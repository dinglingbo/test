<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false" %>
	
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<!-- 
  - Author(s): zzj
  - Date: 2019-03-28 17:23:44
  - Description:
-->
<head>
<title>测试上传到七牛</title>  
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
    <script src="<%= request.getContextPath() %>/common/nui/nui.js" type="text/javascript"></script>
    
</head>
<body>
		<input id="file1" name="file" type="file" />
		<input id="file2" name="file" type="file" />
		<input name="x:fname" type="hidden" value="aaaaaaa" >
		<button type="button" id="fileSubmitOnly" onclick="uploadOnlyFile()" >确认上传文件</button>
	<!-- <form id="uploadOnly" action="http://up-z2.qiniup.com" target="hidden_frameOnly" method="post" enctype="multipart/form-data"  >
		
		<input name="x:imageInfo" type="hidden" >
		<input name="token" type="hidden" value="RxFl_tw2vpWOF_i-3d6cAsGwWL1wL69_AMKMi3qJ:g0KusFYQ72HDQfWwuX1z2Ow8hf0=:eyJzY29wZSI6ImNoZWRhby13ZWNoYXQiLCJkZWFkbGluZSI6MTU1NTczNjczMX0=">
		<input id="file1" name="file" type="file" />
		<button type="button" id="fileSubmitOnly" onclick="uploadOnlyFile()" >确认上传文件</button>
	</form>
	
	<iframe name='hidden_frameOnly' id="hidden_frameOnly" style="display:none;" ></iframe> -->
	

	<script type="text/javascript">
    	nui.parse();
    	function uploadOnlyFile(){
    		/* $("#uploadOnly").submit();//门店图片上传
			$('#hidden_frameOnly').load(function(){
				console.log($(this).contents());
				console.log($(this).contents().find("body"));
				var text=$(this).contents().find("body").text();//获得上传之后返回的参数
				var imagerData=nui.decode(text);
				console.log(imagerData);
			}); */
                var formData = new FormData();
                formData.append("file", document.getElementById("file1").files[0] );
                formData.append("x:name", "12345678" );
                formData.append("token", "RxFl_tw2vpWOF_i-3d6cAsGwWL1wL69_AMKMi3qJ:4s3NrWw7wQhEXPlY6XO5GXy5dXU=:eyJzY29wZSI6ImNoZWRhby13ZWNoYXQiLCJkZWFkbGluZSI6MTU1NjAxNTI3MX0=" );
                $.ajax({
                    url: "http://up-z2.qiniup.com",
                    type: "POST",
                    data: formData,
                    /**
                    *必须false才会自动加上正确的Content-Type
                    */
                    contentType: false,
                    /**
                    * 必须false才会避开jQuery对 formdata 的默认处理
                    * XMLHttpRequest会对 formdata 进行正确的处理
                    */
                    processData: false,
                    success: function (data) {
                    	console.log(data);
                    	console.log(data["x:name"]);
                        if (data.status == "true") {
                            console.log("上传成功！");
                        }
                        if (data.status == "error") {
                            console.log(data.msg);
                        }
                    },
                    error: function () {
                        console.log("上传失败！");
                    }
                });
		};
    	// action + 返回的key，就是图片链接 例如（http://qxy60.7xdr.com/FsUrC35uDyiwYA9ErN54jzPSfbGK）
    </script>
</body>
</html>