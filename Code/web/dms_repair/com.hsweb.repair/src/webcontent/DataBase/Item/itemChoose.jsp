<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false"%>
<%@include file="/common/common.jsp"%>
<%@include file="/common/commonRepair.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<!-- 
  - Author(s): Administrator
  - Date: 2018-01-23 17:00:58
  - Description:
-->
<head>
<title>维修项目</title>

<script src="<%= request.getContextPath() %>/repair/js/DataBase/Item/itemChoose.js?v=1.0.53" type="text/javascript"></script>
<style type="text/css">
    html, body{
        margin:0px;padding:0px;border:0px;width:100%;height:100%;overflow:hidden;
    }
    .form_label {
	width: 80px;
	text-align:right;
   }
    .addyytime a.ztedit{ height:18px; display:inline-block; background:url(../images/sjde.png) 40px -1px no-repeat; padding-right:22px; color:#888; text-decoration:none;}
    .addyytime a.hui{padding-left: 5px;padding-right: 5px;height:;line-height:24px;border:1px #a6e0f5 solid;display:block;float:left;text-decoration:none;
        text-align:center;color:#00b4f6;border-radius:4px;margin:0 5px 5px 0;}
    .addyytime a.hui{border:1px #e6e6e6 solid;color:#555555;background:#ffc8a6;}
    .addyytime a.xz{ font-size: 13px; color: #555555 !important; background:#5ab1ef !important;}
    .addyytime a:link, a:visited { font-family: 微软雅黑, Arial, Helvetica, sans-serif; font-size: 13px; color: #555555; text-decoration: none; }
    .addyytime a.hui:hover { font-family: 微软雅黑, Arial, Helvetica, sans-serif; font-size: 13px;background-color: #9fe6b8 ; color: #FFF; text-decoration: none; }
    .addyytime a .hui{text-decoration:none;transition:all .4s ease;}
    .addyytime a.backRed{border:1px #e6e6e6 solid;color:#555555;background:#f17171 ;}
</style>
</head>
<body>       
   <div class="nui-fit">
	<div class="nui-splitter" style="width: 100%; height: 100%;"
		 showHandleButton="false">
		<div size="200" showCollapseButton="false">
			<div class="nui-fit">
				<!-- onactivechanged="onTabChanged" -->
				 <div class="nui-tabs"  id="mainTab" 
                           activeIndex="0" style="width: 100%; height: 100%;" plain="false" borderStyle="border:0;">
                     
                  <div title="热词">
                          <div class="addyytime" style="display:''" id="showHot" >
                             <table style="width:100%;height:50px;">
		                        <tr>
				                    <td id="addAEl">
				           
				                       <!--  <a href='javascript:;' itemid='1'name='type'class='hui'>交强险到</a>
				                        <a href='javascript:;' itemid='2'name='type'class='hui'>保养到户</a>
				                        <a href='javascript:;' itemid='3'name='type'class='hui'>年检到</a>
				                        <a href='javascript:;' itemid='3'name='type'class='hui'>驾照年审</a>
				                        <a href='javascript:;' itemid='3'name='type'class='hui'>客户生日</a>   -->
				                        
				                    </td>
		                       </tr>
                         </table>
                      </div>
                      
                      </div>
                      <div title="分类">
                      <div class="nui-toolbar"
					         style="padding: 2px; border-top: 0; border-left: 0; border-right: 0; text-align: center;">
					      <span>本地项目类型</span>
				      </div>
				         <div style="width: 100%; height: 55%;">
							<ul id="tree1" class="nui-tree" url="" style="width: 100%;"
								dataField="data"
								resultAsTree="false"
								showTreeIcon="true"
								textField="name" idField="id" parentField="dictid">
							</ul>
				        </div>
			
					<div class="nui-toolbar"
						 style="padding: 2px; border-top: 0; border-left: 0; border-right: 0; text-align: center;">
						<span>标准项目类型</span>
					</div>
					<div style="width: 100%; height: 35%;">
					<!--	<ul id="tree" class="nui-tree" url="" style="width: 100%;height:100%;"
							dataField="result" showTreeIcon="true" textField="name" 
							idField="code" >
						</ul>-->
						       <ul id="tree" class="mini-tree" style="width: 100%;height:100%;"
						        showTreeIcon="true" textField="name" idField="code" >        
						    </ul>
        
				    </div>
		   
                </div>
             </div>
				
		</div>
	</div>
		<div showCollapseButton="false">
			<div class="nui-toolbar" style="padding: 2px; border-bottom: 0;">
				<input class="nui-textbox" id="state" visible="false"/>
				<div class="form" id="queryForm">
					<table class="table" id="table1">
					    <tr id="WechatShow">
					        <td style="width:40px">
						    <label >品牌：</label>
							</td>
							<td >
								<input class="nui-combobox" name="carBrandId" id="carBrandId"
										valueField="id"
										textField="nameCn"
										onValuechanged="initCarSeries('carSeriesId', e.value)"
										width="100%" popupHeight="100%"
										allowInput="true"
										valueFromSelect="true"
										/>
							</td>
							
						  <td style="width:40px">
								<label>车系：</label>
							</td>
							<td>
								<input class="nui-combobox" name="carSeriesId" id="carSeriesId"
										valueField="carSeriesId"
										textField="carSeriesName"
										onValuechanged="initCarModel('carModelId', '', e.value)"
										width="100%" popupHeight="100%"
										allowInput="true"
										valueFromSelect="true"
										/>
							</td>
						   <td style="width:65px">
								<label>品牌车型：</label>
							</td>
							<td colspan="1">
								<input class="nui-combobox" name="carModelId" id="carModelId"
										valueField="carModelId"
										textField="carModel"
										width="100%" popupHeight="100%"
										allowInput="true"
										valueFromSelect="true"
										/>
							</td>
							</tr>
						<tr>
							<td colspan="6">
								<input name="dataType"
										id="dataType"
										class="nui-combobox"
										value="1"
										textField="name"
										valueField="id"
										allowInput="true"
										width="80px"
										/>
								<label style="font-family: Verdana;font-size: 12px;" id="serviceLabel">业务类型：</label>
								<input name="serviceTypeId"
										id="serviceTypeId"
										class="nui-combobox"
										textField="name"
										valueField="id"
										emptyText=""
										url=""
										allowInput="true"
										showNullItem="false"
										valueFromSelect="true"
										nullItemText="请选择..."
										width="80px"
										/>
								<!-- <input id="carBrandId"
										name="carBrandId"
										class="nui-combobox width1"
										visible="false"
										textField="nameCn"
										valueField="id"
										emptyText="请选择..."
										url=""
										allowInput="false"
										showNullItem="false"
										nullItemText="请选择..."/> -->
								<label style="font-family: Verdana;font-size: 12px;">项目名称：</label>
								<input class="nui-textbox" width="80px" id="search-name" name="name" onenter="onSearch()" />
								<label style="font-family: Verdana;font-size: 12px;">项目拼音：</label>
								<input class="nui-textbox" width="80px" id="search-namePy" name="namePy" onenter="onSearch()" />
								<label style="font-family: Verdana;font-size: 12px;" id="itemCodeLabel">项目编码：</label>
								<input class="nui-textbox" width="60px" id="search-code" name="code" onenter="onSearch()"/>
								<a class="nui-button" plain="true" iconCls="" onclick="onSearch()"><span class="fa fa-search fa-lg"></span>&nbsp;查询</a>
								<span class="separator"></span>
								<a class="nui-button" id="add" iconCls="" onclick="add()" plain="true"><span class="fa fa-plus fa-lg"></span>&nbsp;新增项目</a>
								<a class="nui-button" plain="true" iconCls="" onclick="onClear()"><span class="fa fa-trash-o"></span>&nbsp;清空</a>
								<a class="nui-button" id="selectBtn" iconCls="" onclick="choose()" plain="true" visible="true"><span class="fa fa-check fa-lg"></span>&nbsp;选择</a>
								<a class="nui-button" id="" iconCls="" onclick="" plain="true" visible="true"><span class="fa fa-user-circle-o fa-lg"></span>&nbsp;语音输入</a>
							</td>
							
						</tr>
					</table>
				</div>
			</div>
            
			<div class="nui-fit">
				<div id="rightGrid"
					 dataField="list"
					 class="nui-datagrid"
					 style="float:left;width: 70%; height: 100%;"
					 url=""
					 borderStyle="border:1"
					 pageSize="50"
					 totalField="page.count"
					 sortMode="client"
					 showPageSize="true"  
					 allowSortColumn="true"
					 selectOnLoad="true"
					 allowCellSelect="true"
					 onDrawCell="onDrawCell"
					 showFilterRow="false">
					<div property="columns" >
						<div type="indexcolumn">序号</div>
						<div type="checkcolumn" name="checkcolumn" visible="false"></div>
						<div field="belonging" headerAlign="center" allowSort="true" width="50px">归属</div>
						<div field="name" headerAlign="center" allowSort="true" width="150px">项目名称</div>
						<div field="type" headerAlign="center" allowSort="true" width="100px">项目类型</div>
						<div field="serviceTypeId" headerAlign="center" allowSort="true" width="60px">业务类型</div>
						<div field="itemTime" headerAlign="center" allowSort="true" visible="true" width="50px">工时</div>
						<div field="unitPrice" headerAlign="center" allowSort="true" width="50px">单价</div>
						<div field="amt" headerAlign="center" allowSort="true" width="50px">金额</div>
						<div field="code" headerAlign="center" width="60px">项目编码</div>
							
					</div>
				</div>
                
               
		        <div class="nui-datagrid" style="float:left;width: 70%; height: 100%;display:none"
					 id="itemGrid"
					 dataField="result"
					 showPager="true"
					 pageSize="500"
					 totalField="page.count"
					 allowSortColumn="true">
					<div property="columns">
						<div type="indexcolumn" width="35">序号</div>
						   	<div field="itemName" width="80" headerAlign="center"  header="项目名称"></div>
						    <div field="itemTime" width="40" headerAlign="center"  allowSort="true" header="工时"></div>
						    <div field="amount" width="40" headerAlign="center"  allowSort="true" header="金额"></div>
							<div field="amount4s" width="40" headerAlign="center"  allowSort="true" header="4s店金额"></div>
						   	<div field="AStandTime" width="40" headerAlign="center" visible="false" allowSort="true" header="工时"></div>
						    <div field="AStandSum" width="40" headerAlign="center" visible="false" allowSort="true" header="项目金额"></div>
							<div field="Amt4S" width="40" headerAlign="center" visible="false" allowSort="true" header="市场金额"></div>
							<div field="itemKind" width="40" headerAlign="center" visible="false" allowSort="true" header="工种"></div>
					</div>
				</div>           
                
                
				<div id="splitDiv" style="float:left;width:1%;height:100%;"></div>
				<div id="tempGrid" class="nui-datagrid" style="float:left;width:29%;height:100%"
					showPager="false"
					pageSize="1000"
					selectOnLoad="true"
					showModified="false"
					multiSelect="true"
					dataField="parts"
					url="">
					<div property="columns" >
						<div type="indexcolumn" width="20px" headerAlign="center">序号</div>
						<div header="已添加项目" headerAlign="left">
							<div property="columns">
								<div type="checkboxcolumn" field="check" trueValue="1" falseValue="0" 
									width="20" headerAlign="center" header="">操作
								</div>
								<div field="itemName" headerAlign="center" allowSort="true" width="80px">项目名称</div>
								<div field="amt" headerAlign="center" allowSort="true" width="20px">金额</div>								
							</div>
						</div>
					</div>
				</div>	
			</div>
		</div>
	</div>
</div>

<div id="advancedAddWin" class="nui-window"
     title="项目类型" style="width:300px;height:160px;"
     showModal="true"
     allowResize="false"
     allowDrag="true">
       <div class="nui-toolbar" style="">
                <table style="width:100%;">
                    <tr>
                        <td style="width:100%;">
                            <a class="nui-button" onclick="onAdvancedAddOk()" plain="true" style="width: 60px;"><span class="fa fa-save fa-lg"></span>&nbsp;保存</ a>
                            <a class="nui-button" onclick="onAdvancedAddCancel()" plain="true"  style="width: 60px;"><span class="fa fa-remove fa-lg"></span>&nbsp;取消</ a>
                        </td>
                    </tr>
                </table>
            </div>
    <div id="advancedAddForm" class="form">
        <input id="id" name="id" width="100%" class="nui-hidden" >
    	<input id="orgid" name="orgid" width="100%" class="nui-hidden" >
        <table class="tmargin" style="width:100%;margin-top:10px;">
            <tr class="htr">
                <td class=" right fwidtha required">类型名称:</td>
                <td ><input id="name" name="name" width="100%" class="nui-textbox" ></td>
            </tr>
            <tr class="htr">
                <td class=" right fwidtha required">上级类型:</td>
                <td ><input id="dictid" name="dictid" width="100%" class="nui-combobox" textField="name" valueField="id"     dataField="" url="" valueFromSelect="true" allowinput="true"></td>
            </tr>
        </table>
    </div>
</div>
</body>

	
</body>
</html>