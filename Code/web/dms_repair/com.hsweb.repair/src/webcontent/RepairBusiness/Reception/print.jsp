<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false" %>
	
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<!-- 
  - Author(s): localhost
  - Date: 2018-09-07 18:52:38
  - Description:
-->
<head>
<title>Title</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
    <script src="<%= request.getContextPath() %>/common/nui/nui.js" type="text/javascript"></script>
</head>
<style type="text/css">
 <style>
 
        * {
            margin: 0;
            padding: 0;
        }

        ul, li, dl, dt, dd, ol {
            list-style: none;
        }

        sup {
            vertical-align: text-top;
        }

        sub {
            vertical-align: text-bottom;
        }

        legend {
            color: #000;
        }

        fieldset, img {
            border: 0;
        }

        button, input, select, textarea {
            font-size: 100%;
        }
        /*table { border-collapse: collapse; border-spacing: 0; }*/
        body {
            position: relative;
        }

        .cf:after {
            clear: both;
            content: ".";
            display: block;
            height: 0;
            overflow: hidden;
            visibility: hidden;
        }

        .cf {
            *zoom: 1;
        }

        .dn {
            display: none;
        }

        .fl {
            float: left;
        }

        .fr {
            float: right;
        }

        .mr0 {
            margin-right: 0 !important;
        }

        .mrb {
            margin-right: 10px;
        }

        .mr10 {
            margin-right: 10px;
        }

        .mb10 {
            margin-bottom: 10px;
        }

        .mb20 {
            margin-bottom: 20px;
        }

        .tc {
            text-align: center;
        }

        .tr {
            text-align: right;
        }

        .es {
            white-space: nowrap;
            overflow: hidden;
            text-overflow: ellipsis;
        }

        .fb {
            font-weight: bold !important;
        }

        .pr {
            position: relative;
        }

        .pa {
            position: absolute;
        }

        .red {
            color: #F00;
        }

        .vm {
            vertical-align: middle;
        }

        .f14 {
            font-size: 14px;
        }

        .fwn {
            font-weight: normal !important;
        }

        /* display */
        .dn {
            display: none;
        }

        .di {
            display: inline;
        }

        .db {
            display: block;
        }

        .dib {
            display: inline-block;
        }

        .h14 {
            height: 14px;
        }

        .h16 {
            height: 16px;
        }

        .h18 {
            height: 18px;
        }

        .h20 {
            height: 20px;
        }

        .h22 {
            height: 22px;
        }

        .h24 {
            height: 24px;
        }

        .h40 {
            height: 40px;
        }

        .h60 {
            height: 60px;
        }

        .h80 {
            height: 80px;
        }

        .h100 {
            height: 100px;
        }

        /* zoom */
        .z {
            *zoom: 1;
        }

        #print-container {
            padding: 0 5px;
        }

            #print-container h5 {
                font-size: 14px;
            }

        .company-info {
        }

            .company-info h3 {
                font-size: 16px;
                padding: 10px 0 8px 5px;
                border-bottom: 1px solid #333;
            }

        #title {
            font-size: 24px;
            margin: 15px 0 10px;
            font-weight: 800;
            text-align: center;
        }

        .table {
            width: 100%;
            max-width: 100%;
            border-spacing: 0;
            border-collapse: collapse;
            background-color: transparent;
        }

            .table thead td {
                line-height: 20px;
                font-weight: bold;
            }

        hr {
            margin: 4px 0;
            border: 0;
            border-top: 1px solid #333;
            border-bottom: 1px solid #ffffff;
        }

        td.left, th.left {
            text-align: left;
        }

        td.center, th.center {
            text-align: center;
        }

        td.right, td.right {
            text-align: right;
        }

        .table-header {
            padding-bottom: 3px;
            margin: 10px 0 2px;
        }

            .table-header h3, .table-header h4 {
                text-align: left;
                padding-left: 5px;
                font-size: 14px;
            }

        .tlist td {
            line-height: 18px;
            font-size: 12px;
            padding: 0 0 0 3px;
            border: 1px solid #333;
        }

        .noborder td {
            border: none !important;
        }

        .theader td {
            font-size: 12px;
        }

        .tfooter td {
            padding: 0px;
            font-size: 12px;
        }

        [contenteditable="true"].single-line {
            white-space: nowrap;
            min-width: 200px;
            overflow: hidden;
        }

            [contenteditable="true"].single-line br {
                display: none;
            }

            [contenteditable="true"].single-line * {
                display: inline;
                white-space: nowrap;
            }

        .print-btn {
            display: block;
            position: fixed;
            width: 100px;
            height: 30px;
            line-height: 30px;
            background-color: #d9d9d9;
            color: #333;
            text-align: center;
            top: 15px;
            right: 25px;
        }

            .print-btn:hover {
                background-color: #ccc;
            }

        table, td {
            font-family: Tahoma, Geneva, sans-serif;
            font-size: 12px;
            color: #000;
        }

        .print_btn {
            text-align: center;
            width: 100%;
            padding: 30px 0 0 0;
        }

            .print_btn a {
                width: 160px;
                height: 42px;
                display: inline-block;
                background: #578ccd;
                line-height: 42px;
                border-radius: 5px;
                color: #fff;
                font-size: 18px;
                text-decoration: none;
                margin: 0 10px;
            }

                .print_btn a:hover, .print_btn a:active {
                    background: #df0024;
                }

        .sminput {
            width: 640px;
            height: 40px;
            border: 1px #b4b4b4 solid;
            float: left;
            font-size: 16px;
            font-family: "微软雅黑";
        }

        .smbottom {
            width: 50px;
            height: 44px;
            background: #c8c8c8;
            border: 0;
            border-radius: 5px;
            margin-left: 5px;
        }

        .xgsm {
            width: 700px;
            margin: 0 auto;
            display: none;
        }
    </style>
