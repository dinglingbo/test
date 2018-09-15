<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false"%>
<%@include file="/common/common.jsp"%>
<%@include file="/common/commonRepair.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<!--
  - Author(s): Administrator
  - Date: 2018-09-14 19:31:35
  - Description:
  -->
<head>
<title>车间调度</title>
<style type="text/css">
table {
	font-size: 12px;
}

#title1 {
	font-size: 25px;
	padding-left: 18px;
	margin-bottom: 10px;
	margin-top: 10px;
	color: red;
}
/* .mini-tabs-firstSpace{ */
/*  padding-top:20px !important; */
/* } */
.form_label {
	width: 84px;
}

a.ztedit {
	height: 18px;
	display: inline-block;
	background: url(../images/sjde.png) 40px -1px no-repeat;
	padding-right: 22px;
	color: #888;
	text-decoration: none;
}

.addyytime a {
	width: 112px;
	height: 35px;
	line-height: 36px;
	border: 1px #a6e0f5 solid;
	display: block;
	float: left;
	text-decoration: none;
	text-align: center;
	color: #00b4f6;
	border-radius: 4px;
	margin: 0 15px 15px 15px;
}

.addyytime a.hui {
	border: 1px #e6e6e6 solid;
	color: #c8c8c8;
	background: #e6e6e6;
}

.addyytime a.xz {
	border: 1px #ff7800 solid;
	color: #fff;
	background: #ff7800;
}

a:link,a:visited {
	font-family: 微软雅黑, Arial, Helvetica, sans-serif;
	font-size: 14px;
	color: #555555;
	text-decoration: none;
}

a:hover {
	font-family: 微软雅黑, Arial, Helvetica, sans-serif;
	font-size: 14px;
	color: #df0024;
	text-decoration: none;
}

