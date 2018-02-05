<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<!-- 
  - Author(s): Administrator
  - Date: 2018-01-26 12:06:08
  - Description:
-->
<head>
<title>维修档案</title>
<meta http-equiv="content-type" content="text/html; charset=UTF-8" />
<script src="<%= request.getContextPath() %>/common/nui/nui.js"
	type="text/javascript"></script>

</head>
<body style="margin: 0; height: 100%; width: 100%; overflow: hidden">
	<div  class="nui-toolbar"  style="height:50px">
		<div class="nui-form1" id="form1" style="height: 100%">
			<input class="nui-hidden" name="criteria/_entity"
				value="com.hsweb.repair.DataBase.RpbClass" />
			
			<table class="table" id="table1" style="height: 100%;">
				<tr style="display: block; margin:-5px 0">
					<td width="80px">
						<span style="color:#0000FF;margin-left: 10px;">工单号：</span>
					</td>
					<td>
						<label field="" style="color:#0000FF;width: 200px; " /></label>
					</td>
					<td width="80px">
							<span style="color:#0000FF;margin-left: 10px;">车牌号：</span>
					</td>
					<td>
						<label field="" style="color:#0000FF;width:120px; " /></label>
					</td>
				</tr>
				<tr style="display: block; margin:-3px 0">
					<td>
						<label style="font-family:Verdana;">快速查询：</label>
						<a class="nui-button"  style="color:#0000FF" plain="true">本日</a>
						<a class="nui-button"  style="color:#0000FF" plain="true">昨日</a>
						<a class="nui-button"  style="color:#0000FF" plain="true">本周</a>
						<a class="nui-button"  style="color:#0000FF" plain="true">上周</a>
						<a class="nui-button"  style="color:#0000FF" plain="true">本月</a>
						<a class="nui-button"  style="color:#0000FF" plain="true">上月</a>
						<a class="nui-button"  style="color:#0000FF" plain="true">本年</a>
						<a class="nui-button"  style="color:#0000FF" plain="true">上年</a>
						<span style="widht:0;height:100%;border:0.6px solid #AAAAAA;margin:0 10px 0 0" ></span>
						<label class="form_label" >车牌号（客户）：</label>
						<input class="nui-buttonedit" name="isDisabled" emptyText="请输入..." showClose="true" oncloseclick="onClean()" /> 
						<label class="form_label" >维修顾问：</label>
						<input class="nui-combobox" name="isDisabled" emptyText="请选择..." /> 
						<a class="nui-button" iconCls="icon-search" onclick="search()" plain="true">查询（Q）</a>
						<a class="nui-button" iconCls="icon-search" onclick="search()" plain="true" style="color:#0000FF">更多</a>
					</td>
				</tr>
			</table>
		</div>
	</div>

	<div class="nui-toolbar" id="div_1"
		style="border-bottom: 0; padding: 0px;">
		<table style="width: 100%">
			<tr>
				<td style="width: 100%">
					<a class="nui-button" plain="true" iconCls="icon-downgrade" onclick="next()">下一页</a> 
					<a class="nui-button" plain="true" iconCls="icon-user" onclick="customer()">客户资料</a>
					<a class="nui-button" plain="true" iconCls="icon-date" onclick="history()">维修历史</a> 
					<a class="nui-menubutton" plain="true" iconCls="icon-print"  menu="#printMenu">打印</a>
				</td>
			</tr>
		</table>
	</div>
	<div class="nui-splitter" style="width: 100%; height: 100%;"
		vertical="true">
		<div size="40%" showCollapseButton="false">
			<div class="nui-fit">
				<div id="datagrid1" dataField="rpbclass" class="nui-datagrid"
					style="width: 100%; height: 100%;"
					url="com.hsweb.repair.DataBase.class.ClassQuery.biz.ext"
					pageSize="20" showPageInfo="true" multiSelect="true"
					showPageIndex="false" showPage="true" showPageSize="false"
					showReloadButton="false" showPagerButtonIcon="false"
					totalCount="total" onselectionchanged="selectionChanged"
					allowSortColumn="true" frozenStartColumn="0" frozenEndColumn="5">

					<div property="columns">
						<div id="type" field="type" headerAlign="center" allowSort="true"
							visible="true" width="30px">序号</div>
						<div header="基本信息" headerAlign="center">
							<div property="columns">
								<div id="type" field="type" headerAlign="center"
									allowSort="true" visible="true" width="80px">公司名称</div>
								<div id="name" field="name" headerAlign="center"
									allowSort="true" visible="true" width="150px">工单号</div>
								<div id="captainName" field="captainName" headerAlign="center"
									allowSort="true" visible="true" width="80px">维修顾问</div>
								<div id="isDisabled" field="isDisabled" headerAlign="center"
									allowSort="true" visible="true" width="120px">车牌号</div>
								<div id="isDisabled" field="isDisabled" headerAlign="center"
									allowSort="true" visible="true" width="80px">接车卡号</div>
							</div>
						</div>
						<div header="辅助信息" headerAlign="center">
							<div property="columns">
								<div id="type" field="type" headerAlign="center"
									allowSort="true" visible="true" width="60px">品牌</div>
								<div id="name" field="name" headerAlign="center"
									allowSort="true" visible="true" width="150px">车型</div>
								<div id="captainName" field="captainName" headerAlign="center"
									allowSort="true" visible="true" width="60px">质检员</div>
								<div id="isDisabled" field="isDisabled" headerAlign="center"
									allowSort="true" visible="true" width="80px">客户名称</div>
								<div id="isDisabled" field="isDisabled" headerAlign="center"
									allowSort="true" visible="true" width="80px">业务类型</div>
								<div id="isDisabled" field="isDisabled" headerAlign="center"
									allowSort="true" visible="true" width="80px">维修类型</div>
								<div id="isDisabled" field="isDisabled" headerAlign="center"
									allowSort="true" visible="true" width="100px">投保公司</div>
								<div id="isDisabled" field="isDisabled" headerAlign="center"
									allowSort="true" visible="true" width="100px">维修日期</div>
								<div id="isDisabled" field="isDisabled" headerAlign="center"
									allowSort="true" visible="true" width="100px">离厂日期</div>
								<div id="isDisabled" field="isDisabled" headerAlign="center"
									allowSort="true" visible="true" width="80px">是否洗车</div>
								<div id="isDisabled" field="isDisabled" headerAlign="center"
									allowSort="true" visible="true" width="120px">备注</div>
							</div>
						</div>
						<div header="维修项目" headerAlign="center">
							<div property="columns">
								<div id="type" field="type" headerAlign="center"
									allowSort="true" visible="true" width="80px">项目金额</div>
								<div id="name" field="name" headerAlign="center"
									allowSort="true" visible="true" width="60px">优惠率</div>
								<div id="captainName" field="captainName" headerAlign="center"
									allowSort="true" visible="true" width="80px">优惠金额</div>
								<div id="captainName" field="captainName" headerAlign="center"
									allowSort="true" visible="true" width="80px">项目小计</div>
							</div>
						</div>
						<div header="材料信息" headerAlign="center">
							<div property="columns">
								<div id="type" field="type" headerAlign="center"
									allowSort="true" visible="true" width="80px">材料金额</div>
								<div id="name" field="name" headerAlign="center"
									allowSort="true" visible="true" width="60px">优惠率</div>
								<div id="captainName" field="captainName" headerAlign="center"
									allowSort="true" visible="true" width="80px">优惠金额</div>
								<div id="captainName" field="captainName" headerAlign="center"
									allowSort="true" visible="true" width="80px">材料小计</div>
							</div>
						</div>
						<div header="金额信息" headerAlign="center">
							<div property="columns">
								<div id="type" field="type" headerAlign="center"
									allowSort="true" visible="true" width="80px">维修金额</div>
								<div id="name" field="name" headerAlign="center"
									allowSort="true" visible="true" width="100px">材料管理费</div>
								<div id="captainName" field="captainName" headerAlign="center"
									allowSort="true" visible="true" width="60px">辅料费</div>
								<div id="captainName" field="captainName" headerAlign="center"
									allowSort="true" visible="true" width="80px">折让金额</div>
								<div id="captainName" field="captainName" headerAlign="center"
									allowSort="true" visible="true" width="80px">其他费用</div>
								<div id="captainName" field="captainName" headerAlign="center"
									allowSort="true" visible="true" width="100px">整单优惠率</div>
								<div id="captainName" field="captainName" headerAlign="center"
									allowSort="true" visible="true" width="100px">总优惠金额</div>
								<div id="captainName" field="captainName" headerAlign="center"
									allowSort="true" visible="true" width="80px">结算金额</div>
								<div id="captainName" field="captainName" headerAlign="center"
									allowSort="true" visible="true" width="8，，0px">发票金额</div>
							</div>
						</div>

					</div>
				</div>
			</div>
		</div>
		<div showCollapseButton="false">
			<div id="mainTabs" class="nui-tabs" activeIndex="0"
				style="width: 100%; height: 100%;" plain="false" onactivechanged="">
				<div title="维修套餐" url="./subpage/RepairCombo.jsp"></div>
				<div title="估算项目/材料" url="./subpage/EstimateItem.jsp"></div>
				<div title="维修项目/材料" url="./subpage/RepairItem.jsp"></div>
				<div title="出单项目/材料 " url="./subpage/OutItem.jsp"></div>
				<div title="辅料清单 " url="./subpage/PartList.jsp"></div>
				<div title="出车报告 " url="./subpage/OutCar.jsp"></div>
				<div title="描述信息 " url="./subpage/Description.jsp"></div>
			</div>
		</div>
	</div>



	<ul id="printMenu" class="nui-menu" style="display:none;">
		<li class="separator"></li>
        <li onclick="print()">打印维修委托单（A）</li>
        <li>打印派工单（C）</li>
	    <li>打印结算单（E）</li>
	    <li>打印出单结算单（F）</li>
    </ul>

	<script type="text/javascript">
    	nui.parse();
    	var grid = nui.get("datagrid1");
    	var formData = new nui.Form("#form1").getData(false, false);
    	grid.load(formData);
    	
    	function customer(){
    		nui.open({
    			url:"../../RepairBusiness/CustomerProfile/CustomerProfileDetail.jsp",
    			title:"客户资料",width:460,height:640,
    			onload:function(){
    			    var iframe = this.getIFrameEl();
    			    var data = {pageType:"customer"};
    			    iframe.contentWindow.setData(data);
    			},
    			
    		    ondestroy:function(action){
    		    grid.reload();
    		}	
    		});
    	}
    </script>
</body>
</html>