<body>
	 <div class="print_btn">
        <a id="print" href="javascript:void(0)">打印</a>
    </div>
    <div id="print-container">
        <div class="company-info">
            <h3>易维天下</h3>
             <input name="serviceTypeId"
                        id="serviceTypeId"
                        class="nui-combobox width1"
                        textField="name"
                        valueField="id"
                        emptyText="请选择..."
                        url=""
                        allowInput="true"
                        showNullItem="false"
                        valueFromSelect="true"
                        nullItemText="请选择..."/ visible="false">
        </div>
        <h1 id="title">派工单</h1>
        <div class="content">
            <h5>单据编号:1809070021</h5>
            <hr />
            <table width="100%" border="0" cellpadding="0" cellspacing="0" class="table theader">
                <tbody>
                    <tr>
                        <td class="left" width="33.3%">客户名称：方先生</td>
                        <td class="left" width="33.3%">车牌号：赣H9J468</td>
                            <td class="left">联系电话：137****679</td>
                    </tr>
                    <tr>
                        <td class="left">车型： </td>
                        <td class="left">公里数：</td>
                        <td class="left">服务顾问：方银辉</td>
                    </tr>
                    <tr>
                        <td class="left">VIN：LFMAP86C3E0458796</td>
                        <td class="left">进厂时间：<span class="left" style="width: 33.33%">2018-09-07 09:05</span></td>
                        <td class="left">预计完工时间：</td>
                    </tr>
                </tbody>
            </table>
            <hr />
            <h5 style="padding-top: 20px;">施工项目</h5>
            <div style="padding: 10px 0">
                <table width="100%" border="0" cellpadding="0" cellspacing="0" class="table tlist mt10" style="table-layout: fixed;">
                    <tbody>
                        <tr>
                            <td width="30" height="35" align="center">序号</td>
                            <td width="200" align="center">工时名称</td>
                            <td align="center" width="150">业务类型</td>
                            <td align="center"width="200">施工员</td>
                            <td align="center"width="300">备注</td>
                            <td align="center" width="150">签字</td>
                        </tr>
                        <tbody id="tbodyId">
						</tbody>
                    </tbody>
                </table>
            </div>
            <table width="100%" border="0" cellpadding="0" cellspacing="0" class="table theader" style="margin-top: 15px;">
                <tbody>
                    <tr>
                        <td width="50%" height="30" class="left" style="font-size: 14px;">质检员：</td>
                        <td class="left" width="50%" style="font-size: 14px;">质检员签字：</td>
                    </tr>
                </tbody>
            </table>
            <hr />
            <table class="table theader" style="margin-top: 5px">
                <tbody>
                    <tr>
                        <td height="40">故障描述：</td>
                    </tr>
                    <tr>
                        <td style="width: 25%">备注：</td>
                    </tr>
                </tbody>
            </table>
        </div>
    </div>
	<script type="text/javascript">
    	nui.parse();
    	var params = {};
    	
		var servieTypeList = [];
		var servieTypeHash = {};

    	$(document).ready(function (){
    		 $("#print").click(function () {
	            $(".print_btn").hide();
	            window.print();
	         });
    	    initServiceType("serviceTypeId",function(data) {
		        servieTypeList = nui.get("serviceTypeId").getData();
		        servieTypeList.forEach(function(v) {
		            servieTypeHash[v.id] = v;
		        });
		        var tBody = $("#tbodyId");
	    				tBody.empty();
	    				var tds = '<td align="center">[id]</td>' +
		    			"<td align='center'>[itemName]</td>"+
		    			"<td align='center'>[serviceTypeId]</td>"+ 
		    			"<td align='center'>[workers]</td>"+
		    			"<td align='center'></td>"+
		    			"<td align='center'></td>";
    		var p = {
                            interType: "item",
                            data:{
                                serviceId: "842"
                            }
                        }
    		getBillDetail(p, function(text){
	            var errCode = text.errCode;
	            var data = text.data||[];
	            if(errCode == "S"){
	            	for(var i = 0 , l = data.length ; i < l ; i ++){
	            	    var serviceTypeId = data[i].serviceTypeId;
	            	    if(servieTypeHash[serviceTypeId]){
	            	    	serviceTypeId = servieTypeHash[serviceTypeId].name;
	            	    }else{
	            	    	serviceTypeId = ""
	            	    }
	            		var tr = $("<tr></tr>");
				    			tr.append(
				    				tds.replace("[id]",i +1)
				    				.replace("[itemName]",data[i].itemName)
				    				.replace("[serviceTypeId]",serviceTypeId)
				    				.replace("[workers]",data[i].workers));
				    			tBody.append(tr);
	            	}
	            }
	        }, function(){});
		    });
    		
    	}); 
    </script>
</body>
</html>