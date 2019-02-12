<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" session="false"%>
 <%@include file="/common/sysCommon.jsp"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<!-- 
  - Author(s): Administrator
  - Date: 2018-05-27 15:11:00
  - Description: 
--> 
<head>
    <title>门店信息</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
  	<script src="<%=webPath + contextPath%>/common/js/orgExtendEdit.js?v=2.0.4" type="text/javascript"></script>
  	<script src="<%=webPath + contextPath%>/common/js/qiniu.min.js" type="text/javascript"></script>



  <style type="text/css">
    body {
       margin: 0;
       padding: 0;
       border: 0;
       width: 100%;
       height: 100%;
       overflow: hidden;
   }

    /*body.back{background:LightSteelBlue;}*/
   #table1
   {

    border-collapse:collapse;
    table-layout:fixed;
    font-weight:bold;
    left:0;right:0;   
    margin:0 auto;
    padding:1px 0px 1px 0px;


}
.pic { /* 页面logo图片 */
background-image: <%-- url(<%=request.getContextPath()%>/eos/A/jsp/Main.png) --%>;
background-repeat: no-repeat;
background-size: 100% 100%;
border-radius: 4px;
}

#table1  tr
{
  height:40px; 
} 
 .spanwidth
{
   width:10px; 
  display: inline-block;
} 

.tabwidth{
    width:800px;
}
.tbtext{
    float: right; 
    line-height: 40px;
}
.mini-textbox{
    height: 28px;
    display: inline;
}
.mini-textbox-border{ 
    height: 25px;
} 
.mini-textbox-input{/* 输入框的里面的高度 */
    height: 24px;
}

.mini-buttonedit {
    height: 28px;
}

.mini-buttonedit-border {
    height: 25px;
}

.mini-buttonedit-input {
    height: 24px;
}
.mini-buttonedit-buttons{
    top:3px;
    right: 10px;
}
.mini-buttonedit-button{
    border-left:0px;
}

.mini-buttonedit-button-pressed, .mini-buttonedit-popup .mini-buttonedit-button {
    background: #fff;
    color: #333333;
    border-width: 0px;
     border-left: 0px;
}

.mini-buttonedit-popup .mini-buttonedit-button
{
    background: #fff;
    border-width:0px;
    border-left: 0px ;
}

