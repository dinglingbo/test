var form1;

$(document).ready(function(v){

	form1 = new nui.Form("#form1");
	var dictDefs = {"guarantee":"010811"};
	initRoleMembers(dictDefs,null);
    
 });

var mentt = [{ id: 1, text: '保险挂账' }, { id: 2, text: '担保挂账'}];
  function SetData(param) {
      form1.setData(param.data);     
	
        }
  		function onOk(){
  			
  		var s=GetData();
  		if(s!=undefined){
  		   nui.ajax({
               url: apiPath + frmApi + "/com.hsapi.frm.setting.updateguarante.biz.ext",
       		 type: 'post',
             data: nui.encode({
            	 params: s
             }),
               success: function (data) {
                   if (data.errCode == "S"){
                   	nui.alert("挂账成功！");
                   	closeWindow("ok");
                       }else {
                       nui.alert("挂账失败！");
                   }
               },
               error: function (jqXHR, textStatus, errorThrown) {
                   nui.alert(jqXHR.responseText);
               }
           });}
  		
  		}
        function GetData() {
            var o = form1.getData();
            return o;
        }
 