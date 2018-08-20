<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false" %>	
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ include file="/common/sysCommon.jsp"%>
<html>
<!-- 
  - Author(s): localhost
  - Date: 2018-07-08 15:13:55
  - Description:
-->
<head>
<title>基础设置</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
    <script src="<%=webPath + contextPath%>/config/js/basicDeductParamsSet.js?v=1.0.0"></script>
</head>
<style type="text/css">
    body {
        margin: 0;
        padding: 0;
        border: 0;
        width: 100%;
        height: 100%;
        overflow: hidden;
    }
</style>
<body>
<div class="nui-fit">
	<div id="basicInfoForm" class="form" contenteditable="false" >
		<table align= "center" >
			<tr>
				<td style="text-align: right;">
						<label>是否启用技师等级分配提成：</label>
				</td>
				<td>
					<div id="repairMemLevelDeductFlag" name="repairMemLevelDeductFlag" 
							class="nui-radiobuttonlist" value="" repeatItems="2" 
							repeatDirection="" repeatLayout="table" 
							textField="text" valueField="id" ></div>
				</td>
			</tr>
			<tr>	 
				<td style="text-align: right;">
					<label>绩效核算指标：</label>
				</td>
				<td>
					<div id="repairDeductKpiFlag" name="repairDeductKpiFlag" 
						class="nui-radiobuttonlist" value="" repeatItems="3" 
						repeatDirection="" repeatLayout="table" 
						textField="text" valueField="id" ></div>
				</td>
			</tr>
            <tr>
				<td colspan="2" style="text-align: center;">
					<a class="nui-button" onclick="save()"   plain="false" >保存</a>
				</td>
			</tr>
		</table>
	</div>
</div>
	<script type="text/javascript">
    	nui.parse();
    </script>
</body>
</html>