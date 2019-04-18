<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false" %>
<%@ include file="/common/sysCommon.jsp"%>	
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<!-- 
  - Author(s): Administrator
  - Date: 2019-03-07 12:12:17
  - Description:
-->
<head>
<title>费用报销单</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
    <script src="<%= request.getContextPath() %>/common/nui/nui.js" type="text/javascript"></script>
	<script src="<%=request.getContextPath()%>/repair/RepairBusiness/Reception/js/numberFormat.js"  type="text/javascript"></script>  
</head>
<style>
	        table, td {
	            font-family: Tahoma,Geneva,sans-serif;
	            font-size: 14px;
	            color: #000;
	        }

            table.ybk {
                width: 100%;
                max-width: 100%;
                border-spacing: 0;
                border-collapse: collapse;
                background-color: transparent;
            }
			table.ybk1 {
                width: 100%;
                max-width: 100%;
                border: 1px solid #151515;
                background-color: transparent;
            }
            
            table.ybk2 {
                border-top:#FF0000 solid 1px;
            }
            
            table.ybk td {
                border: 1px solid #000;
            }

	        .print_btn {
	            text-align: center;
	            width: 100%;
	            padding: 30px 0 20px 0;
	            border:0px solid red; 
	        }

            .print_btn a {
                width: 160px;
                height: 42px;
                display: inline-block;
                background: #578ccd;
                line-height: 42px;
                border-radius: 5px;
                color: #fff;
                font-size: 16px;
                text-decoration: none;
                margin: 0 10px;
            }

            .print_btn a:active, .print_btn a:hover {
                background: #df0024;
            }

        .sminput {
            width: 640px;
            height: 40px;
            border: 1px #b4b4b4 solid;
            float: left;
            font-size: 14px;
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
            width: 720px;
            margin: 0 auto;
            display: none;
        }

        .jsxx {
            color: #000;
            padding-bottom: 15px;
        }

            .jsxx h3 {
                color: #000;
                font-size: 13px;
                font-weight: 700;
                height: 26px;
                border-bottom: 1px #000 solid;
            }

            .jsxx ul {
                padding-top: 6px;
            }

                .jsxx ul li {
                    color: #000;
                }

        .renyuan {
            height: 40px;
            line-height: 40px;
            width: 97%;
            margin: 0 auto;
        }

            .renyuan li {
                width: 33%;
                float: left;
            }

        .myddc dd, .myddc dt {
            float: left;
            margin-right: 30px;
        }

            .myddc dd font {
                display: block;
                float: left;
                width: 12px;
                height: 12px;
                border: 1px #000 solid;
                margin: 4px 5px 0 0;
            }
    </style>
