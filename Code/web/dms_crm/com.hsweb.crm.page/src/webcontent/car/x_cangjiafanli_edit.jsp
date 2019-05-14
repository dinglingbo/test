<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false" %>

    <!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
    <html>
    <!-- 
  - Author(s): Administrator
  - Date: 2019-05-05 14:49:39
  - Description:
-->

    <head>
        <title>厂家返利编辑</title>
        <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
        <script src="<%= request.getContextPath() %>/common/nui/nui.js" type="text/javascript"></script>
        <%@include file="/common/commonRepair.jsp"%>
            <style>
                html,
                body { 
                    margin: 0px; 
                    padding: 0px;
                    border: 0px;
                    width: 100%;
                    height: 100%;
                    overflow: hidden;
                }
                .td_title{
                    width:6%;
                    text-align:right;
                }
                .td_ctrl{
                    width:13%;
                }
            </style>
    </head>

    <body>
        <div class="nui-toolbar">
                <a class="nui-button" iconCls="" plain="true" onclick="del()" id="deletBtn"><span class="fa fa-save fa-lg"></span>&nbsp;保存</a>
            </div>
            <table cellpadding="0" cellspacing="0" style="padding:5px 20px;">
                <tr style="height: 35px;">
                    <td class="td_title">单据编号：
                    </td>
                    <td class="td_ctrl">
                        <input id="txtDocumentId" value="自动编号" style="width: 100%" disabled class="nui-textbox" />
                    </td>
                    <td class="td_title">返利日期：
                    </td>
                    <td class="td_ctrl">
                        <input id="txtDocumentDate" editable="false" style="width: 100%" class="nui-datepicker" />
                    </td>

                    <td class="td_title">厂家名称：
                    </td>
                    <td class="td_ctrl">
                        <input id="cmbUnitName" class="nui-combobox" style="width: 100%"></input>
                    </td>
                    <td class="td_title" style="text-align: right">经办人：
                        </td>
                        <td  class="td_ctrl">
                            <input class="nui-combobox" id="cmbDealMan" style="width: 100%;" validtype="equals" />
                        </td>
                </tr>
                 <tr style="height: 35px;">
                    <td style="text-align: right">返利政策：
                    </td>
                    <td >
                        <input class="nui-combobox" editable="false" id="cmbRebatePolicy" style="width: 100%;" />
                    </td>
               
                    <td style="text-align: right">备注：
                    </td>
                    <td colspan="5">
                        <input id="txtRemark" style="width: 100%; " class="nui-textbox" multiline="true" />
                    </td>
                </tr> 
            </table>

        <div class="nui-fit">

                <div class="nui-splitter" vertical="false" style="width:100%;height:100%;">
                        <div size="30%" showCollapseButton="true">

                                <div id="business" dataField="list" class="nui-datagrid" style="width: 100%; height: 100%;" multiSelect="false" pageSize="20" pageList='[10,20,50,100]' showPageInfo="true" selectOnLoad="true" onDrawCell="" onselectionchanged="" allowSortColumn="false"
                                totalField="page.count">
                                <div property="columns">
                                    <div type="checkcolumn" ></div>    
                                    <div type="indexcolumn" headerAlign="center" width="60px">序号</div>
                                    <div field="" headerAlign="center" allowSort="true" width="100px">整车编号</div>
                                    <div field="" headerAlign="center" allowSort="true" width="100px">车架号(VIN)</div>
                                    <div field="" headerAlign="center" allowSort="true" width="100px">车型名称</div>
                                </div>
                            </div>

                        </div>
                        <div showCollapseButton="true">
                            

            <div id="business" dataField="list" class="nui-datagrid" style="width: 100%; height: 100%;" multiSelect="false" pageSize="20" pageList='[10,20,50,100]' showPageInfo="true" selectOnLoad="true" onDrawCell="" onselectionchanged="" allowSortColumn="false"
                totalField="page.count">
                <div property="columns">
                    <div type="indexcolumn" headerAlign="center" width="60px">序号</div>
                    <div field="" headerAlign="center" allowSort="true" width="100px">整车编号</div>
                    <div field="" headerAlign="center" allowSort="true" width="100px">车架号(VIN)</div>
                    <div field="" headerAlign="center" allowSort="true" width="100px">车型名称</div>
                    <div field="" headerAlign="center" allowSort="true" width="100px">进货日期</div>
                    <div field="" headerAlign="center" allowSort="true" width="100px">进价</div>
                    <div field="" headerAlign="center" allowSort="true" width="100px">返利金额</div>
                    <div field="" headerAlign="center" allowSort="true" width="100px">备注</div>
                    <div field="" headerAlign="center" allowSort="true" width="100px">操作</div>
                </div>
            </div>
        </div>        
    </div>
        </div>
        <script type="text/javascript">
            nui.parse();

            function edit(e) {
                var tit = null;
                if (e == 1) {
                    tit = '新增';
                } else {
                    tit = '修改';
                }
                nui.open({
                    url: webPath + contextPath + '/page/car/xiaoshouhuifang_det.jsp',
                    title: tit,
                    width: 380,
                    height: 250,
                    onload: function() {
                        var iframe = this.getIFrameEl();
                        iframe.contentWindow.setData(row);
                    },
                    ondestroy: function(action) {
                        visitHis.reload();
                    }
                });
            }
        </script>
    </body>

    </html>