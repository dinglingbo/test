<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false" %>
<%@include file="/common/sysCommon.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<!-- 
  - Author(s): lidongsheng
  - Date: 2019-03-04 10:16:55
  - Description:
-->
<head>
<title>查看优惠劵派发详情</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
    <style type="text/css">
    	label{
	    	font-size: 14px;
	    }
	    body .mini-tabs-plain .mini-tabs-scrollCt{
	    	background-color: DEEDF7;
	    }
	    .mini-tabs-position-top .mini-tabs-plain .mini-tabs-header{
	    	margin-top: 4px;
	    }
	    .mini-checkboxlist{
	    	padding-top:2px;
	    }
	    table{
	    	font-size: 12px;
	    }
	    
    </style>
</head>
<body>
	<!-- <div id="userDivTable" class="nui-tabs" style="width:100%;height:92%;" activeIndex="0">
		<div title="绑定用户" value="1" >
	       
	    </div>
	  	<div title="关注用户" value="1" >
	        
	    </div>
	</div> -->
	<div class="nui-fit" style="padding-left: 3px; padding-right: 3px; padding-bottom: 3px; height:95%;width:100%;">
		<div id="useCouponUser" class="nui-datagrid" style="height:100%;width:100%;" allowResize="true"
	        dataField="useCouponUserArray" pageSize="12" showPageInfo="true" allowCellSelect="false" multiSelect="false">
            <div property="columns">
            	<div field="userCouponCode" headerAlign="center" align="center" width="180" >卡劵编码</div>
            	<div field="userMarke" headerAlign="center" align="center"  >用户服务号</div>
            	<div field="userNickname" headerAlign="center" align="center"  >用户昵称</div>
            	<div field="userName" headerAlign="center" align="center"  >用户姓名</div>
            	<div field="userPhone" headerAlign="center" align="center"  >用户电话</div>
            	<div field="carNo" headerAlign="center" align="center"  >车牌号</div>
            	<div field="userCouponStatus" headerAlign="center" align="center"  renderer="onUserCouponStatus" >优惠劵状态</div>
         </div>
    </div>
	
	    
	</div>

	<script type="text/javascript">
		nui.parse();
    	var pathapi=apiPath+wechatApi;
    	var pathweb=webPath+wechatDomain;
    	var useCouponUser = nui.get("useCouponUser");
    	
    	
		//页面间传输json数据
		function setFormData(data) {
			var infos = nui.clone(data);
			useCouponUser.setUrl(pathapi+"/com.hsapi.wechat.autoServiceBackstage.weChatCardCoupon.queryUseCouponCardUser.biz.ext");
			var paraMap={
				couponDistributeId:infos.couponDistributeId
			};
			useCouponUser.load({map:paraMap,token:token});
		}
		
		//是否核销
		function onUserCouponStatus(e){
			return e.value == 0 ?  "未使用" : "已核销" ;
		}
    	
    </script>
</body>
</html>