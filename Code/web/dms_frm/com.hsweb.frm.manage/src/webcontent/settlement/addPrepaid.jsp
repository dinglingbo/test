<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<%@include file="/common/commonRepair.jsp"%>

<html>
<!-- 
  - Author(s): Administrator
  - Date: 2019-05-05 16:13:04
  - Description:
-->
<head>
<title>新增预收预付</title>
    <script src="<%=webPath + contextPath%>/manage/settlement/js/addPrepaid.js?v=1.0.3"></script>
    <style type="text/css">
.title {
  width: 90px;
  height:35px;
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
 	<fieldset style="border: solid 1px #aaa; position: relative; margin: 5px 2px 20px 2px;height: 200px;">
		<legend> 账款信息</legend>       
		<div id="advancedSearchForm" class="form">
			<input class="nui-hidden" name="id" id="id"/>
			 <input class="nui-hidden" name="guestName" id="guestName"/>
			<table style="width: 100%;">
				<tr>
                      <td class="title required" style="width:8%">
                          <label>往来单位：</label>
                      </td>
                      <td colspan="3" style="width:38%">
                          <input id="guestId"
                                 name="guestId"
                                 class="nui-buttonedit"
                                 emptyText="请选择往来单位..."
                                 onbuttonclick="selectSupplier('guestId')"
                                 onvaluechanged="onGuestValueChanged"
                                 width="100%"
                                 placeholder="请选择往来单位"
                                 selectOnFocus="true" />
                      </td>
				</tr>
				<tr>
					<td class="title required">
						<label id="closed">预收项目:</label>
						<label id="pay">预付项目:</label>
					</td>
					<td>
						<input  property="editor" enabled="true" id="payBillTypeList" name="list" data="plist" dataField="plist" class="nui-combobox" 
								valueField="id" onvaluechanged="onbillPTypeChange" textField="name" url="" emptyText=""  vtype="required"/> 
							<input  property="editor" enabled="true" id="closedBillTypeList" name="list" data="rlist" dataField="rlist" class="nui-combobox" 
								        valueField="id" onvaluechanged="onbillRTypeChange" textField="name" url="" emptyText=""  vtype="required"/> 
					</td>
	              <td class="title" style="width:8%">
                      <label>账款金额：</label>
                  </td>
                  <td colspan="1" >
                  		<input class="nui-Spinner"  decimalPlaces="2" minValue="0" maxValue="1000000000"  allowNull="false" showButton="false" width="100%" id="amt" name="amt" />
                  </td>
				</tr>					
				<tr>
				
					<td class="title">
						<label>备注:</label>
					</td>
					<td colspan="3">
						<input name="remark" id="remark" class="nui-TextArea" width="100%" />
					</td>
				</tr>																			
			</table>
		</div>
</fieldset>					
	<script type="text/javascript">
    	nui.parse();
    </script>
</body>
</html>