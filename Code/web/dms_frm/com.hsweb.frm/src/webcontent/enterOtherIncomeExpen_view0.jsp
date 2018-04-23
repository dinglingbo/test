<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<%@include file="/common/common.jsp"%>
<html>
<!-- 
  - Author(s): Guine
  - Date: 2018-04-23 12:39:27
  - Description:
-->
<head>
<title>其它收支登记</title> 
</head>
<body>


<form id="form1" action="com.hsweb.frm.enterOtherIncomeExpen"  method="post">
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
