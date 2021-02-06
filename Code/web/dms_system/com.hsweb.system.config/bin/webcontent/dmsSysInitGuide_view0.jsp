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
    <title>初始化导航</title>
    <script src="<%= request.getContextPath() %>/config/js/dmsSysInitGuide.js?v=1.2.2"></script>
    <style>
    	body{
			overflow:auto;
		}
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
    <div class="container" align="center">
        <table>
            <tr>
                <td>
                    <div class="mini-panel mini-panel-danger" title="业务参数" width="350px" showCollapseButton="false" showCloseButton="false">
                        <br />根据业务实际情况配置系统运行业务选项、业务处理控制参数
                        <br />
                        <br />
                        <div align="center">
                            <a class="mini-button mini-button-success" onclick="initSysParamsCfg()">设置系统参数</a>
                        </div>
                    </div>
                </td>
                <td>
                    <div class="mini-panel mini-panel-info" title="仓库设置" width="350px" showCollapseButton="false" showCloseButton="false">
                        <br />设置保管商品存货的实体仓库信息，也可以是零售门店或者废品虚拟仓库等
                        <br />
                        <br />
                        <div align="center">
                            <a class="mini-button mini-button-success" onclick="initComStoreCfg()">设置仓库</a>
                        </div>
                    </div>
                </td>
                <td>
                    <div class="mini-panel mini-panel-primary" title="配件分类" width="350px" showCollapseButton="false" showCloseButton="false">
                        <br />建立配件存货的分类，便于以后按分类查找、统计
                        <br />
                        <br />
                        <div align="center">
                            <a class="mini-button mini-button-success" onclick="initComPartTypeCfg()">设置配件分类</a>
                        </div>
                    </div>
                </td>
            </tr>
            <tr>
                <td>
                    <div class="mini-panel mini-panel-success" title="配件品牌" width="350px" showCollapseButton="false" showCloseButton="false">
                        <br />建立配件存货的品牌，便于以后按分类查找、统计
                        <br />
                        <br />
                        <div align="center">
                            <a class="mini-button mini-button-success" onclick="initComPartBrandCfg()">设置配件品牌</a>
                        </div>
                    </div>
                </td>
                <td>
                    <div class="mini-panel mini-panel-warning" title="期初库存" width="350px" showCollapseButton="false" showCloseButton="false">
                        <br />设置系统启用之前各仓库商品存货的结存数量和成本
                        <br />
                        <br />
                        <div align="center">
                            <a class="mini-button mini-button-success" onclick="initBeginPeriodStockCfg()">设置期初库存</a>
                        </div>
                    </div>
                </td>
                <td>
                    <div class="mini-panel mini-panel-info" title="品牌车型" width="350px" showCollapseButton="false" showCloseButton="false">
                        <br />管理维护汽车品牌、车系、车系数据
                        <br />
                        <br />
                        <div align="center">
                            <a class="mini-button mini-button-success" onclick="initCarBarndCfg()">设置品牌车型</a>
                        </div>
                    </div>
                </td>

            </tr>
            <tr>
                <td>
                    <div class="mini-panel mini-panel-success" title="保险公司" width="350px" showCollapseButton="false" showCloseButton="false">
                        <br />管理和维护保险公司
                        <br />
                        <br />
                        <div align="center">
                            <a class="mini-button mini-button-success" onclick="initInsuranceCompanyCfg()">设置保险公司</a>
                        </div>
                    </div>
                </td>
                <td>
                    <div class="mini-panel mini-panel-warning" title="出车报告" width="350px" showCollapseButton="false" showCloseButton="false">
                        <br />设置车辆维修出车报告模版，便于规范出车报告内容
                        <br />
                        <br />
                        <div align="center">
                            <a class="mini-button mini-button-success" onclick="initCheckReportCfg()">设置出车报告</a>
                        </div>
                    </div>
                </td>
                <td>
                    <div class="mini-panel mini-panel-warning" title="导入" width="350px" showCollapseButton="false" showCloseButton="false">
                        <br />导入功能通常只在系统初次使用时使用，导入完成后数据无法撤回
                        <br />
                        <br />
                        <div align="center">
                            <a class="mini-button mini-button-success" onclick="initImport()">导入功能</a>
                        </div>
                    </div>
                </td>
            </tr>
            <tr>
                <td>
                    <div class="mini-panel mini-panel-success" title="门店管理" width="350px" showCollapseButton="false" showCloseButton="false">
                        <br />管理和维护门店信息
                        <br />
                        <br />
                        <div align="center">
                            <a class="mini-button mini-button-success" onclick="companyMgr()">门店管理</a>
                        </div>
                    </div>
                </td>
                <td>
                    <div class="mini-panel mini-panel-warning" title="预约参数" width="350px" showCollapseButton="false" showCloseButton="false">
                        <br />设置预约时间，便于预约时间选择
                        <br />
                        <br />
                        <div align="center">
                            <a class="mini-button mini-button-success" onclick="appointmentMgr()">设置预约参数</a>
                        </div>
                    </div>
                </td>
                <td>
                    <div class="mini-panel mini-panel-warning" title="配件提成" width="350px" showCollapseButton="false" showCloseButton="false">
                        <br />设置配件提成，用于计算配件提成数据
                        <br />
                        <br />
                        <div align="center">
                            <a class="mini-button mini-button-success" onclick="partDeductMgr()">设置配件提成</a>
                        </div>
                    </div>
                </td>
            </tr>
            <tr>
                <td>
                    <div class="mini-panel mini-panel-danger" title="结算账户" width="350px" showCollapseButton="false" showCloseButton="false">
                        <br />设置经营活动中的各种结算账户，如现金、工行、建行、支付宝、微信等
                        <br />
                        <br />
                        <div align="center">
                            <a class="mini-button mini-button-success" onclick="initFiSettleAccountCfg()">设置结算账户</a>
                        </div>
                    </div>
                </td>
                <td>
                    <div class="mini-panel mini-panel-primary" title="期初现金银行" width="350px" showCollapseButton="false" showCloseButton="false">
                        <br />设置系统启用之前各资金账户的余额
                        <br />
                        <br />
                        <div align="center">
                            <a class="mini-button mini-button-success" onclick="initFiSettleAccountBalanceCfg()">设置期初现金银行</a>
                        </div>
                    </div>
                </td>
                <td>
                    <div class="mini-panel mini-panel-success" title="期初应收应付" width="350px" showCollapseButton="false" showCloseButton="false">
                        <br />设置系统启用之前供应商和客户的应收应付欠款余额
                        <br />
                        <br />
                        <div align="center">
                            <a class="mini-button mini-button-success" onclick="initRPBillCfg()">设置期初应收应付</a>
                        </div>
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
<!--               <tr>
                <td>
                    <div class="mini-panel mini-panel-info" title="导入工单信息" width="250px" showCollapseButton="false" showCloseButton="false">
                        <br />导入未跟换系统前的工单信息
                        <br /><br />
                        <div align="center"><a class="mini-button mini-button-success" onclick="importMaintain()" >导入工单信息</a></div>
                    </div>
                </td>
            </tr> -->
        </table>
    </div>
</body>

</html>