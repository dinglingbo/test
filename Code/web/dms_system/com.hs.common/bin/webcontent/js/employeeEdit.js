/**
 * Created by steven on 2018/1/31.
 */

var baseUrl = apiPath + sysApi + "/";
var repairUrl = apiPath + repairApi + "/";
var saveUrl = baseUrl + "com.hsapi.system.tenant.employee.saveEmployee.biz.ext";//"com.hsapi.system.employee.employeeMgr.employeeSave.biz.ext";
var fromUrl = baseUrl + "com.hsapi.system.tenant.employee.queryEmployee.biz.ext";
var sex;
var isservice;
var isservicelist = [{id: 1, name: '是'}, {id: 0, name: '否'}];
var sexlist = [{id: 1, name: '男'}, {id: 0, name: '女'}]; //[{id:0, name:"女"}, {id:1, name:"男"}];
var dimissionlist = [{id:0, name:"在职"}, {id:1, name:"离职"}];
var basicInfoForm = null;
var form1=null;
var workList=[];
var memberLever=[];
var isCanSettle ;
var isCanfreeCarnovin;
$(document).ready(function(v) {
	/*isShowOwnBill=nui.get("isShowOwnBill");
	isAllowRemind=nui.get("isAllowRemind");
	isCanSettle=nui.get("isCanSettle");
	isCanfreeCarnovin=nui.get("isCanfreeCarnovin");
	isShowOwnBill.setData(isservicelist);
	isAllowRemind.setData(isservicelist);
	isCanSettle.setData(isservicelist);	
	isCanfreeCarnovin.setData(isservicelist);*/
	isservice=nui.get("isArtificer");
	sex=nui.get("sex");
	sex.setData(sexlist);
	//isservice.setData(isservicelist);

    basicInfoForm = new nui.Form('#basicInfoForm');
    initTearm();
    initMemberLever();
    from1=basicInfoForm.getData();
    nui.get("name").focus();
	document.onkeyup=function(event){
        var e=event||window.event;
        var keyCode=e.keyCode||e.which;//38向上 40向下

        if((keyCode==27))  {  //ESC
        	 closeWindow("cal");
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
		            $("#xmTanImg").attr("src",domain + '/' + info1.key);
		            nui.get("headPortrait").setValue(domain + '/' + info1.key);
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
function onempid(e) {
    if (e.isValid) {
        if ( e.value.length >=11 ) {
            e.errorText = "必须输入不大于11位数字";
            e.isValid = false;
        }
    }
}
function SetInitData(data) {
	if (!data.empid) return; 
	var itemDiscountRate =data.itemDiscountRate*100;
	var partDiscountRate =data.partDiscountRate*100;
	basicInfoForm.setData(data);
	if(data.memberGroupId==0){
		nui.get("memberGroupId").setText("选择工作组");
	}
	if(data.memberLevelId==0){
		nui.get("memberLevelId").setText("选择技师等级");
	}
	nui.get("itemDiscountRate").setValue(itemDiscountRate);
	nui.get("partDiscountRate").setValue(partDiscountRate);
	var isArtificer = nui.get("isArtificer").value;
	   if(isArtificer == true){
	        $("#memberLevelId").show();
	   }
	   $("#xmTanImg").attr("src",data.headPortrait||webPath + contextPath + "/common/images/logo.jpg");
//	nui.get("newand").setVisible(false);
//    nui.ajax({
//        url:fromUrl + "?params/empid=" + data.empid,
//        type:"post",        
//        success:function(data)
//        {
//            nui.unmask();
//            data = data || {};
//            
//            if (data.length <= 0) return;
//            
//        	var form = new nui.Form("#basicInfoForm");
//            form.setData(data.rs[0]);    
//            nui.get("newand").setVisible(false);
//        },
//        error:function(jqXHR, textStatus, errorThrown){
//            //  nui.alert(jqXHR.responseText);
//            console.log(jqXHR.responseText);
//        }
//    });	
}

var requiredField = {
    name:"姓名",
    tel:"电话",
    idcardno:"身份证号码"
};

function save(action) {
	var form = new nui.Form("#basicInfoForm");
    var data = form.getData();
    if(data.birthday){  	
    	data.birthday = format(data.birthday, 'yyyy-MM-dd HH:mm:ss');
    }
    if(data.recordDate){   	
    	data.recordDate = format(data.recordDate, 'yyyy-MM-dd HH:mm:ss');
    }
	data.itemDiscountRate =data.itemDiscountRate/100;
	data.partDiscountRate =data.partDiscountRate/100;
    for(var key in requiredField)
    {
        if(!data[key] || data[key].trim().length==0)
        {
            showMsg(requiredField[key] + "不能为空!","W");
            return;
        }
    }
    form.validate();
    if (form.isValid() == false) return;
  
    nui.mask({
        el : document.body,
        cls : 'mini-mask-loading',
        html : '保存中...'
    });
    nui.ajax({
        url:saveUrl,
        type:"post",
        data:JSON.stringify({
        	emp:data,
        	token: token
        }),
        success:function(data)
        {
            nui.unmask();
            data = data||{};
            if (data.errCode == 'S' && action != 'new') {
                showMsg(data.errMsg,"S");
            	if (window.CloseOwnerWindow){
            		 closeWindow("ok");
                } else {
                	 closeWindow("cal");
                }
            }else{
                showMsg(data.errMsg,"W");
                //basicInfoForm.setData([]); 
            }
        },
        error:function(jqXHR, textStatus, errorThrown){
            //  nui.alert(jqXHR.responseText);
           
            closeWindow("cal");
        }
    });
}

function close() {
	if (window.CloseOwnerWindow){
		return window.CloseOwnerWindow('OK');
    } else {
        window.close();
        return ;
    }
}

function Oncancel(){
    closeWindow("cal");
}

function onIDCardsValidation(e)
{
    if (e.isValid) {
        var pattern = /^[1-9][0-9]{5}(19[0-9]{2}|20[0-9]{2})(0[1-9]|1[0-2])(0[1-9]|[12][0-9]|3[01])[0-9]{3}[0-9xX]$/;
        if (e.value.length != 18 || pattern.test(e.value) == false) {
            e.errorText = "必须输入正确的18位身份证号码";
            e.isValid = false;
        }
    }
}

function onMobileValidation(e)
{
    if (e.isValid) {
        var pattern = /^1(3|4|5|6|7|8|9)\d{9}$/;;
        if (e.value.length != 11 || pattern.test(e.value) == false) {
            e.errorText = "必须输入正确的手机号码";
            e.isValid = false;
        }
    }
}
//获取工作组
function initTearm(){
	   nui.ajax({
	        url:repairUrl +"com.hsapi.repair.baseData.team.queryWorkTeam.biz.ext",
	        type:"post",
	        async:false,
	        data:JSON.stringify({
	        	token: token
	        }),
	        success:function(data)
	        {
	        	
	        	var TearmObj=data.list;
	        	var work=nui.get('memberGroupId');
	        	for(var i=0;i<TearmObj.length;i++){
	        		var data ={
	        				id:TearmObj[i].id,
	        				name:TearmObj[i].name
	        		}
	        		workList.push(data);
	        		work.setData(workList);
	        	}
	        },
	        error:function(jqXHR, textStatus, errorThrown){
	            console.log(jqXHR.responseText);
	        }
	    });	
}
//获取技师等级
function initMemberLever(){
	 nui.ajax({
	        url:repairUrl +"com.hsapi.repair.baseData.team.queryMemberLevel.biz.ext",
	        type:"post",
	        async:false,
	        data:JSON.stringify({
	        	token: token
	        }),
	        success:function(data)
	        {
	        	var obj=data.list;
	        	var lever=nui.get('memberLevelId');
	        	for(var i=0;i<obj.length;i++){
	        		var data ={
	        				id:obj[i].id,
	        				name:obj[i].name
	        		}
	        		memberLever.push(data);
	        		lever.setData(memberLever);
	        	}
	        },
	        error:function(jqXHR, textStatus, errorThrown){
	            //  nui.alert(jqXHR.responseText);
	            console.log(jqXHR.responseText);
	        }
	    });	
	
}

function onRateValidation(e){
	var el = e.sender.id;
	if(el == "itemDiscountRate"||el == "partDiscountRate"){
				if(e.value == "" || e.value == null){

				}else{
					var reg=/^(\d|[1-9]\d)(\.\d{1,2})?$|100$/;
					if (!reg.test(e.value)) {
						e.errorText = "请输入0~100的数,最多可保留两位小数";
						e.isValid = false;
						showMsg("请输入0~100的数,最多可保留两位小数","W");
					}
				}
	}else if(el == "integralDiscountMax"||el == "freeDiscountMax"||el == "cashDiscountMax"){
			if(e.value == "" || e.value == null){

			}else{
				var reg=/(^[1-9]{1}[0-9]*$)|(^[0-9]*\.[0-9]{2}$)|0$/;
				if (!reg.test(e.value)) {
					e.errorText = "请输入大于等于0的整数或者保留两位小数";
					e.isValid = false;
					showMsg("请输入大于0的整数或者保留两位小数","W");
				}
			}
	}
}