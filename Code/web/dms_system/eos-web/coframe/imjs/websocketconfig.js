//var websocketurl="ws://192.168.122.68:2048/ws";   //ws://{ip}:{端口}/{java后端websocket配置的上下文}
var websocketurl="ws://127.0.0.1:2048/ws";
//var websocketurl="wss://192.168.111.60:2048/ws";   
var reconnectflag = false;//避免重复连接
var socket; 
var currentsession= currImCode;

function createWebSocket(url,callbak) {
   try { 
      if (!window.WebSocket) {
  	      window.WebSocket = window.MozWebSocket; 
  	  }  
  	  if (window.WebSocket) {
  		socket = new WebSocket(url);
        socket.binaryType = "arraybuffer"; 
        callbak();
  	  } else {
         // layer.msg("你的浏览器不支持websocket！");
  	     //当浏览器不支持websocket时 降级为http模式	  
  	    var isClose =false;
  		window.onbeforeunload =function() {
  			if(!isClose){
  				return "确定要离开当前聊天吗?";
  			}else{
  				return "";
  			}
  		}
  		window.onunload =function() {
  			if(!isClose){
  				//Imwebserver.closeconnect(); 
  			}
  		} 
  	    //dwr.engine.setActiveReverseAjax(true);
  	    //dwr.engine.setNotifyServerOnPageUnload(true);
  	    //dwr.engine.setErrorHandler(function(){  
  	    //});
  	    //dwr.engine._errorHandler = function(message, ex) {
  	       //alert("服务器出现错误");
  	       //dwr.engine._debug("Error: " + ex.name + ", " + ex.message, true);
  	    //};
  	    //Imwebserver.serverconnect();
  		  
      }  
    } catch (e) { 
       reconnect(url,callbak);
    }     
}
 

function reconnect(callbak) {
    if(reconnectflag) return;
    reconnectflag = true;
    //没连接上会一直重连，设置延迟避免请求过多
    setTimeout(function () {
        createWebSocket(websocketurl,callbak);
        reconnectflag = false;
    }, 2000);
}

 

