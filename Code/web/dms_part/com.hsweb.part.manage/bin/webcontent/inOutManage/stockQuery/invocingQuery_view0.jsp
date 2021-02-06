<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<%@include file="/common/common.jsp"%>
<html>
<!-- 
  - Author(s): Administrator
  - Date: 2018-03-08 01:16:13
  - Description:
-->
<head>
<title>jsp auto create</title> 
</head>
<body>


<form id="form1" action="com.hsweb.cloud.part.purchase.invocingQuery.flow"  method="post">
	<h:hidden name="_eosFlowKey" property="_eosFlowKey"></h:hidden>
	
		
	<table cellPadding="0" style="width:80%" class="pg_result" align="left" 

cellSpacing="1" border="1">
  		<tr bgcolor="#99FFFF"> 
    		<td colspan="4" align="center">???????????</td>
	    </tr>
	    <tr bgcolor="#CCCCFF"> 
	    	<td style="width:10%">???????</td>
	    	<td style="width:10%">???????</td>
	    	<td style="width:10%">????????</td>
	    	<td style="width:25%">?????</td>
	    </tr>
	    
	    
  </table>
  <input id="action" type="hidden" name="_eosFlowAction" value="action1">
  
  	<script type="text/javascript">
		function selectAction(action){			
			document.getElementById("action").value=action;
			document.getElementById("form1").submit();
		}		
	</script>
	
  <input type="button" align="left" value="??"  onclick="selectAction('action1');">
</form>




</body>
</html>
