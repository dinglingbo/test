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
var upGridUrl= baseUrl + "com.hsapi.repair.repairService.booking.queryBookingList.biz.ext";
var downGridUrl= baseUrl + "com.hsapi.repair.repairService.booking.queryBookingTrace.biz.ext";

$(document).ready(function(v){
	
	statusStatus=nui.get("status");
	timeStatus=nui.get("timeStatus");
	upGrid=nui.get("upGrid");
	upGrid.setUrl("upGridUrl");
	downGrid=nui.get("downGrid");
	downGrid.setUrl("downGridUrl");
	search();
});




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