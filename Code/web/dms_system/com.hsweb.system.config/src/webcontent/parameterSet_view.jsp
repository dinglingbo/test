<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ include file="/common/sysCommon.jsp"%>
<html>
<!-- 
  - Author(s): Guine
  - Date: 2018-04-23 11:00:21
  - Description:-->

<%
	//String contextPath = request.getContextPath();
%>
<head>
<title>参数设置</title>
    <script src="<%= request.getContextPath() %>/config/js/parameterSet.js?v=1.7.8"></script>

</head>
<body>

<div id="tabs1" class="nui-tabs" activeIndex="0" style="width:95%;height:100%; margin-left: 3%;  " plain="false">
    <div title="免责条款" >
  	<div id="tabs2" class="nui-tabs" activeIndex="0" style="width:93%;height:95%; margin-left:2.5%; margin-top: 1%; " plain="false">
  	<div title="结算单打印内容">
  	<div style="border: solid 1px black; width: 50%;  height:80%; margin-left: 2%; margin-top: 3%;">
  	<div style="height: 5%; margin-top: 5%; margin-bottom: 5%;">
  	<span style="width: 100%; height: 20%; margin-left: 45%; ">内容体</span>
  	</div>
  	<textarea placeholder="由于上述自带材料引起的任何相关问题（除了因安装不规范造成的故障责任由施工方承担外，其它因材料质量等因素引起的故障责任，如：对车辆本身造成的伤害、车辆行驶过程中造成的损害、以及出现交通事故产生的损害等）都由承修方承担，与施工方无关，恳请悉知！"style="width: 90%;  margin-left: 5%; height: 68.5%;" name="settArea" id="settArea"></textarea>
  	<div style="background-color: #F0F0F0; width: 100%;height: 10%; margin-top: 3%;">
	 	<a class="nui-button" style="margin-top: 1.5%;   float: right; margin-right:10%;" onclick="orderPrintSet('repair_sett_print_content',1)">保存并复制</a>
	 	<a class="nui-button"  style="margin-top: 1.5%;  float: right; margin-right:3%;" onclick="orderPrintSet('repair_sett_print_content',0)">保存</a>
	 </div>
	 </div>
	 </div>
	 <div title="委托单打印内容">
	 <div style="border: solid 1px black; width: 50%; height:80%; margin-left: 2%; margin-top: 3%;">
  	<div style="height: 5%; margin-top: 5%; margin-bottom: 5%;">
  	<span style="width: 100%; height: 20%; margin-left: 45%; ">内容体</span>
  	</div>
  	<textarea style="width: 90%;  margin-left: 5%; height: 68.5%;"  name="entrustArea" id="entrustArea"></textarea>
  	<div style="background-color: #F0F0F0; width: 100%;height: 10%; margin-top: 3%;">
	 	<a class="nui-button" style="margin-top: 1.5%;   float: right; margin-right:10%;" onclick="orderPrintSet('repair_entrust_print_content',1)">保存并复制</a>
	 	<a class="nui-button"  style="margin-top: 1.5%;  float: right; margin-right:3%;" onclick="orderPrintSet('repair_entrust_print_content',0)">保存</a>
	 </div>
	 </div>
	 </div>
  	</div>
	</div>
    <div title="客户级别设置" >
   

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
  	
    </div>
     <div title="回返设置" >
     
   <div style="background-color: #F0F0F0; width: 90%;height: 70%; margin-top: 3%; margin-left: 5%;">
	 	<div style="width: 90%; height: 50%;  margin-left: 5%;">
	 
	 	<span>
	 	<br>
	 	<br>
	 	注：出厂（仅第一次收款）时，根据“预定回访日设置(1天～371天)”：<br>
   			 1、自动生成各时间的<span style="color: red;">回访单</span>，其中回访单中“预定回访日”为“预定回访日设置”计算出的日期<br>
   			 2、在到达预定回访日时系统会自动生成<span style="color: red;">回访提醒</span>
		<br>
		<br>	
		预定回访日设置
	 	</span>
	 	<div style="background-color: #FFFFFF; width:90%;height: 100%; margin-top: 1%;">
	 	<div style="width: 100%;height: 0.1%;"></div>
	 	<div style="margin-top: 3%;">
	 		<div class="nui-form" id="returnForm">
	 		<table border="1" style="margin-left: 5%; width:90%; border-spacing:1px 0px;">
	 		<tr>
	 		<td width="100px;" align="center">类别</td>
	 		<td width="200px;">第一次回访日</td>
	 		<td width="200px;">第二次回访日</td>
	 		<td width="200px;">第三次回访日</td>
	 		</tr>
	 		<tr>
	 		<td align="center">工单</td>
	 		<td>出厂	 <div class="nui-textbox" style="width: 10%" value="7" name="workScoutDay1"></div>天后 <div  class="nui-radiobuttonlist" style="display:inline-block; margin-left: 10%;" name="workScoutDisable1" id="workScoutDisable1" textField="name" valueField="id" value="1" data="showList" ></div></td>
	 		<td>出厂	 <div class="nui-textbox" style="width: 10%" value="30"  name="workScoutDay2"></div>天后 <div  class="nui-radiobuttonlist" style="display:inline-block; margin-left: 10%;" name="workScoutDisable2" id="workScoutDisable2" textField="name" valueField="id" value="1" data="showList"  ></div></td>
	 		<td>出厂	 <div class="nui-textbox" style="width: 10%" value="90"  name="workScoutDay3"></div>天后 <div  class="nui-radiobuttonlist" style="display:inline-block; margin-left: 10%;" name="workScoutDisable3" id="workScoutDisable3" textField="name" valueField="id" value="1"  data="showList"></div></td>
	 		</tr>
	 		<tr>
	 		<td align="center">洗车单</td>
			<td>出厂	 <div class="nui-textbox" style="width: 10%" value="7" name="washScoutDay1"></div>天后 <div  class="nui-radiobuttonlist" style="display:inline-block; margin-left: 10%;" name="washScoutDisable1" id="washScoutDisable1" textField="name" valueField="id" value="1" data="showList" ></div></td>
	 		<td>出厂	 <div class="nui-textbox" style="width: 10%" value="30" name="washScoutDay2"></div>天后<div  class="nui-radiobuttonlist" style="display:inline-block; margin-left: 10%;" name="washScoutDisable2" id="washScoutDisable2" textField="name" valueField="id" value="1" data="showList" ></div></td>
	 		<td>出厂	 <div class="nui-textbox" style="width: 10%" value="90" name="washScoutDay3"></div>天后<div  class="nui-radiobuttonlist" style="display:inline-block; margin-left: 10%;" name="washScoutDisable3" id="washScoutDisable3" textField="name" valueField="id" value="1" data="showList" ></div></td>
	 		</tr>
	 		<tr>
	 		<td align="center">零售单</td>
			<td>出厂	 <div class="nui-textbox" style="width: 10%" value="7" name="zeroScoutDay1"></div>天后<div  class="nui-radiobuttonlist" style="display:inline-block; margin-left: 10%;" name="zeroScoutDisable1" id="zeroScoutDisable1" textField="name" valueField="id" value="1" data="showList" ></div></td>
	 		<td>出厂	 <div class="nui-textbox" style="width: 10%" value="30" name="zeroScoutDay2"></div>天后<div  class="nui-radiobuttonlist" style="display:inline-block; margin-left: 10%;" name="zeroScoutDisable2" id="zeroScoutDisable2" textField="name" valueField="id" value="1" data="showList" ></div></td>
	 		<td>出厂	 <div class="nui-textbox" style="width: 10%" value="90" name="zeroScoutDay3"></div>天后<div  class="nui-radiobuttonlist" style="display:inline-block; margin-left: 10%;" name="zeroScoutDisable3" id="zeroScoutDisable3" textField="name" valueField="id" value="1"  data="showList"></div></td>
	 		</tr>
	 		<tr>
	 		<td align="center">理赔单</td>
			<td>出厂	 <div class="nui-textbox" style="width: 10%" value="7" name="claimScoutDay1"></div>天后<div  class="nui-radiobuttonlist" style="display:inline-block; margin-left: 10%;" name="claimScoutDisable1" id="claimScoutDisable1" textField="name" valueField="id" value="1"  data="showList"></div></td>
	 		<td>出厂	 <div class="nui-textbox" style="width: 10%" value="30" name="claimScoutDay2"></div>天后<div  class="nui-radiobuttonlist" style="display:inline-block; margin-left: 10%;" name="claimScoutDisable2" id="claimScoutDisable2" textField="name" valueField="id" value="1"  data="showList"></div></td>
	 		<td>出厂	 <div class="nui-textbox" style="width: 10%" value="90" name="claimScoutDay3"></div>天后<div  class="nui-radiobuttonlist" style="display:inline-block; margin-left: 10%;" name="claimScoutDisable3" id="claimScoutDisable3" textField="name" valueField="id" value="1"  data="showList"></div></td>
	 		</tr>
	 		</table>
	 		
	 	</div>
	 	</div>
	 	</div>
	 <div style=" width: 100%;height: 10%; margin-top: 3%;">
	 	
	 	<a class="nui-button"  style="margin-top: 1.5%;  float: right; margin-right:10%;" onclick="returnFormSet">保存</a>
	 </div>
	 </div>
	 </div> 

     </div>
   
     
     
     <div title="汽车电子健康档案上传设置" >	
   
 
     <div style="background-color: #F0F0F0; width: 50%;height: 42%; margin-top: 3%; margin-left: 5%;">
     <div style="height: 0.1%;width: 100%;"></div>
     <div style="margin-top: 1%;margin-left: 1%;">
     	<span > 
     	电子健康档案门店信息
     	</span>
     </div>
     <div style="width: 100%; height: 75%; border: 1px; background-color: #ffffff; margin-top: 1%;">
     	<div class="nui-form" id="repairStoreForm">
     	 <table style="border-spacing:0px 20px;" >
		    <tr>
		    <td  style="width:100px; text-align: right; color: red;">
			对接省份:
		    </td>
		    <td style="width:500px;">
		    <input  class="nui-combobox" style="margin-left: 5%; width: 65%; "  emptytext="选择省份"  id="provinceId" name="provinceId" textField="name"  valueField="code" onvaluechanged="onProvinceChange" />
			</td>
		    <td>
		 
            </td>
		    </tr>
			 <tr>
		    <td  style="text-align: right; color: red;">
			维修厂编号:
		    </td>
		    <td><div class="nui-textbox" style="width: 65%;margin-left: 5%; " name="repairStoreNo"></div></td>
		    </tr>
		     <tr>
		    <td  style=" text-align: right; color: red;">
			用户名:
		    </td>
		    <td><div class="nui-textbox" style="width: 65%;margin-left: 5%; "  name="repairStoreName"></div></td>
		    </tr>
		     <tr>
		    <td  style=" text-align: right; color: red;">
			密码:
		    </td>
		    <td ><div class="nui-textbox" style="width: 65%;margin-left: 5%; "  name="repairStorePwd"></div></td>
		    </tr>
		   </table>
		 <div style=" width: 100%;height: 5%;">
	 		<a class="nui-button" style= "float: right;" onclick="repairStoreFormSet">保存</a>
	 	 </div>
      </div>
     </div>
   </div> 
     </div>
     <div title="查车模板设置" >
       
      <div class="nui-tabs" style="margin-left: 5%; width: 90%; height: 100%;">
     <div title="查车单">
     <div style="height:390%;width: 100%; background-color:#F0F0F0;">
     <div style="height:100%;width: 100%; background-color: #ffffff; width: 90%; margin-left: 5%;">
     	
  		<div style="background-color:#E8E8E8; width: 100%;height: 2%; margin-top: 2%; ">	
  		<div style="width: 100%;height: 0.1%;"></div>
  		<div style="margin-top: 2%; margin-left: 2%;">
  		<span style="font-size: 20px; line-height: 1%;">车辆环视图</span>
  		<input  class="nui-checkbox" style="float: right;"/>
  		</div>
  		</div>
  		<div>
  		<center>
  		<img alt="" src="<%=webPath + contextPath%>/frm/Newimg/dounload.png" border="1px;" >
  		</center>
  		</div>
  	<div style="background-color:#E8E8E8; width: 100%;height: 2%; ">	
  		<div style="width: 100%;height: 0.1%;"></div>
  		<div style="margin-top: 2%; margin-left: 2%;">
  		<span style="font-size: 20px; line-height: 1%;">随车物品</span>
  		<input  class="nui-checkbox" style="float: right;"/>
  		</div>
  	</div>
  		<div style="width: 100%;height: 1%; margin-top: 2%;">
  		<span style="margin-left: 7%;">备胎  <input  class="nui-checkbox" style="margin-left: 1%;"/></span>
  		<span style="margin-left: 7%;">警示牌  <input  class="nui-checkbox" style="margin-left: 1%;"/></span>
  		<span style="margin-left: 7%;">点烟器 <input  class="nui-checkbox" style="margin-left: 1%;"/></span>
  		<span style="margin-left: 7%;">千斤顶  <input  class="nui-checkbox" style="margin-left: 1%;"/></span>  		
  		<span style="margin-left: 7%;">灭火器  <input  class="nui-checkbox" style="margin-left: 1%;"/></span>  		
  		<span style="margin-left: 7%;">工具  <input  class="nui-checkbox" style="margin-left: 1%;"/></span>
  		<span style="margin-left: 7%;">烟灰缸  <input  class="nui-checkbox" style="margin-left: 1%;"/></span>
  		</div>
  	<div style="background-color:#E8E8E8; width: 100%;height: 2%; ">	
  		<div style="width: 100%;height: 0.1%;"></div>
  		<div style="margin-top: 2%; margin-left: 2%;">
  		<span style="font-size: 20px; line-height: 1%;">警示灯标志</span>
  		<input  class="nui-checkbox" style="float: right;"/>
  		</div>
  	</div>
  		<div style="width: 100%;height: 1%; margin-top: 2%;">
  		<span style="margin-left: 7%;">备胎  <input  class="nui-checkbox" style="margin-left: 1%;"/></span>
  		<span style="margin-left: 7%;">警示牌  <input  class="nui-checkbox" style="margin-left: 1%;"/></span>
  		<span style="margin-left: 7%;">点烟器 <input  class="nui-checkbox" style="margin-left: 1%;"/></span>
  		<span style="margin-left: 7%;">千斤顶  <input  class="nui-checkbox" style="margin-left: 1%;"/></span>  		
  		<span style="margin-left: 7%;">灭火器  <input  class="nui-checkbox" style="margin-left: 1%;"/></span>  		
  		<span style="margin-left: 7%;">工具  <input  class="nui-checkbox" style="margin-left: 1%;"/></span>
  		<span style="margin-left: 7%;">烟灰缸  <input  class="nui-checkbox" style="margin-left: 1%;"/></span>
  		</div>
  	<div style="background-color:#E8E8E8; width: 100%;height: 2%; ">	
  		<div style="width: 100%;height: 0.1%;"></div>
  		<div style="margin-top: 2%; margin-left: 2%;">
  		<span style="font-size: 20px; line-height: 1%;">发动机舱检查</span>
  		<input  class="nui-checkbox" style="float: right;"/>
  		</div>
  		</div>
  
  	<div style="width: 30%; height: 10%;">
  	机舱检查
  	</div>
  		
  	<div style="background-color:#E8E8E8; width: 100%;height: 2%; ">	
  		<div style="width: 100%;height: 0.1%;"></div>
  		<div style="margin-top: 2%; margin-left: 2%;">
  		<span style="font-size: 20px; line-height: 1%;">车辆外观检查</span>
  		<input  class="nui-checkbox" style="float: right;"/>
  		</div>
  		</div>
  	
  	<div style="width: 30%; height: 10%;">
  		   		车辆外观
  	</div>

  		
  	<div style="background-color:#E8E8E8; width: 100%;height: 2%; ">	
  		<div style="width: 100%;height: 0.1%;"></div>
  		<div style="margin-top: 2%; margin-left: 2%;">
  		<span style="font-size: 20px; line-height: 1%;">底盘制动检查</span>
  		<input  class="nui-checkbox" style="float: right;"/>
  		</div>
  		</div>
  	
  	<div style="width: 30%; height: 10%;">
  		   		底盘制动
  	</div>

  		
  	<div style="background-color:#E8E8E8; width: 100%;height: 2%; ">	
  		<div style="width: 100%;height: 0.1%;"></div>
  		<div style="margin-top: 2%; margin-left: 2%;">
  		<span style="font-size: 20px; line-height: 1%;">内饰检查</span>
  		<input  class="nui-checkbox" style="float: right;"/>
  		</div>
  		</div>
  	
  	<div style="width: 30%; height: 10%;">
  		   	内饰
  	</div>

  		
  	<div style="background-color:#E8E8E8; width: 100%;height: 2%; ">	
  		<div style="width: 100%;height: 0.1%;"></div>
  		<div style="margin-top: 2%; margin-left: 2%;">
  		<span style="font-size: 20px; line-height: 1%;">客户描述</span>
  		<input  class="nui-checkbox" style="float: right;"/>
  		</div>
  	</div>  	
  	<div style="width: 30%; height: 8%;">
  		   	描述
  	</div>
  		
	  	<div style="background-color:#E8E8E8; width: 100%;height: 2%; ">	
  		<div style="width: 100%;height: 0.1%;"></div>
  		<div style="margin-top: 2%; margin-left: 2%;">
  		<span style="font-size: 20px; line-height: 1%;">检测照片</span>
  		<input  class="nui-checkbox" style="float: right;"/>
  		</div>
  	</div>  	
  	<div style="width: 30%; height: 8%;">
  		   	照片
  	</div>
  	<div style=" width: 100%; height: 2%; background-color: #E8E8E8">
	 	<a class="nui-button" style="margin-top: 1.5%;   float: right; margin-right:10%;">保存并复制</a>
	 	<a class="nui-button"  style="margin-top: 1.5%;  float: right; margin-right:3%;">保存</a>
	 </div>	
     </div>
     </div>
     </div>
     <div title="接车预检单">
     </div>
     </div>
     </div>
     <div title="显示设置" >
  
	  <div  class="nui-form" id="showForm">
     <div class="nui-col-6" style="margin-top: 2%;">
                
                <div class="nui-panel" title="关怀提醒默认显示" width="80%" style="margin-left: 10%;" 
                    showCollapseButton="false" showCloseButton="false"  >
              		     显示建档人为本人的提醒：    <input  class="nui-checkbox" text="" value="0" trueValue="1" falseValue="0" name="repair_careAlarm_default_show"/>
                </div>

     </div>
     <div class="nui-col-6" style="margin-top: 2%;">
                
                <div class="nui-panel" title="业务提醒默认显示" width="80%" style="margin-left: 10%;" 
                    showCollapseButton="false" showCloseButton="false"  >
              		     显示服务顾问为本人的工单：    <input  class="nui-checkbox" text="" value="0" trueValue="1" falseValue="0" name="repair__service_default_show"/>
                </div>

     </div>
     <div class="nui-col-6" style="margin-top: 2%;">
                
                <div class="nui-panel" title="工作列表默认显示" width="80%" style="margin-left: 10%;" 
                    showCollapseButton="false" showCloseButton="false"  >
              		     显示服务顾问为本人的工单：    <input  class="nui-checkbox" text="" value="0" trueValue="1" falseValue="0" name="repair__worklist_default_show"/>
                </div>

     </div>
          <div class="nui-col-6" style="margin-top: 2%;">
                
                <div class="nui-panel" title="默认仓库" width="80%" style="margin-left: 10%;" 
                    showCollapseButton="false" showCloseButton="false"  >
              		
              		     默认仓库：           <input class="nui-combobox" id="defaultStore" name="defaultStore" value=""   width="70px"  textField="name" valueField="id"/>
              
                </div>

    	 </div>
    	 <div class="nui-col-6" style="margin-top: 2%;">
                
                <div class="nui-panel" title="结算单打印显示" width="80%" style="margin-left: 10%;" 
                    showCollapseButton="false" showCloseButton="false"  >
              		   结算单打印抬头显示：    <input  class="nui-textbox" name="repair__settorder_print_show"/>
                </div>

     	</div>
     	 <div style=" width: 100%;height: 10%;">
	 		<a class="nui-button" style="margin-top: 1.5%;  margin-right:10%;float: right;" onclick="showFormSet">保存</a>
	 
		 </div>
    </div> 
    </div>
     </div>


	
</body>
 <script type="text/javascript">
      
		nui.parse();

      
       
  </script>
</html>