a {
	text-decoration: none;
	transition: all .4s ease;
}
</style>
</head>
<body>
	<div class="nui-fit">
		<div class="nui-splitter" vertical="true"
			style="width: 100%; height: 100%;" allowResize="true">
			<!--上 -->
			<div id="top" size="30%" showCollapseButton="false">
				<div class="nui-fit">
					<div id="title1">未派工车辆</div>
					<div class="addyytime"></div>
				</div>
			</div>
			<!-- 下 -->
			<div id="bottom" size="" showCollapseButton="false">
				<div class="nui-fit">
					<div class="nui-toolbar" style="padding: 6px; border-bottom: 1;">
						<table>
							<tr>
								<td style="font-size: 18px;">已派工车辆</td>
							</tr>
						</table>
					</div>
					<div id="mainTabs" class="nui-tabs" name="mainTabs" activeIndex="0"
						style="width: 100%; height: 100%;" tabPosition="left"
						plain="false">
						<div title="全部">
							<div class="nui-fit">
								<div class="nui-datagrid" name="" url="" id="carGrid"
									dataField="data" idField="id" showPager="false"
									allowSortColumn="true" sortMode="client">
									<div property="columns">
										<div field="" width="100" headerAlign="center"
											allowSort="true" header="序号"></div>
										<div field="" width="60" headerAlign="center" allowSort="true"
											header="车牌"></div>
										<div field="" width="60" headerAlign="center" allowSort="true"
											header="接待人"></div>
										<div field="" width="60" headerAlign="center" allowSort="true"
											header="进厂时间"></div>
										<div field="" width="60" headerAlign="center" allowSort="true"
											header="项目"></div>
										<div field="" width="60" headerAlign="center" allowSort="true"
											header="班组"></div>
										<div field="" width="60" headerAlign="center" allowSort="true"
											header="派工时间"></div>
										<div field="" width="60" headerAlign="center" allowSort="true"
											header="施工员"></div>
										<div field="" width="60" headerAlign="center" allowSort="true"
											header="预计完工时间"></div>
										<div field="" width="60" headerAlign="center" allowSort="true"
											header="开始施工"></div>
										<div field="" width="60" headerAlign="center" allowSort="true"
											header="施工耗时"></div>
										<div field="" width="60" headerAlign="center" allowSort="true"
											header="中断耗时"></div>
										<div field="" width="60" headerAlign="center" allowSort="true"
											header="状态"></div>
										<div field="" width="60" headerAlign="center" allowSort="true"
											header="操作"></div>
									</div>
								</div>
							</div>
						</div>
						<div title="钣金组">
							<div class="nui-fit">
								<div class="nui-datagrid" name="" url="" id="carGrid"
									dataField="data" idField="id" showPager="false"
									allowSortColumn="true" sortMode="client">
									<div property="columns">
										<div field="" width="100" headerAlign="center"
											allowSort="true" header="序号"></div>
										<div field="" width="60" headerAlign="center" allowSort="true"
											header="车牌"></div>
										<div field="" width="60" headerAlign="center" allowSort="true"
											header="接待人"></div>
										<div field="" width="60" headerAlign="center" allowSort="true"
											header="进厂时间"></div>
										<div field="" width="60" headerAlign="center" allowSort="true"
											header="项目"></div>
										<div field="" width="60" headerAlign="center" allowSort="true"
											header="班组"></div>
										<div field="" width="60" headerAlign="center" allowSort="true"
											header="派工时间"></div>
										<div field="" width="60" headerAlign="center" allowSort="true"
											header="施工员"></div>
										<div field="" width="60" headerAlign="center" allowSort="true"
											header="预计完工时间"></div>
										<div field="" width="60" headerAlign="center" allowSort="true"
											header="开始施工"></div>
										<div field="" width="60" headerAlign="center" allowSort="true"
											header="施工耗时"></div>
										<div field="" width="60" headerAlign="center" allowSort="true"
											header="中断耗时"></div>
										<div field="" width="60" headerAlign="center" allowSort="true"
											header="状态"></div>
										<div field="" width="60" headerAlign="center" allowSort="true"
											header="操作"></div>
									</div>
								</div>
							</div>
						</div>
						<div title="前台收银">
							<div class="nui-fit">
								<div class="nui-datagrid" name="" url="" id="carGrid"
									dataField="data" idField="id" showPager="false"
									allowSortColumn="true" sortMode="client">
									<div property="columns">
										<div field="" width="100" headerAlign="center"
											allowSort="true" header="序号"></div>
										<div field="" width="60" headerAlign="center" allowSort="true"
											header="车牌"></div>
										<div field="" width="60" headerAlign="center" allowSort="true"
											header="接待人"></div>
										<div field="" width="60" headerAlign="center" allowSort="true"
											header="进厂时间"></div>
										<div field="" width="60" headerAlign="center" allowSort="true"
											header="项目"></div>
										<div field="" width="60" headerAlign="center" allowSort="true"
											header="班组"></div>
										<div field="" width="60" headerAlign="center" allowSort="true"
											header="派工时间"></div>
										<div field="" width="60" headerAlign="center" allowSort="true"
											header="施工员"></div>
										<div field="" width="60" headerAlign="center" allowSort="true"
											header="预计完工时间"></div>
										<div field="" width="60" headerAlign="center" allowSort="true"
											header="开始施工"></div>
										<div field="" width="60" headerAlign="center" allowSort="true"
											header="施工耗时"></div>
										<div field="" width="60" headerAlign="center" allowSort="true"
											header="中断耗时"></div>
										<div field="" width="60" headerAlign="center" allowSort="true"
											header="状态"></div>
										<div field="" width="60" headerAlign="center" allowSort="true"
											header="操作"></div>
									</div>
								</div>
							</div>
						</div>
						<div title="维修部">
							<div class="nui-fit">
								<div class="nui-datagrid" name="" url="" id="carGrid"
									dataField="data" idField="id" showPager="false"
									allowSortColumn="true" sortMode="client">
									<div property="columns">
										<div field="" width="100" headerAlign="center"
											allowSort="true" header="序号"></div>
										<div field="" width="60" headerAlign="center" allowSort="true"
											header="车牌"></div>
										<div field="" width="60" headerAlign="center" allowSort="true"
											header="接待人"></div>
										<div field="" width="60" headerAlign="center" allowSort="true"
											header="进厂时间"></div>
										<div field="" width="60" headerAlign="center" allowSort="true"
											header="项目"></div>
										<div field="" width="60" headerAlign="center" allowSort="true"
											header="班组"></div>
										<div field="" width="60" headerAlign="center" allowSort="true"
											header="派工时间"></div>
										<div field="" width="60" headerAlign="center" allowSort="true"
											header="施工员"></div>
										<div field="" width="60" headerAlign="center" allowSort="true"
											header="预计完工时间"></div>
										<div field="" width="60" headerAlign="center" allowSort="true"
											header="开始施工"></div>
										<div field="" width="60" headerAlign="center" allowSort="true"
											header="施工耗时"></div>
										<div field="" width="60" headerAlign="center" allowSort="true"
											header="中断耗时"></div>
										<div field="" width="60" headerAlign="center" allowSort="true"
											header="状态"></div>
										<div field="" width="60" headerAlign="center" allowSort="true"
											header="操作"></div>
									</div>
								</div>
							</div>
						</div>

						<div title="机电组">
							<div class="nui-fit">
								<div class="nui-datagrid" name="" url="" id="carGrid"
									dataField="data" idField="id" showPager="false"
									allowSortColumn="true" sortMode="client">
									<div property="columns">
										<div field="" width="100" headerAlign="center"
											allowSort="true" header="序号"></div>
										<div field="" width="60" headerAlign="center" allowSort="true"
											header="车牌"></div>
										<div field="" width="60" headerAlign="center" allowSort="true"
											header="接待人"></div>
										<div field="" width="60" headerAlign="center" allowSort="true"
											header="进厂时间"></div>
										<div field="" width="60" headerAlign="center" allowSort="true"
											header="项目"></div>
										<div field="" width="60" headerAlign="center" allowSort="true"
											header="班组"></div>
										<div field="" width="60" headerAlign="center" allowSort="true"
											header="派工时间"></div>
										<div field="" width="60" headerAlign="center" allowSort="true"
											header="施工员"></div>
										<div field="" width="60" headerAlign="center" allowSort="true"
											header="预计完工时间"></div>
										<div field="" width="60" headerAlign="center" allowSort="true"
											header="开始施工"></div>
										<div field="" width="60" headerAlign="center" allowSort="true"
											header="施工耗时"></div>
										<div field="" width="60" headerAlign="center" allowSort="true"
											header="中断耗时"></div>
										<div field="" width="60" headerAlign="center" allowSort="true"
											header="状态"></div>
										<div field="" width="60" headerAlign="center" allowSort="true"
											header="操作"></div>
									</div>
								</div>
							</div>
						</div>

						<div title="特殊组">
							<div class="nui-fit">
								<div class="nui-datagrid" name="" url="" id="carGrid"
									dataField="data" idField="id" showPager="false"
									allowSortColumn="true" sortMode="client">
									<div property="columns">
										<div field="" width="100" headerAlign="center"
											allowSort="true" header="序号"></div>
										<div field="" width="60" headerAlign="center" allowSort="true"
											header="车牌"></div>
										<div field="" width="60" headerAlign="center" allowSort="true"
											header="接待人"></div>
										<div field="" width="60" headerAlign="center" allowSort="true"
											header="进厂时间"></div>
										<div field="" width="60" headerAlign="center" allowSort="true"
											header="项目"></div>
										<div field="" width="60" headerAlign="center" allowSort="true"
											header="班组"></div>
										<div field="" width="60" headerAlign="center" allowSort="true"
											header="派工时间"></div>
										<div field="" width="60" headerAlign="center" allowSort="true"
											header="施工员"></div>
										<div field="" width="60" headerAlign="center" allowSort="true"
											header="预计完工时间"></div>
										<div field="" width="60" headerAlign="center" allowSort="true"
											header="开始施工"></div>
										<div field="" width="60" headerAlign="center" allowSort="true"
											header="施工耗时"></div>
										<div field="" width="60" headerAlign="center" allowSort="true"
											header="中断耗时"></div>
										<div field="" width="60" headerAlign="center" allowSort="true"
											header="状态"></div>
										<div field="" width="60" headerAlign="center" allowSort="true"
											header="操作"></div>
									</div>
								</div>
							</div>
						</div>

						<div title="前台一组">
							<div class="nui-fit">
								<div class="nui-datagrid" name="" url="" id="carGrid"
									dataField="data" idField="id" showPager="false"
									allowSortColumn="true" sortMode="client">
									<div property="columns">
										<div field="" width="100" headerAlign="center"
											allowSort="true" header="序号"></div>
										<div field="" width="60" headerAlign="center" allowSort="true"
											header="车牌"></div>
										<div field="" width="60" headerAlign="center" allowSort="true"
											header="接待人"></div>
										<div field="" width="60" headerAlign="center" allowSort="true"
											header="进厂时间"></div>
										<div field="" width="60" headerAlign="center" allowSort="true"
											header="项目"></div>
										<div field="" width="60" headerAlign="center" allowSort="true"
											header="班组"></div>
										<div field="" width="60" headerAlign="center" allowSort="true"
											header="派工时间"></div>
										<div field="" width="60" headerAlign="center" allowSort="true"
											header="施工员"></div>
										<div field="" width="60" headerAlign="center" allowSort="true"
											header="预计完工时间"></div>
										<div field="" width="60" headerAlign="center" allowSort="true"
											header="开始施工"></div>
										<div field="" width="60" headerAlign="center" allowSort="true"
											header="施工耗时"></div>
										<div field="" width="60" headerAlign="center" allowSort="true"
											header="中断耗时"></div>
										<div field="" width="60" headerAlign="center" allowSort="true"
											header="状态"></div>
										<div field="" width="60" headerAlign="center" allowSort="true"
											header="操作"></div>
									</div>
								</div>
							</div>
						</div>
						<div title="前台三组">
							<div class="nui-fit">
								<div class="nui-datagrid" name="" url="" id="carGrid"
									dataField="data" idField="id" showPager="false"
									allowSortColumn="true" sortMode="client">
									<div property="columns">
										<div field="" width="100" headerAlign="center"
											allowSort="true" header="序号"></div>
										<div field="" width="60" headerAlign="center" allowSort="true"
											header="车牌"></div>
										<div field="" width="60" headerAlign="center" allowSort="true"
											header="接待人"></div>
										<div field="" width="60" headerAlign="center" allowSort="true"
											header="进厂时间"></div>
										<div field="" width="60" headerAlign="center" allowSort="true"
											header="项目"></div>
										<div field="" width="60" headerAlign="center" allowSort="true"
											header="班组"></div>
										<div field="" width="60" headerAlign="center" allowSort="true"
											header="派工时间"></div>
										<div field="" width="60" headerAlign="center" allowSort="true"
											header="施工员"></div>
										<div field="" width="60" headerAlign="center" allowSort="true"
											header="预计完工时间"></div>
										<div field="" width="60" headerAlign="center" allowSort="true"
											header="开始施工"></div>
										<div field="" width="60" headerAlign="center" allowSort="true"
											header="施工耗时"></div>
										<div field="" width="60" headerAlign="center" allowSort="true"
											header="中断耗时"></div>
										<div field="" width="60" headerAlign="center" allowSort="true"
											header="状态"></div>
										<div field="" width="60" headerAlign="center" allowSort="true"
											header="操作"></div>
									</div>
								</div>
							</div>
						</div>

						<div title="全能组">
							<div class="nui-fit">
								<div class="nui-datagrid" name="" url="" id="carGrid"
									dataField="data" idField="id" showPager="false"
									allowSortColumn="true" sortMode="client">
									<div property="columns">
										<div field="" width="100" headerAlign="center"
											allowSort="true" header="序号"></div>
										<div field="" width="60" headerAlign="center" allowSort="true"
											header="车牌"></div>
										<div field="" width="60" headerAlign="center" allowSort="true"
											header="接待人"></div>
										<div field="" width="60" headerAlign="center" allowSort="true"
											header="进厂时间"></div>
										<div field="" width="60" headerAlign="center" allowSort="true"
											header="项目"></div>
										<div field="" width="60" headerAlign="center" allowSort="true"
											header="班组"></div>
										<div field="" width="60" headerAlign="center" allowSort="true"
											header="派工时间"></div>
										<div field="" width="60" headerAlign="center" allowSort="true"
											header="施工员"></div>
										<div field="" width="60" headerAlign="center" allowSort="true"
											header="预计完工时间"></div>
										<div field="" width="60" headerAlign="center" allowSort="true"
											header="开始施工"></div>
										<div field="" width="60" headerAlign="center" allowSort="true"
											header="施工耗时"></div>
										<div field="" width="60" headerAlign="center" allowSort="true"
											header="中断耗时"></div>
										<div field="" width="60" headerAlign="center" allowSort="true"
											header="状态"></div>
										<div field="" width="60" headerAlign="center" allowSort="true"
											header="操作"></div>
									</div>
								</div>
							</div>
						</div>
					</div>

					<div class="nui-toolbar" style="padding: 6px; border-bottom: 1;">
						<table>
							<tr>
								<td style="font-size: 18px;">已完成车辆</td>
							</tr>
						</table>
					</div>
					<div class="nui-datagrid" height="50%" name="" url="" id="carGrid"
						dataField="data" idField="id" showPager="false"
						allowSortColumn="true" sortMode="client">
						<div property="columns">
							<div field="" width="50" headerAlign="center" allowSort="true"
								header="序号"></div>
							<div field="" width="60" headerAlign="center" allowSort="true"
								header="车牌"></div>
							<div field="" width="60" headerAlign="center" allowSort="true"
								header="接待人"></div>
							<div field="" width="60" headerAlign="center" allowSort="true"
								header="进厂时间"></div>
							<div field="" width="60" headerAlign="center" allowSort="true"
								header="项目"></div>
							<div field="" width="60" headerAlign="center" allowSort="true"
								header="班组"></div>
							<div field="" width="60" headerAlign="center" allowSort="true"
								header="派工时间"></div>
							<div field="" width="60" headerAlign="center" allowSort="true"
								header="施工员"></div>
							<div field="" width="60" headerAlign="center" allowSort="true"
								header="预计完工时间"></div>
							<div field="" width="60" headerAlign="center" allowSort="true"
								header="开始施工"></div>
							<div field="" width="60" headerAlign="center" allowSort="true"
								header="施工耗时"></div>
							<div field="" width="60" headerAlign="center" allowSort="true"
								header="中断耗时"></div>
							<div field="" width="60" headerAlign="center" allowSort="true"
								header="状态"></div>
							<div field="" width="60" headerAlign="center" allowSort="true"
								header="操作"></div>
						</div>
					</div>

				</div>
			</div>
		</div>
		<script type="text/javascript">
			nui.parse();
			$(document).ready(function() {
				init();
			});
			var carList = [];
			function init() {
				for (var i = 0; i < 100; i++) {
					var data = {
						id : i,
						name : "粤B643" + i
					};
					carList.push(data);
				}
				if (carList && carList.length > 0) {
					var htmlStr = "";
					for (var i = 0; i < carList.length; i++) {
						var cardObj = carList[i];
						var name = cardObj.name;
						s = "<a href='javascript:;' name='car'id='car'>" + name
								+ "</a>";
						htmlStr += s;
					}
					$(".addyytime").html(htmlStr);
					selectclick();
				}
			}
			function selectclick() {
				$("a[name=car]").click(function() {
					$(this).siblings().removeClass("xz");
					$(this).toggleClass("xz");
				});
			}
		</script>
</body>
</html>