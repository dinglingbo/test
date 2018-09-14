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
$(document).ready(function(v) {
	isservice=nui.get("isArtificer");
	sex=nui.get("sex");
	sex.setData(sexlist);
	//isservice.setData(isservicelist);

    basicInfoForm = new nui.Form('#basicInfoForm');
    initTearm();
    initMemberLever();
    from1=basicInfoForm.getData();
});

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
	basicInfoForm.setData(data);
	var isArtificer = nui.get("isArtificer").value;
	   if(isArtificer == true){
	        $("#memberLevelId").show();
	   }
	nui.get("newand").setVisible(false);
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
    
    for(var key in requiredField)
    {
        if(!data[key] || data[key].trim().length==0)
        {
            showMsg(requiredField[key] + "不能为空!","W");
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
            showMsg(data.errMsg,"S");
            
            if (data.errCode == 'S' && action != 'new') {
            	if (window.CloseOwnerWindow){
            		 closeWindow("ok");
                } else {
                	 closeWindow("cal");
                }
            }else{
                basicInfoForm.setData([]); 
//                nui.get("name").focus();
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
        var pattern = /^1(3|5|6|7|8|9)\d{9}$/;;
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