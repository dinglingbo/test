<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false" %>
	
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<!-- 
  - Author(s): Administrator
  - Date: 2018-02-06 14:11:57
  - Description:
-->
<head>
<title>客户跟进记录</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
    <script src="<%= request.getContextPath() %>/common/nui/nui.js" type="text/javascript"></script>
    
</head>
<body style="margin: 0; height: 100%; width: 100%; overflow: hidden">
	<div  class="nui-toolbar"  style="height:50px">
        <div  class="nui-form1" id="form1" style="height:100%">
        	<input class="nui-hidden" name="criteria/_entity" value=""/>
        	<table class="table" id="table1" style="height:100% ">
        		<tr style="display: block; margin:-5px 0">
					<td>
						<span style="color:#0000FF;margin-left: 10px;">客户名称：</span>
					</td>
					<td>
						<span ></span>
					</td>
					<td>
						<span style="color:#0000FF;margin-left: 5px;">联系人：</span>
					</td>
					<td>
						<span ></span>
					</td>
					<td>
						<span style="color:#0000FF;margin-left: 5px;">车牌号：</span>
					</td>
					<td>
						<span ></span>
					</td>
				</tr>
        		<tr style="display: block;width:700px">
        	   		<td width="700px">
        	    		<label style="font-family:Verdana;">显示客户所有的联系记录，便于提供更合理的服务。</label>
        	    	</td>
                </tr>
			</table>
		</div>
	</div>
	<div id="mainTabs" class="nui-tabs" activeIndex="0" style="width: 100%; height: 90.5%;" plain="false"
		onactivechanged="">
		<div title="基本信息" url="../common/subpage/CustomerFollowUp_subpage/Telemarketing.jsp"></div>
		<div title="售后3DC回访 " url="../common/subpage/CustomerFollowUp_subpage/Aftermarket3DC.jsp"></div>
		<div title="满意度调研" url="../common/subpage/CustomerFollowUp_subpage/SatisfactionSurvey.jsp"></div>
		<div title="保养提醒" url="../common/subpage/CustomerFollowUp_subpage/Maintain.jsp"></div>
		<div title="特别关怀" url="../common/subpage/CustomerFollowUp_subpage/SpecialCare.jsp"></div>
		<div title="流失回访" url="../common/subpage/CustomerFollowUp_subpage/ReturnVisit.jsp"></div>
		<div title="美容回访" url="../common/subpage/CustomerFollowUp_subpage/CosmetologyVisit.jsp"></div>
		<div title="销售3DC回访 " url="../common/subpage/CustomerFollowUp_subpage/Sales3DC.jsp"></div>
		<div title="售后7DC回访" url="../common/subpage/CustomerFollowUp_subpage/Aftermarket7DC.jsp"></div>
	</div>


	<script type="text/javascript">
    	nui.parse();
    </script>
</body>
</html>