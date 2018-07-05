<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" session="false" %>	
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@include file="/common/sysCommon.jsp"%>	

<html>
<!-- 
  - Author(s): localhost
  - Date: 2018-07-03 19:34:53
  - Description:
-->

<head>
    <title>供应商采购排行榜</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
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
        <div>
            <input class="nui-combobox" style="width:5%" data="data">&nbsp;&nbsp;
            <span>日期</span>
            <input class="nui-datepicker" id="" name="" dateFormat="yyyy-MM-dd" style="width:120px" /> 至
            <input class="nui-datepicker" id="" name="" dateFormat="yyyy-MM-dd" style="width:120px" />
        </div>
        <div>
            供应商
            <input class="nui-textbox" style="width:20%">&nbsp;&nbsp; 采购方式
            <input class="nui-combobox" style="width:10%" data="data1" value="1">&nbsp;&nbsp;
            <a class="nui-button" iconcls="" id="" name="" onclick="">查询</a>
            <span>采购金额合计</span>
            <span style="color:rgb(102, 255, 0)">好多钱</span>
        </div>
        <div class="nui-fit">
            <div id="grid" class="nui-datagrid" datafield="" allowcelledit="true" url="" allowcellwrap="true" style="width:100%;height:100%;">
                <div property="columns">
                    <div field="" name="" headeralign="center" align="center">供应商名字</div>
                    <div field="" id="" name="" headeralign="center" align="center">采购数量</div>
                    <div field="" id="" name="" headeralign="center" align="center">采购金额</div>
                    <div field="" id="" name="" headeralign="center" align="center">数量百分比</div>
                    <div field="" id="" name="" headeralign="center" align="center">金额百分比</div>
                </div>
            </div>
        </div>
    </div>
    <script type="text/javascript">
        var data = [{
            id: "1",
            text: "今天"
        }, {
            id: "2",
            text: "三个月"
        }, {
            id: "3",
            text: "六个月"
        }, {
            id: "4",
            text: "九个月"
        }, {
            id: "5",
            text: "一年"
        }, {
            id: "6",
            text: "一年以上"
        }];
        var data1 = [{
            id: "1",
            text: "对外采购"
        }, {
            id: "2",
            text: "对内采购（调拨）"
        }, {
            id: "3",
            text: "所有"
        }];
        nui.parse();
    </script>
</body>

</html>