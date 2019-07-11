/**
 * Created by Administrator on 2018/1/24.
 */

var baseUrl = apiPath + partApi + "/";//window._rootUrl || "http://127.0.0.1:8080/default/";
var leftGridUrl = baseUrl+"com.hsapi.part.baseDataCrud.crud.queryPartBrandList.biz.ext";
var rightGridUrl = baseUrl+"com.hsapi.part.baseDataCrud.crud.queryPartBrandList.biz.ext";
var bottomeGridUrl = baseUrl+"com.hsapi.part.baseDataCrud.crud.queryOrgPartBrandList.biz.ext";
var leftGrid = null;
var rightGrid = null;
var splitter = null;
var bottomGrid = null;
$(document).ready(function(v)
{
    //splitter = nui.get("splitter");
    //console.log(splitter);
    leftGrid = nui.get("leftGrid");
    leftGrid.setUrl(leftGridUrl);
    leftGrid.on("beforeload",function(e){
        e.data.token = token;
    });
    rightGrid = nui.get("rightGrid");
    rightGrid.setUrl(rightGridUrl);
    rightGrid.on("beforeload",function(e){
        e.data.token = token;
    });
    bottomGrid = nui.get("bottomGrid");
    bottomGrid.setUrl(bottomeGridUrl);
    rightGrid.on("rowclick",function(e)
    {
        var row = e.record;
        if(row)
        {
            if(row.isDisabled == 1)
            {
                nui.get("disabledRight").hide();
                nui.get("enabledRight").show();
            }
            else{
                nui.get("enabledRight").hide();
                nui.get("disabledRight").show();
            }
        }
    });
    
    if(currOrgId != "0") {
		nui.get("addLeft").disable();
		nui.get("editLeft").disable();
		nui.get("disabledLeft").disable();
		nui.get("enabledLeft").disable();
		

		nui.get("editRight").disable();
		nui.get("disabledRight").disable();
		nui.get("enabledRight").disable();
	}
    
    uploader = Qiniu.uploader({
        runtimes: 'html5,flash,html4',
        browse_button: 'faker',//上传按钮的ID
        container: 'btn-uploader',//上传按钮的上级元素ID
        drop_element: 'btn-uploader',
        max_file_size: '100mb',//最大文件限制
        //flash_swf_url: '/static/js/plupload/Moxie.swf',
        dragdrop: false,
        chunk_size: '4mb',//分块大小
        uptoken_url: webPath + sysDomain + "/com.hs.common.login.getQNAccessToken.biz.ext",//设置请求qiniu-token的url
        //Ajax请求upToken的Url，**强烈建议设置**（服务端提供）
        // uptoken : '<Your upload token>',
        //若未指定uptoken_url,则必须指定 uptoken ,uptoken由其他程序生成
        unique_names: false,
        // 默认 false，key为文件名。若开启该选项，SDK会为每个文件自动生成key（文件名）
        // save_key: true,
        // 默认 false。若在服务端生成uptoken的上传策略中指定了 `sava_key`，则开启，SDK在前端将不对key进行任何处理
        domain: getQiNuiUrl(),//自己的七牛云存储空间域名
        multi_selection: false,//是否允许同时选择多文件
        //文件类型过滤，这里限制为图片类型
        filters: {
            mime_types: [
                {title: "Image files", extensions: "jpg,jpeg,gif,png"}
            ]
        },
        auto_start: true,
        init: {
            'FilesAdded': function (up, files) {
                //do something
            },
            'BeforeUpload': function (up, file) {
                //do something
            },
            'UploadProgress': function (up, file) {
                //可以在这里控制上传进度的显示
                //可参考七牛的例子
            },
            'UploadComplete': function () {
                //do something
            },
            'FileUploaded': function (up, file, info) {
                //每个文件上传成功后,处理相关的事情
                //其中 info 是文件上传成功后，服务端返回的json，形式如
                //{
                //  "hash": "Fh8xVqod2MQ1mocfI4S4KpRL6D98",
                //  "key": "gogopher.jpg"
                //}
                var domain = up.getOption('domain');
                //var sourceLink = domain + res.key;//获取上传文件的链接地址
                var info1 = JSON.parse(info);
                var imageUrl=qiNiuUrl + info1.hash;
                savePicture(imageUrl);
             // nui.get("logoImg").setValue("http://qxy60.7xdr.com/" + info1.hash);
            },
            'Error': function (up, err, errTip) {
                alert(errTip);
            },
            'Key': function (up, file) {
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
    
    onSearch(2);

    loadBottom();
});
function addOrEditPartQuality(quality)
{
	var title = "新增品质";
    if(quality)
    {
        if(quality.orgid != currOrgid)
        {
            return;
        }
        title = "品质编辑";
    }
    nui.open({
        // targetWindow: window,
        url: webPath + contextPath + "/com.hsweb.part.baseData.partQualityDetail.flow?token=" + token,
        title: title, width: 350, height: 150,
        allowDrag:true,
        allowResize:false,
        onload: function ()
        {
            if(quality)
            {
                var iframe = this.getIFrameEl();
                iframe.contentWindow.setData({
                    quality:quality
                });
            }
        },
        ondestroy: function (action)
        {
            if(action == "ok")
            {
                leftGrid.reload();
            }
        }
    });
}
function addPartQuality()
{
    addOrEditPartQuality();
}
function editPartQuality()
{
    var row = leftGrid.getSelected();
    if(row)
    {
        addOrEditPartQuality(row);
    }
}


function addOrEditPartBrand(brand)
{
	var title = "新增品牌";
	if(brand && brand.id)
    {
       if(brand.orgid != currOrgid)
        {
        	parent.showMsg("不允许修改!","W");
            return;
        }
        title = "品牌编辑";
    }
    nui.open({
        // targetWindow: window,
        url: webPath + contextPath + "/com.hsweb.part.baseData.partBrandDetail.flow?token=" + token,
        title: title, width: 350, height: 200,
        allowDrag:true,
        allowResize:false,
        onload: function ()
        {
            if(brand)
            {
                var iframe = this.getIFrameEl();
                iframe.contentWindow.setData({
                    brand:brand
                });
            }
        },
        ondestroy: function (action)
        {
            if(action == "ok")
            {
                rightGrid.reload();
            }
        }
    });
}

function addPartBrand()
{
    var quality = leftGrid.getSelected();
    if(quality)
    {
        var brand = {
            parentId:quality.id
        };
        addOrEditPartBrand(brand);
    }
}
function editPartBrand(){
    var brand = rightGrid.getSelected();
    if(brand)
    {
        addOrEditPartBrand(brand);
    }
}
function onDrawCell(e)
{
    switch (e.field)
    {
        case "isDisabled":
            e.cellHtml = e.value==1?"禁用":"启用";
            break;
        case "imageUrl":
        	if(e.value){		
        		e.cellHtml = "<img src='"+ e.value+ "'alt='配件图片' height='25px' width=' '/>";
        	}
            break;
        default:
            break;
    }
}
function onSearch(type)
{
    var params = {};
    if(type == 1||type == 0)
    {
        params.isDisabled = type;
    }
    if($("a[id*='type']").length>0)
    {
        $("a[id*='type']").css("color","black");
    }
    if($("#type"+type).length>0)
    {
        $("#type"+type).css("color","blue");
    }
    loadLeftGridData(params);
}
function loadLeftGridData(params)
{
    rightGrid.setData([]);
    leftGrid.load(params,function()
    {
        var row = leftGrid.getSelected();
        if(row)
        {
            if(row.isDisabled)
            {
                nui.get("disabledLeft").hide();
                nui.get("enabledLeft").show();
            }
            else{
                nui.get("disabledLeft").show();
                nui.get("enabledLeft").hide();
            }
            onLeftGridRowClick({
                record:row
            });
        }
    });
}
function onLeftGridRowClick(e)
{
    var row = e.record;
    if(row.isDisabled)
    {
        nui.get("disabledLeft").hide();
        nui.get("enabledLeft").show();
    }
    else{
        nui.get("disabledLeft").show();
        nui.get("enabledLeft").hide();
    }
    if(row.orgid == currOrgid || currTenantId=='default'){
        nui.get("disabledLeft").enable();
        nui.get("enabledLeft").enable();
        nui.get("editLeft").enable();
        //nui.get("addRight").enable();
        nui.get("editRight").enable();
        nui.get("disabledRight").enable();
        nui.get("enabledRight").enable();
    }else{
        nui.get("disabledLeft").disable();
        nui.get("enabledLeft").disable();
        nui.get("editLeft").disable();
        //nui.get("addRight").disable();
        nui.get("editRight").disable();
        nui.get("disabledRight").disable();
        nui.get("enabledRight").disable();
    }
    
    loadRightGridData(row.id);
}
function loadRightGridData(parentId)
{
    rightGrid.load({
        parentId:parentId
    },function(){
        var row = rightGrid.getSelected();
        if(row && row.isDisabled)
        {
            nui.get("disabledRight").hide();
            nui.get("enabledRight").show();
        }
        else{
            nui.get("disabledRight").show();
            nui.get("enabledRight").hide();
        }
    });
}
function reloadRightGrid(){
    rightGrid.reload()
}

function disablePartQuality(){
    var row = leftGrid.getSelected();
    if(row)
    {
        nui.confirm("确定要禁用所选品质？","提示",function(action)
        {
            if(action == "ok")
            {
                updateIsDisabled({
                    id:row.id,
                    isDisabled:1,
                    name:row.name
                },function(data)
                {
                    data = data||{};
                    if(data.errCode == "S")
                    {
                        row.isDisabled = 1;
                        leftGrid.updateRow(row,row);
                        nui.get("disabledLeft").hide();
                        nui.get("enabledLeft").show();
                        parent.showMsg("禁用成功","S");
                    }
                    else{
                        parent.showMsg(data.errMsg||"禁用失败","E");
                    }
                });
            }
        }.bind(row));
    }
}
function enablePartQuality(){
    var row = leftGrid.getSelected();
    if(row)
    {
        nui.confirm("确定要启用所选品质？","提示",function(action)
        {
            if(action == "ok")
            {
                updateIsDisabled({
                    id:row.id,
                    isDisabled:0,
                    name:row.name
                },function(data)
                {
                    data = data||{};
                    if(data.errCode == "S")
                    {
                        row.isDisabled = 0;
                        leftGrid.updateRow(row,row);
                        nui.get("disabledLeft").show();
                        nui.get("enabledLeft").hide();
                        parent.showMsg("启用成功","S");
                    }
                    else{
                        parent.showMsg(data.errMsg||"启用失败","E");
                    }
                });
            }
        }.bind(row));
    }
}
function disablePartBrand()
{
    var row = rightGrid.getSelected();
    if(row)
    {
        nui.confirm("确定要禁用所选品牌？","提示",function(action)
        {
            if(action == "ok")
            {
                updateIsDisabled({
                    id:row.id,
                    isDisabled:1,
                    name:row.name
                },function(data)
                {
                    data = data||{};
                    if(data.errCode == "S")
                    {
                        row.isDisabled = 1;
                        rightGrid.updateRow(row,row);
                        nui.get("disabledRight").hide();
                        nui.get("enabledRight").show();
                        parent.showMsg("禁用成功","S");
                    }
                    else{
                        parent.showMsg(data.errMsg||"禁用失败","E");
                    }
                });
            }
        }.bind(row));
    }
}
function enablePartBrand()
{
    var row = rightGrid.getSelected();
    if(row)
    {
        nui.confirm("确定要启用所选品牌？","提示",function(action)
        {
            if(action == "ok")
            {
                updateIsDisabled({
                    id:row.id,
                    isDisabled:0,
                    name:row.name
                },function(data)
                {
                    data = data||{};
                    if(data.errCode == "S")
                    {
                        row.isDisabled = 0;
                        rightGrid.updateRow(row,row);
                        nui.get("disabledRight").show();
                        nui.get("enabledRight").hide();
                        parent.showMsg("启用成功","S");
                    }
                    else{
                        parent.showMsg(data.errMsg||"启用失败","E");
                    }
                });
            }
        }.bind(row));
    }
}
var updateIsDisabledUrl = baseUrl+"com.hsapi.part.baseDataCrud.crud.savePartBrand.biz.ext";

function updateIsDisabled(brand,callback)
{
    console.log(brand);
    nui.mask({
        html:'保存中...'
    });
    nui.ajax({
        url:updateIsDisabledUrl,
        type:"post",
        data:JSON.stringify({
            brand:brand,
            token:token
        }),
        success:function(data)
        {
            nui.unmask();
            callback && callback(data);
        },
        error:function(jqXHR, textStatus, errorThrown){
            //  nui.alert(jqXHR.responseText);
            console.log(jqXHR.responseText);
        }
    });
}
function addLocalBrand()
{
    nui.open({
        // targetWindow: window,
        url: webPath + contextPath + "/com.hsweb.part.baseData.partBrandOrgDetail.flow?token=" + token,
        title: "新增关注品牌", width: 600, height: 350,
        allowDrag:true,
        allowResize:true,
        onload: function ()
        {
            var iframe = this.getIFrameEl();
            iframe.contentWindow.setInitData(bottomGrid.getData());
         
        },
        ondestroy: function (action)
        {
            loadBottom();
        }
    });
}
function loadBottom(){
    bottomGrid.load({
        token:token
    });
}
var saveLocalBrandUrl = baseUrl + "com.hsapi.part.baseDataCrud.crud.saveOrgPartBrand.biz.ext";
function delLocalBrand()
{
    var data = bottomGrid.getSelecteds();
    if(!data || data.length<=0) return;

    nui.mask({
        el: document.body,
        cls: 'mini-mask-loading',
        html: '处理中...'
    });
    nui.ajax({
        url:saveLocalBrandUrl,
        type:"post",
        data:JSON.stringify({
            deleteList:data,
            token:token
        }),
        success:function(rs)
        {
            nui.unmask();
            rs = rs||{};
            if(rs.errCode == "S")
            {
                parent.showMsg("处理成功","S");
                loadBottom();
            }
            else{
                parent.showMsg(data.errMsg||"处理失败","E");
            }
        },
        error:function(jqXHR, textStatus, errorThrown){
            console.log(jqXHR.responseText);
        }
    });
}
function saveLocalBrand(){
    var data = bottomGrid.getChanges("modified");

    if(!data || data.length<=0) return;

    nui.mask({
        el: document.body,
        cls: 'mini-mask-loading',
        html: '处理中...'
    });
    nui.ajax({
        url:saveLocalBrandUrl,
        type:"post",
        data:JSON.stringify({
            updateList:data,
            token:token
        }),
        success:function(rs)
        {
            nui.unmask();
            rs = rs||{};
            if(rs.errCode == "S")
            {
                parent.showMsg("保存成功","S");
                loadBottom();
            }
            else{
                parent.showMsg(data.errMsg||"保存失败","E");
            }
        },
        error:function(jqXHR, textStatus, errorThrown){
            console.log(jqXHR.responseText);
        }
    });
}

var savePictureUrl = baseUrl + "com.hsapi.cloud.part.baseDataCrud.crud.savePartBrand.biz.ext";
function savePicture(imageUrl){
    var row=rightGrid.getSelected();
    row.imageUrl=imageUrl;
    if(row.length<0) {
    	showMsg("请选择品牌!","W");
    	return;
    	
    }

    nui.mask({
        el: document.body,
        cls: 'mini-mask-loading',
        html: '上传中...'
    });
    nui.ajax({
        url:savePictureUrl,
        type:"post",
        data:JSON.stringify({
        	brand:row,
        	orgid :currOrgid,
        	userName :currUserName,
            token:token
        }),
        success:function(rs)
        {
            nui.unmask();
            rs = rs||{};
            if(rs.errCode == "S")
            {
                parent.showMsg("图片上传成功","S");
                rightGrid.reload();
            }
            else{
                parent.showMsg(data.errMsg||"图片上传失败","E");
            }
        },
        error:function(jqXHR, textStatus, errorThrown){
            console.log(jqXHR.responseText);
        }
    });
}	



var qiNiuUrl=null;
function getQiNuiUrl(){

  nui.ajax({
    url:webPath + sysDomain +"/com.hs.common.login.getCompanyLogoUrl.biz.ext",
    type:"post",
    data:{},
    async:false,
    success:function(data)
    {
        nui.unmask();
        data = data||{};
        if(data.errCode && data.errCode == 'S'){
      	  qiNiuUrl =  data.companyLogoUrl;
        }else{
            showMsg(data.errMsg,"W");
        }
        
    },
    error:function(jqXHR, textStatus, errorThrown){
        //  nui.alert(jqXHR.responseText);
    	  nui.unmask();
        closeWindow("cal");
    }
});
return qiNiuUrl;
};