.mini-buttonedit-button-hover,
.mini-buttonedit-hover .mini-buttonedit-button
{
    color:#333;     
    background:#fff;
    border-width:0px;
    border-left: 0px ;
}
.checkboxwidth{
    width: 65px;
    margin-left:20px;
}
.textboxwidth{
    width:200px;
}
.inline{
    width:320px ;
    display:inline-block !important;
} 
</style> 
</head> 
<body class="back">
    <div class="nui-fit">  
    <div class="nui-toolbar" style="padding:0px;">
                <table style="width:100%;">
                    <tr>
                        <td style="width:100%;">
                            <a class="nui-button" onclick="save('no')" plain="true" style="width: 60px;"><span class="fa fa-save fa-lg"></span>&nbsp;保存</a>
                            <a class="nui-button" onclick="Oncancel()" plain="true"  style="width: 60px;"><span class="fa fa-remove fa-lg"></span>&nbsp;取消</a>
                        </td>
                    </tr>
                </table>
            </div>
        <div class="form"id="basicInfoForm" name="basicInfoForm" style="width:950px;height:100%;left:0;right:0;margin: 0 auto;">
        		     
           <table  id="table1">

            <tr >
                <td class="tbtext">LOGO图片<span class="spanwidth"></span>   </td>
                <td  colspan="5" class="tabwidth">
                	<div class="pic" style="width:64px;height:64px;border:1px solid #ccc; "></div>
                </td>
				
            </tr> 

            <tr>
                <td class="tbtext">企业号<span style="color:red">*</span></td>
                <td colspan="5"><input class="nui-textbox tabwidth" name="code" id="code" vtype="maxLength:5"/></td>
				<td><input class="nui-textbox tabwidth" name="orgid" id="orgid" visible="false"/></td>
            </tr>    
            
            <tr>
                <td class="tbtext">公司全称<span style="color:red">*</span></td>
                <td colspan="3"><input class="nui-textbox tabwidth" name="name" id="name"/></td>
                <td class="tbtext">公司简称<span style="color:red">*</span></td>
                <td><input class="nui-textbox tabwidth" name="shortName" id="shortName"/></td>

            </tr>               

		
            <tr>
                <td style="width:100px;text-align:right;" class="tbtext">省份<span style="color:red">*</span></td>
                <td style="width:200px;text-align:left;"><input class="nui-combobox textboxwidth" name="provinceId" id="provinceId"  allowinput="true" valueField="code" textField="name" data="list" onvaluechanged="onProvinceChange" /></td>
                <td style="width:100px;text-align:right;"class="tbtext">城市<span style="color:red">*</span></td>
                <td style="width:200px;text-align:left;"><input class="nui-combobox textboxwidth" name="cityId" id="cityId" onvaluechanged="onCityChange"  allowinput="true"  allowinput="true" valueField="code" textField="name" /></td>
                <td style="width:100px;text-align:right;"class="tbtext">地区<span style="color:red">*</span></td>
                <td style="width:200px;text-align:left;"><input class="nui-combobox textboxwidth" name="countyId"  valueField="code" textField="name" allowinput="true" id="countyId" allowinput="true" onvaluechanged="onCountyChange"/></td>

            </tr> 

            <tr>
                <td class="tbtext">详细地址<span style="color:red">*</span></td>
                <td colspan="5"><input class="nui-textbox tabwidth" name="streetAddress" id="streetAddress" onvaluechanged="onStreetChange"/></td>

            </tr>
            <tr>
                <td class="tbtext">组合地址<span class="spanwidth"></span></td>
                <td colspan="5"><input class="nui-textbox tabwidth" enabled="false" name="address" id="address"/></td>

            </tr>

            <tr>
                <td class="tbtext">经度<span class="spanwidth" style="color:red" ></span></td>
                <td colspan="5" ><input class="nui-textbox inline " style="" name="longitude" id="longitude"/>
                    <span style="width:450px;float: right;text-align: right;">纬度<input class="nui-textbox inline" style="margin-left: 10px;" name="latitude" id="latitude"/></span>
                </td>

            </tr>
                        <tr>
                <td class="tbtext">开户银行<span style="color:red" ></span></td>
                <td colspan="5" ><input class="nui-textbox inline " style="" name="bankName" id="bankName"/>
                    <span style="width:450px;float: right;text-align: right;">银行账号<input class="nui-textbox inline" style="margin-left: 10px;" name="bankAccountNumber" id="bankAccountNumber"/></span>
                </td>

            </tr>
            <tr>
                <td class="tbtext">开店日期<span style="color:red">*</span></td>
                <td colspan="5"><input class="nui-datepicker tabwidth" enabled="true" format="yyyy-MM-dd hh:MM" name="softOpenDate" id="softOpenDate"/></td>

            </tr>           
            <tr>
                <td class="tbtext">公司电话<span style="color:red">*</span></td>
                <td colspan="4"><input class="nui-textbox tabwidth" name="tel" id="tel" onvalidation="onMobileValidation"/></td>
            </tr>           
            <tr>
                <td class="tbtext">网站<span class="spanwidth"></span></td>
                <td colspan="5"><input class="nui-textbox tabwidth" id="webaddress" name="webaddress"/></td>

            </tr>         


            <tr>
                <td class="tbtext">主修品牌<span class="spanwidth"></span></td>
                <td colspan="5"><input class="nui-textbox tabwidth" name="mainBrandId" id="mainBrandId"/></td>

            </tr>


            <tr>
                <td class="tbtext">救援电话<span class="spanwidth"></span></td>
                <td colspan="5"><input class="nui-textbox tabwidth" name="rescueTel" id="rescueTel"/></td>

            </tr>           
            
            <tr>
                <td class="tbtext">广告语1<span class="spanwidth"></span></td>
                <td colspan="5"><input class="nui-textbox tabwidth" name="slogan1" id="slogan1"/></td>

            </tr>           
            <tr>
                <td class="tbtext">广告语2<span class="spanwidth"></span></td>
                <td colspan="5"><input class="nui-textbox tabwidth" name="slogan2" id="slogan2"/></td>

            </tr>

            <tr>
                <td class="tbtext">电子档案对接省份<span style="color:red"></span></td>
                <td colspan="5" ><input class="nui-textbox inline " style="width: 255px;" name="eRecordProvince" id="eRecordProvince" />
                    <span style="width:500px;float: right;text-align: right;">电子档案维修厂编号
                    <input class="nui-textbox inline" style="margin-left: 10px;" name="eRecordRepairNo" id="eRecordRepairNo"/></span>
                </td>


            </tr>

            <tr>
                <td class="tbtext">电子档案用户名<span style="color:red"></span></td>
                <td colspan="5" ><input class="nui-textbox inline " style="" name="eRecordUser" id="eRecordUser"/>
                    <span style="width:450px;float: right;text-align: right;">电子档案密码<input class="nui-textbox inline" style="margin-left: 10px;" name="eRecordPwd" id="eRecordPwd"/></span>
                </td>


            </tr>


            <tr>
                <td class="tbtext">备注<span class="spanwidth"></span></td>
                <td colspan="5"><input class="nui-textbox tabwidth"/></td>

            </tr>


            <tr>
                <td class="tbtext">建档人<span style="color:red" ></span></td>
                <td colspan="5" ><input class="nui-textbox inline " readonly="readonly" style="" name="recorder" id="recorder" enabled="false" />
                    <span style="width:450px;float: right;text-align: right;">建档日期<input class="nui-textbox inline" readonly="readonly" style="margin-left: 10px;" name="recordDate" id="recordDate" enabled="false"/></span>
                </td>

            </tr>
            
            <tr>
                <td class="tbtext">最后操作人<span style="color:red"></span></td>
                <td colspan="5" ><input class="nui-textbox inline " style="" name="modifier" id="modifier" readonly="readonly" enabled="false"/>
                    <span style="width:450px;float: right;text-align: right;">最后操作日期<input readonly="readonly" class="nui-textbox inline" style="margin-left: 10px;" name="modifyDate" id="modifyDate" enabled="false"/></span>
                </td>

            </tr>
        </table>
   
    </div>
