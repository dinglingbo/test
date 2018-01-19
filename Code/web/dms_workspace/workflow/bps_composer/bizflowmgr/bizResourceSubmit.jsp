<%@page pageEncoding="UTF-8"%>
<%@include file="/workflow/bps_composer/common/common_composer.jsp" %>
<html>
<!-- 
  - Author(s): bps
  - Date: 2009-08-04 13:41:09
  - Description:
-->
<head>
<title><b:message key="permission_common.biz_resource_submit"/></title>
</head>
<body onload="showReferenceinit()">
<div id="ResponseMessage" class="response_message" style="display:none;" onclick="hiddenResponseMessage(this)"></div>
<table border="0" cellpadding="0" cellspacing="0" class="workarea" width="100%">
  <tr>
    <td class="workarea_title" valign="middle"><h3><b:message key="permission_common.biz_resource_submit"/></h3></td>
    </tr>
    <tr> 
      <td width="100%">
      <table width="100%" height="100%" border="0" cellpadding="0" cellspacing="0">
      <tr height="330px">
        <td style="width:30%;height:330px;overflow:visible" valign="top">
          <div style="border:1px solid #dddddd;width:100%;height:330px;overflow:auto;overflow-x:auto;overflow-y:auto;float: left;" >
          <table>

<form name="viewlist1" id="viewlist1" action="com.primeton.bps.web.composer.bizflowmgr.bizProcessCustomSubmit.flow" method="post">
<h:hidden property="submitType" />
<h:hidden property="version" />
<h:hidden property="deploy" />
<h:hidden property="processDefName" />
<h:hidden property="processDefCHName" />
<h:hidden property="tempProcessDefID" />
<h:hidden property="pathName" />
<h:hidden property="versionDesc" />
<input type="hidden" name="_eosFlowAction" value="saveSubmit"/>
              <l:iterate id="list" property="resource/result" indexId="index">
               <tr><td>
               <input type="checkbox" name="resourceList[<b:write property="index" scope="p" />]/id" value="<b:write iterateId="list" property="id"/>" checked="true"> 
               <a href="javascript:showReference('<b:write iterateId="list" property="name"/>','<b:write iterateId="list" property="type"/>','<b:write iterateId="list" property="desc"/>','<b:write iterateId="list" property="id"/>')"/>
               <b:write iterateId="list" property="name"/>
               </a>
               </td></tr>
               <h:hidden iterateId ="list" name="resourceList/name" property="name" indexed="true"/>
               <h:hidden iterateId ="list" name="resourceList/type" property="type" indexed="true"/>
               <h:hidden iterateId ="list" name="resourceList/pathname" property="pathname" indexed="true"/>
              </l:iterate>
</form>   
</table>
</div>
</td>
<td width="70%"  valign="top">
            <table width="100%">
            <tr height="330px">
              <td>
                <iframe id="tab" name="tab" style="width:100%;height:330px" frameBorder="0" scrolling="no" src="">
                          </iframe>
              </td>
            </tr>
          </table>
</td>
</tr>
</table>               
        </td>
        </tr>
        <tr class="form_bottom">
          <td colspan="2">  
            <input id="btnPrevStep" name="btnPrevStep" type="button" value='<b:message key="permission_common.btn_prev_step"/>' class="button" onclick="backStep()">
            <input id="btnDone" name="btnDone" type="button" value='<b:message key="permission_common.btn_done"/>' class="button" onclick="resSubmit()">
            <input id="btnCancel" name="btnCancel" type="button" value='<b:message key="permission_common.btn_cancel"/>' onclick="cancle()" class="button">
          </td>
        </tr>
    </table>
<form name="refForm" action="com.primeton.bps.web.composer.bizflowmgr.resourceReference.flow" method="post" target="tab">
  <input type="hidden" name="_eosFlowAction" value="init"/> 
  <input type="hidden" name="resouceName" id="ref_resouceName" value="<b:write property='resource/result/name'/>"/>
  <input type="hidden" name="resouceType" id="ref_resouceType" value="<b:write property='resource/result/type'/>"/>
  <input type="hidden" name="resouceDesc" id="ref_resouceDesc" value="<b:write property='resource/result/desc'/>"/>
  <input type="hidden" name="resouceID" id="ref_resouceID" value="<b:write property='resource/result/id'/>"/>
</form>
</body>

</html>
<script>
  var ret = new Array(2);
    function cancle() {
    ret[0]="N";
    // 定义窗口关闭时的返回值
        window['returnValue'] = ret;
        window.close();
    }
    
    function backStep() {
      var frm = $name("viewlist1");
      frm.elements["_eosFlowAction"].value = "backStep";
      frm.submit();
    }
    
    function resSubmit() {
      var myAjax = new Ajax("com.primeton.bps.web.composer.bizflowmgr.bizprocessmgr.submitProcessbiz.biz");
      //alert($id("viewlist1").innerHTML);
        myAjax.submitForm("viewlist1"); 
        var isSuc =myAjax.getValue("root/data/result/code");
        //alert(isSuc);
        if(isSuc==1){
          ret[0]="Y";
          //ret[1]="业务流程提交";
          ret[1]='<b:message key="permission_common.biz_proc_submit_tip"/>';
          window['returnValue'] = ret;
          window.close();
        }else{
          showMessage($id("ResponseMessage"),myAjax.getValue("root/data/result/name"));
        }
    }
    
    function showReference(resouceName,resouceType,resouceDesc,resID) {
      var frm = $name("refForm");
      $id("ref_resouceName").value=resouceName;
      $id("ref_resouceType").value=resouceType;
      $id("ref_resouceDesc").value=resouceDesc;
      $id("ref_resouceID").value=resID;
      
      frm.submit();
    }
    
    function showReferenceinit(){
      var frm = $name("refForm");
  
      frm.submit();
    }
</script>
