<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false" %>
<%@include file="/common/sysCommon.jsp" %>	
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<!-- 
  - Author(s): Administrator
  - Date: 2019-01-30 17:18:43
  - Description:
-->
<head>
    <meta charset="UTF-8">
    <title>clipboard示例</title>
</head>
<body>
<input type="text" id="copyVal" readonly value="被复制内容" />
<button class="copyBtn" ><span class="fa fa-copy fa-lg">点击复制</span></button>

    <script>
   var copyBtn = document.getElementsByClassName('copyBtn')[0];

    copyBtn.onclick = function(){
        var copyVal = document.getElementById("copyVal");
            copyVal.select();

        try{
            if(document.execCommand('copy', false, null)){
                //success info
                console.log("doSomething...");
            } else{
                //fail info
                console.log("doSomething...");
            }
        } catch(err){
            //fail info
            console.log("doSomething...");
        }
    }


    </script>
</body>
</html>
