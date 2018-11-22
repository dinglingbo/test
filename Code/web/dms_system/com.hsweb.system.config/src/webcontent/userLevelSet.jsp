<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false" %>
<%@ include file="/common/sysCommon.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<!-- 
  - Author(s): Administrator
  - Date: 2018-06-14 09:46:58
  - Description:
-->
<head>
<title>Title</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
     <script src="<%= request.getContextPath() %>/config/js/userLevelSet.js?v=1.7.8"></script>
    
</head>
<body>

<div style="border: solid 1px black; width: 55%; margin-left: 10%; margin-top: 3%; height: 80%;">
 	 <div class="nui-form" id="discountForm">
    <table style="border-spacing:0px 20px;" > 
  	
  	<tr>
  	<td align="right">客户级别名称：</td>
  	<td><div class="nui-textbox" name="name" width="55%";></div></td>
  
  	</tr>
  	<tr>
  	<td align="right">折扣适用范围：</td>
  	<td><div name="discountArea" id="discountArea" class="nui-checkboxlist"  value="0" repeatItems="4" repeatLayout="flow"  textField="name" valueField="id" data="typeList"></div></td>
  
  	</tr>  	
  	<tr>
  	<td width="220px;" align="right">积分系统启用：</td>
  	<td width="400px;"><input name="integralDisabled" class="nui-checkbox" text="" value="0" trueValue="1" falseValue="0"/></td>
  	
  	</tr>		
  	<tr>
  	<td align="right">消费1元兑换：</td>
  	<td><div class="nui-textbox" name="integralAdd"></div> 积分</td>
  	
  	</tr>
  	<tr>
  	<td align="right">产生积分：</td>
  	<td><div name="pointBring" id="pointBring" value="0" class="nui-checkboxlist" repeatItems="4" repeatLayout="flow"  textField="name" valueField="id" data="typeList"></div></td>
  	
  	</tr>
  	<tr>
  	<td align="right">抵扣1元消费：</td>
  	<td><div class="nui-textbox" name="integralReduce"></div> 积分</td>
 
  	</tr>
  	<tr>
  	<td align="right">使用积分：</td>
  	  	<td><div name="pointUse" id="pointUse" class="nui-checkboxlist"  value="0" repeatItems="4" repeatLayout="flow"  textField="name" valueField="id" data="typeList"></div></td>
  	<td></td>
  	</tr>
  	</table>
  	</div>
  	<div>
  	<label style="margin-left: 16%;">折扣设定:</label>
  	<div id="discountGrid" class="nui-datagrid" 
				style="width: 60%; height: 40%; float: right; margin-right: 18%; "pageSize="10"
				sizeList="[10,20,50]" allowAlternating="true" multiSelect="true"  oncellcommitedit="onCellCommitEdit"
				 dataField="data" idField="id" allowCellEdit="true" allowCellSelect="true"treeColumn="name" parentField="parentId" showPager="false">
			<div property="columns" width="10">
				
				<div field="name" allowSort="true" headerAlign="center" Align="center">业务类型</div>
				<div field="packageDiscountRate" allowSort="true" headerAlign="center"  Align="right" >套餐折扣（0.1-1.00）
					<input property="editor" class="nui-textbox"  vtype="range:0,1"   style="width:100%;  " value="0"/>
				</div>
				<div field="itemDiscountRate" allowSort="true" headerAlign="center"  Align="right" >项目折扣（0.1-1.00）
					<input property="editor" class="nui-textbox"  vtype="range:0,1"   style="width:100%;  " value="0"/>
				</div>
				<div field="partDiscountRate" allowSort="true" headerAlign="center" Align="right">配件折扣（0.1-1.00）
					<input property="editor" class="nui-textbox"  vtype="range:0,1"   style="width:100%; " value="0"/>
				</div>
	</div>
	</div>
	<div style=" width: 100%;height: 10%; margin-top: 25%; margin-left: 78%;">
	 
	 	<a class="nui-button" onclick="saveDiscount">保存</a>
	 </div>
  	</div>
  	
  </div>


</body>
</html>