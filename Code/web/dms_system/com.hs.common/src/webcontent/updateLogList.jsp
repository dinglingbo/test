<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false" %>
<%@ include file="/common/sysCommon.jsp"%>	
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<!-- 
  - Author(s): Administrator
  - Date: 2019-06-20 14:33:42
  - Description:
-->
<head>
<title>Title</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
    
    <style type="text/css">
    	.font15{font-size:15px;}
    	.color999 {color: #999;}
    	.fr{float:right;}
    </style>
</head>
<body>
	<div class="nui-fit">
		<div id="main"></div>
		<div style="height: 10%;"></div>
	</div>
	<div style="background-color: #cfddee;position:absolute; top:90%;width:100%;height: 10%; z-index:900;">
	    <div id="pager" class="nui-pager" style="width:100%;top:25%;background:#cfddee;border:solid 1px #ccc;    " 
		    totalCount="" onpagechanged="onPageChanged" sizeList="[5,10,20,100]"
		    showPageSize="true" showPageIndex="true" showPageInfo="true">         
		</div> 
	</div>

	  


	<script type="text/javascript">
    	nui.parse();
    	var p = nui.get("pager");
    	
    	load(0, 10);
    	function onPageChanged(e) {
	        load(e.pageIndex, e.pageSize);
	    }
	    
	    function load(pageIndex, pageSize) {
	    	var page = {
	    		begin: pageIndex * pageSize,
	    		length: pageSize
	    	};
	    	var json = {
	    		page: page,
	    		token: token
	    	};
	    	nui.ajax({
				url: apiPath + sysApi + "/com.hsapi.system.employee.slog.querySysUpdateLogList.biz.ext",
				type: 'POST',
				data: json,
				cache: false,
				async: false,
				contentType: 'text/json',
				success: function(text) {
					var data = text.data;
					var page = text.page;
					
					p.setTotalCount(page.count);
					
					var itemHtml = "";
					for(var i=0; i<data.length; i++) {
						var temp = data[i];
						var content = temp.content;
						var date = temp.recordDate;
						date = new Date(date);
						date = format(date, "yyyy-MM-dd");
						if(content != null && content != "") {
							var title = " <h3 style='margin: 0px 0px 8px; padding: 0px; font-size: 20px;  "
							          + "        font-weight: normal; font-variant-numeric: normal; font-variant-east-asian: normal;  "
							          + "        border-bottom: 2px solid rgb(220, 225, 229); height: 35px;'> "
							          + "        <span class='fr color999 font15' style='float: right; color: rgb(153, 153, 153);  "
							          + "        font-size: 15px; margin-top: 5px;'> "
							          + "                    更新日期： " + date 
							          + "        </span> "
							          + temp.title
							          + " </h3> ";
							
							itemHtml+="<p>"+ title + content+"</p>";
							
							var btn = "<h4 style='margin: 0px; padding: 0px; font-weight: normal;  "
									+ "	          font-variant-numeric: normal; font-variant-east-asian: normal;'> "
									+ "		<a href='"+webPath + sysDomain+"/com.hs.common.updateLogDetail.flow?id="+temp.id+"&show=true'  "
									+ "		        target='_blank' style='text-decoration-line: none; transition: all 0.4s ease 0s; "
									+ "		        font-family: 微软雅黑, Arial, Helvetica, sans-serif; font-size: 16px; "
									+ "		        color: rgb(87, 140, 205); display: block; width: 200px; height: 40px; "
									+ "		        line-height: 40px; text-align: center; border-radius: 5px; "
									+ "		        margin: 10px 0px 0px 5px; background: rgb(220, 225, 229);'> "
									+ "		        点击查看优化详情 "
									+ "		</a> "
									+ "	</h4> ";
							itemHtml += btn;
							
						}
					}
					
					var mainDiv = document.getElementById("main");
					mainDiv.innerHTML=itemHtml;
					
				}
			});
	    }
	    
	    
    </script>
</body>
</html>