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
<title>维修顾问排行</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
</head>
<body>
<div id="toolbar1" class="nui-toolbar" style="padding:2px;">
    <table style="width:80%;">
        <tr>
        <td style="width:80%;">
        	快速统计：
            <a class="nui-button" plain="true"><font color="blue"><u>本周</u></font></a>
            <a class="nui-button" plain="true"><font color="blue"><u>上周</u></font></a>
            <a class="nui-button" plain="true"><font color="blue"><u>本月</u></font></a>
            <a class="nui-button" plain="true"><font color="blue"><u>上月</u></font></a>
            <a class="nui-button" plain="true"><font color="blue"><u>本年</u></font></a>
            <a class="nui-button" plain="true"><font color="blue"><u>上年</u></font></a>
            <input class="nui-combobox" property="editor" data="fmonth" id="fmonth" name="fmonth" width="50px" value="9"/>月
            <span class="separator"></span>
                      结算日期  从：
          	<input class="nui-datepicker"/>&nbsp;至：<input class="nui-datepicker"/>
          	服务顾问：<input name="mtAdvisorId"
                    id="mtAdvisorId"
                    class="nui-combobox width1"
                    textField="empName"
                    valueField="empId"
                    emptyText="请选择..."
                    url=""
                    allowInput="true"
                    showNullItem="false"
                    valueFromSelect="true"
                    nullItemText="请选择..."/>
          	<span class="separator"></span>
          	<a class="nui-button" iconCls="" plain="true" onclick="onSearch"><span class="fa fa-search fa-lg"></span>&nbsp;查询</a>
        </td>
        </tr>
    </table>
</div>
<div class="nui-fit">
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
              	<div type="indexcolumn" headerAlign="center" align="center">序号</div>
                  <div header="基本信息" headerAlign="center" >
                	<div property="columns">
                		<div field="" width="80" headerAlign="center" align="center" header="区域"></div>
                		<div field="" width="80" headerAlign="center" align="center" header="分店类型"></div>
                		<div field="" width="80" headerAlign="center" align="center" header="店名"></div>
                		<div field="" width="80" headerAlign="center" align="center" header="职务"></div>
                		<div field="" width="80" headerAlign="center" align="center" header="姓名"></div>
                	</div>
        		  </div>
        		  <div header="业绩指标" headerAlign="center" >
                	<div property="columns">
                		<div field="" width="80" headerAlign="center" align="center" header="期末车辆数"></div>
                		<div field="" width="80" headerAlign="center" align="center" header="结算车次"></div>
                		<div field="" width="80" headerAlign="center" align="center" header="单产"></div>
                		<div field="" width="80" headerAlign="center" align="center" header="运营毛利"></div>
                		<div field="" width="80" headerAlign="center" align="center" header="维修净收入"></div>
                		<div field="" width="80" headerAlign="center" align="center" header="实营金额"></div>
                		<div field="" width="80" headerAlign="center" align="center" header="运营毛利率"></div>
                		<div field="" width="80" headerAlign="center" align="center" header="配件成本率"></div>
                		<div field="" width="80" headerAlign="center" align="center" header="买X送Y销售数"></div>
                		<div field="" width="80" headerAlign="center" align="center" header="换季保套包数"></div>
                		<div field="" width="80" headerAlign="center" align="center" header="点评数"></div>
                		<div field="" width="80" headerAlign="center" align="center" header="好评数"></div>
                		<div field="" width="80" headerAlign="center" align="center" header="点评率"></div>
                	</div>
        		  </div>
              </div>
          </div>
  </div>
	<script type="text/javascript">
	var fmonth = [{ id: 1, text: 1 }, { id: 2, text: 2 }, { id: 3, text: 3 }, { id: 4, text: 4 }, { id: 5, text: 5 }, { id: 6, text: 6 }
	, { id: 7, text: 7 }, { id: 8, text: 8 }, { id: 9, text: 9 }, { id: 10, text: 10 }, { id: 11, text: 11 }, { id: 12, text: 12 }];
    	nui.parse();
    </script>
</body>
</html>