<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false" %>
	<%@include file="/common/sysCommon.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<!-- 
  - Author(s): Administrator
  - Date: 2018-12-05 08:55:03
  - Description:
-->
<head>
<title>会员选择</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
    <script src="<%= request.getContextPath() %>/common/nui/nui.js" type="text/javascript"></script>
    <style type="text/css">
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
		a.btn{
				width: 300px;
				height: 50px;
				font-size: 20px;
				background: #E6E6FA;
				color: #fff;
				text-align: center;
				display: block;
				border-radius: 5px;
				text-decoration: none;
				line-height: 2;
				margin-left: 190px;
			}
		a.btn:visited{
				width: 300px;
				height: 50px;
				font-size: 20px;
				background: #8EE5EE;
				color: #fff;
				text-align: center;
				display: block;
				border-radius: 5px;
				text-decoration: none;
				line-height: 2;
				margin-left: 190px;
			}
 		a.btn:active,a.btn:hover{
				width: 300px;
				height: 50px;
				font-size: 20px;
				background: #836FFF;
				color: #fff;
				text-align: center;
				display: block;
				border-radius: 5px;
				text-decoration: none;
				line-height: 2;
				margin-left: 190px;
		} 

 		 
			.up{
				color: #CCC;
			}
			.down{
				color: #FFA500;
			}		span.da{
				margin-top: 20px;
				margin-left: 80px;
				font-size: 30px;
				font-weight:bolder;
				float: left;
				width: 100%;
			}
			span.xiao{
				
				font-size: 15px;
				
			}
 		div.xuan {
			vertical-align:middle;
			display:table-cell;		
			width: 260px;
			height: 30px;
			background-color: #FFFFFF;
			padding-bottom: 40px;	
    		border:1px solid #CCC;
    		margin-left:60px;
    		float:left;
		} 
		.yuan{		
			
			margin-right:30px;
			float:right;
		}
 
    </style>
</head>
<body >
	<div style="width:660px;height:100px;">
		<span class="da">请选择会员类型</span>
	</div>
	
	<div style="width:660px;height:100px;">
			<div class="xuan" >
				<span class="xiao" ></br>非会员</span> <a  id="a1" onclick="settleOK(this.id)" class="tu"><span class="fa fa-check-circle fa-2x yuan" > </span></a>	
			</div>
			<div class="xuan" >
				<span class="xiao" ></br>plus会员</span> <a  id="a2" onclick="settleOK(this.id)" class="tu"><span class="fa fa-check-circle fa-2x yuan" > </span></a>
			</div >
			<div class="clear:both"></div>
	</div>		
	<br>
	<div style="width:660px;height:100px;">
			<div class="xuan" >
				<span class="xiao" ></br>普通会员</span> <a id="a3" onclick="settleOK(this.id)" class="tu"><span class="fa fa-check-circle fa-2x yuan" > </span></a>
			</div >
			<div class="xuan" >
				<span class="xiao" ></br>金牌会员</span> <a  id="a4" onclick="settleOK(this.id)" class="tu"><span class="fa fa-check-circle fa-2x yuan" > </span></a>
			</div>
			<div class="clear:both"></div>
	</div>
	<div style="width:660px;height:100px;">
			<div class="xuan" >
				<span class="xiao" ></br>普通会员</span> <a  id="a5" onclick="settleOK(this.id)" class="tu"><span class="fa fa-check-circle fa-2x yuan" > </span></a>
			</div >
			<div class="xuan" >
				<span class="xiao" ></br>金牌会员</span> <a  id="a6" onclick="settleOK(this.id)" class="tu"><span class="fa fa-check-circle fa-2x yuan" > </span></a>
			</div>
			<div class="clear:both"></div>
	</div>
	
	<div style="width:660px;height:100px;">
		<a href=""  class="btn"  onclick="memberType()">确定</a>
	</div>
	<script type="text/javascript">
		var color = "a1";
		$(document).ready(function(){
			settleOK(color);
		});
    	nui.parse();
	    	function settleOK(e){
					document.getElementById(color).setAttribute("class", "up");
					color = e;
					document.getElementById(color).setAttribute("class", "down");

			}
		function memberType(){
				 nui.open({
			         url: webPath + contextPath + "/com.hsweb.RepairBusiness.membersTypeChoose.flow?token="+token,
			         title: '近期活动',
			         width: 800, height: 580,
			         onload: function () {

			         },
			         ondestroy: function (action)
			         {

			         }
     });
		}
    </script>
</body>
</html>