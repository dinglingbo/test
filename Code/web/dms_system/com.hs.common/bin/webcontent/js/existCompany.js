/**
 * Created by steven on 2018/1/31.
 */

var baseUrl = apiPath + sysApi + "/";
var repairUrl = apiPath + repairApi + "/";
var queryUrl = baseUrl + "com.hsapi.system.basic.organization.getExistCompany.biz.ext";
var moreOrgGrid = null;
var empId = null;
$(document).ready(function(v) {
	moreOrgGrid = nui.get("moreOrgGrid");
	moreOrgGrid.setUrl(queryUrl);
	
    nui.get("name").focus();
    moreOrgGrid.on("beforeselect",function(e){
    	var row = e.record;
    	if(row.ismain && row.ismain=="y"){
    		showMsg("不能取消所属机构","W");
    		e.cancel = true;
    		//moreOrgGrid.deselect(row,false);
    	}
    });
	document.onkeyup=function(event){
        var e=event||window.event;
        var keyCode=e.keyCode||e.which;//38向上 40向下

        if((keyCode==27))  {  //ESC
        	 //closeWindow("cal");
        	Oncancel();
        }
      };
      if(currIsMaster==1){
      	nui.get("cancelOrg").setVisible(true);
      }else{
      	nui.get("cancelOrg").setVisible(false);
      }
});

function onSearch(){
	var params = {};
	params.empId = empId;
	params.name = nui.get("name").getValue().replace(/\s+/g, "");
	params.code = nui.get("code").getValue().replace(/\s+/g, "");
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
	onSearch();
}
function cancelOrg(){
	var rows = moreOrgGrid.getSelecteds();
	
	if(rows.length>0){
		var json = nui.encode({
			companyList:rows,
			token:token});
		 nui.mask({
	            el: document.body,
	            cls: 'mini-mask-loading',
	            html: '保存中...'
	    });
		$.ajax({
            url:apiPath + sysApi + "/com.hsapi.system.basic.organization.deletExistCompany.biz.ext",
            type:'POST',
            data:json,
            cache: false,
            contentType:'text/json',
            success:function(text){
              var returnJson = nui.decode(text);
              if(returnJson.errCode == 'S'){
            	  nui.unmask(document.body);
                  showMsg(returnJson.errMsg || "取消兼职成功!", "S");
                  var params = {};
              	  params.empId = empId;
                  moreOrgGrid.load({
              		params:params,
              		token : token
              	});
              }else{
            	  nui.unmask(document.body);
                  showMsg(returnJson.errMsg || "取消兼职失败!", "E");
              }
            }
          });
	}else{
		 showMsg("请选择门店!","W");
	}
}

