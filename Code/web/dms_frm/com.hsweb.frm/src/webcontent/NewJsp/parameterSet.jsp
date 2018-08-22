<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>

<html>
<!-- 
  - Author(s): Guine
  - Date: 2018-04-23 11:00:21
  - Description:
-->
<%
	//String contextPath = request.getContextPath();
%>
<head>
<title>参数设置</title>
<%@include file="/common/sysCommon.jsp"%>


</head>
<body>

<div id="tabs1" class="nui-tabs" activeIndex="0" style="width:95%;height:100%; margin-left: 3%;  " plain="false">
    <div title="免责条款" >
  	<div id="tabs2" class="mini-tabs" activeIndex="0" style="width:94%;height:95%; margin-left:2.5%; margin-top: 1%; " plain="false">
  	<div title="结算单打印内容">
  	<div style="border: solid 1px black; width: 50%; margin-left: 2%; margin-top: 3%;">
  	<div style="height: 5%; margin-top: 5%; margin-bottom: 5%;">
  	<span style="width: 100%; height: 20%; margin-left: 45%; ">内容体</span>
  	</div>
  	<div class="nui-textarea" value="由于上述自带材料引起的任何相关问题（除了因安装不规范造成的故障责任由施工方承担外，其它因材料质量等因素引起的故障责任，如：对车辆本身造成的伤害、车辆行驶过程中造成的损害、以及出现交通事故产生的损害等）都由承修方承担，与施工方无关，恳请悉知！"style="width: 90%;  margin-left: 5%; height: 55%;"></div>
  	<div style="background-color: #F0F0F0; width: 100%;height: 10%; margin-top: 3%;">
	 	<a class="nui-button" style="margin-top: 1.5%;   float: right; margin-right:10%;">保存并复制</a>
	 	<a class="nui-button"  style="margin-top: 1.5%;  float: right; margin-right:3%;">保存</a>
	 </div>
	 </div>
	 </div>
	 <div title="委托单打印内容">
	 <div style="border: solid 1px black; width: 50%; margin-left: 2%; margin-top: 3%;">
  	<div style="height: 5%; margin-top: 5%; margin-bottom: 5%;">
  	<span style="width: 100%; height: 20%; margin-left: 45%; ">内容体</span>
  	</div>
  	<div class="nui-textarea" style="width: 90%;  margin-left: 5%; height: 55%;"></div>
  	<div style="background-color: #F0F0F0; width: 100%;height: 10%; margin-top: 3%;">
	 	<a class="nui-button" style="margin-top: 1.5%;   float: right; margin-right:10%;">保存并复制</a>
	 	<a class="nui-button"  style="margin-top: 1.5%;  float: right; margin-right:3%;">保存</a>
	 </div>
	 </div>
	 </div>
  	</div>
	</div>
    <div title="积分设置" >
 	<div style="border: solid 1px black; width: 40%; margin-left: 20%; margin-top: 3%;">
    <table style="border-spacing:0px 20px;" > 
  	<tr>
  	<td width="220px;" align="right">积分系统启用：</td>
  	<td width="400px;"><input name="Married" class="nui-checkbox" text="" value="N" trueValue="Y" falseValue="N"/></td>
  	
  	</tr>		
  	<tr>
  	<td align="right">消费1元兑换：</td>
  	<td><a class="nui-textbox"></a> 积分</td>
  	
  	</tr>
  	<tr>
  	<td align="right">产生积分：</td>
  	<td><div name="countrys" class="mini-checkboxlist" repeatItems="4" repeatLayout="flow" url="<%=apiPath + frmApi%>/com.hsapi.frm.newcomponent.newbiz.biz.ext" value="cn,de,usa" textField="text" valueField="id" ></div></td>
  	
  	</tr>
  	<tr>
  	<td align="right">抵扣1元消费：</td>
  	<td><a class="nui-textbox"></a> 积分</td>
 
  	</tr>
  	<tr>
  	<td align="right">使用积分：</td>
  	<td><div name="countrys" class="mini-checkboxlist" repeatItems="4" repeatLayout="flow" url="<%=apiPath + frmApi%>/com.hsapi.frm.newcomponent.newbiz.biz.ext" value="cn,de,usa" textField="text" valueField="id" ></div></td>
  	<td></td>
  	</tr>
  	<tr>
  	<td align="right">积分可抵扣工时费：</td>
  	<td><input name="Married" class="nui-checkbox" text="" value="N" trueValue="Y" falseValue="N"/></td>
  
  	</tr>
  	<tr>
  	<td align="right">积分可抵扣材料费：</td>
  	<td><input name="Married" class="nui-checkbox" text="" value="N" trueValue="Y" falseValue="N"/></td>
  
  	</tr>  	
  	</table>
  	<div style=" width: 100%;height: 10%; margin-top: 3%;">
	 	<a class="nui-button" style="margin-top: 1.5%;   float: right; margin-right:10%;">保存并复制</a>
	 	<a class="nui-button"  style="margin-top: 1.5%;  float: right; margin-right:3%;">保存</a>
	 </div>
  </div>
  
    </div>
     <div title="回访设置" >
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
	 		<table border="1" style="margin-left: 5%; width:90%; border-spacing:1px 0px;">
	 		<tr>
	 		<td width="100px;" align="center">类别</td>
	 		<td width="200px;">第一次回访日</td>
	 		<td width="200px;">第二次回访日</td>
	 		<td width="200px;">第三次回访日</td>
	 		</tr>
	 		<tr>
	 		<td align="center">工单</td>
	 		<td>出厂	<div class="nui-textbox" style="width: 10%" value="7"></div>天后<input type="radio" value="启用"name="workoneday">启用<input type="radio" value="不
	 		启用"name="workoneday"> 不启用 </td>
	 		<td>出厂	<div class="nui-textbox" style="width: 10%" value="30"></div>天后<input type="radio" value="启用"name="workoneday">启用<input type="radio" value="不
	 		启用"name="worktwoday"> 不启用</td>
	 		<td>出厂	<div class="nui-textbox" style="width: 10%" value="90"></div>天后<input type="radio" value="启用"name="workoneday">启用<input type="radio" value="不
	 		启用"name="workthreeday"> 不启用</td>
	 		</tr>
	 		<tr>
	 		<td align="center">洗车单</td>
			<td>出厂	<div class="nui-textbox" style="width: 10%" value="7"></div>天后<input type="radio" value="启用"name="workoneday">启用<input type="radio" value="不
	 		启用"name="caroneday"> 不启用 </td>
	 		<td>出厂	<div class="nui-textbox" style="width: 10%" value="30"></div>天后<input type="radio" value="启用"name="workoneday">启用<input type="radio" value="不
	 		启用"name="cartwoday"> 不启用</td>
	 		<td>出厂	<div class="nui-textbox" style="width: 10%" value="90"></div>天后<input type="radio" value="启用"name="workoneday">启用<input type="radio" value="不
	 		启用"name="carthreeday"> 不启用</td>
	 		</tr>
	 		<tr>
	 		<td align="center">零售单</td>
			<td>出厂	<div class="nui-textbox" style="width: 10%" value="7"></div>天后<input type="radio" value="启用"name="workoneday">启用<input type="radio" value="不
	 		启用"name="zerooneday"> 不启用 </td>
	 		<td>出厂	<div class="nui-textbox" style="width: 10%" value="30"></div>天后<input type="radio" value="启用"name="workoneday">启用<input type="radio" value="不
	 		启用"name="zerotwoday"> 不启用</td>
	 		<td>出厂	<div class="nui-textbox" style="width: 10%" value="90"></div>天后<input type="radio" value="启用"name="workoneday">启用<input type="radio" value="不
	 		启用"name="zerothreeday"> 不启用</td>
	 		</tr>
	 		<tr>
	 		<td align="center">理赔单</td>
			<td>出厂	<div class="nui-textbox" style="width: 10%" value="7"></div>天后<input type="radio" value="启用"name="workoneday">启用<input type="radio" value="不
	 		启用"name="payoneday"> 不启用 </td>
	 		<td>出厂	<div class="nui-textbox" style="width: 10%" value="30"></div>天后<input type="radio" value="启用"name="workoneday">启用<input type="radio" value="不
	 		启用"name="paytwoday"> 不启用</td>
	 		<td>出厂	<div class="nui-textbox" style="width: 10%" value="90"></div>天后<input type="radio" value="启用"name="workoneday">启用<input type="radio" value="不
	 		启用"name="paythreeday"> 不启用</td>
	 		</tr>
	 		</table>
	 		
	 	</div>
	 	
	 	</div>
	 <div style=" width: 100%;height: 10%; margin-top: 3%;">
	 	<a class="nui-button" style="margin-top: 1.5%;   float: right; margin-right:10%;">保存并复制</a>
	 	<a class="nui-button"  style="margin-top: 1.5%;  float: right; margin-right:3%;">保存</a>
	 </div>
	 </div>
	 </div>

     </div>
     <div title="财务参数设置" >
     		<div class="mini-tabs" style="height: 90%; width:90%; margin-top: 1%; margin-left: 5%;">
     		<div title="收款方式" >
     		<div style="width: 90%; margin-left: 5%; " ><a class="nui-button" style="margin-top: 1%; float: right;">修改</a></div>
     		<div id="dgGrid" class="nui-datagrid" 
				style="width: 90%; height: 40%; margin-left: 5%; margin-top: 5%; "pageSize="10"
				sizeList="[10,20,50]" allowAlternating="true" multiSelect="true"
			<%-- 	url="<%=apiPath + frmApi%>/com.hsapi.frm.setting.QueryInt.biz.ext" --%>
				onselectionchanged="statuschange" dataField="data" idField="id"
				treeColumn="name" parentField="parentId" showPager="false">
			<div property="columns" width="10">
							<div type="checkcolumn" >选择</div>
							<div field="remark" allowSort="true" headerAlign="center"
								width="120">收款方式</div>
							<div field="remark" allowSort="true" headerAlign="center"
								width="120">说明</div>
							<div field="remark" allowSort="true" headerAlign="center"
								width="120">启用状态</div>
			</div>
			</div>
			<div style="margin-top: 1%; margin-left: 5%;">
			对收款方式的使用如有疑问请咨询客服
			</div>
			</div>
			<div title="付款方式">
			     		<div style="width: 90%; margin-left: 5%; " ><a class="nui-button" style="margin-top: 1%; float: right;">修改</a></div>
     		<div id="dgGrid" class="nui-datagrid" 
				style="width: 90%; height: 40%; margin-left: 5%; margin-top: 5%; "pageSize="10"
				sizeList="[10,20,50]" allowAlternating="true" multiSelect="true"
			<%-- 	url="<%=apiPath + frmApi%>/com.hsapi.frm.setting.QueryInt.biz.ext" --%>
				onselectionchanged="statuschange" dataField="data" idField="id"
				treeColumn="name" parentField="parentId" showPager="false">
			<div property="columns" width="10">
							<div type="checkcolumn" >选择</div>
							<div field="remark" allowSort="true" headerAlign="center"
								width="120">收款方式</div>
							<div field="remark" allowSort="true" headerAlign="center"
								width="120">说明</div>
							<div field="remark" allowSort="true" headerAlign="center"
								width="120">启用状态</div>
			</div>
			</div>
			<div style="margin-top: 1%; margin-left: 5%;">
			对收款方式的使用如有疑问请咨询客服
			</div>
			</div>
			<div title="记账方式">
			     <div class="mini-col-6" style="margin-top: 2%;">
			                
			                <div class="nui-panel" title="记账限额" width="80%" style="margin-left: 5%;" 
			                    showCollapseButton="false" showCloseButton="false"  >
			              		     启用记账限额：    <input name="Married" class="nui-checkbox" text="" value="N" trueValue="Y" falseValue="N" "/>
			                </div>
			
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
     	 <table style="border-spacing:0px 20px;" >
		    <tr>
		    <td  style="width:100px; text-align: right; color: red;">
			对接省份:
		    </td>
		    <td style="width:500px;">
		    <a class="nui-menubutton"  menu="popupMenu3"id="timeStatus" name="timeStatus" style="margin-left: 5%; width: 10%;"></a>
		    </td>
		    <td>
		    <ul id="popupMenu3" class="nui-menu" style="display:none;">
                    <li>请选择</li>
                    <li>超级管理员</li>
                    <li>前台</li>
                    <li>连锁店店长</li>
               		<li>采购仓库</li>
                    <li>维修技师</li>
            </ul>
            </td>
		    </tr>
			 <tr>
		    <td  style="text-align: right; color: red;">
			维修厂编号:
		    </td>
		    <td><div class="nui-textbox" style="width: 65%;margin-left: 5%; "></div></td>
		    </tr>
		     <tr>
		    <td  style=" text-align: right; color: red;">
			用户名:
		    </td>
		    <td><div class="nui-textbox" style="width: 65%;margin-left: 5%; "></div></td>
		    </tr>
		     <tr>
		    <td  style=" text-align: right; color: red;">
			密码:
		    </td>
		    <td ><div class="nui-textbox" style="width: 65%;margin-left: 5%; "></div></td>
		    </tr>
		   </table>
		 <div style=" width: 100%;height: 5%;">
	 		<a class="nui-button" style= "float: right;">保存</a>
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

     <div class="mini-col-6" style="margin-top: 2%;">
                
                <div class="nui-panel" title="关怀提醒默认显示" width="80%" style="margin-left: 10%;" 
                    showCollapseButton="false" showCloseButton="false"  >
              		     显示建档人为本人的提醒：    <input name="Married" class="nui-checkbox" text="" value="N" trueValue="Y" falseValue="N" "/>
                </div>

     </div>
     <div class="mini-col-6" style="margin-top: 2%;">
                
                <div class="nui-panel" title="关怀提醒默认显示" width="80%" style="margin-left: 10%;" 
                    showCollapseButton="false" showCloseButton="false"  >
              		     显示服务顾问为本人的工单：    <input name="Married" class="nui-checkbox" text="" value="N" trueValue="Y" falseValue="N" "/>
                </div>

     </div>
     <div class="mini-col-6" style="margin-top: 2%;">
                
                <div class="nui-panel" title="关怀提醒默认显示" width="80%" style="margin-left: 10%;" 
                    showCollapseButton="false" showCloseButton="false"  >
              		     显示服务顾问为本人的工单：    <input name="Married" class="nui-checkbox" text="" value="N" trueValue="Y" falseValue="N" "/>
                </div>

     </div>
          <div class="mini-col-6" style="margin-top: 2%;">
                
                <div class="nui-panel" title="关怀提醒默认显示" width="80%" style="margin-left: 10%;" 
                    showCollapseButton="false" showCloseButton="false"  >
              		
              		     默认仓库：    <a class="nui-menubutton "  menu="#popupMenu"id="timeStatus" name="timeStatus">所有</a>
                 	 <ul id="popupMenu" class="nui-menu" style="display:none;">
                    <li>主仓库</li>
                  </ul>	
                </div>

    	 </div>
    	 <div class="mini-col-6" style="margin-top: 2%;">
                
                <div class="nui-panel" title="关怀提醒默认显示" width="80%" style="margin-left: 10%;" 
                    showCollapseButton="false" showCloseButton="false"  >
              		   结算单打印抬头显示：    <input  class="nui-textbox" />
                </div>

     	</div>
     	 <div style=" width: 100%;height: 10%;">
	 		<a class="nui-button" style="margin-top: 1.5%;  margin-right:10%;float: right;">保存</a>
	 
		 </div>
    </div>
     </div>


	
</body>
 <script type="text/javascript">
      
		nui.parse();

      
       
  </script>
</html>