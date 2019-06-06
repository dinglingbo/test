<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<!-- 
  - Author(s): Administrator
  - Date: 2019-05-10 17:37:06
  - Description:
-->
<head>
<title>创建群聊</title>
<script
	src="<%=request.getContextPath()%>/common/nui/jquery/jQuery-2.2.0.min.js?v=1.0.1"></script>
<%@include file="/common/sysVarCommon.jsp"%>
<link href="<%=request.getContextPath()%>/layim-v3.8.0/dist/css/modules/layim/layim.css?v=3.8.01" rel="stylesheet" type="text/css" />
<link rel="stylesheet" href="<%=request.getContextPath()%>/layim-v3.8.0/dist/css/layui.css">
<script src="<%=request.getContextPath()%>/layim-v3.8.0/dist/lay/modules/layim.js"></script>
<style type="text/css">

</style>
</head>
<body>
	<div id="layui-layim" class="layui-layer-content" style="width: 100%; height: 450px;">
		<div class="layui-layim-main" style=" top: 0px !important;  width: 49%; height: 380px; border: 1px solid black; border-top: none; border-bottom: none; border-left: none; float: left;">

			<ul id="u" class="layui-unselect layim-tab-content layim-list-friend layui-show" style="height: 380px !important;">
			
				
				<!-- <li class="layim-list-friend-group">
					<h5 layim-event="spread" lay-type="false" id="1">
						<i class="layui-icon"></i> <span>前端码屌</span> <em>(<cite class="layim-count"> 5</cite>)
						</em>
					</h5>
					<ul class="layui-layim-list ">
						<li layim-event="chat" data-type="friend" data-index="0" onclick="addMembers()"
							id="layim-friend3" class="layim-friend3 "><img
							src="http://tp1.sinaimg.cn/1571889140/180/40030060651/1"><span>贤心</span>
						<p>这些都是测试数据，实际使用请严格按照该格式返回</p>
							<span class="layim-msg-status">new</span></li>
						<li layim-event="chat" data-type="friend" data-index="0" onclick="addMembers()"
							id="layim-friend9" class="layim-friend9 "><img
							src="http://tva3.sinaimg.cn/crop.0.0.512.512.180/8693225ajw8f2rt20ptykj20e80e8weu.jpg"><span>Z_子晴</span>
						<p>微电商达人</p>
							<span class="layim-msg-status">new</span></li>
						<li layim-event="chat" data-type="friend" data-index="0" onclick="addMembers()"
							id="layim-friend102101" class="layim-friend102101 "><img
							src="http://tp2.sinaimg.cn/1833062053/180/5643591594/0"><span>Lemon_CC</span>
						<p></p>
							<span class="layim-msg-status">new</span></li>
						<li layim-event="chat" data-type="friend" data-index="0" onclick="addMembers()"
							id="layim-friend168168"
							class="layim-friend168168 layim-list-gray"><img
							src="http://tp4.sinaimg.cn/2145291155/180/5601307179/1"><span>马小云</span>
						<p>让天下没有难写的代码</p>
							<span class="layim-msg-status">new</span></li>
						<li layim-event="chat" data-type="friend" data-index="0" onclick="addMembers()"
							id="layim-friend666666" class="layim-friend666666 "><img
							src="http://tp2.sinaimg.cn/1783286485/180/5677568891/1"><span>徐小峥</span>
						<p>代码在囧途，也要写到底</p>
							<span class="layim-msg-status">new</span></li>
					</ul>
				</li>
				<li class="layim-list-friend-group"><h5 layim-event="spread"
						lay-type="false" id="2">
						<i class="layui-icon"></i><span>网红</span><em>(<cite
							class="layim-count">6</cite>)
						</em>
					</h5>
					<ul class="layui-layim-list ">
						<li layim-event="chat" data-type="friend" data-index="1"
							id="layim-friend121286" class="layim-friend121286 "><img
							src="http://tp1.sinaimg.cn/1241679004/180/5743814375/0"><span>罗玉凤</span>
						<p>在自己实力不济的时候，不要去相信什么媒体和记者。他们不是善良的人，有时候候他们的采访对当事人而言就是陷阱</p>
							<span class="layim-msg-status">new</span></li>
						<li layim-event="chat" data-type="friend" data-index="1"
							id="layim-friend100001222" class="layim-friend100001222 "><img
							src="http://tva1.sinaimg.cn/crop.0.0.180.180.180/86b15b6cjw1e8qgp5bmzyj2050050aa8.jpg"><span>长泽梓Azusa</span>
						<p>我是日本女艺人长泽あずさ</p>
							<span class="layim-msg-status">new</span></li>
						<li layim-event="chat" data-type="friend" data-index="1"
							id="layim-friend12123454" class="layim-friend12123454 "><img
							src="http://tp1.sinaimg.cn/5286730964/50/5745125631/0"><span>大鱼_MsYuyu</span>
						<p>我瘋了！這也太準了吧 超級笑點低</p>
							<span class="layim-msg-status">new</span></li>
						<li layim-event="chat" data-type="friend" data-index="1"
							id="layim-friend10034001" class="layim-friend10034001 "><img
							src="http://tp4.sinaimg.cn/1665074831/180/5617130952/0"><span>谢楠</span>
						<p></p>
							<span class="layim-msg-status">new</span></li>
						<li layim-event="chat" data-type="friend" data-index="1"
							id="layim-friend3435343" class="layim-friend3435343 "><img
							src="http://tp2.sinaimg.cn/2518326245/180/5636099025/0"><span>柏雪近在它香</span>
						<p></p>
							<span class="layim-msg-status">new</span></li>
						<li layim-event="chat" data-type="friend" data-index="1"
							id="layim-friend1233333312121212"
							class="layim-friend1233333312121212 "><img
							src="http://tp2.sinaimg.cn/2386568184/180/40050524279/0"><span>冲田杏梨</span>
						<p>本人冲田杏梨将结束AV女优的工作</p>
							<span class="layim-msg-status">new</span></li>
					</ul></li>
				<li class="layim-list-friend-group"><h5 layim-event="spread"
						lay-type="undefined" id="3">
						<i class="layui-icon"></i><span>我心中的女神</span><em>(<cite
							class="layim-count"> 2</cite>)
						</em>
					</h5>
					<ul class="layui-layim-list ">
						<li layim-event="chat" data-type="friend" data-index="2"
							id="layim-friend76543" class="layim-friend76543 "><img
							src="http://tp3.sinaimg.cn/1223762662/180/5741707953/0"><span>林心如</span>
						<p>我爱贤心</p>
							<span class="layim-msg-status">new</span></li>
						<li layim-event="chat" data-type="friend" data-index="2"
							id="layim-friend4803920" class="layim-friend4803920 "><img
							src="http://tp4.sinaimg.cn/1345566427/180/5730976522/0"><span>佟丽娅</span>
						<p>我也爱贤心吖吖啊</p>
							<span class="layim-msg-status">new</span></li>
					</ul></li> -->
			</ul>
		</div>
		<div class="layui-layim-main" style=" top: 0px !important;  width: 49%; height: 450px; float: left;">
			<ul class="layui-unselect layim-tab-content layim-list-friend layui-show" style="height: 380px !important;">
				<li class="layim-list-friend-group ">
					<h5 layim-event="spread" lay-type="false" id="1">
						 <span>已选联系人：</span> <em></em>
					</h5>
					<ul class="layui-layim-list layui-show" id="Members" >

					</ul>
				</li>
			</ul>
			<!-- <div class="layui-form-item">
			    <div class="layui-input-block" >
			      <button class=" layui-btn-xs " id="createChat" lay-submit lay-filter="createChat"  style="margin-left: 90px;margin-top: 0px;">确认</button>
			      <button  id="cancel"  lay-submit lay-filter="cancel" class=" layui-btn-xs" >取消</button>
			    </div>
 		    </div> -->
			<div class="layui-layer-btn layui-layer-btn-">
		      <a class="layui-layer-btn0" id="createChat" lay-submit lay-filter="createChat" >确认</button>
		      <a id="cancel"  lay-submit lay-filter="cancel" class="layui-layer-btn1" >取消</button>
 		    </div>
		</div>
	</div>

