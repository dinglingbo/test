var baseUrl = window._rootSysUrl || "http://127.0.0.1:8080/default/";
$(document).ready(function ()
{
	
});

function addCus(){
	nui.open({
		url : webPath + contextPath + "/com.hsweb.repair.potentialCustomer.addVisitRecords.flow?token=" + token,
		title : "新增来访记录",
		width : 1000,
		height : 560,
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