<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false" %>
<%@include file="/common/commonRepair.jsp"%>	
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<!-- 
  - Author(s): localhost
  - Date: 2018-09-28 14:49:40
  - Description:
-->
<head>
<title>维修档案</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
</head>
<body>
<div id="toolbar1" class="nui-toolbar" style="padding:2px;">
    <table style="width:80%;">
        <tr>
        <td style="width:80%;">
        	查询项(S)：<input class="nui-combobox" data="data" textfield="text" valuefield="id" value="1" id="type"onvaluechanged="valueChane()"/>
        	查询值(V)：<input class="nui-textbox"/>
            <span class="separator"></span>
                      出厂日期查询 从：<a class="nui-button" plain="true"><font color="blue"><u>本周</u></font></a>
            <a class="nui-button" plain="true"><font color="blue"><u>上周</u></font></a>
            <a class="nui-button" plain="true"><font color="blue"><u>本月</u></font></a>
            <a class="nui-button" plain="true"><font color="blue"><u>上月</u></font></a>
          	<input class="nui-datepicker"/>&nbsp;至：<input class="nui-datepicker"/>
          	本公司档案：<input  class="nui-checkbox">
          	<span class="separator"></span>
          	<a class="nui-button" iconCls="" plain="true" onclick="onSearch"><span class="fa fa-search fa-lg"></span>&nbsp;查询</a>
          	<span class="separator"></span>
          	<a class="nui-button">客户信息</a>
          	<a class="nui-menubutton" plain="true" menu="#popupMenuPrint" id="menuprint"><span class="fa fa-print fa-lg"></span>&nbsp;打印</a>
		
                <ul id="popupMenuPrint" class="nui-menu" style="display:none;">
                    <li iconCls="" onclick="onPrint(1)" id="type11">报价单</li>
                    <li iconCls="" onclick="onPrint(2)" id="type11">维修报价单</li>
                    <li iconCls="" onclick="onPrint(3)" id="type11">正常结算单</li>
                    <li iconCls="" onclick="onPrint(4)" id="type11">出单结算单</li>
                </ul>
        </td>
        </tr>
    </table>
