<%@ page import=" com.eos.system.utility.StringUtil" %>
<%=StringUtil.htmlFilter(request.getAttribute("fileId").toString())%>