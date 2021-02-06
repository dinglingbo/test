<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false"%>
    <%@include file="/common/sysCommon.jsp"%>
            <!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
            <html>
            <!-- 
  - Author(s): Administrator
  - Date: 2018-01-31 16:54:43
  - Description:
-->
<head>
    <title>员工选择</title> 
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
                    <a class="nui-button" onclick="save()" plain="true" style="width: 60px;" id="save"><span class="fa fa-save fa-lg"></span>&nbsp;确定</ a>
                    <a class="nui-button" onclick="CloseWindow('cancle')" plain="true"  style="width: 60px;"><span class="fa fa-remove fa-lg"></span>&nbsp;取消</ a>
                </td>
            </tr>
        </table>
    </div>
    <div class="nui-fit">
	    <div  id="memGrid" class="nui-datagrid"
		    style="width:100%;height:100%;"
		    dataField="rs" showPager="true" totalField="page.count"
		    pageSize="50" showPageInfo="true" multiSelect="true"
		    showModified="false" allowSortColumn="false" allowCellWrap=true>
		      <div property="columns">
		      	   <div type="checkcolumn" field="check" width="20"></div>
		           <div field="empid" headerAlign="center" allowSort="false" visible="false" width="100" header="id" align="center"></div>
		    	   <div field="name" headerAlign="center" allowSort="false" visible="true" width="100" header="员工姓名" align="center"></div>
		           <div field="tel" headerAlign="center" allowSort="false" visible="true" width="120" header="手机号" align="center"></div>
		           <div field="compShortName" headerAlign="center" name="remark" allowSort="false" visible="true" width="200" header="所属机构" align="center"></div>
		     </div>
	    </div>
   </div>
</div>         
</body>

<script type="text/javascript">
	var baseUrl = apiPath + sysApi + "/";
	var gridUrl = baseUrl + "com.hsapi.system.tenant.employee.queryEmployee.biz.ext";
	var retList = [];
	var grid = null;
	
	$(document).ready(function(v) {
		grid = nui.get("memGrid");
		grid.setUrl(gridUrl);
		
		var request = {
	        "params":{
	        	orgid: currOrgId
	        }
	    };
		grid.load(request,function(){
	        //成功;
	       // nui.alert("数据成功！");
	    },function(){
	        //失败;
	        showMsg("数据加载失败!","W");
	    });
	});
	
	function save() {
		var rows = grid.getSelecteds();
		retList = rows;
		CloseWindow('ok');
	}
	
	function getRetData() {
		return retList;
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