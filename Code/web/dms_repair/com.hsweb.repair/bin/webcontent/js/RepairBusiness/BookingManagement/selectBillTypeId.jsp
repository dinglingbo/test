<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<!-- 
  - Author(s): Administrator
  - Date: 2018-10-25 11:01:42
  - Description:
-->
<head>
<title>选择开单类型</title>
<meta http-equiv="content-type" content="text/html; charset=UTF-8" />
<script src="<%=request.getContextPath()%>/common/nui/nui.js" type="text/javascript"></script>
<%@include file="/common/commonRepair.jsp"%>
</head>
<body>
    <div class="mini-toolbar" style="padding:0px;border-top:0;border-left:0;border-right:0;">
        <a class="nui-button" onclick="onOk" style="width: 60px;" plain="true"><span class="fa fa-save fa-lg"></span>&nbsp;保存 </a>
		<a class="nui-button" onclick="onCancel" style="width: 60px;" plain="true"><span class="fa fa-close fa-lg"></span>&nbsp;取消 </a>
    </div>
	<div class="nui-fit" style="width: 100%;">
		<table align="center">
		   <tr style ="height:30px">
			  <td>
               <input type="radio"
				style="vertical-align: middle; margin-top: -2px; margin-bottom: 1px;"
				name="billType" id="billType1" value="2" checked="true" >
				<label for="billType1" >洗美开单</label>    
				
			  </td>
			</tr>
			<tr style ="height:30px">
			 	<td>
               <input type="radio"
				style="vertical-align: middle; margin-top: -2px; margin-bottom: 1px;"
				name="billType" id="billType2" value="0">
				<label for="billType2">综合开单</label>    
				</td>
			</tr>
			
			<tr style ="height:30px">
				<td>
              <input
				type="radio"
				style="vertical-align: middle; margin-top: -2px; margin-bottom: 1px;"
				name="billType" id="billType3" value="4">
				<label for="billType3">理赔开单</label> 
			</td>
			</tr>
		</table>
		
	</div>
</body>
<script type="text/javascript">
    $(document).ready(function (){
	    
	    document.onkeyup=function(event){
        var e=event||window.event;
        var keyCode=e.keyCode||e.which;//38向上 40向下

        if((keyCode==27))  {  //ESC
            onCancel();
        }
      }
    });
    /*  $("#billType1").mouseenter(function(){
 	    alert("111");
     }); */
    var billType = 2;
    $(function(){
      $('input').click(
         function(){
           billType = $('input[name = "billType"]:checked').val();
         }
       );
    });
    function getBilltype(){
       return billType;
    }
    function onOk(){
      CloseWindow("ok");
    }
    //关闭窗口
	function CloseWindow(action) {
	    if (window.CloseOwnerWindow)
	        return window.CloseOwnerWindow(action);
	    else window.close();
	}
	//取消
	function onCancel() {
	    CloseWindow("cancel");
	}
</script>



</html>