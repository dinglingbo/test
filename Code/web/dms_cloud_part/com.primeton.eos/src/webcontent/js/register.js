/**
 * Created by lilium on 2018/5/27.
 */
var baseUrl = apiPath + frmApi + "/";//window._rootUrl||"http://127.0.0.1:8080/default/";


var msgCode=null;
var provinceCode = null;
var list = null;
var regionList =null;
var msgButton=null;

$(document).ready(function(v)
{

	msgButton=document.getElementById("msgButton");

   getProvince(function(data) {
        list = data.rs;
        nui.get("ProvinceList").setData(list);

    });


   
});

var queryUrl = baseUrl + "com.hs.common.region.getRegin.biz.ext";
function getProvince(callback) {

    nui.ajax({
        url : queryUrl,
        data : {
        	parentId:provinceCode,
            token: token
        },
        type : "post",
        success : function(data) {
            if (data && data.rs) {
                callback && callback(data);
            }
        },
        error : function(jqXHR, textStatus, errorThrown) {
           console.log(jqXHR.responseText);
        }
    });
}
function onProvinceChange(e){
    var se = e.selected;
    provinceCode = se.code;
  
    getProvince(function(data) {
    	  nui.get("RegionList").setData(data.rs);
    });
}
var msgUrl = baseUrl + "com.hsapi.cloud.part.report.report.MsgReport.biz.ext";
function sendMsg(){
	
	var params={};
	params.phone=nui.get("phone").getValue();
    nui.ajax({
        url : msgUrl,
        data : {
        	params:params,
            token: token
        },
        type : "post",
        success : function(data) {
        	if(data.data.Code=="OK")
        		{
        		msgCode=data.data.msgCode;
        		settime(10);
        		}
        	else {
        		alert(data.data.Message);
        	}
        	
        },
        error : function(jqXHR, textStatus, errorThrown) {
           console.log(jqXHR.responseText);
        }
    });
	
}
function submit(){
	var form = new mini.Form("#form1");            
	var formdata = form.getData();  
	formdata.msgCode=$("#msgCode").val();
	vaild(formdata);
	
}
function vaild(formdata){
	if(formdata.phone==""||formdata.phone.length!=11)
		nui.alert("请输入正确的手机号！");
	else if(formdata.msgCode==""||formdata.msgCode.length!=6)
		nui.alert("请输入正确的验证码！");
	else if(formdata.userName=="")
		nui.alert("请输入用户姓名！");
	else if(formdata.orgId=="")
		nui.alert("请输入公司！");
	else if(formdata.ProvinceList=="")
		nui.alert("请选择省份！");
	else if(formdata.RegionList=="")
		nui.alert("请选择区域！");
	else if(msgCode==null)
		nui.alert("请获取验证码！");
	else if(formdata.msgCode!=msgCode)
		nui.alert("验证码不匹配！");
	else {
		{
			save(formdata);
			msgCode=null;
		}
	}
}
var saveUrl = baseUrl + "com.hsapi.cloud.part.report.report.saveRegist.biz.ext";
function save(formdata){
	 nui.ajax({
	        url : saveUrl,
	        data : {
	        	params:formdata,
	            token: token
	        },
	        type : "post",
	        success : function(data) {
	        	if(data.errCode=='S'){
	        		nui.alert("成功");
	        	}else if(data.errCode=='E'){
	        		nui.alert("失败");
	        	}
	        	
	        },
	        error : function(jqXHR, textStatus, errorThrown) {
	           console.log(jqXHR.responseText);
	        }
	    });
	
}
function settime(time) {
	  if (time == 0) {
		  $("#msgButton").attr("disabled", true);
		  $("#msgButton").attr("href","javascript:sendMsg();");
		  $("#msgButton").text("点击发送验证码"); 
	    return;
	  } else {
		  $("#msgButton").attr("href","javascript:void(0);");
		  $("#msgButton").attr("disabled", false);
		  $("#msgButton").text("重新发送(" + time + ")");
		
	    time--;
	  }
	  setTimeout(function () { settime(time); }, 1000);
	}
