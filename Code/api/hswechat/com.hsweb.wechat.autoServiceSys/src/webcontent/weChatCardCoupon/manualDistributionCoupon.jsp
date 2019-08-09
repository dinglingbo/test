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
<title>手动派发优惠劵</title>
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
				<td style="font-size: 12px;">
					<label class="labeltext" >门店名称： </label>
					<input id="storeId" name="storeId" class="nui-combobox" onvaluechanged="OnStoreIdchanged"  textField="storeName" value=""  valueField="storeId" dataField="wechatStoreData" />
					<label class="labeltext" >派发人： </label>
					<input id="distributePeopleName" name="distributePeopleName" class="nui-textbox inputLeft"  />
					<label class="labeltext" >派发时间： </label>
					<input id="beginDistributeDate" name="beginDistributeDate" onvaluechanged="dateBeginchanged" class="nui-datepicker" />
					-
					<input id="endDistributeDate" name="endDistributeDate" onvaluechanged="dateEndchanged" class="nui-datepicker"  />
 
					<a class="nui-button" onclick="search()" plain="true" ><span class="fa fa-search fa-lg"></span>&nbsp;查询</a> 
					<a class="nui-button" onclick="reset()" plain="true" ><span class="fa fa-refresh fa-lg"></span>&nbsp;重置</a>
					<a class="nui-button" onclick="distribution()" plain="true" ><span class="fa fa-plus fa-lg"></span>&nbsp;派发</a>
				</td>
			</tr>
		</table>
	</div>
	</div>	
	<div class="nui-fit" style="padding-left: 3px; padding-right: 3px; padding-bottom: 3px; height:95%;">
		<div id="wxbCouponDistributeData" class="nui-datagrid" style="height:100%;" allowResize="true"
	        dataField="wxbCouponDistributeData" pageSize="12" showPageInfo="true" allowCellSelect="false" multiSelect="false">
            <div property="columns">
            	<div type="checkcolumn" width="50" >选择</div>
            	<div field="storeName" headerAlign="center" align="center" >微信门店</div>
            	<div field="couponCode" headerAlign="center" align="center" width="150" >卡劵编码</div>
            	<div field="couponTitle" headerAlign="center" align="center"  >卡劵标题</div>
            	<div field="distributePeopleName" headerAlign="center" align="center"  >派发人</div>
            	<div field="distributeDate" headerAlign="center" align="center" dateFormat="yyyy-MM-dd HH:mm:ss" >派发时间</div>
            	<div field="couponNumber" headerAlign="center" align="center" width="65" >库存量</div>
            	<div field="distributePeopleNumber" headerAlign="center" align="center" width="70"renderer="onDistributePeopleNumber" >已派发人数</div>
            	<div field="couponDiscountsPrice" headerAlign="center" renderer="onCouponDiscountsPrice" align="center" width="65" >优惠价格</div>
            	<div field="couponType" headerAlign="center" align="center" renderer="onCouponType" width="65" >优惠劵类别</div>
            	<div field="distributeStatus" headerAlign="center" align="center" renderer="onDistributeStatus" width="65" >派发状态</div>
            	<div field="couponStatus" headerAlign="center" align="center" renderer="onCouponStatus" width="65" >优惠劵状态</div>
            	<div field="couponDistributeId" headerAlign="center" align="center" renderer="onCouponDistributeId" width="100" >查看优惠劵派发详情</div>
            </div>
        </div>
	    
	</div>

	<script type="text/javascript">
		nui.parse();
    	var pathapi=apiPath+wechatApi;
    	var pathweb=webPath+wechatDomain;
    	var wxbCouponDistributeData = nui.get("wxbCouponDistributeData");
    	var storeId = nui.get("storeId");
    	
    	$(function(){
    		wxbCouponDistributeData.setUrl(pathapi+"/com.hsapi.wechat.autoServiceBackstage.weChatCardCoupon.queryManualDistributionCoupon.biz.ext");
			storeId.setUrl(pathapi+"/com.hsapi.wechat.autoServiceBackstage.weChatStore.queryWechatStoreList.biz.ext?token="+token);
			storeId.select(0);
			search();
		});
		
		//已派发人数
		function onDistributePeopleNumber(e){
			return e.value ? e.value : 0 ;
		}
		
		//点击查看
		function onCouponDistributeId(e){
			return "<a style='text-decoration: none;' href='javascript:queryPushUser("+e.value+")'>点击查看</a>";
		}
		
		//优惠劵派发详情
		function queryPushUser(couponDistributeId) {
			nui.open({
				url: pathweb+"/autoServiceSys/weChatCardCoupon/queryPushCouponCardInfo.jsp",
				title: "优惠劵派发详情",
				width: 850,
				height: 400,
				onload: function() { //弹出页面加载完成
					var iframe = this.getIFrameEl();
					var data = {
						couponDistributeId:couponDistributeId
					}; //传入页面的json数据
					iframe.contentWindow.setFormData(data);
				},
				ondestroy: function(action) { //弹出页面关闭前
					
				}
			});
		}
		
		//手动派发
		function distribution(){
			nui.open({
				url: pathweb+"/autoServiceSys/weChatCardCoupon/pushCoupon.jsp",
				title: "优惠劵派发",
				width: 1210,
				height: 670,
				onload: function() { //弹出页面加载完成
					var iframe = this.getIFrameEl();
					var data = {
						storeId:storeId.getValue()
					}; //传入页面的json数据
					iframe.contentWindow.setFormData(data);
				},
				ondestroy: function(action) { //弹出页面关闭前
					if(action == 'saveSuccess') {
						nui.alert("派发成功", "系统提示");
						serviceItemData.reload();
					}else if(action == 'saveFail'){
						nui.alert("派发失败", "系统提示");
					}
				}
			});
			
		}
		
		//选择门店
		function OnStoreIdchanged(){
			var formData = new nui.Form("#form1").getData();
        	wxbCouponDistributeData.load({map:formData,token:token});
		}
		
		//搜索
    	function search(){
    		var formData = new nui.Form("#form1").getData();
        	wxbCouponDistributeData.load({map:formData,token:token});
    	}
		
		//清空
    	function reset(){
    		var id=storeId.getValue();
    		var form = new nui.Form("#form1");
			form.reset();
			storeId.setValue(id);
    	}
		
		//开始时间
		function dateBeginchanged(){
			nui.get("endDistributeDate").setMinDate(nui.get("beginDistributeDate").getValue());
		}
		
		//结束时间
		function dateEndchanged(){
			nui.get("beginDistributeDate").setMaxDate(nui.get("endDistributeDate").getValue());
		}
		
		//派发状态
		function onDistributeStatus(e){
			return e.value == 1 ?  "未派发" : "已派发" ;
		}
		
		//优惠劵状态
		function onCouponStatus(e){
			return e.value == 1 ?  "线上使用" : "线下使用" ;
		}
		
		//优惠价格
		function onCouponDiscountsPrice(e){
			return Boolean(e.value) ? e.value+"元" : e.value;
		}
		
		//优惠劵类别
		function onCouponType(e){
			return e.value == 1 ?  "通用劵" : "专属劵" ;
		}
		
		//只限车辆下使用
		function onIsCarUse(e){
			return e.value == 0 ?  "是" : "否" ;
		}
		
		//只限门店下使用
		function onIsStoreUse(e){
			return e.value == 0 ?  "是" : "否" ;
		}
		
		//只限租下使用
		function onIsTenantUse(e){
			return e.value == 0 ?  "是" : "否" ;
		}
    	
    </script>
</body>
</html>