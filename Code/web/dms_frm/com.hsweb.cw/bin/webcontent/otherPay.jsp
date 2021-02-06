<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false" %>
	
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<!-- 
  - Author(s): localhost
  - Date: 2018-07-02 20:26:29
  - Description:
-->
<head>
<title>其他收支</title>
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
</style>

<body>
    <div class="nui-fit">
        <div style="height: 60px;">
            <table>
                <tr>
                    <td style="width:100%;">
                        <input class="nui-textbox" style="width:30%" emptytext="请输入发票号/开票单号/源单号/客户姓名/手机号码/车牌号查询">
                        <input class="nui-combobox" style="width:12%" data="data" value="1">
                        <a class="nui-button" iconCls="icon-search" onclick="">打印</a>
                        <a class="nui-button" iconCls="icon-search" onclick="">新建</a>
                        <a class="nui-button" iconCls="icon-search" onclick="">修改</a>
                        <a class="nui-button" iconCls="icon-search" onclick="">删除</a>
                        <a class="nui-button" iconCls="icon-search" onclick="">导出XLS</a>
                    </td>
                </tr>
            </table>
        </div>
        <div class="nui-fit">
            <div id="grid" class="nui-datagrid" datafield="" allowcelledit="true" url="" allowcellwrap="true" style="width:100%;height:100%;">
                <div property="columns">
                    <div type="checkcolumn"></div>
                    <div field="" name="" headeralign="center" align="center">其他收支单号</div>
                    <div field="" id="" name="" headeralign="center" align="center">来源单号</div>
                    <div field="" id="" name="" headeralign="center" align="center">交易对象</div>
                    <div field="" id="" name="" headeralign="center" align="center">金额</div>
                    <div field="" id="" name="" headeralign="center" align="center">交易类型</div>
                    <div field="" id="" name="" headeralign="center" align="center">业务类型</div>
                    <div field="" id="" name="" headeralign="center" align="center">发生日期</div>
                    <div field="" id="" name="" headeralign="center" align="center">办理人</div>
                    <div field="" id="" name="" headeralign="center" align="center">审批状态</div>                   
                </div>
            </div>
        </div>
    </div>
    <script type="text/javascript">
        var data = [{ id: "1", text: "更多筛选" }];
        nui.parse();
    </script>
</body>
</html>