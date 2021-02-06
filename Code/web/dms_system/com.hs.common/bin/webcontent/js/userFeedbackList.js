/**
 * Created by steven on 2018/1/31.
 */

var baseUrl = apiPath + sysApi + "/";
var repairUrl = apiPath + repairApi + "/";
var queryUrl = baseUrl + "com.hsapi.system.employee.feedback.queryFeedBackInfo.biz.ext";
var moreOrgGrid = null;
var empId = null;
$(document).ready(function(v) {
	moreOrgGrid = nui.get("moreOrgGrid");
	moreOrgGrid.setUrl(queryUrl);
	
    nui.get("orgname").focus();
	document.onkeyup=function(event){
        var e=event||window.event;
        var keyCode=e.keyCode||e.which;//38向上 40向下

        if((keyCode==27))  {  //ESC
        	 //closeWindow("cal");
        	Oncancel();
        }
      };
      moreOrgGrid.on("drawcell", function (e) {
    	  var grid = e.sender;
          var record = e.record;
          var uid = record._uid;
          var rowIndex = e.rowIndex;
          var s = "";
    	  if(e.field == "status"){
    		  if(e.value == 0){
	      		  s = "待处理";
	           }else if(e.value == 1){
	          	 //删除配件信息
	        	   s = "处理中";
	           }else if(e.value == 2){
	        	  s = "已解决"; 
	           }
    		   //s =  s + "&nbsp&nbsp&nbsp" +' <a class="optbtn" href="javascript:solveFeedBack(\'' + uid + '\')">查看</a>';
    		  e.cellHtml = s;
    	  };
    	  if(e.field == "feedOptBtn"){
    		  e.cellHtml = ' <a class="optbtn" href="javascript:solveFeedBack(\'' + uid + '\')">查看</a>';
    	  }
    	  
      });
      onSearch();
});

function onSearch(){
	var params = {};
	params.orgname = nui.get("orgname").getValue().replace(/\s+/g, "");
	params.recordMobile = nui.get("recordMobile").getValue().replace(/\s+/g, "");
	var sta = nui.get("statusId").getValue();
	if(sta==3){
		params.statusList = 1;
	}else{
		params.status = sta;
	}
	params.orgid = currOrgId;
	params.recordId = currEmpId;
	moreOrgGrid.load({
		params:params,
		token : token
	});
}

function close() {
	if (window.CloseOwnerWindow){
		return window.CloseOwnerWindow('OK');
    } else {
        window.close();
        return ;
    }
}

function Oncancel(){
    //closeWindow("cancel");
	close();
}

function solveFeedBack(row_uid){
	var row = moreOrgGrid.getRowByUID(row_uid);
	if(row){
		 nui.open({
	         url: webPath + contextPath + "/common/feedbackDetail.jsp?token="+token,
	         title: '查看反馈',
	         width: "100%", height: "100%",
	         onload: function () {
	             var iframe = this.getIFrameEl();
	             row.user = 1;
	             iframe.contentWindow.setFeedbackData(row);
	         },
	         ondestroy: function (action)
	         {
	        	 //onSearch();
	         }
	     });
	}
}

