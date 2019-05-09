<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false" %>

    <!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
    <html>
    <!-- 
  - Author(s): Administrator
  - Date: 2019-05-06 08:54:19
  - Description:
-->

    <head>
        <title>客户信息</title>
        <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
        <script src="<%= request.getContextPath() %>/common/nui/nui.js" type="text/javascript"></script>
        <%@include file="/common/commonRepair.jsp"%>
    </head>
    <style type="text/css">
        .td_title {
            width: 75px;
            text-align: right;
        }
        
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
        <div class="nui-toolbar" style="padding:0px;border-bottom:0;">
            <a class="nui-button" iconCls="" plain="true" onclick="finish()" id="addBtn"><span class="fa fa-check fa-lg"></span>&nbsp;选中</a>
            <a class="nui-button" iconCls="" plain="true" onclick="add()" id="addBtn"><span class="fa fa-plus fa-lg"></span>&nbsp;新增</a>
            <a class="nui-button" iconCls="" plain="true" onclick="edit()" id="addBtn"><span class="fa fa-edit fa-lg"></span>&nbsp;修改</a>
            <a class="nui-button" iconCls="" plain="true" onclick="del()" id="deletBtn"><span class="fa fa-remove fa-lg"></span>&nbsp;删除</a>
            <a class="nui-button" iconCls="" plain="true" onclick="onExport()" id="exportBtn"><span class="fa fa-level-up fa-lg"></span>&nbsp;导出</a>
        </div>
        <table>
            <tr>
                <td class="td_title">客户编号
                </td>
                <td>
                    <input id="txtCustId" name="ProductNum" type="text" class="nui-textbox" />
                </td>
                <td class="td_title">客户名称
                </td>
                <td>
                    <input id="txtCustName" class="nui-textbox" />
                </td>
                <td class="td_title">拼音码
                </td>
                <td>
                    <input id="txtCustCode" name="ProductCode" type="text" class="nui-textbox" />
                </td>
                <td></td>
            </tr>
            <tr>
                <td align="right">客户地区
                </td>
                <td>
                    <input class="nui-combobox" id="txtcust_area" />
                </td>
                <td>
                    <input id="txtSearchSort" class="nui-combobox">
                </td>
                <td>
                    <input id="txtSearch" name="searchsortValue" class="nui-textbox" />
                </td>
                <td align="right">客户性质
                </td>
                <td>
                    <select id="txtcust_nature" class="nui-combobox">
                </td>
                <td style="text-align: right">
                        <a class="nui-button" iconCls="" plain="true" onclick="onSearch"><span class="fa fa-search fa-lg"></span>&nbsp;查找</a>
                </td>
            </tr>
        </table>
        <div class="nui-fit">
            <div id="layout1" class="nui-layout" style="width:100%;height:100%;">
                <div title="客户类别" region="west">
                    
                </div>
                <div title="center" region="center">
                        <div id="mainGrid" class="nui-datagrid" style="width:100%;height:100%;" selectOnLoad="true" showPager="true" pageSize="50" totalField="page.count" sizeList=[20,50,100,200] dataField="list" showModified="false" onrowdblclick="" allowCellSelect="true" editNextOnEnterKey="true"
                        onshowrowdetail="onShowRowDetail" allowCellWrap="true" url="">
                        <div property="columns">
                            <div type="indexcolumn">序号</div>
                            <div field="" name="" width="70px" headerAlign="center" header="客户编号"></div>
                            <div field="" name="" width="150px" headerAlign="center" header="客户名称"></div>
                            <div field="" name="" width="100px" headerAlign="center" header="客户类别"></div>
                            <div field="" name="" width="80px" headerAlign="center" header="地区"></div>
                            <div field="" name="" width="110px" headerAlign="center" header="客户性质"></div>
                            <div field="" name="" width="110px" headerAlign="center" header="拼音码"></div>
                            <div field="" name="" width="110px" headerAlign="center" header="联系人"></div>
                            <div field="" name="" width="110px" headerAlign="center" header="性别"></div>
                            <div field="" name="" width="110px" headerAlign="center" header="出生日期"></div>
                            <div field="" name="" width="110px" headerAlign="center" header="电话号码"></div>
                            <div field="" name="" width="110px" headerAlign="center" header="手机号码"></div>
                            <div field="" name="" width="110px" headerAlign="center" header="备用号码"></div>
                            <div field="" name="" width="110px" headerAlign="center" header="传真号码"></div>
                            <div field="" name="" width="110px" headerAlign="center" header="电子邮件"></div>
                            <div field="" name="" width="110px" headerAlign="center" header="邮政编码"></div>
                            <div field="" name="" width="110px" headerAlign="center" header="联系地址"></div>
                            <div field="" name="" width="110px" headerAlign="center" header="开户行"></div>
                            <div field="" name="" width="110px" headerAlign="center" header="银行账号"></div>
                            <div field="" name="" width="110px" headerAlign="center" header="税号"></div>
                            <div field="" name="" width="110px" headerAlign="center" header="结算公式"></div>
                            <div field="" name="" width="110px" headerAlign="center" header="开票名称"></div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <script type="text/javascript">
            nui.parse();
            
            function add(){
                nui.open({
                    url: webPath + contextPath + "/page/carSales/editCustInfo.jsp?token=" + token,
                    title: "编辑客户信息",
                    width: "600px",
                    height: "360px",
                    onload: function() {
                        var iframe = this.getIFrameEl();
                    },
                    ondestroy: function(action) {

                    }
                });
            }
        </script>
    </body>

    </html>