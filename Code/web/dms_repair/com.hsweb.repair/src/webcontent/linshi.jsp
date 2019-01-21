<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<!-- 
  - Author(s): Administrator
  - Date: 2018-12-24 11:02:48
  - Description:
-->

<head>
    <title>业务产值汇总表</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
    <script src="<%= request.getContextPath() %>/repair/js/linshi.js?v=1.0.0" type="text/javascript"></script>
    <%@include file="/common/commonRepair.jsp"%>
    <style>
        .titleTextDiv{
            border-bottom:1px solid #ccc;
            margin-top: 10px;
        }
        .titleText{
            font-weight: 400;
            font-size: 18px;
            color: #666;
            border-bottom: 2px solid #23c0fa;
            display: inline-block;
            line-height: 35px;
        }
        .tbText{
            width:100px;
            text-align: right;
            font-size: 13px;
        }
        body{
            overflow: hidden;
        }
        /* .iconStyle{
            font-size: 14px;
            margin-top: 2px;
            position: absolute;
            color:#f0ce25;
        }
        .tipStyle{
            position: absolute; 
            background-color: #595959; 
            color:#fff;
            border-radius: 4px;
            padding:5px 10px 5px 10px;
            opacity:0.9;
            font-size:14px;
            display: none;
            z-index:999;
        } */
    </style>
</head>

<body>
    <div class="nui-fit">
        <div style="padding:2px;" id="queryForm">
            <table style="width:100%;line-height: 30px;">

                <tr>
                    <td class="tbText">新车上路时间：</td>
                    <td> <input class="nui-combobox" name="" id="tyear" data="tyear" valueField="text" textFieid="text" allowInput="true"/>
                        <input class="nui-combobox" name="" id="tmonth" data="tmonth" valueField="text" textFieid="text" allowInput="true"/>
                    </td>
                </tr>
                <tr>
                    <td class="tbText">当前行驶里程：</td>
                    <td> <input class="nui-combobox" name="" id="kili" data="kili" valueField="text" textFieid="text" allowInput="true"/>
                        <a class="nui-button" onclick="" plain="" style="margin-left:83px;">
                            <span class="fa fa-search fa-lg"></span>&nbsp;查询
                        </a>
                    </td>
                </tr>
            </table>
        </div>

        <div id="showDiv" class="tipStyle"></div>
        <div class="titleTextDiv">
            <span class="titleText">必做项信息</span>
        </div>

        <div id="grid1" class="nui-datagrid" style="width:100%;height:auto;margin-top:10px;" allowResize="false"
            showPager="false" showSummaryRow="false">
            <div property="columns">

                <div field="val1" width="130" headerAlign="center" align="left">配件名称</div>
                <div field="val2" width="100" headerAlign="center" align="left">配件编号</div>
                <div field="val3" width="100" headerAlign="center" align="left">用量</div>
                <div field="val4" width="300" headerAlign="center" align="left">备注</div>
                <div field="val5" width="100" headerAlign="center" align="left">配件单价x数量</div>
                <div field="val6" width="100" headerAlign="center" align="left">工时小费</div>
                <div field="val7" width="100" headerAlign="center" align="left">小计</div>
            </div>
        </div>

        <div class="titleTextDiv">
            <span class="titleText">检查项信息</span>
        </div>

        <div id="grid2" class="nui-datagrid" style="width:100%;height:auto;margin-top:10px;" allowResize="false"
            showPager="false" showSummaryRow="false">
            <div property="columns">
                <div field="val1" width="130" headerAlign="center" align="left">配件名称</div>
                <div field="val2" width="100" headerAlign="center" align="left">配件编号</div>
                <div field="val3" width="100" headerAlign="center" align="left">用量</div>
                <div field="val4" width="300" headerAlign="center" align="left">备注</div>
                <div field="val5" width="100" headerAlign="center" align="left">配件单价x数量</div>
                <div field="val6" width="100" headerAlign="center" align="left">工时小费</div>
                <div field="val7" width="100" headerAlign="center" align="left">小计</div>
            </div>
        </div>
        <span style="font-size: 13px;"> 注意：部分车型可能无法查询到结果</span>
    </div>
    <script type="text/javascript">
        nui.parse();
        var grid1 = nui.get("grid1");
        var grid2 = nui.get("grid2");
        //grid1.setData(data1);

        showGrid(4);

        function showGrid(e) {

            nui.get("tyear").setValue("2015年");
            nui.get("tmonth").setValue("8月");
            nui.get("kili").setValue("12万公里");
            if (e == 1) { //丰田卡罗拉
                grid1.setData(da1);
                grid2.setData(da2);
            }
            if (e == 2) { //宝马
                grid1.setData(db1);
                grid2.setData(db2);
            }
            if (e == 3) { //奥迪Q5
                grid1.setData(dc1);
                grid2.setData(dc2);
            }
            if (e == 4) { //大众CC 2016款 2.0TSI DCT 尊贵版
                grid1.setData(dd1);
                grid2.setData(dd2);
            }
            if (e == 0) {
                grid1.setData([]);
                grid2.setData([]);

                nui.get("tyear").setValue();
                nui.get("tmonth").setValue();
                nui.get("kili").setValue();
            }
        }
        
        function setInitData(params, yearp, monthp, milep) {
        	var brand = params.brand||"";
        	var index1 = brand.indexOf("丰田");
        	var index2 = brand.indexOf("宝马");
        	var index3 = brand.indexOf("奥迪");
        	var index4 = brand.indexOf("大众");
        	var e = 2;
        	if(index1 >= 0) {
        		e = 1;
        	}
        	if(index2 >= 0) {
        		e = 2;
        	}
        	if(index3 >= 0) {
        		e = 3;
        	}
        	if(index4 >= 0) {
        		e = 4;
        	}
        	
			showGrid(e);
		}
    </script>
</body>

</html>