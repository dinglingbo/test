<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" session="false"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ include file="/common/sysCommon.jsp"%>
<html>
<!--
  - Author(s): Administrator
  - Date: 2018-01-25 14:17:08
  - Description:
-->
<head>
  <title>计次卡</title>
  <script src="<%=webPath + contextPath%>/repair/js/RepairBusiness/Reception/ReceptionMain.js?v=1.1.8"></script>
  <style type="text/css">

  .title {
    width: 60px;
    text-align: right;
  }

  .form_label {
   width: 72px;
   text-align: right;
 }

 .required {
   color: red;
 }

 .rmenu {
  font-size: 14px;
  /* font-weight: bold; */
  text-align: left;
  margin: 0;
  padding-left: 25px;
  height: 18px;
  color: #fff;
  width: auto;
  margin-left: 20px;
  margin-top: 20px;
  background-size: 50%;
}

.tbtext{
  text-align: right;
  line-height: 40px;
}
.tbCtrl{
  width: 50px;
}

</style>

</head>
<body>

  <table class="table" id="table1"> 
    <tr>
      <td class="tbtext">计次卡名称<input  class="nui-textbox tabwidth" /></td>
      <td class="tbCtrl" ></td>
      <td class="tbtext">销售价格 <input  class="nui-textbox tabwidth" /></td>
      <td class="tbCtrl" ></td>
      <td class="tbtext">总价值 <input  class="nui-textbox tabwidth" /></td>
    </tr>

    <tr>
      <td class="tbtext">次数<input  class="nui-textbox tabwidth" /></td>
      <td class="tbCtrl" ></td>
      <td class="tbtext">原价<input  class="nui-textbox tabwidth" /></td>
      <td class="tbCtrl" ></td>
      <td class="tbtext">销价 <input  class="nui-textbox tabwidth" /></td>
    </tr>
    <tr>
      <td class="tbtext">有效期 <input  class="nui-combobox tabwidth" /></td>
      <td class="" >月</td>
      <td class="tbCtrl" ></td>
      <td class="tbtext">使用说明<input  class="nui-textbox tabwidth" /></td>
      <td class="tbCtrl" ></td>
      <td class="tbtext">卡说明<input  class="nui-textbox tabwidth" /></td>
    </tr>
        <tr>
      <td class="tbtext">状态<input  class="nui-textbox tabwidth" /></td>
    </tr>
  </table>


  <div id="mainGrid" class="nui-datagrid" style="width:100%;height:300px;"
  selectOnLoad="true"
  showPager="false"
  pageSize="50"
  totalField="page.count"
  sizeList=[20,50,100,200]
  dataField="list"
  onrowdblclick=""
  allowCellSelect="true"
  editNextOnEnterKey="true"
  onshowrowdetail="onShowRowDetail"
  url="">
  <div property="columns">
    <div field="" name="" width="40" headerAlign="center" align="center" >套餐项目</div>
    <div field="" name="" width="40" headerAlign="center" align="center" >原价</div>
    <div field="" name="" width="40" headerAlign="center" align="center" >套餐单价</div>
    <div field="" name="" width="40" headerAlign="center" align="center" >数量</div>
    <div field="" name="" width="40" headerAlign="center" align="center" >操作</div>
  </div>
</div>


<table class="table" id="table1">
  <tr>
    <td class="tbtext">
      套餐名称<label><input name="Fruit" type="radio" value="" />有效</label>
      <label><input name="Fruit" type="radio" value="" />停用</label>
    </td>
    <td class="tbCtrl"></td>
    <td class="tbtext">限制车辆 <input  class="nui-combobox tabwidth" /></td>

  </tr>
</table>
<div style="border: 1px solid #ccc">
  1. 不限：若项目勾选了不限，则该套餐售出后，客户消费该项目时不再受数量限制。<br>
  举例：普通洗车项目为20次，勾选【不限】后，客户购买消费时则不再受数量限制，全年均可消费任意次数的普通洗车服务。<br>
  2. 套餐单价的计算：套餐合计价除以套餐数量，得出套餐单价。<br>
  3. 消费计算：消费时，在设置数量范围内，预收款是平摊到车主的消费中的，若超出了数量，预收款已经用完，则消费价格为0。

</div>
<div style="width:100%;margin-top: 10px;text-align: center;">
  <a class="nui-button" onclick=""   plain="false" >保存</a>

  <a class="nui-button" onclick=""   plain="false" >取消</a>
</div>
<script type="text/javascript">
 nui.parse();

 //700px   550px
</script>
</body>
</html>