layui.use('layim', function(layim){
	//回复消息
	var reMsg=function(sender,time,msg){
		layim.getMessage({
			username: "Hi"
			,avatar: ""
			,id: sender
			,type: "friend"
			,content: msg
		});
	};
			  
	var reGroupMsg=function(sender,time,msg){
		layim.getMessage({
			username: "Hi"
			,avatar: ""
			,id: sender
			,type: "group"
			,content: msg
		});
	};
			
	//发送消息
	var sendMsg=function(msg,receiver,group){ 
		var message = new proto.Model(); 
		var content = new proto.MessageBody();
	    message.setMsgtype(4);
	    message.setCmd(5);
	    message.setGroupid(group);//系统用户组
	    message.setToken(currentsession);  
	    message.setSender(currentsession);
	    message.setReceiver(receiver);//好友ID
	    content.setContent(msg);
	    content.setType(0)
	    message.setContent(content.serializeBinary())
	    socket.send(message.serializeBinary()); 
	};
	
	//拉取离线消息
	var showOfflineMsg = function (layim){
		nui.ajax({
			type : "post",
		    url : baseUrl + "com.hsapi.system.im.message.getOffLineMsg.biz.ext?token="+token+"&receiveuser="+currentsession,
		    async : true,
		    success : function(text){ 
			  var dataObj=text.data;
		      if(dataObj!=null&&dataObj.length>0){
		    	  for(var i =0;i<dataObj.length;i++){
		    		  layim.getMessage({
				 	        username: dataObj[i].username
				 	        ,avatar: dataObj[i].avatar+"?"+new Date().getTime()
				 	        ,id: dataObj[i].id
				 	        ,type: "friend"
				 	        ,content: dataObj[i].content
				 	        ,timestamp: dataObj[i].timestamp
			 	       }); 
		    	  }   
		    	  
		    	  layim.getMessage({
			 	        username: "前端群"
			 	        ,avatar: "http://tp2.sinaimg.cn/2211874245/180/40050524279/0"
			 	        ,id: 101
			 	        ,type: "group"
			 	        ,content: "ok.........."
			 	        ,timestamp: ""
			 	       }); 
				  } 
			 }
		}); 
	};
	
	var initEventHandle = function () {
		//收到消息后
		socket.onmessage = function(event) {
	  	  if (event.data instanceof ArrayBuffer){
	  	       var msg =  proto.Model.deserializeBinary(event.data);      //如果后端发送的是二进制帧（protobuf）会收到前面定义的类型
	       //心跳消息
	       if(msg.getCmd()==2){
	    	   //发送心跳回应
	    	   var message1 = new proto.Model();
	           message1.setCmd(2);
	           message1.setMsgtype(4);
	           socket.send(message1.serializeBinary());
	       }else if(msg.getCmd()==3){
	    	  if(msg.getSender()!=currentsession){
	    		layer.msg("用户"+msg.getSender()+"上线了");  
	    		 var existsUser =  $("li[title='"+msg.getSender()+"']").html();
	    		 if(existsUser == undefined){
	    			var usertpl = $(".usertemplate").html();
	    			usertpl  =usertpl.replace("{user}", msg.getSender()).replace("{user}",msg.getSender());
	    			$(".u-lst").append(usertpl);  
	    		 }else{
	    			$("li[title='"+msg.getSender()+"']").removeClass("off");
	    		 }  
	    	  } 
	       }else if(msg.getCmd()==4){
	    	  if(msg.getSender()!=currentsession){
		    		layer.msg("用户"+msg.getSender()+"下线了");  
		    		$("li[title='"+msg.getSender()+"']").addClass("off");
		       }    
		   }else if(msg.getCmd()==5){
	    	   //显示非自身消息    
	    	   if(msg.getSender()!=currentsession){
	    		   //不显示用户组消息
	    		   var msgCon =  proto.MessageBody.deserializeBinary(msg.getContent()); 
	    		   if(msg.getGroupid()==null||msg.getGroupid().length<1){
	  	    	     reMsg(msg.getSender(),msg.getTimestamp(),msgCon.getContent());
	    		   } else {
	    		   	 reGroupMsg(msg.getGroupid(),msg.getTimestamp(),msgCon.getContent());
	    		   }
	    	   } 
	       }
	  }else {
	        var data = event.data;                //后端返回的是文本帧时触发
	      } 
	  };
	  //连接后
	  socket.onopen = function(event) {
		   var message = new proto.Model();
		   var browser=BrowserUtil.info();
	       message.setVersion("1.0");
	       message.setDeviceid("");
	       message.setCmd(1);
	       message.setSender(currentsession);
	       message.setMsgtype(1); 
	       message.setFlag(1);
	       message.setPlatform(browser.name);
	       message.setPlatformversion(browser.version);
	       message.setToken(currentsession);
	       var bytes = message.serializeBinary();  
	       
	       console.log("连接成功...");
		   socket.send(bytes);
	       showOfflineMsg(layim);
	  };
	  //连接关闭
	  socket.onclose = function(event) {
	  	console.log("关闭成功...");
		//layer.confirm('您已下线，重新上线?', function(index){
		//  reconnect(websocketurl,initEventHandle); 
		//  layer.close(index);
	    //}); 
	  };
	  socket.onerror = function () {
		  //layer.msg("服务器连接出错，请检查websocketconfig.js里面的IP地址");  
	    //reconnect(websocketurl,initEventHandle);
	    console.log("error");
	  }; 
  };
	  
  createWebSocket(websocketurl,initEventHandle);  
      
  
  //演示自动回复
  var autoReplay = [
    '您好，我现在有事不在，一会再和您联系。', 
    '你没发错吧？face[微笑] ',
    '洗澡中，请勿打扰，偷窥请购票，个体四十，团体八折，订票电话：一般人我不告诉他！face[哈哈] ',
    '你好，我是主人的美女秘书，有什么事就跟我说吧，等他回来我会转告他的。face[心] face[心] face[心] ',
    'face[威武] face[威武] face[威武] face[威武] ',
    '<（@￣︶￣@）>',
    '你要和我说话？你真的要和我说话？你确定自己想说吗？你一定非说不可吗？那你说吧，这是自动回复。',
    'face[黑线]  你慢慢说，别急……',
    '(*^__^*) face[嘻嘻] ，是贤心吗？'
  ];
  
  //基础配置
  layim.config({

    //初始化接口  layim-v3.8.0/示例/json/getList.json 
    init: {
      url: apiPath + sysApi + '/com.hsapi.system.im.message.getUserFriendList.biz.ext?token='+token
      ,data: {}
    }

    //查看群员接口
    /*0523,members: {
      url: apiPath + sysApi + '/com.hsapi.system.im.message.queryGroupUserInfo.biz.ext?token='+token
      ,data: {}
    }*/
    
    //上传图片接口
    ,uploadImage: {
      url: '/upload/image' //（返回的数据格式见下文）
      ,type: '' //默认post
    } 
    
    //上传文件接口
    ,uploadFile: {
      url: '/upload/file' //（返回的数据格式见下文）
      ,type: '' //默认post
    }
    
    ,isAudio: false //开启聊天工具栏音频
    ,isVideo: false //开启聊天工具栏视频
    
    //扩展工具栏
    //,tool: [{
    //  alias: 'code'
    //  ,title: '代码'
    //  ,icon: '&#xe64e;'
    //}] 
    
    //,brief: true //是否简约模式（若开启则不显示主面板）
    
    //,title: 'WebIM' //自定义主面板最小化时的标题
    //,right: '100px' //主面板相对浏览器右侧距离
    //,minRight: '90px' //聊天面板最小化时相对浏览器右侧距离
    ,initSkin: '5.jpg' //1-5 设置初始背景
    //,skin: ['aaa.jpg'] //新增皮肤
    //,isfriend: false //是否开启好友 
    //,isgroup: false //是否开启群组
    //,min: true //是否始终最小化主面板，默认false
    ,notice: true //是否开启桌面消息提醒，默认false
    ,voice: 'default.mp3' //声音提醒，默认开启，声音文件为：default.mp3
    
    ,msgbox: layui.cache.dir + 'css/modules/layim/html/msgbox.jsp' //消息盒子页面地址，若不开启，剔除该项即可
    ,find: layui.cache.dir + 'css/modules/layim/html/find.jsp' //发现页面地址，若不开启，剔除该项即可
    ,chatLog: layui.cache.dir + 'css/modules/layim/html/chatlog.jsp' //聊天记录页面地址，若不开启，剔除该项即可
    
    
  });

  /*
  layim.chat({
    name: '在线客服-小苍'
    ,type: 'kefu'
    ,avatar: 'http://tva3.sinaimg.cn/crop.0.0.180.180.180/7f5f6861jw1e8qgp5bmzyj2050050aa8.jpg'
    ,id: -1
  });
  layim.chat({
    name: '在线客服-心心'
    ,type: 'kefu'
    ,avatar: 'http://tva1.sinaimg.cn/crop.219.144.555.555.180/0068iARejw8esk724mra6j30rs0rstap.jpg'
    ,id: -2
  });
  layim.setChatMin();*/

  //监听在线状态的切换事件
  layim.on('online', function(data){
    //console.log(data);
  });
  
  //监听签名修改
  layim.on('sign', function(value){
    //console.log(value);
  });

  //监听自定义工具栏点击，以添加代码为例
  layim.on('tool(code)', function(insert){
    layer.prompt({
      title: '插入代码'
      ,formType: 2
      ,shade: 0
    }, function(text, index){
      layer.close(index);
      insert('[pre class=layui-code]' + text + '[/pre]'); //将内容插入到编辑器
    });
  });
  
  //监听layim建立就绪
  layim.on('ready', function(res){

    //console.log(res.mine);
    
    layim.msgbox(5); //模拟消息盒子有新消息，实际使用时，一般是动态获得
  
    //添加好友（如果检测到该socket）
    /*0523layim.addList({
      type: 'group'
      ,avatar: "http://tva3.sinaimg.cn/crop.64.106.361.361.50/7181dbb3jw8evfbtem8edj20ci0dpq3a.jpg"
      ,groupname: 'Angular开发'
      ,id: "12333333"
      ,members: 0
    });
    layim.addList({
      type: 'friend'
      ,avatar: "http://tp2.sinaimg.cn/2386568184/180/40050524279/0"
      ,username: '冲田杏梨'
      ,groupid: 2
      ,id: "1233333312121212"
      ,remark: "本人冲田杏梨将结束AV女优的工作"
    });*/
    
    /*setTimeout(function(){
      //接受消息（如果检测到该socket）
      layim.getMessage({
        username: "Hi"
        ,avatar: "http://qzapp.qlogo.cn/qzapp/100280987/56ADC83E78CEC046F8DF2C5D0DD63CDE/100"
        ,id: "10000111"
        ,type: "friend"
        ,content: "临时："+ new Date().getTime()
      });
      
      layim.getMessage({
        username: "贤心"
        ,avatar: "http://tp1.sinaimg.cn/1571889140/180/40030060651/1"
        ,id: "100001"
        ,type: "friend"
        ,content: "嗨，你好！欢迎体验LayIM。演示标记："+ new Date().getTime()
      });
      
    }, 3000);*/
  });

  //监听发送消息
  layim.on('sendMessage', function(data){
    
     var To = data.to; 
	 var my = data.mine;
	 var message = my.content;
	 var receiver =To.id+"";
	 if($.trim(currentsession)=='' ){
	   return;
	 } 
	 if($.trim(message)==''){
	   layer.msg("请输入要发送的消息!");
	   return;
	 }   
	 if (!window.WebSocket) {
		//判断是发送好友消息还是群消息
		 
	 }else{
		 if (socket.readyState == WebSocket.OPEN) {
	    	 //判断是发送好友消息还是群消息
	    	 if(To.type=="friend"){
	    		 sendMsg(message,receiver,null)
	    	 }else{
	    		 sendMsg(message,null,receiver)
	    	 }   
	     }   
	 }
 
    /* var To = data.to;
    //console.log(data);
    
    if(To.type === 'friend'){
      layim.setChatStatus('<span style="color:#FF5722;">对方正在输入。。。</span>');
    }
    
    //演示自动回复
    setTimeout(function(){
      var obj = {};
      if(To.type === 'group'){
        obj = {
          username: '模拟群员'+(Math.random()*100|0)
          ,avatar: layui.cache.dir + 'images/face/'+ (Math.random()*72|0) + '.gif'
          ,id: To.id
          ,type: To.type
          ,content: autoReplay[Math.random()*9|0]
        }
      } else {
        obj = {
          username: To.name
          ,avatar: To.avatar
          ,id: To.id
          ,type: To.type
          ,content: autoReplay[Math.random()*9|0]
        }
        layim.setChatStatus('<span style="color:#FF5722;">在线</span>');
      }
      layim.getMessage(obj);
    }, 1000); */
    
    
  });

  //监听查看群员
  layim.on('members', function(data){
    //console.log(data);
  });
  
  //监听聊天窗口的切换
  layim.on('chatChange', function(res){
    var type = res.data.type;
    console.log(res.data.id)
    if(type === 'friend'){
      //模拟标注好友状态
      //layim.setChatStatus('<span style="color:#FF5722;">在线</span>');
    } else if(type === 'group'){
      //模拟系统消息
      layim.getMessage({
        system: true
        ,id: res.data.id
        ,type: "group"
        ,content: '模拟群员'+(Math.random()*100|0) + '加入群聊'
      });
    }
  });
  
  /* //鼠标右键点击事件测试
  $("div").mousedown(function(e) {
    console.log(e.which);
    //右键为3
    if (3 == e.which) {
        $(this).css({
            "font-size": "-=2px"
        });
    } else if (1 == e.which) {
        //左键为1
        $(this).css({
            "font-size": "+=3px"
        });
    }
   }) */


}); 