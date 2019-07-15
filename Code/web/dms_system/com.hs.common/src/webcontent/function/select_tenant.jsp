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
				    <a class="nui-menubutton " menu="#popupMenuStatus" id="menunamestatus">所有</a>
                    <ul id="popupMenuStatus" class="nui-menu" style="display:none;">
                        <li iconCls="" onclick="quickSearch1(1)" id="type0">汽修</li>
                        <li iconCls="" onclick="quickSearch1(2)" id="type0">汽配</li>
                        <li iconCls="" onclick="quickSearch1(3)" id="type1">变速箱</li>
                        <li iconCls="" onclick="quickSearch1(4)" id="type2">汽贸</li>
                        <li iconCls="" onclick="quickSearch1(5)" id="type0">汽修汽贸</li>
                        <li iconCls="" onclick="quickSearch1(6)" id="type0">所有</li>
                   </ul>
                   <a class="nui-menubutton" plain="false" iconCls="" id="menunamedate" menu="#popupMenu" >在用</a>
				    <ul id="popupMenu" class="nui-menu" style="display:none;">
				        <li iconCls="" onclick="quickSearch(1)">停用</li>
				        <li iconCls="" onclick="quickSearch(0)">在用</li>
				        <li iconCls="" onclick="quickSearch(2)">所有</li>
				        
				    </ul>
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
		if(isDisabled != 2){
			params.isDisabled = isDisabled;
		}
		if(tenantType != 6){
			params.tenantType = tenantType;
		}
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
   
   
   var isDisabled = 0;
function quickSearch(type) {
   // var params = getSearchParam();
    var queryname = "在用";
    switch (type) {
        case 1:
            //params.isDisabled = 1;
            queryname = "停用";
            isDisabled = 1;
            break;
        case 0:
        	//params.isDisabled =0;
        	isDisabled = 0;
            queryname = "在用";
            break;
        case 2:
            //queryname = "所有";
            isDisabled = 2;
            break;
        default:
            break;
    }
    var menunamedate = nui.get("menunamedate");
    menunamedate.setText(queryname);
    refresh();
}

//1，汽修店，2汽配店，3变速箱维修店，4汽贸店，5汽贸汽修综合店
var tenantType = 6;
function quickSearch1(type) {
    var queryname = "所有";
    switch (type) {
        case 1:
            //params.tenantType = 1;
            queryname = "汽修";
            tenantType = 1;
            break;
        case 2:
        	//params.tenantType =1;
        	tenantType = 2;
            queryname = "汽配";
            break;
        case 3:
        	//params.tenantType =3;
        	tenantType = 3;
            queryname = "变速箱";
            break;
        case 4:
        	//params.tenantType =4;
        	tenantType = 4;
            queryname = "汽贸";
            break;
        case 5:
        	//params.tenantType =5;
        	tenantType = 5;
            queryname = "汽修汽贸";
            break;
        case 6:
            queryname = "所有";
            tenantType = 6;
            break;
        default:
            break;
    }
    var menunamedate = nui.get("menunamestatus");
    menunamedate.setText(queryname);
    refresh();
 }
   
   
   
   
	</script>
</body>
</html>

	