<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">	
<%@ include file="/common/sysCommon.jsp"%>

<html>
<!-- 
  - Author(s): Administrator
  - Date: 2018-06-14 09:48:24
  - Description:
-->

<head>
	<title>回访设置</title>
	<meta http-equiv="content-type" content="text/html; charset=UTF-8" />
	<script src="<%= request.getContextPath() %>/config/js/visitSet.js?v=1.7.8"></script>

</head>

<body>
	<div style="background-color: #F0F0F0; width: 90%;height: 70%; margin-top: 3%; margin-left: 5%;">
		<div style="width: 90%; height: 50%;  margin-left: 5%;">

			<span>
				<br>
				<br> 注：出厂（仅第一次收款）时，根据“预定回访日设置(1天～371天)”：
				<br>      1、自动生成各时间的
				<span style="color: red;">回访单</span>，其中回访单中“预定回访日”为“预定回访日设置”计算出的日期
				<br>      2、在到达预定回访日时系统会自动生成
				<span style="color: red;">回访提醒</span>
				<br>
				<br> 预定回访日设置
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
								<td>出厂
									<div class="nui-textbox" style="width: 10%" value="7" name="workScoutDay1"></div>天后
									<div class="nui-radiobuttonlist" style="display:inline-block; margin-left: 10%;" name="workScoutDisable1"
									    id="workScoutDisable1" textField="name" valueField="id" value="1" data="showList"></div>
								</td>
								<td>出厂
									<div class="nui-textbox" style="width: 10%" value="30" name="workScoutDay2"></div>天后
									<div class="nui-radiobuttonlist" style="display:inline-block; margin-left: 10%;" name="workScoutDisable2"
									    id="workScoutDisable2" textField="name" valueField="id" value="1" data="showList"></div>
								</td>
								<td>出厂
									<div class="nui-textbox" style="width: 10%" value="90" name="workScoutDay3"></div>天后
									<div class="nui-radiobuttonlist" style="display:inline-block; margin-left: 10%;" name="workScoutDisable3"
									    id="workScoutDisable3" textField="name" valueField="id" value="1" data="showList"></div>
								</td>
							</tr>
							<tr>
								<td align="center">洗车单</td>
								<td>出厂
									<div class="nui-textbox" style="width: 10%" value="7" name="washScoutDay1"></div>天后
									<div class="nui-radiobuttonlist" style="display:inline-block; margin-left: 10%;" name="washScoutDisable1"
									    id="washScoutDisable1" textField="name" valueField="id" value="1" data="showList"></div>
								</td>
								<td>出厂
									<div class="nui-textbox" style="width: 10%" value="30" name="washScoutDay2"></div>天后
									<div class="nui-radiobuttonlist" style="display:inline-block; margin-left: 10%;" name="washScoutDisable2"
									    id="washScoutDisable2" textField="name" valueField="id" value="1" data="showList"></div>
								</td>
								<td>出厂
									<div class="nui-textbox" style="width: 10%" value="90" name="washScoutDay3"></div>天后
									<div class="nui-radiobuttonlist" style="display:inline-block; margin-left: 10%;" name="washScoutDisable3"
									    id="washScoutDisable3" textField="name" valueField="id" value="1" data="showList"></div>
								</td>
							</tr>
							<tr>
								<td align="center">零售单</td>
								<td>出厂
									<div class="nui-textbox" style="width: 10%" value="7" name="zeroScoutDay1"></div>天后
									<div class="nui-radiobuttonlist" style="display:inline-block; margin-left: 10%;" name="zeroScoutDisable1"
									    id="zeroScoutDisable1" textField="name" valueField="id" value="1" data="showList"></div>
								</td>
								<td>出厂
									<div class="nui-textbox" style="width: 10%" value="30" name="zeroScoutDay2"></div>天后
									<div class="nui-radiobuttonlist" style="display:inline-block; margin-left: 10%;" name="zeroScoutDisable2"
									    id="zeroScoutDisable2" textField="name" valueField="id" value="1" data="showList"></div>
								</td>
								<td>出厂
									<div class="nui-textbox" style="width: 10%" value="90" name="zeroScoutDay3"></div>天后
									<div class="nui-radiobuttonlist" style="display:inline-block; margin-left: 10%;" name="zeroScoutDisable3"
									    id="zeroScoutDisable3" textField="name" valueField="id" value="1" data="showList"></div>
								</td>
							</tr>
							<tr>
								<td align="center">理赔单</td>
								<td>出厂
									<div class="nui-textbox" style="width: 10%" value="7" name="claimScoutDay1"></div>天后
									<div class="nui-radiobuttonlist" style="display:inline-block; margin-left: 10%;" name="claimScoutDisable1"
									    id="claimScoutDisable1" textField="name" valueField="id" value="1" data="showList"></div>
								</td>
								<td>出厂
									<div class="nui-textbox" style="width: 10%" value="30" name="claimScoutDay2"></div>天后
									<div class="nui-radiobuttonlist" style="display:inline-block; margin-left: 10%;" name="claimScoutDisable2"
									    id="claimScoutDisable2" textField="name" valueField="id" value="1" data="showList"></div>
								</td>
								<td>出厂
									<div class="nui-textbox" style="width: 10%" value="90" name="claimScoutDay3"></div>天后
									<div class="nui-radiobuttonlist" style="display:inline-block; margin-left: 10%;" name="claimScoutDisable3"
									    id="claimScoutDisable3" textField="name" valueField="id" value="1" data="showList"></div>
								</td>
							</tr>
						</table>

					</div>
				</div>
			</div>
			<div style=" width: 100%;height: 10%; margin-top: 3%;">

				<a class="nui-button" style="margin-top: 1.5%;  float: right; margin-right:10%;" onclick="returnFormSet">保存</a>
			</div>
		</div>
	</div>



</body>

</html>