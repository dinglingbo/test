<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false" %>
	
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<!-- 
  - Author(s): localhost
  - Date: 2018-07-03 18:26:27
  - Description:
-->
<head>
<title>Title</title>
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
                       <span>统计范围</span>
                        <input class="nui-combobox" style="width:15%" data="data" value="1">
                        <input class="nui-combobox" style="width:10%" data="data1" value="1">                       
                        <a class="nui-button" iconCls="icon-search" onclick="">查询</a>
                        <a class="nui-button" iconCls="icon-search" onclick="">导出EXCEL</a>
                    </td>                                    
                </tr>
                
            </table>
        </div>
        <div class="nui-fit">
            <div id="grid" class="nui-datagrid" datafield="" allowcelledit="true" url="" allowcellwrap="true" style="width:100%;height:100%;">
                <div property="columns">                    
                    <div field="" name="" headeralign="center" align="center" width="80px">工单号</div>
                    <div field="" id="" name="" headeralign="center" align="center"width="80px">所属门店</div>
                    <div field="" id="" name="" headeralign="center" align="center"width="80px">工单类型</div>
                    <div field="" id="" name="" headeralign="center" align="center"width="80px">业务类型</div>
                    <div field="" id="" name="" headeralign="center" align="center"width="80px">车牌号</div>
                    <div field="" id="" name="" headeralign="center" align="center"width="80px">客户姓名</div>
                    <div field="" id="" name="" headeralign="center" align="center"width="80px">联系人</div>
                    <div field="" id="" name="" headeralign="center" align="center"width="80px">应收单号</div>
                    <div field="" id="" name="" headeralign="center" align="center"width="80px">工时应收</div>
                    <div field="" id="" name="" headeralign="center" align="center"width="80px">工时数</div>
                    <div field="" id="" name="" headeralign="center" align="center"width="80px">材料应收</div>
                    <div field="" id="" name="" headeralign="center" align="center"width="80px">代办费</div>
                    <div field="" id="" name="" headeralign="center" align="center"width="80px">诊断费</div>
                    <div field="" id="" name="" headeralign="center" align="center"width="80px">检测费</div>
                    <div field="" id="" name="" headeralign="center" align="center"width="80px">加工费</div>
                    <div field="" id="" name="" headeralign="center" align="center"width="80px">管理费</div>
                    <div field="" id="" name="" headeralign="center" align="center"width="80px">工单应收</div>
                    <div field="" id="" name="" headeralign="center" align="center"width="80px">工单实收</div>
                    <div field="" id="" name="" headeralign="center" align="center"width="80px">工单挂账</div>
                    <div field="" id="" name="" headeralign="center" align="center"width="80px">挂账回收</div>
                    <div field="" id="" name="" headeralign="center" align="center"width="80px">明细类别</div>
                    <div field="" id="" name="" headeralign="center" align="center"width="80px">工时费优惠</div>
                    <div field="" id="" name="" headeralign="center" align="center"width="80px">材料费优惠</div>
                    <div field="" id="" name="" headeralign="center" align="center"width="80px">套餐优惠</div>
                    <div field="" id="" name="" headeralign="center" align="center"width="80px">储值卡优惠</div>
                    <div field="" id="" name="" headeralign="center" align="center"width="80px">套餐卡优惠</div>
                    <div field="" id="" name="" headeralign="center" align="center"width="80px">计次卡优惠</div>
                </div>
            </div>
        </div>
</div>
    <script type="text/javascript">
    var data = [{ id: "1", text: "宝轩汽车" }];
     var data1 = [{ id: "1", text: "今天" }, { id: "2", text: "本周" }, { id: "3", text: "本月" }];
    	nui.parse();
    </script>
</body>
</html>