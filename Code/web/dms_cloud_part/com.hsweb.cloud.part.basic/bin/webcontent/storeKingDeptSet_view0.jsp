<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false"%>
    <%@include file="/common/sysCommon.jsp"%>
<%@include file="/common/commonCloudPart.jsp"%>
            <!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
            <html>
            <!-- 
  - Author(s): Administrator
  - Date: 2018-01-31 16:54:43
  - Description:
-->
<head>
    <title>仓库部门设置</title> 
    <style type="text/css">
        table {
            font-size: 12px;
        }

        .form_label {
            width: 100px;
            text-align: right;
        }

        .required {
            color: red;
        }
    </style>
</head>
<body>
<div class="nui-fit">
     <div class="nui-toolbar" style="padding:0px;border-bottom:0;">
        <table style="width:100%;">
            <tr>
                <td style="width:100%;">
                    <a class="nui-button" plain="true" iconCls="" onclick="add()"><span class="fa fa-plus fa-lg"></span>&nbsp;新增</a>
		            <a class="nui-button" plain="true" iconCls="" onclick="del()"><span class="fa fa-remove fa-lg"></span>&nbsp;删除</a>
                    <a class="nui-button" onclick="save()" plain="true" style="width: 60px;" id="save"><span class="fa fa-save fa-lg"></span>&nbsp;保存</a>
                    <a class="nui-button" onclick="CloseWindow('cancle')" plain="true"  style="width: 60px;"><span class="fa fa-remove fa-lg"></span>&nbsp;取消</a>
                    
                    <input class="nui-combobox" visible="false" name="orgCarBrandId" id="orgCarBrandId"/>
                </td>
            </tr>
        </table>
    </div>
    <div class="nui-fit">
	    <div  id="mainGrid" class="nui-datagrid"
		    style="width:100%;height:100%;"
		    dataField="list" showPager="false" totalField="page.count"
		    pageSize="50" showPageInfo="true" multiSelect="true"
		    ondrawcell="onDraw"
	         allowCellSelect="true"
	         allowCellEdit="true"
		    showModified="false" allowSortColumn="false" allowCellWrap=true>
		      <div property="columns">
		      	   <div type="checkcolumn" field="check" width="20"></div>
		      	   <div type="comboboxcolumn" field="storeId" width="60" headerAlign="center" allowSort="true" header="仓库" visible="false">
                   </div> 
		      	   <div type="comboboxcolumn" field="orgCarBrandId" width="60" headerAlign="center" allowSort="true" header="厂牌" visible="true">
                        <input  property="editor" enabled="true" name="compBrandList" dataField="compBrandList" class="nui-combobox" valueField="customid" textField="name" data="compBrandList"
                                      url=""emptyText=""  vtype="required"/> 
                   </div> 
                   <div field="kingDeptCode" width="60" headerAlign="center" allowSort="" header="金蝶部门编码">
                        <input property="editor" class="nui-textbox"/>
                   </div> 
                   <div field="kingDeptName" width="60" headerAlign="center" allowSort="" header="金蝶部门名称">
                        <input property="editor" class="nui-textbox"/>
                   </div>
                   <div field="remark" width="100" headerAlign="center" allowSort="" header="备注">
                        <input property="editor" class="nui-textbox"/>
                   </div>
		           <div field="creator" width="40" headerAlign="center" allowSort="true">创建人</div>
		           <div field="createDate" width="60" headerAlign="center" allowSort="true" dateFormat="yyyy-MM-dd HH:mm">创建时间</div>
		           <div field="operator" width="40" headerAlign="center" allowSort="true">修改人</div>
		           <div field="operateDate" width="60" headerAlign="center" allowSort="true" dateFormat="yyyy-MM-dd HH:mm">修改时间</div>
		     </div>
	    </div>
   </div>
</div>         
</body>

