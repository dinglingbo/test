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
  </style>
</head>

<body>
  <div class="nui-toolbar">
      <table cellpadding="0" cellspacing="0" style="line-height: 27px; padding-top: 4px; padding-left: 0px;">
          <tr>
              <td class="td_title">单据编号
              </td>
              <td>
                  <input id="txtDocumentId" value="自动编号" style="width: 130px" disabled class="nui-textbox" />
              </td>
              <td class="td_title">返利日期
              </td>
              <td>
                  <input id="txtDocumentDate" editable="false" style="width: 95px" class="nui-datepicker" />
              </td>

              <td class="td_title">厂家名称
              </td>
              <td colspan="3">
                  <input id="cmbUnitName" class="nui-combobox" style="width: 200px" >
                  </input>
              </td>
          </tr>
          <tr>
              <td class="td_title" style="text-align: right">经办人
              </td>
              <td>
                  <input class="nui-combobox" id="cmbDealMan" style="width: 130px;" validtype="equals" />
              </td>
              <td style="text-align: right">返利政策
              </td>
              <td colspan="3">
                  <input class="nui-combobox" editable="false" id="cmbRebatePolicy" style="width: 360px;" />
              </td>
          </tr>
          <tr>
              <td style="text-align: right">备注
              </td>
              <td colspan="5">
                  <input id="txtRemark" style="width: 555px; height: 40px" class="nui-textarea" multiline="true" />
              </td>
          </tr>
      </table>
  </div>

  <div class="nui-fit">

    <div id="layout1" class="nui-layout" style="width:100%;height:100%;">
      <div title="center" region="center">
        <div id="business" dataField="list" class="nui-datagrid" style="width: 100%; height: 100%;" multiSelect="false"
          pageSize="20" pageList='[10,20,50,100]' showPageInfo="true" selectOnLoad="true" onDrawCell=""
          onselectionchanged="" allowSortColumn="false" totalField="page.count">
          <div property="columns">
            <div type="indexcolumn" headerAlign="center" width="60px">序号</div>
            <div type="checkcolumn" class="mini-radiobutton" width="60px">选择</div>
            <div field="" headerAlign="center" allowSort="true" width="100px">整车编号</div>
            <div field="" headerAlign="center" allowSort="true" width="100px">VIN码</div>
            <div field="" headerAlign="center" allowSort="true" width="100px">车型名称</div>
            <div field="" headerAlign="center" allowSort="true" width="100px">销售单号</div>
            <div field="" headerAlign="center" allowSort="true" width="100px">销售日期</div>
            <div field="" headerAlign="center" allowSort="true" width="100px">客户名称</div>
            <div field="" headerAlign="center" allowSort="true" width="100px">业务员</div>
            <div field="" headerAlign="center" allowSort="true" width="100px">指导销价</div>
            <div field="" headerAlign="center" allowSort="true" width="100px">成交金额</div>
            <div field="" headerAlign="center" allowSort="true" width="100px">进货日期</div>
            <div field="" headerAlign="center" allowSort="true" width="100px">进价</div>
            <div field="" headerAlign="center" allowSort="true" width="100px">返利金额</div>
            <div field="" headerAlign="center" allowSort="true" width="100px">备注</div>
          </div>
        </div>
      </div>
      <div title="回访记录" region="east" showCloseButton="false" showSplitIcon="true" width="400">
          <div class="nui-toolbar">
          <a class="nui-button" iconCls="" plain="true" onclick="onCancel()"><span class="fa fa-check fa-lg"></span>&nbsp;确定</a>
        </div>
        <table style="width: 100%; line-height: 22px">
            <tr>
                <td class="td_title">查询条件
                </td>
                <td colspan="3">
                    <input id="cmbTXM" disabled style="width: 305px" class="nui-combobox">
                    </input>
                </td>
            </tr>
            <tr>
                <td align="right">车型名称
                </td>
                <td colspan="3">
                    <input id="txtAutotypeName" class="nui-textbox" disabled style="width: 305px" />
                </td>
            </tr>
            <tr>
                <td align="right">VIN码
                </td>
                <td colspan="3">
                    <input id="txtVIN" class="nui-textbox" disabled style="width: 305px" />
                </td>
            </tr>
            <tr>
                <td align="right">整车编号
                </td>
                <td>
                    <input id="txtAutoID" class="nui-textbox" disabled style="width: 113px" />
                </td>
                <td align="right">客户名称
                </td>
                <td>
                    <input id="txtCustName" class="nui-textbox" disabled style="width: 102px" />
                </td>
            </tr>
            <tr>
                <td align="right">销售单号
                </td>
                <td>
                    <input id="txtSailId" class="nui-textbox" disabled style="width: 113px" />
                </td>
                <td align="right">业务员
                </td>
                <td>
                    <input id="txtBusinessMan" class="nui-textbox" disabled style="width: 102px" />
                </td>
            </tr>
            <tr>

                <td align="right">销售日期
                </td>
                <td>
                    <input id="txtSailDate" class="nui-textbox" disabled style="width: 113px" />
                </td>
                <td align="right">成交金额
                </td>
                <td>
                    <input id="txtSettleMoney" numbertype="Money" min="0" disabled class="nui-textbox " style="width: 102px;" />
                </td>
            </tr>
            <tr>
                <td align="right">进货日期
                </td>
                <td>
                    <input id="txtPurchaseDate" class="nui-textbox" disabled style="width: 113px" />
                </td>
                <td align="right">进价
                </td>
                <td>
                    <input id="txtPurchasePrice" numbertype="Money" min="0" disabled class="nui-textbox " style="width: 102px;" />
                </td>
            </tr>
            <tr>
                <td align="right">指导销价
                </td>
                <td>
                    <input id="txtSailPrice" numbertype="Money" min="0" disabled class="nui-textbox " style="width: 113px;" />
                </td>
                <td align="right">返利金额
                </td>
                <td>
                    <input id="txtRebateMoney"  min="0" class="nui-textbox " style="width: 102px; "  />
                </td>
            </tr>
            <tr>
                <td align="right">备注
                </td>
                <td colspan="3">
                    <input id="txtDocumentRemark" class="nui-textarea"  style="width: 305px; height: 50px" />
                </td>
            </tr>
        </table>
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
        onload: function () {
          var iframe = this.getIFrameEl();
          iframe.contentWindow.setData(row);
        },
        ondestroy: function (action) {
          visitHis.reload();
        }
      });
    }
  </script>
</body>

</html>