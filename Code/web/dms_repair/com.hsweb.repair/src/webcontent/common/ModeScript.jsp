<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false" %>
	
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<!-- 
  - Author(s): Administrator
  - Date: 2018-02-06 16:41:08
  - Description:
-->
<head>
<title>话术模板</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
    <script src="<%= request.getContextPath() %>/common/nui/nui.js" type="text/javascript"></script>
    
</head>
<body style="margin: 0; height: 100%; width: 100%; overflow: hidden">
	<div  class="nui-toolbar"  style="height:50px">
        <div  class="nui-form1" id="form1" style="height:100%">
        	<input class="nui-hidden" name="criteria/_entity" value=""/>
        	<table class="table" id="table1" style="height:100%;width: 700% ">
        		<tr style="display: block; margin:-5px 0;">
					<td style="width:700px">
						<span style="color:#0000FF;">
							销售很大程度上是语言的科学，销售的和核心智慧，就是销售的话术。
						</span>
					</td>
				</tr>
        		<tr style="display: block; margin:-5px 0;">
        	   		<td>
        	    		<label style="font-family:Verdana;">快速查询：</label>
        	    	</td>
                	<td>
                		<span style="width:0;height:100%;border: 0.6px solid #AAAAAA;margin:5px" ></span>
                	</td>
                	<td>
                		<label>话术来源：</label>
                	</td>
                	<td>
                		<input class="nui-textbox" style="widht:150px"/>
                	</td>
                	<td>
                		<label>主题：</label>
                	</td>
                	<td>
                		<input class="nui-textbox" style="widht:150px"/>
                	</td>
                	
                	<td>
                		<label>创建人：</label>
                	</td>
                	<td>
                		<input class="nui-textbox" style="widht:150px"/>
                		<a class="nui-button" iconCls="icon-search" plain="true" onclick="">查询(Q)</a>
                	</td>
        		</tr>
			</table>
		</div>
	</div>
	<div class="nui-toolbar" style="border-bottom: 0; padding: 0px;">
		<table style="width: 100%">
			<tr>
				<td style="width: 100%">
					<a class="nui-button" plain="true" iconCls="icon-ok" onclick="onChoise()">选择（C）</a> 
				</td>
			</tr>
		</table>
	</div>

	<div class="nui-fit">
		<div class="nui-splitter" style="width: 100%; height: 100%;" allowResize="false">
			<div size="25%" showCollapseButton="false">
				<div class="nui-fit">
					<div class="nui-toolbar" style="height: 21px;text-align: center;margin:-2px 0 0 0" >话术类型</div>
					<ul  class="nui-tree" resultAsTree="false" style="width:100%;height:93%;" idField="id" parentField="pid" textField="text" url="">
						
					</ul>
				</div>
			</div>
			<div showCollapseButton="false">
				<div class="nui-fit">
					<div id="datagrid1" dataField="rpbclass" class="nui-datagrid"
						style="width: 100%; height: 100%;"
						url=""
						multiSelect="true" showReloadButton="false" showPager="false" totalCount="total" onselectionchanged="selectionChanged"
						allowSortColumn="true">


						<div property="columns">
							<div type="indexcolumn" headerAlign="center" allowSort="true" width="30px">序号</div>
							<div header="&nbsp" headerAlign="center">
								<div property="columns">
									<div field="" headerAlign="center" allowSort="true" width="60px">主题</div>
									<div field="" headerAlign="center" allowSort="true" width="180px">话术内容</div>
								</div>
							</div>
							<div header="&nbsp" headerAlign="center">
								<div property="columns">
									<div field="" headerAlign="center" allowSort="true" width="60px">创建人</div>
									<div field="" headerAlign="center" allowSort="true" width="90px">创建日期</div>
									<div field="" headerAlign="center" allowSort="true" width="90px">话术来源</div>
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