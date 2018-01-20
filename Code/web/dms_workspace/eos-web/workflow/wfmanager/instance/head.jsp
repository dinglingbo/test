<html>
<head>
</head>
<body style="background:#FFFFFF;repeat-x;margin-top:0px;margin-left:0px;margin-buttom:0px;background:url(<%=request.getContextPath() %>/workflow/wfmanager/images/MainFrameBg.gif) repeat-x">
<table border="0" cellpadding="0" cellspacing="0" border="0" class="workarea" style="width:100%; height:100%">
  <tr>
  	<td class="workarea_title" valign="middle">&nbsp;
  	  <l:present property="pkgId">
  		<b:write property="pkgId"/> &gt; <b:write property="processDefName"/> &nbsp;&gt&nbsp;V<b:write property="versionSign"/> 
  		<d:write dictTypeId="WFDICT_ProcessDefState" property="currentState"/>
  	  </l:present>
  	  <l:notPresent property="pkgId">
  	  	<b:write property="title1"/>
  	  </l:notPresent>
	</td>
  </tr>
  <tr height="100%">
    <td width="100%" valign="top" >