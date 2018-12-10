<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false" %>
	<%@include file="/common/sysCommon.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<!-- 
  - Author(s): localhost
  - Date: 2018-07-03 20:20:41
  - Description:
-->
<head>
<title>收款流水明细</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
    <script src="<%= request.getContextPath() %>/common/nui/nui.js" type="text/javascript"></script>
</head>
<style type="text/css">
    body {
        margin: 0;
        padding: 0;
        border: 0;
        width: 100%;
        height: 100%;
        overflow: hidden;
    }
    	#left {
	display:inline-block;
	float:left;
	}
	#right {
	display:inline-block;
	float:right;
	}
</style>
<body>
<div class="nui-fit">
    <div style="height: 50px;">
        <h2><span id="left">收款流水明细表（收款单据）</span></h2>
        <span id="right">2018.07.02</span>
    </div>
    <div style="height: 50px;">
        <span>统计范围</span>
        <input class="nui-combobox" style="width:15%" data="data" value="1">
        <span>收款时间</span>
        <input class="nui-datepicker" id="" name="" dateFormat="yyyy-MM-dd" style="width:120px" /> 至
        <input class="nui-datepicker" id="" name="" dateFormat="yyyy-MM-dd" style="width:120px" />
        <input class="nui-combobox" style="width:6%" data="data1" value="1">
        <a class="nui-button" iconCls="icon-search" onclick="">查询</a>
        <a class="nui-button" iconCls="icon-search" onclick="">重置</a>
        <a class="nui-button" iconCls="icon-search" onclick="">导出</a>
        <a class="nui-button" iconCls="icon-search" onclick="">列设置</a>
    </div>
    <div class="nui-fit">
        <table>
            <tr>
                <td>
                    收款对象
                    <input class="nui-textbox" style="width:100%">
                </td>
                <td style="width: 60px;"></td>
                <td>
                    手机号
                    <input class="nui-textbox" style="width:100%">
                </td>
                <td style="width: 60px;"></td>
                <td>
                    客户类型
                    <input class="nui-combobox" style="width:100%">
                </td>
                <td style="width: 60px;"></td>
                <td>
                    客户来源
                    <input class="nui-combobox" style="width:100%">
                </td>
            </tr>
            <tr>
                <td>
                    车牌号
                    <input class="nui-textbox" style="width:100%">
                </td>
                <td style="width: 60px;"></td>
                <td>
                    品牌车型
                    <input class="nui-textbox" style="width:100%">
                </td>
                <td style="width: 60px;"></td>
                <td>
                    源单类型
                    <input class="nui-combobox" style="width:100%">
                </td>
                <td style="width: 60px;"></td>
                <td>
                    源单业务分类
                    <input class="nui-combobox" style="width:100%">
                </td>
            </tr>
            <tr>
                <td>
                    来店途径
                    <input class="nui-combobox" style="width:100%">
                </td>
                <td style="width: 60px;"></td>
                <td>
                    源单号
                    <input class="nui-textbox" style="width:100%">
                </td>
                <td style="width: 60px;"></td>
                <td>
                    送修人
                    <input class="nui-textbox" style="width:100%">
                </td>
                <td style="width: 60px;"></td>
                <td>
                    送修人手机
                    <input class="nui-textbox" style="width:100%">
                </td>
            </tr>
            <tr>
                <td>
                    服务顾问
                    <input class="nui-textbox" style="width:100%">
                </td>
                <td style="width: 60px;"></td>
                <td>
                    财务单号
                    <input class="nui-textbox" style="width:100%">
                </td>
                <td style="width: 60px;"></td>
                <td>
                    明细类别
                    <input class="nui-combobox" style="width:100%">
                </td>
                <td style="width: 60px;"></td>
                <td>
                    结算时间
                    <input class="nui-datepicker" id="" name="" dateFormat="yyyy-MM-dd" style="width:120px" /> 至
                    <input class="nui-datepicker" id="" name="" dateFormat="yyyy-MM-dd" style="width:120px" />
                </td>
            </tr>
            <tr>
                <td>
                    财务分类
                    <input class="nui-combobox" style="width:100%">
                </td>
                <td style="width: 60px;"></td>
                <td>
                    结算人
                    <input class="nui-textbox" style="width:100%">
                </td>
                <td style="width: 60px;"></td>
                <td>
                    收款人
                    <input class="nui-textbox" style="width:100%">
                </td>
                <td style="width: 60px;"></td>
                <td>
                    票据号
                    <input class="nui-textbox" style="width:100%">
                </td>
            </tr>
            <tr>
                <td>
                    业务单备注
                    <input class="nui-textbox" style="width:100%">
                </td>
                <td style="width: 60px;"></td>
                <td>
                    结算备注
                    <input class="nui-textbox" style="width:100%">
                </td>
                <td style="width: 80px;"></td>
				 <td>
                    收银备注
                    <input class="nui-textbox" style="width:100%">
                </td>
            </tr>
        </table>
    </div>
</div>
    <script type="text/javascript">
     var data = [{ id: "1", text: "宝轩汽车" }];
     var data1 = [{ id: "1", text: "更多筛选" }];
    	nui.parse();
    </script>
</body>
</html>