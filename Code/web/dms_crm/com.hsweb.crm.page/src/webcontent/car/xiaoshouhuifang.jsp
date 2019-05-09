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
  <title>销售回访</title>
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
    <table>
      <tr>
        <td class="td_title"><select id="cmbDateType" editable="false" class="nui-combobox" style="width: 85px">
            <option value="">--全部--</option>
            <option value="回访日期">回访日期</option>
            <option value="单据日期" selected="selected">单据日期</option>
          </select>
        </td>
        <td>
          <input id="txtStartDate" class="nui-datepicker" style="width: 95px" />
          -
          <input id="txtEndDate" class="nui-datepicker" style="width: 95px" />
        </td>
        <td align="right">单据编号
        </td>
        <td>
          <input id="txtDocumentId" class="nui-textbox" style="width: 140px" />
        </td>
        <td class="td_title">客户名称
        </td>
        <td>
          <input id="txtCustName" class="nui-textbox" style="width: 140px" />
        </td>
      </tr>
      <tr>
        <td align="right">车型名称
        </td>
        <td>
          <input id="txtCarSort" class="nui-textbox" style="width: 218px" />
        </td>
        <td align="right"><select id="cmbOther" editable="false" class="nui-combobox" style="width: 70px">
            <option value="LinkMan" selected="selected">联系人</option>
            <option value="Phone">联系电话</option>
            <option value="VIN">VIN码</option>
          </select>
        </td>
        <td>
          <input id="txtOther" class="nui-textbox" style="width: 140px" />
        </td>
        <td align="right">业务员
        </td>
        <td>
          <input id="cmbBusinessMan" class="nui-combobox" style="width: 140px" />
        </td>
        <td colspan="2" align="right"></select> <a class="nui-button" plain="false" onclick="" id=""
            enabled="true"><span class="fa fa-search fa-lg"></span>&nbsp;查找</a>
        </td>
      </tr>
      <tr>
        <td align="right">组织机构
        </td>
        <td>
          <select id="cmbOrganization" name="cmbOrganization" class="nui-combobox" style="width: 218px">
          </select>
        </td>
        <td colspan="8">
          <a class="nui-button" plain="true" onclick="" id="" enabled="true">今天</a>
          <a class="nui-button" plain="true" onclick="" id="" enabled="true">明天</a>
          <a class="nui-button" plain="true" onclick="" id="" enabled="true">后天</a>
          <a class="nui-button" plain="true" onclick="" id="" enabled="true">三天内</a>
          <a class="nui-button" plain="true" onclick="" id="" enabled="true">五天内</a>
          <a class="nui-button" plain="true" onclick="" id="" enabled="true">七天内</a>
          <a class="nui-button" plain="true" onclick="" id="" enabled="true">十天内</a>
          <a class="nui-button" plain="true" onclick="" id="" enabled="true">本月</a>
          <a class="nui-button" plain="true" onclick="" id="" enabled="true">下月</a>
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
            <div field="" headerAlign="center" allowSort="true" width="100px">单据编号</div>
            <div field="" headerAlign="center" allowSort="true" width="100px">单据日期</div>
            <div field="" headerAlign="center" allowSort="true" width="100px">回访日期</div>
            <div field="" headerAlign="center" allowSort="true" width="100px">单据状态</div>
            <div field="" headerAlign="center" allowSort="true" width="100px">业务员</div>
            <div field="" headerAlign="center" allowSort="true" width="100px">客户编号</div>
            <div field="" headerAlign="center" allowSort="true" width="100px">客户名称</div>
            <div field="" headerAlign="center" allowSort="true" width="100px">联系人</div>
            <div field="" headerAlign="center" allowSort="true" width="100px">联系电话</div>
            <div field="" headerAlign="center" allowSort="true" width="100px">车型编号</div>
            <div field="" headerAlign="center" allowSort="true" width="100px">车型名称</div>
            <div field="" headerAlign="center" allowSort="true" width="100px">汽车品牌</div>
            <div field="" headerAlign="center" allowSort="true" width="100px">车辆类型</div>
            <div field="" headerAlign="center" allowSort="true" width="100px">颜色</div>
            <div field="" headerAlign="center" allowSort="true" width="100px">车内饰色</div>
            <div field="" headerAlign="center" allowSort="true" width="100px">VIN码</div>
            <div field="" headerAlign="center" allowSort="true" width="100px">发动机号</div>
            <div field="" headerAlign="center" allowSort="true" width="100px">交车日期</div>
            <div field="" headerAlign="center" allowSort="true" width="100px">交车人</div>
            <div field="" headerAlign="center" allowSort="true" width="100px">交车备注</div>
            <div field="" headerAlign="center" allowSort="true" width="100px">购车方式</div>
            <div field="" headerAlign="center" allowSort="true" width="100px">开票客户</div>
            <div field="" headerAlign="center" allowSort="true" width="100px">结算类型</div>
            <div field="" headerAlign="center" allowSort="true" width="100px">是否开票</div>
            <div field="" headerAlign="center" allowSort="true" width="100px">票据类型</div>
            <div field="" headerAlign="center" allowSort="true" width="100px">发票号码</div>
            <div field="" headerAlign="center" allowSort="true" width="100px">合同编号</div>
            <div field="" headerAlign="center" allowSort="true" width="100px">成交车价</div>
            <div field="" headerAlign="center" allowSort="true" width="100px">代办金额</div>
            <div field="" headerAlign="center" allowSort="true" width="100px">让利金额</div>
            <div field="" headerAlign="center" allowSort="true" width="100px">装潢金额</div>
            <div field="" headerAlign="center" allowSort="true" width="100px">应收金额</div>
            <div field="" headerAlign="center" allowSort="true" width="100px">实收金额</div>
            <div field="" headerAlign="center" allowSort="true" width="100px">欠款金额</div>
            <div field="" headerAlign="center" allowSort="true" width="100px">经办人</div>
            <div field="" headerAlign="center" allowSort="true" width="100px">制单人</div>
            <div field="" headerAlign="center" allowSort="true" width="100px">制单时间</div>
            <div field="" headerAlign="center" allowSort="true" width="100px">组织机构</div>
          </div>
        </div>
      </div>
      <div title="回访记录" region="east" showCloseButton="false" showSplitIcon="true" width="300">
          <div class="nui-toolbar">
          <a class="nui-button" plain="true" onclick="edit(1)" id="" plain="false"><span class="fa fa-plus fa-lg"></span>&nbsp;新增</a>
        <a class="nui-button" plain="true" onclick="edit(2)" id="" enabled="true"><span  class="fa fa-edit fa-lg"></span>&nbsp;修改</a>
        <a class="nui-button" plain="true" onclick="" id="" enabled="true"><span  class="fa fa-close fa-lg"></span>&nbsp;删除</a>
          <a class="nui-button" iconCls="" plain="true" onclick="onCancel()"><span class="fa fa-check fa-lg"></span>&nbsp;审核</a>
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