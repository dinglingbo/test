<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false" %>
    <!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
    <html>
    <!-- 
        - Author(s): Administrator
        - Date: 2019-05-05 14:52:47
        - Description:
        -->

    <head>
        <title>整车销售</title>
        <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
        <script src="<%= request.getContextPath() %>/common/nui/nui.js" type="text/javascript"></script>
        <%@include file="/common/commonRepair.jsp"%>
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
        
        .td_title {
            width: 65px;
            text-align: right;
        }
    </style>

    <body>
        <div class="nui-toolbar" style="padding:2px;border-bottom:0;">
            <a class="nui-button" iconCls="" plain="true" onclick="add()" id="addBtn"><span class="fa fa-plus fa-lg"></span>&nbsp;新增</a>
            <a class="nui-button" iconCls="" plain="true" onclick="edit()" id="addBtn"><span class="fa fa-edit fa-lg"></span>&nbsp;修改</a>
            <a class="nui-button" iconCls="" plain="true" onclick="del()" id="deletBtn"><span class="fa fa-remove fa-lg"></span>&nbsp;删除</a>
            <a class="nui-button" iconCls="" plain="true" onclick="onPrint()" id="onPrint"><span class="fa fa-print fa-lg"></span>&nbsp;打印</a>
        </div>
        <div style="padding-top: 5px">
            <table>
                <tr>
                    <td>
                        <input class="nui-combobox" id="DateType" name="DateType" editable="false" style="width: 90px;">
                    </td>
                    <td colspan="2">
                        <input id="txtStartDate" editable="false" name="StartDate" class="nui-datepicker" style="width: 95px" /> -
                        <input id="txtEndDate" editable="false" name="EndDate" class="nui-datepicker" style="width: 95px" />
                    </td>
                    <td style="width:60px;text-align:right">单据编号
                    </td>
                    <td>
                        <input id="txtDocumentId" name="Order_id" class="nui-textbox" style="width: 90px" />
                    </td>
                    <td class="td_title">客户姓名
                    </td>
                    <td>
                        <input id="txtCustName" name="txtUnitName" class="nui-textbox" style="width: 90px" />
                    </td>
                    <td class="td_title">车型名称
                    </td>
                    <td colspan="4">
                        <input id="txtAutotypeName" name="txtDealMan" class="nui-textbox" style="width: 100px" />
                    </td>
                </tr>
                <tr>
                    <td align="right">整车仓库
                    </td>
                    <td colspan="2">
                        <input id="cmbAutoStore" class="nui-combobox" style="width: 208px" data="cmbAutoStoreList" editable="false" />
                    </td>
                    <td style="width:50px;text-align:right">车身颜色
                    </td>
                    <td>
                        <input id="cmbAutoColor" class="nui-combobox" style="width: 90px" editable="false" />
                    </td>
                    <td align="right">车内饰色
                    </td>
                    <td>
                        <input id="cmbAutoSetcolor" class="nui-combobox" style="width: 90px" editable="false" />
                    </td>
                    <td align="right">购买方式
                    </td>
                    <td colspan="4">
                        <input id="cmbAutoBuyway" class="nui-combobox" style="width: 100px" editable="false" />
                    </td>


                </tr>
                <tr>
                    <td>
                        <input id="selType" class="nui-combobox" name="state" editable="false" style="width: 90px;">
                    </td>
                    <td colspan="2">
                        <input id="txtsel" class="nui-textbox" type="text" style="width: 80px" /> 业务员
                        <input id="cmbBusinessMan" class="nui-combobox" style="width: 80px" editable="false" />


                    </td>

                    <td align="right">组织机构
                    </td>
                    <td>
                        <input id="cmbOrganization" class="nui-combobox" style="width: 90px">
                    </td>
                    <td align="right">单据状态
                    </td>
                    <td>
                        <!--<input id="cmbDocumentState" class="nui-combobox" type="text" style="width: 80px" />-->
                        <input id="cmbDocumentState" class="nui-combobox" editable="false" style="width: 90px">
                    </td>
                    <td align="right">是否开票
                    </td>
                    <td>
                        <input id="cmbBillFlg" class="nui-combobox" name="state" editable="false">
                        <a class="nui-button" iconCls="" plain="true" onclick="onSearch"><span class="fa fa-search fa-lg"></span>&nbsp;查询</a>
                    </td>
                </tr>
            </table>
        </div>
        <div class="nui-fit">
            <div id="mainGrid" class="nui-datagrid" style="width:100%;height:100%;" selectOnLoad="true" showPager="true" pageSize="50" totalField="page.count" sizeList=[20,50,100,200] dataField="list" showModified="false" onrowdblclick="" allowCellSelect="true" editNextOnEnterKey="true"
                onshowrowdetail="onShowRowDetail" allowCellWrap="true" url="">
                <div property="columns">
                    <div type="indexcolumn">序号</div>
                    <div field="" name="" width="70px" headerAlign="center" header="单据编号"></div>
                    <div field="" name="" width="150px" headerAlign="center" header="单据日期"></div>
                    <div field="" name="" width="100px" headerAlign="center" header="单据状态"></div>
                    <div field="" name="" width="80px" headerAlign="center" header="客户编号"></div>
                    <div field="" name="" width="110px" headerAlign="center" header="客户名称"></div>
                    <div field="" name="" width="140px" headerAlign="center" header="联系人"></div>
                    <div field="" name="" width="100px" headerAlign="center" header="联系电话"></div>
                    <div field="" name="" width="100px" headerAlign="center" header="车牌号码"></div>
                    <div field="" name="" width="100px" headerAlign="center" header="车型编号"></div>
                    <div field="" name="" width="130px" headerAlign="center" header="车型名称"></div>
                    <div field="" name="" width="90px" headerAlign="center" header="汽车品牌"></div>
                    <div field="" name="" width="90px" headerAlign="center" header="车辆类型"></div>
                    <div field="" name="" width="80px" headerAlign="center" header="颜色"></div>
                    <div field="" name="" width="100px" headerAlign="center" header="车内饰色"></div>
                    <div field="" name="" width="100px" headerAlign="center" header="VIN码"></div>
                    <div field="" name="" width="100px" headerAlign="center" header="发动机号"></div>
                    <div field="" name="" width="100px" headerAlign="center" header="预交车日期"></div>
                    <div field="" name="" width="100px" headerAlign="center" header="交车日期"></div>
                    <div field="" name="" width="100px" headerAlign="center" header="交车人"></div>
                    <div field="" name="" width="100px" headerAlign="center" header="交车备注"></div>
                    <div field="" name="" width="100px" headerAlign="center" header="购车方式"></div>
                    <div field="" name="" width="100px" headerAlign="center" header="开票客户"></div>
                    <div field="" name="" width="100px" headerAlign="center" header="结算类型"></div>
                    <div field="" name="" width="100px" headerAlign="center" header="是否开票"></div>
                    <div field="" name="" width="100px" headerAlign="center" header="票据类型"></div>
                    <div field="" name="" width="100px" headerAlign="center" header="发票号码"></div>
                    <div field="" name="" width="100px" headerAlign="center" header="合同编号"></div>
                    <div field="" name="" width="100px" headerAlign="center" header="指导销价"></div>
                    <div field="" name="" width="100px" headerAlign="center" header="成交车价"></div>
                    <div field="" name="" width="100px" headerAlign="center" header="代办金额"></div>
                    <div field="" name="" width="100px" headerAlign="center" header="让利金额"></div>
                    <div field="" name="" width="100px" headerAlign="center" header="装潢金额"></div>
                    <div field="" name="" width="100px" headerAlign="center" header="应收金额"></div>
                    <div field="" name="" width="100px" headerAlign="center" header="实收金额"></div>
                    <div field="" name="" width="100px" headerAlign="center" header="欠款金额"></div>
                    <div field="" name="" width="100px" headerAlign="center" header="业务员"></div>
                    <div field="" name="" width="100px" headerAlign="center" header="制单人"></div>
                    <div field="" name="" width="100px" headerAlign="center" header="制单时间"></div>
                    <div field="" name="" width="100px" headerAlign="center" header="组织机构"></div>
                    <div field="" name="" width="100px" headerAlign="center" header="结算备注"></div>
                    <div field="" name="" width="100px" headerAlign="center" header="单据备注"></div>
                    <div field="" name="" width="100px" headerAlign="center" header="手机号码"></div>
                    <div field="" name="" width="100px" headerAlign="center" header="传真号码"></div>
                    <div field="" name="" width="100px" headerAlign="center" header="电子邮箱"></div>
                    <div field="" name="" width="100px" headerAlign="center" header="合格证号"></div>
                    <div field="" name="" width="100px" headerAlign="center" header="商检单号"></div>
                    <div field="" name="" width="100px" headerAlign="center" header="关单号"></div>
                    <div field="" name="" width="100px" headerAlign="center" header="钥匙号"></div>
                    <div field="" name="" width="100px" headerAlign="center" header="出厂日期"></div>
                    <div field="" name="" width="100px" headerAlign="center" header="车辆仓库"></div>
                    <div field="" name="" width="100px" headerAlign="center" header="提单号"></div>
                    <div field="" name="" width="100px" headerAlign="center" header="生产日期"></div>
                    <div field="" name="" width="100px" headerAlign="center" header="上市日期"></div>
                    <div field="" name="" width="100px" headerAlign="center" header="车体结构"></div>
                    <div field="" name="" width="100px" headerAlign="center" header="车辆级别"></div>
                    <div field="" name="" width="100px" headerAlign="center" header="变速箱"></div>
                    <div field="" name="" width="100px" headerAlign="center" header="排量"></div>
                    <div field="" name="" width="100px" headerAlign="center" header="驱动方式"></div>
                    <div field="" name="" width="100px" headerAlign="center" header="是否进口"></div>
                    <div field="" name="" width="100px" headerAlign="center" header="座位数"></div>
                    <div field="" name="" width="100px" headerAlign="center" header="车型备注"></div>
                </div>
            </div>
        </div>
        <script type="text/javascript">
            nui.parse();
        </script>
    </body>

    </html>