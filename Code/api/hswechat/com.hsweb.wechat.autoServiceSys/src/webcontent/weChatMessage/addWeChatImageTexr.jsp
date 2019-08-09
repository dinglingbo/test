<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false" %>
<%@include file="/common/sysCommon.jsp"%>
<% String webcssPath = webPath + wechatDomain; %>	
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<!-- 
  - Author(s): lidongsheng
  - Date: 2019-02-21 11:16:26
  - Description:
-->
<head>
<title>微信图文消息添加</title>
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
	    .imgA{
	    	height: 150px;
    		width: 140px;
    		display: table-cell;
    		text-align: center;
    		vertical-align: middle;
    		border: 1px solid #DFDFDF;
   			background: url(<%=webcssPath %>/autoServiceSys/images/bg.png) no-repeat scroll center 0px transparent;
	    }
	    .divImg{
	    	width: 120px;
    		margin: auto;
	    }
	    .imgStyle{
	    	border: none;
		    max-width: 100%;
		    height: auto;
		    vertical-align: middle;
	    }
	    
	    /* 单图文消息样式  开始*/
	    .msg-item-wrapper{
	    	color: #AAAAAA;
			width: 350px;
		    margin-top: 30px;
		    margin-left: 15px;
		    background-color: #F4F4F4;
		    border: 1px solid #B8B8B8;
		    border-radius: 5px 5px 5px 5px;
		    box-shadow: 0 2px 2px rgba(0, 0, 0, 0.1);
		    margin-bottom: 26px;
		    position: relative;
			
		}
		.msg-item{
			background-color: #FFFFFF;
		    border-bottom: 1px solid #CCCCCC;
		    border-radius: 5px 5px 0 0;
		    box-shadow: 0 2px 4px rgba(0, 0, 0, 0.2);
		    padding: 2px 0;
		    border-radius: 5px;
		    box-shadow: none;
		    moz-border-radius: 5px;
		    moz-box-shadow: none;
		    webkit-border-radius: 5px;
		    webkit-box-shadow: none;
			
		}
		.msg-t{
			font-size: 15px;
		    color: #000000;
		    letter-spacing: 1px;
		    line-height: 16px;
		    margin: 6px 14px 0;
		    max-height: 56px;
		    overflow: hidden;
		    margin-bottom: 4px;
		}
		.cover{
			font-size: 0;
		    height: 160px;
		    margin: 0 14px 12px;
		    overflow: hidden;
		    position: relative;
		}
		.default-tip{
			margin: 0 0 10px;
			background-color: #ECECEC;
			text-align: center;
			text-shadow: 0 1px 0 #FFFFFF;
			color: #AAAAAA;
			font-size: 22px;
			line-height: 160px;
		}
		.i-img{
			width: 100%;
		    vertical-align: middle;
		    border: 0;
		}
		.msg-text{
			font-size: 12px;
    		line-height: 1.5;
		    margin: 0 14px;
		    padding-bottom: 8px;
		    text-align: left;
		}
		.msg-hover-mask{
			background: none repeat scroll 0 0 rgba(0, 0, 0, 0.6) !important;
		    display: none;
		    height: 100%;
		    position: absolute;
		    top: 0;
		    width: 100%;
		}
		.msg-mask{
			background: none repeat scroll 0 0 rgba(0, 0, 0, 0.6) !important;
		    display: none;
		    height: 100%;
		    position: absolute;
		    top: 0;
		    width: 100%;
		} 
		.msg-selected-tip{
			background: url(http://erp.baisyi.net/Public/Wechat/Admin/item_addkeyword/mpres/htmledition/images/selected-icon.png) no-repeat scroll 50% 50% transparent;
		    height: 100%;
		    position: absolute;
		    width: 100%;
		    display: inline-block;
		}
		/* 单图文消息样式  结束*/
		
		/* 多图文消息样式  开始*/
		.msg-tss{
			font-size: 17px;
    		padding: 2px;
		    background: none repeat scroll 0 0 rgba(0, 0, 0, 0.6) !important;
		    bottom: 0;
		    color: #FFFFFF;
		    margin: 0;
		    overflow: hidden;
		    position: absolute;
		    width: 100%;
		}
		.i-titles{
		    display: block;
		    padding-left: 4px;
		    padding-right: 4px;
		}
		.appmsgItemss{
			position: relative;
		    border-top: 1px solid #C6C6C6;
		    overflow: hidden;
		    padding: 12px 14px;
		}
		.default-tipss{
			
		    border: 1px solid #B2B8BD;
		    color: #C0C0C0;
		    font-size: 16px;
		    line-height: 70px;
		    width: 70px;
		    background-color: #ECECEC;
		    display: block;
		    text-align: center;
		    text-shadow: 0 1px 0 #FFFFFF;
		
		}
		.msg-ts{
			
		    font-size: 14px;
		    line-height: 24px;
		    margin-left: 0;
		    margin-right: 85px;
		    margin-top: 0;
		    max-height: 48px;
		    overflow: hidden;
		    padding-left: 4px;
		    padding-top: 12px;
		
			
		}
		.sub-add-btnss{
			
		    border: 2px dotted #B8B8B8;
		    border-radius: 5px 5px 5px 5px;
		    color: #222222;
		    line-height: 70px;
		    display: block;
		    text-align: center;
		    cursor: pointer;
		    text-decoration: none;
		    background-color: transparent;
		
		}
		.sub-add-iconss{
			
		    background: url(http://erp.baisyi.net/Public/Wechat/Admin/item_addkeyword/mpres/htmledition/images/icon18.png) no-repeat scroll 0 -83px transparent;
		    height: 18px;
		    margin-right: 5px;
		    width: 18px;
		    display: inline-block;
		    vertical-align: middle;
		
			
		}
		/* 多图文消息样式  结束*/
		
		.sub-msg-oprs{
			background: none repeat scroll 0 0 rgba(229, 229, 229, 0.85);
		    height: 100%;
		    left: 100%;
		    top: 0;
		    width: 100%;
		    position: absolute;
		    text-align: center;
		    margin-top: 0;
		    margin-bottom: 10px;
		}
		.sub-msg-opr-items{
		    font-size: 0;
		    margin: 64px 0px 0px 0px;
		    display: inline-block;
		    margin-right: 44px;
		}
		.iconEditss{
		    background: url(http://erp.baisyi.net/Public/Wechat/Admin/item_addkeyword/mpres/htmledition/images/icon18.png) no-repeat scroll 0 0 transparent;
		    display: block;
		    height: 18px;
		    width: 18px;
		    line-height: 150px;
		    overflow: hidden;
		    cursor: pointer;
		    color: #337ab7;
		    text-decoration: none;
		    background-position: 0 -139px;
		}
		
		.sub-msg-opr_detail{
		    margin-top: 0;
		    margin-bottom: 10px;
		    text-align: center;
		    position: absolute;
		    background: none repeat scroll 0 0 rgba(229, 229, 229, 0.85);
		    height: 100%;
		    top: 0;
		    right: 85px;
		    width: 100%;
		}
		.sub-msg-opr-item_detail{
		    display: inline-block;
		    font-size: 0;
		    margin: 40px 20px 0;
		}
		.iconEdit_detail{
		    color: #337ab7;
		    text-decoration: none;
		    cursor: pointer;
		    line-height: 150px;
		    overflow: hidden;
		    background: url(http://erp.baisyi.net/Public/Wechat/Admin/item_addkeyword/mpres/htmledition/images/icon18.png) no-repeat scroll 0 0 transparent;
		    display: block;
		    height: 18px;
		    width: 18px;
		    background-position: 0 -139px;
		}
		.iconDel_detail{
			background: url(http://erp.baisyi.net/Public/Wechat/Admin/item_addkeyword/mpres/htmledition/images/icon18.png) no-repeat scroll 0 0 transparent;
		    display: block;
		    height: 18px;
		    width: 18px;
		    line-height: 150px;
		    overflow: hidden;
		    cursor: pointer;
		    color: #337ab7;
		    text-decoration: none;
		    background-position: 0 -195px;
		}
		.tableList{
			position: relative;
		    overflow: hidden;
		    background-color: #f8f8f8;
		    border: 1px solid #b8b8b8;
		    border-radius: 5px;
		    box-shadow: 0 2px 2px rgba(0,0,0,0.1);
		    padding: 14px 22px 20px 20px;
		}
		.a-out{
			margin-top: 0px;
		    border-color: transparent #b8b8b8 transparent transparent;
		    border-width: 12px 14px 12px 0;
		    left: -13px;
		    top: 114px;
		    border-style: dashed solid dashed dashed;
		    font-size: 0;
		    height: 0;
		    width: 0;
		    position: absolute;
		}
		.a-in{
			margin-top: 0px;
		    border-color: transparent #f8f8f8 transparent transparent;
		    border-width: 11px 13px 11px 0;
		    left: -12px;
		    top: 115px;
		    border-style: dashed solid dashed dashed;
		    font-size: 0;
		    height: 0;
		    width: 0;
		    position: absolute;
		}
    </style>
    <script type="text/javascript" charset="utf-8" src="<%=webcssPath %>/autoServiceSys/ueditor/ueditor.config.js"> </script>
    <script type="text/javascript" charset="utf-8" src="<%=webcssPath %>/autoServiceSys/ueditor/ueditor.all.min.js"></script>
    <script type="text/javascript" charset="utf-8" src="<%=webcssPath %>/autoServiceSys/ueditor/zh-cn.js"></script>
    <!-- 模板 -->
    <script type="text/javascript" charset="utf-8" src="<%=webcssPath %>/autoServiceSys/js/mustache.js"></script>
    
</head>
<body>
	<div class="nui-fit">
	
		<div class="nui-toolbar" style="padding:0px;">
	        <table style="width:100%;">
	            <tr>
	                <td style="width:100%;">
	                    <a class="nui-button" onclick="save()" plain="true" style="width: 60px;"><span class="fa fa-save fa-lg"></span>&nbsp;保存</a>
	                    <a class="nui-button" onclick="onCancel()" plain="true"  style="width: 60px;"><span class="fa fa-remove fa-lg"></span>&nbsp;取消</a>
	                    <a id="preview" enabled="false" class="nui-button" onclick="preview()" plain="true"  style="width: 60px;"><span class="fa fa-tablet fa-lg"></span>&nbsp;预览</a>
	                </td>
	            </tr>
	        </table>
		</div>
		<!-- 预览用户填写 -->
		<div id="advancedOrgWin" class="nui-window windowsss"
		     title="填写预览用户" style="border-width: 0px;width: 530px;padding: 0px;z-index: 999;margin-top: 5%;margin-left: 30%;"
		     showModal="true"
		     showHeader="false"
		     allowResize="false"
		     style="padding:2px;border-bottom:0;"
		     allowDrag="true">
		     <div class="nui-toolbar" >
		        <table style="width:100%;">
		            <tr>
		            	<td class="nui-form-label" colspan="1" style="width: 25%;" >
							<label>用户微信号：</label>
						</td>
		                <td style="width:100%;">
		                    <input class="nui-textbox" id="userCode" name="userCode" width="160px" emptyText="请输入用户微信号">
		                    <a class="nui-button" iconCls="" plain="true" onclick="pushMessagerData" id=""><span class="fa fa-check fa-lg"></span>&nbsp;确定</a>
		                    <a class="nui-button" iconCls="" plain="true" onclick="onClose" id=""><span class="fa fa-close fa-lg"></span>&nbsp;取消</a>
		                </td>
		            </tr>
		        </table>
		    </div>
		    
		</div>
		 
			
			<input class="nui-textbox" name="pageType" id="pageType" visible="false"/>
			<input class="nui-textbox" name="imageTextId" id="imageTextId" visible="false"/>
			
			<div id="messageDivTable" class="nui-tabs" style="width:100%;height:92%;" activeIndex="0" onactivechanged="activechanged">
			
			    <div title="文本消息" value="1" >
			    	<input class="nui-textbox" name="textDetailId" id="textDetailId" visible="false"/>
			    	<div class="form" id="ImageTextMessOne" name="ImageTextMessOne" style="height:92%;left:0;right:0;margin: 0 auto;display: flex;">
						<table style="width:auto;margin-left: 30px;border-collapse: separate;border-spacing: 0px 20px;" class="nui-form-table">
							<tr>
								<td class="nui-form-label" colspan="1" style="width: 25%;" >
									<label>门店选择：</label>
								</td>
								<td colspan="1">
									<input id="storeId" name="storeId" class="nui-combobox" required="true" style="margin-right: 30px;" textField="storeName" value=""  valueField="storeId" dataField="wechatStoreData" />
								</td>
							</tr>
							<tr>
								<td class="nui-form-label" colspan="1" style="width: 20%;" >
									<label>标题：</label>
								</td>
								<td colspan="1">
									<input class="nui-textbox tabwidth" name="textTitle" id="textTitle" required="true"/>
								</td>
							</tr>
							<tr>
								<td class="nui-form-label" colspan="1" style="width: 20%;" >
									<label>文本内容：</label>
								</td>
								<td colspan="1">
									<input class="nui-textarea" name="imageTextDescribe" id="imageTextDescribe" style="width:400px;height:100px;" required="true"/>
								</td>
							</tr>
							<tr>
								<td class="nui-form-label" colspan="2" >
									<span style="color:red;" >注：微信回复文字只允许200以内字符！</span>
								</td>
							</tr>
							
						</table>
					</div>
					
			    </div>
			    
			    <div title="图片消息" value="2">
			        <input class="nui-textbox" name="ImageDetailId" id="ImageDetailId" visible="false"/>
			        <input class="nui-textbox" name="imageFodderId" id="imageFodderId" visible="false"/>
			        <div class="form" id="ImageTextMessTwo" name="ImageTextMessTwo" style="height:92%;left:0;right:0;margin: 0 auto;display: flex;">
						<table style="width:100%;margin-left: 30px;border-collapse: separate;border-spacing: 0px 20px;" class="nui-form-table">
							<tr>
								<td class="nui-form-label" colspan="1" style="width: 10%;" >
									<label>门店选择：</label>
								</td>
								<td colspan="2">
									<input id="storeIdImage" name="storeIdImage" class="nui-combobox" required="true" style="margin-right: 30px;" textField="storeName" value=""  valueField="storeId" dataField="wechatStoreData" />
								</td>
							</tr>
							<tr>
								<td class="nui-form-label" colspan="1" style="" >
									<label>标题：</label>
								</td>
								<td colspan="2">
									<input class="nui-textbox tabwidth" name="textTitleImage" id="textTitleImage" required="true"/>
								</td>
							</tr>
							<tr>
								<td class="nui-form-label" colspan="1"  >
									<label>图片：</label>
								</td>
								<td colspan="1">
									<a href="#" class="imgA">
										<div class="divImg" >
											<img id="imgshowOnly" alt="" src="#" class="imgStyle" >
										</div>
									</a>
									<form id="uploadOnly" action="" target="hidden_frameOnly" method="post" enctype="multipart/form-data" style="display:none;" >
										<input id="fileImageOnly" type="file" size="30" accept="image/png,image/jpeg" name="fileselect[]">
										<button type="button" id="fileSubmitOnly" onclick="uploadOnlyFile()" >确认上传文件</button>
									</form>
									<iframe name='hidden_frameOnly' id="hidden_frameOnly" style="display:none;" ></iframe>
								</td>
								<td class="nui-form-label" colspan="1" style="width: 77%;">
									<span style="color:red;" >图片建议尺寸：900像素 * 500像素，其它小图片尺寸：200 x 200像素</span>
								</td>
							</tr>
							
							
						</table>
					</div>
			        
			    </div>
			    <div title="单图文消息" value="3">
			        <input class="nui-textbox" name="imageTextDetailId" id="imageTextDetailId" visible="false"/>
			        <input class="nui-textbox" name="imageTextFodderId" id="imageTextFodderId" visible="false"/>
			        <div class="form" id="ImageTextMessThree" name="ImageTextMessThree" style="height:92%;left:0;right:0;margin: 0 auto;display: flex;">
			        		<!-- 开始 -->
			        		<div class="msg-item-wrapper msg-item-wrapper_only" id="appmsg" data-appid="" data-create-time="" style="">
								<div class="msg-item appmsgItem appmsgItem_only" style="">
									<p class="msg-meta" style=" font-size: 13px; margin: 0 14px 6px;">
										<span class="msg-date"></span>
									</p>
							
									<div class="cover imageCover" style="">
										<p class="default-tip default-tip_only" style="">单图文回复</p>
										<img src="" class="i-img" id="one_pic" style="">
										<ul class="abs tc sub-msg-oprs" style="">
											<li class="b-dib sub-msg-opr-items" style="">
												<a href="javascript:;" class="th icon18 iconEditss" data-rid="1" style="">编辑</a>
											</li>
										</ul>
									</div>
									<span style="color:red;padding-left:13px;" >图片建议尺寸：900像素 * 500像素，其它小图片尺寸：200 x 200像素</span>
									<h4 class="msg-t textTitleOnlys" style="display:none;">
							           <span class="i-title"></span>
							        </h4>
									<p class="msg-text i-desc imageTextDescribeOnly" style="display:none;"></p>
							
								</div>
								<div class="msg-opr" style="display: none;">
									<ul class="f0 msg-opr-list">
										<li class="b-dib opr-item">
											<a class="block tc opr-btn edit-btn" href="">
												<span class="th vm dib opr-icon edit-icon">编辑</span></a>
										</li>
										<li class="b-dib opr-item">
											<a class="block tc opr-btn del-btn" href="javascript:;" data-mid="">
												<span class="th vm dib opr-icon del-icon">删除</span></a>
										</li>
									</ul>
								</div>
								<div class="msg-hover-mask" style=""></div>
								<div class="msg-mask" style="">
									<span class="dib msg-selected-tip" style=""></span>
								</div>
							</div>
			        		<!-- 结束 -->
			        		
			        		<!-- 单图片上传 开始 -->
			        		<div>
				        		<form id="uploadOnlyImageText" action="" target="frameOnlyImageText" method="post" enctype="multipart/form-data" style="display:none;" >
									<input id="fileImageOnlyImageText" type="file" size="30" accept="image/png,image/jpeg" name="fileselect[]">
								</form>
								<iframe name='frameOnlyImageText' id="frameOnlyImageText" style="display:none;" ></iframe>
				        	</div>
			        		<!-- 单图片上传 结束 -->
			        		
			        		
			        		<table style="width:100%;margin-top: 22px;margin-left: 30px;border-collapse: separate;border-spacing: 0px 27px;" class="nui-form-table">
								<tr>
									<td class="nui-form-label" colspan="1" style="width: 10%;" >
										<label>门店选择：</label>
									</td>
									<td colspan="1" style="width: 24%;">
										<input id="storeIdOnly" name="storeIdOnly" class="nui-combobox" required="true" style="margin-right: 30px;" textField="storeName" value=""  valueField="storeId" dataField="wechatStoreData" />
									</td>
									<td class="nui-form-label" colspan="1" style="width: 9%;" >
										<label>标题：</label>
									</td>
									<td colspan="1" style="width: 34%;">
										<input class="nui-textbox tabwidth" name="textTitleOnly" id="textTitleOnly"  required="true"/>
									</td>
								</tr>
								<tr>
									<td class="nui-form-label" colspan="1" style="" >
										<label>图文标题：</label>
									</td>
									<td colspan="1">
										<input class="nui-textbox tabwidth" name="imageTextTitleOnly" id="imageTextTitleOnly" onvaluechanged="OnImageTextTitleOnlychanged" required="true"/>
									</td>
									<td class="nui-form-label" colspan="1" style="" >
										<label>图文作者：</label>
									</td>
									<td colspan="1">
										<input class="nui-textbox tabwidth" name="imageTextAuthorOnly" id="imageTextAuthorOnly" required="true"/>
									</td>
								</tr>
								<tr>
									<td class="nui-form-label" colspan="1" style="" >
										<label>图文摘要：</label>
									</td>
									<td colspan="2">
										<input class="nui-textarea" name="imageTextDescribeOnly" id="imageTextDescribeOnly" onvaluechanged="OnImageTextDescribeOnlychanged" style="width:400px;height:50px;" required="true"/>
									</td>
									<td class="nui-form-label" colspan="1"  >
										<label style="font-size: 12px;">注：图文摘要文字只允许64以内字符！</label>
									</td>
								</tr>
								<tr>
									<td class="nui-form-label" colspan="1" style="" >
										<label>是否打开评论：</label>
									</td>
									<td colspan="1">
										<div id="isOpenCommentOnly" name="isOpenCommentOnly" class="nui-radiobuttonlist" textField="text"  valueField="id" repeatLayout="none" value="1" data='[{"id":1,"text":"打开"},{"id":0,"text":"不打开"}]' />
									</td>
									<td class="nui-form-label" colspan="1" style="" >
										<label>是否粉丝才可评论：</label>
									</td>
									<td colspan="1">
										<div id="isCanCommentOnly" name="isCanCommentOnly" class="nui-radiobuttonlist" textField="text"  valueField="id" repeatLayout="none" value="0" data='[{"id":0,"text":"所有人可评论"},{"id":1,"text":"粉丝才可评论"}]' />
									</td>
								</tr>
								<tr>
									<td class="nui-form-label" colspan="1" style="" >
										<label>原文链接：</label>
									</td>
									<td colspan="3">
										<input class="nui-textbox tabwidth" name="imageTextSourceOnly" id="imageTextSourceOnly" style="width:35%;" />
									</td>
								</tr>
								<tr>
									<td class="nui-form-label" colspan="4" style="" >
										<label>图文内容：</label>
									</td>
								</tr>
								<tr>
									<td colspan="4" style="" >
										<textarea id="container" name="content" style="width:1100px;height:500px;"></textarea>
									</td>
								</tr>
							</table>
							
						</div>
						
			    </div>
			    
			    
			    <div title="多图文消息" value="4" >
			    
					<div class="form" id="ImageTextMessFour" name="ImageTextMessThree" style="height:92%;left:0;right:0;margin: 0 auto;display: flex;">
						<!-- 开始 -->
						<div class="msg-item-wrapper" id="appmsg" data-appid="" data-create-time="">
	
							<div class="msg-item multi-msg">
							
								<div id="appmsgItem1" >
									<p class="msg-meta" style="line-height: 28px;margin: 0 14px;">
										<span class="msg-date" style="line-height: 28px;">2019年02月21日</span>
									</p>
						
									<div class="cover coverMany">
										<p class="default-tip default-tip_Many" style="">多图文回复</p>
										<input type="hidden" id="lanmuid" value="sss">
										<input type="hidden" id="tieziid" value="">
										<input type="hidden" id="wailian" value="">
										<input type="hidden" id="duo_picurl" value="">
										<h4 class="msg-tss" style="">
											<span class="i-titles titlesMany" style="">标题</span>
						                </h4>
										<ul class="abs tc sub-msg-oprs oprs_Many" style="">
											<li class="b-dib sub-msg-opr-items" style="">
												<a href="javascript:;" class="th icon18 iconEditss iconEditssMany" data-rid="1" style="">编辑</a>
											</li>
										</ul>
										<img src="" class="i-img i-imgMany" style="display:none">
									</div>
								</div>
								
								<!-- 开始多图文模板 -->
								<!-- <div class="rel sub-msg-item appmsgItemss" id="appmsgItem2" style="">
									<span class="thumb" style="float: right;font-size: 0;">
						            <span class="default-tipss" style="">缩略图</span>
									<img src="" class="i-img" style="display:none;border: 1px solid #B2B8BD;height: 70px;width: 70px;vertical-align: middle;"></span>
									<input type="hidden" id="lanmuid" value="">
									<input type="hidden" id="tieziid" value="">
									<input type="hidden" id="wailian" value="">
									<input type="hidden" id="duo_picurl" value="">
									<h4 class="msg-ts" style="">
						                <span class="i-title">标题</span>
									</h4>
									<ul class="abs tc sub-msg-opr_detail" style="">
									    <li class="b-dib sub-msg-opr-item_detail" style="">
									        <a href="javascript:;" id="first" class="th icon18 iconEdit_detail" data-rid="2" style="">编辑</a></li>
									    <li class="b-dib sub-msg-opr-item_detail" style="margin-right: 65px;">
									        <a href="javascript:;" class="th icon18 iconDel_detail" data-rid="2">删除</a>
									    </li>
									</ul>
								</div> -->
								<!-- 结束多图文模板 -->
								
								<div class="sub-adds" style="display: block;border-top: 1px solid #C6C6C6;padding: 12px 14px;">
									<a href="javascript:;" class="block tc sub-add-btnss" style="">
										<span class="vm dib sub-add-iconss" style=""></span>增加一条
									</a>
								</div>
								<span style="color:red;padding-left:13px;" >图片建议尺寸：900像素 * 500像素，其它小图片尺寸：200 x 200像素</span>
							</div>
						
							<div class="msg-hover-mask"></div>
							<div class="msg-mask">
								<span class="dib msg-selected-tip"></span>
							</div>
						</div>
						<!-- 结束	 -->
					
						<!-- 多图片上传 开始 -->
		        		<div>
			        		<form id="uploadManyImageText" action="" target="hidden_frameMany" method="post" enctype="multipart/form-data" style="display:none;" >
								<input id="fileImageManyImageText" type="file" size="30" accept="image/png,image/jpeg" name="fileselect[]">
							</form>
							<iframe name='hidden_frameMany' id="hidden_frameMany" style="display:none;" ></iframe>
			        	</div>
		        		<!-- 多图片上传 结束 -->
					
						<!-- 开始 -->
						<div style="display: flex;" >
							<table id="titleTable" style="width:100%;margin-top: 22px;margin-left: 30px;border-collapse: separate;border-spacing: 0px 27px;" class="nui-form-table">
								<tr>
									<td class="nui-form-label" colspan="1" style="width: 10%;" >
										<label>门店选择：</label>
									</td>
									<td colspan="1" style="width: 24%;">
										<input id="storeIdMany" name="storeIdMany" class="nui-combobox" required="true" style="margin-right: 30px;" textField="storeName" value=""  valueField="storeId" dataField="wechatStoreData" />
									</td>
									<td class="nui-form-label" colspan="1" style="width: 9%;" >
										<label>标题：</label>
									</td>
									<td colspan="1" style="width: 34%;">
										<input class="nui-textbox tabwidth" name="textTitleMany" id="textTitleMany"  required="true"/>
									</td>
								</tr>
								<tr>
									<td colspan="4">
										<span style="margin-top: 0px;" class="abs msg-arrow a-out"></span>
			    						<span style="margin-top: 0px;" class="abs msg-arrow a-in"></span>
										<!-- table开始 -->
										<div id="imageTextTalbe" class="tableList" >
											<table id="imageTextDataTemplate" style="width:100%;border-collapse: separate;border-spacing: 0px 20px;" class="nui-form-table nuiTable">
												<tr>
													<td class="nui-form-label" colspan="1" style="width: 10%;" >
														<label>图文标题：</label>
													</td>
													<td colspan="1" style="width: 24%;">
														<input class="nui-textbox tabwidth" name="imageTextTitleMany" id="imageTextTitleMany" onvaluechanged="OnImageTextTitleManychanged('0')" required="true"/>
													</td>
													<td class="nui-form-label" colspan="1" style="width: 9%;" >
														<label>图文作者：</label>
													</td>
													<td colspan="1" style="width: 34%;">
														<input class="nui-textbox tabwidth" name="imageTextAuthorMany" id="imageTextAuthorMany" required="true"/>
													</td>
												</tr>
												<tr>
													<td class="nui-form-label" colspan="1" style="" >
														<label>是否打开评论：</label>
													</td>
													<td colspan="1">
														<div id="isOpenCommentMany" name="isOpenCommentMany" class="nui-radiobuttonlist" textField="text"  valueField="id" repeatLayout="none" value="1" data='[{"id":1,"text":"打开"},{"id":0,"text":"不打开"}]' />
													</td>
													<td class="nui-form-label" colspan="1" style="" >
														<label>是否粉丝才可评论：</label>
													</td>
													<td colspan="1">
														<div id="isCanCommentMany" name="isCanCommentMany" class="nui-radiobuttonlist" textField="text"  valueField="id" repeatLayout="none" value="0" data='[{"id":0,"text":"所有人可评论"},{"id":1,"text":"粉丝才可评论"}]' />
													</td>
												</tr>
												<tr>
													<td class="nui-form-label" colspan="1" style="" >
														<label>原文链接：</label>
													</td>
													<td colspan="3">
														<input class="nui-textbox tabwidth" name="imageTextSourceMany" id="imageTextSourceMany" style="width:35%;" />
													</td>
												</tr>
												<tr>
													<td class="nui-form-label" colspan="4" style="" >
														<label>图文内容：</label>
													</td>
												</tr>
												<tr>
													<td colspan="4" style="" >
														<textarea id="containerMony" name="containerMony" style="width:1050px;height:500px;"></textarea>
													</td>
												</tr>
											</table>
										</div>
										<!-- table结束 -->
									</td>
								</tr>
							</table>
							
							
							
						</div>
						<!-- 结束 -->
						
						
					</div>
					
								
				</div>
				
			
			    
			</div>
			
			
		
	</div>


	<script type="text/javascript">
    	nui.parse();
    	var pathapi=apiPath+wechatApi;
    	var pathweb=webPath+wechatDomain;
    	var messageDivTable=nui.get("messageDivTable");
    	//实例化富文本编辑器
    	var ue = UE.getEditor('container');
    	var ueMany = null;
    	var onlyFileNameString="";
    	var storeIdImage = nui.get("storeIdImage");
    	var storeId = nui.get("storeId");
    	var storeIdOnly = nui.get("storeIdOnly");
    	var storeIdMany = nui.get("storeIdMany");
    	var editBool=true;
    	
    	$(function(){
    		nui.get("imageTextDescribe").setMaxLength(200);
    		nui.get("imageTextDescribeOnly").setMaxLength(64);
    		$("#uploadOnlyImageText").attr("action", pathweb+"/autoServiceSys/weChatMessage/uploadWechatImage.jsp");
    		$("#uploadOnly").attr("action", pathweb+"/autoServiceSys/storeManagement/uploadImage.jsp");
    		storeIdImage.setUrl(pathapi+"/com.hsapi.wechat.autoServiceBackstage.weChatStore.queryWechatStoreList.biz.ext?token="+token);
    		storeIdImage.select(0);
    		storeId.setUrl(pathapi+"/com.hsapi.wechat.autoServiceBackstage.weChatStore.queryWechatStoreList.biz.ext?token="+token);
    		storeId.select(0);
    		storeIdOnly.setUrl(pathapi+"/com.hsapi.wechat.autoServiceBackstage.weChatStore.queryWechatStoreList.biz.ext?token="+token);
    		storeIdOnly.select(0);
    		storeIdMany.setUrl(pathapi+"/com.hsapi.wechat.autoServiceBackstage.weChatStore.queryWechatStoreList.biz.ext?token="+token);
    		storeIdMany.select(0);
		});
		
		//页面间传输json数据
		function setFormData(data) {
			var infos = nui.clone(data);
			nui.get("pageType").setValue(infos.pageType);
			if( infos.pageType == "add" ){
				return;
			}
			editBool=false;
			var imageTextData=infos.imageTextData;
			var paramMap={
				imageTextId:imageTextData.imageTextId
			}
			nui.get("imageTextId").setValue(imageTextData.imageTextId);
			var json=nui.encode({map:paramMap,type:imageTextData.imageTextType});
			nui.ajax({
				url: pathapi+"/com.hsapi.wechat.autoServiceBackstage.weChatImageTextMessage.queryImageTextDetail.biz.ext?token="+token,
				type: 'POST',
				data: json,
				cache: false,
				async: false,
				contentType: 'text/json',
				success: function(text) {
					var imageTextDetailData=text.imageTextDetailData;
					console.log("查询明细",imageTextDetailData);
					
					if(imageTextData.imageTextType == "1"){//文本
						messageDivTable.activeTab(0);
						messageDivTable.removeTab(1);messageDivTable.removeTab(1);messageDivTable.removeTab(1);
						nui.get("storeId").setValue(imageTextData.storeId);
						nui.get("textTitle").setValue(imageTextData.textTitle);
						nui.get("imageTextDescribe").setValue(imageTextDetailData[0].imageTextDescribe);
						nui.get("textDetailId").setValue(imageTextDetailData[0].detailId);
					}else if(imageTextData.imageTextType == "2"){//图片
						messageDivTable.activeTab(1);
						messageDivTable.removeTab(0);messageDivTable.removeTab(1);messageDivTable.removeTab(1);
						nui.get("storeIdImage").setValue(imageTextData.storeId);
						nui.get("textTitleImage").setValue(imageTextData.textTitle);
						$('#imgshowOnly').get(0).src = pathweb+imageTextDetailData[0].fodderPath;
						nui.get("ImageDetailId").setValue(imageTextDetailData[0].detailId);
						nui.get("imageFodderId").setValue(imageTextDetailData[0].fodderId);
					}else if(imageTextData.imageTextType == "3"){//单图文
						messageDivTable.activeTab(2);
						messageDivTable.removeTab(0);messageDivTable.removeTab(0);messageDivTable.removeTab(1);
						nui.get("storeIdOnly").setValue(imageTextData.storeId);
						nui.get("textTitleOnly").setValue(imageTextData.textTitle);
						nui.get("imageTextTitleOnly").setValue(imageTextDetailData[0].imageTextTitle);
						nui.get("imageTextAuthorOnly").setValue(imageTextDetailData[0].imageTextAuthor);
						nui.get("imageTextDescribeOnly").setValue(imageTextDetailData[0].imageTextDescribe);
						nui.get("isOpenCommentOnly").setValue(imageTextDetailData[0].isOpenComment);
						nui.get("isCanCommentOnly").setValue(imageTextDetailData[0].isCanComment);
						nui.get("imageTextSourceOnly").setValue(imageTextDetailData[0].imageTextSource);
						
						nui.get("imageTextDetailId").setValue(imageTextDetailData[0].detailId);
						nui.get("imageTextFodderId").setValue(imageTextDetailData[0].fodderId);
						
						var ue = UE.getEditor('container');
						ue.setContent(imageTextDetailData[0].imageTextContent);
						
						var fileNameArray=imageTextDetailData[0].fodderPath.split("/");
						onlyFileNameString=fileNameArray[fileNameArray.length-1];
						
						$(".default-tip_only").hide();
						$('#one_pic').get(0).src = pathweb+imageTextDetailData[0].fodderPath;
						$(".textTitleOnlys").show();
						$(".textTitleOnlys").find(".i-title").html(imageTextDetailData[0].imageTextTitle);
						$(".imageTextDescribeOnly").show();
						$(".imageTextDescribeOnly").html(imageTextDetailData[0].imageTextDescribe);
				
					}else if(imageTextData.imageTextType == "4"){//多图文
						messageDivTable.activeTab(3);
						messageDivTable.removeTab(0);messageDivTable.removeTab(0);messageDivTable.removeTab(0);
						nui.get("storeIdMany").setValue(imageTextData.storeId);
						nui.get("textTitleMany").setValue(imageTextData.textTitle);
						
						for(var b=0;b<imageTextDetailData.length;b++){
							var indexs=b+"";
							if(b == 0){
								indexs="";
								$(".default-tip_Many").hide();
	    						$(".oprs_Many").find(".sub-msg-oprs").css("left","100%");
								$('.i-imgMany').show();
								$('.i-imgMany').get(0).src = pathweb+imageTextDetailData[b].fodderPath; 
								$('.titlesMany').html(imageTextDetailData[b].imageTextTitle);
								nui.get("imageTextTitleMany").setValue(imageTextDetailData[b].imageTextTitle);
								nui.get("imageTextAuthorMany").setValue(imageTextDetailData[b].imageTextAuthor);
								nui.get("isOpenCommentMany").setValue(imageTextDetailData[b].isOpenComment);
								nui.get("isCanCommentMany").setValue(imageTextDetailData[b].isCanComment);
								nui.get("imageTextSourceMany").setValue(imageTextDetailData[b].imageTextSource);
								var ues = UE.getEditor("containerMony");
								htmlss(ues,imageTextDetailData[b].imageTextContent);
							}else{
								textsss(indexs,imageTextDetailData[b]);
							}
							
						}
						
					}
				}
			});
			//nui.get("pageType").setValue(infos.pageType);
			console.log(infos);
		}
		
		function htmlss(ues,content){
			ues.ready(function() {
				ues.setContent(content);
			});
		}
		
		function textsss(indexs,imageTextDetailData){
			var template=pathweb+"/autoServiceSys/weChatMessage/imageTextMessageTemplate.html";
			$.ajax(template).done(function(template){
				var data={
					indexTemplate:indexTemplate
				}
				var medolHtml= Mustache.render(template,{showMedlHtml:data});
				$("#appmsgItem1").append(medolHtml);
				var imageTextData= Mustache.render(template,{imageTextData:data});
				$("#imageTextTalbe").append(imageTextData);
				$("#uploadManyImageText").append('<input id="fileImageManyImageText'+indexTemplate+'" index="'+indexTemplate+'" type="file" size="30" accept="image/png,image/jpeg" name="fileselect[]">');
				nui.parse();
				eventBind(indexTemplate);
				indexTemplate++;
				$(".thumed"+indexs).hide();
				$('.imageTextImg'+indexs).show();
				$('.imageTextImg'+indexs).get(0).src = pathweb+imageTextDetailData.fodderPath;
				$('.imageTextTitles'+indexs).html(imageTextDetailData.imageTextTitle);
				nui.get("imageTextTitleMany"+indexs).setValue(imageTextDetailData.imageTextTitle);
				nui.get("imageTextAuthorMany"+indexs).setValue(imageTextDetailData.imageTextAuthor);
				nui.get("isOpenCommentMany"+indexs).setValue(imageTextDetailData.isOpenComment);
				nui.get("isCanCommentMany"+indexs).setValue(imageTextDetailData.isCanComment);
				nui.get("imageTextSourceMany"+indexs).setValue(imageTextDetailData.imageTextSource);
				var uess = UE.getEditor("containerMony"+indexs);
				htmlss(uess,imageTextDetailData.imageTextContent);
				editBool=true;
			});
		}
		
		//添加数据
		function save(){
			if( messageDivTable.getActiveTab().title == "文本消息" ){
				var form = new nui.Form("#ImageTextMessOne");
				form.setChanged(false);
    			form.validate();
				if(form.isValid() == false) return;
				var imageTextMainData={
					storeId:nui.get("storeId").getSelected().storeId,
					tenantId:nui.get("storeId").getSelected().tenantId,
					textTitle:nui.get("textTitle").getValue(),
					imageTextType:1,
					imageTextStatus:0,
					isDelete:0
				}
				var imageTextDetailDataArray=[];
				var imageTextDetailData={
					storeId:nui.get("storeId").getSelected().storeId,
					tenantId:nui.get("storeId").getSelected().tenantId,
					imageTextDescribe:nui.get("imageTextDescribe").getValue()
				};
				imageTextDetailDataArray.push(imageTextDetailData);
				
				var urlString="";
				if( nui.get("pageType").getValue() == "add" ){
					 urlString = pathapi+"/com.hsapi.wechat.autoServiceBackstage.weChatImageTextMessage.addTextMessage.biz.ext?token="+token;
				}else if( nui.get("pageType").getValue() == "edit" ){
					imageTextMainData.imageTextId = nui.get("imageTextId").getValue();
					imageTextDetailDataArray[0].detailId = nui.get("textDetailId").getValue();
					urlString = pathapi+"/com.hsapi.wechat.autoServiceBackstage.weChatImageTextMessage.editTextMessage.biz.ext?token="+token;
				}
				var json=nui.encode({imageTextMainData:imageTextMainData,imageTextDetailDataArray:imageTextDetailDataArray,type:1});
				nui.ajax({
					url: urlString,
					type: 'POST',
					data: json,
					cache: false,
					async: false,
					contentType: 'text/json',
					success: function(text) {
						if(text.errCode == "S"){
							CloseWindow("saveSuccess");
						}else{
							CloseWindow("saveFail");
						}
					}
				});
			}else if( messageDivTable.getActiveTab().title == "图片消息" ){
				var form = new nui.Form("#ImageTextMessTwo");
				form.setChanged(false);
    			form.validate();
				if(form.isValid() == false) return;
				var fileImageOnly = $('#fileImageOnly').get(0).files[0];
				if(!fileImageOnly && nui.get("pageType").getValue() == "add"){
					showMsg("请上传图片","W");
					return;
				}
				
				var imageTextMainData={
					storeId:nui.get("storeIdImage").getSelected().storeId,
					tenantId:nui.get("storeIdImage").getSelected().tenantId,
					textTitle:nui.get("textTitleImage").getValue(),
					imageTextType:2,
					imageTextStatus:0,
					isDelete:0
				}
				var imageTextDetailDataArray=[];
				var imageTextDetailData={
					detailId:nui.get("ImageDetailId").getValue(),
					storeId:nui.get("storeIdImage").getSelected().storeId,
					tenantId:nui.get("storeIdImage").getSelected().tenantId
				};
				imageTextDetailDataArray.push(imageTextDetailData);
				
				var fodderData={
					storeId:nui.get("storeIdImage").getSelected().storeId,
					tenantId:nui.get("storeIdImage").getSelected().tenantId,
					fodderTitle:nui.get("textTitleImage").getValue(),
					fodderType:0,
					fodderStater:1
				}
				
				if(fileImageOnly){
					$("#uploadOnly").submit();
					$('#hidden_frameOnly').load(function(){
						var text=$(this).contents().find("body").text();//获得上传之后返回的参数
						var imagerData=nui.decode(text);
						fodderData.fodderPath = imagerData.pictureUrl;
						addEditImagerMessage(imageTextMainData,imageTextDetailDataArray,fodderData);
					});
				}else{
					addEditImagerMessage(imageTextMainData,imageTextDetailDataArray,fodderData);
				}
				
			}else if( messageDivTable.getActiveTab().title == "单图文消息" ){
				var form = new nui.Form("#ImageTextMessThree");
				form.setChanged(false);
				form.validate();
				if(form.isValid() == false) return;
				var fileImageOnlyImageText = $('#fileImageOnlyImageText').get(0).files[0];
				if(!fileImageOnlyImageText && nui.get("pageType").getValue() == "add"){
					showMsg("请上传图文缩略图","W");
					return;
				}
				
				var imageTextMainData={//主表
					storeId:nui.get("storeIdOnly").getSelected().storeId,
					tenantId:nui.get("storeIdOnly").getSelected().tenantId,
					textTitle:nui.get("textTitleOnly").getValue(),
					imageTextType:3,
					imageTextStatus:0,
					isDelete:0
				}
				var imageTextDetailDataArray=[];
				var imageTextDetailData={//从表
					storeId:nui.get("storeIdOnly").getSelected().storeId,
					tenantId:nui.get("storeIdOnly").getSelected().tenantId,
					imageTextTitle:nui.get("imageTextTitleOnly").getValue(),
					imageTextAuthor:nui.get("imageTextAuthorOnly").getValue(),
					imageTextDescribe:nui.get("imageTextDescribeOnly").getValue(),
					imageTextContent:UE.getEditor('container').getContent(),
					isShowCoverPic:0,
					isOpenComment:nui.get("isOpenCommentOnly").getValue(),
					isCanComment:nui.get("isCanCommentOnly").getValue(),
					imageTextSource:nui.get("imageTextSourceOnly").getValue()
				};
				imageTextDetailDataArray.push(imageTextDetailData);
				var fodderData={//素材表
					storeId:nui.get("storeIdOnly").getSelected().storeId,
					tenantId:nui.get("storeIdOnly").getSelected().tenantId,
					fodderTitle:nui.get("imageTextTitleOnly").getValue(),
					fodderType:3,
					fodderStater:1
				}
				
				if(fileImageOnlyImageText){
					$("#uploadOnlyImageText").attr("action", pathweb+"/autoServiceSys/storeManagement/uploadImage.jsp");
					$("#uploadOnlyImageText").submit();
					$('#frameOnlyImageText').load(function(){
						var text=$(this).contents().find("body").text();//获得上传之后返回的参数
						var imagerData=nui.decode(text);
						fodderData.fodderPath=imagerData.pictureUrl;
						addEditImagerTextMessage(imageTextMainData,imageTextDetailDataArray,fodderData);
					});
				}else{
					addEditImagerTextMessage(imageTextMainData,imageTextDetailDataArray,fodderData);
				}
				
			}else if( messageDivTable.getActiveTab().title == "多图文消息" ){
				$('#uploadManyImageText').attr("action", pathweb+"/autoServiceSys/storeManagement/uploadImage.jsp");
				$("#uploadManyImageText").submit();
				$('#hidden_frameMany').load(function(){
					var text=$(this).contents().find("body").text();//获得上传之后返回的参数
					var imagerData=nui.decode(text);
					var imageTextMainData={//主表
						storeId:nui.get("storeIdMany").getSelected().storeId,
						tenantId:nui.get("storeIdMany").getSelected().tenantId,
						textTitle:nui.get("textTitleMany").getValue(),
						imageTextType:4,
						imageTextStatus:0,
						isDelete:0
					}
					var paraDataArray=[];
					for(var a=0;a<$(".appmsgItemss").length+1;a++){
						var imageTextTitleMany="imageTextTitleMany";//图文标题
						var imageTextAuthorMany="imageTextAuthorMany";//图文作者
						var isOpenCommentMany="isOpenCommentMany";//是否打开评论
						var isCanCommentMany="isCanCommentMany";//是否粉丝才可评论
						var imageTextSourceMany="imageTextSourceMany";//原文链接
						var containerMony="containerMony";//图文内容
						if(a!=0){
							var num=Number( $($(".appmsgItemss")[a-1]).attr("index") );
							imageTextTitleMany+=num;
							imageTextAuthorMany+=num;
							isOpenCommentMany+=num;
							isCanCommentMany+=num;
							imageTextSourceMany+=num;
							containerMony+=num;
						}
						var data={
							storeId:nui.get("storeIdMany").getSelected().storeId,
							tenantId:nui.get("storeIdMany").getSelected().tenantId,
							imageTextTitle : nui.get(imageTextTitleMany).getValue(),
							imageTextAuthor : nui.get(imageTextAuthorMany).getValue(),
							isShowCoverPic:0,
							isOpenComment : nui.get(isOpenCommentMany).getValue(),
							isCanComment : nui.get(isCanCommentMany).getValue(),
							imageTextSource : nui.get(imageTextSourceMany).getValue(),
							imageTextContent : UE.getEditor(containerMony).getContent(),
							fodderPath:imagerData[a].pictureUrl
						}
						paraDataArray.push(data);
					
						if( a == $(".appmsgItemss").length ){
							var json=nui.encode({imageTextMainData:imageTextMainData,imageTextDetailDataArray:paraDataArray,type:4});
							nui.ajax({
								url: pathapi+"/com.hsapi.wechat.autoServiceBackstage.weChatImageTextMessage.addImageTextMessageMany.biz.ext?token="+token,
								type: 'POST',
								data: json,
								cache: false,
								async: false,
								contentType: 'text/json',
								success: function(text) {
									if(text.errCode){
										CloseWindow("saveSuccess");
									}else{
										CloseWindow("saveFail");
									}
								}
							});
						}
						
						
					}
					
				});
			}
		}
		
		//添加和编辑单图文
		function addEditImagerTextMessage(imageTextMainData,imageTextDetailDataArray,fodderData){
			var urlString="";
			if( nui.get("pageType").getValue() == "add" ){
				 urlString = pathapi+"/com.hsapi.wechat.autoServiceBackstage.weChatImageTextMessage.addImageTextMessage.biz.ext?token="+token;
			}else if( nui.get("pageType").getValue() == "edit" ){
				imageTextMainData.imageTextId = nui.get("imageTextId").getValue();
				imageTextDetailDataArray[0].detailId = nui.get("imageTextDetailId").getValue();
				fodderData.fodderId = nui.get("imageTextFodderId").getValue();
				urlString = pathapi+"/com.hsapi.wechat.autoServiceBackstage.weChatImageTextMessage.editImageTextMessage.biz.ext?token="+token;
			}
			var json=nui.encode({imageTextMainData:imageTextMainData,imageTextDetailDataArray:imageTextDetailDataArray,type:3,fodderData:fodderData});
			nui.ajax({
				url: urlString,
				type: 'POST',
				data: json,
				cache: false,
				async: false,
				contentType: 'text/json',
				success: function(text) {
					if(text.errCode == "S"){
						CloseWindow("saveSuccess");
					}else{
						CloseWindow("saveFail");
					}
				}
			});
		}
		
		//添加和编辑图文
		function addEditImagerMessage(imageTextMainData,imageTextDetailDataArray,fodderData){
			var urlString="";
			if( nui.get("pageType").getValue() == "add" ){
				 urlString = pathapi+"/com.hsapi.wechat.autoServiceBackstage.weChatImageTextMessage.addImageMessage.biz.ext?token="+token;
			}else if( nui.get("pageType").getValue() == "edit" ){
				imageTextMainData.imageTextId = nui.get("imageTextId").getValue();
				imageTextDetailDataArray[0].detailId = nui.get("ImageDetailId").getValue();
				fodderData.fodderId = nui.get("imageFodderId").getValue();
				urlString = pathapi+"/com.hsapi.wechat.autoServiceBackstage.weChatImageTextMessage.editImageMessage.biz.ext?token="+token;
			}
			var json=nui.encode({imageTextMainData:imageTextMainData,imageTextDetailDataArray:imageTextDetailDataArray,type:2,fodderData:fodderData});
			nui.ajax({
				url: urlString,
				type: 'POST',
				data: json,
				cache: false,
				async: false,
				contentType: 'text/json',
				success: function(text) {
					if(text.errCode == "S"){
						CloseWindow("saveSuccess");
					}else{
						CloseWindow("saveFail");
					}
				}
			});
		}
		
		
		//输入用户信息
		function pushMessagerData(){
			nui.mask({
	            el: document.body,
	            cls: 'mini-mask-loading',
	            html: '推送中...'
	        });
			var userCode=nui.get("userCode").getValue();
			if(!userCode || userCode == ""){
				showMsg("请填写用户微信号！","W");
				return;
			}
			//清空微信号并且隐藏
			nui.get("userCode").setValue("");
			$("#advancedOrgWin").hide();
			var formBool=false;
			if( messageDivTable.getActiveTab().title == "单图文消息" ){
				$("#uploadOnlyImageText").submit();
				$('#frameOnlyImageText').load(function(){
					if(formBool)return;
					var text=$(this).contents().find("body").text();//获得上传之后返回的参数
					var weChatData=nui.decode(text);
					console.log(weChatData);
					formBool=true;
					var form = new nui.Form("#ImageTextMessThree");
					var data=form.getData();
					data.mediaId=weChatData.media_id;
					if(nui.get("pageType").getValue() == "edit" && weChatData){
						data.imagerUrl=$('#one_pic').get(0).src;
						data.imagerName=onlyFileNameString;
	        		}
					data.contentHtml=UE.getEditor('container').getAllHtml();
					var json=nui.encode({paramMap:data,weChatCode:userCode,messAgeType:1});
					$("#advancedOrgWin").hide();
					nui.ajax({
						url: pathapi+"/com.hsapi.wechat.autoServiceBackstage.weChatImageTextMessage.previewImageTextMessage.biz.ext?token="+token,
						type: 'POST',
						data: json,
						cache: false,
						async: false,
						contentType: 'text/json',
						success: function(text) {
							nui.unmask(document.body);
							if(text.errCode){
								showMsg("推送成功，已推送给指定用户预览，请自行查看。","S");
							}else{
								showMsg("推送失败!","E");
							}
						}
					});
				});
			}else if( messageDivTable.getActiveTab().title == "多图文消息" ){
				var bool=false;
				for(var a=0;a<$(".appmsgItemss").length+1;a++){
					var fileImageManyImageText = "#fileImageManyImageText"; //图片
					if(a!=0){
						var num=Number( $($(".appmsgItemss")[a-1]).attr("index") );
						fileImageManyImageText+=num;
					}
					if( $(fileImageManyImageText).get(0).files.length > 0 ) bool=true;
					if(a == $(".appmsgItemss").length){
						if(bool){
							$('#uploadManyImageText').attr("action", pathweb+"/autoServiceSys/weChatMessage/uploadWechatImage.jsp");
							$("#uploadManyImageText").submit();
							$('#hidden_frameMany').load(function(){
								if(formBool)return;
								var text=$(this).contents().find("body").text();//获得上传之后返回的参数
								var weChatData=nui.decode(text);
								console.log(text,weChatData);
								formBool=true;
								pushImagerTextArray(userCode,weChatData);
							});
						}else{
							pushImagerTextArray(userCode,null);
						}
					}
				}
				
				
			}
			
			
		}
		
		
		//推送多图文
		function pushImagerTextArray(userCode,weChatData){
			var paraDataArray=[];
			for(var a=0;a<$(".appmsgItemss").length+1;a++){
				var fileImageManyImageText = "#fileImageManyImageText"; //图片
				var imageTextTitleMany="imageTextTitleMany";//图文标题
				var imageTextAuthorMany="imageTextAuthorMany";//图文作者
				var isOpenCommentMany="isOpenCommentMany";//是否打开评论
				var isCanCommentMany="isCanCommentMany";//是否粉丝才可评论
				var imageTextSourceMany="imageTextSourceMany";//原文链接
				var containerMony="containerMony";//图文内容
				var imageTextImg=".imageTextImg";
				if(a!=0){
					var num=Number( $($(".appmsgItemss")[a-1]).attr("index") );
					imageTextTitleMany+=num;
					imageTextAuthorMany+=num;
					isOpenCommentMany+=num;
					isCanCommentMany+=num;
					imageTextSourceMany+=num;
					containerMony+=num;
					fileImageManyImageText+=num;
					imageTextImg+=num;
				}
				
				var data={
					imageTextTitle : nui.get(imageTextTitleMany).getValue(),
					imageTextAuthor : nui.get(imageTextAuthorMany).getValue(),
					isOpenComment : nui.get(isOpenCommentMany).getValue(),
					isCanComment : nui.get(isCanCommentMany).getValue(),
					imageTextSource : nui.get(imageTextSourceMany).getValue(),
					mediaId : weChatData != null ? weChatData[a].media_id : "",
					container : UE.getEditor(containerMony).getAllHtml()
				}
				if(nui.get("pageType").getValue() == "edit" && $(fileImageManyImageText).get(0).files.length == 0){debugger;
					if(a!=0){
						data.imagerUrl=$(imageTextImg).get(0).src;
					}else{
						data.imagerUrl=$('.i-imgMany').get(0).src;
					}
					data.imagerName="demo.jpg";
    			}
				paraDataArray.push(data);
				if( a == $(".appmsgItemss").length ){
					$("#advancedOrgWin").hide();
					var json=nui.encode({paramDataArray:paraDataArray,weChatCode:userCode,messAgeType:1});
					nui.ajax({
						url: pathapi+"/com.hsapi.wechat.autoServiceBackstage.weChatImageTextMessage.previewlmageTextMessageMany.biz.ext?token="+token,
						type: 'POST',
						data: json,
						cache: false,
						async: false,
						contentType: 'text/json',
						success: function(text) {
							nui.unmask(document.body);
							if(text.errCode){
								showMsg("推送成功，已推送给指定用户预览，请自行查看。","S");
							}else{
								showMsg("推送失败!","E");
							}
						}
					});
				}
			}
		}
		
		//取消隐藏
		function onClose(){
			$("#advancedOrgWin").hide();
			nui.get("userCode").setValue("");
		}
		
		//预览事件
		function preview(){
			$("#advancedOrgWin").show();
		}
		
		//图文点击添加事件
		$(".sub-add-btnss").click(function(){
			if($(".appmsgItemss").length < 7){
				imageTextAddHtml();
			}
		});
		
		var indexTemplate=1;
		var template=pathweb+"/autoServiceSys/weChatMessage/imageTextMessageTemplate.html";
		//多图文的添加
		function imageTextAddHtml(){
			$.ajax(template).done(function(template){
				var data={
					indexTemplate:indexTemplate
				}
				var medolHtml= Mustache.render(template,{showMedlHtml:data});
				$("#appmsgItem1").append(medolHtml);
				var imageTextData= Mustache.render(template,{imageTextData:data});
				$("#imageTextTalbe").append(imageTextData);
				$("#uploadManyImageText").append('<input id="fileImageManyImageText'+indexTemplate+'" index="'+indexTemplate+'" type="file" size="30" accept="image/png,image/jpeg" name="fileselect[]">');
				nui.parse();
				var ue = UE.getEditor('containerMony'+indexTemplate);
				
				eventBind(indexTemplate);
				indexTemplate++;
			});
		}
		
		//多图文绑定事件
		function eventBind(indexs){
			
			$(".imageTextEdit"+indexs).click(function(){
				for(var a=0;a<$(".iconEdit_detail").length;a++){
					if($($(".iconEdit_detail")[a]).attr("index") == $(this).attr("index")){
						var num=a+1;
						$(".nuiTable").hide();
						$("#imageTextDataTemplate"+indexs).show();
						var marTop=258+Number(num-2) * 114;
						var top=254+Number(num-2) * 106;
						$("#imageTextTalbe").css("margin-top",marTop+"px");
						$(".a-out").css("margin-top",(top-1)+"px");
						$(".a-in").css("margin-top",top+"px");
					}
				}
				
			});
			$(".showImageText"+indexs).click(function(){
				console.log("++++");
				$("#fileImageManyImageText"+indexs).click();
				event.stopPropagation();
			});
			
			$("#fileImageManyImageText"+indexs).change(function(){
				var num=$(this).attr("index");
	    		if( $('#fileImageManyImageText'+num).get(0).files.length == 0 ){
	    			$(".imageTextImg"+num).hide();
	    			$(".thumed"+num).show();
	    			return;
	    		}
	    		$(".thumed"+num).hide();
	      		var file = $('#fileImageManyImageText'+num).get(0).files[0];
	      		var reader = new FileReader();
	      		reader.readAsDataURL(file);
	      		reader.onload=function(e){
	      			$(".imageTextImg"+num).show();
		        	$('.imageTextImg'+num).get(0).src = e.target.result;
	      		}
	    	});
	    	
	    	//移动到其面板上
	    	$(".imageTextTemplate"+indexs).mousemove(function(){
				$(this).find(".sub-msg-opr_detail")[0].style.cssText="";
	    	});
	    	//从其面板上移开
	    	$(".imageTextTemplate"+indexs).mouseout(function(){
				$(this).find(".sub-msg-opr_detail").css("left","100%");
	    	});
	    	
	    	//删除面板
	    	$(".imageTextDelete"+indexs).click(function(){
	    		if($(".appmsgItemss").length>1){
	    			var num=$(this).attr("index");
					$(".imageTextTemplate"+num).remove();
					$("#imageTextDataTemplate"+num).remove();
					$("#fileImageManyImageText"+num).remove();
					$(".oprs_Many").click();
	    		}
			});
		}
		
		
		//多图文标题输入事件
		function OnImageTextTitleManychanged(num){
			var nameId="imageTextTitleMany";
			var imageName="titlesMany";
			if(num != "0"){
				nameId+=num;
				imageName="imageTextTitles"+num;
			}
			if( nui.get(nameId).getValue() ){
				$("."+imageName).html(nui.get(nameId).getValue());
			}else{
				$("."+imageName).html("标题");
			}
			
		}
		
		
		
		
		//选择面板事件
		function activechanged(e){
			nui.get("preview").setEnabled(false);//禁用预览按钮
			if(e.index == 2 || e.index == 3){
				nui.get("preview").setEnabled(true);//恢复预览按钮
				var date=new Date();
				$(".msg-date").html(date.getFullYear()+"年"+(date.getMonth()+1)+"月"+date.getDate()+"日");
				$(".msg-item-wrapper_only").height($(".appmsgItem_only").height()+5);//调div框高度
			}
			if(e.index == 3 ){//多图文消息
				//实例化富文本编辑器
    			ueMany = UE.getEditor('containerMony');
    			//多图文的添加
    			if( $(".appmsgItemss").length < 1 && editBool){
    				imageTextAddHtml();
    			}
			}
			console.log(e);
		}
		
			//多图文:移动到选择图片上
			$(".coverMany").mousemove(function(){
				if( $('#fileImageManyImageText').get(0).files.length != 0 || ( $('#fileImageManyImageText').get(0).files.length == 0 && nui.get("pageType").getValue() == "edit" ) ){
					$(".oprs_Many").css("left","0%");
				}
			});
			
			//多图文:移开到选择图片上
			$(".coverMany").mouseout(function(){
				if( $('#fileImageManyImageText').get(0).files.length != 0 || ( $('#fileImageManyImageText').get(0).files.length == 0 && nui.get("pageType").getValue() == "edit" ) ){
					$(".oprs_Many").css("left","100%");
				}
			});
			
											
			//多图文点击事件预览
			$(".default-tip_Many").click(function(){
				$("#fileImageManyImageText").click();
			});
			
			$(".iconEditssMany").click(function(){
				$("#fileImageManyImageText").click();
			});
			
			//填写是否显示
			$(".oprs_Many").click(function(){
				$(".nuiTable").hide();
				$("#imageTextDataTemplate").show();
				$("#imageTextTalbe").css("margin-top","0px");
				$(".a-out").css("margin-top","0px");
				$(".a-in").css("margin-top","0px");
			});
			
			//多图文点击改变的时候触发事件
	    	$('#fileImageManyImageText').change(function(){
	    		if( $('#fileImageManyImageText').get(0).files.length == 0 ){
	    			$(".default-tip_Many").show();
	    		}else{
	    			$(".default-tip_Many").hide();
	    			$(".oprs_Many").find(".sub-msg-oprs").css("left","100%");
					var file = $('#fileImageManyImageText').get(0).files[0];
		      		var reader = new FileReader();
		      		reader.readAsDataURL(file);
		      		reader.onload=function(e){
		      			$('.i-imgMany').show();
			        	$('.i-imgMany').get(0).src = e.target.result;
		      		}
	    		}
	      		
	    	});
    	
		
		//单图文标题
		function OnImageTextTitleOnlychanged(e){
			if(e.value){
				$(".textTitleOnlys").show();
				$(".textTitleOnlys").find(".i-title").html(e.value);
			}else{
				$(".textTitleOnlys").hide();
			}
			$(".msg-item-wrapper_only").height($(".appmsgItem_only").height()+5);//调div框高度
		}
		
		//单图文摘要，描述
		function OnImageTextDescribeOnlychanged(e){
			if(e.value){
				$(".imageTextDescribeOnly").show();
				$(".imageTextDescribeOnly").html(e.value);
			}else{
				$(".imageTextDescribeOnly").hide();
			}
			$(".msg-item-wrapper_only").height($(".appmsgItem_only").height()+5);//调div框高度
		}
		
		//单图文:移动到选择图片上
		$(".imageCover").mousemove(function(){
			if( $('#fileImageOnlyImageText').get(0).files.length != 0 ){
				$(".imageCover").find(".sub-msg-oprs").css("left","0%");
			}
		});
		
		//单图文:移开到选择图片上
		$(".imageCover").mouseout(function(){
			if( $('#fileImageOnlyImageText').get(0).files.length != 0 ){
				$(".imageCover").find(".sub-msg-oprs").css("left","100%");
			}
		});
		
										
		//单图文点击事件预览
		$(".imageCover").click(function(){
			$("#fileImageOnlyImageText").click();
		});
		
		//单图文点击改变的时候触发事件
    	$('#fileImageOnlyImageText').change(function(){
    		if( $('#fileImageOnlyImageText').get(0).files.length == 0 ){
    			$(".default-tip_only").show();
    		}else{
    			$(".imageCover").find(".sub-msg-oprs").css("left","100%");
    			$(".default-tip_only").hide();
    			var file = $('#fileImageOnlyImageText').get(0).files[0];
	      		var reader = new FileReader();
	      		reader.readAsDataURL(file);
	      		reader.onload=function(e){
		        	$('#one_pic').get(0).src = e.target.result;
	      		}
    		}
      		
    	});
		
    	//图片选择预览
		$(".imgA").click(function(){
			$("#fileImageOnly").click();
		});
		
		//在input file内容改变的时候触发事件
    	$('#fileImageOnly').change(function(){
    		if( $('#fileImageOnly').get(0).files.length == 0 ){
    			$("#imgshowOnly").attr("src", pathweb+"/autoServiceSys/images/add_img.png");
    			return;
    		}
    		//获取input file的files文件数组;$('#filed')获取的是jQuery对象，.get(0)转为原生对象;这边默认只能选一个，但是存放形式仍然是数组，所以取第一个元素使用[0];
      		var file = $('#fileImageOnly').get(0).files[0];
    		//创建用来读取此文件的对象
      		var reader = new FileReader();
    		//使用该对象读取file文件
      		reader.readAsDataURL(file);
    		//读取文件成功后执行的方法函数
      		reader.onload=function(e){
	    		//读取成功后返回的一个参数e，整个的一个进度事件
	        	console.log(e);
	        	if(nui.get("pageType").getValue() == "edit"){
	        		headBoolean=true;
	        	}
	    		//选择所要显示图片的img，要赋值给img的src就是e中target下result里面的base64编码格式的地址
	        	$('#imgshowOnly').get(0).src = e.target.result;
      		}
    	});
    	
		
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