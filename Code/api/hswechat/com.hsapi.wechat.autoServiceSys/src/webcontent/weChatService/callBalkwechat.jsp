<%@page import=" com.huasheng.userOrder.CallBackUtil"%>
<%@page import="java.io.ByteArrayOutputStream"%>
<%@page import="java.util.Map"%>
<%@page import="java.io.InputStream"%>
<%@page import="com.huasheng.userOrder.WXPayUtil"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false"%>



<%
	boolean isOk = CallBackUtil.callBack(request, response);
	System.out.println(isOk);
	System.out.println("你支付成功了哦");
	
 %>
	