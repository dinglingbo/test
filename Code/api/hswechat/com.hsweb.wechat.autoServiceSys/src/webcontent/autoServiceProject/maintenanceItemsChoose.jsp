<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false" %>
<%@include file="/common/sysCommon.jsp"%>	
<%@include file="/autoServiceSys/common/wechatCommon.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<!-- 
  - Author(s): lidongsheng
  - Date: 2019-02-13 09:08:39
  - Description:
-->
<head>
<title>维修项目</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
    
</head>
<body>
	<div class="nui-toolbar" style="padding:0px;">
        <table style="width:100%;">
            <tr>
                <td style="width:100%;">
                    <a class="nui-button" onclick="save()" plain="true" style="width: 60px;"><span class="fa fa-save fa-lg"></span>&nbsp;确定</a>
                    <a class="nui-button" onclick="onCancel()" plain="true"  style="width: 60px;"><span class="fa fa-remove fa-lg"></span>&nbsp;取消</a>
                </td>
            </tr>
        </table>
	</div>
    <div class="nui-fit">
		<div id="rightGrid"
			 dataField="list"
			 class="nui-datagrid"
			 style="float:left;width: 100%; height: 100%;"
			 url=""
			 borderStyle="border:1"
			 pageSize="50"
			 totalField="page.count"
			 sortMode="client"
			 showPageSize="true"  
			 allowSortColumn="true"
			 selectOnLoad="false"
			 allowCellSelect="true"
			 onload="loadForm"
			 showFilterRow="false" >
			<div property="columns" >
				<div type="checkcolumn" >选择</div>
				<div type="checkcolumn" name="checkcolumn" visible="false"></div>
				<div field="serviceTypeId" headerAlign="center" align="center" allowSort="true" width="60px">业务类型</div>
				<div field="code" headerAlign="center" align="center" width="60px">项目编码</div>
				<div field="name" headerAlign="center" align="center" allowSort="true" width="150px" >项目名称</div>
			</div>
		</div>
	</div>
    	


	<script type="text/javascript">
    	nui.parse();
    	var repairApiUrl=apiPathUrl+repairApi;
    	var rightGridUrl = repairApiUrl+"/com.hsapi.repair.baseData.item.queryRepairItemList.biz.ext";
		var rightGrid = nui.get("rightGrid");
		var itemId ="";
			
		function setFormData(data){
			var infos = nui.clone(data);
			rightGrid.setUrl(rightGridUrl);
			var params={
				isCanOrder:0,
				serviceTypeId:infos.serviceTypeId,
				isDisabled:0
			}
    		rightGrid.load({token:token,params:params});
    		itemId =infos.itemId;
		}
		
		function loadForm(){debugger;
			if(itemId){
    			var dataArray=rightGrid.getData();
    			for(var a=0;a<dataArray.length;a++){
    				if( dataArray[a].id == itemId){
    					rightGrid.setSelected(dataArray[a]);
    				}
    			}
    		}
		}
		
		//确定
		function save(){
			CloseWindow( nui.encode( rightGrid.getSelected() ) );//将选择的项目传入到输入框内
		}
		
		//取消
		function onCancel() {
			CloseWindow("cancel");
		}
		
		//关闭窗口
		function CloseWindow( action ) {
			if(action == "close" && form.isChanged()) {
				if(confirm("数据被修改了，是否先保存？")) {
					saveData();
				}
			}
			if(window.CloseOwnerWindow)
				return window.CloseOwnerWindow(action);
			else
				window.close();
		}
    </script>
</body>
</html>