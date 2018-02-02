<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false" %>
	
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<!-- 
  - Author(s): Administrator
  - Date: 2018-02-02 15:41:15
  - Description:
-->
<head>
<title>标准配件</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
    <script src="<%= request.getContextPath() %>/common/nui/nui.js" type="text/javascript"></script>
    
</head>
<body style="margin: 0; height: 100%; width: 100%; overflow: hidden">
	<div  class="nui-splitter" style="width:100%;height:100%;" allowResize="false" vertical="true">
	    <div size="50%" showCollapseButton="false">
	    	<div>
	    		<label>原厂配件编码</label>
	    	</div>
	        <div  class="nui-fit" >
				<div  class="nui-datagrid" id="datagrid1" dataField="" style="width:100%;height:100%" url=""
				      multiSelect="true" showPager="false" showReloadButton="false"
					  allowSortColumn="true" frozenStartColumn="0" frozenEndColumn="0">
					<div property="columns">
						<div type="indexcolumn">序号</div>
						<div header="&nbsp" headerAlign="center">
							<div property="columns" >
								<div field="" width="100px" headerAlign="center" allowSort="true">
									配件编码
								</div>
								<div field="" width="180px" headerAlign="center" allowSort="true">
									原厂名称
								</div>
								<div field="" width="100px" headerAlign="center" allowSort="true">
									标准名称
								</div>
								<div field="" width="180px" headerAlign="center" allowSort="true">
									市场金额
								</div>
								<div field="" width="80px" headerAlign="center" allowSort="true">
									建议销价
								</div>
								<div field="" width="80px" headerAlign="center" allowSort="true">
									备注
								</div>
								<div field="" width="180px" headerAlign="center" allowSort="true">
									主组别编码
								</div>
								<div field="" width="60px" headerAlign="center" allowSort="true">
									主组别
								</div>
								<div field="" width="100px" headerAlign="center" allowSort="true">
									子组别编码
								</div>
								<div field="" width="100px" headerAlign="center" allowSort="true">
									主组别
								</div>
								<div field="" width="100px" headerAlign="center" allowSort="true">
									状态
								</div>
								<div field="" width="50px" headerAlign="center" allowSort="true">
									内码
								</div>
							</div>
						</div>
					</div>	  
				</div>
			</div>
	    </div>
	    <div showCollapseButton="false">
	        <div  class="nui-splitter" style="width:100%;height:100%;">
			    <div size="70%" showCollapseButton="false">
			    	<div>
			    		<label>连锁库存分布</label>
			    	</div>
			        <div  class="nui-fit">
						<div id="mainTabs" class="nui-tabs" activeIndex="0" style="width: 100%; height: 100%;" plain="false" onactivechanged="">
							<div title="本店" >
								<div  class="nui-fit" >
									<div  class="nui-datagrid" id="datagrid1" dataField="" style="width:100%;height:100%" url=""
									      multiSelect="true" showPager="false" showReloadButton="false"
										  allowSortColumn="true">
										<div property="columns">
											<div type="indexcolumn" width="40px">序号</div>
											<div field="" width="80px" headerAlign="center" allowSort="true">
												配件内码
											</div>
											<div field="" width="70px" headerAlign="center" allowSort="true">
												配件编码
											</div>
											<div field="" width="100px" headerAlign="center" allowSort="true">
												配件名称
											</div>
											<div field="" width="60px" headerAlign="center" allowSort="true">
												库存
											</div>
											<div field="" width="60px" headerAlign="center" allowSort="true">
												仓库
											</div>
											<div field="" width="50px" headerAlign="center" allowSort="true">
												库龄
											</div>
										</div>	  
									</div>
								</div>
							</div>
							<div title="连锁" >
								<div  class="nui-fit" >
									<div  class="nui-datagrid" id="datagrid1" dataField="" style="width:100%;height:100%" url=""
									      multiSelect="true" showPager="false" showReloadButton="false"
										  allowSortColumn="true">
										<div property="columns">
											<div type="indexcolumn" width="40px">序号</div>
											<div field="" width="60px" headerAlign="center" allowSort="true">
												店名
											</div>
											<div field="" width="75px" headerAlign="center" allowSort="true">
												配件内码
											</div>
											<div field="" width="75px" headerAlign="center" allowSort="true">
												配件编码
											</div>
											<div field="" width="85px" headerAlign="center" allowSort="true">
												配件名称
											</div>
											<div field="" width="40px" headerAlign="center" allowSort="true">
												库存
											</div>
											<div field="" width="50px" headerAlign="center" allowSort="true">
												仓库
											</div>
											<div field="" width="40px" headerAlign="center" allowSort="true">
												库龄
											</div>
										</div>	  
									</div>
								</div>
							</div>
						</div>
					</div>
			    </div>
			    <div showCollapseButton="false">
			        <div>
			    		<label>互换配件编码</label>
			    	</div>
			    	<div  class="nui-fit" >
						<div  class="nui-datagrid" id="datagrid1" dataField="" style="width:100%;height:100%" url=""
							  multiSelect="true" showPager="false" showReloadButton="false"
							  allowSortColumn="true">
							<div property="columns">
								<div type="indexcolumn" width="40px">序号</div>
								<div field="" width="40px" headerAlign="center" allowSort="true">
									品牌
								</div>
								<div field="" width="70px" headerAlign="center" allowSort="true">
									配件编码
								</div>
								<div field="" width="40px" headerAlign="center" allowSort="true">
									热度
								</div>
							</div>	  
						</div>
					</div>
			    </div>
			</div>

	    </div>
	</div>

	



	<script type="text/javascript">
    	nui.parse();
    </script>
</body>
</html>