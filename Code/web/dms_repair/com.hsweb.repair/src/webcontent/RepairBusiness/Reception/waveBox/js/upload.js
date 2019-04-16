 var baseUrl = apiPath + repairApi + "/";  
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
                var photos = null;
                var table = null;
                if (nui.get("state").value == 1) {
                    table = document.getElementById("table1");
                } else {
                    table = document.getElementById("table2");
                }
                if (table.rows.length > 3) {
                    showMsg("最多上传9张图片", "W");
                    return;
                }
                if (table.rows.length == 3) {
                    if (table.rows[2].cells[2].innerHTML != "") {
                        showMsg("最多上传9张图片", "W");
                        return;
                    }
                }
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
                if (nui.get("state").value == 1) {
                    crr = arr;
                } else {
                    crr = brr;
                }
                for (var i = 0, l = crr.length; i < l; i++) {
                    var tds = '<td align="center">[1]</td><td align="center">[2]</td><td align="center">[3]</td>';
                    var tr = $("<tr></tr>");
                    var index = i + 1;
                    var value1 = crr[i] || "";
                    var value2 = crr[i + 1] || "";
                    var value3 = crr[i + 2] || "";
                    value1 = value1 ? '<img id="xmTanImg" style="width: 120px;height: 120px" onclick="changeShow(this);" src="' + value1 + '" />' : "";
                    value2 = value2 ? '<img id="xmTanImg" style="width: 120px;height: 120px" onclick="changeShow(this);" src="' + value2 + '" />' : "";
                    value3 = value3 ? '<img id="xmTanImg" style="width: 120px;height: 120px" onclick="changeShow(this);" src="' + value3 + '" />' : "";
                    tr.append(
                        tds.replace("[1]", value1)
                        .replace("[2]", value2)
                        .replace("[3]", value3));
                    tBody.append(tr);
                    i = i + 2;
                }
            },
            'Error': function(up, err, errTip) {
                showMsg(errTip, "W");
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
    
    $("table td").click(function()	{
		var photoUrl = $(this).text();
		$("#maxImgShow").attr("src",photoUrl)
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

function ok() {
	var add = null;
	var type = null;
    if(nui.get("state").value == 1){
    	add = arr;
    	type = 1;
    }else{
    	add = brr;
    	type = 2;
    }
    if(add.length == 0){
    	showMsg("暂无图片需要保存","W");
    	return;
    }
    var addData = [];
    for(var i = 0 , l = add.length ; i < l ; i ++){
    	var newRow = {attachName : add[i],type:type,serviceId:nui.get("serviceId").value};
    	addData.add(newRow);
    }
    nui.ajax({
		url: baseUrl+ "com.hsapi.repair.repairService.waveBox.addUploadPhoto.biz.ext",
		type: "post",
		cache: false,
		async: false,
		data: {
			add: addData,
			type : type,
			serviceId : nui.get("serviceId").value
		},
		success: function (text) {
				if(text.errCode == "S"){
					showMsg("执行成功","S");
				}else{
					showMsg(text.errMsg,"W");
				}
		},
		error: function (jqXHR, textStatus, errorThrown) {
			console.log(jqXHR.responseText);
			showMsg("网络出错", "E");
		}
	});
}

function SetData(serviceId, serviceCode, state) {
    nui.get("serviceId").setValue(serviceId);
    nui.get("serviceCode").setValue(serviceCode);
    nui.get("state").setValue(state); //1维修前  2维修后
	nui.ajax({
		url: baseUrl+ "com.hsapi.repair.repairService.waveBox.searchUploadPhoto.biz.ext",
		type: "post",
		cache: false,
		async: false,
		data: {
			serviceId : nui.get("serviceId").value
		},
		success: function (text) {
				if(text.errCode == "S"){
					var data = text.data;
					for(var i = 0 , l = data.length ; i < l ;i ++){
						if(data[i].type == 1){
							arr.add(data[i].attachName);
							var tBody = $("#tbodyId");
							showPhoto(arr,tBody);
						}else{
							brr.add(data[i].attachName);
							var tBody = $("#tbodyId");
							showPhoto(brr,tBody);
						}
					}
					
				}else{
					showMsg(text.errMsg,"W");
				}
		},
		error: function (jqXHR, textStatus, errorThrown) {
			console.log(jqXHR.responseText);
			showMsg("网络出错", "E");
		}
	});
}

function showPhoto(crr,tBody){
	tBody.empty();
	for (var i = 0, l = crr.length; i < l; i++) {
        var tds = '<td align="center">[1]</td><td align="center">[2]</td><td align="center">[3]</td>';
        var tr = $("<tr></tr>");
        var index = i + 1;
        var value1 = crr[i] || "";
        var value2 = crr[i + 1] || "";
        var value3 = crr[i + 2] || "";
        value1 = value1 ? '<img id="xmTanImg" style="width: 120px;height: 120px" onclick="changeShow(this);" src="' + value1 + '" />' : "";
        value2 = value2 ? '<img id="xmTanImg" style="width: 120px;height: 120px" onclick="changeShow(this);" src="' + value2 + '" />' : "";
        value3 = value3 ? '<img id="xmTanImg" style="width: 120px;height: 120px" onclick="changeShow(this);" src="' + value3 + '" />' : "";
        tr.append(
            tds.replace("[1]", value1)
            .replace("[2]", value2)
            .replace("[3]", value3));
        tBody.append(tr);
        i = i + 2;
    }
}

function changeHide(){
	$(".max_img").hide();
}

function changeShow(evn){
	$("#maxImgShow").attr("src",evn.src);
	$(".max_img").show();
}