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
    <title>客户资料汇总</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
    <script src="<%= request.getContextPath() %>/common/nui/nui.js" type="text/javascript"></script>
    <script type="text/javascript" src="https://unpkg.com/echarts@3.5.3/dist/echarts.js"></script>
    <script src="<%= request.getContextPath() %>/common/nui/macarons.js" type="text/javascript"></script>
    <%@include file="/common/commonRepair.jsp"%>
    <style>

        .parent{display:flex;}
        .column{flex:1;border-radius:10px;background-color:#95d9f966;margin-top:20px;padding:10px;}
        .column+.column{margin-left:20px;} 
        .incomeTitle{
            margin: 10px 0px 0px 5px;
            color: #23c0fa;
            font-size:18px;
            font-weight: normal;
        }
        .incomeStyle{
            margin: 10px 0px 0px 0px;
            text-align: center;
            color: #f9a52e ;
            font-size:28px;
        }
        .incomeStyle2{
            margin: 10px 0px 0px 0px;
            text-align: center;
            color: #f9a52e ;
            font-size:18px;
        }
         .parent div:hover{
            background-color:#B0D6F9;
            
            cursor: pointer;
        }
        .parent div:hover p{
            color:#fff ;
        }
        .parent div:hover h3{
            color:#fff ;
        }
        .parent div:hover p>span{
            color:#fff ;
        }
        .titleText{
            font-weight: 400;
            font-size: 18px;
            color: #666;
            border-bottom: 2px solid #23c0fa;
            display: inline-block;
            line-height: 35px;
        }
    </style>
</head>

<body>

    <div style="height: 150px;" class="parent">

        <div class="column">
            <h3 class="incomeTitle">总客户数</h3>
            <p class="incomeStyle" style="margin-top: 20px;">345342.00</p>
        </div>
        <div class="column">
            <h3 class="incomeTitle">总车辆数</h3>
            <p class="incomeStyle"  style="margin-top: 20px;">345342.00</p>
        </div>
        <div class="column">
            <h3 class="incomeTitle">已来厂车辆</h3>
            <p class="incomeStyle"  style="margin-top: 20px;">300000.00</p>
        </div>
        <div class="column">
            <h3 class="incomeTitle">未来厂车辆</h3>
            <p class="incomeStyle"  style="margin-top: 20px;">45342.00</p>
        </div>

    </div>

    <div class="nui-fit">
        <div id="t1" style="width: 100%; height: auto;padding:10px 0px 0px 0px;display: inline-block;">
            <div id="t2" style="float:left;width: 49.5%; height: 100%;">
                <div style="border-bottom:1px solid #ccc;">
                    <span class="titleText">已来厂客户</span>
                </div>
                <div class="nui-toolbar" style="padding:2px;border-bottom:0px;color:#2d79aa;margin-top: 10px;" id="queryForm">
                    <table style="width:100%;">
                        <tr>
                            <td>
                                <label style="font-family:Verdana;">分组查询条件：</label>
                                <a class="nui-button" plain="false" onclick="" id="" style="margin-right:5px;"><span class="fa fa-bars fa-lg"></span>&nbsp;品牌</a>
                                <a class="nui-button" plain="false" onclick="" id="" style="margin-right:5px;"><span class="fa fa-bars fa-lg"></span>&nbsp;SA</a>
                                <a class="nui-button" plain="false" onclick="" id="" style="margin-right:5px;"><span class="fa fa-bars fa-lg"></span>&nbsp;来厂次数</a>
                                <a class="nui-button" plain="false" onclick="" id="" style="margin-right:5px;"><span class="fa fa-bars fa-lg"></span>&nbsp;金额</a>
                            </td>
                        </tr>
                    </table>
                </div>
                <div id="datagrid1" class="mini-datagrid" style="width:100%;height:auto" idField="id" allowResize="false"
                    showPager="false" showColumns="true"showSummaryRow="true">
                    <div property="columns">
                        <div field="" width="60" headerAlign="center" align="center">品牌</div>
                        <div field="" width="60" headerAlign="center" align="center">总数</div>
                        <div field="" width="60" headerAlign="center" align="center">新客户</div>
                        <div field="" width="60" headerAlign="center" align="center">活跃期</div>
                        <div field="" width="60" headerAlign="center" align="center">稳定期</div>
                        <div field="" width="60" headerAlign="center" align="center">睡眠期</div>
                        <div field="" width="60" headerAlign="center" align="center">流失期</div>
                        <div field="" width="60" headerAlign="center" align="center">未分类</div>
                    </div>
                </div>
            </div>
            <div id="t4" style="float:left;width: 1%; height:-webkit-fill-available;display:block;"></div>
            <div id="t3" style="float:left;width: 49.5%; height: 100%;">
                <div style="border-bottom:1px solid #ccc;">
                    <span class="titleText">营销客户</span>
                </div>
                <div class="nui-toolbar" style="padding:2px;border-bottom:0px;color:#2d79aa;margin-top: 10px;" id="queryForm">
                    <table style="width:100%;">
                        <tr>
                            <td>
                                <label style="font-family:Verdana;">分组查询条件：</label>
                                <a class="nui-button" plain="false" onclick="" id="" style="margin-right:5px;"><span class="fa fa-bars fa-lg"></span>&nbsp;品牌</a>
                                <a class="nui-button" plain="false" onclick="" id="" style="margin-right:5px;"><span class="fa fa-bars fa-lg"></span>&nbsp;营销员</a>
                                <a class="nui-button" plain="false" onclick="" id="" style="margin-right:5px;"><span class="fa fa-bars fa-lg"></span>&nbsp;意向等级</a>
                            </td>
                        </tr>
                    </table>
                </div>
                <div id="datagrid2" class="mini-datagrid" style="width:100%;height:auto;" idField="id" allowResize="false"
                    showPager="false" showColumns="true" showSummaryRow="true">
                    <div property="columns">
                        <div field="vala" width="60" headerAlign="center" align="center">品牌</div>
                        <div field="vala" width="60" headerAlign="center" align="center">总数</div>
                        <div field="" headerAlign="center" align="center">联系状态
                            <div property="columns">
                                <div field="vala" width="60" headerAlign="center" align="center">已联系</div>
                                <div field="vala" width="60" headerAlign="center" align="center">未联系</div>
                                <div field="vala" width="60" headerAlign="center" align="center">终止联系</div>
                            </div>

                        </div>
                        <div field=""headerAlign="center" align="center">来厂状态
                            <div property="columns">
                                <div field="vala" width="60" headerAlign="center" align="center">已来厂</div>
                                <div field="vala" width="60" headerAlign="center" align="center">未来厂</div>
                            </div>

                        </div>
                        <div field="" headerAlign="center" align="center">资料有效状态
                            <div property="columns">
                                <div field="vala" width="60" headerAlign="center" align="center">有效资料</div>
                                <div field="vala" width="60" headerAlign="center" align="center">无效资料</div>
                            </div>

                        </div>

                    </div>
                </div>
            </div>

            <div style="clear: both"></div>
            <!-- 注释：清除float产生浮动 -->
        </div>
    </div>


    <script type="text/javascript">
        nui.parse();

    </script>
</body>

</html>