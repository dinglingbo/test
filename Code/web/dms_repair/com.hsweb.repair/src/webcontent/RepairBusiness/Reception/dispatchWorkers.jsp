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
<title>班组选择</title>
<script
	src="<%=request.getContextPath()%>/repair/RepairBusiness/Reception/js/dispatchWorkers.js?v=1.1.2"></script>
	<style type="text/css">
	.show {
    background: #c0e1fd;
    color: #1582de;
}
.none{	
	 width: 60px;
    height: 30px;
    font-size: 18px;
    text-align: center;

    border-radius: 5px;
    text-decoration: none;
    line-height: 2;
	background: #a596963d;
}
a {
  cursor:pointer;
}
	</style>
</head>
	<body>
		<div>
			<table>
				<tr>
					<td >
						为本单项目类型派工：
					</td>
				</tr>
				<tr>
					<td >
						<div id="Project" style="width: 100%;height: 100%;">
							
						</div>
					</td>
				</tr>
				<tr>	
					<td width="90px" >
						选择方式：
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
							耗时工时：<input class="nui-textbox" width="50px"/>天<input class="nui-textbox" width="50px"/>时<input class="nui-textbox" width="50px"/>分<br>
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
					<td >
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