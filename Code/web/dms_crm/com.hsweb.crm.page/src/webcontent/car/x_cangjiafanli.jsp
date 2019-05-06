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
  <title>厂家返利</title>
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
              <td class="td_title">单据日期
              </td>
              <td>
                  <input id="txtStartDate" editable="false" name="StartDate" class="nui-datepicker"
                      style="width: 95px" />
                  -
                  <input id="txtEndDate" editable="false" name="EndDate" class="nui-datepicker" style="width: 95px"/>
              </td>
              <td class="td_title">单据编号
              </td>
              <td>
                  <input id="txtDocumentId" class="nui-textbox" style="width: 110px" />
              </td>
              <td class="td_title">返利厂家
              </td>
              <td>
                  <input id="txtUnitName" class="nui-combobox" style="width: 110px" />
              </td>
              <td class="td_title">经办人
              </td>
              <td>
                  <input id="txtDealMan" class="nui-combobox" style="width: 110px" />
              </td>
          </tr>
          <tr>
              <td align="right">组织机构
              </td>
              <td>
                  <input id="cmbOrgId" class="nui-combobox" style="width: 207px" editable="false" />
              </td>
              <td align="right">车型名称
              </td>
              <td>
                  <input id="txtAutoType" class="nui-textbox" style="width: 110px" />
              </td>
              <td align="right">返利政策
              </td>
              <td>
                  <input id="txtRebatePolicy" class="nui-combobox" type="text" style="width: 110px" />
              </td>
              <td colspan="2" align="right">
                  <a class="nui-button" plain="false" onclick="" id="" enabled="true"><span
                    class="fa fa-search fa-lg"></span>&nbsp;查找</a>
              </td>
              <td style="text-align: right"></td>
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
        <div field="" headerAlign="center" allowSort="true" width="100px">经办人</div>
        <div field="" headerAlign="center" allowSort="true" width="100px">厂家编号</div>
        <div field="" headerAlign="center" allowSort="true" width="100px">返利厂家</div>
        <div field="" headerAlign="center" allowSort="true" width="100px">返利政策</div>
        <div field="" headerAlign="center" allowSort="true" width="100px">数量</div>
        <div field="" headerAlign="center" allowSort="true" width="100px">金额（元） </div>
        <div field="" headerAlign="center" allowSort="true" width="100px">制单人</div>
        <div field="" headerAlign="center" allowSort="true" width="100px">制单时间</div>
        <div field="" headerAlign="center" allowSort="true" width="100px">组织机构</div>
        <div field="" headerAlign="center" allowSort="true" width="100px">备注</div>
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
        url: webPath + contextPath + '/page/car/x_cangjiafanli_edit.jsp',
        title: tit,
        width: '100%',
        height: '100%',
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