baseUrl = apiPath + sysApi + "/";;
var queryForm;
var upGrid;
var downGrid;
var currGuest;
var assignStatus;
var timeStatus;
var rOrp;
var statusStatus;
var advancedSearchWin = null;
var bisinessList=[];
var carBrandList=[];//车系
var carModeList=[];//车型
var upGridUrl= baseUrl + "com.hsapi.repair.repairService.booking.queryBookingList.biz.ext";
var downGridUrl= baseUrl + "com.hsapi.repair.repairService.booking.queryBookingTrace.biz.ext";
var prebookCategoryHash=[{text:'用户主动预约',value:'0'},{text:'用户被动预约',value:'1'}];
$(document).ready(function(v){

	statusStatus=nui.get("status");
	timeStatus=nui.get("timeStatus");
	upGrid=nui.get("upGrid");
	upGrid.setUrl("upGridUrl");
	downGrid=nui.get("downGrid");
	downGrid.setUrl("downGridUrl");
	search();
	getBisinessList(function(data) {
		bisinessList = data.data;
		});
	
	init(function(data) {
		
	});
	init2(function(data) {
		
	});
});

var carBrandUrl=baseUrl+"com.hsapi.repair.repairService.booking.queryCarBrand.biz.ext";
var carModelUrl=baseUrl+"com.hsapi.repair.repairService.booking.queryCarModel.biz.ext";
function init(callback){
	
	nui.ajax({
		url : carBrandUrl,
		type : 'post',
		data : nui.encode({
			
		}),
		success : function(data) {
			carBrandList=data;
			
		},
		error : function(jqXHR, textStatus, errorThrown) {
			nui.alert(jqXHR.responseText);
		}
	});

	 callback();
}
function init2(callback){
	nui.ajax({
		url : carModelUrl,
		type : 'post',
		data : nui.encode({
			
		}),
		success : function(data) {
			carModeList=data;
		},
		error : function(jqXHR, textStatus, errorThrown) {
			nui.alert(jqXHR.responseText);
		}
	});
	 callback();
}
/*
 * 
 * 获取业务分类列表*/
var bisinessUrl = baseUrl + "com.hsapi.system.confi.paramSet.getbusinessSort.biz.ext";
function getBisinessList(callback){
    nui.ajax({
        url: bisinessUrl,
        type: 'post',
        data: nui.encode({
        }),
        cache: false,
        success: function (data) {
            if (data) {
             callback(data);
            }
        },
        error: function (jqXHR, textStatus, errorThrown) {
            nui.alert(jqXHR.responseText);
        }
	});
	
}


function clearQueryForm(){
    queryForm.setData({});
}

/*
 *设置时间菜单
 **/
function setMenu(obj, target, value){
    target.setValue(value);
    target.setText(obj.getText());   
   
}

function setMenu1(obj, target, value){
    target.setValue(value);
    target.setText(obj.getText());   
   
}



function search() {
    var param = getSearchParam();
    doSearch(param);
}

function getSearchParam() {
	queryForm = new nui.Form("#queryForm");
    var params = queryForm.getData();
    return params;
}

function doSearch(params) {

	params.status=statusStatus.getValue();
	params.timeStatus=timeStatus.getValue();
	upGrid.load({
        params:params,
        token:token
    });
}

function selectedchange(){
	var s=upGrid.getSelected();
	 var params ={
			 serviceId:s.id
	 };
	 downGrid.load({
	        params:params,
	        token:token
	    });
}

function addRow(){
	
	

		
		 nui.open({
             url: "BookingManagementEdit.jsp",
             title: "新增", width: 800, height: 500,
             onload: function () {
              
             },
             ondestroy: function (action) {
              	 upGrid.reload();

             }
         });
	
	
	
	
}
function editRow(){
	
	var row=upGrid.getSelected();
	if(row==undefined)
		{
		nui.alert("请选中一条数据");
		return;
		}

	
	 nui.open({
        url: "BookingManagementEdit.jsp",
        title: "修改", width: 800, height: 500,
        onload: function () {
            var iframe = this.getIFrameEl();
            var param = { action: "edit", data: row };
            iframe.contentWindow.SetData(param);
        },
        ondestroy: function (action) {
         	 upGrid.reload();

        }
    });




}

function typeChange(type,status){
	
	var row=upGrid.getSelected();
	if(row==undefined){
		nui.alert("请选中一行");
	}
	if(type=="确认"&&row.status=='1'){
		nui.alert("此行已确认");
		return;
	}
	if(type=="开单"&&row.status=='2'){
		nui.alert("此行已开单");
		return;	
	}
	if(type=="取消"&&row.status=='3'){
		nui.alert("此行已取消");
		return;
	}
	var s={
			id:row.id,
			status:status
	};
		nui.ajax({
			url : baseUrl
					+ "com.hsapi.repair.repairService.booking.updateBooking.biz.ext",
			type : 'post',
			data : nui.encode({
				param : s
			}),
			success : function(data) {
				if (data.errCode == "S") {
					nui.alert(type+"成功!");
				}else{
					nui.alert(type+"失败!");
				}
			},
			error : function(jqXHR, textStatus, errorThrown) {
				nui.alert(jqXHR.responseText);
			}
		});
	
	
}


function gridOnDraw(e)
{	

    switch (e.field)
    {
        case "serviceTypeId":
        	var is=false;
            for(var i=0;i<bisinessList.length;i++){
            	 if(bisinessList[i].code==e.cellHtml)
                 {
                     e.cellHtml = bisinessList[i].name;
                     is=true;
                     break;
                 }
            	 }
            if(is==false)e.cellHtml="";
            break;
        case "prebookCategory":
        	 if(prebookCategoryHash[e.value])
             {
                 e.cellHtml = prebookCategoryHash[e.value].text||"";
             }
             else{
                 e.cellHtml = "";
             }
        	break;
        case "carBrandId":
        	var is=false;
            for(var i=0;i<carBrandList.data.length;i++){
            	 if(carBrandList.data[i].id==e.cellHtml)
                 {
                     e.cellHtml = carBrandList.data[i].carBrandZh;
                     is=true;
                     break;
                 }
            	 }
            if(is==false)e.cellHtml="";
            break;
        case "carSeriesId":
        	/*var is=false;
            for(var i=0;i<carModeList.data.length;i++){
            	 if(carModeList.data[i].id==e.cellHtml)
                 {
                     e.cellHtml = carModeList.data[i].name;
                     is=true;
                     break;
                 }
            	 }
            if(is==false)e.cellHtml="";*/
            break;
       	 	default:
            break;
    }
}