<script src="<%=request.getContextPath()%>/layim-v3.8.0/dist/layui.js?v=1.0.1"></script>
<script>
	var baseUrl = apiPath + sysApi + "/";
	var userHash = {};
	var userList = [];
	var tcallback = null;
	var groupId = null;
	
	function setData(id, friend,callback){
		groupId = id;
		var htmlStr = "";
		for(var i=0; i<friend.length; i++) {
			htmlStr+='<li class="layim-list-friend-group">';

			htmlStr+='<h5 layim-event="spread" lay-type="false" id="'+(i+1)+'">';

			htmlStr+='<i class="layui-icon"></i> <span>'+friend[i].groupname+'</span> <em>(<cite class="layim-count"> '+friend[i].list.length+'</cite>)</em>';

			htmlStr+='</h5>';

			htmlStr+='<ul class="layui-layim-list ">';

			for(var j=0; j<friend[i].list.length; j++) {
				htmlStr+='<li layim-event="chat" data-type="friend" data-index="0" onclick="addMembers(this)" id='+friend[i].list[j].id+' name='+friend[i].list[j].username+' class="layim-friend3 "> ';
				htmlStr+='<img src="'+friend[i].list[j].avatar+'"><span>'+friend[i].list[j].username+'</span>';
				htmlStr+='<p>'+friend[i].list[j].sign+'</p><span class="layim-msg-status">new</span></li>';
			}


			htmlStr+='</ul>';
			
			htmlStr+='</li>';
		}
		var li = document.createElement("li");
		li.innerHTML=htmlStr;
		var ul=document.getElementById("u");
		ul.appendChild(li);
		
		tcallback = callback;
	}
	
	
	
	layui.define(['layer','form', 'laytpl', 'upload'], function(exports){
	  var v = '3.8.0';
	  var $ = layui.$;
	  var layer = layui.layer;
	  var form = layui.form
	  var laytpl = layui.laytpl;
	  var device = layui.device();
	    //对外API
	  var LAYIM = function(){
	    this.v = v;
	    $('body').on('click', '*[layim-event]', function(e){
	      var othis = $(this), methid = othis.attr('layim-event');
	      events[methid] ? events[methid].call(this, othis, e) : '';
	    });
	  };
  
	    //监听事件
	  LAYIM.prototype.on = function(events, callback){
	    if(typeof callback === 'function'){
	      call[events] ? call[events].push(callback) : call[events] = [callback];
	    }
	    return this;
	  };
	  
	 //事件
	  var anim = 'layui-layer-content', events = {   
	        //展开联系人分组
	    spread: function(othis){
	      var type = othis.attr('lay-type');
	      var spread = type === 'true' ? 'false' : 'true';
	      var local = layui.data('layim')[0] || {};
	      othis.next()[type === 'true' ? 'removeClass' : 'addClass']("layui-show");
	      local['spread' + othis.parent().index()] = spread;
	      layui.data('layim', {
	        key: 0
	        ,value: local
	      });
	      othis.attr('lay-type', spread);
	      othis.find('.layui-icon').html(spread === 'true' ? '&#xe61a;' : '&#xe602;');
	    }
	  }
	  //暴露接口
  	exports('layim', new LAYIM());
 	//监听申请按钮
  	form.on('submit(createChat)', function(data){
  			if(userList.length==0) {
  				parent.layer.msg('请选择群聊成员', {
                    icon: 7,
                    time: 1000
                });
  				return;
  			}
  			
  			if(!groupId) {
	  			var mine = parent.layui.layim.cache().mine;
	  			var groupManager = {
	  				userId: mine.id,
	      			userName : mine.username
	  			}
	  			var groupName = mine.username;
	  			if(userList.length > 2) {
	  				groupName += ","+userList[0].userName;
	  				groupName += ","+userList[1].userName+"...";
	  			}else {
	  				for(var i=0; i<userList.length; i++){
	  				 groupName += ","+userList[i].userName;
	  				}
	  			}
	  			userList.push(groupManager);
	  			
				//创建群聊
			    $.ajax({
			        type:'post',
			        dataType:'json',
			        contentType:'application/json',
			        cache : false,
			        async:false, 
			        data: JSON.stringify({
			        	members: userList,
			        	name : groupName,
			        	groupManager :  groupManager       	
			        }),
			        url:baseUrl + "com.hsapi.system.im.message.createChat.biz.ext",
			        success:function(data){
			        	if(data.code=="0"){
							var index = parent.layer.getFrameIndex(window.name); 
							parent.layer.close(index);//关闭当前页  
						    //parent.layer.msg('创建成功！',{icon: 1,time: 2000});
						    tcallback(data.data); 
			        	}else{
			        		parent.layer.msg('创建异常',{icon: 7,time: 1000});
			        	}
			        }
			    });
		    }

     });
    //监听取消按钮
    form.on('submit(cancel)', function(data){
			var index = parent.layer.getFrameIndex(window.name); 
			parent.layer.close(index);//关闭当前页  
	     });
	}).addcss(
	  'modules/layim/layim.css?v=3.8.0'
	  ,'skinlayimcss'
	);
	
	function addMembers(obj){
		if(userHash[obj.id]) return; 
	    var eList = obj.children;
	    var imgSrc = eList[0].src;
	    var p = eList[2].innerText;
	    var name = obj.getAttribute("name");
	    var user = {
	    	userId:obj.id,
	    	userName:name
	    };
		htmlStr = "";
		htmlStr+='<li layim-event="chat" data-type="friend" data-index="0" id='+obj.id+' name='+name+' class="layim-friend3" onclick="delMembers(this)">';
		htmlStr+='	<img src='+imgSrc+'>'; 
		htmlStr+='	<span>'+name+'</span>';
		htmlStr+='  <p>'+p+'</p>';
		htmlStr+='	<span class="layim-msg-status">new</span>';
		htmlStr+='</li>';
		
		var li = document.createElement("li");
		li.innerHTML=htmlStr;
		var ul=document.getElementById("Members");
		ul.appendChild(li);
		
		userHash[obj.id] = user;
		userList.push(user);
	
		//$("#Members").html(htmlStr);
	}
	
	function delMembers(obj) {
		obj.parentElement.remove();
		var id = obj.id;
		for(var i=0;i<userList.length;i++) {
			var u = userList[i];
			if(id==u.userId) {
				userList.splice(i,1);
			}
		}
		
		delete userHash[id];
		
	}

</script>
</body>
</html>