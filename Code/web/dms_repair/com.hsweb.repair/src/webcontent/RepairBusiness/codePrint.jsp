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
        #printBody { display:block; }
        #photos { display:none; }
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
	 /*打印高度的设置*/
	@media print {
	    html, body {
	        height: inherit;
	    }
	    #query-table {
	        height: inherit;
	    }
	    #queryTable {
	        height: inherit !important;
	
	    }
	    @page {
	      size: auto;  /* auto is the initial value */
	      margin: 0mm; /* this affects the margin in the printer settings */
	    }
	} 
	<style media="print">//这表示是在打印时的样式 .noprint { display: none;font-size:19px;COLOR: blue; } </style>
<style media="screen"> //这表示是在屏幕显示时的样工 .print {font-size:19px;COLOR: red; } </style>   
    </style>
    <div class="print_btn">
        <a id="print" href="javascript:void(0)" style="background: #ff6600;">打印</a>
        <a id="" href="javascript:void(0)" onclick="CloseWindow('cancle')">取消</a>
    </div>
    <div id="photos" class="noprint">



   	</div>
	<div  id="printBody"  class="print" style="display:none !important;width:100%;height: 100%;"></div>

	<script type="text/javascript">
	$(document).ready(function (){
		$("#print").click(function () {
            $(".print_btn").hide();
            document.getElementById('printBody').style.display="";
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
	var str = "";
	var str2 = ""
		for(var i =0;i<codeList.length;i++){		
			str =str + imageHtml(codeList[i].img,codeList[i].name);
			str2 =str2 + imageHtml2(codeList[i].img,codeList[i].name);
		}
			document.getElementById('photos').innerHTML=str;
			document.getElementById('printBody').innerHTML=str2;	    
	}

	function imageHtml(imageUrl,name){    
		var html="";
		html+='		<div class="webPrint" style="width:250px;height: 270px;float: left;page-break-after:always;" >';
		html+='			<img style="width:150px;height: 150px;    margin-left: 50px;" id=""  alt="" src="'+imageUrl+'"  >';
		html+='			<p style="text-align: center;color: black;">'+name+'</p>'		
		html+='		</div>';
	
		return html;
	};
	function imageHtml2(imageUrl,name){    
		var html="";
		html+='		<div class="webPrint" style="width:90%;height: 90%;float: left;page-break-after:always;" >';
		html+='			<img style="width:90%;height: 88%;    margin-left: 50px;" id=""  alt="" src="'+imageUrl+'"  >';
		html+='			<p style="text-align: center;color: black;">'+name+'</p>'		
		html+='		</div>';
	
		return html;
	};
    </script>
</body>