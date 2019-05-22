var baseUrl = window._rootSysUrl || "http://127.0.0.1:8080/default/";
var levelOfIntent = null;
var important = null;
var frameColorIdHash = {};
var saleAdvisorIdEl = null;
var memList = [];
var saleAdvisorList = [];
var intentLevelList = []; 
$(document).ready(function ()
{
	levelOfIntent = nui.get("levelOfIntent");
	specialCareId = nui.get("specialCareId");
	intentLevelId = nui.get("intentLevelId");
	saleAdvisorIdEl = nui.get("saleAdvisorId");
	
	//车身颜色
	 initDicts({
		 frameColorId:"DDT20130726000003",
		 interialColorId:"10391",
		 comeTypeId:'DDT20130731000003',
		 specialCare:"DDT20130703000049",
		 intentLevel:"DDT20130703000050"
     },function(data){
    	 asaleAdvisorList = nui.get('specialCare').getData();
    	 intentLevelList = nui.get('intentLevel').getData();
    	 //specialCareId.setData(asaleAdvisorList);
    	 getServiceTypeList(asaleAdvisorList,function(data){
    			specialCareId.setData(data);
    			//levelOfIntent.setData(data);
    	 });
    	 getServiceTypeList(intentLevelList,function(data){
    		 intentLevelId.setData(data);
 			//levelOfIntent.setData(data);
 	 });
     });
	
	initMember("saleAdvisorId",function(){
        memList = saleAdvisorIdEl.getData();
    });
	
	
});


var serviceTypeUrl = baseUrl + "com.hsapi.repair.common.common.getBusinessType.biz.ext";
function getServiceTypeList(data,callback){
	var serviceTypeList = [];
	var list = data;
    /*var params = {sortField:'id',sortOrder:'asc',isDisabled:0};
    nui.ajax({
		url : serviceTypeUrl,
        type : "post",
        async:false,
		data : JSON.stringify({
			params : params,
			token: token
		}),
		success : function(data) {
			nui.unmask(document.body);
            data = data || {};
            var list = data.list;
			if (list && list.length>0) {
				for(var i=0; i<list.length; i++){
                    var type = list[i];
                    var serviceTypeObj = {id:(i+1), text:type.name};
                    serviceTypeList.push(serviceTypeObj);
                    callback && callback(serviceTypeList);
                }
			} else {
				parent.showMsg("工单设置信息读取失败,请联系管理员!","W");
			}
		},
		error : function(jqXHR, textStatus, errorThrown) {
			// nui.alert(jqXHR.responseText);
			console.log(jqXHR.responseText);
		}
	});*/
	if (list && list.length>0) {
		for(var i=0; i<list.length; i++){
            var type = list[i];
            var serviceTypeObj = {id:(i+1), text:type.name};
            serviceTypeList.push(serviceTypeObj);
            callback && callback(serviceTypeList);
        }
	}
}


function add(){
	/*nui.open({
		url : webPath + contextPath + "/com.hsweb.repair.potentialCustomer.addVisitRecords.flow?token=" + token,
		title : "新增来访记录",
		width : 1000,
		height : 560,
		allowDrag : true,
		allowResize : true,
		onload : function() {
			var iframe = this.getIFrameEl();
            iframe.contentWindow.updatRowSetData(params);//显示该显示的功能
           // iframe.contentWindow.setViewData(dock, dodelck, docck);
		},
		ondestroy : function(action) {
			
			
		}
	});*/
	var part={};
    part.id = "addVisitors";
    part.text = "新增来访记录";
    part.url = webPath + contextPath + "/com.hsweb.repair.potentialCustomer.addVisitRecords.flow?token="+token;
    part.iconCls = "fa fa-file-text";
    var params = {};
    window.parent.activeTabAndInit(part,params);
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

function chooseCarModelType(){
	nui.open({
        url: webPath + contextPath + "/sales/base/sCarModelType.jsp?token="+token,
        title: '选择意向车型',
        width: 1200, height: 700,
        onload: function () {
            var iframe = this.getIFrameEl();
            var params = {};	
            params.guestId=guestId;
            iframe.contentWindow.setData(params);
        },
        ondestroy: function (action)
        {
       	 var iframe = this.getIFrameEl();
       	 var row = iframe.contentWindow.getData();
       	 
        }
    });
}
