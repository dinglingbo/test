<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<%@ include file = "/workflow/wfmanager/common/common.jsp"%>
<html>
	<head>
		<title>Title</title>
		<script type="text/javascript" language="javascript">
<!-- 
     //检查WFAgentName是否存在
     function checkAgentName(){
         var name=document.forms['form1'].WFAgentName.value;
         if(name==""||name==null){
    	     return false;
    	 }else
    	     return true;
     }
     
     /**
     //查询代理人范围
     function doQuery(){
         selectParticipant ('WFAgent','maxNum=1&selectTypes=<b:write  property="leafType"/>',new FormElement('form1','WFAgentName','WFAgentID','ID'),function(){
            $name('form1').action = 'com.primeton.workflow.manager.agent.queryAgentScope.flow';
            if($name('form1').WFAgentID)
		 	    $name('form1')._eosFlowAction.value = "query";
            else
                $name('form1')._eosFlowAction.value = "initial";
            $name('form1').submit();
		 });
	 }
	 **/
	 
	  //检查Index是否存在
	 function checkIndex(){
	    var el = document.getElementsByName('Index');
	    //alert(el.length);
	    //alert(el.value);
	    if(el.length==0)
			 return false;
	    else
	         return true;
	 }
	 
	 //删除指定的代理人
	 function  doDelete(){
	    if(checkIndex()){
	         var el = document.getElementsByName('Index');
	      	 var len = el.length;
	       	 var temp=0;
	         for(var i=0; i<len; i++){  
	           if(el[i].checked == true){
	              temp=temp+1;
	           }
	         }
	         if(temp==0){
			    alert("<b:message key="mgr_agentscope_jsp.select_del_agent"/>");//请至少选择一个要删除的代理人.
			    return false;
		     }
		     if(confirm('<b:message key="mgr_agentscope_jsp.sure_del"/>')){//您确定要删除所选项吗？
			       document.forms['form1'].action ='com.primeton.workflow.manager.agent.deleteAgentScope.flow';
			       document.forms['form1'].elements['_eosFlowAction'].value = "action0";
			       document.forms['form1'].submit();
			 }else
				return false;
	    }else
	       return false;
	 }
	 
	 //复选框全选操作
	 function SelectAllCheck(obj){
	    if(checkIndex()){
	        var el = document.getElementsByName('Index');
	        //alert(el[0].value);
	        var len = el.length;
	        if(obj.checked==true){ 
	            for(var i=0; i<len; i++){  
	              el[i].checked = true; 
	            } 
	        } else { 
	            for(var i=0; i<len; i++){ 
	              el[i].checked = false; 
	            } 
	        }
	    }else
	       return false;  
	 }
	 
	 function doSelect(chkObj){
	 	var chkAll = $name("Checkbox");
	 	if(chkAll.checked){
	        chkAll.checked=false;
	        chkObj.checked=false;
		}else{
			if(chkObj.checked){
				  chkObj.checked=true;
			}else{
				  chkObj.checked=false;
			}
			var el = document.getElementsByName('Index');
	      	var len = el.length;
	       	var temp=0;
	        for(var i=0; i<len; i++){  
	          if(el[i].checked == true){
	             temp=temp+1;
	          }
	        }
	        if(temp==len)
	        	chkAll.checked=true;
		}
	}
	 
	 //设置按钮是否可用
	 function showButton(){  
	     if(checkAgentName()){  
	     //FIXME:document.getElementById --> $id  
	           if($name("Button2").checked == true){
	             $name("Surrogate").disabled = false;
	             $name("Button3").disabled = false;
	             $name("Button4").disabled = false;            
	           }else{
	             $name("Surrogate").disabled = true;
	             $name("Button3").disabled = true;
	             $name("Button4").disabled = true;
	           }
	     }else 
	       return false;  	          
	 } 
	 
	 //添加代理人
	 function doAdd(){
	    var surgname=document.forms['form1'].Surrogate.value;
	    if(surgname==""){
			alert("<b:message key="mgr_agentscope_jsp.select_add_agent"/>");//请选择要添加的代理人.
			return false;
		}
	    
	    var wfagid=document.forms['form1'].WFAgentID.value;
		var n = surgname.split(",").length;
	    for(var i=1;i<=n;i++){
	        var t=document.forms['form1'].elements['SurrogateID['+i+']/id'].value;
	        if(t==wfagid){
	           alert("<b:message key="mgr_agentscope_jsp.agent_scope_condition"/>");//代理人范围中不能包含委托人自己.
			   return false;
	        }
	    }
	    document.forms['form1'].action ='com.primeton.workflow.manager.agent.addAgentScope.flow';
	    document.forms['form1']._eosFlowAction.value = "action0";
	    document.forms['form1'].submit();
	 }
	   
	 //恢复默认代理人范围
	 function doReset(){
	   if(checkAgentName()){ 
	      if(confirm('<b:message key="mgr_agentscope_jsp.sure_resume"/>')){//您确定要恢复默认代理人范围吗？
		       document.forms['form1'].action ='com.primeton.workflow.manager.agent.resetAgentScope.flow';
		       document.forms['form1']._eosFlowAction.value = "reset";
		       document.forms['form1'].submit();
		  }else
				return false;
	   }else 
	     return false; 
	 }
     
