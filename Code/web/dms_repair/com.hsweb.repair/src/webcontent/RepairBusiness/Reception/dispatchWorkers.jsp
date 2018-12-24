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
	<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<title>班组选择</title>
<script
	src="<%=request.getContextPath()%>/repair/RepairBusiness/Reception/js/dispatchWorkers.js?v=1.8.7"></script>
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
					font-size: 15px;
					font-style: normal;
					font-weight: normal;
					font-variant: normal;
					list-style-type: none;
				}
table {
  border-collapse:separate;
  border-spacing: 7px;
  }
body{
	overflow:auto;
	background:#f5f5f5;
}
.none{	
	 width: 90px;
    height: 30px;
    font-size: 18px;
    text-align: center;
	margin-left:20px;
    border-radius: 5px;
    text-decoration: none;
    line-height: 2;
	background: #FFF;
    color: #4eb7f5;

    float:right;
    margin-right: 0px;
}
.none1{	
	 width: 90px;
    height: 30px;
    font-size: 18px;
    text-align: center;
	margin-left:20px;
    border-radius: 5px;
    text-decoration: none;
    line-height: 2;
	background: #f5f5f5;
	color:#333;
    float:right;
    margin-right: 0px;
}
.empl{	
	 width: 90px;
    height: 30px;
    font-size: 18px;
    text-align: center;
	margin-left:20px;
    border-radius: 40px;
    text-decoration: none;
    line-height: 2;
	background: #f5f5f5;
    color: #4eb7f5;
    border: 1px solid #c0e1fd;
}
.empl1{	
	 width: 90px;
    height: 30px;
    font-size: 18px;
    text-align: center;
	margin-left:20px;
    border-radius: 40px;
    text-decoration: none;
    line-height: 2;
	background: #3899ec3d;
    color: #4eb7f5;
    border: 1px solid #c0e1fd;
}
.sj{	

        background: #fff;
    color: #4eb7f5;
    font-size: 18px;
    text-align: center;
	margin-left:20px;
    border-radius: 5px;
    text-decoration: none;
    line-height: 2;
	border: 1px solid #c0e1fd;
}
a.sj:hover {	

    font-size: 18px;
    text-align: center;
	margin-left:20px;
    border-radius: 0px;
    text-decoration: none;
    line-height: 2;
	    background: #3899ec;
    border-color: #3899ec;
}
.show{	
	 width: 60px;
    height: 30px;
    font-size: 18px;
    text-align: center;
	margin-left:20px;
    border-radius: 0px;
    text-decoration: none;
    line-height: 2;
	background: #c0e1fd;
}
#kong{
	width:100%;
	padding-bottom: 0px;
	padding-left: 0px;
	 border-bottom: 2px #dcdcdc solid;
}
#team{
	float:left;
	width:25%;
	margin-top:5px;
	display:inline;
	background: #FFF;
}
#empl{
	float:left;
	width:75%;
	height:70%;
	margin-top:5px;
	background: #f5f5f5;
	display:inline;
}
.da{
	font-size: 18px;
	margin-top: 20px;
}
.xiao{
	font-size: 14px;
	color:#999;
}
a {
  cursor:pointer;
}
label{
    margin-right: 10px;
}
.xline{border-bottom:solid 2px #dcdcdc; height:5px;width: 600px;}
	</style>
</head>
	<body >

		<div>
			<table>
				<tr >
					<td  >
						<span class="da">项目类型</span>
					</td>
				</tr>
 				<tr>
					<td >	
					<div class="xline" ></div>
					</td>
				</tr> 
				<tr>
					<td >
					<div id="serviceTypeIds" name="serviceTypeIds" class="nui-checkboxlist" repeatItems="5" repeatLayout="table"
                    repeatLayout="flow"  value="" 
                    textField="name" valueField="id" ></div>
					</td>
				</tr>
				<tr >
					<td  >
						<span class="da">预计完工时间</span>
					</td>
				</tr>
 				<tr>
					<td >	
					<div class="xline" ></div>
					</td>
				</tr> 
<!--  				<tr>	
					<td >
						<div style="display:inline;width:100%;">
							<font size="3">选择方式：</font>  
							<div class="mini-radiobuttonlist" repeatItems="1"
								repeatLayout="table" repeatDirection="vertical" name="isShare"
								textField="text" valueField="value"
								data="[{value:'0',text:'耗时选择',},{value:'1',text:'时间选择器'}]" value="0" onvaluechanged="">		
							</div>
						</div>
					</td>
					
				</tr> -->
 				<tr>
					<td>
						<div>
							<span class="xiao">施工耗时：</span>
							<input class="nui-textbox" id="day" width="50px" onvalueChanged="times(this.id)"/>天<input class="nui-textbox" id="hour" width="50px" onvalueChanged="times(this.id)"/>时<input class="nui-textbox" id="min" width="50px" onvalueChanged="times(this.id)" />分<br>
							
							<a  class="sj" style="margin-left: 80px;" onclick="timeStamp(15)" >15m</a>
							<a  class="sj" onclick="timeStamp(30)" >30m</a>
							<a  class="sj" onclick="timeStamp(60)" >1h</a>
							<a  class="sj" onclick="timeStamp(120)" >2h</a>
							<a  class="sj" onclick="timeStamp(180)" >3h</a>
							<a  class="sj" onclick="timeStamp(240)" >4h</a>
							<a  class="sj" onclick="timeStamp(1440)" >1d</a>
							<a  class="sj" onclick="timeStamp(2880)" >2d</a>
						</div>

					</td>
				</tr>
				<tr>
					<td >
						<span class="xiao">预计完工时间：</span>
						<input class="nui-textbox" id="planFinishDate" name="planFinishDate">
					</td>
				</tr> 
								<tr>
					<td>
						<span class="da">施工人员</span>
					</td>
				</tr>
			</table>
		</div>
		<div id="kong">
			<div id="team" >
				
			</div>
			<div id="empl">
				
			</div>
		</div>
		<div style="background-color: #cfddee;position:fixed; top:90%;width:100%;height: 10%; z-index:900;">
			 <table style="width:100%;">
                    <tr>
                        <td style="width:100%;">
                          <a id="wxbtnsettle" style="    width: 80px;
							height: 40px;
							font-size: 18px;
							background: #FFF;
							color: #333;
							text-align: center;
							display: block;
							border-radius: 5px;
							line-height: 2;
							float:right;
								margin-right:0px;
								margin-left:10px;
							text-decoration: none;" 
							href="javascript:void(0)" onclick="onClose()" >取消</a>
							
						 <a id="wxbtnsettle" style="    width: 120px;
							height: 40px;
							font-size: 18px;
							background: #2ac476;
							color: #FFF;
							text-align: center;
							display: block;
							border-radius: 5px;
							line-height: 2;
								float:right;
								margin-right:0px;
							text-decoration: none;" 
							href="javascript:void(0)" onclick="dispatchOk()" >派工</a>
                           
                        </td>
                    </tr>
                </table>
		</div>
	</body>
</html>