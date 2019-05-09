
<%@page import="com.eos.data.datacontext.IUserObject"%>
<%@page import="com.eos.data.datacontext.DataContextManager"%>
<%@page import="com.eos.data.datacontext.IMUODataContext"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false"%>

<script type="text/javascript" src="<%=webPath + contextPath%>/cloudservice/cloudcall/assets/js/jquery.js" charset="utf8"></script>
    <script src="http://cdn.bootcss.com/jquery/1.12.3/jquery.min.js"></script>
    <script src="<%=webPath + contextPath%>/cloudservice/cloudcall/assets/js/layer.js"></script>
    <script type="text/javascript" src="<%=webPath + contextPath%>/cloudservice/cloudcall/libs/polyfill.min.js" charset="utf8"></script>
    <script type="text/javascript" src="<%=webPath + contextPath%>/cloudservice/cloudcall/libs/M800Core.js" id="m800Core" charset="utf-8"></script>
    <script type="text/javascript" src="<%=webPath + contextPath%>/cloudservice/cloudcall/libs/M800Verification.js" charset="utf-8"></script>
    <script type="text/javascript" src="<%=webPath + contextPath%>/cloudservice/cloudcall/libs/M800Im.js" charset="utf8"></script>
    <script type="text/javascript" src="<%=webPath + contextPath%>/cloudservice/cloudcall/libs/M800Call.js" charset="utf8"></script>
<script src="<%=webPath + contextPath%>/common/crmcommon.js?v=1.0.1" type="text/javascript"></script>


<style type="text/css">
	html,
	body {
		margin: 0;
		padding: 0;
		border: 0;
		width: 100%;
		height: 100%;
		overflow: hidden;
	}

	table {
		font-size: 12px;
	}
</style>