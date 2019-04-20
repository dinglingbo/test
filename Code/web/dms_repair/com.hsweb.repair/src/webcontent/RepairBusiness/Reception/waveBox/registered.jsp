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
	<input  class="nui-hidden" name="serviceId" id="serviceId" enabled="false" width="100%"/>
	<table   style="width: 100%;border-spacing: 0px 5px;"> 
		<tr>
			<td>
				 <td class="title"  align="right">
                      <label>业务单号：</label>
                 </td>
                <td class="" colspan="1"><input  class="nui-textbox" name="serviceCode" id="serviceCode" enabled="false" width="100%"/></td>
                
                 <td class="title"  align="right">
                      <label>客户名称：</label>
                 </td>
                <td class="" colspan="1"><input  class="nui-textbox" name="guestFullName" id="guestFullName" enabled="false" width="100%"/></td>
                
                <td class="title" align="right">
                      <label>车牌号：</label>
                 </td>
                <td class="" colspan="1"><input  class="nui-textbox" name="carNo" id="carNo" enabled="false" width="100%"/></td>
		</tr>
	</table>
	<div class="nui-fit">
		<div class="nui-splitter" style="width:100%;height:96%;"style="top:10px;">
		    <div size="20%" showCollapseButton="true" style="padding:10px;">
		        <div id="repairPartAuditFlag" name="repairPartAuditFlag" id="repairPartAuditFlag" class="nui-checkboxlist" repeatItems="1" 
                    repeatLayout="flow"  value="" 
                    textField="name" valueField="customid" onvaluechanged="onValueChanged"></div>
			     </div>
			     <div showCollapseButton="true">
			        <div id="grid" class="nui-datagrid" style="width:100%;height:100%;" showsummaryrow="true" ondrawsummarycell="onDrawSummaryCell"
					      selectOnLoad="true"
					      showPager="false"
					      dataField="msg" oncellcommitedit="onCellCommitEdit" 
					      allowCellEdit="true" allowCellSelect="true" multiSelect="true"   
					      url="">
					      <div property="columns">
					          <div field="attachCode" name="attachCode" width="100" headerAlign="center" header="附件编号" ></div>
					          <div field="attachName" name="attachName" width="60" headerAlign="center" header="附件名称"></div>
					          <div field="qty" name="qty" width="50" headerAlign="center" header="数量" summarytype="sum">
					          	<input class="nui-textbox"  property="editor"  vtype="int"/>
					          </div>
					      </div>
					  </div>
			    </div>        
		    </div>
		</div>
			<div align="center" style="hight:auto">
				<a  class="nui-button" onclick="onOK()">保存</a>
				<a  class="nui-button" onclick="close()">取消</a>
			</div>
	</div>
	<script type="text/javascript">
    	nui.parse();
    	var repairPartAuditFlag = null;
    	var grid = null;
    	var serviceTypeList = [];
    	var baseUrl = apiPath + repairApi + "/";
    	var serviceTypeUrl = baseUrl + "com.hsapi.repair.common.common.getBusinessType.biz.ext";
    	var gridUrl =baseUrl + "com.hsapi.repair.repairService.waveBox.searchRegistered.biz.ext";
    	$(document).ready(function(v) {
    		repairPartAuditFlag = nui.get("repairPartAuditFlag");
    		grid = nui.get("grid");
    		init();
    		
    		grid.on("load",function(e){
				 var dataAll = grid.getData();
				 if(dataAll){
					var str = "";
					for(var i = 0 , l = dataAll.length ; i < l ; i++){
						if(i != dataAll.length -1){
							str += dataAll[i].attachCode+",";
						}else{
							str += dataAll[i].attachCode;
						}
					}
					repairPartAuditFlag.setValue(str);
				} 
			});
    	});
    	
    	function init(){
            var dictDefs ={"repairPartAuditFlag":"10241"};
			initDicts(dictDefs, function(){
				
			});
    	}
    	
		function onValueChanged(e){
			var check = e.sender.O010Item || "";
			check.id = "";
			check.attachCode =check.customid;
			check.attachName = check.name;
			if(check){
				var data = grid.getData();
				var num = 0;
				var index = 0;
				var row_index = null;
				var row = grid.findRow(function(row){
					if(row.attachCode == check.customid){
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
			if (e.field == "qty") {
				e.cellHtml = '<div align="center" >' + e.cellHtml + '</div>';
			}
		}
		
		function onOK(){
			var add = grid.getChanges("added");
			for(var i = 0 , l = add.length ; i < l ; i++){
				add[i].serviceId = nui.get("serviceId").value;
			}
			var modified = grid.getChanges("modified");
			for(var i = 0 , l = modified.length ; i < l ; i++){
				add[add.length] = modified[i];
			}
			var removed = grid.getChanges("removed"); 
             nui.ajax({
                    url: baseUrl+"com.hsapi.repair.repairService.crud.saveRegistered.biz.ext",
                    type: "post",
                    cache: false,
                    async: false,
                    data: {
                      register :add ,
                      removed : removed 
                    },
                    success: function(text) {
                    		if(text.errCode == "S"){
                    			var params = {serviceId : nui.get("serviceId").value};
								grid.load({params : params});
                    			showMsg("保存成功","S");
                    		}else{
                    			showMsg(text.errMsg,"W");
                    		} 
                    }
            });
		}
		
		function SetData(data){
			var ndata = nui.clone(data); 
			nui.get("serviceCode").setValue(ndata.serviceCode);
			nui.get("guestFullName").setValue(ndata.guestFullName);
			nui.get("carNo").setValue(ndata.carNo);
			nui.get("serviceId").setValue(ndata.serviceId);
			grid.setUrl(gridUrl);
			var params = {serviceId : ndata.serviceId};
			grid.load({params : params});
		}
		
		function onCellCommitEdit(e){
			var editor = e.editor;
			if(e.field == "qty"){
				if (editor.isValid() == false) {
					nui.alert("请输入整数！","温馨提示");
					e.cancel = true;
					nui.layout();
				}
			}
		}
		
		function close(){
			window.CloseOwnerWindow('');
		}
    </script>
</body>
</html>