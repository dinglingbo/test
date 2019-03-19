<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" session="false"%>
 <%@ include file="/common/sysCommon.jsp"%>


<html>
<!-- 
  - Author(s): Administrator
  - Date: 2018-05-27 15:11:00 
  - Description:
-->
<head> 
    <title>添加员工</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
    <script src="<%=webPath + contextPath%>/common/js/updateSkin.js?v=1.0.1" type="text/javascript"></script>
    <style type="text/css">
</style>
</head>
<body>
    <div class="nui-fit"> 
        <div class="form" style="width:98%;height:98%;left:0;right:0;margin: 0 auto;" id="basicInfoForm">
            <input class="mini-hidden" id="empid" name="empid" />
            <fieldset id="fd1" style="width:100%;">
                <legend><span>我的皮肤</span></legend>
                <table >
					<tr>
						<td>
							经典蓝：
						</td>
						<td height="140px">
							<div  style=" width:800px; height:100px;">
						    	<img class="icon" id="icon" src="<%=webPath + contextPath%>/common/images/blue.jpg" />
						    	<button style="margin-top: 10px;border-color: #368bf4" onclick="updateSkin('#368bf4')">使用经典蓝</button>
						    </div>
						    
						</td>
						
					</tr>
					
					<tr>
					
						<td>
							宜修橙：
						</td>
						<td height="140px">
							<div  style=" width:800px; height:100px;">
						    	<img class="icon" id="icon" src="<%=webPath + contextPath%>/common/images/easy.jpg" />
						    	<button style="margin-top: 10px;border-color: #f36205" onclick="updateSkin('#f36205')">使用宜修橙</button>
						    </div>
						</td>
					</tr>
					<tr>
						<td>
							极简灰：
						</td>
						<td height="140px">
							<div  style=" width:800px; height:100px;">
						    	<img class="icon" id="icon" src="<%=webPath + contextPath%>/common/images/grey.jpg" />
						    	<button style="margin-top: 10px;border-color: #c1c1c1" onclick="updateSkin('#c1c1c1')">使用极简灰</button>
						    </div>
						</td>
					</tr>
					<tr>
						<td>
							炫酷黑：
						</td>
						<td height="140px">
							<div  style=" width:800px; height:100px;">
						    	<img class="icon" id="icon" src="<%=webPath + contextPath%>/common/images/black.jpg" />
						    	<button style="margin-top: 10px;;border-color: #42485b" onclick="updateSkin('#42485b')">使用炫酷黑</button>
						    </div>
						</td>
					</tr>

		        </table>
		    </fieldset>

		</div>
</div>
<script type="text/javascript">
  nui.parse();

</script>
</body>
</html>