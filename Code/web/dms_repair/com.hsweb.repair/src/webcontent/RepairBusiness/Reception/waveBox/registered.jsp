<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ include file="/common/sysCommon.jsp"%>
<html>
<!-- 
  - Author(s): Adnuistrator
  - Date: 2019-02-18 11:10:42
  - Description:
-->
<head>
<title>附件登记</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
</head>
<style type="text/css">
 body {
                margin: 0;
                padding: 0;
                border: 0;
                width: 100%;
                height: 100%;
                overflow: hidden;
 }
 </style>
<body>
<div class="nui-fit">
	<table   style="width: 100%;border-spacing: 0px 5px;"> 
		<tr>
			<td>
				 <td class="title"  align="right">
                      <label>业务单号：</label>
                 </td>
                <td class="" colspan="1"><input  class="nui-textbox" name="carModel" id="carModel" enabled="false" width="100%"/></td>
                
                 <td class="title"  align="right">
                      <label>客户名称：</label>
                 </td>
                <td class="" colspan="1"><input  class="nui-textbox" name="carModel" id="carModel" enabled="false" width="100%"/></td>
                
                <td class="title" align="right">
                      <label>车牌号：</label>
                 </td>
                <td class="" colspan="1"><input  class="nui-textbox" name="carModel" id="carModel" enabled="false" width="100%"/></td>
		</tr>
	</table>
	<div class="nui-fit">
		<div class="nui-splitter" style="width:100%;height:96%;"style="top:10px;">
		    <div size="20%" showCollapseButton="true" style="padding:10px;">
		        <div id="repairPartAuditFlag" name="repairPartAuditFlag" class="nui-checkboxlist" repeatItems="1" 
                    repeatLayout="flow"  value="" 
                    textField="name" valueField="id" onvaluechanged="onValueChanged"></div>
			     </div>
			     <div showCollapseButton="true">
			        <div id="grid" class="nui-datagrid" style="width:100%;height:100%;" showsummaryrow="true" ondrawsummarycell="onDrawSummaryCell"
					      selectOnLoad="true"
					      showPager="false"
					      dataField="data"
					      idField="id"
					      allowCellSelect="true"
					      editNextOnEnterKey="true"
					      url="">
					      <div property="columns">
					          <div field="id" name="prdtName" width="100" headerAlign="center" header="附件编号 测试" summarytype="sum"></div>
					          <div field="name" name="prdtType" width="60" headerAlign="center" header="附件名称 测试"></div>
					          <div field="modifier" name="totalTimes" width="50" headerAlign="center" header="数量 测试" ></div>
					      </div>
					  </div>
			    </div>        
		    </div>
		</div>
			<div align="center" style="hight:auto">
				<a  class="nui-button" onclick="">保存</a>
				<a  class="nui-button" onclick="">取消</a>
			</div>
	</div>
	<script type="text/javascript">
    	nui.parse();
    	var repairPartAuditFlag = null;
    	var grid = null;
    	var serviceTypeList = [];
    	var baseUrl = apiPath + repairApi + "/";
    	var serviceTypeUrl = baseUrl + "com.hsapi.repair.common.common.getBusinessType.biz.ext";
    	$(document).ready(function(v) {
    		repairPartAuditFlag = nui.get("repairPartAuditFlag");
    		grid = nui.get("grid");
    		 getServiceTypeList();
    	});
    	
		function getServiceTypeList(){
		    var params = {sortField:'id',sortOrder:'asc',isDisabled:0};
		    nui.ajax({
				url : serviceTypeUrl,
		        type : "post",
		        async:false,
				data : JSON.stringify({
					params : params,
					token: token
				}),
				success : function(data) {
					nui.unmask(document.body);
		            data = data || {};
		            serviceTypeList = data.list;
					if (serviceTypeList && serviceTypeList.length>0) {
						repairPartAuditFlag.setData(serviceTypeList);
					} else {
						parent.showMsg("加载信息错误,请联系管理员!","W");
					}
				},
				error : function(jqXHR, textStatus, errorThrown) {
					// nui.alert(jqXHR.responseText);
					console.log(jqXHR.responseText);
				}
			});
		}
		
		function onValueChanged(e){
			var check = e.sender.O010Item || "";
			if(check){
				var data = grid.getData();
				var num = 0;
				var index = 0;
				var row_index = null;
				var row = grid.findRow(function(row){
					if(row.id == check.id){
						num ++;
						index = grid.indexOf(row);
						row_index = row;
					}
				});
				if(num > 0){
					grid.removeRow(row_index,false);
				}else{
					grid.addRow(check,grid.getData().length);
				}
			}
		}
		
		function onDrawSummaryCell(e){
			if (e.field == "id") {
				e.cellHtml = '<div align="center" >' + e.cellHtml + '</div>';
			}
		}
    </script>
</body>
</html>