<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false" %>
	
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<!-- 
  - Author(s): Administrator
  - Date: 2018-04-30 10:32:35
  - Description:
-->
<head>
<title>Title</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
    <script src="<%= request.getContextPath() %>/common/nui/nui.js" type="text/javascript"></script>
    <link href="//netdna.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css" rel="stylesheet">
</head>
<body>
   	 基本图标
	<div>
		<i class="fa fa-camera-retro"></i> fa-camera-retro
	</div>
	
	大图标
	<div>
		<i class="fa fa-camera-retro fa-lg"></i> fa-lg
		<i class="fa fa-camera-retro fa-2x"></i> fa-2x
		<i class="fa fa-camera-retro fa-3x"></i> fa-3x
		<i class="fa fa-camera-retro fa-4x"></i> fa-4x
		<i class="fa fa-camera-retro fa-5x"></i> fa-5x
	</div>
	
	固定宽度
	<div class="list-group">
	  <a class="list-group-item" href="#"><i class="fa fa-home fa-fw"></i>&nbsp; Home</a>
	  <a class="list-group-item" href="#"><i class="fa fa-book fa-fw"></i>&nbsp; Library</a>
	  <a class="list-group-item" href="#"><i class="fa fa-pencil fa-fw"></i>&nbsp; Applications</a>
	  <a class="list-group-item" href="#"><i class="fa fa-cog fa-fw"></i>&nbsp; Settings</a>
	</div>
	
	
	
	<div>
		<ul class="fa-ul">
		  <li><i class="fa-li fa fa-check-square"></i>List icons</li>
		  <li><i class="fa-li fa fa-check-square"></i>can be used</li>
		  <li><i class="fa-li fa fa-spinner fa-spin"></i>as bullets</li>
		  <li><i class="fa-li fa fa-square"></i>in lists</li>
		</ul>
	</div>

	<div>
		<i class="fa fa-quote-left fa-3x pull-left fa-border"></i>
	</div>
	
	
	
	<div>
		<i class="fa fa-spinner fa-spin"></i>
		<i class="fa fa-circle-o-notch fa-spin"></i>
		<i class="fa fa-refresh fa-spin"></i>
		<i class="fa fa-cog fa-spin"></i>
		<i class="fa fa-spinner fa-pulse"></i>
	</div>
	
	<div>
		<i class="fa fa-shield"></i> normal<br>
		<i class="fa fa-shield fa-rotate-90"></i> fa-rotate-90<br>
		<i class="fa fa-shield fa-rotate-180"></i> fa-rotate-180<br>
		<i class="fa fa-shield fa-rotate-270"></i> fa-rotate-270<br>
		<i class="fa fa-shield fa-flip-horizontal"></i> fa-flip-horizontal<br>
		<i class="fa fa-shield fa-flip-vertical"></i> icon-flip-vertical
	</div>
	
	<div>
		<span class="fa-stack fa-lg">
		  <i class="fa fa-square-o fa-stack-2x"></i>
		  <i class="fa fa-twitter fa-stack-1x"></i>
		</span>
		fa-twitter on fa-square-o<br>
		<span class="fa-stack fa-lg">
		  <i class="fa fa-circle fa-stack-2x"></i>
		  <i class="fa fa-flag fa-stack-1x fa-inverse"></i>
		</span>
		fa-flag on fa-circle<br>
		<span class="fa-stack fa-lg">
		  <i class="fa fa-square fa-stack-2x"></i>
		  <i class="fa fa-terminal fa-stack-1x fa-inverse"></i>
		</span>
		fa-terminal on fa-square<br>
		<span class="fa-stack fa-lg">
		  <i class="fa fa-camera fa-stack-1x"></i>
		  <i class="fa fa-ban fa-stack-2x text-danger"></i>
		</span>
		fa-ban on fa-camera
	</div>
	
	
	
	
	
	
	
	
	

	<script type="text/javascript">
    	nui.parse();
    </script>
</body>
</html>