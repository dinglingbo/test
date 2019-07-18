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
<title>调整订单数量</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />

</head>
<body>
	 <div class="nui-fit">
        <div class="nui-toolbar" style="padding:2px;border-bottom:0;">
        	<table class="table" id="table1">
	            <tr> 
	              	<td>
					<input class="nui-textbox" width="170px" id="serviceId" name="serviceId" selectOnFocus="true" enabled="true" emptyText="订单号"/>
					<a class="nui-button" iconCls="" plain="true" onclick="onSerach()">
                  	<span class="fa fa-search fa-lg"></span>&nbsp;查询</a>
                  	<a class="nui-button" iconCls="" plain="true" onclick="onOk"><span class="fa fa-check fa-lg"></span>&nbsp;保存</a>
					</td>
	            </tr>
            </table>
        </div>
    
     
  	<div class="nui-fit">
  		 <div id="mainGrid" class="nui-datagrid" style="width:100%;height:100%;"
	        url=""
	        dataField="list"
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
            <div field="serviceId" name="serviceId" width="160px" headerAlign="center" allowSort="true"  header="单号"></div>
            <div field="storeId" name="storeId" allowSort="true"  width="80px" header="仓库"  headerAlign="center" allowSort="true"></div>
             
            <div field="partCode" name="partCode" width="100" headerAlign="center"align="center"  header="配件编码"></div>
            <div field="partName" name="partName" width="100" headerAlign="center" header="配件名称"></div>
            <div field="orderQty" name="orderQty" allowSort="true"  width="60" headerAlign="center" align="center" header="订单数量" datatype="float" summaryType="sum"></div>
            <div field="trueEnterQty" name="trueEnterQty" width="90px" headerAlign="center" allowSort="true" align="center" header="实际入库数量"></div>
            <div field="adjustQty" name="adjustQty" width="60"  headerAlign="center" align="center" header="调整数量" datatype="float" summaryType="sum">
                <input property="editor" class="nui-textbox" vtype="float"/> 
            </div> 
            <div field="createDate"  dateFormat="yyyy-MM-dd HH:mm" name ="createDate" width="120px" headerAlign="center" align="center" allowSort="true" header="创建日期"></div>
          
        </div> 
    </div>
    
   </div>

	<script type="text/javascript">
    	nui.parse();
    	var storehouse = null;
    	var storeHash = {};
    	var baseUrl = apiPath + cloudPartApi + "/";
    	var mainGrid = nui.get("mainGrid"); 
    	var gridUrl = baseUrl + "/com.hsapi.cloud.part.invoicing.query.queryNotFinishOrder.biz.ext";
    	mainGrid.setUrl(gridUrl);
    	$(document).ready(function(v){
    	   	 
    	   	onSerach();
    	   	
    	   	getStorehouse(function(data) {
		        storehouse = data.storehouse || [];
		        if (storehouse && storehouse.length > 0) {
//		            nui.get("storeId").setData(storehouse);
		            storehouse.forEach(function(v) {
		                storeHash[v.id] = v;
		            });
		        }
		    }); 
			document.onkeyup = function(event) {
	        var e = event || window.event;
	        var keyCode = e.keyCode || e.which;// 38向上 40向下
	        
	
	        if ((keyCode == 27)) { // ESC
	            CloseWindow('cancle');
	        }

    	}
		});
		
		mainGrid.on("drawcell", function(e) { 
        switch (e.field) {            
            case "storeId":
            if (storeHash[e.value]) { 
                e.cellHtml = storeHash[e.value].name || "";
            } else {
                e.cellHtml = "";
            }
            break;
            default:
            break;
        }

    });
		
		function onSerach(){
		  var params = {};
		  params.orgid =currOrgId;
		  params.serviceId =nui.get("serviceId").getValue().replace(/\s+/g, "");
		  params.orderTypeId=1;
		  mainGrid.load({params:params,token:token});
		}
		function CloseWindow(action) {
	        if (window.CloseOwnerWindow) return window.CloseOwnerWindow(action);
	        else window.close();
	    }
	    
	   	function onOk(){
	   		var list =mainGrid.getChanges("modified");
   			nui.ajax({
				url : baseUrl + "com.hsapi.cloud.part.invoicing.ordersettle.adjustQtyList.biz.ext",
				type : "post",
				data : JSON.stringify({
					data : list,
					token: token
				}),
				success : function(data) {
					nui.unmask(document.body);
					data = data || {};
					var rtnList = data.rtnList;
					if (data.errCode == "S") {
						var msg = data.errMsg;
						if(msg){
							showMsg(msg,"S");
							mainGrid.reload();
						}
						
					} else {
						showMsg(data.errMsg || "添加数据失败!","W");
					}
				},
				error : function(jqXHR, textStatus, errorThrown) {
					// nui.alert(jqXHR.responseText);
					console.log(jqXHR.responseText);
				}
			});
	   	}
    	
    </script>
</body>
</html>