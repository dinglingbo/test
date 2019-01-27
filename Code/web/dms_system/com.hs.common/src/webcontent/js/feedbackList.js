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
	
    nui.get("recordMobile").focus();
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
    	  if(e.field == "status"){
    		  if(e.value == 0){
	      		s =  ' <a class="optbtn" href="javascript:deleteItemRow(\'' + uid + '\')">待处理</a>';
	           }else if(e.value == 1){
	          	 //删除配件信息
	          	 s =  ' <a class="optbtn" href="javascript:deletePartRow(\'' + uid + '\')">处理中</a>';
	           }else{
	        	   s =  ' <a class="optbtn" href="javascript:deletePartRow(\'' + uid + '\')">已解决</a>'; 
	           }
    	      e.cellHtml = s; 
    	  }
    	  
      });
      onSearch();
});

function onSearch(){
	var params = {};
	params.orgname = nui.get("orgname").getValue();
	var sta = nui.get("statusId").getValue();
	if(sta==3){
		params.statusList = 1;
	}else{
		params.status = sta;
	}
	params.recordMobile = nui.get("recordMobile").getValue();
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

function setData(row){
	empId = row.empid;
}
function addOrg(){
	var rows = moreOrgGrid.getSelecteds();
	if(rows.length>0){
		var json = nui.encode({
			intCompanyList:rows,
			empId:empId,
			token:token});
		 nui.mask({
	            el: document.body,
	            cls: 'mini-mask-loading',
	            html: '保存中...'
	    });
		$.ajax({
            url:apiPath + sysApi + "/com.hsapi.system.basic.organization.saveMyCompany.biz.ext",
            type:'POST',
            data:json,
            cache: false,
            contentType:'text/json',
            success:function(text){
              var returnJson = nui.decode(text);
              if(returnJson.errCode == 'S'){
            	  nui.unmask(document.body);
                  showMsg(returnJson.errMsg || "保存成功!", "S");
              }else{
            	  nui.unmask(document.body);
                  showMsg(returnJson.errMsg || "保存失败!", "E");
              }
            }
          });
	}else{
		nui.alert("请选择兼职门店!");
	}
}


