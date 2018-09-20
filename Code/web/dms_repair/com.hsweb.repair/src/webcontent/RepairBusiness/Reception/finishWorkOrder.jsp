<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false"%>
<%@include file="/common/commonRepair.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<!-- 
  - Author(s): Administrator
  - Date: 2018-01-25 14:17:08
  - Description:
-->
<head>
<title>完工</title>
<script src="<%=webPath + contextPath%>/repair/js/RepairBusiness/Reception/sellMain.js?v=1.0.0"></script>
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

</style>

</head>
<body style="height:100%;width:100%">

<div class="nui-fit">
<div class="nui-toolbar" style="padding:2px;border-bottom:0;"> 
   
   
  <div id="dataGrid1"
       dataField="list"
       class="nui-datagrid"
       style="width: 100%; height: 100px;"
       showPager="false"
       allowSortColumn="true">
      <div property="columns">
          <!-- <div headerAlign="center" type="indexcolumn" width="30">序号</div> -->
          <div field="partName" headerAlign="center" allowSort="true" visible="true" width="100">项目编号</div>
          <div field="receTypeId" headerAlign="center" allowSort="true" visible="true" width="80">项目名</div>
          <div field="qty" headerAlign="center" allowSort="true" visible="true" width="80" datatype="int" align="right">维修技师</div>
          <div field="unitPrice" headerAlign="center" allowSort="true" visible="true" width="80" datatype="float" align="right">是否合格</div>
          <div field="amt" headerAlign="center" allowSort="true" visible="true" width="80" datatype="float" align="right">备注</div>
      </div>
  </div>
   
   
   <div id="dataGrid2"
       dataField="list"
       class="nui-datagrid"
       style="width: 100%; height: 100px;"
       showPager="false"
       allowSortColumn="true">
      <div property="columns">
         <!--  <div headerAlign="center" type="indexcolumn" width="30">序号</div> -->
          <div field="partName" headerAlign="center" allowSort="true" visible="true" width="100">材料编号</div>
          <div field="receTypeId" headerAlign="center" allowSort="true" visible="true" width="80">材料名</div>
          <div field="qty" headerAlign="center" allowSort="true" visible="true" width="80" datatype="int" align="right">领料人</div>
          <div field="unitPrice" headerAlign="center" allowSort="true" visible="true" width="80" datatype="float" align="right">数量</div>
          <div field="amt" headerAlign="center" allowSort="true" visible="true" width="80" datatype="float" align="right">已领取</div>
          <div field="amt" headerAlign="center" allowSort="true" visible="true" width="80" datatype="float" align="right">未领取</div>
          
      </div>
  </div>

   <div style="padding: 0px;" borderStyle="border:0;">
		<table width="100%">
			<tr >
			<td style="text-align:center;" colspan="1"  >
				<a	class="nui-button"  onclick="readyPay()" id = "readyPay"> 完工</a> 
				<a class="nui-button"  onclick="noPayOk()" id = "noPayOk" >保存</a> 
				<a class="nui-button"  onclick="payOk()" id = "payOk" >返单</a> 
			</td>
			</tr>
		</table>
	</div>
   </div>
</div>
</body>
</html>