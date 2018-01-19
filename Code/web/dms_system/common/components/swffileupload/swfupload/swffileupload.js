(function($){
	$help={
		getContext:function(){
			if(window['contextPath']){
				return window['contextPath'];
			}
			this.contextPath='/'+window.location.href.split('/')[3];
			return this.contextPath;
		},
		loadJS:function(src){
			document.write('<script type="text/javascript" src="'+src+'"></script>');
		},
		loadCSS:function(href){
			var link=document.createElement('LINK');
			link.type="text/css";
			link.href=href;
			link.rel="stylesheet";
			document.getElementsByTagName('head')[0].appendChild(link);
		}
	}
	var path=$help.getContext()+'/common/components/swffileupload/swfupload/';
	
	(function(){
		if(window['SWFUpload']){
			return;
		}
		var jsRes=[
			'js/swfupload.js',
			'js/swfupload.queue.js',
			'js/fileprogress.js',
			'js/swfupload.cookies.js',
			'js/fileupload.js'
		];
		if(!$){
			jsRes.unshift('js/jquery-1.6.2.min.js');
		}
		var cssRes=[
			'css/swfupload.css'
		];
		for(var i=0,len=jsRes.length;i<len;i++){
			$help.loadJS(path+jsRes[i]);
		}
		for(var i=0,len=cssRes.length;i<len;i++){
			$help.loadCSS(path+cssRes[i]);
		}
		window['__swfFileUploadJSList']=jsRes;
	})();
	
	//该变量定义好之后，在js/fileupload.js文件中使用
	window['__swfFileUploadPath']=path;
})(window['jQuery']);