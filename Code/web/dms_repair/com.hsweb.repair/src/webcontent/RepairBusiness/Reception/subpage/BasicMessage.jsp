<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<!-- 
  - Author(s): Administrator
  - Date: 2018-01-25 15:23:28
  - Description:
-->
<head>
<title>基本信息</title>
<meta http-equiv="content-type" content="text/html; charset=UTF-8" />
<script src="<%= request.getContextPath() %>/common/nui/nui.js"
	type="text/javascript"></script>
	<style type="text/css">
		#data{
			
			width:200px
		}
	</style>
</head>
<body style="margin: 0; height: 100%; width: 100%; overflow: hidden">
	<div  class="nui-form1" id="form1" >
        <input class="nui-hidden" name="criteria/_entity" value=""/>
    </div>
	<!-- 上下 -->
	<div class="nui-splitter" handlerSize="2" showHandleButton="false" style="width: 100%; height: 100%;" borderStyle="border:1" vertical="true">
		<div size="40%" showCollapseButton="false">
			<!-- 基本信息 -->
				<div class="nui-panel" title="基本信息" id="div_1" style="border-bottom: 0; padding: 0px; width: 100%; height: 100%;">
				<div class="nui-fit" id="datagrid1">
					<table class="nui-form-table" style="margin:0;height:100%;width:100%;">
						<tr style="display: block; margin:5px 0 0 0">
							<td width="75px">
								<span style="margin-left: 10px;">车牌号：</span>
							</td>
							<td >
								<input class="nui-textbox" style="width: 165px;" /> 
								<a class="nui-button"  onclick="onChange()"  >改</a>
							</td>
							
							<td width="75px">
								<span style="margin-left: 10px;">业务类型：</span>
							</td>
							<td>
								<input class="nui-combobox" id="data" /> 
							</td>
							<td width="75px">
								<span style="margin-left: 10px;">维修类型：</span>
							</td>
							<td>
								<input class="nui-combobox" id="data" />
							</td>
						</tr>
						<tr style="display: block; margin:5px 0 0 0">
							<td width="75px">
								<span style="margin-left: 10px;">维修顾问：</span>
							</td>
							<td>
								<input class="nui-combobox" id="data" allowInput="false"  /> 
							</td>
							<td width="75px">
								<span style="margin-left: 10px;">进厂油量：</span>
							</td>
							<td>
								<input class="nui-combobox" id="data"  allowInput="false" /> 
							</td>
							<td width="75px">
								<span style="margin-left: 10px;">进厂里程：</span>
							</td>
							<td>
								<input class="nui-Spinner" id="data"   format="n" allowNull="true" value=" " showButton="false"/>
							</td>
						</tr>
						<tr style="display: block; margin:5px 0 0 0">
							<td width="75px">
								<span style="margin-left: 10px;">进厂日期：</span>
							</td>
							<td>
								<input id="data"  class="nui-datepicker" value="" nullValue="null"
									   format="yyyy-MM-dd " showOkButton="false" showClearButton="true" 
								/> 
							</td>
							<td width="75px">
								<span style="margin-left: 10px;">报价日期：</span>
							</td>
							<td>
								<input id="data" class="nui-datepicker" value=""  format="yyyy-MM-dd HH:mm:ss"
									   nullValue="null" timeFormat="HH:mm:ss" showTime="true" showOkButton="false" showClearButton="true" 
								/> 
							</td>
							<td width="75px">
								<span style="margin-left: 10px;">维修日期：</span>
							</td>
							<td>
								<input id="data" class="nui-datepicker" value=""  format="yyyy-MM-dd HH:mm:ss"
									   nullValue="null" timeFormat="HH:mm:ss" showTime="true" showOkButton="false" showClearButton="true" 
								/>
							</td>
						</tr>
						<tr style="display: block; margin:5px 0 0 0">
							<td width="75px">
								<span style="margin-left: 10px;">完工日期：</span>
							</td>
							<td>
								<input id="data"  class="nui-datepicker" value="" nullValue="null"
									   format="yyyy-MM-dd " showOkButton="false" showClearButton="true" 
								/> 
							</td>
							<td width="75px">
								<span style="margin-left: 10px;">预计交车：
							</td>
							<td>
								<input id="data"  class="nui-datepicker" value=""  format="yyyy-MM-dd HH:mm:ss"
									   nullValue="null" timeFormat="HH:mm:ss" showTime="true" showOkButton="false" showClearButton="true" 
								/> 
							</td>
							<td width="75px">
								<span style="margin-left: 10px;">接车卡号：</span>
							</td>
							<td>
								<input class="nui-textbox" id="data" /> 
							</td>
						</tr>
						<tr style="display: block; margin:5px 0 0 0">
							<td width="75px">
								<span style="margin-left: 10px;">是否洗车：</span>
							</td>
							<td>
								<input class="nui-combobox" id="data"  allowInput="false" />  
							</td>
							<td width="75px">
								<span style="margin-left: 10px;">备注：</span>
							</td>
							<td>
								<input class="nui-textbox" style="width: 485px;" />
							</td>
						</tr>
					</table>
					
				</div>
			</div>
		</div>

		<div>
			<div class="nui-splitter" handlerSize="2" showHandleButton="false"
				style="width: 100%; height: 100%;" borderStyle="border:0"
				vertical="true">
				<div showCollapseButton="false" size="50%">
					<!-- 描述信息 -->
					<div class="nui-panel" title="描述信息" id="div_1"
						style="border-bottom: 0; padding: 0px; width: 100%; height: 100%;">
						<div class="nui-fit"  style="margin: 0; height: 100%; width: 100%; overflow: hidden">
							<table>
								<tr>
									<td>
										<div style="margin: 0 0 0 4px">
											客户描述：
											<div style="margin-top: 5px">
												<input class="nui-textarea"
													style="width: 295px; height: 100px;" />
											</div>
										</div>
									</td>
									<td>
										<div style="margin: 0 0 0 4px">
											解决措施：
											<div style="margin-top: 5px">
												<input class="nui-textarea"
													style="width: 295px; height: 100px;" />
											</div>
										</div>
									</td>
									<td>
										<div style="margin: 0 0 0 4px">
											故障现象：
											<div style="margin-top: 5px">
												<input class="nui-textarea"
													style="width: 295px; height: 100px;" />
											</div>
										</div>
									</td>
								</tr>
							</table>
						</div>
					</div>
				</div>

				<div showCollapseButton="false">
					<!-- 客户/车辆信息 -->

					<div class="nui-panel" title="客户/车辆信息" id="div_1"
						style="border-bottom: 0; padding: 0; width: 100%; height: 100%;">
						<div class="nui-fit">
							<table>
								<tr style="display: block; margin:10px 0 0 0">
									<td width="75px">
										<span style="margin: 0 0 0 10px">VIN：</span>
									</td>
									<td>
										<input class="nui-textbox" style="width: 200px;" />
									</td>

									<td width="70px">
										<span style="margin: 0 0 0 10px">车型：</span>
									</td>
									<td>
										<input class="nui-combobox" style="width: 400px;" />
									</td>
								</tr>
								<tr style="display: block; margin:10px 0 0 0">
									<td width="75px">
										<span style="margin: 10px 0 0 10px">发动机：</span>
									</td>
									<td>
										<input class="nui-textbox" style="width: 200px;" />
									</td>

									<td width="70px">
										<span style="margin: 0 0 0 10px">客户名称：</span>
									</td>
									<td>
										<input class="nui-combobox" style="width: 400px;" />
									</td>
								</tr>
								<tr style="display: block; margin:10px 0 0 0">
									<td width="75px">
										<span style="margin: 0">联系人姓名：</span>
									</td>
									<td>
										<input class="nui-textbox" style="width: 200px;" />
									</td>

									<td width="70px">
										<span style="margin: 0 0 0 10px">身份：</span>
									</td>
									<td>
										<input class="nui-textbox" style="width: 170px; margin: 0 3px 0 0;" /> 
									</td>
									<td>
										<span style="margin:0;">手机号码：</span> 
									</td>
									<td>
										<input class="nui-textbox" style="width: 160px; margin: 0;" />
									</td>
								</tr>
							</table>
						</div>
					</div>

				</div>
			</div>

			<!-- 竖向splitter结束 -->
		</div>

	</div>





	<script type="text/javascript">
    	nui.parse();
    	var grid = nui.get("datagrid1");
    	var formData = new nui.Form("#form1").getData(false, false);
    	grid.load(formData);
    	
    	function onChange(){
    		nui.open({
    			url:"../../RepairBusiness/CustomerProfile/subpage/Customer.jsp",
    			title:"客户选择",width:900,height:550,
    			onload:function(){
    			    var iframe = this.getIFrameEl();
    			    var data = {pageType:"change"};
    			    iframe.contentWindow.setData(data);
    			},
    			
    		    ondestroy:function(action){
    		    grid.reload();
    		}	
    		});
    	}
    	//重新刷新页面
    	function refresh(){
    		var form = new nui.Form("#form1");
    		var json = form.getData(false, false);
    		grid.load(json);
    		nui.get("update").enable();
    	}
    	//查询
    	function search(){
    		var form = new nui.Form("#form1");
    		var json = form.getData(false, false)
    		grid.load(json);
    	}
    	//重置查询条件
    	function reset(){
    		var form = new nui.Form("#form1");
    		grid.reset();
    	}
    </script>
</body>
</html>