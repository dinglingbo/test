<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false" %>
	
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<!-- 
  - Author(s): localhost
  - Date: 2018-07-04 17:02:13
  - Description:
-->
<head>
<title>工单业绩明细（应收）</title>
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
    <div style="height: 150px;">
        <table>
            <tr>
                <td style="width:300px;">
                    <span>统计范围</span>
                    <input class="nui-combobox" style="width:60%" data="data" value="1">
                </td>
                <td style="width:300px;">
                     出厂日期
                    <input class="nui-datepicker" id="" name="" dateFormat="yyyy-MM-dd" style="width:100px" /> 至
                    <input class="nui-datepicker" id="" name="" dateFormat="yyyy-MM-dd" style="width:100px" />
                </td>
                <td style="width:300px;">
                    <input class="nui-combobox" style="width:30%" data="data3" value="1">
                    <a class="nui-button" iconcls="" id="" name="" onclick="">查询</a>
                    <a class="nui-button" iconcls="" id="" name="" onclick="">重置</a>
                    <a class="nui-button" iconcls="" id="" name="" onclick="">导出</a>
                    <a class="nui-button" iconcls="" id="" name="" onclick="">列设置</a>
                </td>
                <td style="width:200px;"></td>
            </tr>
            <tr>
                <td style="width:300px;">
                 进厂日期
                <input class="nui-datepicker" id="" name="" dateFormat="yyyy-MM-dd" style="width:100px" /> 至
                <input class="nui-datepicker" id="" name="" dateFormat="yyyy-MM-dd" style="width:100px" />
                </td>
                <td  style="width:200px;">
                    工单号
                    <input class="nui-textbox">
                </td>
                <td>
                    车牌号
                    <input class="nui-textbox">
                </td>
                <td>
                    车辆品牌
                    <input class="nui-textbox">
                </td>
            </tr>
            <tr>
                <td>
                    车系
                    <input class="nui-combobox">
                </td>
                <td>
                    车主
                    <input class="nui-combobox" data="data1">
                </td>
                <td >
                    服务顾问
                    <input class="nui-textbox">
                </td>
                <td>
                    工单类型
                    <input class="nui-combobox">
                </td>
            </tr>
            <tr>
                <td>
                    业务分类
                    <input class="nui-combobox">
                </td>
                <td>
                    备注
                    <input class="nui-textbox">
                </td>
                <td>
                    结算人
                    <input class="nui-textbox">
                </td>
                <td>
                    收款人
                    <input class="nui-textbox">
                </td>
            </tr>
            <tr>
                <td>
                    来店途径
                    <input class="nui-combobox">
                </td>
                <td>
                    保险公司
                    <input class="nui-textbox">
                </td>
                <td>
                    客户来源
                    <input class="nui-combobox">
                </td>
                <td>
                    客户类型
                    <input class="nui-combobox">
                </td>
            </tr>
        </table>
    </div>
    <div class="nui-fit">
        <div id="grid" class="nui-datagrid" datafield="" allowcelledit="true" url="" allowcellwrap="true" style="width:100%;height:100%;">
            <div property="columns">
                <div field="" name="" headeralign="center" align="center">所属门店</div>
                <div field="" id="" name="" headeralign="center" align="center">工单号</div>
                <div field="" id="" name="" headeralign="center" align="center">车牌号</div>
                <div field="" id="" name="" headeralign="center" align="center">品牌</div>
                <div field="" id="" name="" headeralign="center" align="center">车系</div>
                <div field="" id="" name="" headeralign="center" align="center">vin码</div>
                <div field="" id="" name="" headeralign="center" align="center">品牌</div>
                <div field="" id="" name="" headeralign="center" align="center">车系</div>
                <div field="" id="" name="" headeralign="center" align="center">客户名称</div>
                <div field="" id="" name="" headeralign="center" align="center">客户类型</div>
                <div field="" id="" name="" headeralign="center" align="center">客户手机</div>
                <div field="" id="" name="" headeralign="center" align="center">工单类型</div>
                <div field="" id="" name="" headeralign="center" align="center">业务分类</div>
                <div field="" id="" name="" headeralign="center" align="center">明细类别</div>
                <div field="" id="" name="" headeralign="center" align="center">工单应收</div>
                <div field="" id="" name="" headeralign="center" align="center">工时应收</div>
                <div field="" id="" name="" headeralign="center" align="center">工时数</div>
                <div field="" id="" name="" headeralign="center" align="center">材料应收</div>
                <div field="" id="" name="" headeralign="center" align="center">代办费</div>
                <div field="" id="" name="" headeralign="center" align="center">诊断费</div>
            </div>
        </div>
    </div>
</div>
    <script type="text/javascript">
    var data = [{ id: "1", text: "宝轩汽车" }];
    var data1 = [{ id: "", text: "请选择" }, { id: "1", text: "维修" }, { id: "2", text: "保养" }, { id: "3", text: "美容" }, { id: "4", text: "钣喷" }
            , { id: "5", text: "轮胎" }, { id: "6", text: "洗车" }, { id: "7", text: "精品" }, { id: "8", text: "其他" }, { id: "9", text: "零售" }];
    var data3 = [{ id: "1", text: "更多筛选" }];
    	nui.parse();
    </script>
</body>
</html>