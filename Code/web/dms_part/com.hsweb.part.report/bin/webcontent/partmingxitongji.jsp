<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false" %>
	
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<!-- 
  - Author(s): localhost
  - Date: 2018-07-04 08:52:51
  - Description:
-->
<head>
<title>采购明细统计</title>
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
    <div style="height: 130px;">
        <div align="right">
            <a class="nui-button" iconcls="" id="" name="" onclick="">查询</a>
            <a class="nui-button" iconcls="icon-blueReturn" id="" name="" onclick="">导出</a>
        </div>
        <table>
            <tr>
                <td>
                    统计范围
                    <input class="nui-combobox" style="width:50%" data="data" value="1">
                </td>
                <td>
                    品牌
                    <input class="nui-combobox" style="width:50%" data="" value="">
                </td>
                <td>
                    材料名称
                    <input class="nui-textbox" style="width:60%" data="" value="">
                </td>
                <td>
                    材料编码
                    <input class="nui-textbox" style="width:60%" data="" value="">
                </td>
            </tr>
            <tr>
                <td>
                     供应商名称
                    <input class="nui-textbox" style="width:60%" data="" value="">
                </td>
                <td>
                    订单号
                    <input class="nui-textbox" style="width:60%" data="" value="">
                </td>
                <td>
                    欠款金额
                    <input class="nui-combobox" style="width:20%" data="data1" value="1">
                    <input class="nui-textbox" style="width:40%" data="" value="">
                </td>
                <td>
                    日期
                    <input class="nui-datepicker" id="" name="" dateFormat="yyyy-MM-dd" style="width:120px" /> 至
                    <input class="nui-datepicker" id="" name="" dateFormat="yyyy-MM-dd" style="width:120px" />
                </td>
            </tr>
            <tr>
                <td>
                    零件号
                    <input class="nui-textbox" style="width:60%" data="" value="">
                </td>
                <td>
                    业务分类
                    <input class="nui-combobox" style="width:60%" data="" value="">
                </td>
                <td>
                     采购方式
                    <input class="nui-combobox" style="width:60%" data="data2" value="1">
                </td>
            </tr>
        </table>
    </div>
    <div class="nui-fit">
        <div class="nui-fit">
            <div id="grid" class="nui-datagrid" datafield="" allowcelledit="true" url="" allowcellwrap="true" style="width:100%;height:100%;">
                <div property="columns">
                    <div field="" name="" headeralign="center" align="center" width="70px">门店</div>
                    <div field="" id="" name="" headeralign="center" align="center" width="70px">订单号</div>
                    <div field="" id="" name="" headeralign="center" align="center" width="70px">供应商单号</div>
                    <div field="" id="" name="" headeralign="center" align="center" width="70px">订单日期</div>
                    <div field="" id="" name="" headeralign="center" align="center" width="70px">供应商名称</div>
                    <div field="" id="" name="" headeralign="center" align="center" width="70px">订单金额</div>
                    <div field="" id="" name="" headeralign="center" align="center" width="70px">欠款金额</div>
                    <div field="" id="" name="" headeralign="center" align="center" width="70px">材料名称</div>
                    <div field="" id="" name="" headeralign="center" align="center" width="70px">业务名称</div>
                    <div field="" id="" name="" headeralign="center" align="center" width="70px">材料编码</div>
                    <div field="" id="" name="" headeralign="center" align="center" width="70px">零件号</div>
                    <div field="" id="" name="" headeralign="center" align="center" width="70px">品牌</div>
                    <div field="" id="" name="" headeralign="center" align="center" width="70px">规格型号</div>
                    <div field="" id="" name="" headeralign="center" align="center" width="70px">单位</div>
                    <div header="数量" headerAlign="center">
                        <div property="columns">
                            <div field="" id="" name="" headeralign="center" align="center" width="70px">采购</div>
                            <div field="" id="" name="" headeralign="center" align="center" width="70px">入库</div>
                            <div field="" id="" name="" headeralign="center" align="center" width="70px">退货</div>
                        </div>
                    </div>
                    <div field="" id="" name="" headeralign="center" align="center" width="70px">单价</div>
                    <div header="金额" headerAlign="center">
                        <div property="columns">
                            <div field="" id="" name="" headeralign="center" align="center" width="70px">采购</div>
                            <div field="" id="" name="" headeralign="center" align="center" width="70px">入库</div>
                            <div field="" id="" name="" headeralign="center" align="center" width="70px">退货</div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
    <script type="text/javascript">
    var data = [{ id: "1", text: "宝轩汽车" }];
    var data1 = [{ id: "1", text: "大于" }, { id: "2", text: "小于" }, { id: "3", text: "等于" }];
    var data2 = [{ id: "1", text: "对外采购" }, { id: "2", text: "对内采购（调拨）" }, { id: "3", text: "所有" }];
    	nui.parse();
    </script>
</body>
</html>