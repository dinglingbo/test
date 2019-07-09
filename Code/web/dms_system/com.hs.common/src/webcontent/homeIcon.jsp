<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false" %>

    <!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
    <html>
    <!-- 
  - Author(s): Administrator
  - Date: 2019-05-05 14:49:39
  - Description:
-->

    <head>
        <title>主页图片款式</title>
        <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
        <script src="<%= request.getContextPath() %>/common/nui/nui.js" type="text/javascript"></script>
        <%@include file="/common/commonRepair.jsp"%>
            <script src="<%=webPath + contextPath%>/common/js/homeIcon.js?v=1.0.9"></script>
		<script src="<%=webPath + contextPath%>/common/js/jquery-1.11.3.min.js?v=1.0.3"></script>
		<script src="<%=webPath + contextPath%>/common/js/jquery.dad.min.js?v=1.0.3"></script>
            <style>
                html,
                body {
                    margin: 0px;
                    padding: 0px;
                    border: 0px;
                    width: 100%;
                    height: 100%;
                    overflow: hidden;
                }

                .mini-panel-border {
                    border-radius: 0px;
                }
                .dad-noSelect,.dad-noSelect *{
				    -webkit-touch-callout: none;
				    -webkit-user-select: none;
				    -khtml-user-select: none;
				    -moz-user-select: none;
				    -ms-user-select: none;
				    user-select: none;
				    cursor: -webkit-grabbing !important;
				    cursor: -moz-grabbing !important;
				}
				
				.dad-container{
				    position: relative;
				    -webkit-touch-callout: none;
				    -webkit-user-select: none;
				    -khtml-user-select: none;
				    -moz-user-select: none;
				    -ms-user-select: none;
				    user-select: none;
				}
				.dad-container::after{
				    content: '';
				    clear: both !important;
				    display: block;
				}
				.dad-active .dad-draggable-area{
				    cursor: -webkit-grab;
				    cursor: -moz-grab;
				}
				.dads-children-clone{
				    opacity: 0.8;
				    z-index: 9999;
				    pointer-events: none;
				}
				.dads-children-placeholder{
				    overflow: hidden;
				    position: absolute !important;
				    box-sizing: border-box;
				    border:4px dashed #639BF6;
				    margin:5px;
				    text-align: center;
				    color: #639BF6;
				    font-weight: bold;
				}
               .demo { width: 1000px; margin: 0 auto; font-family: arial,SimSun; font-size: 0;}
				.demo .item { display: inline-block; width: 80px; height: 40px; margin-right: 10px; *display: inline; *zoom: 1;}
/* 				.demo .item1 { background-color: #1faeff;}
				.demo .item2 { background-color: #ff2e12;}
				.demo .item3 { background-color: #00c13f;}
				.demo .item4 { background-color: #e1b700;} */
				 .demo span { display: block; height: 40px; line-height: 40px; font-size: 12px; text-align: center; color: #fff;}  
            </style>
    </head>

    <body>
        <input id="level" name="level" class="nui-combobox" visible="false" dataField="data" valueField="customid" textField="name"
        />
                      <div class="nui-toolbar" style="padding:0px;border-bottom:0;">
                    <table style="width:100%;">
                        <tr>
                            <td style="width:100%;">
                                <a class="nui-button" iconCls="" plain="true" onclick="save()"><span class="fa fa-save fa-lg"></span>&nbsp;保存</a>
                                <a class="nui-button" iconCls="" plain="true" onclick="onCancel"><span class="fa fa-close fa-lg"></span>&nbsp;取消</a>
                                <a class="nui-button" iconCls="" plain="true" onclick="delet()" id="deletBtn"><span class="fa fa-trash-o fa-lg"></span>&nbsp;清空</a>
                            </td>
                        </tr>
                    </table>
                </div>
        <div class="nui-splitter" style="width:100%;height:100%;">
            <div style="border:0;" size="30%" showCollapseButton="true">
                <div class="nui-fit">
                    <div class="mini-panel" title="选择功能" style="width:100%;height:100%;" bodyStyle="padding:0;">
						<ul id="tree1" class="mini-tree" style="width: 100%;height:100%;"
						        showTreeIcon="true" textField="menuName" idField="menuPrimeKey" >        
						    </ul>
                    </div>
                </div>
            </div>
            <div style="border:0;" showCollapseButton="true">
				<div class="demo jq22 dad-active dad-container" id="demo" >  					
<!--  					<div class="item item1">	
	 					<a onclick="toRepairBill()">
						<i class="fa fa-wrench fa-4x  fa-inverse"></i>
						<p>综合开单</p> 
						</a> 
					</div>
					<div class="item item2 ">	
	 					<a onclick="toRepairBill()">
						<i class="fa fa-wrench fa-4x  fa-inverse"></i>
						<p>综合开单</p> 
						</a> 
					</div>
					<div class="item item3">	
	 					<a onclick="toRepairBill()">
						<i class="fa fa-wrench fa-4x  fa-inverse"></i>
						<p>综合开单</p> 
						</a> 
					</div>  -->  
<!-- 				<div class="item item1"><span>1</span></div>
					<div class="item item2"><span>2</span></div>
					<div class="item item3"><span>3</span></div>
					<div class="item item4"><span>4</span></div>
					<div class="item item5"><span>5</span></div>
					<div class="item item6"><span>6</span></div>
					<div class="item item7"><span>7</span></div> -->
				</div>
            </div>

        </div>

        <script type="text/javascript">
            $('.demo').dad();
        </script>
    </body>

    </html>