<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false" %>
<%@include file="/common/sysCommon.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<!-- 
  - Author(s): zzj
  - Date: 2019-03-28 14:56:55
  - Description:
-->
<head>
<title>门店下所有用户的优惠券</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
    <style type="text/css">
                    body {
        margin: 0; 
        padding: 0;
        border: 0;
        width: 100%;
        height: 100%; 
        overflow: hidden;
        font-family: "微软雅黑";
    }
	    .mini-checkboxlist{
	    	padding-top:2px;
	    }
	    table{
	    	font-size: 12px;
	    }
	    .labeltext{
	    	font-family:Verdana;
	    	line-height: 25px;
	    }
	    .inputLeft{
	    	margin-right: 6px;
	    }
    </style>
</head>
<body>
	<div id="form1" class="nui-form">
		<div class="nui-toolbar" style="padding:0px;">
		<table style="width: 100%;">						
			<tr>
				<td style="font-size: 12px;display: flex;">
					<label class="labeltext" >门店名称： </label>
					<input id="storeId" name="storeId" class="nui-combobox"  textField="storeName" onvaluechanged="search" valueField="storeId" dataField="wechatStoreData" />
					<label class="labeltext" >微信昵称： </label>
					<input id="userName" name="userName" class="nui-textbox inputLeft" />
					<label class="labeltext" >车牌号： </label>
					<input id="carNo" name="carNo"  class="nui-textbox inputLeft" />
					<label class="labeltext" >优惠券名称： </label>
					<input id="couponTitle" name="couponTitle" class="nui-textbox inputLeft"  />
					<label class="labeltext" >优惠券状态： </label>
					<input id="userCouponStatus" name="userCouponStatus" class="nui-combobox"  textField="text" valueField="id" data='[{"id":0,"text":"未使用"},{"id":1,"text":"已核销"}]' />
				</td>
				<td width="40%" >
					<a class="nui-button" onclick="search()" plain="true" ><span class="fa fa-search fa-lg"></span>&nbsp;查询</a> 
					<a class="nui-button" onclick="reset()" plain="true" ><span class="fa fa-refresh fa-lg"></span>&nbsp;重置</a>
				</td>
			</tr>
		</table>
	</div>
		</div>
	<div class="nui-fit" >
		<div id="datagrid" class="nui-datagrid" style="height:100%;" allowResize="true"
	        dataField="result.data" pageSize="20" showPageInfo="true" allowCellSelect="false" multiSelect="false">
            <div property="columns">
            	<div type="checkcolumn" width="50" >选择</div>
            	<div field="storeName" headerAlign="center" align="center" >门店</div>
            	<div field="userName" headerAlign="center" align="center" >微信昵称</div>
            	<div field="carNo" headerAlign="center" align="center" >车牌号</div>
            	<div field="couponCode" headerAlign="center" align="center" >优惠券编码</div>
            	<div field="couponTitle" headerAlign="center" align="center" >优惠券名称</div>
            	<div field="couponUseTime" headerAlign="center" align="center" dateFormat="yyyy-MM-dd HH:mm:ss" >优惠券核销时间</div>
            	<div field="userCouponStatus" headerAlign="center" align="center" renderer="showCouponStatus">优惠券核销状态</div>
            </div>
        </div>
	    
	</div>

	<script type="text/javascript">
		nui.parse();
    	var pathapi=apiPath+wechatApi;
    	var pathweb=webPath+wechatDomain;
    	
    	var datagrid = nui.get("datagrid");
    	var storeId = nui.get("storeId");
    	
		$(function(){
			datagrid.setUrl(pathapi+"/com.hsapi.wechat.autoServiceBackstage.weChatCardCoupon.queryUserCouponListByStore.biz.ext");
			storeId.setUrl(pathapi+"/com.hsapi.wechat.autoServiceBackstage.weChatStore.queryWechatStoreList.biz.ext?token="+token);
			storeId.select(0);
			search();
		});
		
		//搜索
    	function search(){
    		var formData = new nui.Form("#form1").getData();
        	datagrid.load({param:formData,token:token});
    	}
		
		//清空
    	function reset(){
    		var id=storeId.getValue();
    		var form = new nui.Form("#form1");
			form.reset();
			storeId.setValue(id);
    	}
		
		//渲染表单业务字典
		function showCouponStatus(e){
			return e.value == 0 ?  "未使用" : "已核销" ;
		}
    	
    </script>
</body>
</html>