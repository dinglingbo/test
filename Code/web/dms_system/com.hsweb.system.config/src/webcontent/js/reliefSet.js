/**
 * Created by steven on 2018/1/31.
 */
baseUrl = apiPath + sysApi + "/";;


var grid;
var time;
var person;
var provinceList=[];
var provinceHash={};
var cityList=[];
var cityHash={};
var queryForm;
var provinceCode;
nui.parse();
var productStatus;
var types;



$(document).ready(function(v) {
	
	
	
});












/*

*
*免责条款处理
*/
var orderPrintUrl = baseUrl + "com.hsapi.system.confi.paramSet.saveDisclaimer.biz.ext";
function orderPrintSet(type,iscopy){
	
	var content;
	var keyidId;
	var s={};
	var e;
	keyidId=type;
	if(type=='repair_sett_print_content'){
		
		e=$("#settArea");//获取textarea的id  
		content=e.val();
		if(content==''){
			nui.alert('不能保存空内容');
			return ;
		}
		nui.mask({
	        el : document.body,
	        cls : 'mini-mask-loading',
	        html : '保存结算打印单中...'
	    });
		}
	else{
		
		 e=$("#entrustArea");//获取textarea的id  
		content=e.val();
		if(content==''){
			nui.alert('不能保存空内容');
			return ;
		}
		nui.mask({
	        el : document.body,
	        cls : 'mini-mask-loading',
	        html : '保存委托打印单中...'
	    });
		}
	
	s.content=content;
	s.keyidId=keyidId;
	nui.ajax({
		url:orderPrintUrl,
		type:"post",
		data:{
			params:s
		},
		success: function (data) {
               if (data.errCode == "S"){
               	nui.unmask(document.body);
               	if(iscopy==0)
               	nui.alert("保存成功！");
               	}
				else{
				nui.unmask(document.body);
				if(iscopy==0)
               	nui.alert("保存失败！");
               	}
       
           },
           error: function (jqXHR, textStatus, errorThrown) {
               nui.alert(jqXHR.responseText);
           }
	
	});
	if(iscopy==1){
		
	    e.select(); //选择textarea的文本内容  
	    document.execCommand("Copy"); //执行浏览器复制命令  
	    nui.alert("保存并复制成功！");
	}
}
