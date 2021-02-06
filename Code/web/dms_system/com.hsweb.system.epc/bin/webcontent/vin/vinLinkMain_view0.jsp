<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" session="false" %>
    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<!-- 
  - Author(s): Guine
  - Date: 2018-02-18 23:25:58
  - Description:
-->
<head>
    <title>车架号/品牌车型/零件号</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
    <%@include file="/common/sysCommon.jsp" %>
    <script src="<%=contextPath%>/epc/vin/js/vinLinkMain.js?v=1.14" type="text/javascript"></script>
    <style type="text/css">
    body {
        margin: 0;
        padding: 0;
        border: 0;
        width: 100%;
        height: 100%;
        overflow: hidden;
        font-family: "微软雅黑";
    }

    .right{
        text-align: right;
    }  
    .fwidtha{
        width: 120px;
    }
    .fwidthb{
        width: 120px;
    }
    .htr{
        height: 30px;
    }
    .mainwidth{
        width: 1100px;
    }
    .tmargin{
        margin-top: 10px;
        margin-bottom: 10px;
    }

    .vpanel{
        border:1px solid #d9dee9;
        margin:10px 0px 0px 20px;
        height:248px;
        float:left;
    }
    .vpanel_heading{
        border-bottom:1px solid #d9dee9;
        width:100%;
        height:28px;
        line-height:28px;
    }
    .vpanel_heading span{
        margin:0 0 0 20px;
        font-size:16px;
        font-weight:normal;
    }
    .vpanel_bodyww{
        padding : 10 10 10 10px !important

    }

    .required {
        color: red;
    }

</style>
</head>
<body>
    <div class="nui-toolbar" style="padding:10px;border-top:0;border-left:0;border-right:0;text-align:center;">
        <a class="nui-button" iconCls="" plain="true" onclick="query_vin(0)" id="query0">车架号查询</a>
        <a class="nui-button" iconCls="" plain="true" onclick="query_vin(1)" id="query1">车型查询</a>
        <a class="nui-button" iconCls="" plain="true" onclick="query_vin(2)" id="query2">零件号查询</a>
<!--         <a class="nui-button" iconCls="" plain="true" onclick="query_vin(3)" id="query3">品牌件查询</a>
        <a class="nui-button" iconCls="" plain="true" onclick="query_vin(4)" id="query4">保养件查询</a> -->
        <a class="nui-button" iconCls="" plain="true" onclick="showPanel('')" id="query2">（购物车）</a>
    </div>
    <div class="nui-fit">
            <iframe id="mainFrame0" class="theIframe" src="" frameborder="0" scrolling="yes" height="100%" width="100%" noresize="noresize"></iframe>
            <iframe id="mainFrame1" class="theIframe" src="" frameborder="0" scrolling="yes" height="100%" width="100%" noresize="noresize"></iframe>
            <iframe id="mainFrame2" class="theIframe" src="" frameborder="0" scrolling="yes" height="100%" width="100%" noresize="noresize"></iframe>
            <iframe id="mainFrame3" class="theIframe" src="" frameborder="0" scrolling="yes" height="100%" width="100%" noresize="noresize"></iframe>
            <iframe id="mainFrame4" class="theIframe" src="" frameborder="0" scrolling="yes" height="100%" width="100%" noresize="noresize"></iframe>
    </div>



    <div id="win" class="nui-window" title="购物车(临时存放信息)" style="width:570px;height:300px;" 
        showMaxButton="true" showCollapseButton="true" showShadow="true"
        showToolbar="true" showFooter="true" showModal="false" allowResize="true" allowDrag="true"
        >
        <div class="nui-toolbar" style="padding:0px;border-bottom:0;">
            <div class="form" id="queryForm">
                <table style="width:100%;">
                    <tr>
                        <td style="white-space:nowrap;">
                            <a class="nui-button" iconCls="" plain="true" onclick="deleteCartShop()">删除</a>
                            <span class="separator"></span>
                            <a class="nui-button" iconCls="" visible="true" id="pchsCartBtn" plain="true" onclick="addToPchsCart()">添加采购车</a>
                            <a class="nui-button" iconCls="" visible="true" id="sellCartBtn" plain="true" onclick="addToSellCart()">添加销售车</a>
                            <span class="separator"></span>
                            <a class="nui-button" iconCls="" visible="true" id="pchsOrderBtn" plain="true" onclick="generatePchsOrder()">生成采购订单</a>
                            <a class="nui-button" iconCls="" visible="true" id="sellOrderBtn" plain="true" onclick="generateSellOrder()">生成销售订单</a>
                            <a class="nui-button" visible="true" plain="true"onclick="copyEmbed()" id="copyBtn" data-clipboard-action="copy">一键复制</a>							
                            <input id="bar" value="Mussum ipsum cacilds..." style="display:none">
                     
                        </td>
                    </tr>
                </table>
            </div>
        </div>

        <div class="nui-fit">
                <div id="cartGrid" class="nui-datagrid" style="width:100%;height:100%;"
                             borderStyle="border:0;"
                             showPager="false"
                             dataField="list"
                             url=""
                             showSummaryRow="true"
                             idField="id"
                             totalField="page.count"
                             pageSize="100"
                             oncellcommitedit="onCellCommitEdit"
                             showPager="true"
                             showLoading="false"
                             multiSelect="true"
                             showFilterRow="false" allowCellSelect="true" allowCellEdit="true">
                        <div property="columns">
                                <div type="indexcolumn">序号</div>
                                <div type="checkcolumn" width="25"></div>
                                <div field="partId" width="50" visible="false" headerAlign="center">配件ID</div>
                                <div field="pid" width="80" headerAlign="center" allowSort="true" summaryType="count">零件OE号</div>
                                <div field="label" width="120" headerAlign="center" allowSort="true">名称</div>
                                <div field="PCS" width="30" visible="false" headerAlign="center" allowSort="true">单位PCS</div>
                                <div field="orderQty" width="50" headerAlign="center" allowSort="true">
                                    数量<input property="editor" vtype="float" class="nui-textbox"/>
                                </div>
                                <div field="orderPrice" width="50" headerAlign="center" allowSort="true">
                                    单价<input property="editor" vtype="float" class="nui-textbox"/>
                                </div>
                                <div field="remark" width="80" headerAlign="center" allowSort="true">备注<input property="editor" class="nui-textbox"/></div>
                        </div>
                </div>
        </div>
    </div>


</body>
</html>