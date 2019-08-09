<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false" %>
	<%@include file="/common/sysCommon.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<!-- 
  - Author(s): lidongsheng
  - Date: 2019-03-23 04:54:21
  - Description:
-->
<head>
<title>门店评价详情</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
    <style type="text/css">
    	table{
	    	font-size: 12px;
	    }
	    .imageComment{
	    	width: 120px;
    		height: 130px;
    		border: 1px solid #c1c1c1;
    		border-radius: 25px;
	    }
    	/* body .mini-textbox-disabled .mini-textbox-border{
    		border: 0px !important;
    		background: #f2f5f7 !important;
    	}
    	.mini-textarea .mini-textbox-input{
    		line-height: 2.2 !important;
    	} */
    </style>
</head>
<body>
	<div class="form" id="storeCommentInfoForm" name="templateInfoForm" style="height:85%;left:0;right:0;margin: 0 auto;display: flex;padding: 10px;padding-right: 25px;">
		<table style="width:100%;margin-left: 30px;border-collapse: separate;border-spacing: 0px 20px;" class="nui-form-table">
			<tr>
				<td class="nui-form-label" colspan="1" style="" >
					<label>门店名称:</label>
				</td>
				<td colspan="1" style="">
					<input class="nui-textbox tabwidth" name="storeName" id="storeName" />
				</td>
			</tr>
			<tr>
				<td class="nui-form-label" colspan="1" style="" >
					<label>用户昵称:</label>
				</td>
				<td colspan="1" style="">
					<input class="nui-textbox tabwidth" name="userNickname" id="userNickname" />
				</td>
				<td class="nui-form-label" colspan="1" style="" >
					<label>用户车牌号:</label>
				</td>
				<td colspan="1" style="">
					<input class="nui-textbox tabwidth" name="carNo" id="carNo" />
				</td>
			</tr>
			<tr>
				<td class="nui-form-label" colspan="1" style="" >
					<label>评分分数:</label>
				</td>
				<td colspan="1" style="">
					<input class="nui-textbox tabwidth" name="commentScore" id="commentScore" />
				</td>
				<td class="nui-form-label" colspan="1" style="" >
					<label>评分时间:</label>
				</td>
				<td colspan="1" style="">
					<input class="nui-textbox tabwidth" name="commentDate" id="commentDate" style="width:180px;"/>
				</td>
			</tr>
			<tr>
				<td class="nui-form-label" colspan="1" style="" >
					<label>评分内容:</label>
				</td>
				<td colspan="3" style="">
					<input class="nui-textarea tabwidth" name="commentContent" id="commentContent" style="width:350px;height:100px;" />
				</td>
			</tr>
			<tr>
				<td class="nui-form-label" colspan="1" style="" >
					<label>评分图片:</label>
				</td>
			</tr>
			<tr>
				<td class="nui-form-label" colspan="1" style="" >
				</td>
				<td colspan="3" style="" id="pictureList" >
					<img src="" />
				</td>
			</tr>
		</table>
	</div>


	<script type="text/javascript">
    	nui.parse();
    	var pathapi=apiPath+wechatApi;
    	var pathweb=webPath+wechatDomain;
    	
    	//页面间传输json数据
		function setFormData(data) {
			var infos = nui.clone(data);
			var storeCommentData=infos.storeCommentData;
			console.log(storeCommentData);
			var form = new nui.Form("#storeCommentInfoForm"); //将普通form转为nui的form
			form.setData(storeCommentData);
			
			var commentDate = new Date(storeCommentData.commentDate);
			commentDateString = commentDate.getFullYear()+"年"+dateFormStirng( (commentDate.getMonth()+1) )+"月"+dateFormStirng( commentDate.getDate() ) + "日    "+dateFormStirng( commentDate.getHours() )+":"+dateFormStirng( commentDate.getMinutes() )+":"+dateFormStirng( commentDate.getSeconds() );
			nui.get("commentDate").setValue(commentDateString);
			
			nui.get("storeName").disable(false);
			nui.get("userNickname").disable(false);
			nui.get("carNo").disable(false);
			nui.get("commentScore").disable(false);
			nui.get("commentDate").disable(false);
			nui.get("commentContent").disable(false);
			var pictureDataArray = storeCommentData.pictureDataArray;
			for(var a=0;a<pictureDataArray.length;a++){
				$("#pictureList").append('<img class="imageComment" src="'+pictureDataArray[a].pictureUrl+'" />');
			}
			
		}
		
		function dateFormStirng(dateString){
			return Number(dateString) > 9 ? dateString : "0"+dateString;
		}
		
    </script>
</body>
</html>