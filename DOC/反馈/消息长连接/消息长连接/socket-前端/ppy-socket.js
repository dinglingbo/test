
// 公共 websocket 插件
// 功能，连接，发送消息，接收消息，
// 插件构造函数
// 公共测试地址 wss://echo.websocket.org/
function ppySocket(obj) {
  /** obj 参数
   * url        -   连接地址
   * reconnect  -   是否断开重新连接
   * ajaxUrl    -   接口请求域名
   */
  this.ws = null;
  this.reconnect = obj.reconnect;
  this.connecting = false; // 是否正在连接中
  this.url = ''; // websocket连接地址
  this.ajaxUrl = obj.ajaxUrl || '';
  this.maxFdBox = 10; // 反馈置顶弹框 z-index 从10开始
  this.connTimer = null; // 一次性定时器
  this.connInterval = null; // 周期性定时器
  this.heart = 120; // 心跳间隔时间
  this.reConnTime = 0; // 心跳重连次数
  this.maxReconn = 10; // 允许的最大重连次数

  var isString = typeof obj === 'string';
  var isObject = Object.prototype.toString.call(obj) === '[object Object]';
  if (isString) {
    this.url = obj;
  }
  if (isObject) {
    this.url = obj.url;
  }
  if (!isString && !isObject) {
    throw new Error('构造函数传入参数类型只能为字符串或对象');
  }
  if (this.url !== '') {
    // 连接 websocket
    // this.ws = new WebSocket(this.url);
    this.ws = new WebSocket(this.url);
    this.open()
  }
}
// 开始连接
ppySocket.prototype.conn = function () {
  if (this.reConnTime > this.maxReconn) { // 超过最大连接次数，不再连接
    return false;
  }
  var _this = this;
  if (this.connecting) {
    return false;
  }
  this.ws = null;
  console.log('start conn', this.reConnTime);
  this.reConnTime++;
  this.connecting = true;
  setTimeout(function() {
    _this.ws = new WebSocket(_this.url);
    _this.open();
    _this.connecting = false;
  }, 2000);
}
// 连接初始化
ppySocket.prototype.init = function () {
  this.close();
  this.jqInit();
}
// 打开连接
ppySocket.prototype.open = function (callback) {
  var _this = this;
  this.ws.addEventListener('open', function (event) {
    console.log('conn succ')
    _this.closeHeart().startHeart();
    _this.init();
    callback && callback();
  });
}
// 监听关闭事件
ppySocket.prototype.close = function (callback) {
  var _this = this;
  this.ws.addEventListener("close", function (event) {
    _this.connecting = false;
    var code = event.code; // 服务器发送的连接关闭代码
    var reason = event.reason; // 连接是否已完全关闭
    var wasClean = event.wasClean; // 关闭来自服务器的close帧的响应，为true;其他为false
    console.log('websocket 断开: ' + code + ' ' + reason + ' ' + wasClean)
    // 如果不是服务器断开的，则开始重连
    // _this.conn();
    // handle close event
    callback && callback(event);
  });
}
// 收到服务器消息
ppySocket.prototype.message = function (callback) {
  var _this = this;
  this.ws.addEventListener("message", function (event) {
    var retData = event.data;
    
    var data = _this.isJsonString(retData) ? JSON.parse(retData) : retData;
    // 处理数据
    callback && callback(data, event);
  });
}
// 发送消息给服务器
ppySocket.prototype.send = function (msg) {
  if (+this.ws.readyState !== 1) {
    console.log('正在连接中，请稍后');
    return false;
  }
  // 可以发送文本和二进制数据(包括ArrayBuffer和blob)数据
  this.ws.send(msg);
}
// 获取未发送的二进制数据大小
ppySocket.prototype.sendRemain = function () {
  return this.ws.bufferedAmount;
}
// 判断是否发送完毕
ppySocket.prototype.isSendEnd = function () {
  return this.ws.bufferedAmount === 0;
}
// 开始心跳连接
ppySocket.prototype.startHeart = function() {
  var _this = this;
  _this.connInterval = setTimeout(function() {
    _this.send('1');
    _this.connTimer = setTimeout(function() {
      // 如果指定时间之内，没有关闭此定时器，则关闭socket连接，重新连接
      console.log('超时关闭连接');
      _this.ws.close();
      _this.conn();
    }, _this.heart * 1000);
  }, _this.heart * 1000);
}
// 关闭心跳连接
ppySocket.prototype.closeHeart = function() {
  clearTimeout(this.connTimer);
  this.connTimer = null;
  clearTimeout(this.connInterval);
  this.connInterval = null;
  return this;
}
// 接收消息处理
ppySocket.prototype.jqInit = function() {
  // 接收消息
  var _this = this;
  this.message(function(msg, data) {
    // 重置定时器
    _this.closeHeart().startHeart();
    console.log('recieve', msg);
    var rMsg = msg;
    var code = +rMsg.message_code;
    var timer = null;
    var timeStamp = +new Date();
    var omitTxt = '';
    // 如果返回消息是 1 ， 则说明保持连接，重置 10s 定时器， 
    // 10 s定时器监控socket是否还在保持连接，如果10s没返回，说明连接出现了问题，关闭连接，重新连接

    if (rMsg.content && rMsg.content.length > 60) {
      omitTxt = rMsg.content.substr(0, 60) + '...';
    } else {
      omitTxt = rMsg.content || '';
    }
    if (code === 80001) { // 系统消息
      _this.showSystemMsg(timeStamp, rMsg, omitTxt);
    } else if (code === 80002) { // 反馈消息
      _this.showFeedbackMsg(timeStamp, rMsg, omitTxt);
    } else if (code === 80003) { // 临时消息
      _this.showInterimMsg(timeStamp, rMsg, omitTxt);
    } else if (code === 80004) { // 浮层广告
      _this.prodBroadcast(timeStamp, rMsg)
    }
  })
}
// 显示系统消息弹框到右上角
ppySocket.prototype.showSystemMsg = function(timeStamp, rMsg, omitTxt) {
  var _this = this;
  var $body = $(document.body);

  // 创建右上角消息列表容器
  var msgsList = $('.s-msgs-list.t-r');
  if (msgsList.length <= 0) {
    $body.append('<div class="s-msgs-list t-r"></div>');
  }
  // 弹出单条消息
  var sysHtml = '<div class="socket-msgs animated fadeInDown" data-time="'+ timeStamp +'">'+
  '        <div class="socket-msgs-content">'+
  '          <h1>'+ rMsg.title +'</h1>'+
  '          <p class="s-content">'+ omitTxt +'</p>'+
  '          <div style="min-height:18px">';
  sysHtml += rMsg.content.length > 60 ? '<a href="javascript:;" style="color:#0076FF" class="msg-detail">查看详情</a>' : '';
  sysHtml += '            <a href="javascript:;" class="s-close-btn">关闭</a>'+
  '          </div>'+
  '        </div>'+
  '      </div>';
  $('.s-msgs-list.t-r').prepend(sysHtml);

  var sockMsgEl = $('.socket-msgs[data-time='+timeStamp+']');
  // 查看详情
  sockMsgEl.on('click', '.msg-detail', function(e) {
    _this.showSystemDetail(timeStamp, rMsg);
  })

  sockMsgEl.on('click', '.s-close-btn', function(e) {
    var item = $(this).closest('.socket-msgs');
    item.remove();
    // 如果消息内容超过60个字符，接口消息已读
    if (rMsg.length > 60) {
      // 消息设置为已读
      _this.setRead(rMsg.inid);
    }
  })

  // 定时器自动关闭
  setTimeout(function() {
    sockMsgEl.remove();
  }, rMsg.msg_exist_time * 1000);
}
// 打开系统消息居中弹框
ppySocket.prototype.showSystemDetail = function(timeStamp, rMsg) {
  var $body = $(document.body);
  var lastSys = $('.s-system-c:last');
  var lTop = 0;
  var lLeft = 0;
  if (lastSys.length > 0) {
    lTop = parseInt(lastSys.css('top'));
    lLeft = parseInt(lastSys.css('left'));
    console.log(lTop, lLeft)
  }
  var nTop = lTop === 0 ? 0 : (lTop + 15);
  var nLeft = lLeft === 0 ? 0 : (lLeft + 15);
  // $('.s-system-c').remove();
  var cHtml = '';
  if (lastSys.length === 0) {
    cHtml += '<div class="s-system-c" data-time="'+ timeStamp +'">';
  } else {
    cHtml += '<div class="s-system-c" data-time="'+ timeStamp +'" style="top:'+ nTop +'px;left:'+ nLeft +'px">';
  }
  cHtml += '      <h1 class="tit">'+ rMsg.title +'</h1>'+
  '      <p class="content">'+ rMsg.content +'</p>'+
  '      <a href="javascript:;" class="s-close-btn"></a>'+
  '    </div>';
  $body.append(cHtml);
  // 点击居中弹框的关闭按钮，关闭弹框
  $('.s-system-c').on('click', '.s-close-btn', function(e) {
    var $this = $(this);
    $this.closest('.s-system-c').remove();
  })
  // 关闭消息提示
  $('.socket-msgs[data-time='+timeStamp+']').remove();
  // 接口消息已读
  _this.setRead(rMsg.inid);
}
// 打开右上角反馈消息弹框
ppySocket.prototype.showFeedbackMsg = function(timeStamp, rMsg, omitTxt) {
  var _this = this;
  var $body = $(document.body);
  // 创建右上角消息列表容器
  var msgsList = $('.s-msgs-list.t-r');
  if (msgsList.length<=0) {
    $body.append('<div class="s-msgs-list t-r"></div>');
  }
  // 弹出单条消息
  var sysHtml = '<div class="socket-msgs animated fadeInDown" data-time="'+ timeStamp +'">'+
  '        <div class="socket-msgs-content">'+
  '          <h1>'+ rMsg.title +'</h1>'+
  '          <p class="s-content">'+ omitTxt +'</p>'+
  '          <div style="min-height:18px">'+
  '          <a href="javascript:;" style="color:#0076FF" class="msg-detail">查看详情</a>'+
  '            <a href="javascript:;" class="s-close-btn">关闭</a>'+
  '          </div>'+
  '        </div>'+
  '      </div>';
  $('.s-msgs-list.t-r').prepend(sysHtml);

  // 反馈详情
  $('.socket-msgs[data-time='+timeStamp+']').on('click', '.msg-detail', function(e) {
    _this.showFeedBackDetail(timeStamp, rMsg, 'socket');
    $('.socket-msgs[data-time='+timeStamp+']').remove();
  });

  // 点击关闭消息
  $('.socket-msgs[data-time='+timeStamp+']').on('click', '.s-close-btn', function(e) {
    var item = $(this).closest('.socket-msgs');
    item.remove();
  })

  // 定时器自动关闭
  setTimeout(function() {
    $('.socket-msgs[data-time='+timeStamp+']').remove();
  }, rMsg.msg_exist_time * 1000);
}
// 打开居中反馈消息详情弹框
ppySocket.prototype.showFeedBackDetail = function(timeStamp, data, origin) {
  // 传入的数据为反馈详情
  var _this = this;
  // 调接口，拿数据，拿到显示在页面上
  this.getFeddbackDetail(data.fid, function(detail) {
    var $body = $(document.body);
    var lastFd = $('.s-feedback:last');
    var submitting = false;
    var lTop = 0;
    var lLeft = 0;
    if (lastFd.length > 0) {
      lTop = parseInt(lastFd.css('top'));
      lLeft = parseInt(lastFd.css('left'));
    }
    var nTop = lTop === 0 ? 0 : (lTop + 15);
    var nLeft = lLeft === 0 ? 0 : (lLeft + 15);
    // 详情数据二次处理
    var fdStatus = {
      0: '待处理',
      1: '已解决',
      2: '待回复',
      3: '不采纳',
      21: '已回复'
    };
    var fdImgs = detail.feedback_imgurl ? detail.feedback_imgurl.split(',') : [];
    var replays = detail.reply || [];
    // 获取反馈详情，放入页面中
    var cHtml = '';
    if (lastFd.length === 0) {
      cHtml += '<div class="s-feedback" data-time="'+ timeStamp +'" style="z-index:'+ _this.maxFdBox +'">';
    } else {
      cHtml += '<div class="s-feedback" data-time="'+ timeStamp +'" style="z-index:'+ _this.maxFdBox +';top:'+ nTop +'px;left:'+ nLeft +'px">';
    }
    cHtml += '      <div class="fd-head">反馈详情<a class="fd-close-btn"></a></div>'+
    '      <div class="fd-section"><div class="fd-answer">'+
    '        <div class="fd-f-item">';
    cHtml += '          <span class="fd-f-lf">';
    cHtml += fdImgs.length>0 ? '<img src="'+ fdImgs[0] +'" />' : '';
    cHtml += '</span>';
    cHtml += '          <span class="fd-f-rt">'+
    '            <p>2018-9-8 11:56:11 <span style="float:right">待回复</span></p>'+
    '            <p>问题类型：'+ detail.advise_type +'</p>'+
    '            <p>问题描述: '+ detail.advise +'</p>'+
    '          </span>'+
    '        </div>'+
    '        </div><div class="fd-feed-areas">';
    // 回复处理
    for(var i = 0;i < replays.length;i++) {
      var replayItem = replays[i];
      var itemImgs = replayItem.img;
      cHtml += '        <div class="fd-f-item text-center">'+
      '          <span class="fd-f-content hui">'+ replayItem.time +'</span>'+
      '        </div>'+
      '        <div class="fd-f-item">'+
      '          <span class="fd-f-tit '+ (replayItem.type === 'reply' ? 'fd-head-kefu' : 'fd-head-me') +'">';
      cHtml += (replayItem.type === 'reply') ? '<i class="iconfont icon-kefu"></i>' : '<span>我</span>';
      cHtml += '</span>'+
      '          <span class="fd-f-content">'+ replayItem.content +
      '            <ul class="fd-img-look">';
      for(var j = 0;j < itemImgs.length;j++) {
        cHtml += '<li><img src="'+ itemImgs[j] +'" alt=""></li>';
      }
      cHtml += '            </ul>'+
      '          </span>'+
      '        </div>';
    }
    // 追加处理
    cHtml += '        <p class="fd-cut-line feedback-cutline" style="display:none"></p>'+
    '        <div class="fd-f-item add-feedback hide">'+
    '          <span class="fd-f-tit">补充问题：</span>'+
    '          <span class="fd-f-content">'+
    '            <textarea rows="5" class="fd-reply"></textarea>'+
    '          </span>'+
    '        </div>'+
    '      </div></div>';
    cHtml += detail.status === 1 ? '' : '      <div class="fd-foot fd-sub">'+
    '        <a href="javascript:;" class="s-add-ans" data-ans="1">补充问题</a>'+
    '        <a href="javascript:;" class="s-know">结束此反馈</a>'+
    '      </div><div class="fd-foot fd-add" style="display:none"><a class="fd-cancle">取消</a><a class="fd-submit">提交</a></div>';
    cHtml += '    </div>';
    // data-ans:   1 - 补充问题；  2 - 提交问题
    $body.append(cHtml);
    _this.maxFdBox++;
    // 反馈消息设置为已读
    if (origin === 'socket') {
      _this.setRead(data.inid);
    }

    var nFdBox = $('.s-feedback[data-time=' + timeStamp + ']');
    // 滑入消息区域，禁止body滚动
    nFdBox.on('mouseover', function(e) {
      _this.noScroll();
    })
    nFdBox.on('mouseout', function(e) {
      _this.canScroll()
    })
    // 点击置顶弹框
    nFdBox.mousedown(function(e) {
      $(this).css('z-index', _this.maxFdBox+1);
      _this.maxFdBox++;
    })
    // 取消提问
    nFdBox.on('click', '.fd-cancle', function(e) {
      nFdBox.find('.feedback-cutline').css('display', 'none');
      nFdBox.find('.add-feedback').addClass('hide');
      nFdBox.find('.fd-add').css('display', 'none');
      nFdBox.find('.fd-sub').css('display', 'flex');
    })
    // 提交提问
    nFdBox.on('click', '.fd-submit', function(e) {
      if (submitting) {
        return false;
      }
      // 调追加问题接口
      var params = {
        advise: nFdBox.find('.fd-reply').val(),
        fid: detail.fid,
        imageData: ''
      };
      if (params.advise.trim() === '') {
        // alert('提问内容不能为空');
        _this.msg('提问内容不能为空');
        return false;
      }
      submitting = true;
      _this.post({
        url: '/userfeedback/edit',
        data: params,
        success(res) {
          if (res && res.code === 1) {
            _this.canScroll();
            nFdBox.remove();
            _this.msg('反馈成功');
          } else {
            res && res.msg && alert(res.msg);
          }
        },
        complete() {
          submitting = false;
        }
      });
    })
    // 点击补充问题，问题输入框显示出来，然后滚动到最下面的问题输入框
    nFdBox.on('click', '.fd-foot .s-add-ans', function(e) {
      var $this = $(this);
      nFdBox.find('.feedback-cutline').css('display', 'block');
      nFdBox.find('.add-feedback').removeClass('hide');
      var $el = nFdBox.find('.fd-feed-areas');
      var h = $el[0].scrollHeight;
      $el.scrollTop(h - nFdBox.find('.fd-feed-areas').height());
      nFdBox.find('.fd-sub').css('display', 'none');
      nFdBox.find('.fd-add').css('display', 'block');
    })
    // 弹框拖动事件
    nFdBox.find('.fd-head').mousedown(function(ev) {
      console.log(ev.target);
      
      var $tar = $(ev.target);
      var lf = parseInt(nFdBox.css('left'));
      var rt = parseInt(nFdBox.css('top'));
      var mX = parseInt(_this.getMouseXY(ev).x);
      var mY = parseInt(_this.getMouseXY(ev).y);

      document.onmousemove=function(ev) {
        var msX = parseInt(_this.getMouseXY(ev).x);
        var msY = parseInt(_this.getMouseXY(ev).y);
        var l = lf + (msX - mX);
        var t = rt + (msY - mY);
        if (l <= 0) {
          l = 0;
        }
        if (t <= 0) {
          t = 0;
        }
        
        nFdBox.css('left', l + 'px');
        nFdBox.css('top', t + 'px');
      }
      document.onmouseup = function() {
        document.onmousemove = null
        document.onmouseup = null
      }
    });
    // 关闭消息提示
    nFdBox.on('click', '.s-know', function(e) {
      _this.get({
        url: '/userfeedback/finish',
        data: {
          fid: detail.fid,
        },
        success(res) {
          if (res && res.code === 1) {
            _this.msg('反馈已结束，谢谢您的反馈！');
            setTimeout(function() {location.reload()}, 800);
          } else {
            res.msg && console.log(res.msg);
          }
        }
      });
      nFdBox.remove();
    })
    // 图片预览
    nFdBox.on('click', 'img', function(e) {
      var $this = $(this);
      $('.fd-img-prev').remove();
      var src = $this.attr('src');
      var html = '<div class="fd-img-prev"><a href="javascript:;" class="img-prev-close">×</a>'+
      '      <div class="fd-img-flex">'+
      '        <span>'+
      '          <img src="'+ $this.attr('src') +'" alt="">'+
      '        </span>'+
      '      </div>'+
      '    </div>';
      $body.append(html);
      // 关闭预览函数
      function closeImg() {
        $('.fd-img-prev').remove();
        _this.canScroll()
      }
      // 禁止页面滚动
      _this.noScroll();
      // 点击关闭预览
      $('.fd-img-prev').on('click', '>div, >span, >a', function(e) {
        var tar = e.target;
        if (tar.tagName !== 'IMG') {
          closeImg();
        };
      })
    })
    // 关闭反馈消息弹框
    nFdBox.on('click', '.fd-close-btn', function(e) {
      nFdBox.remove();
      _this.canScroll()
    })
  });
}
// 打开临时消息右下角弹出
ppySocket.prototype.showInterimMsg = function(timeStamp, rMsg, omitTxt) {
  var $body = $(document.body);
  if ($('.s-pop-msg').length<=0) {
    $body.append('<div class="s-pop-msg"></div>');
  }
  var popNum = $('.s-pop-msg').find('.s-pop-con');
  if (popNum.length >= 2) {
    popNum[0].remove()
  }
  $('.s-pop-msg').append('<div class="s-pop-con animated fadeInRight" data-time="'+ timeStamp +'">'+ rMsg.content +'</div>');
  // 定时器自动关闭
  setTimeout(function() {
    $('[data-time='+timeStamp+']').remove();
  }, rMsg.msg_exist_time * 1000);
}
ppySocket.prototype.getMouseXY = function(e) {
  var x = 0, y = 0;
  e = e || window.event;
  if (e.pageX) {
    x = e.pageX;
    y = e.pageY;
  } else {
    x = e.clientX + document.body.scrollLeft - document.body.clientLeft;
    y = e.clientY + document.body.scrollTop - document.body.clientTop;
  }
  return {
    x: x,
    y: y
  };
}
// 生成浮层广告轮播图
ppySocket.prototype.prodBroadcast = function(timeStamp, rMsg) {
  var _this = this;
  var $body = $(document.body);
  // 移除原来的浮层广告
  $body.find('.s-broadcast').remove();
  var adsData = rMsg.data || [];
  var adHtml = '<div class="s-broadcast">'+
  '      <i class="shade"></i>'+
  '      <a href="javascript:;" class="ads-close">×</a>'+
  '      <div id="broadcastBox"></div>'+
  '    </div>';
  $body.append(adHtml);
  var $broadcast = $('.s-broadcast');

  this.noScroll()
  // 关闭广告弹框
  function closeAd() {
    $broadcast.remove();
    _this.canScroll()
  }
  $broadcast.on('click', '.ads-close', function(e) {
    closeAd();
  })
  // 轮播初始化
  var box = $('#broadcastBox')[0];
  var imagesAndUrl = adsData.map(function(item) {
    return {
      imgSrc: item.pic_url,
      linkHref: (item.url === '') ? null : item.url
    }
  });
  var broadcast = new Broadcast(box,imagesAndUrl,{
    transitionTime: 600, // 动画过渡时间，默认为800ms
    intervalTime: 3000 // 图片切换时间，默认为5s
  });
  if (rMsg.msg_exist_time !== -1) {
    setTimeout(function() {
      closeAd();
    }, rMsg.msg_exist_time * 1000);
  }
}
// 禁止页面滚动
ppySocket.prototype.noScroll = function() {
  $(document.body).css({
    overflow: 'hidden',
    height: '100%'
  });
}
// 解禁页面滚动
ppySocket.prototype.canScroll = function() {
  $(document.body).css({
    overflow: 'auto',
    height: 'auto'
  });
}
// 发送消息已读
ppySocket.prototype.setRead = function(msgId) {
  this.get({
    url: '/user/msglocalread',
    data: {
      inid: msgId
    },
    success(res) {
      if (res && res.code === 1) {
        console.log('read has set');
      } else {
        res.msg && console.log(res.msg);
      }
    }
  });
}
// 获取反馈详情接口
ppySocket.prototype.getFeddbackDetail = function(fid, succ) {
  this.get({
    url: '/userfeedback/detail',
    data: {
      fid: fid
    },
    success(res) {
      // 获取成功，弹出反馈详情弹框
      if (res && res.code === 1) {
        succ && succ(res.data);
      } else {
        res && res.msg && alert(res.msg);
      }
    }
  });
}
// 发get请求
ppySocket.prototype.get = function(obj) {
  $.ajax({
    url: this.ajaxUrl + obj.url,
    method: 'get',
    contentType: obj.contentType || 'application/x-www-form-urlencoded; charset=UTF-8',
    data: obj.data,
    // dataType: 'json',
    headers: obj.headers || {},
    success: obj.success,
    error: obj.error,
    complete: obj.complete
  });
}
// 发post请求
ppySocket.prototype.post = function(obj) {
  var params = [];
  if (obj.data) {
    for(var key in obj.data) {
      params.push(key+'='+obj.data[key]);
    }
  }
  $.ajax({
    url: this.ajaxUrl + obj.url + '?' + params.join('&'),
    method: 'post',
    contentType: obj.contentType,
    data: obj.data,
    headers: obj.headers || {},
    success: obj.success,
    error: obj.error,
    complete: obj.complete
  });
}
// 判断是否是 json 串
ppySocket.prototype.isJsonString = function(str) {
  try {
    if (typeof JSON.parse(str) == "object") {
      return true;
    }
  } catch (e) {}
  return false;
}
// 弹出公共弹框
ppySocket.prototype.msg = function(msg, time) {
  time = time || 1.5;
  // time - 单位是s
  var $body = $(document.body);
  var html = '<div class="s-all-msg">'+
  '      <p class="s-msg-con">'+ msg +'</p>'+
  '    </div>';
  $body.append(html);
  setTimeout(function(params) {
    $('.s-all-msg').remove();
  }, time * 1000);
}

// 连接状态判断
ppySocket.prototype.stdOutStatus = function () {
  var status = this.ws.readyState;
  if (+status === 0) {
    console.log('websocket 正在连接');
  } else if (+status === 1) {
    console.log('websocket 连接成功');
  } else if (+status === 2) {
    console.log('websocket 正在关闭');
  } else if (+status === 3) {
    console.log('websocket 已经关闭');
  }
  return status;
}
