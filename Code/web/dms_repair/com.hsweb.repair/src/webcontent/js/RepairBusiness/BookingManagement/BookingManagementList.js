var baseUrl = apiPath + repairApi + "/";
var queryForm;
var upGrid;
var downGrid;
var currGuest;
var assignStatus;
var timeStatus;
var rOrp;
var statusStatus;
var advancedSearchWin = null;
var serviceTypeHash = [];
var carBrandHash = []; 
var carSeriesHash = []; 
var mtAdvisorHash = []; 
var prebookCategoryHash = [{name:'客户主动预约',id:'0'},{name:'客户被动预约',id:'1'}];
var prebookStatusHash = [{name:'待确认',id:'0'},{name:'已确认',id:'1'},{name:'已开单',id:'2'},{name:'已取消',id:'3'}];

var upGridUrl = baseUrl + "com.hsapi.repair.repairService.booking.queryPrebookList.biz.ext";
var downGridUrl = baseUrl + "com.hsapi.repair.repairService.booking.queryBookingTrace.biz.ext";

$(document).ready(function(v){
	statusStatus = nui.get("status");
	timeStatus = nui.get("timeStatus");

	upGrid = nui.get("upGrid");
	upGrid.setUrl("upGridUrl");
	upGrid.on("drawcell",onDrawCell);

	downGrid = nui.get("downGrid");
	downGrid.setUrl("downGridUrl");

	upGrid.on("selectionchanged",function(e) {
        onupGridSelectionchanged(e);
    });

	init();

	search();
});

function init(){	
	initCarBrand("carBrandList", function(){
        var data = nui.get("carBrandList").getData();
        data.forEach(function(v) {
            carBrandHash[v.id] = v;
        });
    });	

 	initCarSeries("carSeriesList", "", function(){
        var data = nui.get("carSeriesList").getData();
        data.forEach(function(v) {
            carSeriesHash[v.id] = v;
        });
    });	

 	initMember("mtAdvisorList", function(){
        var data = nui.get("mtAdvisorList").getData();
        data.forEach(function(v) {
            mtAdvisorHash[v.id] = v;
        });
    });	   

 	initServiceType("bisinessList", function(){
        var data = nui.get("bisinessList").getData();
        data.forEach(function(v) {
            serviceTypeHash[v.id] = v;
        });
    });
}

var currType = 0;

function quickSearch(ctlid, value, text){
    ctlid.setValue(value);
    ctlid.setText(text);
    currType = value;
    onSearch();
}

function search() {
    
    doSearch(param);
}

function getSearchParam() {
	var params = {};
    params.mtAdvisorId = nui.get("mtAdvisorList").getValue();
    params.carNo = nui.get("carNo").getValue();
    params.contactorTel = nui.get("contactorTel").getValue();

    var d = menuBtnDateQuickSearch.getValue();

    if (d == 0) {
        params.today = 1;
        params.startDate = getNowStartDate();
        params.endDate = addDate(getNowEndDate(), 1);
    } else if (d == 1) {
        params.yesterday = 1;
        params.startDate = getPrevStartDate();
        params.endDate = addDate(getPrevEndDate(), 1);        
    }  else if (d == 2) {
        params.thisWeek = 1;
        params.startDate = getWeekStartDate();
        params.endDate = addDate(getWeekEndDate(), 1);        
    } else if (d == 3) {
        params.lastWeek = 1;
        params.startDate = getLastWeekStartDate();
        params.endDate = addDate(getLastWeekEndDate(), 1);        
    } else if (d == 4) {
        params.thisMonth = 1;
        params.startDate = getMonthStartDate();
        params.endDate = addDate(getMonthEndDate(), 1);        
    } else if (d == 5) {
        params.lastMonth = 1;
        params.startDate = getLastMonthStartDate();
        params.endDate = addDate(getLastMonthEndDate(), 1);        
    }

    var status = menuBtnStatusQuickSearch.getValue();

    if (status != -1) {
        params.status = status;
    } 

    return params;
}

function doSearch(params) {
	var param = getSearchParam();

	upGrid.load({
        params: params,
        token: token
    });
}

function onupGridSelectionchanged(e) {
    var row = e.record;
    if (!row) return;

    var status = row.status;

    if (status != 0) nui.get("btnEdit").disable();
    if (status != 0) nui.get("btnconfirm").disable();
    if (status != 1) nui.get("btnNewBill").disable();
    if (status > 1) nui.get("btnCancel").disable();
    if (status > 1) nui.get("btnCall").disable();
    

    getPrebookById(row.id,function(data)
    {
        nui.unmask();
        data = data||{};
        if(data.prebook)
        {
            var prebook = data.prebook;
            basicInfoForm.setData(prebook);
            carBrandIdEl.doValueChanged();
            nui.get("carId").setText(prebook.carNo);
            resetBtn();
            if(prebook.bookStatus == "040901")
            {
                nui.get("cancelBtn").disable();
            }
            else{
                nui.get("fllowUpBtn").disable();
            }
        }
        else
        {
            nui.alert("数据加载失败");
        }
    });

    rightGrid.load({
    	token:token,
        bookId:row.id
    });
}

function onDrawCell(e) {
    var field = e.field;

    if(field == "serviceTypeId" && serviceTypeHash[e.value]) {
        e.cellHtml = serviceTypeHash[e.value].name;
    } else if (field == "carBrandId" && carBrandHash[e.value]) {
        e.cellHtml = carBrandHash[e.value].name;
    } else if (field == "carSeriesId" && carSeriesHash[e.value]) {
        e.cellHtml = carSeriesHash[e.value].name;
    } else if (field == "prebookCategory" && prebookCategoryHash[e.value]) {
        e.cellHtml = prebookCategoryHash[e.value].name;
    }
}

/*设置时间菜单*/
function setMenu(obj, target, value){
    target.setValue(value);
    target.setText(obj.getText());   
   
}

function setMenu1(obj, target, value){
    target.setValue(value);
    target.setText(obj.getText());   
   
}


function selectedchange(){
	var s = upGrid.getSelected();
	 var params = {
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


