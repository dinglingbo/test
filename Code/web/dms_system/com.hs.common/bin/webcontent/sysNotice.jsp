<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false" %>
    
 <link href="<%=webPath + contextPath%>/common/css/naranja.min.css?v=1.0.0" rel="stylesheet"	type="text/css" />
 <script src="<%=webPath + contextPath%>/common/js/naranja.js?v=1.0.4" type="text/javascript"></script>    
 
 <script type="text/javascript">
    //  调用的例子
	function narn (type) { 
        naranja()[type]({
            title: '新消息提示',
            text: '单击“接受”以创建新通知',
            timeout: 'keep',
            buttons: [{
                text: '接受',
                click: function (e) {
                    naranja().success({
                        title: '通知',
                        text: '通知被接受'
                    })
                }
            },{
                text: '取消',
                click: function (e) {
                    e.closeNotification()
			    }
		    }]
		})
    }
      
    function showNotice({//仅显示标题和内容
        type:type,
        title:title,
        text:text,
        timeout:timeout,
    }) {
        naranja()[type]({
            title: title,
            text: text,
            timeout: timeout
        });
    }


    function showNoticeWithBtn({//显示标题和内容 附加按钮
        type:type,
        title:title,
        text:text,
        timeout:timeout,
        onOK:onOK,
        onCancel:onCancel
    }) {
        naranja()[type]({
            title: title,
            text: text,
            timeout: timeout,
            buttons: [{
                text: '确定',
                click: function (e) {
                    onOK&&onOK();
                }
            },{
                text: '取消',
                click: function (e) {
                    e.closeNotification();
                    onCancel&&onCancel();
			    }
		    }]
        });
    }

</script>