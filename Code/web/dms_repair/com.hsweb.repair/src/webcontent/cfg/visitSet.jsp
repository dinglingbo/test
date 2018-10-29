<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false" %>
<%@ include file="/common/sysCommon.jsp"%>
<html>
<!-- 
  - Author(s): Administrator
  - Date: 2018-06-14 09:48:24
  - Description:
-->
<head>
<title>Title</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
   <script src="<%= webPath + contextPath %>/repair/cfg/js/visitSet.js?v=1.0.7"></script>
    
</head>
<body>
<div class="nui-fit">
	 <div style="background-color: #F0F0F0; width: 90%;height: 100%;  margin-left: 5%;">
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
			<input class="nui-hidden" name="workId"/>
			<input class="nui-hidden" name="washId"/>
			<input class="nui-hidden" name="zeroId"/>
			<input class="nui-hidden" name="claimId"/>
	 		<table border="1" style="margin-left: 2%; width:96%; border-spacing:1px 0px;">
	 		<tr>
	 		<td width="100px;" align="center">类别</td>
	 		<td width="200px;">第一次回访日</td>
	 		<td width="200px;">第二次回访日</td>
	 		<td width="200px;">第三次回访日</td>
	 		</tr>
	 		<tr>
	 		<td align="center">综合单</td>
	 		<td> 出厂	 
				 <input name="workScoutDay1" style="width: 12%" class="nui-spinner" format="0"  value="7" minValue="1" maxValue="371" showButton="false"/>
				 天后 
				 <div  class="nui-radiobuttonlist" style="display:inline-block;text-align: right; " name="workScoutDisable1" id="workScoutDisable1" textField="name" valueField="id" value="1" data="showList" ></div>
			</td>
	 		<td> 出厂	 
				<input name="workScoutDay2" style="width: 12%" class="nui-spinner" format="0"  value="30" minValue="1" maxValue="371" showButton="false"/>
				 天后 
				 <div  class="nui-radiobuttonlist" style="display:inline-block; text-align: right;" name="workScoutDisable2" id="workScoutDisable2" textField="name" valueField="id" value="1" data="showList"  ></div>
			</td>
	 		<td> 出厂	 
				 <input name="workScoutDay3" style="width: 12%" class="nui-spinner" format="0"  value="90" minValue="1" maxValue="371" showButton="false"/>
				 天后 
				 <div  class="nui-radiobuttonlist" style="display:inline-block; text-align: right;" name="workScoutDisable3" id="workScoutDisable3" textField="name" valueField="id" value="1"  data="showList"></div>
			</td>
	 		</tr>
	 		<tr>
	 		<td align="center">洗美单</td>
			<td> 出厂	 
				<input name="washScoutDay1" style="width: 12%" class="nui-spinner" format="0"  value="7" minValue="1" maxValue="371" showButton="false"/>
				天后 
				<div  class="nui-radiobuttonlist" style="display:inline-block; text-align: right;" name="washScoutDisable1" id="washScoutDisable1" textField="name" valueField="id" value="1" data="showList" ></div>
			</td>
	 		<td> 出厂	 
				 <input name="washScoutDay2" style="width: 12%" class="nui-spinner" format="0"  value="30" minValue="1" maxValue="371" showButton="false"/>
				 天后 
				 <div  class="nui-radiobuttonlist" style="display:inline-block; text-align: right;" name="washScoutDisable2" id="washScoutDisable2" textField="name" valueField="id" value="1" data="showList" ></div>
			</td>
	 		<td> 出厂	 
				 <input name="washScoutDay3" style="width: 12%" class="nui-spinner" format="0"  value="90" minValue="1" maxValue="371" showButton="false"/>
				 天后 
				 <div  class="nui-radiobuttonlist" style="display:inline-block; text-align: right;" name="washScoutDisable3" id="washScoutDisable3" textField="name" valueField="id" value="1" data="showList" ></div>
			</td>
	 		</tr>
	 		<tr>
	 		<td align="center">销售单</td>
			<td> 出厂	 
				<input name="zeroScoutDay1" style="width: 12%" class="nui-spinner" format="0"  value="7" minValue="1" maxValue="371" showButton="false"/>
				天后 
				<div  class="nui-radiobuttonlist" style="display:inline-block; text-align: right;" name="zeroScoutDisable1" id="zeroScoutDisable1" textField="name" valueField="id" value="1" data="showList" ></div>
			</td>
	 		<td> 出厂	 
				 <input name="zeroScoutDay2" style="width: 12%" class="nui-spinner" format="0"  value="30" minValue="1" maxValue="371" showButton="false"/>
				 天后 
				 <div  class="nui-radiobuttonlist" style="display:inline-block; text-align: right;" name="zeroScoutDisable2" id="zeroScoutDisable2" textField="name" valueField="id" value="1" data="showList" ></div>
			</td>
	 		<td> 出厂	 
				 <input name="zeroScoutDay3" style="width: 12%" class="nui-spinner" format="0"  value="90" minValue="1" maxValue="371" showButton="false"/>
				 天后 
				 <div  class="nui-radiobuttonlist" style="display:inline-block; text-align: right;" name="zeroScoutDisable3" id="zeroScoutDisable3" textField="name" valueField="id" value="1"  data="showList"></div>
			</td>
	 		</tr>
	 		<tr>
	 		<td align="center">理赔单</td>
			<td> 出厂	 
				<input name="claimScoutDay1" style="width: 12%" class="nui-spinner" format="0"  value="7" minValue="1" maxValue="371" showButton="false"/>
				天后 
				<div  class="nui-radiobuttonlist" style="display:inline-block; text-align: right;" name="claimScoutDisable1" id="claimScoutDisable1" textField="name" valueField="id" value="1"  data="showList"></div>
			</td>
	 		<td> 出厂	 
				 <input name="claimScoutDay2" style="width: 12%" class="nui-spinner" format="0"  value="30" minValue="1" maxValue="371" showButton="false"/>
				 天后 
				 <div  class="nui-radiobuttonlist" style="display:inline-block; text-align: right;" name="claimScoutDisable2" id="claimScoutDisable2" textField="name" valueField="id" value="1"  data="showList"></div>
			</td>
	 		<td> 出厂	 
				 <input name="claimScoutDay3" style="width: 12%" class="nui-spinner" format="0"  value="90" minValue="1" maxValue="371" showButton="false"/>
				 天后 
				 <div  class="nui-radiobuttonlist" style="display:inline-block; text-align: right;" name="claimScoutDisable3" id="claimScoutDisable3" textField="name" valueField="id" value="1"  data="showList"></div>
			</td>
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


</body>
</html>