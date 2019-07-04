<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<%@include file="/common/common.jsp"%>
<%@include file="/common/commonPart.jsp"%>
<html>
<!-- 
  - Author(s): steven
  - Date: 2018-03-23 15:00:13
  - Description:
-->
<head>
    <title>用户导航</title>
    <script src="<%= request.getContextPath() %>/config/js/cloudPartsysInitGuide.js?v=1.1.4"></script>
    <style>
        .container {
            padding: 10px;
        }

        .container .mini-panel {
            margin-right: 20px;
            margin-bottom: 20px;
        }

    </style>
</head>
<body>
    <div class="container" align="center" >
        <table>
            <tr>
                <td>
                    <div class="mini-panel mini-panel-danger" title="系统参数" width="350px" showCollapseButton="false" showCloseButton="false">
                        <br />根据业务实际情况配置系统运行业务选项、业务处理控制参数
                        <br /><br />
                        <div align="center"><a class="mini-button mini-button-success" onclick="toSysSet()" >设置系统参数</a></div>
                    </div>
                </td>
                <td>
                    <div class="mini-panel mini-panel-primary" title="配件分类" width="350px" showCollapseButton="false" showCloseButton="false">
                        <br />建立配件存货的分类，便于以后按分类查找、统计
                        <br /><br />
                        <div align="center"><a class="mini-button mini-button-success" onclick="toComPartTypeSet()" >设置配件分类</a></div>
                    </div>
                </td>
                <td>
                    <div class="mini-panel mini-panel-success" title="配件资料" width="350px"showCollapseButton="false" showCloseButton="false">
                        <br />存货在商贸企业一般叫商品，是库存商品、在产品、原材料等生产经营资料的统称
                        <br /><br />
                        <div align="center"><a class="mini-button mini-button-success" onclick="toComAttributeSet()">设置配件资料</a></div>
                    </div>
                </td>
            </tr>
            <tr>
                <td>
                    <div class="mini-panel mini-panel-info" title="仓库设置" width="350px" showCollapseButton="false" showCloseButton="false">
                        <br />设置保管商品存货的实体仓库信息，也可以是零售门店或者废品虚拟仓库等
                        <br /><br />
                        <div align="center"><a class="mini-button mini-button-success" onclick="toComStoreSet()">设置仓库</a></div>
                    </div>
                </td>
                <td>
                    <div class="mini-panel mini-panel-info" title="往来单位" width="350px" showCollapseButton="false" showCloseButton="false">
                        <br />管理登记供应商与客户的资料，包括基本信息、联系人信息及其它信息，可导入
                        <br /><br />
                        <div align="center"><a class="mini-button mini-button-success" onclick="toComGuestSet()">设置往来单位</a></div>
                    </div>
                </td>
                <td>
                    <div class="mini-panel mini-panel-warning" title="期初库存" width="350px" showCollapseButton="false" showCloseButton="false">
                        <br />设置系统启用之前各仓库商品存货的结存数量和成本
                        <br /><br />
                        <div align="center"><a class="mini-button mini-button-success" onclick="toPartStockSet()">设置期初库存</a></div>
                    </div>
                </td>
            </tr>
            <tr>
                <td>
                    <div class="mini-panel mini-panel-danger" title="结算账户" width="350px" showCollapseButton="false" showCloseButton="false">
                        <br />设置经营活动中的各种结算账户，如现金、工行、建行、支付宝、微信等
                        <br /><br />
                        <div align="center"><a class="mini-button mini-button-success" onclick="toFiSettleAccountSet()">设置结算账户</a></div>
                    </div>
                </td>
                <td>
                    <div class="mini-panel mini-panel-primary" title="期初现金银行" width="350px" showCollapseButton="false" showCloseButton="false">
                        <br />设置系统启用之前各资金账户的余额
                        <br /><br />
                        <div align="center"><a class="mini-button mini-button-success" onclick="toFiSettleAccountBalanceSet()">设置期初现金银行</a></div>
                    </div>
                </td>
                <td>
                    <div class="mini-panel mini-panel-success" title="期初应收应付" width="350px"showCollapseButton="false" showCloseButton="false">
                        <br />设置系统启用之前供应商和客户的应收应付欠款余额
                        <br /><br />
                        <div align="center"><a class="mini-button mini-button-success" onclick="toRPBillSet()">设置期初应收应付</a></div>
                    </div>
                </td>
            </tr>
           
            <tr>
            	 <td>
                    <div class="mini-panel mini-panel-info" title="配件提成" width="350px" showCollapseButton="false" showCloseButton="false">
                        <br />设置配件提成，用于计算配件提成数据
                        <br /><br />
                        <div align="center"><a class="mini-button mini-button-success" onclick="toPartDeductSet()" >设置配件提成</a></div>
                    </div>
                </td>
                <td>
                    <div class="mini-panel mini-panel-info" title="公司属性" width="350px" showCollapseButton="false" showCloseButton="false">
                        <br />设置系统公司属性
                        <br /><br />
                        <div align="center"><a class="mini-button mini-button-success" onclick="toOrgSetSet()" >设置公司属性</a></div>
                    </div>
                </td>
            </tr>
            <!-- <tr>
                <td>
                    <div class="mini-panel mini-panel-info" title="维修班组" width="250px" showCollapseButton="false" showCloseButton="false">
                        <br />设置车间机电、钣金、喷漆维修班组
                        <br /><br />
                        <div align="center"><a class="mini-button mini-button-success" onclick="toTeamMainSet()" >设置维修班组</a></div>
                    </div>
                </td>
            </tr> -->
        </table>
    </div>
</body>
</html>
