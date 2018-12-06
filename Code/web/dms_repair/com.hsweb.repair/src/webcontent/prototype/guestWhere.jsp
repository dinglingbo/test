<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false" %>
	<%@include file="/common/sysCommon.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<!-- 
  - Author(s): Administrator
  - Date: 2018-12-04 18:35:20
  - Description:
-->
<head>
<title>客户在哪</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
    <script src="<%= request.getContextPath() %>/common/nui/nui.js" type="text/javascript"></script>
    	<style>
    	body,
				div,
				dl,
				dt,
				dd,
				ul,
				ol,
				li,
				h1,
				h2,
				h3,
				h4,
				h5,
				h6,
				p ,
				select{
					margin: 0;
					padding: 0;
					font-family: "微软雅黑", "宋体", "黑体", Arial, simsun, Verdana, Lucida, Helvetica, sans-serif;
					font-size: 14px;
					font-style: normal;
					font-weight: normal;
					font-variant: normal;
					list-style-type: none;
				}
			span.xiao{
				margin-top: 30px;
				font-size: 14px;
				font-weight:bold;
				text-align:center;
				float: left;
				width: 100%;
			}
			span.da{
				margin-top: 20px;
				font-size: 30px;
				font-weight:bolder;
				text-align:center;
				float: left;
				width: 100%;
			}
			span.zhong{
				margin-top: 20px;
				font-size: 20px;
				font-weight:bolder;
				text-align:center;
				float: left;
				width: 100%;
			}
			span.texiao{
				margin-top: 20px;
				font-size: 10px;
				font-weight:bolder;
				text-align:center;
				float: left;
				width: 100%;
				color: #836FFF;
			}
			a {
					margin-top: 25px;
					cursor: pointer;
				}
			font{
				color: #8B4513;
			}
			select{
			
			    width: 150px;
			    height: 33px;
			    font-weight: bold;
			    font-size: 14px;

			
			}
		</style>
</head>
<body>
	<div>
		<span class="xiao">Where are the customers 标签筛选</span></br>
		<span class="da">客户在哪为社区及派卡行动提供指南</span></br>
		<span class="xiao">数据来自ETCP,泊车链等全国最大的动态停车支付运营商，华胜签约获取全国超过2万家动态数据热力poi</br>
							数据为实时更新状态，点击城市或者社区可查看历史目标车型出行停留程度，目标车型包BENZ,BMW,AUDI<br>
							等高端车型。
		</span>

			<table align="center" style="">
				<tr>
					<td width="50%" align="right" >
						<select name="" id="" onchange="" >
							<option value="">选择城市</option>
							<option value="">广州</option>

						</select>
					</td>
					<td>
					 <select name="" id="" onchange="" >
						<option value="">选择社区</option>
						<option value="">品秀星源</option>
						<option value="">兰亭集序</option>
						<option value="">碧桂园凤凰亭</option>
					</select>
					</td>

				</tr>
				<tr>
					<td colspan="2" align="center">
						<img src="<%=webPath + contextPath%>/repair/prototype/images/11.jpg" width="620px" height="250px" text-align="center"/>
					</td>
				</tr>
				<tr>
					<td colspan="2" align="center">
						<span class="zhong">已为您搜索到9876名客户</span>
					</td>
				</tr>
				<tr>
					<td colspan="2" align="center">
						<a><span class="texiao">保存并添加其他标签筛选 <span class="fa fa-angle-right fa-2x" style="margin-left: 10px"></span></span></a>
					</td>
				</tr>
			</table>
	</div>



	<script type="text/javascript">

		$(document).ready(function(){
	
		});
    	nui.parse();

    </script>
</body>
</html>