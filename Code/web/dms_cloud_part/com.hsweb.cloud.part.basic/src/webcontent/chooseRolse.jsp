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
    <title>APP权限选择</title> 
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
		           <div field="code" headerAlign="center" allowSort="false" visible="true" width="40" header="角色编码" align="center"></div>
		    	   <div field="name" headerAlign="center" allowSort="false" visible="true" width="80" header="角色名称" align="center"></div>
		           <div field="remark" headerAlign="center" allowSort="false" visible="true" width="120" header="权限描述" align="center"></div>
		     </div>
	    </div>
   </div>
</div>         
</body>

<script type="text/javascript">
	var roles = "";
	var grid = null;
	var rs =[{"code":"1111","name":"管理员","remark":"没有人事权限"},
			 {"code":"1","name":"仓库管理员","remark":"仓库信息查询，仓库信息编辑"},
			 {"code":"10","name":"入库质检员","remark":"质检信息查询,录入质检信息"},
			 {"code":"100","name":"出库管理员","remark":"创建出库单,查询出库单"},
			 {"code":"1000","name":"盘点员","remark":"盘点仓库信息"},
			 {"code":"0","name":"普通成员","remark":"团队信息"},
			 {"code":"9999","name":"创建人","remark":"所有权限"},
			 {"code":"11","name":"入库管理员","remark":"创建入库单，查看入库单"},
			 {"code":"12","name":"入库员","remark":"入库、入库盘点"}];
	
	$(document).ready(function(v) {
		grid = nui.get("memGrid");
		grid.setData(rs);
		
	
	});
	
	function save() {
		var rows = grid.getSelecteds();
		for(var i=0;i<rows.length;i++){
			roles =roles + rows[i].code +",";
		}
		roles=roles.substring(0,roles.length-1);
		CloseWindow('ok');
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