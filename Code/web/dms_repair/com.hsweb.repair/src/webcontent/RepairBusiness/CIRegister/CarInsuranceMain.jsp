<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<!-- 
  - Author(s): Administrator
  - Date: 2018-01-27 09:33:59
  - Description:
-->
<head>
<title>车险登记</title>
<meta http-equiv="content-type" content="text/html; charset=UTF-8" />
<script src="<%= request.getContextPath() %>/common/nui/nui.js"
	type="text/javascript"></script>

</head>
<body style="margin: 0; height: 100%; width: 100%; overflow: hidden">
	<div  class="nui-toolbar"  style="height:26px">
		<div class="nui-form1" id="form1" style="height: 100%">
			<input class="nui-hidden" name="criteria/_entity" value="" />
			
			<table class="table" id="table1" style="height: 100%;">
				<tr style="display: block; margin:-3px 0">
					<td>
						<label style="font-family:Verdana;">快速查询：</label>
					</td>
					<td>
						<a class="nui-button"  style="color:#0000FF" plain="true"><u>本日</u></a>
						<a class="nui-button"  style="color:#0000FF" plain="true"><u>昨日</u></a>
						<a class="nui-button"  style="color:#0000FF" plain="true"><u>本周</u></a>
						<a class="nui-button"  style="color:#0000FF" plain="true"><u>上周</u></a>
						<a class="nui-button"  style="color:#0000FF" plain="true"><u>本月</u></a>
						<a class="nui-button"  style="color:#0000FF" plain="true"><u>上月</u></a>
						<a class="nui-button"  style="color:#0000FF" plain="true"><u>本年</u></a>
						<a class="nui-button"  style="color:#0000FF" plain="true"><u>上年</u></a>
					</td>
					<td>
						<span style="widht:0;height:100%;border:0.6px solid #AAAAAA;margin:0 10px 0 0" ></span>
					</td>
					<td>
						
						<label class="form_label" >车牌号：</label>
						<input class="nui-buttonedit" name="isDisabled" emptyText="请输入..." showClose="true" oncloseclick="onClean()" /> 
						<label class="form_label" >客户名称：</label>
						<input class="nui-combobox" name="isDisabled" emptyText="请选择..." /> 
						<a class="nui-button" iconCls="icon-search" onclick="search()" plain="true">查询（Q）</a>
						<a class="nui-button"  onclick="onMore()" plain="true" style="color:#0000FF;"><u>更多</u></a>
					</td>
				</tr>
			</table>
		</div>
	</div>

	<div class="nui-toolbar" style="border-bottom: 0; padding: 0px;">
		<table style="width: 100%">
			<tr>
				<td style="width: 100%">
					<a class="nui-button" plain="true" iconCls="icon-reload" onclick="reload()">刷新（R）</a> 
					<a class="nui-button" plain="true" iconCls="icon-add" onclick="add()">新增（A）</a>
					<a class="nui-button" plain="true" iconCls="icon-save" onclick="save()">保存（S）</a> 
					<a class="nui-button" plain="true" iconCls="" onclick="settlement()">结算（S）</a> 
					<a class="nui-button" plain="true" iconCls="icon-undo" onclick="undo()">返单（B）</a> 
					<a class="nui-button" plain="true" iconCls="icon-print" onclick="print()">打印（P）</a>
				</td>
			</tr>
		</table>
	</div>

	<div class="nui-fit">
		<div class="nui-splitter" style="width: 100%; height: 100%;" allowResize="false">
			<div size="40%" showCollapseButton="false">
				<div class="nui-fit">
					<div id="datagrid1" dataField="rpbclass" class="nui-datagrid"
						style="width: 100%; height: 100%;"
						url=""
						pageSize="50" showPageInfo="true" multiSelect="true"
						showReloadButton="true" showPagerButtonIcon="true"
						totalCount="total" onselectionchanged="selectionChanged"
						allowSortColumn="true">


						<div property="columns">
							<div id="type" field="type" headerAlign="center" allowSort="true"
								visible="true" width="35px">序号</div>
							<div header="">
								<div property="columns">
									<div id="type" field="type" headerAlign="center"
										allowSort="true" visible="true" width="40px">状态</div>
								</div>
							</div>
							<div header="">
								<div property="columns">
									<div id="type" field="type" headerAlign="center"
										allowSort="true" visible="true" width="60px">车牌号</div>
									<div id="type" field="type" headerAlign="center"
										allowSort="true" visible="true" width="80px">被保险人</div>
									<div id="type" field="type" headerAlign="center"
										allowSort="true" visible="true" width="60px">品牌</div>
									<div id="type" field="type" headerAlign="center"
										allowSort="true" visible="true" width="60px">车型</div>
								</div>
							</div>
							<div header="交强险" headerAlign="center">
								<div property="columns">
									<div id="type" field="type" headerAlign="center"
										allowSort="true" visible="true" width="100px">购买日期</div>
									<div id="type" field="type" headerAlign="center"
										allowSort="true" visible="true" width="100px">到期日期</div>
								</div>
							</div>
							<div header="商业险" headerAlign="center">
								<div property="columns">
									<div id="type" field="type" headerAlign="center"
										allowSort="true" visible="true" width="100px">购买日期</div>
									<div id="type" field="type" headerAlign="center"
										allowSort="true" visible="true" width="100px">到期日期</div>
								</div>
							</div>
							<div header="">
								<div property="columns">
									<div id="type" field="type" headerAlign="center"
										allowSort="true" visible="true" width="150px">工单号</div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
			<div showCollapseButton="false">
				<div id="mainTabs" class="nui-tabs" activeIndex="0"
					style="width: 100%; height: 100%;" plain="false" onactivechanged="">
					<div title="基本信息" url="./subpage/BasicMessage.jsp"></div>
					<div title="险种信息" url="./subpage/InsuranceType.jsp"></div>
				</div>
			</div>
		</div>
	</div>



	<script type="text/javascript">
    	nui.parse();
    	
    	function settlement() {
			nui.open({
    			url:"./subpage/SettlementInsurance.jsp",
    			title:"保险结算",width:450,height:520,
    			onload:function(){
    			    var iframe = this.getIFrameEl();
    			    var data = {pageType:"settlement"};
    			    iframe.contentWindow.setData(data);
    			},
    			
    		    ondestroy:function(action){
    		    grid.reload();
    		}	
    		});
		}
		function onMore(){
    		nui.open({
    			url:"./subpage/More.jsp",
    			title:"高级查询",width:400,height:290,
    			onload:function(){
    			    var iframe = this.getIFrameEl();
    			    var data = {pageType:"more"};
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