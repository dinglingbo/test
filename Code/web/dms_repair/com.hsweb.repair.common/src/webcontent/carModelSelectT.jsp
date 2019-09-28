<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
	<%@include file="/common/common.jsp"%>
		<%@include file="/common/commonRepair.jsp"%>
			<html>
			<!-- 
  - Author(s): chenziming
  - Date: 2018-03-19 10:28:11
  - Description:
-->

			<head>
				<title>选择车型</title>
				<script src="<%= request.getContextPath() %>/commonRepair/js/carModelSelectT.js?v=1.0.4"></script>
				<style type="text/css">
					.yuan {
						display: inline-block;
						background: #e6e6e6;
						padding: 3px 10px;
						border-radius: 4px;
						text-decoration: none;
						color: #201f35;
					}

					.dian {
						display: inline-block;
						background: #00BFFF;
						padding: 3px 10px;
						border-radius: 4px;
						text-decoration: none;
						color: #201f35;
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

					.car_type {
						height: 500px;
						margin-bottom: 10px;
						overflow: auto;
					}

					.car_type_menu {
						height: 55px;
						border-bottom: 1px #dcdcdc solid;
					}

					.car_type_menu ul {
						width: 718px;
						height: 55px;
						background: url(<%=request.getContextPath()%>/commonRepair/img/car_type_menu.png) no-repeat;
						margin: 0 auto;
					}

					ul,
					li,
					dl,
					dt,
					dd,
					ol {
						list-style: none;
					}

					.car_type_menu ul li a {
						width: 178px;
						height: 55px;
						display: block;
						float: left;
						text-indent: -9999px;
					}

					a:link,
					a:visited {
						font-family: 微软雅黑, Arial, Helvetica, sans-serif;
						font-size: 13px;
						color: #555555;
						text-decoration: none;
					}

					#carinfo {
						width: 860px;
						height: 565px;
					}

					.car_type_yxz {
						height: 40px;
						border-bottom: 1px #dcdcdc solid;
					}

					.car_type_yxz ul li {
						float: left;
						margin-left: 5px;
						margin-right: 10px;
						position: relative;
					}

					.car_type_yxz a {
						position: absolute;
						width: 17px;
						height: 17px;
						background: url(<%=request.getContextPath()%>/commonRepair/img/car_close.png) no-repeat;
						text-indent: -9999px;
						right: -7px;
						top: -7px;
					}

					.car_type_yxz ul li font {
						padding: 0 15px;
						height: 26px;
						line-height: 26px;
						border: 1px #578ccd solid;
						text-align: center;
						font-size: 14px;
						color: #555;
						float: left;
						margin-left: 6px;
						background: #e6edf5;
					}

					.car_type_cx dl {
						width: 100%;
						height: auto;
						overflow: hidden;
						padding-top: 5px;
					}

					.car_type_cx dl dd {
					    text-align: center;
						float: left;
						width: 186px;
						min-height: 32px;
						margin: 7px 3px 6px 10px;
					}

					.car_type_cx dl dd a {
						min-height: 30px;
						border: 1px #dcdcdc solid;
						display: contents;
						line-height: 28px;
						padding-left: 8px;
						text-decoration: none;
						text-align: center;
						font-size: 13px;
					}

					.xz {
						border: 1px #ff6600 solid !important;
						color: #ff6600;
						background: url(<%= request.getContextPath() %>/tenant/img/cztcbtn.gif) right bottom no-repeat;
					}

					.car_type_menu ul.c2 {
						background-position: 0 -70px;
					}

					.car_type_menu ul.c3 {
						background-position: 0 -140px;
					}

					.car_type_menu ul.c4 {
						background-position: 0 -210px;
					}

					.car_type_yxz em {
						float: left;
						line-height: 26px;
					}
				</style>
			</head>

			<body>
				<div id="carinfo">
					<div style="width: 850px; height: auto; overflow: hidden; margin: 0 auto; padding-bottom: 30px;">
						<div class="car_type">
							<div class="car_type_menu" style=" margin-top: 10px;">
								<ul class="c1">

								</ul>
							</div>
							<div class="car_type_pp" style="display: none; margin-top: 10px;">
								<a class="yuan" href="#" onclick="getCarBrandB('A')" id="A">A</a>
								<a class="yuan" href="#" onclick="getCarBrandB('B')" id="B">B</a>
								<a class="yuan" href="#" onclick="getCarBrandB('C')" id="C">C</a>
								<a class="yuan" href="#" onclick="getCarBrandB('D')" id="D">D</a>
								<a class="yuan" href="#" onclick="getCarBrandB('E')" id="E">E</a>
								<a class="yuan" href="#" onclick="getCarBrandB('F')" id="F">F</a>
								<a class="yuan" href="#" onclick="getCarBrandB('G')" id="G">G</a>
								<a class="yuan" href="#" onclick="getCarBrandB('H')" id="H">H</a>
								<a class="yuan" href="#" onclick="getCarBrandB('I')" id="I">I</a>
								<a class="yuan" href="#" onclick="getCarBrandB('J')" id="J">J</a>
								<a class="yuan" href="#" onclick="getCarBrandB('K')" id="K">K</a>
								<a class="yuan" href="#" onclick="getCarBrandB('L')" id="L">L</a>
								<a class="yuan" href="#" onclick="getCarBrandB('M')" id="M">M</a>
								<a class="yuan" href="#" onclick="getCarBrandB('N')" id="N">N</a>
								<a class="yuan" href="#" onclick="getCarBrandB('O')" id="O">O</a>
								<a class="yuan" href="#" onclick="getCarBrandB('P')" id="P">P</a>
								<a class="yuan" href="#" onclick="getCarBrandB('Q')" id="Q">Q</a>
								<a class="yuan" href="#" onclick="getCarBrandB('R')" id="R">R</a>
								<a class="yuan" href="#" onclick="getCarBrandB('S')" id="S">S</a>
								<a class="yuan" href="#" onclick="getCarBrandB('T')" id="T">T</a>
								<a class="yuan" href="#" onclick="getCarBrandB('U')" id="U">u</a>
								<a class="yuan" href="#" onclick="getCarBrandB('V')" id="V">V</a>
								<a class="yuan" href="#" onclick="getCarBrandB('W')" id="W">W</a>
								<a class="yuan" href="#" onclick="getCarBrandB('X')" id="X">X</a>
								<a class="yuan" href="#" onclick="getCarBrandB('Y')" id="Y">Y</a>
								<a class="yuan" href="#" onclick="getCarBrandB('Z')" id="Z">Z</a>
							</div>
							<div class="car_type_yxz" style="display: none;">
								<em>已选车型：</em>
								<ul>
									<li id="level2" style="display: none;">
										<a href="javascript:void(0)" class="yxzxz" onclick="uplevel(2)">关闭</a>
										<font id="level2Name"></font>
									</li>
									<li id="level3" style="display: none;">
										<a href="javascript:void(0)" class="yxzxz" onclick="uplevel(3)">关闭</a>
										<font id="level3Name"></font>
									</li>
									<li id="level4" style="display: none;">
										<a href="javascript:void(0)" class="yxzxz" onclick="uplevel(4)">关闭</a>
										<font id="level4Name"></font>
									</li>
								</ul>
							</div>

							<div class="car_type_list" bindlist="1" style="display: none; padding-left: 10px;">
								<ul id="carB">

								</ul>
							</div>

							<div class="car_type_cx dumascroll" bindlist="2" id="dumaScrollAreaId_5" style="position: relative; display: none; padding-left: 10px;">
								<div id="dumaScrollAreaId_5Area" class="dumascroll_area">
									<dl id="carC">

									</dl>

								</div>
								<div id="dumaScrollAreaId_5Bar" class="dumascroll_bar">
									<div class="dumascroll_arrow_up"></div>
									<div class="dumascroll_handle" style="top: 14px; height: 110px;"></div>
									<div class="dumascroll_arrow_down"></div>
								</div>
							</div>

							<div class="car_type_cx" id="dumaScrollAreaId_4" style="padding-top: 20px; padding-left: 10px; display: none;" bindlist="4">
								<dl id="carN">

								</dl>
							</div>
						</div>
						<div class="boxbtn" style="position: absolute;bottom:4px;">
							<ul style="text-align: left;">
								<a class="kaitong" href="#" style="background: #4f9ada; font-size:14px;margin-left:700px;" onclick="onCancel()">确定</a>
							</ul>
						</div>
					</div>
				</div>
			</body>

			</html>