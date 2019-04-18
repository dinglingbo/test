var baseUrl = window._rootUrl||"http://127.0.0.1:8080/default/";
var contactInfoForm = null;
var carInfoFrom = null;
var basicInfoForm = null;
var provice; 
var cityId;
var data;
var carview = null;
var cardatagrid = null;
var contactview = null;
var contactdatagrid = null;
var contactInfoForm = null;
var guestTypeList = [];
var guestTypeHash = {};
var lyData = [];
var sfData = [];
var fullName = null;
var mobile = null;
var resultGuest = {};
var resultCar = {};
var resultContact= {};
var isAdd = 0;//是否是添加界面
var empty = 0;//是否清空
var  index = 0;//汽车图片的下标
var photos = [];//汽车图片
var isOpen = true;
var carIdForPhoto = null;
$(document).ready(function()
{
	carview = nui.get("carview");
	carview.hide();
	contactview = nui.get("contactview");
	contactview.hide();
	cardatagrid = nui.get("cardatagrid");
	contactdatagrid = nui.get("contactdatagrid");
	carInfoFrom = new nui.Form("#carInfoFrom");
	contactInfoForm = new nui.Form("#contactInfoForm");
	basicInfoForm = new nui.Form("#basicInfoForm");
	//nui.get("name").focus();
	
	if(currRepairBillCmodelFlag == "1"){
        nui.get("carModel").disable();
    }else{
        nui.get("carModel").enable();
    }
	
	nui.get("name").focus();
	document.onkeyup=function(event){
        
		var e=event||window.event;
        var keyCode=e.keyCode||e.which;//38向上 40向下
        if((keyCode==27))  {  //ESC
            onCancel();
            
        }
      };
      
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
		    domain: getCompanyLogoUrl(),//自己的七牛云存储空间域名
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
		            $("#xmTanImg").attr("src",getCompanyLogoUrl() + info1.hash);
		            nui.get("licensePicOne").setValue(getCompanyLogoUrl() + info1.hash);
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
		
		uploader = Qiniu.uploader({
		    runtimes: 'html5,flash,html4',
		    browse_button: 'faker1',//上传按钮的ID
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
		    domain: getCompanyLogoUrl(),//自己的七牛云存储空间域名
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
		            $("#xmTanImg1").attr("src",getCompanyLogoUrl() + info1.hash);
		            nui.get("licensePicTwo").setValue(getCompanyLogoUrl() + info1.hash);
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
		
		uploader = Qiniu.uploader({
		    runtimes: 'html5,flash,html4',
		    browse_button: 'faker2',//上传按钮的ID
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
		    domain: getCompanyLogoUrl(),//自己的七牛云存储空间域名
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
		            $("#xmTanImg2").attr("src",getCompanyLogoUrl() + info1.hash);
		            nui.get("driveLicensePicOne").setValue(getCompanyLogoUrl() + info1.hash);
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
		
		uploader = Qiniu.uploader({
		    runtimes: 'html5,flash,html4',
		    browse_button: 'faker3',//上传按钮的ID
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
		    domain: getCompanyLogoUrl(),//自己的七牛云存储空间域名
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
		            $("#xmTanImg3").attr("src",getCompanyLogoUrl() + info1.hash);
		            nui.get("driveLicensePicTwo").setValue(getCompanyLogoUrl() + info1.hash);
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
    	uploader = Qiniu.uploader({
		    runtimes: 'html5,flash,html4',
		    browse_button: 'faker4',//上传按钮的ID
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
		    domain: getCompanyLogoUrl(),//自己的七牛云存储空间域名
		    multi_selection: true,//是否允许同时选择多文件
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
		            index++;
		            var html=imageHtml(getCompanyLogoUrl() + info1.hash,index);
		            $(".photos").before(html);
		            mouseImage();
		            photos[photos.length]={
		            		address:getCompanyLogoUrl() + info1.hash,
		            		carId: carIdForPhoto,
		            	    index : index
		            }
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
});

function getCompanyLogoUrl(){
	  var url="";
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
      	  url =  data.companyLogoUrl;
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
return url;
};
function init(callback)
{
	var addEditCustomerPage = nui.get("addEditCustomerPage");
    basicInfoForm = new nui.Form("#basicInfoForm");
    contactInfoForm = new nui.Form("#contactInfoForm");
    carInfoFrom = new nui.Form("#carInfoFrom");
    provice = nui.get("provice");
    cityId = nui.get("cityId");
    
    var hash = {};
    addEditCustomerPage.mask({
        html:'数据加载中..'
    });
    var checkComplete = function()
    {
    	var keyList = ['initInsureComp','initDicts'];
        for(var i=0;i<keyList.length;i++)
        {
            if(!hash[keyList[i]])
            {
                return;
            }
        }
        setContactByIdx(0);
        setCarByIdx(0);
        addEditCustomerPage.unmask();
        callback && callback();
    };
/*    initInsureComp("insureCompCode",function(){
        hash.initInsureComp = true;
        checkComplete();
    });*/
    initInsureComp("annualInspectionCompCode",function(){
        hash.initInsureComp = true;
        checkComplete();
    	var inlist = nui.get("annualInspectionCompCode").getData();
    	nui.get("insureCompCode").setData(inlist);
    });
    initDicts({
        //carSpec:CAR_SPEC,//车辆规格
        //kiloType:KILO_TYPE,//里程类别
        source:GUEST_SOURCE,//客户来源
        identity:IDENTITY, //客户身份
        guestProperty:GUEST_PROPERTY //客户类别
    },function(data){
        hash.initDicts = true;
        checkComplete();
        lyData  = nui.get("source").data;
        sfData = nui.get("identity").data;
    });
    initProvince("provice");
    nui.get("wechatOpenId").disable();
    initGuestType("guestTypeId",function(data) {
      	guestTypeList = nui.get("guestTypeId").getData();
      	guestTypeList.forEach(function(v) {
      		guestTypeHash[v.id] = v;
          });
      });
}
var carList = [{}];
var carHash = {};
var currCarIdx = 0;

function setCarByIdx(idx)
{
    if(currCarIdx>=0 && currCarIdx<carList.length)
    {
        carList[currCarIdx] = carInfoFrom.getData();
        //carList[currCarIdx].carModel = nui.get("carModelId").getText();
        carList[currCarIdx].isChanged = carInfoFrom.isChanged();
        currCarIdx = idx;
    }
}
function preCar()
{
    setCarByIdx(currCarIdx-1);
}
function nextCar()
{
    setCarByIdx(currCarIdx+1);
}

var contactList = [{}];
var contactHash = {};
var currContactIdx = 0;

function preContact()
{
    //上一个联系人
    setContactByIdx(currContactIdx-1);
}
function nextContact()
{
    //下一个联系人
    setContactByIdx(currContactIdx+1);
}
function setContactByIdx(idx)
{
    if(idx>=0 && idx<contactList.length)
    {
        var contact = contactInfoForm.getData();
        contact.isChanged = contactInfoForm.isChanged();
        contactList[currContactIdx] = contact;
        currContactIdx = idx;
    }
}
function addContact()
{
    //添加联系人
    contactList.push({});
    setContactByIdx(contactList.length-1);
}

//关闭窗口
function CloseWindow(action) {
    if (action == "close" && form.isChanged()) {
        if (confirm("数据被修改了，是否先保存？")) {
            saveData();
        }
    }
    if (window.CloseOwnerWindow)
        return window.CloseOwnerWindow(action);
    else window.close();
}
//取消
function onCancel() {
    CloseWindow("cancel");
}

var basicRequiredField = {
    "fullName":"客户名称",
    "mobile":"手机号码"
}

/*var carRequiredField ={
    "carNo":"车牌号",
    "vin":"车架号"
};*/
/*var contactRequiredField ={
    "name":"联系人姓名",
    "mobile":"联系人手机",
    "identity":"联系人身份",
    "source":"联系人来源"
};*/

var saveUrl = baseUrl+"com.hsapi.repair.repairService.crud.saveCustomerInfo.biz.ext";
function onOk()
{
    var guest = basicInfoForm.getData(true);
    guest.guestType = "01020103";
    guest.tgrade = guest.guestTypeId;
    for(key in basicRequiredField){
        //tmp = nui.get(key).getText();
        if(!nui.get(key).value){
            showMsg(basicRequiredField[key]+"不能为空", "W");
            return;
        }
    }
    
    if(!checkMobile(nui.get("mobile").value)){
        return;
    }
    
/*    var insCarList = carList.filter(function(v)
    {
        return !v.id;
    });
    var updCarList = carList.filter(function(v)
    {
        if(v.id)
        {
            var oldJson =carHash[v.id];
            var newJson = JSON.stringify(v);
            return oldJson !== newJson;
        }
    });
    var insContactList = contactList.filter(function(v)
    {
        return !v.id;
    });
    var updContactList = contactList.filter(function(v)
    {
        if(v.id)
        {
            var oldJson = contactHash[v.id];
            var newJson = JSON.stringify(v);
            return oldJson !== newJson;
        }
    });*/

    var insCarList = [];
    var updCarList = [];
    
    if(isAdd==1){
        var insContactList = [{
        	source: "060110",
        	mobile: guest.mobile,
        	name: guest.fullName, 
        	identity: "060301"
        }];
    }else{
    	var insContactList = [];
    }

    var updContactList = [];
    nui.mask({
		el : document.body,
		cls : 'mini-mask-loading',
		html : '保存中...'
	});
    
    $("#btnGroup").hide();
    doPost({
        url : saveUrl,
        data : {
            guest:guest,
            insCarList:insCarList,
            updCarList:updCarList,
            insContactList:insContactList,
            updContactList:updContactList
        },
        success : function(data)
        {
        	nui.unmask(document.body);
            data = data||{};
            if(data.errCode == "S")
            {
                showMsg("保存成功","S");
                resultGuest = data.retData;
                nui.get("guestId").setValue(resultGuest.guestId);
                
                    //添加一行联系人
                    resultContact = data.retData;
            		var newRow = {
            				id:resultContact.contactorId,
            				guestId:resultContact.guestId,
            				name : resultContact.guestFullName,
            				mobile : resultContact.mobile,
            				identity :resultContact.identity,
            				source :resultContact.source,
            				wechatServiceId:resultContact.wechatServiceId,
            				wechatOpenId:resultContact.wechatOpenId
            				
            			};
                    var contactid = contactdatagrid.getData(true);
                    for(var i = 0 ;i<contactid.length;i++){
                    	if(contactid[i].id==contact.id){
                    		contactdatagrid.removeRow(contactid[i]);
                    	}
                    }
            		contactdatagrid.addRow(newRow);
                    //再次保存时清空联系人的值
            		isAdd = 0;
                //CloseWindow("ok");
            }
            else{
                showMsg(data.errMsg||"保存失败", "E");
            }
            $("#btnGroup").show();
        },
        error : function(jqXHR, textStatus, errorThrown) {
        	nui.unmask(document.body);
            showMsg("网络出错", "E");
            $("#btnGroup").show();
        }
    });    
}
function getSaveData(){
	return resultData;
}
var queryUrl = baseUrl+"com.hsapi.repair.repairService.svr.getGuestCarContactInfoById.biz.ext";
var oldGuest = {};
function setData(data)
{
		if(isEmptyObject(data)){
			isAdd=1;		
		}
	var carNo = null;
	var guestFullName = null;
	if(data.guest){
		resultGuest.guestId=data.guest.guestId;
		carNo =data.guest.carNo;
	    guestFullName =data.guest.guestFullName; 
	}
	var count = 0;
    init(function()
    {
        if(data.guest)
        {
            var guest = data.guest;
            doPost({
                url : queryUrl,
                data : {
                    guestId:guest.guestId
                },
                success : function(data)
                {
                    data = data||{};
                    if(data.guest && data.guest.id)
                    {   
                    	oldGuest = data.guest;
                        basicInfoForm.setData(data.guest);
                        initCityByParent('cityId', data.guest.provinceId || -1);
                        initCityByParent('areaId', data.guest.cityId || -1);
                        contactList = data.contactList||[{}];
                        carList = data.carList||[{}];
                        cardatagrid.setData(carList);
                        contactdatagrid.setData(contactList);
                        var tgrade = data.guest.tgrade;
                	    if(tgrade){
                	    	var num = parseInt(tgrade);
                	    	var tgradeName = guestTypeHash[num].name;
                	    	nui.get("guestTypeId").setText(tgradeName);
                	    	nui.get("guestTypeId").setValue(tgrade);
                	    }
                    }
                    else{
                        showMsg("获取客户信息失败", "E");
                    }
                },
                error : function(jqXHR, textStatus, errorThrown) {
                    console.log(jqXHR.responseText);
                    showMsg("网络出错", "E");
                }
            });
        }
    });

}
function onParseUnderpanNo()
{
    var vin = nui.get("vin").getValue();
    //判断VIN
    var data = {};
    data = validation(vin);
    if(data.isNo){
    	vin = data.vin//返回转化好的vin
    	nui.get("vin").setValue(vin);
        nui.mask({
            el: document.body,
            cls: 'mini-mask-loading',
            html: '车型解析中...'
        });
        getCarVinModel(vin,function(data)
        {
            data = data||{};
            if(data.errCode == "S")
            {
                //var list = data.rs||[];
                var carVinModel = data.data.SuitCar||[];//list[0];
                var carModelId = data.data.carModelId;
                carVinModel = carVinModel[0]||{};
                carVinModel.vin = vin;
             //   nui.get("carBrandId").setValue(carVinModel.carBrandId);
             //   nui.get("carModelId").setValue(carVinModel.carModelId);
             //   nui.get("carModelId").setText(carVinModel.carModelName);
                var carModelInfo = "品牌:"+carVinModel.carBrandName+"\n";
                carModelInfo += "车型:"+carVinModel.carModelName+"\n";
                carModelInfo += "车系:"+carVinModel.carLineName+"\n";
                var name1 = carVinModel.grandParentName||"";
                name1 = name1?(name1+" "):"";
                var name2 = carVinModel.parentName || "";
                name2 = name2?(name2+" "):"";
                var name3 = carVinModel.name||"";
                nui.get("carModel").setValue(name1 + name2 + name3);
                nui.get("carBrandId").setValue("");
                nui.get("carModelId").setValue(carVinModel.id);
                nui.get("carModelIdLy").setValue(carModelId);
                nui.unmask(document.body);
            }else{
            	nui.unmask(document.body);
            	showMsg("车型解析失败，请手工维护车型信息！","W");
            }
        });
    }else{
    	showMsg("VIN不规范，请确认！","W");
    	return;
    }

}

//手机号处理
function processMobile(mobile){
    if(checkMobile(mobile)){
        if(!nui.get("mobile2").value){
            nui.get("mobile2").setValue(mobile);
        }
    }
}
function onInsureChange(e){
	//var value = e.value;
	var row = e.selected;
	var shortName = row.shortName;
	nui.get('insureCompName').setValue(shortName);
}
function onannualInsureChange(e){
	//var value = e.value;
	var row = e.selected;
	var shortName = row.shortName;
	nui.get('annualInspectionCompName').setValue(shortName);
}
function getCarModel(callBack) {
	nui.open({
		//// targetWindow: window,,
		url : "com.hsweb.repair.common.carModelSelect.flow",
		title : "选择车型",
		width : 900,
		height : 600,
		allowDrag : true,
		allowResize : false,
		onload : function() {
		},
		ondestroy : function(action) {
			if (action == "ok") {
				var iframe = this.getIFrameEl();
				var data = iframe.contentWindow.getData(true);
				if (data && data.carModel) {
					var carModel = data.carModel || {};
                    callBack && callBack(carModel);
					/*if (elId && nui.get(elId)) {
						nui.get(elId).setValue(carModel.id);
						nui.get(elId).setText(carModel.carModel);
					}
					if (carBrandId && nui.get(carBrandId)) {
						nui.get(carBrandId).setValue(carModel.carBrandId);
						if (nui.get(carBrandId).doValueChanged) {
							nui.get(carBrandId).doValueChanged();
						}
					}
					if (carModelId && nui.get(carModelId)) {
						nui.get(carModelId).setValue(carModel.id);
					}*/
				}
			}
		}
	});
}

var parsingCarNoUrl = apiPath+sysApi + "/com.hs.common.sysService.getCarVinByCarNo.biz.ext";
function parsingCarNo() {
	var carNo = nui.get("carNo").getValue(); 
	 nui.mask({
	        el: document.body,
	        cls: 'mini-mask-loading',
	        html: '数据加载中...'
	 });
	 var json = nui.encode({
		 carNo:carNo,
		 token:token
	  });
	 nui.ajax({
	 		url : parsingCarNoUrl,
	 		type : 'POST',
	 		data : json,
	 		cache : false,
	 		contentType : 'text/json',
	 		success : function(text) {
	 			if(text.errCode=="S"){
	 				nui.get("vin").setValue(text.data.vin); 
	 				onParseUnderpanNo();
	 			//nui.unmask();
	 			//showMsg(text.errMsg || "解析成功!","S");
	 			return;
	 			}else{
	 				nui.unmask();
	 				showMsg("车架号(VIN)解析失败","W");
	 				return;
	 			}
	 			
	 		}
	});
}

//设置车型
function setCarModel(data){
	var d = data.carModel;
    nui.get("carModel").setValue(data.carModel);
}

var queryGuestUrl = apiPath + repairApi + "/com.hsapi.repair.repairService.svr.queryCustomerList.biz.ext";
function onChanged(id){
	if(id=="fullName"){
		fullName = nui.get("fullName").value;
		nui.get("shortName").setValue(fullName);
		
	}
	if(id=="mobile"){
		mobile = nui.get("mobile").value;
		var params = 
		      {
				"carNo":"",
		        "mobile":mobile
		      };
		if(mobile.length==11){
			nui.ajax({
				url : queryGuestUrl,
				type : "post",
				data : JSON.stringify({
					params:params,
					token: token
				}),
				success : function(data) {
					var list = data.list;
					var data = {};
					if(list.length){
						var guest = list[0];
						data ={
								guest:guest
						};
						setDataQuery(data);
						 empty = 1;//是否清空
					}else{
						if(empty==1){
							cardatagrid.setData([]);
		                    contactdatagrid.setData([]);
		                    basicInfoForm.setData([]);
		                    nui.get("mobile").setValue(mobile);
						}

					}
					
				},
				error : function(jqXHR, textStatus, errorThrown) {
					console.log(jqXHR.responseText);
				}
			});
		}else{
			cardatagrid.setData([]);
            contactdatagrid.setData([]);
            basicInfoForm.setData([]);
            nui.get("mobile").setValue(mobile);
		}
	}
}


function setDataQuery(data)
{
	var carNo = null;
	var guestFullName = null;
	if(data.guest){
		resultGuest.guestId=data.guest.guestId;
		carNo =data.guest.carNo;
	    guestFullName =data.guest.guestFullName;
	}
	var count = 0;
	 if(data.guest)
     {
         var guest = data.guest;
         doPost({
             url : queryUrl,
             data : {
                 guestId:guest.guestId
             },
             success : function(data)
             {
                 data = data||{};
                 if(data.guest && data.guest.id)
                 {
                     basicInfoForm.setData(data.guest);
                     initCityByParent('cityId', data.guest.provinceId || -1);
                     initCityByParent('areaId', data.guest.cityId || -1);
                     contactList = data.contactList||[{}];
                     carList = data.carList||[{}];
                     cardatagrid.setData(carList);
                     contactdatagrid.setData(contactList);
                 }
                 else{
                     showMsg("获取客户信息失败", "E");
                 }
             },
             error : function(jqXHR, textStatus, errorThrown) {
                 console.log(jqXHR.responseText);
                 showMsg("网络出错", "E");
             }
         });
     }

}



function addCar() {
	var id = basicInfoForm.getData(true).id;
	if(id==""||id==null){
		showMsg("请先保存客户信息!","W");
		return;
	}
	carIdForPhoto = null;
	nui.get("carNo").enable();
	nui.get("vin").enable();
	carInfoFrom.setData("");
	carview.show();
}

function addContact() {
	var id = basicInfoForm.getData(true).id;
	if(id==""||id==null){
		showMsg("请先保存客户信息!","W");
		return;
	}
	contactview.show();
	contactInfoForm.setData("");
	nui.get("name").setValue(fullName);
	nui.get("mobile2").setValue(mobile);
	nui.get("wechatOpenId").disable();
	nui.get("wechatServiceId").enable();
}

function addCarList(){
	var guest = {};
	nui.get("carNo").enable();
	nui.get("vin").enable();
	var updCarList=[];
	var insCarList = [];
	var insContactList=[];
	var updContactList = [];
	var car = carInfoFrom.getData(true);
	var carExtend = {};
	carExtend.lastComeKilometers = car.lastComeKilometers;
	carExtend.careDueMileage = car.careDueMileage;
	carExtend.careDueDate = car.careDueDate;
	car.carExtend = carExtend;
	//禁用的车辆不判断车牌号Vin
	if(nui.get("isDisabled").getValue()==0){
	    //判断VIN
	    var data = {};
	    data = validation(car.vin);
	    if(data.isNo){
	    	car.vin = data.vin//返回转化好的vin
	    	nui.get("vin").setValue(car.vin);
	    }else{
	    	if(car.id==""||car.id==null){
	    		nui.get("carNo").enable();
	    	}else{
	    		nui.get("carNo").disable();
	    	}
	    	nui.get("vin").enable();
	    	showMsg("VIN不规范，请确认！","W");
	    	return;
	    }
	    //判断车牌号,返回是否正确，和转化后的车牌
		var falge = isVehicleNumber(car.carNo);
		nui.get("carNo").setValue(falge.vehicleNumber);
		car.carNo = falge.vehicleNumber;
		if(!falge.result){
			if(car.id==""||car.id==null){
	    		nui.get("carNo").enable();
	    		nui.get("vin").enable();
	    	}else{
	    		nui.get("carNo").disable();
	    		nui.get("vin").disable();
	    	}
			//nui.get("carNo").enable();
			showMsg("请输入正确的车牌号","W");
			return;
		}
	}

	 guest = basicInfoForm.getData();
    guest.id = resultGuest.guestId;
    for(key in basicRequiredField){
        if(!nui.get(key).value){
            showMsg(basicRequiredField[key]+"不能为空!", "W");
            return;
        }
    }
    
    if(!checkMobile(nui.get("mobile").value)){
        return;
    }
    
    if(car.id==""||car.id==null){
    	 insCarList = [car];

    }else{
    	 updCarList = [car];
    }
    
    nui.mask({
		el : document.body,
		cls : 'mini-mask-loading',
		html : '保存中...'
	});
    
    $("#btnGroup").hide();
    doPost({
        url : saveUrl,
        data : {
            guest:guest,
            insCarList:insCarList,
            updCarList:updCarList,
            insContactList:insContactList,
            updContactList:updContactList
        },
        success : function(data)
        {
        	nui.unmask(document.body);
            data = data||{};
            if(data.errCode == "S")
            {
                showMsg("保存成功","S");
                resultCar = data.retData;
                var newRow = {
            	id : resultCar.carId,
            	guestId : resultCar.guestId,
				carNo : car.carNo,
				vin : car.vin,
				carModelFullName : car.carModelFullName,
				engineNo :car.engineNo,
				annualVerificationDueDate :car.annualVerificationDueDate,
				insureCompCode:car.insureCompCode,
				insureCompName:car.insureCompName,
				annualInspectionCompCode :car.annualInspectionCompCode,
				annualInspectionCompName :car.annualInspectionCompName,
				annualInspectionNo:car.annualInspectionNo,
				annualInspectionDate:car.annualInspectionDate,
				insureNo:car.insureNo,
				insureDueDate:car.insureDueDate,
				produceDate:car.produceDate,	
				firstRegDate:car.firstRegDate,
				issuingDate:car.issuingDate,
				lastComeKilometers:car.lastComeKilometers,
				careDueMileage:car.careDueMileage,
				careDueDate:car.careDueDate,
				driveLicensePicOne : car.driveLicensePicOne,
				driveLicensePicTwo : car.driveLicensePicTwo,
				remark:car.remark,
				isDisabled:car.isDisabled
				
			};
                var cargrid = cardatagrid.getData(true);
                for(var i = 0 ;i<cargrid.length;i++){
                	if(cargrid[i].id==car.id){
                		cardatagrid.removeRow(cargrid[i]);
                	}
                }
                cardatagrid.addRow(newRow);
       			carview.hide();
                //CloseWindow("ok");
            }
            else{
                showMsg(data.errMsg||"保存失败", "E");
            }
            $("#btnGroup").show();
        },
        error : function(jqXHR, textStatus, errorThrown) {
        	nui.unmask(document.body);
            showMsg("网络出错", "E");
            $("#btnGroup").show();
        }
    });  
		

}

function addContactList(){
	var updCarList=[];
	var insCarList = [];
	var insContactList=[];
	var updContactList = [];
	var contact = contactInfoForm.getData(true);
	if(contact.identity==""||contact.source==""){
		showMsg("身份和来源不能为空!","W");
		return;
	}else{

		var guest = basicInfoForm.getData(true);
    	guest.id = resultGuest.guestId;
    for(key in basicRequiredField){
        if(!nui.get(key).value){
            showMsg(basicRequiredField[key]+"不能为空", "W");
            return;
        }
    }
    
    if(!checkMobile(nui.get("mobile").value)){
        return;
    }
    
    if(contact.id==""||contact.id==null){
    	insContactList = [contact];

    }else{
    	updContactList = [contact];
    }
    
    nui.mask({
		el : document.body,
		cls : 'mini-mask-loading',
		html : '保存中...'
	});
    
    $("#btnGroup").hide();
    doPost({
        url : saveUrl,
        data : {
            guest:guest,
            insCarList:insCarList,
            updCarList:updCarList,
            insContactList:insContactList,
            updContactList:updContactList
        },
        success : function(data)
        {
        	nui.unmask(document.body);
            data = data||{};
            if(data.errCode == "S")
            {
                showMsg("保存成功","S");
                resultContact = data.retData;
        		var newRow = {
        				id:resultContact.contactorId,
        				guestId:resultContact.guestId,
        				name : contact.name,
        				sex : contact.sex,
        				mobile : contact.mobile,
        				identity :contact.identity,
        				source :contact.source,
        				drivingLicenceDueDate:contact.drivingLicenceDueDate,	
        				birthdayType:contact.birthdayType,
        				birthday:contact.birthday,
        				idNo:contact.idNo,
        				licensePicOne : contact.licensePicOne,
        				licensePicTwo : contact.licensePicTwo,
        				remark:contact.remark

        			};
                var contactid = contactdatagrid.getData(true);
                for(var i = 0 ;i<contactid.length;i++){
                	if(contactid[i].id==contact.id){
                		contactdatagrid.removeRow(contactid[i]);
                	}
                }
        		contactdatagrid.addRow(newRow);
        		contactview.hide();
                //CloseWindow("ok");
            }
            else{
                showMsg(data.errMsg||"保存失败", "E");
            }
            $("#btnGroup").show();
        },
        error : function(jqXHR, textStatus, errorThrown) {
        	nui.unmask(document.body);
            showMsg("网络出错", "E");
            $("#btnGroup").show();
        }
    });  
		
	}


}

function remove(){
	var row = cardatagrid.getSelected();
	cardatagrid.removeRow(row);
	
}
function eaidCar(){
	var row = cardatagrid.getSelected();
	if(row==null){
		showMsg("请选择车辆!","W");
		return;
	}
	carIdForPhoto = row.id;
	nui.ajax({
		url: baseUrl+ "com.hsapi.repair.repairService.waveBox.searchCarPhoto.biz.ext",
		type: "post",
		cache: false,
		async: false,
		data: {
			carIdForPhoto : carIdForPhoto
		},
		success: function (text) {
				if(text.errCode == "S"){
					var data = text.data;
					for(var i = 0 , l = data.length ; i < l ;i ++){
							index++;
				            var html=imageHtml(data[i].attachName,index);
							 $(".photos").before(html);
							 mouseImage();
					         photos[photos.length]={
					            		address:getCompanyLogoUrl() + info1.hash,
					            		carId: carIdForPhoto,
					            	    index : index
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
    $("#xmTanImg2").attr("src",row.driveLicensePicOne||webPath + contextPath + "/common/images/logo.jpg");
    $("#xmTanImg3").attr("src",row.driveLicensePicTwo||webPath + contextPath + "/common/images/logo.jpg");
	//cardatagrid.removeRow(row);
	carview.show();
	carInfoFrom.setData(row);
	nui.get("carNo").disable();
	if(!nui.get("vin").getValue()) {
		nui.get("vin").enable();
	}else {
		nui.get("vin").disable();
	}
}

function eaidContact(){
	var row = contactdatagrid.getSelected();
	if(row==null){
		showMsg("请选择联系人!","W");
		return;
	}
	//contactdatagrid.removeRow(row);
	contactview.show();
	contactInfoForm.setData(row);
    $("#xmTanImg").attr("src",row.licensePicOne||webPath + contextPath + "/common/images/logo.jpg");
    $("#xmTanImg1").attr("src",row.licensePicTwo||webPath + contextPath + "/common/images/logo.jpg");
	if(row.wechatOpenId && row.wechatOpenId!=null){
		nui.get("wechatServiceId").disable();
	}else{
		nui.get("wechatServiceId").enable(); 
	}
	nui.get("wechatOpenId").disable();
}

function onDrawCell(e) {
	var sexList = new Array("男", "女", "未知");
	var birthdayTypeList = new Array("农历", "阴历");
	switch (e.field) {
	case "sex":
		e.cellHtml = sexList[e.value];
		break;
	case "birthdayType":
		e.cellHtml = birthdayTypeList[e.value];
		break;


	}
	if(e.field=="source"){
		for(var i=0;i<lyData.length;i++){
			if(e.value==lyData[i].customid){
				e.cellHtml = lyData[i].name;
			}
		}
	}
	if(e.field=="identity"){
		for(var i=0;i<sfData.length;i++){
			if(e.value==sfData[i].customid){
				e.cellHtml =sfData[i].name;
			}
		}
	}
}

function onClose(e){
	if(e==1){		
		contactview.hide();
	}else{	
		carview.hide();
	}
}

function onCarNoChanged(e){
/*	var falge = isVehicleNumber(e.value);
	if(!falge){
		showMsg("请输入正确的车牌号","W");
		return;
	}*/
}

/*function isVehicleNumber(vehicleNumber) {
    var result = false;
    if (vehicleNumber.length == 7){
      var express = /^[京津沪渝冀豫云辽黑湘皖鲁新苏浙赣鄂桂甘晋蒙陕吉闽贵粤青藏川宁琼使领A-Z]{1}[A-Z]{1}[A-Z0-9]{4}[A-Z0-9挂学警港澳]{1}$/;
      result = express.test(vehicleNumber);
    }
    return result;
}*/


//判断对象是否为{}
function isEmptyObject (obj){
	for(var key in obj ){
		return false;
	}
	return true;
}

var saveOpenIdUrl = baseUrl + "com.hsapi.repair.repairService.svr.saveWechatOpenId.biz.ext";
function wechatBin(){
	var data = contactInfoForm.getData();
	if(data.wechatOpenId){
		showMsg("此联系人已绑定!","W");
		return 0;
	}
	var wechatServiceId = nui.get("wechatServiceId").value;
	if(!wechatServiceId){
		 showMsg("请输入服务号!","W");
		 return; 
	 }
	var wechatUser = {};
	 wechatUser.userPhone = data.mobile;
	 wechatUser.userMarke = wechatServiceId;
	 wechatUser.contactorId = data.id;
	 wechatUser.userName = data.name;
	 wechatUser.guestId = data.guestId;
	 nui.mask({
	        el: document.body,
	        cls: 'mini-mask-loading',
	        html: '数据加载中...'
	 });
	 var json = nui.encode({
		 carNo:"",
		 wechatUser:wechatUser,
		 token:token
	  });
	 nui.ajax({
	 		url : saveOpenIdUrl,
	 		type : 'POST',
	 		data : json,
	 		cache : false,
	 		contentType : 'text/json',
	 		success : function(text) {
	 			if(text.errCode=="S"){
	 				//data.wechatServiceId = wechatServiceId;
	 				var opid = text.re.opid;
	 				/*data.wechatOpenId = wechatOpenId;
	 				contactInfoForm.setData(data);*/
	 				nui.get("wechatOpenId").setValue(opid);
	 				var row = contactdatagrid.findRow(function(row){
						 if(data.id==row.id){
							 var newRow = row;
							 newRow.wechatServiceId = wechatServiceId;
							 newRow.wechatOpenId = opid; 
							 contactdatagrid.updateRow(row, newRow);
						 }
						 
				     });
	 			nui.unmask();
	 			showMsg(text.errMsg || "绑定成功!","S");
	 			return;
	 			}else{
	 				nui.unmask();
	 				showMsg(text.errMsg,"E");
	 				return;
	 			}
	 			
	 		}
	});
}

function split() {
	var rows = cardatagrid.getSelecteds();
	if(rows.length){
		nui.open({
	        url: webPath + contextPath +"/repair/RepairBusiness/CustomerProfile/Split.jsp?token="+token,
	        title: "资料拆分", width: 630, height: 300,
	        onload: function () {
	            var iframe = this.getIFrameEl();
	            iframe.contentWindow.setData(rows,oldGuest);
	        },
	        ondestroy: function (action) {
	        	if(action=="ok"){
	        		cardatagrid.removeRows(rows);
	        	}
	        	
	        }
	    });
	}else{
		showMsg("请选择车辆!","W");
	}
    
}

function mergeCar(){
	var rows = cardatagrid.getSelecteds();
	if(rows.length){
		nui.open({
	        url: webPath + contextPath +"/repair/RepairBusiness/CustomerProfile/selectCustomer.jsp?token="+token,
	        title: "资料合并", width: 700, height: 400,
	        onload: function () {
	            var iframe = this.getIFrameEl();
	            iframe.contentWindow.setData(rows,oldGuest);
	        },

	        ondestroy: function (action) {
	        	if(action=="ok"){
	        		cardatagrid.removeRows(rows);
	        	}
	        }
	    });
	}else{
		showMsg("请选择车辆!","W");
	}
	
}


function changeShow1(src){
	var str = src.substr(src.length-8, 4);
	if(str=="logo"){
		return;
	}
	$("#maxImgShow1").attr("src",src);
	$(".max_img1").show();
}
function changeShow(src){
	var str = src.substr(src.length-8, 4);
	if(str=="logo"){
		return;
	}
	$("#maxImgShow").attr("src",src);
	$(".max_img").show();
}
function changeHide(){
	$(".max_img").hide();
	$(".max_img1").hide();
}


function imageHtml(imageUrl,indexss){
	var html="";
	var imagerText="imagers"+indexss;
	var imagerShow="imageshow"+indexss;
	html+='<a href="#" class="imgListA '+imagerText+'">';
	html+='		<div class="" style="position: relative;" >';
	html+='		<div class="imgListOneDiv" style="display:none;" >';
	html+='			<img id="" alt="" src="'+webPath + contextPath +'/repair/prototype/images/preview.png" class="imgListone preview" num="'+indexss+'" >';
	html+='			<img  id="" alt="" src="'+webPath + contextPath +'/repair/prototype/images/deleteImage.png"  class="imgListtwo imgDelete" num="'+indexss+'" >';
	html+='		</div>';
	html+='			<img id=""  alt="" src="'+imageUrl+'" class="imgStyle '+imagerShow+'" >';
	html+='		</div>';
	html+='</a>';
	return html;
};



function addCarListPhoto(){
	if(!carIdForPhoto){
		showMsg("请先保存车辆!","W");
		return;
	}
    if(photos.length == 0){
    	showMsg("暂无图片需要保存","W");
    	return;
    }
	 nui.mask({
	        el: document.body,
	        cls: 'mini-mask-loading',
	        html: '数据加载中...'
	 });
    nui.ajax({
		url: baseUrl+ "com.hsapi.repair.repairService.waveBox.addCarPhoto.biz.ext",
		type: "post",
		cache: false,
		async: false,
		data: {
			add: photos,
			carIdForPhoto : carIdForPhoto
		},
		success: function (text) {
			nui.unmask();
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

function mouseImage(){
	//鼠标移动到图片上时触发
	$(".imgListA").mouseover(function(){
    		$(this).css("cursor","default");
		$(this).find(".imgListOneDiv").show();
		
		var height = $(this).find(".imgStyle").height();
		var width = $(this).find(".imgStyle").width();
		$( $(this).find(".imgListOneDiv") ).css("height",height+"px");
		$( $(this).find(".imgListOneDiv") ).css("width",width+"px");
		var heightTo=height/2;
		if( heightTo>20 ){
			heightTo-=20;
			$( $(this).find(".imgListOneDiv") ).css("padding-top",heightTo+"px");
		}else{
			$( $(this).find(".imgListOneDiv") ).css("padding-top",heightTo+"px");
		}
	});

	//鼠标从图片上离开时触发
	$(".imgListA").mouseout(function(){
		$(this).css("cursor","pointer");
		$(this).find(".imgListOneDiv").hide();
		
	});
	
	//删除选择的图片
	$(".imgDelete").click(function(e){
		var num=$(this).attr("num");
		for(var i =0;i<photos.length;i++){
			if(photos[i].index==num){
				photos.splice(i,1); 
			}
		}
		$(".fileImage"+num).remove();
		$(".imagers"+num).remove();
	});
	//预览选择的图片
	$(".preview").click(function(e){
		var num=$(this).attr("num");
		if(isOpen){
			for(var i =0;i<photos.length;i++){
				if(photos[i].index==num){
					preview(photos[i].address); 
				}
			}
		}

	});
}

function preview(url){
	isOpen = false;
	nui.open({
	    url: webPath + contextPath
		+ "/com.hsweb.repair.repoart.preview.flow?token="+token,
	    title: "预览图片",
		width: "700px",
		height: "610px",
		allowResize : false,
	    onload: function () {
	        var iframe = this.getIFrameEl();
	        iframe.contentWindow.setData(url);
	    },
	    ondestroy: function (action){
	    	isOpen = true;
	    }
	});
}