</div>
<div class="nui-fit">
	<div id="mainGrid" class="nui-datagrid" style="width:100%;height:50%;"
               selectOnLoad="true"
               showPager="true"
               pageSize="80"
               totalField="page.count"
               sizeList=[20,80,80,200]
               dataField="list"
               onrowdblclick=""
               showModified="false"
               allowCellSelect="true"
               editNextOnEnterKey="true"
               url=""
               >
              <div property="columns">
              	<div type="indexcolumn" headerAlign="center" align="center">序号</div>
                  <div header="业务信息" headerAlign="center" >
                	<div property="columns">
                		<div field="" width="80" headerAlign="center" align="center" header="店号"></div>
                		<div field="" width="80" headerAlign="center" align="center" header="车牌号"></div>
                		<div field="" width="80" headerAlign="center" align="center" header="厂牌"></div>
                		<div field="" width="80" headerAlign="center" align="center" header="品牌车型"></div>
                		<div field="" width="80" headerAlign="center" align="center" header="工单号"></div>
                		<div field="" width="80" headerAlign="center" align="center" header="业务类型"></div>
                		<div field="" width="80" headerAlign="center" align="center" header="进厂里程"></div>
                		<div field="" width="80" headerAlign="center" align="center" header="维修顾问"></div>
                		<div field="" width="80" headerAlign="center" align="center" header="档案号"></div>
                		<div field="" width="80" headerAlign="center" align="center" header="维修日期"></div>
                		<div field="" width="80" headerAlign="center" align="center" header="结算日期"></div>
                	</div>
        		  </div>
        		  <div header="结算信息" headerAlign="center" >
                	<div property="columns">
                		<div field="" width="80" headerAlign="center" align="center" header="结算金额"></div>
                		<div field="" width="80" headerAlign="center" align="center" header="出单金额"></div>
                		<div field="" width="80" headerAlign="center" align="center" header="应收金额"></div>
                	</div>
        		  </div>
              </div>
          </div>
      <div class="nui-fit">
        <div class="mini-tabs" activeIndex="0"  style="width:100%;height:100%;">
		    <div title="报价信息">
		       <div id="t1">
		       	<div id="t2" style="float:left;width: 49%; height: 100%;"> 
		       		<div id="mainGrid" class="nui-datagrid" style="width:100%;height:100%;"
		               selectOnLoad="true"
		               showPager="true"
		               pageSize="80"
		               totalField="page.count"
		               sizeList=[20,80,80,200]
		               dataField="list"
		               onrowdblclick=""
		               showModified="false"
		               allowCellSelect="true"
		               editNextOnEnterKey="true"
		               url=""
		               >
		              <div property="columns">
		              	<div header="报价项目" headerAlign="center" >
                			<div property="columns">
                				<div field="" width="80" headerAlign="center" align="center" header="项目名称"></div>
				        		<div field="" width="80" headerAlign="center" align="center" header="工种"></div>
				        		<div field="" width="80" headerAlign="center" align="center" header="金额"></div>
				        		<div field="" width="80" headerAlign="center" align="center" header="标准金额"></div>
				        		<div field="" width="80" headerAlign="center" align="center" header="备注"></div>
                			</div>
            			</div>
		              </div>
		          </div>
		       	</div>
		       	<div id="t3" style="float:right;width: 49%; height: 100%;">
		       		<div id="mainGrid" class="nui-datagrid" style="width:100%;height:100%;"
		               selectOnLoad="true"
		               showPager="true"
		               pageSize="80"
		               totalField="page.count"
		               sizeList=[20,80,80,200]
		               dataField="list"
		               onrowdblclick=""
		               showModified="false"
		               allowCellSelect="true"
		               editNextOnEnterKey="true"
		               url=""
		               >
		              <div property="columns">
		              	<div header="报价配件" headerAlign="center" >
                			<div property="columns">
                				<div field="" width="80" headerAlign="center" align="center" header="配件名称"></div>
				        		<div field="" width="80" headerAlign="center" align="center" header="数量"></div>
				        		<div field="" width="80" headerAlign="center" align="center" header="单价"></div>
				        		<div field="" width="80" headerAlign="center" align="center" header="金额"></div>
				        		<div field="" width="80" headerAlign="center" align="center" header="备注"></div>
                			</div>
            			</div>
		              </div>
		          </div>
		       	</div>
				<div style="clear: both"></div>
		       </div>
		    </div>
		    <div title="维修信息">
		        <div id="t1">
		       	<div id="t2" style="float:left;width: 49%; height: 100%;"> 
		       		<div id="mainGrid" class="nui-datagrid" style="width:100%;height:100%;"
		               selectOnLoad="true"
		               showPager="true"
		               pageSize="80"
		               totalField="page.count"
		               sizeList=[20,80,80,200]
		               dataField="list"
		               onrowdblclick=""
		               showModified="false"
		               allowCellSelect="true"
		               editNextOnEnterKey="true"
		               url=""
		               >
		              <div property="columns">
		              	<div header="维修项目" headerAlign="center" >
                			<div property="columns">
                				<div field="" width="80" headerAlign="center" align="center" header="项目名称"></div>
				        		<div field="" width="80" headerAlign="center" align="center" header="工种"></div>
				        		<div field="" width="80" headerAlign="center" align="center" header="金额"></div>
				        		<div field="" width="80" headerAlign="center" align="center" header="优惠率"></div>
				        		<div field="" width="80" headerAlign="center" align="center" header="小计"></div>
				        		<div field="" width="80" headerAlign="center" align="center" header="维修班组"></div>
				        		<div field="" width="80" headerAlign="center" align="center" header="承修人"></div>
				        		<div field="" width="80" headerAlign="center" align="center" header="备注"></div>
                			</div>
            			</div>
		              </div>
		          </div>
		       	</div>
		       	<div id="t3" style="float:right;width: 49%; height: 100%;">
		       		<div id="mainGrid" class="nui-datagrid" style="width:100%;height:100%;"
		               selectOnLoad="true"
		               showPager="true"
		               pageSize="80"
		               totalField="page.count"
		               sizeList=[20,80,80,200]
		               dataField="list"
		               onrowdblclick=""
		               showModified="false"
		               allowCellSelect="true"
		               editNextOnEnterKey="true"
		               url=""
		               >
		              <div property="columns">
		              	<div header="维修配件" headerAlign="center" >
                			<div property="columns">
                				<div field="" width="80" headerAlign="center" align="center" header="配件名称"></div>
				        		<div field="" width="80" headerAlign="center" align="center" header="数量"></div>
				        		<div field="" width="80" headerAlign="center" align="center" header="单价"></div>
				        		<div field="" width="80" headerAlign="center" align="center" header="金额"></div>
				        		<div field="" width="80" headerAlign="center" align="center" header="优惠率"></div>
				        		<div field="" width="80" headerAlign="center" align="center" header="小计"></div>
				        		<div field="" width="80" headerAlign="center" align="center" header="备注"></div>
				        		<div field="" width="80" headerAlign="center" align="center" header="备件编码"></div>
                			</div>
            			</div>
		              </div>
		          </div>
		       	</div>
				<div style="clear: both"></div>
		       </div>
		    </div>
		    <div title="套餐信息" >
		       	<div id="mainGrid" class="nui-datagrid" style="width:100%;height:100%;"
               selectOnLoad="true"
               showPager="true"
               pageSize="80"
               totalField="page.count"
               sizeList=[20,80,80,200]
               dataField="list"
               onrowdblclick=""
               showModified="false"
               allowCellSelect="true"
               editNextOnEnterKey="true"
               url=""
               >
              <div property="columns">
              	<div type="indexcolumn" headerAlign="center" align="center"header="序号"></div>
        		<div field="" width="80" headerAlign="center" align="center" header="套餐编码"></div>
        		<div field="" width="80" headerAlign="center" align="center" header="套餐名称"></div>
        		<div field="" width="80" headerAlign="center" align="center" header="类型"></div>
        		<div field="" width="80" headerAlign="center" align="center" header="标准金额"></div>
        		<div field="" width="80" headerAlign="center" align="center" header="套餐金额"></div>
        		<div field="" width="80" headerAlign="center" align="center" header="优惠金额"></div>
        		<div field="" width="80" headerAlign="center" align="center" header="小计金额"></div>
        		<div field="" width="80" headerAlign="center" align="center" header="备注"></div>
              </div>
          </div>
		    </div>
		    <div title="出单信息">
		        4
		    </div>
		    <div title="总检信息">
		       <div id="t1">
		       	<div id="t2" style="float:left;width: 49%; height: 50%;"> 
		       		客户描述：
		       		<input class="nui-textarea" style="height:90%;width:100%"/>
		 
		       	</div>
	       		<div id="t3" style="float:right;width: 49%; height: 50%;">
	       			故障原因：
		       		<input class="nui-textarea" style="height:90%;width:100%"/>
	       		</div>
	       		<div style="clear: both"></div>
	       	   </div>
	       	  
	       	   		<table style="width:100%">
		       			<tr>
		       				<td>总检人：</td>
		       				<td>总检时间：</td>
		       			</tr>
		       			<tr>
		       				<td>出车报告</td>
		       			</tr>

       		</table>
       		
       		 <div class="nui-fit">
       		 <input class="nui-textarea" style="height:100%;width:100%"/>
	       	   </div>
		    </div>
		    <div title="客户资料">
		        <table style="height:90%;width:50%">
		        	<tr>
		        		<td align="right" style="width:100px">车主：</td>
		        		<td colspan="3"><input class="nui-textbox" style="width:100%"/></td>
		        		<td align="right" style="width:100px">手机号码：</td>
		        		<td colspan="3"><input class="nui-textbox"style="width:100%"/></td>
		        	</tr>
		        	<tr>
		        		<td align="right">车牌号：</td>
		        		<td colspan="3"><input class="nui-textbox" style="width:100%"/></td>
		        		<td align="right">车辆厂牌：</td>
		        		<td colspan="3"><input class="nui-Combobox"style="width:100%"/></td>
		        	</tr>
		        	<tr>
		        		<td align="right">底盘号：</td>
		        		<td colspan="3"><input class="nui-textbox" style="width:100%"/></td>
		        		<td align="right">品牌车型：</td>
		        		<td colspan="3"><input class="nui-textbox"style="width:100%"/></td>
		        	</tr>
		        	<tr>
		        		<td align="right">发动机号：</td>
		        		<td colspan="3"><input class="nui-textbox" style="width:100%"/></td>
		        		<td align="right">来本店次数：</td>
		        		<td><input class="nui-textbox"style="width:100%"/></td>
		        		<td align="right" style="width:100px">来连锁次数：</td>
		        		<td><input class="nui-textbox"style="width:100%"/></td>
		        	</tr>
		        	<tr>
		        		<td align="right">联系人：</td>
		        		<td><input class="nui-textbox" style="width:100%"/></td>
		        		<td align="right" style="width:100px">联系人身份：</td>
		        		<td><input class="nui-Combobox" style="width:100%"/></td>
		        		<td align="right">联系人手机：</td>
		        		<td colspan="3"><input class="nui-textbox"style="width:100%"/></td>
		        	</tr>
		        	<tr>
		        		<td align="right">保险公司：</td>
		        		<td colspan="3"><input class="nui-Combobox" style="width:100%"/></td>
		        		<td align="right">保险到期：</td>
		        		<td colspan="3"><input class="nui-Combobox"style="width:100%"/></td>
		        	</tr>
		        	<tr>
		        		<td align="right">营销员：</td>
		        		<td colspan="3"><input class="nui-textbox" style="width:100%"/></td>
		        		<td align="right">业务员：</td>
		        		<td colspan="3"><input class="nui-textbox"style="width:100%"/></td>
		        	</tr>
	        	</table>
		    </div>
		</div>  
  </div>
</div>
	<script type="text/javascript">
	var data = [{ id: 1, text: '发票号查询' }, { id: 2, text: '开票单号查询' }, { id: 3, text: '源单号查询' },
    	  { id: 4, text: '客户姓名查询' }, { id: 5, text: '手机号码查询' }, { id: 2, text: '车牌号查询' }];
    	nui.parse();
    </script>
</body>
</html>