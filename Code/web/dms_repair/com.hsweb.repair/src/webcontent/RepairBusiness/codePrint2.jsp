<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@include file="/common/commonRepair.jsp"%>
<html>

<!-- 
  - Author(s): localhost
  - Date: 2018-09-07 23:33:56
  - Description:
-->
<head>
<title>打印二维码</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
    <script src="<%= request.getContextPath() %>/repair/RepairBusiness/Reception/js/jquery-1.8.3.min.js" type="text/javascript"></script>
    <script src="<%=request.getContextPath()%>/repair/RepairBusiness/Reception/js/date.js"  type="text/javascript"></script>
</head>
<body onafterprint="CloseWindow('ok')" oncontextmenu = "return false">
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
		#title1 {
            font-size: 24px;
            margin: 15px 0 10px;
            font-weight: 800;
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
            margin: 8px 0;
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

       .imgListA{
	    	display: flex;
	    	border-bottom: 2px solid #f2f5f7;
	    	cursor: pointer;
	    	width:150px;
	    	height: 100px;
	    	display:inline-block;
	    }
 @media print {
        @page 
        {
          size: auto;
          margin: 0mm;
        }
        body
        {
          background-color:#FFFFFF; 
          margin: 0px;
        }
        .print { display:block; }
        .nprint { display:none; }
        div#printBody ul li {
          float: left;
          width: 100%;
          text-align: center;
          padding: 20px 0;
          position: relative;
        }
        div#printBody ul li img {
          width: 80%;
        }
      }
      body {
        margin: 0;
        padding: 0;
      }
      #printBody {
        float: left;
        overflow: hidden;
      }
      #printBody ul {
        list-style: none;
        padding: 9% 0 0 0;
        margin: 0;
        float: left;
      }
      #printBody ul li {
        /* float: left; */
        /* width: 13%; */
        /* text-align: center; */
        /* padding: 1% 10%; */
        /* margin-top: 4.2%; */
      }
      #printBody ul li.nomar {
        /* margin-top: 0; */
      }
      #printBody ul li img {
        width: 100%;
      }
      #printBody ul li p {
        padding: 0;
        margin: 0;
      }	         
    </style>
    <div class="print_btn">
        <a id="print" href="javascript:void(0)" style="background: #ff6600;">打印</a>
        <a id="" href="javascript:void(0)" onclick="CloseWindow('cancle')">取消</a>
    </div>
    <div id="photos" class="nprint" style="width:90%; display:block;word-break: break-all;word-wrap: break-word;">


   	</div>
	<div class="print" id="printBody"></div>


	<script type="text/javascript">
	$(document).ready(function (){
		$("#print").click(function () {
            $(".print_btn").hide();
            window.print();
        });
        document.onkeyup = function(event) {
	        var e = event || window.event;
	        var keyCode = e.keyCode || e.which;// 38向上 40向下
	        
	
	        if ((keyCode == 27)) { // ESC
	            CloseWindow('cancle');
	        }
	
	    }
	});	
	
	
	function CloseWindow(action) {
            if (window.CloseOwnerWindow) return window.CloseOwnerWindow(action);
            else window.close();
        }
	function setData(codeList){
		for(var i =0;i<codeList.length;i++){		
			var html=imageHtml(codeList[i].img,codeList[i].name);
		    $(".photos").before(html);
/* 		    var html2=imageHtml2(codeList[i].img,codeList[i].name);
		    $(".printBody").before(html2); */
		}
	}

	function imageHtml(imageUrl,name){    
		var html="";
		html+='		<div  style="width:250px;height: 270px;float: left;" >';
		html+='			<img style="width:150px;height: 150px;    margin-left: 50px;" id=""  alt="" src="'+imageUrl+'"  >';
		html+='			<p style="text-align: center;color: black;">'+name+'</p>'		
		html+='		</div>';
	
		return html;
	};
	function imageHtml2(imageUrl,name){    
		var html="";
		html+='		<div  style="width:100%;height: 100%;" >';
		html+='			<img style="width:100%;height: 90%; src="'+imageUrl+'"  >';
		html+='			<p style="text-align: center;color: black;">'+name+'</p>'		
		html+='		</div>';
	
		return html;
	};
    </script>
</body>