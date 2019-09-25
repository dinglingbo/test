<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false" %>
	  <%@include file="/common/sysCommon.jsp"%>
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
<script src="<%= request.getContextPath() %>/baseDataPart/js/partMgr/partBrand.js?v=1.0.6" type="text/javascript"></script>
    <style type="text/css">
    	.yuan {
		    display: inline-block;
		    background: #e6e6e6;
		    padding: 3px 10px;
		    border-radius: 4px;
		    text-decoration: none;
		    color:#201f35;
		}
		.dian{
			display: inline-block;
		    background: #00BFFF;
		    padding: 3px 10px;
		    border-radius: 4px;
		    text-decoration: none;
		    color:#201f35;
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
					.car_type_list ul li {
					    width: 182px;
					    height: 42px;
					    float: left;
					    border: 1px #d6d6d6 solid;
					    margin: 15px 0 0 15px;
					    list-style: none;
					    cursor: pointer;
					} 
				.car_type_list ul li a font {
				    display: block;
				    float: left;
				    border-left: 1px #ccc solid;
				    line-height: 30px;
				    height: 30px;
				    overflow: hidden;
				    margin-top: 4px;
				    padding-left: 8px;
				    font-size: 13px;
    				color: #555555;

				}
				.car_type_list ul li a img {
				    width: 30px;
				    height: 30px;
				    margin: 5px;
				    float: left;
				}
						.kaitong {
					    width: 90px;
					    height: 34px;
					    background: #21c064;
					    border-radius: 5px;
					    display: inline-table;
					    color: #fff;
					    font-size: 16px;
					    text-align: center;
					    text-decoration: none;
					    line-height: 34px;
					}			
    </style>
</head>
<body >
<div class="popbox" id="popbox_1" style="height: 100%;position: relative;">
    <div style="overflow: auto;" class="carbandxz" >
        <div class="car_type_band" ><!-- <em>根据首字母筛选：</em> -->
        						<div class="header">
							<input id="brandName" name="brandName" class="intCity" type="text" placeholder="请输入品牌名称" />
							<input class="seachBtn" type="button" value="查询" onclick="getPartBrandName()" />
						</div>
        	<a class="yuan" href="#" onclick="getPartBrandLetter('A')" id="A">A</a>
        	<a class="yuan" href="#" onclick="getPartBrandLetter('B')" id="B">B</a>
        	<a class="yuan" href="#" onclick="getPartBrandLetter('C')" id="C">C</a>
        	<a class="yuan" href="#" onclick="getPartBrandLetter('D')" id="D">D</a>
         	<a class="yuan" href="#" onclick="getPartBrandLetter('E')" id="E">E</a>       	
        	<a class="yuan" href="#" onclick="getPartBrandLetter('F')" id="F">F</a>
        	<a class="yuan" href="#" onclick="getPartBrandLetter('G')" id="G">G</a>
        	<a class="yuan" href="#" onclick="getPartBrandLetter('H')" id="H">H</a>
         	<a class="yuan" href="#" onclick="getPartBrandLetter('I')" id="I">I</a>       	
        	<a class="yuan" href="#" onclick="getPartBrandLetter('J')" id="J">J</a>
        	<a class="yuan" href="#" onclick="getPartBrandLetter('K')" id="K">K</a>
        	<a class="yuan" href="#" onclick="getPartBrandLetter('L')" id="L">L</a>
        	<a class="yuan" href="#" onclick="getPartBrandLetter('M')" id="M">M</a>
        	<a class="yuan" href="#" onclick="getPartBrandLetter('N')" id="N">N</a>
        	<a class="yuan" href="#" onclick="getPartBrandLetter('O')" id="O">O</a>
        	<a class="yuan" href="#" onclick="getPartBrandLetter('P')" id="P">P</a>
        	<a class="yuan" href="#" onclick="getPartBrandLetter('Q')" id="Q">Q</a>
        	<a class="yuan" href="#" onclick="getPartBrandLetter('R')" id="R">R</a>
        	<a class="yuan" href="#" onclick="getPartBrandLetter('S')" id="S">S</a>
        	<a class="yuan" href="#" onclick="getPartBrandLetter('T')" id="T">T</a>
        	<a class="yuan" href="#" onclick="getPartBrandLetter('U')" id="U">u</a>
         	<a class="yuan" href="#" onclick="getPartBrandLetter('V')" id="V">V</a>       	        	
        	<a class="yuan" href="#" onclick="getPartBrandLetter('W')" id="W">W</a>
        	<a class="yuan" href="#" onclick="getPartBrandLetter('X')" id="X">X</a>
        	<a class="yuan" href="#" onclick="getPartBrandLetter('Y')" id="Y">Y</a>
        	<a class="yuan" href="#" onclick="getPartBrandLetter('Z')" id="Z">Z</a> 
        </div>
        <div class="car_type_list" bindlist="1" style="display: block;"  >
        	<ul id="part">
<!--          	<li>
        			<a style="background-color: #fff;" class="partA" href="#"  onclick="choosePart(aa,bb)">
							<img src="baseDataPart/img/brandDefault.jpg" width="30x" height="30px">
							<font>name</font>
					</a>  
			</li>   -->
			</ul>        
        </div>



        <div style="height: 15px;"></div>
    </div>
    <div class="boxbtn" style="position: absolute;bottom:4px;">
        <ul style="text-align: left;">
            <font style="float: left; padding-left: 16px; width: 580px;" class="color999">您已选择：&nbsp;<span style="color:#ff7800;font-size:15px;" id="selectmodels">  </span></font>
           <a class = "kaitong" href="#" style="background: #4f9ada; font-size:14px;margin-left:100px;" onclick="onCancel()">确定</a>
            <!-- <a class = "kaitong" href="#" style="background: #4f9ada; font-size:14px;margin-left: 100px;" onclick="toChainCarCoinRecharge()">链车币充值</a> -->
        </ul>
    </div>
</div>



	<script type="text/javascript">
    	nui.parse();
    </script>
</body>
</html>