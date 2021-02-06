<!DOCTYPE HTML>
<html>
	<head>
		<title>Joyce_Plugins</title>
		<meta name="viewport" content="width=device-width,initial-scale=1.0,
			minimum-scale=1.0,maximum-scale=1.0,user-scalable=no" >
		<meta name="apple-itunes-app" content="" />
		<meta name="format-detection" content="telephone=no, address=no" >
		<meta name="apple-mobile-web-app-capable" content="yes" />
		<meta name="apple-mobile-web-app-status-bar-style" content="black-translucent" />
		<meta http-equiv="X-UA-Compatible" content="IE=Edge,chrome=1">
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache,must-revalidate">
		<meta http-equiv="expires" content="0"> 
		<meta http-equiv="keywords" content="plugin">
		<meta http-equiv="description" content="plugin">
		<meta http-equiv="content-type" content="application/xhtml+xml;charset=UTF-8">
		
		<style type="text/css">
			.view_table {
				width:800px;
				height:auto;
				margin:0px auto;
				width: 100%;
				font-size: 12px;
				font-family: "Microsoft YaHei" !important;
				text-align: center;
			}
			.view_table thead {
				background-color: #cccccc;
			}
			.view_table tr td {
				line-height: 30px;
				width: 80px;
				border-bottom:1px #cccccc dashed;
			}
		</style>
	</head>
  
	<body>
		<table border="0" cellpadding="0" cellspacing="0" class="view_table">
			<thead>
				<td>name</td>
				<td>filename</td>
				<td>version</td>
				<td>description</td>
				<td>action</td>
			</thead>
		</table>
	</body>
	<script src="http://libs.baidu.com/jquery/1.9.1/jquery.min.js"></script>
	<script>
		(function(){
			var getBrowerPlugins = function(){
				var navigator = window.navigator,
					plugins = navigator.plugins,
					$table_view = $('.view_table');
				$.each(plugins, function(index,plugin){
					console.log('name:%s,filename:%s,version:%s,description:%s', plugin.name, plugin.filename, (plugin.version ? plugin.version : ''), plugin.description);
					$table_view.append('<tr><td>' + plugin.name + '</td><td>' + plugin.filename + '</td><td>'
						+ (plugin.version ? plugin.version : '') + '</td><td>' + plugin.description + '</td><td><input type="button" value="edit"></td></tr>')
				});
			};
			getBrowerPlugins();
			$('input[type="button"]').on('click', function(){
				var $this = $(this),
					edit_status = $this.attr('edit_status'),
					status_value = edit_status && 1 == edit_status ? 0 : 1,
					$td_arr = $this.parent().prevAll('td');
				$this.val(1 == status_value ? 'complete' : 'edit').attr('edit_status', status_value);
				$.each($td_arr, function(){
					var $td = $(this);
					if(1 == status_value) {
						$td.html('<input type="text" value="'+$td.html()+'">');
					} else if(0 == status_value){
						$td.html($td.find('input[type=text]').val());
					}
				});
			});
		})();
	</script>
</html>