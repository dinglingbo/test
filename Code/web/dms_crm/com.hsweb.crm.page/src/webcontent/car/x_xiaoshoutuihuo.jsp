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
  <title>销售退货</title>
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
  <div class="nui-toolbar" style="border-bottom:0px;">
    <a class="nui-button" plain="true" onclick="edit(1)" id="" plain="false"><span
        class="fa fa-plus fa-lg"></span>&nbsp;新增</a>
    <a class="nui-button" plain="true" onclick="edit(2)" id="" enabled="true"><span
        class="fa fa-edit fa-lg"></span>&nbsp;修改</a>
    <a class="nui-button" plain="true" onclick="" id="" enabled="true"><span
        class="fa fa-close fa-lg"></span>&nbsp;删除</a>
  </div>
  <div class="nui-toolbar">
     <table>
                <tr>
                    <td class="td_title">制单日期
                    </td>
                    <td>
                        <input id="txtStartDate" name="StartDate" editable="false" class="nui-datepicker"
                            style="width: 95px" />
                        -
                        <input id="txtEndDate" name="EndDate" editable="false" class="nui-datepicker" style="width: 95px" />
                    </td>
                    <td class="td_title">单据编号
                    </td>
                    <td>
                        <input id="txtDocumentID" name="DocumentID" class="nui-textbox" style="width: 110px" />
                    </td>
                    <td class="td_title">客户名称
                    </td>
                    <td>
                        <input id="txtCustName" name="ProvideUnit" class="nui-textbox" style="width: 110px" />
                    </td>
                    <td class="td_title">经办人
                    </td>
                    <td>
                        <input id="cmbDealMan" class="nui-combobox" style="width: 110px" />
                    </td>
                </tr>
                <tr>
                    <td align="right">组织机构
                    </td>
                    <td>
                        <input id="cmbOrg" name="lilink_mannkman" class="nui-combobox" style="width: 205px"
                            editable="false" />
                    </td>
                    <td align="right">整车仓库
                    </td>
                    <td>
                        <input id="cmbAutoStore" class="nui-combobox" style="width: 110px" editable="false" />
                    </td>
                    <td align="right">车型名称
                    </td>
                    <td>
                        <input id="txtAutoTypeName" class="nui-textbox" style="width: 110px" />
                    </td>
                    <td align="right">
                        <select id="cmbMult" class="nui-combobox" name="state"  style="width: 70px;">
                            <option value="VIN">VIN码</option>
                            <option value="AutoTypeId">车型编号</option>
                            <option value="LinkMan">联系人</option>
                            <option value="Phone">联系电话</option>
                        </select>
                    </td>
                    <td>
                        <input id="txtMult" class="nui-textbox" type="text" style="width: 110px" />
                    </td>
                    <td colspan="2" align="right">
                        <a class="nui-button" plain="false" onclick="" id="" enabled="true"><span
                          class="fa fa-search fa-lg"></span>&nbsp;查找</a>
                    </td>
                </tr>
            </table>
  </div>
  <div class="nui-fit">
    <div id="business" dataField="list" class="nui-datagrid" style="width: 100%; height: 100%;" multiSelect="false"
      pageSize="20" pageList='[10,20,50,100]' showPageInfo="true" selectOnLoad="true" onDrawCell=""
      onselectionchanged="" allowSortColumn="false" totalField="page.count">
      <div property="columns">
        <div type="indexcolumn" headerAlign="center" width="60px">序号</div>
        <div type="checkcolumn" class="mini-radiobutton" width="60px">选择</div>
        <div field="" headerAlign="center" allowSort="true" width="100px">单据编号</div>
        <div field="" headerAlign="center" allowSort="true" width="100px">单据日期</div>
        <div field="" headerAlign="center" allowSort="true" width="100px">销售单号</div>
        <div field="" headerAlign="center" allowSort="true" width="100px">经办人</div>
        <div field="" headerAlign="center" allowSort="true" width="100px">客户名称</div>
        <div field="" headerAlign="center" allowSort="true" width="100px">联系人</div>
        <div field="" headerAlign="center" allowSort="true" width="100px">联系电话</div>
        <div field="" headerAlign="center" allowSort="true" width="100px">车型编号</div>
        <div field="" headerAlign="center" allowSort="true" width="100px">车型名称</div>
        <div field="" headerAlign="center" allowSort="true" width="100px">支付方式</div>
        <div field="" headerAlign="center" allowSort="true" width="100px">票据类型</div>
        <div field="" headerAlign="center" allowSort="true" width="100px">发票号码</div>
        <div field="" headerAlign="center" allowSort="true" width="100px">退货原因</div>
        <div field="" headerAlign="center" allowSort="true" width="100px">应收金额</div>
        <div field="" headerAlign="center" allowSort="true" width="100px">已收金额</div>
        <div field="" headerAlign="center" allowSort="true" width="100px">退款金额</div>
        <div field="" headerAlign="center" allowSort="true" width="100px">备注</div>
        <div field="" headerAlign="center" allowSort="true" width="100px">组织机构</div>
        <div field="" headerAlign="center" allowSort="true" width="100px">制单人</div>
        <div field="" headerAlign="center" allowSort="true" width="100px">制单时间</div>
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
        url: webPath + contextPath + '/page/car/x_xiaoshoutuihuo_det.jsp',
        title: tit,
        width: 580,
        height: 350,
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