</div> 
<script type="text/javascript">
  nui.parse();
  function ajaxFileUpload() {
        
        var inputFile = $("#file1 > input:file")[0];

        $.ajaxFileUpload({
            url: 'upload.aspx',                 //用于文件上传的服务器端请求地址
            fileElementId: inputFile,               //文件上传域的ID
            //data: { a: 1, b: true },            //附加的额外参数
            dataType: 'text',                   //返回值类型 一般设置为json
            success: function (data, status)    //服务器成功响应处理函数
            {
                alert("上传成功: " + data);

            },
            error: function (data, status, e)   //服务器响应失败处理函数
            {
                alert(e);
            },
            complete: function () {
                var jq = $("#file1 > input:file");
                jq.before(inputFile);
                jq.remove();
            }
        });
    }
    
    
      var uploader = Qiniu.uploader({
      runtimes: 'html5,flash,html4',      // 上传模式，依次退化
      browse_button: 'pickfiles',         // 上传选择的点选按钮，必需
      // 在初始化时，uptoken，uptoken_url，uptoken_func三个参数中必须有一个被设置
      // 切如果提供了多个，其优先级为uptoken > uptoken_url > uptoken_func
      // 其中uptoken是直接提供上传凭证，uptoken_url是提供了获取上传凭证的地址，如果需要定制获取uptoken的过程则可以设置uptoken_func
      uptoken : '<Your upload token>', // uptoken是上传凭证，由其他程序生成
      // uptoken_url: '/uptoken',         // Ajax请求uptoken的Url，强烈建议设置（服务端提供）
      // uptoken_func: function(){    // 在需要获取uptoken时，该方法会被调用
      //    // do something
      //    return uptoken;
      // },
      get_new_uptoken: false,             // 设置上传文件的时候是否每次都重新获取新的uptoken
      // downtoken_url: '/downtoken',
      // Ajax请求downToken的Url，私有空间时使用，JS-SDK将向该地址POST文件的key和domain，服务端返回的JSON必须包含url字段，url值为该文件的下载地址
      // unique_names: true,              // 默认false，key为文件名。若开启该选项，JS-SDK会为每个文件自动生成key（文件名）
      // save_key: true,                  // 默认false。若在服务端生成uptoken的上传策略中指定了sava_key，则开启，SDK在前端将不对key进行任何处理
      domain: getToken(),            // bucket域名，下载资源时用到，必需
      container: 'container',             // 上传区域DOM ID，默认是browser_button的父元素
      max_file_size: '100mb',             // 最大文件体积限制
      flash_swf_url: 'path/of/plupload/Moxie.swf',  //引入flash，相对路径
      max_retries: 3,                     // 上传失败最大重试次数
      dragdrop: true,                     // 开启可拖曳上传
      drop_element: 'container',          // 拖曳上传区域元素的ID，拖曳文件或文件夹后可触发上传
      chunk_size: '4mb',                  // 分块上传时，每块的体积
      auto_start: true,                   // 选择文件后自动上传，若关闭需要自己绑定事件触发上传
      //x_vars : {
      //    查看自定义变量
      //    'time' : function(up,file) {
      //        var time = (new Date()).getTime();
                // do something with 'time'
      //        return time;
      //    },
      //    'size' : function(up,file) {
      //        var size = file.size;
                // do something with 'size'
      //        return size;
      //    }
      //},
      init: {
          'FilesAdded': function(up, files) {
              plupload.each(files, function(file) {
                  // 文件添加进队列后，处理相关的事情
              });
          },
          'BeforeUpload': function(up, file) {
                 // 每个文件上传前，处理相关的事情
          },
          'UploadProgress': function(up, file) {
                 // 每个文件上传时，处理相关的事情
          },
          'FileUploaded': function(up, file, info) {
                 // 每个文件上传成功后，处理相关的事情
                 // 其中info.response是文件上传成功后，服务端返回的json，形式如：
                 // {
                 //    "hash": "Fh8xVqod2MQ1mocfI4S4KpRL6D98",
                 //    "key": "gogopher.jpg"
                 //  }
                 // 查看简单反馈
                 // var domain = up.getOption('domain');
                 // var res = parseJSON(info.response);
                 // var sourceLink = domain +"/"+ res.key; 获取上传成功后的文件的Url
          },
          'Error': function(up, err, errTip) {
                 //上传出错时，处理相关的事情
          },
          'UploadComplete': function() {
                 //队列文件处理完毕后，处理相关的事情
          },
          'Key': function(up, file) {
              // 若想在前端对每个文件的key进行个性化处理，可以配置该函数
              // 该配置必须要在unique_names: false，save_key: false时才生效

              var key = "";
              // do something with key here
              return key
          }
      }
  });

  // domain为七牛空间对应的域名，选择某个空间后，可通过 空间设置->基本设置->域名设置 查看获取

  // uploader为一个plupload对象，继承了所有plupload的方法
    
  function getToken() {
  	var token = "";
  	nui.ajax({
        url : apiPath + sysApi + "/com.hs.common.login.getQNAccessToken.biz.ext",
        type : "post",
        async: false,
        data : JSON.stringify({
        }),
        success : function(data) {
            data = data || {};
            token = data.token;
        },
        error : function(jqXHR, textStatus, errorThrown) {
            // nui.alert(jqXHR.responseText);
            console.log(jqXHR.responseText);
        }
    });
    return token;
  }

</script>
</body>
</html>