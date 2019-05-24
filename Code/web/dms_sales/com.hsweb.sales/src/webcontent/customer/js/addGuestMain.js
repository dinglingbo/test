var baseUrl = window._rootSysUrl || "http://127.0.0.1:8080/default/";
var queryUrl = apiPath + saleApi + "/sales.custormer.queryGuestList.biz.ext";
var mainGrid = null;
var statusHash = {
	"0":"草稿",
    "1":"归档",
    "2":"转销售",
    "3":"作废"
}
$(document).ready(function ()
{
	mainGrid = nui.get("mainGrid");
	mainGrid.setUrl(queryUrl);
    initDicts({
	  identity:"DDT20171016000001",
	  trade:"10363",
	  source:GUEST_SOURCE,
	  nature:10181
	  },function(data){
   });

	mainGrid.on('drawcell', function (e) {
       var value = e.value;
       var field = e.field;
      if (field == 'sex') {
           e.cellHtml = (value == 0 ? '女' : '男');
       } else if (field == 'identity') {
           e.cellHtml = setColVal('identity', 'id', 'name', e.value);
       } else if (field == 'trade') {
           e.cellHtml = setColVal('trade', 'id', 'name', e.value);
       } else if (field == 'source') {
       	e.cellHtml = setColVal('source', 'id', 'name', e.value);
       } else if (field == 'nature') {
    	   e.cellHtml = setColVal('nature', 'id', 'name', e.value);
       } else if(e.field == "birthdayType"){
    	   e.cellHtml = (value == 0 ? '农历' : '阳历');
       }else if(e.field == "maritalStatus"){
    	   e.cellHtml = (value == 1 ? '已婚' : '未婚');
       }/*else if(e.field == "guestOptBtn"){
  		   s =  ' <a class="optbtn" href="javascript:deletItem(\'' + uid + '\')">删除</a>';
    	   s = '<input name="isDisabled" class="nui-checkbox" trueValue="1" falseValue="0" width="30%"/>';
           e.cellHtml = s;
       }*/
	});
	mainGrid.on("rowdblclick",function(e){
		edit();
	});
	doSearch();
});

function getSearchParam() {
    var params = {};
    var saleAdvisorId = nui.get("saleAdvisorId").getValue();
    params.saleAdvisorId = saleAdvisorId;
    var fullName = nui.get("name-search").getValue();
    params.fullName = fullName;
    var mobile = nui.get("mobile-search").getValue();
    params.mobile = mobile;
    //scoutStatus,跟踪状态
    return params;
}
function doSearch() {
    var gsparams = getSearchParam();
    mainGrid.load({
        token:token,
        params: gsparams
    });
}
function add(){
	nui.open({
		url : webPath + contextPath + "/sales/customer/addGuest.jsp?token=" + token,
		title : "新增客户资料",
		width : 900,
		height : 460,
		allowDrag : true,
		allowResize : true,
		onload : function() {
			var iframe = this.getIFrameEl();
            iframe.contentWindow.updatRowSetData(params);//显示该显示的功能
           // iframe.contentWindow.setViewData(dock, dodelck, docck);
		},
		ondestroy : function(action) {
			doSearch();
		}
	});
}
function edit(){
	var row = mainGrid.getSelected();
   if(row){
	   nui.open({
			url : webPath + contextPath + "/sales/customer/addGuest.jsp?token=" + token,
			title : "编辑客户资料",
			width : 900,
			height : 460,
			allowDrag : true,
			allowResize : true,
			onload : function() {
				var iframe = this.getIFrameEl();
	            iframe.contentWindow.setData(row);//显示该显示的功能
			},
			ondestroy : function(action) {
				doSearch();
			}
		});
   }else{
	   showMsg("请选择一条记录","W");
   }
}
function addFollowUpRecord(){
	nui.open({
		url : webPath + contextPath + "/com.hsweb.repair.potentialCustomer.FollowUpRecord.flow?token=" + token,
		title : "新增跟进记录",
		width : 600,
		height : 360,
		allowDrag : true,
		allowResize : true,
		onload : function() {
			/*var iframe = this.getIFrameEl();
            iframe.contentWindow.updatRowSetData(params);//显示该显示的功能
           // iframe.contentWindow.setViewData(dock, dodelck, docck);
*/		},
		ondestroy : function(action) {
			
			
		}
	});
}

function potentialCustomer(){
	nui.open({
		url : webPath + contextPath + "/com.hsweb.repair.potentialCustomer.check.flow?token=" + token,
		title : "审核",
		width : 600,
		height : 360,
		allowDrag : true,
		allowResize : true,
		onload : function() {
			/*var iframe = this.getIFrameEl();
            iframe.contentWindow.updatRowSetData(params);//显示该显示的功能
           // iframe.contentWindow.setViewData(dock, dodelck, docck);
*/		},
		ondestroy : function(action) {
			
			
		}
	});
}