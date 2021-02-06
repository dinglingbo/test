<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8" session="false"%>
<%@include file="/common/common.jsp"%>
<%@include file="/common/commonRepair.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<!-- 
  - Author(s): Administrator
  - Date: 2018-01-27 09:33:59
  - Description:
-->
<head>
    <title>费用明细表</title>
    <script src="<%=request.getContextPath()%>/common/js/partUtil.js?v=1.1.3" type="text/javascript"></script>
    <script src="<%=request.getContextPath()%>/repair/js/RepairBusiness/Reception/expenseDetail.js?v=1.0.4"></script>
    <link href="<%=webPath + contextPath%>/frm/js/finance/HeaderFilter.css" rel="stylesheet" type="text/css" />
    <script src="<%=webPath + contextPath%>/frm/js/finance/HeaderFilter.js" type="text/javascript"></script>
    <style type="text/css">

    table {
        font-size: 12px;
    }

    .form_label {
        width: 84px;
    }
    
    a.optbtn {
            width: 60px;
            /* height: 26px; */
            border: 1px #d2d2d2 solid;
            background: #f2f6f9;
            text-align: center;
            display: inline-block;
            /* line-height: 26px; */
            margin: 0 4px;
            color: #000000;
            text-decoration: none;
            border-radius: 5px;
        }
</style>

</head>
<body>
    <div class="nui-toolbar" id="toolbar1" style="padding:2px;border-bottom:0;">

        <table class="table" id="table1"> 
            <tr>
                <td>
                    <label style="font-family:Verdana;">快速查询：</label>
                </td>
                <td>
                    <a class="nui-menubutton" plain="false" iconCls="" id="menunamedate" menu="#popupMenu" >本日</a>
                    <ul id="popupMenu" class="nui-menu" style="display:none;">
                        <li iconCls="" onclick="quickSearch(0)">本日</li>
                        <li iconCls="" onclick="quickSearch(1)">昨日</li>
                        <li iconCls="" onclick="quickSearch(2)">本周</li>
                        <li iconCls="" onclick="quickSearch(3)">上周</li>
                        <li iconCls="" onclick="quickSearch(4)">本月</li>
                        <li iconCls="" onclick="quickSearch(5)">上月</li>
                        <li iconCls="" onclick="quickSearch(6)">本年</li>
                        <li iconCls="" onclick="quickSearch(7)">上年</li>
                    </ul>
                </td>
                <td>
                    <input class="nui-combobox" id="search-type" width="100" textField="name" valueField="id" value="0" data="statusList" allowInput="false"/>
                    <input class="nui-textbox" id="carNo-search" emptyText="输入查询条件" width="120" onenter="onSearch" />
                    <input  property="editor" enabled="true" id="typeList" name="list" data="[{dc:1,text:'应收'},{dc:-1,text:'应付'}]" dataField="" class="nui-combobox" 
								valueField="dc"  textField="text" url="" emptyText="费用分类" allowInput="true" vtype="required" onenter="onSearch" onvaluechanged="onSearch" width="80"/> 
                  
                    <input  property="editor" enabled="true" id="billTypeList" name="list" data="plist" dataField="plist" class="nui-combobox" 
								valueField="id"  textField="name" url="" emptyText="费用名称" allowInput="true" onenter="onSearch" onvaluechanged="onSearch" width="120"/>
                         <input name="mtAdvisorId"
                                   id="mtAdvisorId"
                                   class="nui-combobox width1"
                                   textField="empName"
                                   valueField="empId"
                                   emptyText="服务顾问"
                                   url=""
                                   allowInput="true"
                                   showNullItem="false"
                                   valueFromSelect="true"
                                   nullItemText="请选择..." onenter="onSearch" onvaluechanged="onSearch" width="120"/>
                                   
                     <input class="nui-textbox" id="remark" emptyText="备注" width="120" onenter="onSearch" />              
                    <label class="form_label">结算日期&nbsp;从：</label>
	                <input format="yyyy-MM-dd"  style="width:100px"  class="mini-datepicker"  allowInput="false" name="startDate" id = "sRecordDate" value=""/>
	                <label class="form_label">至：</label>
	                <input format="yyyy-MM-dd"  style="width:100px"  class="mini-datepicker"   allowInput="false" name="endDate" id = "eRecordDate" value=""/>
                    <a class="nui-button" iconCls="" onclick="onSearch()" plain="true"><span class="fa fa-search fa-lg"></span>&nbsp;查询</a>
                    <a class="nui-button" iconCls="" plain="true" onclick="onExport()" id="exportBtn"><span class="fa fa-level-up fa-lg"></span>&nbsp;导出</a>
                </td>
            </tr>
        </table> 
    </div> 
   <div  class="nui-fit">
        <div id="mainGrid" dataField="list" class="nui-datagrid" 
         selectOnLoad="true"
         showPager="true"
         pageSize="500"
         totalField="page.count"
         sizeList=[500,1000,2000]
         dataField="list" 
         showModified="false"
         onrowdblclick=""
         allowCellSelect="true"
         editNextOnEnterKey="true"
         allowCellWrap = true
         style="height:100%;width:100%;"
         sortMode="client"
             showSummaryRow = "true"
            >
            <div property="columns">
                <div type="indexcolumn" headeralign="center" allowsort="true" visible="true" width="30">序号</div>
                  <div header="工单信息" headerAlign="center">
                    <div property="columns" >	
	                <div field="id" headeralign="center" allowsort="true" visible="false" >主键</div>
	                <div field="serviceCode" name="serviceCode" width="140" headerAlign="center" header="工单号" summaryType="count"></div>
	                <div field="contactName" name="contactName" headeralign="center" allowsort="true" visible="true" >客户名称</div>
	                <div field="carNo" name="carNo" headeralign="center" allowsort="true" visible="true" >车牌号</div>
	                <div field="outDate" headeralign="center" allowsort="true" visible="true" dateFormat="yyyy-MM-dd HH:mm">结算日期</div>
	                <div field="mtAdvisor" name="mtAdvisor" headeralign="center" allowsort="true" visible="true">服务顾问</div>
                  </div>
                </div>
                <div header="费用信息" headerAlign="center">
                  <div property="columns" >	
                    <div field="dc" headerAlign="center" allowSort="false"  header="费用分类"></div>
                    <div field="typeId" headerAlign="center" allowSort="false"  header="费用名称"></div>
                     <div field="guestName" headerAlign="center" allowSort="false"  header="往来单位" width="170"></div>
                    <div field="amt" name="amt" headerAlign="center"   header="金额"  summaryType="sum" allowsort="true" dataType="float"></div>
                    <div field="remark" headerAlign="center" allowSort="false"  header="备注" align="center"></div>
                  </div>
               </div>
            </div>
        </div>
   </div>
   
  <div id="exportDiv" style="display:none">  
    <table id="tableExcel" width="100%" border="0" cellspacing="0" cellpadding="0">  
        <tr>  
        	<td colspan="1" align="center">工单号</td>
            <td colspan="1" align="center">客户名称</td>
            <td colspan="1" align="center">车牌号</td>
            <td colspan="1" align="center">结算日期</td>
            <td colspan="1" align="center">服务顾问</td> 
            <td colspan="1" align="center">费用分类</td>
            <td colspan="1" align="center">费用名称</td>
            <td colspan="1" align="center">往来单位</td>          
            <td colspan="1" align="center">金额</td>
             <td colspan="1" align="center">备注</td>
        </tr>
        <tbody id="tableExportContent">
        </tbody>
    </table>  
    <a href="" id="tableExportA"></a>
</div> 
       
</body>
</html>