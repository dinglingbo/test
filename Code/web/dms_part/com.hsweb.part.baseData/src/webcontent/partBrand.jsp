<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false" %>
	
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<!-- 
  - Author(s): Administrator
  - Date: 2019-09-09 16:12:32
  - Description:
-->
<head>
<title>配件品牌选择</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
    <script src="<%= request.getContextPath() %>/common/nui/nui.js" type="text/javascript"></script>
    <style type="text/css">
    	.car_type_band a {
		    display: inline-block;
		    background: #e6e6e6;
		    padding: 3px 10px;
		    border-radius: 4px;
		    text-decoration: none;
		}
		.carbandxz a {
		    transition: all .0s ease;
		}
		a:link, a:visited {
		    font-family: 微软雅黑, Arial, Helvetica, sans-serif;
		    font-size: 14px;
		    color: #555555;
		    text-decoration: none;
		}
		.car_type_band a.xz {
		    background: #32aaeb;
		    color: #fff;
		}
		.car_type_band em {
		    color: #5fc8d7;
		    font-weight: 700;
		}
					.header {
						width: 100%;
						height: 60px;
						position: relative;
						line-height: 40px;
/* 						border: 1px solid #fff; */
						border-radius: 4px;
						text-align: center;
					}

					.header .intCity {
						width: 400px;
						height: 40px;
						line-height: 40px;
						font-size: 16px;
						text-indent: 10px;
						margin-top: 10px;
					}

					.header .seachBtn {
						width: 100px;
						height: 40px;
						line-height: 40px;
						font-size: 16px;
						color: #fff;
						text-align: center;
						background: #00BFFF;
						font-weight: 600;
						cursor: pointer;
						margin-top: 10px;
					}

					input {
						outline: none;
						border: none;
						height: 30px;
					}	
					.car_type_bandlist ul li a {
					    display: block;
					    width: 80px;
					    height: 100px;
					    border: 1px #e6e6e6 solid;
					    border-radius: 4px;
					    padding: 0 3px;
					    text-align: center;
					    text-decoration: none;
					    color: #666;
					    font-size: 13px;	
					 }
					 .car_type_bandlist ul li a img {
					    width: 40px;
					    height: 40px;
					    display: block;
					    margin: 15px auto 5px auto;
					}
					img {
					    border: 0;
					    vertical-align: middle;
					}
					ul, li, dl, dt, dd, ol {
					    list-style: none;
					}				
    </style>
</head>
<body >
<div class="popbox" id="popbox_1" >
    <div style="overflow: auto;" class="carbandxz" >
        <div class="car_type_band" ><!-- <em>根据首字母筛选：</em> -->
        						<div class="header">
							<input id="brandName" name="brandName" class="intCity" type="text" placeholder="请输入品牌名称" />
							<input class="seachBtn" type="button" value="查询" onclick="javascript:getViolation()" />
						</div>
        	<a href="javascript:void(0)">A</a>
        	<a href="javascript:void(0)">B</a>
        	<a href="javascript:void(0)">C</a>
        	<a href="javascript:void(0)">D</a>
         	<a href="javascript:void(0)">E</a>       	
        	<a href="javascript:void(0)">F</a>
        	<a href="javascript:void(0)">G</a>
        	<a href="javascript:void(0)">H</a>
         	<a href="javascript:void(0)">I</a>       	
        	<a href="javascript:void(0)">J</a>
        	<a href="javascript:void(0)">K</a>
        	<a href="javascript:void(0)">L</a>
        	<a href="javascript:void(0)">M</a>
        	<a href="javascript:void(0)">N</a>
        	<a href="javascript:void(0)">O</a>
        	<a href="javascript:void(0)">P</a>
        	<a href="javascript:void(0)">Q</a>
        	<a href="javascript:void(0)">R</a>
        	<a href="javascript:void(0)">S</a>
        	<a href="javascript:void(0)">T</a>
        	<a href="javascript:void(0)">u</a>
         	<a href="javascript:void(0)">V</a>       	        	
        	<a href="javascript:void(0)">W</a>
        	<a href="javascript:void(0)">X</a>
        	<a href="javascript:void(0)">Y</a>
        	<a href="javascript:void(0)">Z</a> 
        </div>
        <div class="car_type_bandlist" >
        <ul >
        	<li >
        		<a style="background-color: #fff;" href="javascript:void(0)" value="158" code="402880882ce35a1f012d0814e2f019e8"><img src="http://res.ewewo.com/brandlogo/guangqicyc.jpg" width="100" height="100"><font>广汽乘用车</font></a>
        	</li>
        </ul>
            
        </div>



        <div style="height: 15px;"></div>
    </div>
    <div class="boxbtn">
        <ul style="text-align: left;">
            <font style="float: left; padding-left: 16px; width: 580px;" class="color999">您已选择：&nbsp;<span style="color:#ff7800;" id="selectmodels">  </span></font>
            <a href="javascript:void(0);" class="qc">取消</a>
            <a href="javascript:void(0);" name="carbtnok">确定</a>
        </ul>
    </div>
</div>



	<script type="text/javascript">
    	nui.parse();
    </script>
</body>
</html>