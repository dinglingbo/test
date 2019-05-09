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
                allowCellWrap="true" url="">
                <div property="columns">
                    <div type="indexcolumn">序号</div>
                    <div field="" name="" width="100px" headerAlign="center" header="工单号"></div>
                    <div field="" name="" width="100px" headerAlign="center" header="状态"></div>
                    <div field="" name="" width="100px" headerAlign="center" header="客户名称"></div>
                    <div field="" name="" width="100px" headerAlign="center" header="订车日期"></div>
                    <div field="" name="" width="100px" headerAlign="center" header="车型名称"></div>
                    <div field="" name="" width="100px" headerAlign="center" header="预交车日期"></div>
                    <div field="" name="" width="100px" headerAlign="center" header="销售顾问"></div>
                    <div field="" name="" width="100px" headerAlign="center" header="车辆销价"></div>
                    <div field="" name="" width="100px" headerAlign="center" header="应收定金"></div>
                    <div field="" name="" width="100px" headerAlign="center" header="已收定金"></div>
                    <div field="" name="" width="100px" headerAlign="center" header="应收余款"></div>
                </div>
            </div>
        </div>
        <script type="text/javascript">
            nui.parse();
        </script>
    </body>

    </html>