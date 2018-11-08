<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false"%>
<%@include file="/common/common.jsp"%>
<%@include file="/common/commonRepair.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<!-- 
  - Author(s): Administrator
  - Date: 2018-01-24 11:14:08
  - Description:
-->
<head>
<title>出车报告</title>
<script src="<%= request.getContextPath() %>/repair/js/DataBase/OutCar/SelectOutCarReport.js?v=1.0.9"></script>
<style type="text/css">

table {
	table-layout: fixed;
	font-size: 12px;
}

.required {
	color: red;
}
</style>
</head>
<body>
<div class="nui-toolbar" style="border-bottom: 0;">
    <table style="width: 100%">
        <tr>
            <td>
              <a class="nui-button" iconCls="" plain="true" onclick="save()" id="addBtn"><span class="fa fa-save fa-lg"></span>&nbsp;保存</a>
              <a class="nui-button" plain="true" iconCls="" id="deleteBtn"  onclick="close()"><span class="fa fa-close fa-lg"></span>&nbsp;取消</a>
              <a class="nui-button" plain="true" iconCls="" id="SelectReport"  onclick="SelectReport()"><span class="fa fa-check fa-lg"></span>&nbsp;选择出车报告</a>
            </td>
        </tr>
    </table>
 </div>
<div class="nui-fit">
  <div class="form" id="basicInfoForm" style="width:100%;height: 100%">
        <input name="id" class="nui-hidden"/>
        <table class="nui-form-table" style="width:100%;height: 100%">
            <!-- <tr height="20">
                <td class="form_label">
                    <label>报告类型：</label>
                </td>
            </tr>
            <tr height="20">
                <td>
                    <input class="nui-combobox"
                           id="type" name="type"
                           valueField="customid"
                           textField="name"
                           allowInput="false"
                           allowNullItem="false"
                           width="100%"/>
                </td>
            </tr> -->
            <tr height="20">
                <td class="form_label required">
                    <label>报告内容：</label>
                </td>
            </tr>
            <tr>
                <td>
                    <textarea class="nui-textarea" name="content" style="width: 100%;height: 100%"></textarea>
                </td>
            </tr>
        </table>
  </div>
  <!--  <div style="text-align:center;">
    <span id="carHealthEl" >
        <a href="javascript:choosePart()" class="chooseClass" ><span class="fa fa-plus"></span>&nbsp;选择配件</a>
    </span>
  </div> -->
</div>
</body>
</html>