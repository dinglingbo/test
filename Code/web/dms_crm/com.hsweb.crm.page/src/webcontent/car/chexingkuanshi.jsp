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
  <title>车型款式</title>
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
        <td class="td_title">车型编号
        </td>
        <td>
          <input id="txtTypeId" class="nui-textbox" type="text" style="width: 110px" />
        </td>
        <td class="td_title">车型名称
        </td>
        <td>
          <input id="txtTypeName" class="nui-textbox" type="text" style="width: 110px" />
        </td>
        <td class="td_title">拼音码
        </td>
        <td>
          <input id="txtTypeCode" class="nui-textbox" type="text" style="width: 140px" />
        </td>
        <td class="td_title">上市日期
        </td>
        <td colspan="3">
          <input id="txtStartDate" class="nui-datepicker" editable="false" style="width: 95px" />
          -
          <input id="txtEndDate" class="nui-datepicker" editable="false" style="width: 95px" />
        </td>
      </tr>
      <tr>
        <td class="td_title">产地
        </td>
        <td>
          <input id="cmbProduceHome" class="nui-combobox" style="width: 110px;">
          </input>
        </td>
        <td class="td_title">汽车品牌
        </td>
        <td>
          <input id="txtCarBrand" class="nui-textbox" style="width: 110px" />
        </td>
        <td class="td_title">车辆类型
        </td>
        <td>
          <input id="cmbCarSort" class="nui-combobox" type="text" style="width: 140px">
        </td>
        <td class="td_title">是否进口
        </td>
        <td>
          <input id="cmbImport" class="nui-combobox" name="state" editable="false" style="width: 95px;"> </input>
        </td>
      </tr>
      <tr>
        <td align="right">车体结构
        </td>
        <td>
          <input id="cmbStruct" class="nui-combobox" style="width: 110px"> </input>
        </td>
        <td align="right">&nbsp;车辆级别
        </td>
        <td align="right">
          <input id="cmbLevel" class="nui-combobox" style="width: 110px"></input>
        </td>
        <td align="right">
          <input id="cmbMult" class="nui-combobox" name="state" editable="false" style="width: 80px;"> </input>
        </td>
        <td colspan="4">
          <input id="txtMult" class="nui-textbox" type="text" style="width: 302px" />
        </td>
        <td align="right">
          <!-- <a id="btnSearch" class="nui-linkbutton" onclick="Bind()" iconcls='icon-search'>查找</a> -->
          <a class="nui-button" plain="true" onclick="" id="" enabled="true"><span
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
        <div field="" headerAlign="center" allowSort="true" width="100px">车型编号</div>
        <div field="" headerAlign="center" allowSort="true" width="100px">车型名称</div>
        <div field="" headerAlign="center" allowSort="true" width="100px">拼音码</div>
        <div field="" headerAlign="center" allowSort="true" width="100px">产地</div>
        <div field="" headerAlign="center" allowSort="true" width="100px">汽车品牌</div>
        <div field="" headerAlign="center" allowSort="true" width="100px">车辆类型</div>
        <div field="" headerAlign="center" allowSort="true" width="100px">上市日期</div>
        <div field="" headerAlign="center" allowSort="true" width="100px">车体结构</div>
        <div field="" headerAlign="center" allowSort="true" width="100px">车辆级别</div>
        <div field="" headerAlign="center" allowSort="true" width="100px">变速箱</div>
        <div field="" headerAlign="center" allowSort="true" width="100px">排量</div>
        <div field="" headerAlign="center" allowSort="true" width="100px">驱动方式</div>
        <div field="" headerAlign="center" allowSort="true" width="100px">是否进口</div>
        <div field="" headerAlign="center" allowSort="true" width="100px">座位数</div>
        <div field="" headerAlign="center" allowSort="true" width="100px">指导进货价</div>
        <div field="" headerAlign="center" allowSort="true" width="100px">指导销售价</div>
        <div field="" headerAlign="center" allowSort="true" width="100px">公司限价</div>
        <div field="" headerAlign="center" allowSort="true" width="100px">购车订金</div>
        <div field="" headerAlign="center" allowSort="true" width="100px">备注说明</div>
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
        url: webPath + contextPath + '/page/car/chexingkuanshi_det.jsp',
        title: tit,
        width: 380,
        height: 480,
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