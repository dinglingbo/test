(function($){
	/**
	*@desc 文件上传个时期的事件默认处理
	*/
	var $handler={
		/* Demo Note:  This demo uses a FileProgress class that handles the UI for displaying the file name and percent complete.
		The FileProgress class is not part of SWFUpload.
		*/


		/* **********************
		   Event Handlers
		   These are my custom event handlers to make my
		   web application behave the way I went when SWFUpload
		   completes different tasks.  These aren't part of the SWFUpload
		   package.  They are part of my application.  Without these none
		   of the actions SWFUpload makes will show up in my application.
		   ********************** */
		fileQueued:function(file) {
			try {
				var progress = new FileProgress(file, this.customSettings.progressTarget);
				progress.setStatus("等待上传...");
				progress.toggleCancel(true, this);

			} catch (ex) {
				this.debug(ex);
			}

		},

		fileQueueError:function(file, errorCode, message) {
			try {
				if (errorCode === SWFUpload.QUEUE_ERROR.QUEUE_LIMIT_EXCEEDED) {
					alert("选择上传的文件数量太多，\n" + (message === 0 ? "上传文件数量到达上限。" : (message > 1 ? "您选择的文件超过 " + message + " 个文件。" : "上传文件数量可能已超过上传文件数量上限。")));
					return;
				}

				var progress = new FileProgress(file, this.customSettings.progressTarget);
				progress.setError();
				progress.toggleCancel(false);

				switch (errorCode) {
				case SWFUpload.QUEUE_ERROR.FILE_EXCEEDS_SIZE_LIMIT:
					progress.setStatus("文件太大。");
					this.debug("错误: 文件太大, 文件名称: " + file.name + ", 文件大小: " + file.size + ", 信息: " + message);
					break;
				case SWFUpload.QUEUE_ERROR.ZERO_BYTE_FILE:
					progress.setStatus("不能上传0字节文件");
					this.debug("错误: 0字节文件, 文件名称: " + file.name + ", 文件大小: " + file.size + ", 信息: " + message);
					break;
				case SWFUpload.QUEUE_ERROR.INVALID_FILETYPE:
					progress.setStatus("文件类型错误");
					this.debug("错误: 文件类型错误, 文件名称: " + file.name + ", 文件大小: " + file.size + ", 信息: " + message);
					break;
				default:
					if (file !== null) {
						progress.setStatus("未处理错误");
					}
					this.debug("错误: " + errorCode + ", 文件名称: " + file.name + ", 文件大小: " + file.size + ", 信息: " + message);
					break;
				}
			} catch (ex) {
				this.debug(ex);
			}
		},

		fileDialogComplete:function(numFilesSelected, numFilesQueued) {
			try {
				if (numFilesSelected > 0) {
					document.getElementById(this.customSettings.cancelButtonId).disabled = false;
				}
				
				/* I want auto start the upload and I can do that here */
				
				var fileCount=numFilesSelected+this.customSettings.scope.getFilesLength();
				
				if(this.customSettings.autoUpload){
					var max=this.customSettings.scope.maxFileCount;
					if(max>0){
						if(fileCount>max){
							alert('最多上传：'+max+'个文件！');
							return;
						}
					}else{
						this.addPostParam('savetype',this.saveType);
						this.startUpload();
					}
				}
			} catch (ex)  {
				this.debug(ex);
			}
		},

		uploadStart:function(file) {
			try {
				/* I don't want to do any file validation or anything,  I'll just update the UI and
				return true to indicate that the upload should start.
				It's important to update the UI here because in Linux no uploadProgress events are called. The best
				we can do is say we are uploading.
				 */
				var progress = new FileProgress(file, this.customSettings.progressTarget);
				progress.setStatus("上传...");
				progress.toggleCancel(true, this);
			}
			catch (ex) {}
			
			return true;
		},

		uploadProgress:function(file, bytesLoaded, bytesTotal) {
			try {
				var percent = Math.ceil((bytesLoaded / bytesTotal) * 100);

				var progress = new FileProgress(file, this.customSettings.progressTarget);
				progress.setProgress(percent);
				progress.setStatus("上传...");
			} catch (ex) {
				this.debug(ex);
			}
		},

		uploadSuccess:function(file, serverData) {
			try {
				this.customSettings.success(file,serverData);
				var progress = new FileProgress(file, this.customSettings.progressTarget);
				progress.setComplete();
				progress.setStatus("完成");
				progress.toggleCancel(false);
			} catch (ex) {
				this.debug(ex);
			}
		},

		uploadError:function(file, errorCode, message) {
			try {
				var progress = new FileProgress(file, this.customSettings.progressTarget);
				progress.setError();
				progress.toggleCancel(false);

				switch (errorCode) {
				case SWFUpload.UPLOAD_ERROR.HTTP_ERROR:
					progress.setStatus("上传错误: " + message);
					this.debug("错误: HTTP 错误, 文件名称: " + file.name + ", 信息: " + message);
					break;
				case SWFUpload.UPLOAD_ERROR.UPLOAD_FAILED:
					progress.setStatus("上传失败");
					this.debug("错误: 上传失败, 文件名称: " + file.name + ", 文件大小: " + file.size + ", 信息: " + message);
					break;
				case SWFUpload.UPLOAD_ERROR.IO_ERROR:
					progress.setStatus("服务器 (IO) 错误");
					this.debug("错误: IO 错误, 文件名称: " + file.name + ", 信息: " + message);
					break;
				case SWFUpload.UPLOAD_ERROR.SECURITY_ERROR:
					progress.setStatus("安全错误");
					this.debug("错误: 安全错误, 文件名称: " + file.name + ", 信息: " + message);
					break;
				case SWFUpload.UPLOAD_ERROR.UPLOAD_LIMIT_EXCEEDED:
					progress.setStatus("上传文件大小超过上限");
					this.debug("错误: 上传文件大小超过上限, 文件名称: " + file.name + ", 文件大小: " + file.size + ", 信息: " + message);
					break;
				case SWFUpload.UPLOAD_ERROR.FILE_VALIDATION_FAILED:
					//progress.setStatus("Failed Validation.  Upload skipped.");
					//this.debug("Error Code: File Validation Failed, File name: " + file.name + ", File size: " + file.size + ", 信息: " + message);
					break;
				case SWFUpload.UPLOAD_ERROR.FILE_CANCELLED:
					// If there aren't any files left (they were all cancelled) disable the cancel button
					if (this.getStats().files_queued === 0) {
						document.getElementById(this.customSettings.cancelButtonId).disabled = true;
					}
					progress.setStatus("已取消");
					progress.setCancelled();
					break;
				case SWFUpload.UPLOAD_ERROR.UPLOAD_STOPPED:
					progress.setStatus("已停止");
					break;
				default:
					progress.setStatus("未处理错误: " + errorCode);
					this.debug("错误: " + errorCode + ", 文件名称: " + file.name + ", 文件大小: " + file.size + ", 信息: " + message);
					break;
				}
			} catch (ex) {
				this.debug(ex);
			}
		},

		uploadComplete:function(file) {
			if (this.getStats().files_queued === 0) {
				$('#'+this.customSettings.cancelButtonId).attr('disabled',true);
			}
		},

		// This event comes from the Queue Plugin
		queueComplete:function(numFilesUploaded) {
			var status = document.getElementById(this.customSettings.statusDomId);
			status.innerHTML = numFilesUploaded + " 文件" + (numFilesUploaded === 1 ? "" : "") + " 上传成功。";
		}
	};



	var $help={
		uploadUrl:'/com.primeton.components.web.fileupload.fileupload.flow',
		loadFilesUrl:'/com.primeton.components.web.fileupload.fileupload.loadFiles.biz.ext',
		getFileUrl:'/com.primeton.components.web.fileupload.getfile.flow',
		contextPath:'',
		getContext:function(){
			if(window['contextPath']){
				return window['contextPath'];
			}
			this.contextPath='/'+window.location.href.split('/')[3];
			return this.contextPath;
		},
		getUploadUrl:function(){
			return $help.getContext()+$help.uploadUrl;
		},
		getLoadFilesUrl:function(){
			return $help.getContext()+$help.loadFilesUrl;
		},
		getGetFileUrl:function(){
			return $help.getContext()+$help.getFileUrl;
		},
		createId:function(prix,length){
			prix=prix||'';
			prix+=(prix.substr(0,2)=='swfup_')?'':'swfup_';
			prix+=(prix.substr(prix.length-1,1)=='_')?'':'_';
			
			length=length||5;
			var _x=Math.random()*Math.pow(10, length)+'';
			return prix+_x.substr(0,_x.indexOf('.'));
		},
		parse:function(p,d){
			var reg;
			if(typeof(p)=='object'&&p instanceof Array){
				p=$we.join(p);
			}
			for(var i in d){
				reg=new RegExp('{'+i+'}','g');
				
				p=p.replace(reg,d[i]);
			}
			return p;
		}
	};
	
	//该变量在swffileupload中定义
	var path=window['__swfFileUploadPath'];
	
	var swfConfig={
		upload_url : $help.getUploadUrl(),
		flash_url :path+'/swfupload.swf', 
		
		file_post_name:"uploadfile",
		
		debug: false,
		button_window_mode:SWFUpload.WINDOW_MODE.OPAQUE,
		
		// Button settings
		button_image_url: path+'/images/TestImageNoText_65x29.png',
		button_width: "80",
		button_height: "25",
		button_text: '<div class="theFont" style="color:#ff0000;">选择文件</div>',
		button_text_style: '.theFont {color:#ff0000;font-size: 12px;;}',
		button_text_left_padding: 15,
		button_text_top_padding: 3,			
		//button_cursor : SWFUpload.BUTTON_CURSOR.HAND,
		
		// The event handler functions are defined in handlers.js
		file_queued_handler : $handler.fileQueued,
		file_queue_error_handler : $handler.fileQueueError,
		file_dialog_complete_handler : $handler.fileDialogComplete,
		upload_start_handler :$handler.uploadStart,
		
		upload_progress_handler : $handler.uploadProgress,
		upload_error_handler : $handler.uploadError,
		upload_success_handler : $handler.uploadSuccess,
		upload_complete_handler : $handler.uploadComplete,
		queue_complete_handler : $handler.queueComplete
	};
	
	var SWFFileUpload=function(config){
		$.extend(this,config);
		
		this.init();
	};	
	
	var __map={};
	SWFFileUpload.add=function(obj){
		__map[obj.id]=obj;
	}
	SWFFileUpload.get=function(id){
		return __map[obj.id];
	}
	
	$.extend(SWFFileUpload.prototype,{
		id:'',
		renderTo:'',					//渲染的容器
		name:'files',					//控件将根据此属性设置，生成一个隐藏的hidden，用于数据提交
		hasCancel:true,					//是否有取消按钮
		title:'文件上传',				//fieldset的标题
		width:0,						//宽度
		height:0,						//高度
		cancelBtnText:'取消',			//取消按钮的文字
		maxFileCount:0,					//最对上传文件数
		minFileCount:0,					//最少上传文件数
		fileQueryLimit:0,
		fileRenderType:'file',			//file为文件形式渲染，image为图片形式渲染
		fileTypes:'*',					//可上传文件的扩展名类别
		hiddenType:'',					//hidden控件的类型
		value:'',						//控件的值
		config:{},						//上传控件的配置
		autoUpload:false,				//是否自动保存，即点击文件选择后，自动启动异步的文件上传保存
		saveType:'1',					//上传保存类型
		disabled:false,					//控件是否可编辑
		enable:true,					//是否启用
		getFileUrl:'',					//展示文件的URL地址
		uploadUrl:'',					//文件上传URL地址
		__debug:false,
		__fileNames:[],
	
		/**
		*@desc 设置title
		*@param title 标题
		*/
		setTitle:function(title){	
			this.title=title;
			this.__getEl('title').text(title);
		},
		/**
		*@desc 设置高度
		*@param height 高度
		*/
		setHeight:function(height){
			if(!height){
				return;
			}
			
			this.height=height;
			
			this.getEl().height(height);
		},
		/**
		*@desc 设置宽度
		*@param width 宽度
		*/
		setWidth:function(width){
			if(!width){
				return;
			}
			this.width=width;
			
			this.getEl().width(width);
		},
		getHiddenEl:function(){
			if(this.hiddenType=='nui'){
				return nui.get(this.id+'_hidden')
			}
			return this.__getEl('hidden');
		},
		setValue:function(value,autoLoadFiles){
			var hiddenEl=this.getHiddenEl();
			if(!hiddenEl){
				return;
			}
			if(this.hiddenType=='nui'){
				hiddenEl.setValue(value);
			}else{
				hiddenEl.val(value);
			}
			this.value=value;
			if(value){
				autoLoadFiles=autoLoadFiles===undefined?true:false;
				if(autoLoadFiles){
					this.loadFiles();
				}
			}else{
				this.doFilesRender({
					files:[]
				});
			}
		},
		getValue:function(){
			var hiddenEl=this.getHiddenEl();
			if(!hiddenEl){
				return '';
			}
			if(this.hiddenType=='nui'){
				return hiddenEl.getValue();
			}else{
				var hiddenEl=this.__getEl('hidden');
				return hiddenEl.val();
			}
			return '';
		},
		setDisable:function(){
			this.disabled=true;
			this.__getEl('editor').hide();
			this.__getEl('files .swfupload-file-del').hide();
		},
		setEnable:function(){
			this.disabled=false;
			this.__getEl('editor').show();
			this.__getEl('files .swfupload-file-del').show();
		},
		getRenderEl:function(){
			return $(this.renderTo);
		},
		getEl:function(){
			return this.__getEl();
		},
		/**
		*@desc 上传文件是，会调用该方法获取参数，可以通过覆盖该方法，实现动态参数的传递
		*/
		getPostParams:function(){
			return null;
		},
		/**
		*@desc 设置文件上传时的POST参数，采用键值对的方式进行设置，以前的属性全部被覆盖
		*@params 键值对的对象
			{
				name:value
			}
		*/
		setPostParams:function(params){
			if(!this.swfIns||this.disabled){
				return
			}
			return this.swfIns.setPostParams(params);
		},
		/**
		*@desc 添加文件上传时的POST参数，如果同名的参数已经存在，则进行覆盖
		*@param name 参数的名称
		*@param value 参数的值
				
		*/
		addPostParam:function(name,value){
			if(!this.swfIns||this.disabled){
				return
			}
			return this.swfIns.addPostParam(name,value);
		},
		/**
		*@desc 根据名称移除文件上传时的POST参数
		*@param name 参数的名称
		*/
		removePostParam:function(name){
			if(!this.swfIns||this.disabled){
				return
			}
			return this.swfIns.removePostParam(name);
		},
		getFilesLength:function(){
			var v=this.getValue();
			if(!v){
				return 0;
			}
			return v.split(',').length;
			// return this.getValue().split(',').length;
		},
		/**
		*@desc 获取全部的文件数量，包括队列中待上传的和已经上传成功的
		*/
		getFilesCount:function(){
			var count=this.getFilesLength();
			if(!this.swfIns||this.disabled){
				return count;
			}
			
			var state=this.swfIns.getStats();
			count+=state.files_queued;
			
			return count;
		},
		doFilesRender:function(ret){
			var files=ret.files;
			var html=this.onRenderFiles(files);
			if(!html){
				html=[];
				var delStyle='';
				if(this.disabled){
					delStyle='display:none;';
				}
				var imgTemplate=[
					'<li fileId="{fileId}" class="swfupload-img">',
						'<em fileId="{fileId}" class="swfupload-file-del" style="',delStyle,'"></em>',
						'<a href="{src}?fileId={fileId}" target="_blank" title="{clientFileName}">',
							'<img src="{src}?fileId={fileId}"/>',
							'<div>{clientFileName}</div>',
						'</a>',
					'</li>'
				].join('');
				var fileTemplate=[
					'<li fileId="{fileId}" class="swfupload-file">',
						'<a href="{src}?fileId={fileId}" target="_blank" title="{clientFileName}">',
							'{clientFileName}',
						'</a>',
						'<em fileId={fileId} class="swfupload-file-del" style="',delStyle,'"></em>',
					'</li>'
				].join('');
				var template=this.fileRenderType=='image'?imgTemplate:fileTemplate;
				
				if(files.length){
					this.__fileNames=[];
					for(var i=0,len=files.length;i<len;i++){
						var file=files[i];
						file.src=this.getFileUrl||$help.getGetFileUrl();
						html.push($help.parse(template,file));
						
						this.__fileNames.push(file.clientFileName);
					}
				}else{
					html.push('<div>尚未上传任何文件！</div>');
				}
				html=html.join('');
			}
			this.__getEl('files').html(html);
		},
		doRender:function(renderTo){
			var html=[
				'<fieldset id="',this.id,'">',
					'<legend id="',this.id,'_title">',this.title,'</legend>',
					'<div id="',this.id,'_editor">',
						'<div id="',this.id,'_status"></div>',
						'<div class="fieldset flash" id="',this.id,'_progress"></div>',
						'<div>',
							'<span id="',this.id,'_uploadbutton"></span>',
							this.hasCancel?(['<input id="',this.id,'_cancelbutton" class="swfupload-cancelbutton" value="',this.cancelBtnText,'" type="button"/>'].join('')):'',
						'</div>',
					'</div>',
					this.__renderHidden(),
					//'<input id="',this.id,'_hidden" name="',this.name,'" type="hidden" value=""/>',
					// '<h4>已上传文件</h4>',
					'<ul id="',this.id,'_files" class="swfupload-files"></ul>',
				'</fieldset>'
			];
			
			this.renderTo=renderTo||this.renderTo;
			
			html=html.join('');
			this.getRenderEl().html(html);
			
			if(this.hiddenType=='nui'&&window['nui']){
				window['nui'].parse();
			}
		},
		loadFiles:function(){
			var _this=this;
			$.ajax({
				url:$help.getLoadFilesUrl(),
				data:{
					fileIds:this.value
				},
				dataType:'json',
				success:function(ret){
					if(ret.exception){
						if(ret.exception.code==12101001){
							window.location.href=ret.exception.loginPage+'?_url='+window.location.href;
						}else{
							alert(ret.exception.message);
						}
					}else{
						_this.doFilesRender(ret);
					}
				},
				fail:function(){
					alert('数据加载失败！');
				}
			});
		},
		/**
		*@desc 开始上传文件
		*@param succ 所有文件上传成功的回调处理方法
		*@param fail 文件上传失败的回调处理方法
		*/
		startUpload:function(succ,fail,error){
			succ=succ||this.onUploadSuccess;
			fail=fail||this.onUploadFail;
			error=error||this.onUploadError;
			
			if(!this.swfIns){
				succ();
				return;
			}
			if(!this.__minCheck()){
				error();
				return;
			}
			if(!this.__maxCheck()){
				error();
				return;
			}
			
			this.onUploadSuccess=succ||this.onUploadSuccess;
			this.onUploadFail=fail||this.onUploadFail;
			
			if(this.disabled){
				this.onUploadSuccess();
			}
			
			var state=this.swfIns.getStats();
			
			if(!state.files_queued){//全部文件上传完毕
				this.onUploadSuccess();
			}else{
				/* //队列中的文件+上传成功的文件
				var fileCount=state.files_queued+this.getFilesLength();
				if(this.maxFileCount>0){
					if(fileCount>this.maxFileCount){
						alert('最多只能上传'+this.maxFileCount+'个文件！');
						return;
					}
				}
				if(this.minFileCount>0){
					if(fileCount<this.minFileCount){
						alert('最少上传'+this.minFileCount+'个文件！');
					}
				} */
				this.swfIns.startUpload();
				this.addPostParam('savetype',this.saveType);
			}
		},
		/**
		*@desc 获取文件名称的,号分隔的字符串
		*/
		getFileNames:function(){
			return this.__fileNames.join(',');
		},
		/**
		*@desc 删除一个文件
		*@param fileId 文件的后台记录ID
		*@return 删除后的文件值
		*/
		removeFile:function(fileId){
			var value=this.getValue();
			if(value){
				value=value.split(',');
				for(var i=0,len=value.length;i<len;i++){
					if(value[i]==fileId){
						value.splice(i,1);
						value=value.join(',');
						this.__fileNames.splice(i,1);
						break;
					}
				}
				
				this.setValue(value,false);
			}
			return value;
		},
		
		/**
		*@desc 该方法为一个文件上传成功后调用
		*/
		onUploadOneFileSuccess:function(){},
		/**
		*@desc 该方法为一个文件上传失败后调用
		*/
		onUploadOneFileFail:function(){},
		
		/**
		*@desc 该方法为所有文件上传成功后调用
		*/
		onUploadSuccess:function(){},
		/**
		*@desc 该方法为只要有一个文件上传失败，即会调用触发
		*/
		onUploadFail:function(){},
		/**
		*@desc 文件上传前，校验失败
		*/
		onUploadError:function(){},
		/**
		*@desc 文件列表自定义渲染
		*@param files 文件对象的数组
			{
				
			}
		*/
		onRenderFiles:function(files){},
		
		/**
		*@desc 删除文件后出发
		*@param e {
			oldValue:'',//删除前端值
			value:''//现在的值
		}
		*/
		onFileRemoved:function(e){
			
		},
		
		__renderHidden:function(){
			if(this.hiddenType=='nui'){
				return ['<input class="nui-hidden" id="',this.id,'_hidden" name="',this.name,'" type="hidden" value=""/>'].join('')
			}
			return ['<input id="',this.id,'_hidden" name="',this.name,'" type="hidden" value=""/>'].join('');
		},
		/**
		@@desc	一个文件上传成功的默认处理：将后台返回的值，填充至隐藏域
				如果文件队列中的所有数据都上传成功，则调用所有文件上传成功的处理方法
		*@param 	file 	文件对象
		*@param 	serverData 	后台返回的数据
		*/
		__doUploadFileSucc:function(file,serverData){
						
			value=this.getValue();
			value=value?value.split(','):[];
			value.push(serverData.replace(/(^\s+)|(\s+$)/g, ""));
			value=value.join(',');
			
			var state=this.swfIns.getStats();
			this.setValue(value,false);
			
			this.__fileNames.push(file.name);
			
			//全部文件上传完毕
			if(!state.files_queued){
				this.loadFiles();
				this.onUploadSuccess();
			}
		},
		/**
		*@desc 一个文件上传失败后的默认处理：不在进行下一个文件的上传，并调用文件上传失败的处理方法
		*@param e 错误信息对象
		*/
		__doUploadFileFail:function(e){
			this.onUploadFail();
		},
		__getEl:function(suffix){
			suffix=suffix?('_'+suffix):'';
			return $('#'+this.id+suffix)
		},
		__createIns:function(){
			if(!this.swfIns){
				this.__initConfig();
				
				this.swfIns=new SWFUpload(this.__config);
			}
		},
		__initConfig:function(config){
			var config={};
			var _this=this;
			$.extend(config,swfConfig);
			$.extend(config,{
				button_placeholder_id: this.id+"_uploadbutton",
				debug:this.__debug,
				file_types : this.fileTypes,
				file_queue_limit:this.fileQueryLimit,
				custom_settings : {
					scope:this,
					autoUpload:this.autoUpload,
					hiddenId:this.id+"_fileupload",
					statusDomId:this.id+"_status",
					progressTarget : this.id+"_progress",
					cancelButtonId : this.id+"_cancelbutton",
					success:function(file,serverData){
						//触发一个文件上传成功的处理
						_this.onUploadOneFileSuccess(file,serverData);
						//调用默认的处理，即将后台返回的数据填充到隐藏域中
						_this.__doUploadFileSucc(file,serverData);
					},
					fail:function(e){
						//触发一个文件上传失败的处理
						_this.onUploadOneFileFail();
						//调用默认的处理
						_this.__doUploadFileFail(e);
					}
				}
			});
			if(this.maxFileCount>0){
				config.file_upload_limit=this.maxFileCount-this.getFilesLength();
			}
			if(this.uploadUrl){
				config.upload_url=this.uploadUrl;
			}
			
			$.extend(config,this.config);
			
			this.__config=config;
			
			return config;
		},
		__minCheckErrorHandler:function(){
			alert('请最少上传'+this.minFileCount+'个文件');
		},
		__maxCheckErrorHandler:function(){
			alert('请最多上传'+this.maxFileCount+'个文件');
		},
		__minCheck:function(){
			var fileCount=this.getFilesCount();
			if(this.minFileCount>0&&this.minFileCount>fileCount){
				this.__minCheckErrorHandler();
				return false;
			}
			return true;
		},
		__maxCheck:function(){
			var fileCount=this.getFilesCount();
			if(this.maxFileCount>0&&this.maxFileCount<fileCount){
				this.__maxCheckErrorHandler();
				return false;
			}
			return true;
		},
		destroy:function(){
			$('.swfupload-file-del').die('click');
			$('#'+this.id+'_cancelbutton').die('click');
			
			this.getRenderEl().empty();
		},
		initEvent:function(){
			var _this=this;
			$('.swfupload-file-del').live('click',function(){
				var fileId=$(this).attr('fileid');
				$(this).parent().remove();
				var oldValue=_this.getValue();
				var newValue=_this.removeFile(fileId);
				if(!newValue){
					_this.doFilesRender({
						files:[]
					});
				}
				
				_this.onFileRemoved({
					oldValue:oldValue,
					value:value
				});
			});
			
			$('#'+this.id+'_cancelbutton').live('click',function(){
				_this.swfIns.stopUpload();
			});
		},
		init:function(){
			this.id=this.id||$help.createId();
			if(this.renderTo){
				this.doRender();
			}
			this.setValue(this.value);
			this.__createIns();
			
			this.initEvent();
			
			if(this.disabled){
				this.setDisable();
			}
			
			if(!this.enable){
				this.setEnable();
			}
			
			this.setHeight(this.height);
			this.setWidth(this.width);
						
			if(this.hiddenType=='nui'){
				if(!window['nui']){
					this.hiddenType='';
				}
			}
			
			SWFFileUpload.add(this);
		}
	});
	
	window['SWFFileUpload']=SWFFileUpload;
})(jQuery)