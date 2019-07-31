<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<!-- 
  - Author(s): Administrator
  - Date: 2019-07-29 15:00:37
  - Description:
-->
<head>
<title>数据处理</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
    	<%@include file="/common/sysCommon.jsp"%>
   <script src="<%= request.getContextPath() %>/dataProcessing/js/dataProcessing.js?v=1.0.4"></script>
    
</head>
<body>
         <div class="nui-toolbar" style="padding:0px;border-bottom:0;">
            <table style="width:100%;">
                <tr>
                    <td style="width:100%;">
                        <a class="nui-button" iconCls="" plain="true" onclick="save()"><span class="fa fa-save fa-lg"></span>&nbsp;保存</a>
                        <a class="nui-button" iconCls="" plain="true" onclick="CloseWindow()"><span class="fa fa-close fa-lg"></span>&nbsp;取消</a>
                        <!-- <a class="nui-button" iconCls="" plain="true" onclick="delet()" id="deletBtn"><span class="fa fa-trash-o fa-lg"></span>&nbsp;清空</a> -->
                    </td>
                </tr>
            </table>
        </div>
  <ul id="tree2" class="nui-tree"  style="width:200px;padding:5px;" 
        checkRecursive="true"
        showTreeIcon="true" textField="text" idField="id" parentField="pid" resultAsTree="false"  
        showCheckBox="true"  _checkOnTextClick="true"
        >
    </ul>

	<script type="text/javascript">
    	nui.parse();
    </script>
</body>
</html>