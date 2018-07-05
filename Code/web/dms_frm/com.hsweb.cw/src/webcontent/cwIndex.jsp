<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false" %>

    <!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
    <html>
    <!-- 
  - Author(s): localhost
  - Date: 2018-07-02 21:02:25
  - Description:
-->

    <head>
        <title>财务首页</title>
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
                            <input class="nui-textbox" style="width:30%" emptytext="请输入发票号/开票单号/源单号/客户姓名/手机号码/车牌号查询">
                            <input class="nui-combobox" style="width:6%" data="data" value="1">
                            <span>应收合计</span> <span>66</span>
                            <span>实收合计</span> <span>66</span>
                            <a class="nui-button" iconCls="icon-search" onclick="">收款</a>
                            <a class="nui-button" iconCls="icon-search" onclick="">导出XLS</a>
            </div>
            <div class="nui-fit">
                <div id="grid" class="nui-datagrid" datafield="" allowcelledit="true" url="" allowcellwrap="true" style="width:100%;height:100%;">
                    <div property="columns">
                        <div type="checkcolumn"></div>
                        <div field="" name="" headeralign="center" align="center">应收单号</div>
                        <div field="" id="" name="" headeralign="center" align="center">来源单号</div>
                        <div field="" id="" name="" headeralign="center" align="center">交易对象</div>
                        <div field="" id="" name="" headeralign="center" align="center">交易日期</div>
                        <div field="" id="" name="" headeralign="center" align="center">源单日期</div>
                        <div field="" id="" name="" headeralign="center" align="center">应收</div>
                        <div field="" id="" name="" headeralign="center" align="center">实收</div>
                        <div field="" id="" name="" headeralign="center" align="center">结算</div>
                        <div field="" id="" name="" headeralign="center" align="center">结算人</div>
                        <div field="" id="" name="" headeralign="center" align="center">收款人</div>
                        <div field="" id="" name="" headeralign="center" align="center">开票金额</div>
                        <div field="" id="" name="" headeralign="center" align="center">发票号</div>
                        <div field="" id="" name="" headeralign="center" align="center"></div>
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