<body ><!-- oncontextmenu = "return false" -->
<div class="boxbg" style="display:none"></div>
<input  class="nui-combobox" name="carBrandId" id="carBrandId"  valueField="id" textField="name"width="100%" visible="false"/>
    <div class="print_btn">
        <a id="print" href="javascript:void(0)" style="background: #ff6600;">打印</a>
        <a id="print" href="javascript:void(0)" onclick="CloseWindow('cancle')">取消</a>
    </div>
        <div style="padding-top:5px ;" align="center">
            <h2 id="currRepairSettorderPrintShow"></h2>
            <h3>费&nbsp;&nbsp;用&nbsp;&nbsp;报&nbsp;&nbsp;销&nbsp;&nbsp;单</h3>
        </div>
        <div style="margin: 0 2px;" class="printny">
        <div class="company-info">
            <table  width="100%" border="0" cellspacing="0" cellpadding="0">
	            <tbody>
	            	<tr>
	            		<td colspan="2" align="right">
	            			№:<span id="rpAccountId"></span>
	            		</td>
	            	</tr>
	                <tr>
	                	<td >
                                部门：<span id=""></span>  
                        </td>
                        <td style="width: auto;" align="right">
                                日期：<span id="date"></span>  
	                	</td>
	                </tr>
	            </tbody>
	        </table>
	        
        </div>
        
        <div style="padding-top: 10px;">
            <table  width="100%" border="0" cellspacing="0" cellpadding="0" class="ybk">
                <tr>
                    <td align="center" bgcolor="#f8f8f8" style="font-family: 微软雅黑; font-size:16px;font-weight: bold;width: 25%">
                        摘要
                    </td>
                    <td align="center" bgcolor="#f8f8f8" style="font-family: 微软雅黑; font-size:16px;font-weight: bold;width: 16%">
                        收支类别
                    </td>
                    <td align="center" bgcolor="#f8f8f8" style="font-family: 微软雅黑; font-size:16px;font-weight: bold;width: 16%">
                        数量
                    </td>
                    <td align="center" bgcolor="#f8f8f8" style="font-family: 微软雅黑; font-size:16px;font-weight: bold;width: 16%">
                        单价
                    </td>
                    <td align="center" bgcolor="#f8f8f8" style="font-family: 微软雅黑; font-size:16px;font-weight: bold;width: 16% ">
                        金额
                    </td>
                </tr>
                <tbody id="tbodyId">
                </tbody>
                <tr>
                    <td colspan="2">
                        <font style="font-size: 16px; font-weight: bold;">
                                &nbsp;&nbsp;共计金额：<span id="money"></span>
                        </font>
                    </td>
                    <td colspan="2" align="right">
                        <font style="font-size: 16px; font-weight: bold;">
                                &nbsp;&nbsp;小写金额：
                        </font>
                    </td>
                    <td align="left">
                        <font style="font-size: 16px; font-weight: bold;">
                            &nbsp;&nbsp;<span id="cash">0</span>元
                        </font>
                    </td>
                </tr>
                <tr>
                    <td>
                            &nbsp;&nbsp;收款人：<span></span>
                    </td>
                    <td align="right" style="width:10%">
                            &nbsp;&nbsp;制单：
                    </td>
                    <td colspan="3">

                    </td>
                </tr>
                <tr>
                    <td>
                    	&nbsp;&nbsp;审批人：
                    </td>
                    <td>
                    	&nbsp;&nbsp;审核人：
                    </td>
                    <td>
                    	&nbsp;&nbsp;证明人：
                    </td>
                    <td colspan="2">
                    	&nbsp;&nbsp;经手人：
                    </td>
                </tr>
                <tr>
                    <td>
                    	&nbsp;&nbsp;董事长：
                    </td>
                    <td>
                    	&nbsp;&nbsp;财务经理：
                    </td>
                    <td>
                    	&nbsp;&nbsp;财务主管：
                    </td>
                    <td colspan="2">
                    	&nbsp;&nbsp;支出人（收纳）：
                    </td>
                </tr>
            </table>
        </div>
    </div>
    <script type="text/javascript">
             nui.parse();
             var arr = [];
			 $(document).ready(function (){
                showtime("date");
	 			$("#print").click(function () {
		            $(".print_btn").hide();
		            $(".print_hide").hide();
		            
		            window.print();
		        }); 
			 });
             
             function SetData(data,IClist){
                arr = data;
                var tBody = $("#tbodyId");
                tBody.empty();
                document.getElementById("currRepairSettorderPrintShow").innerHTML = currRepairSettorderPrintShow;
                var tds = '<td align="center">[remark]</td>' +
						    			"<td align='center'>[billTypeId]</td>"+
						    			"<td align='center'>[number]</td>"+ 
						    			"<td align='center'>[charOffAmt]</td>"+
                                        "<td align='center'>[charOffAmt1]</td>";
                for(var i = 0 , l = arr.length ; i < l ; i++){
                	if( i == 0){
                		document.getElementById("rpAccountId").innerHTML = arr[i].rpAccountId;
                	}
                    var tr = $("<tr></tr>");
                    var name = null;
                    for(var j = 0 ; j < IClist.length ; j++){
                        if(IClist[j].id == arr[i].billTypeId){
                            name = IClist[j].name;
                            break;
                        }
                    }
                    document.getElementById("cash").innerHTML = parseFloat(document.getElementById("cash").innerHTML) + parseFloat(arr[i].charOffAmt);
                    tr.append(
                                tds.replace("[remark]",arr[i].remark || "")
                                .replace("[billTypeId]",name || "")
                                .replace("[number]",1)
                                .replace("[charOffAmt]",arr[i].charOffAmt || "")
                                .replace("[charOffAmt1]",data[i].charOffAmt || ""));
                            tBody.append(tr); 
                }

                document.getElementById("money").innerHTML = transform(document.getElementById("cash").innerHTML);
             }

             function CloseWindow(action) {
	            if (window.CloseOwnerWindow) return window.CloseOwnerWindow(action);
	            else window.close();
       		 }
    </script>
</body>
</html>