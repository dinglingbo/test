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
    <script src="<%=webPath + contextPath%>/sales/inventory/js/PDIdetection.js?v=1.0.5"></script>
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
					<td class="title">
						<label>检测日期:</label>
					</td>
					<td>
						<input name="recordDate" id="recordDate" class="nui-datepicker" format="yyyy-MM-dd" timeFormat="H:mm:ss" showTime="false" showOkButton="false" width="100%" showClearButton="false" />
					</td>
					<td class="title">
						<label>检测人:</label>
					</td>
					<td>
						<input name="recorder" id="recorder" width="100%" class="nui-textbox" />
					</td>										
				</tr>
				<tr>
					<td class="">
						<label>车型名称:</label>
					</td>
					<td colspan="3">
						<input name="carModelName" id="carModelName" class="nui-textbox" width="100%" />
					</td>
				</tr>
				<tr>
				
					<td class="title">
						<label>检测模板:</label>
					</td>
					<td colspan="3">
						<input name="" width="100%" class="nui-textbox" />
					</td>
					<td class="title">
						<label>发动机型号:</label>
					</td>
					<td>
						<input name="" width="100%" class="nui-textbox" />
					</td>					
				</tr>				
				<tr>
					<td class="title">
						<label>点火钥匙号:</label>
					</td>
					<td>
						<input name="" width="100%" class="nui-textbox" />
					</td>
					<td class="">
						<label>钥匙数量:</label>
					</td>
					<td>
						<input name="" class="nui-textbox" width="100%" />
					</td>
					<td class="title">
						<label>发送器数量:</label>
					</td>
					<td>
						<input name="" width="100%" class="nui-textbox" />
					</td>					
				</tr>
				<tr>
				
					<td class="title">
						<label>备注:</label>
					</td>
					<td colspan="3">
						<input name="" width="100%" class="nui-textbox" />
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
                <div field="code" name="code" width="100" headerAlign="center" header="PDI项目"></div>
                <div field="oemCode" name="oemCode" width="100" headerAlign="center" header="项目类型"></div>
                <div field="applyCarModel" name="applyCarModel" width="100" headerAlign="center" header="已检测"></div>
                <div allowSort="true"  name="outableQty" field="outableQty"  width="60" headerAlign="center" header="描述"></div>
              </div>
          </div>
    </div>					
	<script type="text/javascript">
    	nui.parse();
    </script>
</body>
</html>