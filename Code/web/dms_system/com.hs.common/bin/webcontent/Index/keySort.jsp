<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false" %>
	
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<!-- 
  - Author(s): Administrator
  - Date: 2018-11-24 11:47:31
  - Description:
-->
<head>
<%@include file="/common/sysCommon.jsp" %>
<title>keySort</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
<script src="<%=webPath + contextPath%>/common/js/jsCryptoJS.js?v=1.0" type="text/javascript"></script>
<script src="<%=webPath + contextPath%>/common/js/settleCenter.js?v=1.0" type="text/javascript"></script>
</head>
<body>

    <di id="content">
    	<a  class="nui-button" onclick="show()" iconCls="icon-edit">
		    Button
		</a>
		
		<a  class="nui-button" onclick="show2()" iconCls="icon-edit">
		    Button
		</a>

    </div>

	<script type="text/javascript">
    	nui.parse();
    	
    	var data = {
	    	"w":"232",
	    	"A":"349034",
	    	"S":"dfslks",
	    	"l":[{"n":"23","m":"23"},
		    	{"m":"832","n":"323"}]
    	};
    	
    	var datao = {
	    	"w":"232",
	    	"A":"349034",
	    	"k":["23","dss"],
	    	"S":"dfslks",
	    	"l":[{"n":"23","m":[{"q":"2323","p":"9898"},{"q":"34df545","p":"ueir2i"}]},
		    	{"m":[{"q":"2323","p":"9898"},{"q":"34ddf545","p":"ueir23i"}],"n":"323"}]
    	};
    	
    	var testData = {
    		"businessNo":"616666",
    		"businessType":"ERP",
    		"companyId":"COM20100211000014",
    		"customerId":"KH04136-20180400024",
    		"customerName":"陈丽卿",
    		"invoiceType":"NONE",
    		"payMethod":"ALIPAY",
    		"receiptAmount":"0.01",
    		"receiptNo":"XSDDS00001",
    		"receiptSummary":"0.01"
    	};
    	
    	var signStr = japi.sign.sign(testData,"NAropsvXehl0SMLcKCRls0xo9WITiVkb");
    	var sortData = japi.aes.encrypt(japi.sign.sortJoin(testData),"NAropsvXehl0SMLcKCRls0xo9WITiVkb");
    	//console.log(japi.sign.sign(datao,"NAropsvXehl0SMLcKCRls0xo9WITiVkb"));
    	//console.log("参数编码data的值为:");
    	console.log("参数编码sign的值为:" + signStr);
    	
    	console.log("参数编码sortData的值为:" + sortData);
    
    	var url = "http://14.23.35.18:8080/hscp/auth/token";	
    	var urlParams = "?grant_type=password&app_id=31370874921755649&login_id=000833&password=1";
		var data = 
		{
			grant_type:"password",
			app_id:"31370874921755649",
			login_id:"000833",
			password:"1"
		}
		
    	nui.ajax({
            url : url,
            type : "post",
            contentType : 'application/x-www-form-urlencoded',
            data : data,
            success : function(data) {
            	data = data || {};
                //console.log(data);
            },
            error : function(jqXHR, textStatus, errorThrown) {
                console.log(jqXHR.responseText);
            }
        });
        
        function show() {
	        var url = "http://14.23.35.18:8080/hscp/pay/accounts?token=nNDBeDsKuGjzBP496cD";//?access_token=DLNtHmzlBTeGFJ8AK0m
	        var access_token = "Z17cYJrkyKxVvV8s1Uy";
			
	        nui.ajax({
	            url : url,
	            async: true,
	            type : "get",
				headers: {
					//"Authorization": 'Bearer '+ access_token,
				    //"X-Token": "q8rnlKM7OnevVlPhoMH",
				    "Call-Source": "WEB",
				    "Api-Version": "1.0"
				     
				},
	            success : function(data) {
	            	data = data || {};
	                console.log(data);
	            },
	            error : function(jqXHR, textStatus, errorThrown) {
	                console.log(jqXHR.responseText);
	            }
	        });
        }
        
       function show2() {
	        var url = "http://14.23.35.18:8080/hscp/pay/accounts";//?access_token=DLNtHmzlBTeGFJ8AK0m
	        var access_token = "nNDBeDsKuGjzBP496cD";
			
	        nui.ajax({
	            url : url,
	            type : "get",
				contentType : "json",
				headers: {
					"Authorization": "Bearer "+ access_token,
				    //"X-Token": "q8rnlKM7OnevVlPhoMH",
				    "Call-Source": "WEB",
				    "Api-Version": "1.0"
				     
				},
	            success : function(data) {
	            	data = data || {};
	                console.log(data);
	            },
	            error : function(jqXHR, textStatus, errorThrown) {
	                console.log(jqXHR.responseText);
	            }
	        });
        }
    	
    </script>
</body>
</html>