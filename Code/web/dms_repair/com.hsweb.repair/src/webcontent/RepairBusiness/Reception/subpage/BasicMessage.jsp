<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<!-- 
  - Author(s): Administrator
  - Date: 2018-01-25 15:23:28
  - Description:
-->
<head>
<title>维修接待</title>
<meta http-equiv="content-type" content="text/html; charset=UTF-8" />
<script src="<%= request.getContextPath() %>/common/nui/nui.js"
	type="text/javascript"></script>

</head>
<body style="margin: 0; height: 100%; width: 100%; overflow: hidden">

	<!-- 上下 -->
	<div class="nui-splitter" handlerSize="2" showHandleButton="false"
		style="width: 100%; height: 100%;" borderStyle="border:1"
		vertical="true">
		<div size="40%" showCollapseButton="falses">
			<!-- 基本信息 -->
			<div class="nui-panel" title="基本信息" id="div_1"
				style="border-bottom: 0; padding: 0px; width: 100%; height: 100%;">
				<div class="nui-fit">
					<span style="margin-left: 20px; margin-top: 10px;">车牌号：</span> <input
						class="nui-textbox" style="width: 14%; margin-top: 10px;" /> <span
						style="margin-left: 20px; margin-top: 10px;"> <a
						class="nui-button" id="save" onclick="save()">改</a>
					</span> <span style="margin-left: 20px; margin-top: 10px;">业务类型：</span> <input
						class="nui-combobox" style="width: 14%; margin-top: 10px;" /> <span
						style="margin-left: 20px; margin-top: 10px;">维修类型：</span> <input
						class="nui-combobox" style="width: 13%; margin-top: 10px;" /></br> <span
						style="margin-left: 20px; margin-top: 10px;">维修顾问：</span> <input
						class="nui-combobox" allowInput="true" textField="text"
						valueField="id" value="cn" showNullItem="true"
						style="width: 14%; margin-top: 10px;" /> <span
						style="margin-left: 20px; margin-top: 10px;">进厂油量：</span> <input
						class="nui-combobox" style="width: 14%; margin-top: 10px;" /> <span
						style="margin-left: 20px; margin-top: 10px;">进厂里程：</span> <input
						class="nui-textbox" style="width: 13%; margin-top: 10px;" /></br> <span
						style="margin-left: 20px; margin-top: 10px;">进厂日期：</span> <input
						id="data" style="margin-top: 10px;" class="nui-datepicker"
						value="" nullValue="null" format="yyyy-MM-dd HH:mm:ss"
						timeFormat="HH:mm:ss" showTime="true" showOkButton="true"
						showClearButton="false" /> <span
						style="margin-left: 20px; margin-top: 10px;">报价日期：</span> <input
						id="data" style="margin-top: 10px;" class="nui-datepicker"
						value="" nullValue="null" format="yyyy-MM-dd HH:mm:ss"
						timeFormat="HH:mm:ss" showTime="true" showOkButton="true"
						showClearButton="false" /> <span
						style="margin-left: 20px; margin-top: 10px;">维修日期：</span> <input
						id="data" style="margin-top: 10px;" class="nui-datepicker"
						value="" nullValue="null" format="yyyy-MM-dd HH:mm:ss"
						timeFormat="HH:mm:ss" showTime="true" showOkButton="true"
						showClearButton="false" /> </br> <span
						style="margin-left: 20px; margin-top: 10px;">完工日期：</span> <input
						id="data" style="margin-top: 10px;" class="nui-datepicker"
						value="" nullValue="null" format="yyyy-MM-dd HH:mm:ss"
						timeFormat="HH:mm:ss" showTime="true" showOkButton="true"
						showClearButton="false" /> <span
						style="margin-left: 20px; margin-top: 10px;">预计交车：</span> <input
						id="data" style="margin-top: 10px;" class="nui-datepicker"
						value="" nullValue="null" format="yyyy-MM-dd HH:mm:ss"
						timeFormat="HH:mm:ss" showTime="true" showOkButton="true"
						showClearButton="false" /> <span
						style="margin-left: 20px; margin-top: 10px;">接车卡号：</span> <input
						class="nui-textbox" style="width: 20%; margin-top: 10px;" /></br> <span
						style="margin-left: 20px; margin-top: 10px;">是否洗车：</span> <input
						class="nui-combobox" style="width: 5%; margin-top: 10px;" /> <span
						style="margin-left: 20px; margin-top: 10px;">备注：</span> <input
						class="nui-textbox" style="width: 50%; margin-top: 10px;" />
				</div>
			</div>
		</div>

		<div>
			<div class="nui-splitter" handlerSize="2" showHandleButton="false"
				style="width: 100%; height: 100%;" borderStyle="border:0"
				vertical="true">
				<div showCollapseButton="false" size="50%">
					<!-- 描述信息 -->
					<div class="nui-panel" title="描述信息" id="div_1"
						style="border-bottom: 0; padding: 0px; width: 100%; height: 100%;">
						<div class="nui-fit">
							<table>
								<tr>
									<td>
										<div style="margin: 0 0 0 4px">
											客户描述：
											<div style="margin-top: 5px">
												<input class="nui-textarea"
													style="width: 295px; height: 80px;" />
											</div>
										</div>
									</td>
									<td>
										<div style="margin: 0 0 0 4px">
											解决措施：
											<div style="margin-top: 5px">
												<input class="nui-textarea"
													style="width: 295px; height: 80px;" />
											</div>
										</div>
									</td>
									<td>
										<div style="margin: 0 0 0 4px">
											故障现象：
											<div style="margin-top: 5px">
												<input class="nui-textarea"
													style="width: 295px; height: 80px;" />
											</div>
										</div>
									</td>
								</tr>
							</table>
						</div>
					</div>
				</div>

				<div showCollapseButton="false">
					<!-- 客户/车辆信息 -->

					<div class="nui-panel" title="客户/车辆信息" id="div_1"
						style="border-bottom: 0; padding: 0; width: 100%; height: 100%;">
						<div class="nui-fit">
							<table>
								<tr>
									<td width="80px">
										<div style="margin: 10px 0 0 10px">VIN：</div>
										<div style="margin: 10px 0 0 10px">发动机：</div>
										<div style="margin: 10px 0 0 0px">联系人姓名：</div>
									</td>
									<td>
										<div style="margin: 10px 20px 0 0">
											<input class="nui-textbox" style="width: 150px;" />
										</div>
										<div style="margin: 10px 20px 0 0">
											<input class="nui-textbox" style="width: 150px;" />
										</div>
										<div style="margin: 10px 20px 0 0">
											<input class="nui-textbox" style="width: 150px;" />
										</div>
									</td>

									<td width="70px">
										<div style="margin: 5px 0 0 10px">车型：</div>
										<div style="margin: 10px 0 0 10px">客户名称：</div>
										<div style="margin: 10px 0 0 10px">身份：</div>
									</td>
									<td>
										<div style="margin: 10px 20px 0 0">
											<input class="nui-combobox" style="width: 300px;" />
										</div>
										<div style="margin: 10px 20px 0 0">
											<input class="nui-combobox" style="width: 300px;" />
										</div>
										<div>
											<input class="nui-textbox"
												style="width: 120px; margin: 10px 3px 0 0;" /> <span
												style="margin: 30px 0 0 0;">手机号码：</span> <input
												class="nui-textbox"
												style="width: 110px; margin: 10px 0 0 0;" />
										</div>
									</td>
								</tr>
							</table>
						</div>
					</div>

				</div>
			</div>

			<!-- 竖向splitter结束 -->
		</div>

	</div>





	<script type="text/javascript">
    	nui.parse();
    	
    	
    </script>
</body>
</html>