<script type="text/javascript">
	var roles = "";
	var grid = null;
	var gridUrl = apiPath + cloudPartApi + "/com.hsapi.cloud.part.report.stock.getStoreKingDept.biz.ext";
	var storehouse = null;
	var storeHash={};
	var compBrandList = [];
	var compBrandHash = {};
	var __storeId = null;
	
	$(document).ready(function(v) {
		grid = nui.get("mainGrid");
		grid.setUrl(gridUrl);
		
		var dictDefs ={"orgCarBrandId": "10444"};
		initDicts(dictDefs, function(){
			
			compBrandList = nui.get("orgCarBrandId").getData();
			compBrandList.forEach(function(v){
				compBrandHash[v.customid]=v;
	    	});
			
			/* getStorehouse(function(data) {
				storehouse = data.storehouse || [];
				
				if(storehouse && storehouse.length>0){
					FStoreId = storehouse[0].id;
					storehouse.forEach(function(v){
		        		storeHash[v.id]=v;
		        	});
				}
		
				
			}); */
		});
	
	});
	
	
	function onDraw(e) {
		var record=e.record;
		var header = e.column.header;

		/* if(e.field== "storeId") {
			if(storeHash[e.value]) {
				e.cellHtml = storeHash[e.value].name;
			}else {
				e.cellHtml = "";
			}
		} */
		
		if(e.field== "orgCarBrandId") {
			if(compBrandHash[e.value]) {
				e.cellHtml = compBrandHash[e.value].name;
			}else {
				e.cellHtml = "";
			}
		}
		
	}
	
	function setData(storeId){
		__storeId = storeId;
		grid.load({
	        storeId: storeId,
	        token : token
	    });
	}
	
	function add() {
		var newRow = { storeId: __storeId };
    	grid.addRow(newRow);
	}
	
	function del() {
		var rows = grid.getSelecteds();
    	grid.removeRows(rows);
	}
	
	function save() {
		var gridData = grid.getChanges();
		var data=[];
		for(var i=0;i<gridData.length;i++){
			if(gridData[i].orgCarBrandId == null || gridData[i].orgCarBrandId == "") {
				showMsg("存在厂牌为空的数据，请完善","W");
				return;
			}
			if(gridData[i].kingDeptCode == null || gridData[i].kingDeptCode == "") {
				showMsg("存在金蝶部门编码为空的数据，请完善","W");
				return;
			}
			if(gridData[i].kingDeptName == null || gridData[i].kingDeptName == "") {
				showMsg("存在金蝶部门名称为空的数据，请完善","W");
				return;
			}
		}
	
		var addList = grid.getChanges("added");
		var updList = grid.getChanges("modified");
		var delList = grid.getChanges("removed");
	
		nui.mask({
	        el : document.body,
	        cls : 'mini-mask-loading',
	        html : '保存中...'
	    });
		nui.ajax({
	        url : apiPath + cloudPartApi + "/com.hsapi.cloud.part.report.stock.saveStoreKingDept.biz.ext",
	        type : "post",
	        data : JSON.stringify({
	            addList : addList,
	            updList : updList,
	            delList : delList,
	            token :token
	        }),
	        success : function(data) {
	            nui.unmask(document.body);
	            data = data || {};
	            if (data.errCode == "S") {
	                showMsg("保存成功","S");
	                
	                grid.load({
				        storeId: __storeId,
				        token : token
				    });
	                
	            } else {
	                showMsg(data.errMsg || "保存失败!","E");
	            }
	        },
	        error : function(jqXHR, textStatus, errorThrown) {
	            console.log(jqXHR.responseText);
	        }
	    });
	}
	
	function getRoles() {
		return roles;
	}
	
	function CloseWindow(action) {
	    //if (action == "close" && form.isChanged()) {
	    //    if (confirm("数据被修改了，是否先保存？")) {
	    //        return false;
	    //    }
	    //}
	    if (window.CloseOwnerWindow) return window.CloseOwnerWindow(action);
	    else window.close();
	}
	function onCancel(e) {
	    CloseWindow("cancel");
	}
	



</script>



</html>