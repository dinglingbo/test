<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<%@include file="/common/commonPart.jsp"%>

<html>
<!-- 
  - Author(s): Administrator
  - Date: 2019-05-05 16:13:04
  - Description:
-->
<head>
<title>PDI检测</title>
    <script src="<%=webPath + contextPath%>/sales/inventory/js/PDIdetection.js?v=1.0.7"></script>
    <style type="text/css">
.title {
  width: 90px;
  text-align: right;
}

.title.required {
  color: red;
}
.title.tip {
  color: blue;
}

.title.wide {
  width: 100px;
}

.mini-panel-border {
  border: 0;
}

.mini-panel-body {
  padding: 0;
}
body .mini-grid-row-selected{
    background:#89c3d6 !important; 
}
.mini-tabs-scrollCt{
	display:none;
}
.mini-tabs-body-top{
	padding:0px;
}

</style>
</head>
<body>
	     <div class="nui-toolbar" style="padding:0px;border-bottom:0;">
            <table style="width:100%;">
                <tr>
                    <td style="width:100%;">
                        <a class="nui-button" onclick="onOk()" plain="true" style="width: 60px;" id="onOk"><span class="fa fa-save fa-lg"></span>&nbsp;保存</a>
                        <a class="nui-button" onclick="onCancel()" plain="true"  style="width: 60px;"><span class="fa fa-remove fa-lg"></span>&nbsp;取消</a>
                    </td>
                </tr>
            </table>
        </div>
 	<fieldset style="border: solid 1px #aaa; position: relative; margin: 5px 2px 0px 2px;">
		<legend> 基本信息</legend>       
		<div id="advancedSearchForm" class="form">
			<table style="width: 100%;">
				<tr>
					<td class="title required" >
						<label>车型名称:</label>
					</td>
					<td colspan="3">
						<input name="carModelName" id="carModelName" disabled="disabled" class="nui-textbox" width="100%" />
					</td>
				</tr>
				<tr>
					<td class="title required">
						<label>车架号（VIN）:</label>
					</td>
					<td>
						<input name="carFrameNo" id="carFrameNo" width="100%" disabled="disabled" class="nui-textbox" />
					</td>
					<td class="title required">
						<label>发动机型号:</label>
					</td>
					<td>
						<input name="engineNo" id="engineNo" disabled="disabled" width="100%" class="nui-textbox" />
					</td>	
				</tr>
				<tr>
					<td class="title required">
						<label>检测人:</label>
					</td>
					<td>
					   <input class="nui-combobox" id="pdiDetectioner" name="pdiDetectioner" textField="empName" valueField="empId" emptyText="请选择..." url="" required="true" allowInput="true" valueFromSelect="false" width="100%">
					</td>										
					<td class="title required">
						<label>检测日期:</label>
					</td>
					<td>
						<input name="pdiDetectionDate" id="pdiDetectionDate" class="nui-datepicker" format="yyyy-MM-dd HH:mm" showTime="false" showOkButton="false" width="100%" showClearButton="false" />
					</td>
					
				</tr>				
				<tr>
					<td class="title required">
						<label>点火钥匙号:</label>
					</td>
					<td>
						<input name="ignitionKeyCode" id="ignitionKeyCode" width="100%" class="nui-textbox" />
					</td>
					<td class="title required">
						<label>钥匙数量:</label>
					</td>
					<td>
						<input name="" class="nui-textbox" width="100%" />
					</td>
				</tr>
				<tr>
					<td class="title required">
						<label>发送器数量:</label>
					</td>
					<td>
						<input name="ignitionKeyNumber" id="ignitionKeyNumber" width="100%" class="nui-textbox" />
					</td>				
					<td class="title required">
						<label>检测模板:</label>
					</td>
					<td colspan="3">
						   <input class="nui-combobox tabwidth"  id="pdiTemplateId" name="pdiTemplateId" 
                    			dataField="list" valueField="id" textField="name" onvaluechanged="ValueChanged" style="width:100%"/>
					</td>				
				</tr>				

				<tr>
				
					<td class="title">
						<label>备注:</label>
					</td>
					<td colspan="3">
						<input name="remark" id="remark" width="100%" class="nui-textbox" />
					</td>
				</tr>																			
			</table>
		</div>
</fieldset>
	
    <div class="nui-fit">
          <div id="morePartGrid" class="nui-datagrid" style="width:100%;height:95%;"
               selectOnLoad="true"
               showPager="false"
               dataField=""
               frozenStartColumn="0"
               onrowdblclick="addSelectPart"
               allowCellSelect="true"
               editNextOnEnterKey="true"
               allowCellWrap = true
               url="">
              <div property="columns">
                <div type="indexcolumn">序号</div>
                <div type="checkcolumn" width="20"></div>
                <div field="code" name="code" width="100" headerAlign="center" header="编码"></div>
                <div field="name" name="name" width="100" headerAlign="center" header="PDI项目"></div>
                <div field="remark" name="remark" width="100" headerAlign="center" header="PDI项目备注"></div>
              </div>
          </div>
    </div>					
	<script type="text/javascript">
    	nui.parse();
    </script>
</body>
</html>