window.onload =  function (){
	var cnt = 0;
	<l:present property="agentScopeList">
	 cnt = <b:size property="agentScopeList"/>
	</l:present>
	if (cnt==0)
		$name("Button1").disabled=true;
}     
     
//-->
</script>

</head>
	
<body style="background:#EAF0F1;margin-top:0px;margin-left:0px;margin-right: 0px;margin-buttom:0px;width: 100%;height: 100%;">
<table border="0" cellpadding="0" cellspacing="0" class="workarea" width="100%" height="100%">
	<tr>
		<td width="100%" valign="top">
   		
    

<form action="" method="post" name="form1">
<h:hidden property="_eosFlowAction"/>
<table border="0" cellpadding="1" cellspacing="0" width="100%">
  <tr>
    <td width="100%" valign="top">
      <table border="0" cellpadding="0" cellspacing="0" class="workarea" width="100%">
        <tr>
          <td>
            <table border="0" cellpadding="1" cellspacing="0" class="EOS_panel_body" width="100%">
              <tr>
                <td class="EOS_panel_head" valign="middle"><l:present property="WFAgentName"><b:write  property="WFAgentName"/>&nbsp;<b:message key="mgr_agentscope_jsp.s"/></l:present><b:message key="mgr_agentscope_jsp.agent_scope"/></td><%-- 的/代理人范围 --%>
                <h:hidden property="WFAgentName"/><h:hidden property="WFAgentID"/>
              </tr>
              <tr>
                <td width="100%" valign="top">
                  <table border="0" class="EOS_table" width="100%">
	                    <tr class="EOS_table_head">
						  <th nowrap width="10%"><input type="checkbox" name="Checkbox" value="checkbox" onclick="SelectAllCheck(this);">&nbsp;<b:message key="mgr_agentscope_jsp.select"/></th><%-- 选择 --%>
	                      <th nowrap width="30%"><b:message key="mgr_agentscope_jsp.name"/></th><%-- 名称 --%>
	                      <th nowrap width="30%">ID</th>
	                      <th nowrap width="30%"><b:message key="mgr_agentscope_jsp.type"/></th><%-- 类型 --%>
	                    </tr>
                    <l:present property="agentScopeList">
                    <% int flag =0;%>
                    <l:iterate id="list" property="agentScopeList" indexId="indexid">
						<tr class="EOS_table_row" onmouseover="this.className='EOS_table_selectRow'" onmouseout="this.className='EOS_table_row'">
						  <td><h:checkbox iterateId="list" name="Index" onclick="doSelect(this);" property="/"/>${pageScope.indexid}</td>
						  <td>
	                          <b:write iterateId="list" property="name"/>
	                          <input type="hidden"   name="name"  value='<b:write iterateId="list" property="name"/>'>
	                      </td>	
						  <td>
						      <b:write iterateId="list" property="id"/>
						      <input type="hidden"   name="id"  value='<b:write iterateId="list" property="id"/>'>
						  </td>
	                      <td>
	                          <b:set iterateId="list" name="typecd" property="typeCode"/>
		                      <wf:convertPartiTypeCode typeCode='<%=(String)request.getAttribute("typecd")%>'/>
	                          <input type="hidden"   name="typeCode"  value='<b:write iterateId="list" property="typeCode"/>'>
	                      </td>
						</tr>
					<%flag++; %>	
				    </l:iterate>
				    <%
				            if(flag<10){
				              for(int i = flag; i < 10;i++){ %> 
				        <tr class="EOS_table_row">
	                      <td></td>
	                      <td></td>
	                      <td></td>
	                      <td></td>
	                    </tr>
				      <%      }
					        } %>
				    </l:present>
				    <l:notPresent  property="agentScopeList">
					    <tr class="EOS_table_row">
	                      <td></td>
	                      <td></td>
	                      <td></td>
	                      <td></td>
	                    </tr>
	                    <tr class="EOS_table_row">
	                      <td></td>
	                      <td></td>
	                      <td></td>
	                      <td></td>
	                    </tr>
	                    <tr class="EOS_table_row">
	                      <td></td>
	                      <td></td>
	                      <td></td>
	                      <td></td>
	                    </tr>
	                    <tr class="EOS_table_row">
	                      <td></td>
	                      <td></td>
	                      <td></td>
	                      <td></td>
	                    </tr>
	                    <tr class="EOS_table_row">
	                      <td></td>
	                      <td></td>
	                      <td></td>
	                      <td></td>
	                    </tr>
	                    <tr class="EOS_table_row">
	                      <td></td>
	                      <td></td>
	                      <td></td>
	                      <td></td>
	                    </tr>
	                    <tr class="EOS_table_row">
	                      <td></td>
	                      <td></td>
	                      <td></td>
	                      <td></td>
	                    </tr>
	                    <tr class="EOS_table_row">
	                      <td></td>
	                      <td></td>
	                      <td></td>
	                      <td></td>
	                    </tr>
	                    <tr class="EOS_table_row">
	                      <td></td>
	                      <td></td>
	                      <td></td>
	                      <td></td>
	                    </tr>
	                    <tr class="EOS_table_row">
	                      <td></td>
	                      <td></td>
	                      <td></td>
	                      <td></td>
	                    </tr>
				    </l:notPresent>
                  </table>
                  <table width="100%" border="0" cellspacing="0" cellpadding="0">
                    <tr>
                      <td align="left" >
					      <input type="button"  id="Button1" name="Button1" value="<b:message key="mgr_agentscope_jsp.delete"/>" class="button" onclick="doDelete();"><%-- 删除 --%>
						  <input type="checkbox" id="Button2" name="Button2" onClick="showButton();"><b:message key="mgr_agentscope_jsp.add"/>
						  <h:text  property="Surrogate" size="32" disabled="true" readonly="true"/><%-- 添加 --%>
						  <input type="button" class="button" id="Button3" name="Button3" value="<b:message key="mgr_agentscope_jsp.select_agent"/>" onclick="selectParticipant ('Surrogate','maxNum=',new FormElement('form1','Surrogate','SurrogateID','PARTICIPANT'))" disabled="true"><%-- 选择代理人... --%>
						  <!--
						  <wf:selectParticipant  value="选择代理人..." form="form1" output="Surrogate" hidden="SurrogateID" hiddenType="PARTICIPANT" root=""/>
						   -->
						  <input type="button" id="Button4" name="Button4" value="<b:message key="mgr_agentscope_jsp.submit"/>" class="button" onclick="doAdd();" disabled="true"><%-- 提交 --%>								
	   					  <input type="button"  id="Button5" name="Button5" value="<b:message key="mgr_agentscope_jsp.resume_default_scope"/>" class="button" onclick="doReset();"> <%-- 恢复默认范围 --%>
                      </td>
                      <!--<td align="right" >3条记录 页次1/1 <a href="#">首页</a> | <a href="#">上一页</a> | <a href="#">下一页</a> | <a href="#">末页</a></td>-->
                    </tr>										
                  </table>
                </td>
              </tr>
            </table>
          </td>
        </tr>
      </table>
    </td>
  </tr>
</table>
</form>
	
	
	
	</td>
  </tr>
</table>
</BODY>
</html>


