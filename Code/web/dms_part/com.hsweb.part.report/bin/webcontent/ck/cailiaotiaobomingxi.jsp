<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false" %>
	
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<!-- 
  - Author(s): localhost
  - Date: 2018-07-04 16:32:23
  - Description:
-->
<head>
<title>材料调拨明细</title>
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
    <div style="height: 200px;">
        <table>
            <tr>
                <td style="width:300px;">
                    <span>汇总方式</span>
                    <input class="nui-combobox" style="width:60%" data="data1" value="1">
                </td>
                <td style="width:200px;">
                    <input class="nui-combobox" style="width:60%" data="data2" value="1">
                </td>
                <td>
                    <a class="nui-button" iconcls="" id="" name="" onclick="">查询</a>
                    <a class="nui-button" iconcls="" id="" name="" onclick="">导出文件</a>
                </td>
            </tr>
            <tr>
                <td style="width:200px;">
                    <input class="nui-combobox" style="width:60%" data="data3" value="1">
                </td>
            </tr>
            <tr>
                <td>
                     日期
                    <input class="nui-datepicker" id="" name="" dateFormat="yyyy-MM-dd" style="width:120px" /> 至
                    <input class="nui-datepicker" id="" name="" dateFormat="yyyy-MM-dd" style="width:120px" />
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
                    材料分类
                    <input class="nui-textbox" style="width:60%" data="" value="">
                </td>
                <td>
                    业务分类
                    <input class="nui-combobox" style="width:60%" data="" value="">
                </td>
                <td>
                    零件号
                    <input class="nui-textbox" style="width:60%" data="" value="">
                </td>
                <td>
                    规格类型
                    <input class="nui-textbox" style="width:60%" data="" value="">
                </td>
            </tr>
            <tr>
                <td>
                    调出门店
                    <input class="nui-combobox" style="width:60%" data="" value="">
                </td>
                <td>
                    调出仓库
                    <input class="nui-combobox" style="width:60%" data="" value="">
                </td>
                <td>
                    调人门店
                    <input class="nui-combobox" style="width:60%" data="" value="">
                </td>
                <td>
                    调人仓库
                    <input class="nui-combobox" style="width:60%" data="" value="">
                </td>
            </tr>
            <tr>
                <td>
                    调拨单号
                    <input class="nui-textbox" style="width:60%" data="" value="">
                </td>
                <td>
                    调拨状态
                    <input class="nui-combobox" style="width:60%" data="" value="">
                </td>
            </tr>
        </table>
    </div>
    <div class="nui-fit">
        <div id="grid" class="nui-datagrid" datafield="" allowcelledit="true" url="" allowcellwrap="true" style="width:100%;height:100%;">
            <div property="columns">
                <div field="" name="" headeralign="center" align="center">调出单号</div>
                <div field="" id="" name="" headeralign="center" align="center">调人单号</div>
                <div field="" id="" name="" headeralign="center" align="center">创建日期</div>
                <div field="" id="" name="" headeralign="center" align="center">调拨状态</div>
                <div field="" id="" name="" headeralign="center" align="center">调出门店</div>
                <div field="" id="" name="" headeralign="center" align="center">调出仓库</div>
                <div field="" id="" name="" headeralign="center" align="center">调入门店</div>
                <div field="" id="" name="" headeralign="center" align="center">调入仓库</div>
                <div field="" id="" name="" headeralign="center" align="center">材料名称</div>
                <div field="" id="" name="" headeralign="center" align="center">材料编码</div>
                <div field="" id="" name="" headeralign="center" align="center">零件号</div>
                <div field="" id="" name="" headeralign="center" align="center">规格型号</div>
                <div field="" id="" name="" headeralign="center" align="center">品牌</div>
                <div field="" id="" name="" headeralign="center" align="center">材料分类</div>
                <div field="" id="" name="" headeralign="center" align="center">业务分类</div>
                <div field="" id="" name="" headeralign="center" align="center">单位</div>
                <div field="" id="" name="" headeralign="center" align="center">调拨数量</div>
                <div field="" id="" name="" headeralign="center" align="center">调拨价格</div>
                <div field="" id="" name="" headeralign="center" align="center">调拨金额</div>
                <div field="" id="" name="" headeralign="center" align="center">成本价格</div>
                <div field="" id="" name="" headeralign="center" align="center">成本金额</div>
                <div field="" id="" name="" headeralign="center" align="center">成本毛利</div>
            </div>
        </div>
    </div>
</div>
    <script type="text/javascript">
    var data = [{ id: "1", text: "宝轩汽车" }];
    var data1 = [{ id: "1", text: "日期" }, { id: "2", text: "材料分类" },{ id: "3", text: "业务分类" },{ id: "4", text: "供应商" },
    { id: "5", text: "出入库方式（含税）" },{ id: "6", text: "出入库方式（除税" }];
     var data2 = [{ id: "1", text: "今天" }, { id: "2", text: "上周末" }, { id: "3", text: "上月末" }];
     var data3 = [{ id: "1", text: "更多筛选" }];
    	nui.parse();
    </script>
</body>
</html>