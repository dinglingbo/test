<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@include file="/common/sysCommon.jsp"%>
<%@include file="/common/commonCloudPart.jsp"%>
<html>
<!-- 
  - Author(s): Administrator
  - Date: 2019-06-10 14:48:53
  - Description:
-->
<head>
<title>调拨申请调整</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />

</head>
<body>
	 <div class="nui-fit">
        <div class="nui-toolbar" style="padding:2px;border-bottom:0;">
        	<table class="table" id="table1">
	            <tr> 
	              	<td>
                  	<a class="nui-button" iconCls="" plain="true" onclick="onOk"><span class="fa fa-check fa-lg"></span>&nbsp;保存</a>
                  	<a class="nui-button" iconCls="" plain="true" onclick="onCancel"><span class="fa fa-remove fa-lg"></span>&nbsp;取消</a>
                  	<span class="separator"></span>
                  	显示已完成：<div  class="nui-checkbox" id="isAll" name="isAll" value="0" onclick="loadData" trueValue="1" falseValue="0"></div>

					</td>
	            </tr>
            </table>
        </div>
    
     
  	<div class="nui-fit">
  		 <div id="mainGrid" class="nui-datagrid" style="width:100%;height:100%;"
	        url=""
	        dataField="pjAllotApplyDetailList"
	        idField="id" 
	        showModified="false"
	        allowResize="true" 
	        showSummaryRow="true"
	        pageSize="20"
	        totalField="page.count"
	        sizeList=[20,50,100,200]
	        allowCellEdit="true" allowCellSelect="true" 
	        editNextOnEnterKey="true"  editNextRowCell="true"
	        contextMenu="#gridMenu"
        >
         <div property="columns">
            <div type="indexcolumn">序号</div>
            <div field="id" name="id" width="100" headerAlign="center" header="id" visible="false"></div>
            <div field="mainId" width="100px" headerAlign="center" allowSort="true"  visible="false" header=""></div>
            <div field="partCode" name="partCode" width="100" headerAlign="center"align="center"  header="配件编码"></div>
            <div field="partName" name="partName" width="100" headerAlign="center" header="配件名称"></div>
            <div field="applyQty" name="applyQty" allowSort="true"  width="60" headerAlign="center" align="center" header="申请数量" datatype="float" summaryType="sum"></div>
            <div field="hasAcceptQty" name="hasAcceptQty" width="90px" headerAlign="center" allowSort="true" align="center" header="已受理数量"></div>
            <div field="hasCancelQty" name="hasCancelQty" width="90px" headerAlign="center" allowSort="true" align="center" header="已调整数量"></div>
            <div field="adjQty" name="adjQty" width="90"  headerAlign="center" align="center" header="本次调整数量" datatype="float" summaryType="sum">
                <input property="editor" class="nui-textbox" vtype="float"/> 
            </div> 
            <div field="remark" name="remark" width="150" headerAlign="center" header="备注"></div>
          
        </div> 
    </div>
    
   </div>

	<script type="text/javascript">
    	nui.parse();
    	var baseUrl = apiPath + cloudPartApi + "/";
    	var mainGrid = nui.get("mainGrid"); 
    	var fmainId = 0;
    	var gridUrl = baseUrl + "/com.hsapi.cloud.part.invoicing.allotsettle.queryPjAllotApplyDetailList.biz.ext";
    	
    	$(document).ready(function(v){ 
    		mainGrid.setUrl(gridUrl);
    	   	
			document.onkeyup = function(event) {
		        var e = event || window.event;
		        var keyCode = e.keyCode || e.which;// 38向上 40向下
		
		        if ((keyCode == 27)) { // ESC
		            CloseWindow('cancle');
		        }

	    	}

	    	mainGrid.on("drawcell", function(e) { 
		        switch (e.field) {
		            case "adjQty" :
		            	e.cellStyle = "background:#54FF9F";
		            break;
		            default:
		            break;
		        }

		    });

		    mainGrid.on("cellcommitedit",function(e){
		        var record = e.record;
		        var value = e.value;
		        var column = e.column;
		        var editor = e.editor;
		        if(column.field == "adjQty"){  
		            editor.validate();  
		            if (editor.isValid() == false) {
		                showMsg("请输入有效数字！","W");
		                e.cancel = true;
		            }

		            if(record.applyQty - record.hasAcceptQty - record.hasCancelQty < value){
		                e.cancel = true;
		                showMsg("调整数量超数！","W");
		            } 
		        }
		    });

	    });
			
		function setInitData(mainId){
			fmainId = mainId;
			loadData();
		}

		function loadData() {
			var params = {};
		    params.mainId = fmainId;
			if(nui.get("isAll").getValue()!=1){
				params.isAllotFinished = 0;
			}
			mainGrid.load({params:params,token:token});
		}
	    
	   	function onOk(){
	   		var list =mainGrid.getChanges("modified");
	   		var adjList = [];
	   		for(var i=0; i<list.length; i++) {
	
			   var val = list[i];
			   var temp = {
			   		detailId: val.id,
			   		mainId: val.mainId,
			   		adjQty: val.adjQty
			   };
			   adjList.push(temp);
			}
			nui.mask({
		        el: document.body,
		        cls: 'mini-mask-loading',
		        html: '保存中...'
			});

   			nui.ajax({
				url : baseUrl + "com.hsapi.cloud.part.invoicing.allotsettle.adjustAllotApply.biz.ext",
				type : "post",
				data : JSON.stringify({
					data : adjList,
					mainId: fmainId,
					token: token
				}),
				success : function(data) {
					nui.unmask(document.body);
					data = data || {};
					nui.unmask(document.body);
					if (data.errCode == "S") {
						showMsg("调整数据成功","S");
						mainGrid.reload();
					} else {
						showMsg(data.errMsg || "调整数据失败!","W");
					}
				},
				error : function(jqXHR, textStatus, errorThrown) {
					nui.unmask(document.body);
					// nui.alert(jqXHR.responseText);
					console.log(jqXHR.responseText);
				}
			});
	   	}
    	
    	function CloseWindow(action)
		{
		    if (window.CloseOwnerWindow) return window.CloseOwnerWindow(action);
		    else window.close();
		}
		function onCancel(e) {
		    CloseWindow("cancel");
		}
    </script>
</body>
</html>