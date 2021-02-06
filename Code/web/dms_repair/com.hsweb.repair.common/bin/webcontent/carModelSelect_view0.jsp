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
<script src="<%= request.getContextPath() %>/commonRepair/js/carModelSelect.js?v=1.0.4"></script>
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
<body>

<div class="nui-splitter" style="width:100%;height:100%;"
     borderStyle="border:0"
     handlerSize="6" allowResize="false">
    <div size="250" showCollapseButton="false" style="border:0;">
        <div class="nui-panel" title="品牌-厂商-车系"
             headerCls="panel-header"
             style="width:100%;height:100%;"
             showToolbar="false" showCloseButton="false" showFooter="false">
            <!--body-->
            <ul id="tree" class="nui-tree"
                style="width:100%;height:100%;"
                dataField="list"
                showTreeIcon="true" textField="nodeName" idField="nodeId" >
            </ul>
        </div>
    </div>
    <div showCollapseButton="false" style="border:0;">
        <div class="nui-toolbar" style="border-bottom: 0;">
            <div class="nui-form" id="queryForm">
                <table class="table">
                    <tr>
                        <td>
                            <label>车型名称</label>
                            <input class="nui-textbox" name="carModel" onenter="searchOnenter" id="carModel"/>
                            <a class="nui-button" iconCls="" plain="true" onclick="onSearch()"><span class="fa fa-search fa-lg"></span>&nbsp;查询</a>
                            <a class="nui-button" iconCls="" plain="true" onclick="onOk()"><span class="fa fa-check fa-lg"></span>&nbsp;选择</a>
                        </td>
                    </tr>
                </table>
            </div>
        </div>
        <div class="nui-fit">
            <div id="datagrid1"
                 class="nui-datagrid" style="width:100%;height:100%;"
                 showPager="false"
                 dataField="list"
                 allowSortColumn="true"
                 virtualScroll="true"
                 frozenStartColumn="0" frozenEndColumn="0">
                <div property="columns">
                    <div width="30" type="indexcolumn">序号</div>
                    <div field="carBrandName" headerAlign="center" allowSort="true" visible="true" header="品牌"></div>
                    <div field="carFactoryName" headerAlign="center" allowSort="true" visible="true" header="厂商"></div>
                    <div field="carSeriesName" headerAlign="center" allowSort="true" visible="true" header="车系"></div>
                    <div field="carModel" headerAlign="center" allowSort="true" visible="true" header="品牌车型"></div>
                    <div field="remark" headerAlign="center" allowSort="true" visible="true" header="备注"></div>
                    <div field="id" headerAlign="center" allowSort="true" visible="true" header="车型ID"></div>
                </div>
            </div>
        </div>
    </div>
</div>


</body>
</html>
