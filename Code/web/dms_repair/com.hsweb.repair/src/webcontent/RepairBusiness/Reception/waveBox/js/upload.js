$(document).ready(function(v) {
    uploader = Qiniu.uploader({
        runtimes: 'html5,flash,html4',
        browse_button: 'faker', //上传按钮的ID
        container: 'btn-uploader', //上传按钮的上级元素ID
        drop_element: 'btn-uploader',
        max_file_size: '100mb', //最大文件限制
        //flash_swf_url: '/static/js/plupload/Moxie.swf',
        dragdrop: false,
        chunk_size: '4mb', //分块大小
        uptoken_url: webPath + sysDomain + "/com.hs.common.login.getQNAccessToken.biz.ext", //设置请求qiniu-token的url
        //Ajax请求upToken的Url，**强烈建议设置**（服务端提供）
        // uptoken : '<Your upload token>',
        //若未指定uptoken_url,则必须指定 uptoken ,uptoken由其他程序生成
        unique_names: false,
        // 默认 false，key为文件名。若开启该选项，SDK会为每个文件自动生成key（文件名）
        // save_key: true,
        // 默认 false。若在服务端生成uptoken的上传策略中指定了 `sava_key`，则开启，SDK在前端将不对key进行任何处理
        domain: getCompanyLogoUrl(), //自己的七牛云存储空间域名
        multi_selection: true, //是否允许同时选择多文件
        //文件类型过滤，这里限制为图片类型
        filters: {
            mime_types: [
                { title: "Image files", extensions: "jpg,jpeg,gif,png" }
            ]
        },
        auto_start: true,
        init: {
            'FilesAdded': function(up, files) {
                //do something
            },
            'BeforeUpload': function(up, file) {
                //do something
            },
            'UploadProgress': function(up, file) {
                //可以在这里控制上传进度的显示
                //可参考七牛的例子
            },
            'UploadComplete': function() {
                //do something
            },
            'FileUploaded': function(up, file, info) {
                //每个文件上传成功后,处理相关的事情
                //其中 info 是文件上传成功后，服务端返回的json，形式如
                //{
                //  "hash": "Fh8xVqod2MQ1mocfI4S4KpRL6D98",
                //  "key": "gogopher.jpg"
                //}
                var domain = up.getOption('domain');
                //var sourceLink = domain + res.key;//获取上传文件的链接地址
                var info1 = JSON.parse(info);
                /*$("#xmTanImg").attr("src", getCompanyLogoUrl() + info1.hash);
                nui.get("logoImg").setValue(getCompanyLogoUrl() + info1.hash);*/
                var tBody = null;
                if (nui.get("state").value == 1) {
                    tBody = $("#tbodyId");
                    arr.add(getCompanyLogoUrl() + info1.hash);
                } else {
                    tBody = $("#tbodyId1");
                    brr.add(getCompanyLogoUrl() + info1.hash);
                }
                tBody.empty();
                var crr = [];
                if(nui.get("state").value == 1){
                	crr = arr;
                }else{
                	crr = brr;
                }
                var tds = '<td>[1]</td>';
                var tr = $("<tr></tr>");
                for(var i = 1 , l = crr.length ; i < l ; i ++){
                	var index = i +1;
                	tds = tds + '<td>['+index+']</td>';
                }
                for(var i = 0 , l = crr.length ; i < l ; i ++){
                	var index = i +1;
                	tds = tds.replace("["+index+"]", '<img id="xmTanImg" style="width: 120px;height: 120px" src="'+crr[i]+'" />');   
                }
                tBody.append(tr.append(tds)); 
            },
            'Error': function(up, err, errTip) {
                showMsg(errTip,"W");
            },
            'Key': function(up, file) {
                //当save_key和unique_names设为false时，该方法将被调用
                /* var key = "";
                 $.ajax({
                 url: '/getToken',
                 type: 'post',
                 async: false,//这里应设置为同步的方式
                 success: function(data) {
                 var ext = Qiniu.getFileExtension(file.name);
                 key = data + '.' + ext;
                 },
                 cache: false
                 });
                 return key;*/
            }
        }
    });

});

function getCompanyLogoUrl() {
    var url = "";
    nui.ajax({
        url: webPath + sysDomain + "/com.hs.common.login.getCompanyLogoUrl.biz.ext",
        type: "post",
        data: {},
        async: false,
        success: function(data) {
            nui.unmask();
            data = data || {};
            if (data.errCode && data.errCode == 'S') {
                url = data.companyLogoUrl;
            } else {
                showMsg(data.errMsg, "W");
            }

        },
        error: function(jqXHR, textStatus, errorThrown) {
            //  nui.alert(jqXHR.responseText);
            nui.unmask();
            closeWindow("cal");
        }
    });
    return url;
};