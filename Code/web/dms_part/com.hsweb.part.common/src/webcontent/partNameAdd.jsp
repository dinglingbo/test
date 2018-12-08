<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false" %>
<%@include file="/common/commonPart.jsp"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<!-- 
  - Author(s): Administrator
  - Date: 2018-12-05 18:59:04
  - Description:
-->
<head>
<title>配件名称申请</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
    
    <style type="text/css">
	table{
   		margin-left:20px;
   	}
   	td{
   		padding-top:3px;
   	}
    </style>
</head>
<body>
	<div class="nui-toolbar" style="padding:2px;border-bottom:0;">
	    <table style="width:100%;">
	        <tr>
                <td style="width:80%;">
					<a class="nui-button" iconCls="" plain="true" onclick="onOk()"><span class="fa fa-save fa-lg"></span>&nbsp;保存</a>
                    <a class="nui-button" iconCls="" plain="true" onclick="CloseWindow('cancle')"><span class="fa fa-close fa-lg"></span>&nbsp;取消</a>
                </td>
            </tr>
	    </table>
	</div>
	
	<div class="nui-fit">
		<div id="form" class="nui-form" style="width:100%; height:100%;">
	        <table style="width:90%;">
		        <tr>
					<td  style="padding-left:25px">标准名称:<input  class="nui-textbox" id="namestd" name="namestd" type="text" width="75%"></td>
		        </tr>
		         <tr>
					<td style="padding-left:50px">别名:<input  class="nui-textbox" id="namecn" name="namecn" type="text" width="80%"></td>
		        </tr>
		        <tr>
					<td>配件一级分类:<input  popupHeight="90%" class="nui-combobox" id="cartypef" name="cartypef" type="text" width="70%"></td>
		        </tr>
		        <tr>
					<td>配件二级分类:<input  popupHeight="90%" class="nui-combobox" id="cartypes" name="cartypes" type="text" width="70%"></td>
		        </tr>
		        <tr>
					<td>配件三级分类:<input popupHeight="90%" class="nui-combobox" id="cartypet" name="cartypet" type="text" width="70%"></td>				
		        </tr>
		        <tr>
					<td style="padding-left:25px">补充说明:<input  class="nui-textbox" id="direction" name="direction" type="text" width="75%"></td>				
		        </tr>
		        <tr>
		        	<td>(方向方位等其他补充)</td>
		        </tr>
		    </table>
    	</div>
	</div>

	<script type="text/javascript">
    	nui.parse();
    	var form=null;
    	var partTypeList=[];
    	var typeHash={};
		$(document).ready(function(){
    		form = new nui.Form("#form");
    		nui.get('namestd').focus();
    		getAllPartType(function(data) {
		        partTypeList = data.partTypes;
		        partTypeList.forEach(function(v) {
		            typeHash[v.id] = v;
		        });
		        console.log(typeHash);
		    });	
		     document.onkeyup = function(event) {
		        var e = event || window.event;
		        var keyCode = e.keyCode || e.which;// 38向上 40向下
		        
		
		        if ((keyCode == 27)) { //ESC
		            CloseWindow('cancle');
		        }
		    }
	   });
    	 
    	function CloseWindow(action){
			    if (window.CloseOwnerWindow) return window.CloseOwnerWindow(action);
			    else window.close();
			}
    	function SetData(params){
    		nui.get('namestd').setValue(params.namestd);
    		nui.get('namestd').focus();
    	}
    </script>
</body>
</html>