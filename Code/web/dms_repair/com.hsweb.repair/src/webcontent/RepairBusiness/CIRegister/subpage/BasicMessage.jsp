<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<!-- 
  - Author(s): Administrator
  - Date: 2018-01-27 10:02:38
  - Description:
-->
<head>
<title>基本信息</title>
<meta http-equiv="content-type" content="text/html; charset=UTF-8" />
<script src="<%= request.getContextPath() %>/common/nui/nui.js"
	type="text/javascript"></script>

</head>
<body style="margin: 0; height: 100%; width: 100%; overflow: hidden">
	<div class="nui-splitter" style="width: 100%; height: 100%"
		vertical="true">
		<div size="33%" showCollapseButton="false">
			<div class="nui-panel" title="保险基本信息" id="div_1"
				style="border-bottom: 0; padding: 0; width: 100%; height: 100%;">
				<div class="nui-fit" style="margin: 0;">
					<table>
						<tr>
							<!-- 第一列 -->
							<td width="70px">
								<div style="margin: 0px 0 0 10px">保险单号：</div>
								<div style="margin: 5px 0 0 10px">客户名称：</div>
								<div style="margin: 5px 0 0 10px">车牌号：</div>
								<div style="margin: 5px 0 0 10px">VIN：</div>
								<div style="margin: 5px 0 0 10px">车险专员：</div>
							</td>
							<td>
								<div style="margin: 0px 20px 0 0">
									<input class="nui-textbox" name="isDisabled" width="150px" />
								</div>
								<div style="margin: 6px 20px 0 0">
									<input class="nui-buttonedit" name="isDisabled" width="150px" />
								</div>
								<div style="margin: 6px 20px 0 0">
									<input class="nui-textbox" name="isDisabled" width="150px" />
								</div>
								<div style="margin: 6px 20px 0 0">
									<input class="nui-textbox" name="isDisabled" width="150px" />
								</div>
								<div style="margin: 6px 20px 0 0">
									<input class="nui-combobox" name="isDisabled" width="150px" />
								</div>
							</td>

							<!-- 第二列 -->
							<td width="70px">
								<div style="margin: 0px 0 0 10px">客户类型：</div>
								<div style="margin: 5px 0 0 10px">被保险人：</div>
								<div style="margin: 5px 0 0 10px">品牌 ：</div>
								<div style="margin: 5px 0 0 10px">发动机号：</div>
								<div style="margin: 5px 0 0 10px">制单员：</div>
							</td>
							<td>
								<div style="margin: 0px 20px 0 0">
									<input class="nui-combobox" name="isDisabled" width="150px" />
								</div>
								<div style="margin: 6px 20px 0 0">
									<input class="nui-textbox" name="isDisabled" width="150px" />
								</div>
								<div style="margin: 6px 20px 0 0">
									<input class="nui-combobox" name="isDisabled" width="150px" />
								</div>
								<div style="margin: 6px 20px 0 0">
									<input class="nui-textbox" name="isDisabled" width="150px" />
								</div>
								<div style="margin: 6px 20px 0 0">
									<input class="nui-textbox" name="isDisabled" width="150px" />
								</div>
							</td>

							<!-- 第三列 -->
							<td width="70px">
								<div style="margin: 25px 0 0 10px"></div>
								<div style="margin: 5px 0 0 10px">联系电话：</div>
								<div style="margin: 5px 0 0 10px">车型：</div>
								<div style="margin: 5px 0 0 10px">购买日期：</div>
								<div style="margin: 5px 0 0 10px">保险类型：</div>
							</td>
							<td>
								<div style="margin: 27px 20px 0 0"></div>
								<div style="margin: 6px 20px 0 0">
									<input class="nui-textbox" name="isDisabled" width="150px" />
								</div>
								<div style="margin: 6px 20px 0 0">
									<input class="nui-textbox" name="isDisabled" width="150px" />
								</div>
								<div style="margin: 6px 20px 0 0">
									<input id="data" class="nui-datepicker" value=""
										nullValue="null" format="yyyy-MM-dd HH:mm:ss"
										timeFormat="HH:mm:ss" showTime="true" showOkButton="true"
										showClearButton="false" width="150px" />
								</div>
								<div style="margin: 6px 20px 0 0">
									<input class="nui-combobox" name="isDisabled" width="150px" />
								</div>
							</td>
						</tr>
					</table>
				</div>
			</div>
		</div>

		<div showCollapseButton="false">
			<div class="nui-splitter" style="width: 100%; height: 100%;"
				vertical="true">
				<div size=50% " showCollapseButton="false">
					<div class="nui-panel" title="交强险信息" id="div_1"
						style="border-bottom: 0; padding: 0px; width: 100%; height: 100%;">
						<div class="nui-fit">
							<table style="margin: 0; padding: 0;">
								<tr>
									<td style="width: 90px">
										<div style="margin: 0">交强险保单号：</div>
										<div style="margin: 10px 0 0 0">投保公司：</div>
										<div style="margin: 10px 0 0 0">投保内容：</div>
									</td>
									<td>
										<div style="margin: 20px 0 0 0">
											<input class="nui-textbox" style="width: 120px;" /> 投保日期： <input
												id="data" class="nui-datepicker" value="" nullValue="null"
												format="yyyy-MM-dd " timeFormat="HH:mm:ss" showTime="true"
												showOkButton="true" showClearButton="false" width="150px" />

											到期日期： <input id="data" class="nui-datepicker" value=""
												nullValue="null" format="yyyy-MM-dd " timeFormat="HH:mm:ss"
												showTime="true" showOkButton="true" showClearButton="false"
												width="150px" />
										</div>
										<div>
											<input class="nui-combobox"
												style="width: 400px; margin: 10px 0 0 0" allowInput="true" />
										</div>
										<div>
											<input class="nui-textarea"
												style="width: 600px; height: 40px; margin: 10px 0 0 0"
												allowInput="true" />
										</div>
									</td>
								</tr>

							</table>
						</div>
					</div>
				</div>
				<div showCollapseButton="false">
					<div class="nui-panel" title="商业险信息" id="div_1"
						style="border-bottom: 0; padding: 0px; width: 100%; height: 100%;">
						<div class="nui-fit">
							<table style="margin: 0; padding: 0;">
								<tr>
									<td style="width: 90px">
										<div style="margin: 0">商业险保单号：</div>
										<div style="margin: 10px 0 0 0">投保公司：</div>
										<div style="margin: 10px 0 0 0">投保内容：</div>
									</td>
									<td>
										<div style="margin: 20px 0 0 0">
											<input class="nui-textbox" style="width: 120px;" /> 投保日期： <input
												id="data" class="nui-datepicker" value="" nullValue="null"
												format="yyyy-MM-dd " timeFormat="HH:mm:ss" showTime="true"
												showOkButton="true" showClearButton="false" width="150px" />

											到期日期： <input id="data" class="nui-datepicker" value=""
												nullValue="null" format="yyyy-MM-dd " timeFormat="HH:mm:ss"
												showTime="true" showOkButton="true" showClearButton="false"
												width="150px" />
										</div>
										<div>
											<input class="nui-combobox"
												style="width: 400px; margin: 10px 0 0 0" allowInput="true" />
										</div>
										<div>
											<input class="nui-textarea"
												style="width: 600px; height: 40px; margin: 10px 0 0 0"
												allowInput="true" />
										</div>
									</td>
								</tr>

							</table>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>







	<script type="text/javascript">
    	nui.parse();
    </script>
</body>
</html>