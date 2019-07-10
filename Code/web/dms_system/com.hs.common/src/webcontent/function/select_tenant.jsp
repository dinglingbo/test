<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" session="false" %>


<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ include file="/common/sysCommon.jsp"%>	
<html>
<!-- 
  - Author(s): Administrator
  - Date: 2018-05-27 15:11:00
  - Description:
-->
<head>
    <title>租户选择</title>
	<meta http-equiv="content-type" content="text/html; charset=UTF-8" />	
    <%-- <script src="<%=webPath + contextPath%>/common/js/employeeHaveCompany.js?v=1.0.6" type="text/javascript"></script>   --%>  
</head>
<body>
	<div class="nui-toolbar" style="padding:2px;border-bottom:0;">
		<input class="nui-hidden" name="criteria/_entity" value="" />
		<table id="form" style="width:100%;">
			<tr>
				<td style="white-space:nowrap;">
				    <label style="font-family:Verdana;">快速查询：</label>
					<input class="nui-textbox" id="tenantId" name="tenantId" width="160px" emptyText="请输入租户ID" onenter="refresh">
                    <a class="nui-button" iconCls="" plain="true" onclick="refresh()"><span class="fa fa-search fa-lg"></span>&nbsp;查询</a>
                    <a class="nui-button" iconCls="" plain="true" onclick="saveMenu()" id=""><span class="fa fa-check fa-lg"></span>&nbsp;确定</a>
                    <a class="nui-button" iconCls="" plain="true" onclick="onCancel()" id=""><span class="fa fa-close fa-lg"></span>&nbsp;取消</a>
				</td>
			</tr>
		</table>
	</div> 
	 <div class="nui-fit">
          <div id="moreOrgGrid" class="nui-datagrid" style="width:100%;height:100%;"
               selectOnLoad="false"
               showPager="true"
               pageSize="20"
               totalField="page.count"
               dataField="rs"
               allowCellSelect="true"
               editNextOnEnterKey="true"
               allowCellWrap = true
               multiSelect="true"
               url="">
              <div property="columns">
                <div header="选择" headerAlign="center">
                   <div property="columns" >
                    <!-- <div field="guestOptBtn" name="guestOptBtn" width="50" headerAlign="center" allowsort="false" header="选择">
                     <input name="isDisabled" class="nui-checkbox" trueValue="1" falseValue="0" width="30%"/>
                    </div> -->
                    <div type="checkcolumn" field="check" width="30"></div> 
                   </div>
                </div>
                <div header="租户信息" headerAlign="center">
                    <div property="columns" >
                       <div field="tenantId" name="tenantId" width="30" align="center"  visible="true" headerAlign="center" header="租户ID"></div>
                       <div field="tenantName" name="tenantName" width="" align="center"  headerAlign="center" header="租户名称"></div>
                       <div field="tenantType" name="tenantType" width="" align="center"  headerAlign="center" header="租户类型"></div>
                   </div>
                </div>
              </div>
          </div>
    </div>
    <script type="text/javascript">
    nui.parse();
	var moreOrgGrid = nui.get("moreOrgGrid");
	var tenantId = null;
    var tenantType = null;
	var baseUrl = apiPath + sysApi + "/";
	var gridUrl = baseUrl + "com.primeton.tenant.comTenant.comTenantQueryBySql.biz.ext";
	var tenantMenu = null;
	//租户类型：1，汽修店，2汽配店，3变速箱维修店，4汽贸店，5汽贸汽修综合店
	var tenantTypeHash = {
			"1":"汽修店",
			"2":"汽配店",
			"3":"变速箱维修店",
			"4":"汽贸店",
			"5":"汽贸汽修综合店"
	};
    $(document).ready(function(v) {
		moreOrgGrid = nui.get("moreOrgGrid");
		moreOrgGrid.setUrl(gridUrl);
		refresh();
	   /*  moreOrgGrid.on("rowdblclick",function(e){
		   edit();
	    }); */
	    moreOrgGrid.on("drawcell", function (e) {
	        var record = e.record;
            var uid = record._uid;
	        if(e.field=="tenantType"){
	          e.cellHtml = tenantTypeHash[e.value];
	        }
	    }); 
    });

	function refresh(){
	    var params = {};
        params.isDisabled = 0;
	    var tenantId = nui.get("tenantId").getValue();
	    if(tenantId){
	       params.tenantId = tenantId;
	    }
        moreOrgGrid.load({params:params,token:token});
	}

	function setData(data){
		tenantMenu = data;
	}

	var saveUrl = baseUrl + "com.hsapi.system.tenant.permissions.saveBachTenantMenu.biz.ext";
	var deleteTenantMenuUrl = baseUrl + "com.hsapi.system.tenant.tenant.deleteTenantMenu.biz.ext"; 
	function saveMenu(){
		var list = moreOrgGrid.getSelecteds();
		var url = null;
		if(tenantMenu.delet && tenantMenu.delet==1){
		    url = deleteTenantMenuUrl;
		}else{
		    url = saveUrl;
		}
		nui.mask({
			el : document.body,
			cls : 'mini-mask-loading',
			html : '保存中...'
		});
		nui.ajax({
        url: url,
        type: 'post',
        data: nui.encode({
        	menu:tenantMenu,
        	list:list
        }),
        cache: false,
        success: function (data) {
            if (data.errCode == "S"){
           	   showMsg("保存成功","S");
           	   closeWindow("ok");
             }else {
            showMsg(data.errMsg,"E");
                /* nui.alert("失败！"); */
            }
            nui.unmask(document.body);
        },
        error: function (jqXHR, textStatus, errorThrown) {
            nui.alert(jqXHR.responseText);
            nui.unmask(document.body);
        }
	  });
	}	
	function CloseWindow(action) {
       if (window.CloseOwnerWindow)
           return window.CloseOwnerWindow(action);
       else window.close();
   }

   function onCancel() {
      CloseWindow("cancel");
   }
	</script>
</body>
</html>

	