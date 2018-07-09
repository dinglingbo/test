<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<!-- 
  - Author(s): Administrator
  - Date: 2018-01-31 16:54:43
  - Description:
-->
<head>
<title>主窗口</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
    <script src="<%= request.getContextPath() %>/common/nui/nui.js" type="text/javascript"></script>
    
</head>
<body>
    <form id="queryForm" method="post" url="", target="myiframe">
        请输入零件号：<input type="text" id="material" name="material" /> 
        <input type="hidden" id="onInputProcessing" name="onInputProcessing" value="atp_all" />
        <input type="hidden" id="contentClip" name="contentClip" />
        <input type="hidden" id="req_date" name="06.07.2018" />
        <input type="hidden" id="x" name="x" />
        <input type="hidden" id="y" name="y" />
        
        <input type="hidden" id="Username" name="Username" value="38256par" />
        <input type="hidden" id="Password" name="Password" value="1qaz2wsx" />
        
        <input type="button" onclick="search()" value="查询" />
    </form>
    <div id="content">

    </div>

    <form id="login" method="post" url="", target="myiframe">
    </form>

    <iframe name="myiframe" id="myiframe" src="" frameborder="1" align="left" width="100%" height="200px" scrolling="auto">
        <p>你的浏览器不支持iframe标签</p>
    </iframe>

<script>

    //init();

    function search(){
        var urla = "https://www.dwp.bmw-brilliance.cn/sap(bD1lbiZjPTEwMA==)/bc/bsp/bmw/gis_tp_par_dev/spp05_stock_check.htm";
        var urlb = "https://www.dwp.bmw-brilliance.cn/sap(bD1lbiZjPTEwMA==)/bc/bsp/bmw/gis_tp_par_dev/SPP05_Stock_RESULT.htm?sap-params=bGZfbWF0ZXJpYWw9MDAwMDAwMDAxNDAyOTgyNjkzJnJlcV9kYXRlPTA2LjA3LjIwMTgmcmVxX3J1bGU9JmVycl9kYXRlPSZyZXN1bHRfZGlzcGxheT1YJmxmX3ZpZXdfYWx0cGFydHM9";
        var parts = $("#material").val();
        var params = {
                "onInputProcessing": "atp_all",
                "contentClip": "",
                "req_date": "06.07.2018",
                "material": parts,
                "x": parseInt(10*Math.random()),
                "y": parseInt(10*Math.random())
        };
        
        /*$("#x").val(parseInt(10*Math.random()));
        $("#y").val(parseInt(10*Math.random()));
        $("#queryForm").attr("action", urla);
        $("#queryForm").submit();*/
        doAjax(urla, params, processData2);
    }
    
    function processData2(json){
        $("#content").html(json);
    }
    
    function init(){
        var iframe = document.getElementById("myiframe"); //获取iframe标签
        iframe.addEventListener("load", function(){
                 //代码能执行到这里说明已经载入成功完毕了
              this.removeEventListener("load", arguments.call, false);
                 //这里是回调函数
                 processData();
        }, false);
    }

    function processData(){
        var iframe = document.getElementById("myiframe"); //获取iframe标签
        var iwindow = iframe.contentWindow; //获取iframe的window对象
        var idoc = iwindow.document; //获取iframe的document对象
        console.log(idoc.documentElement); //获取iframe的html
        console.log("body",idoc.body);
    }

    function doAjax(url, params, callBack){
        $.jsonp({
            url: url,
            type: "post",
            
            //dataType:'jsonp',
            //processData: false, 
     
            data: params,
            beforeSend: function(xhr) {
                xhr.setRequestHeader("Authorization", "Basic MzgyNTZwYXI6MXFhejJ3c3g=");
            },
            //contentType: 'text/json',
            success: function (json) {
                callBack(json);
            },
            error:function(XMLHttpRequest, textStatus, errorThrown) {
               alert(XMLHttpRequest.status);
               alert(XMLHttpRequest.readyState);
               alert(textStatus);
            }
        });
        
        
        
        /*$.jsonp({
          "url": url,
          "success": function(data) {
            $("#current-group").text("当前工作组:"+data.result.name);
          },
          "error": function(d,msg) {
            alert("Could not find user "+msg);
          }
        });*/
    }
</script>
</body>
</html>