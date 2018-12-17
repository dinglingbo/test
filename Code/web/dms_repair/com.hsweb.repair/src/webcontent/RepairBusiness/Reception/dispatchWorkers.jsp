<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false"%>
<%@include file="/common/commonRepair.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<%--
    - Author(s): huang
    - Date: 2014-08-13 12:27:01
    - Description:
  --%>

<head>
<title>维修历史</title>
<script
	src="<%=request.getContextPath()%>/repair/RepairBusiness/Reception/js/dispatchWorkers.js?v=1.0.1"></script>
	<style type="text/css">
	a:hover {
    background: #c0e1fd;
    color: #1582de;
}
a.show{
	
}
	</style>
</head>
	<body>
		<div>
			<table>
				<tr>
					<td>
						预计结束时间
					</td>
					<td></td>
				</tr>
				<tr>	
					<td>
						选择方式：
					</td>
					<td colspan="1" >
						<div class="mini-radiobuttonlist" repeatItems="1"
							repeatLayout="table" repeatDirection="vertical" name="isShare"
							textField="text" valueField="value"
							data="[{value:'0',text:'耗时选择',},{value:'1',text:'时间选择器'}]" value="0" onvaluechanged="">
						</div>
					</td>
					
				</tr>
				<tr>
					<td>
						<div>
							耗时工时：<input class="nui-textbox"/>天<input class="nui-textbox"/>时<input class="nui-textbox"/>分<br>
							<a  class="show"  style="padding: 0px 10px;margin-bottom: 0;border-radius: 4px;line-height: 24px;">
							15m</a>
							<a  class="show"  style="padding: 0px 10px;margin-bottom: 0;border-radius: 4px;line-height: 24px;">
							30m</a>
							<a  class="show"  style="padding: 0px 10px;margin-bottom: 0;border-radius: 4px;line-height: 24px;">
							1h</a>
							<a  class="show"  style="padding: 0px 10px;margin-bottom: 0;border-radius: 4px;line-height: 24px;">
							2h</a>
							<a  class="show"  style="padding: 0px 10px;margin-bottom: 0;border-radius: 4px;line-height: 24px;">
							3h</a>
							<a  class="show"  style="padding: 0px 10px;margin-bottom: 0;border-radius: 4px;line-height: 24px;">
							4h</a>
							<a  class="show"  style="padding: 0px 10px;margin-bottom: 0;border-radius: 4px;line-height: 24px;">
							1d</a>
							<a  class="show"  style="padding: 0px 10px;margin-bottom: 0;border-radius: 4px;line-height: 24px;">
							2d</a>
						</div>
					</td>
				</tr>
				<tr>
					<td>
						预计完工时间：2018-12-18 00.09
					</td>
				</tr>
			</table>
		</div>
		<div>
			<div id="team" runat="server">
			
			</div>
			<div id="empl">
				
			</div>
		</div>
	</body>
</html>