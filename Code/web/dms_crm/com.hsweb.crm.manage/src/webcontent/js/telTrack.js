var baseUrl = apiPath + repairApi + "/";
var getScoutGuestListUrl = apiPath + crmApi +"/com.hsapi.crm.telsales.crmTelsales.getScoutGuestList.biz.ext";
var queryForm;
var dgGrid;
var currGuest;
var memList = [];
var memHash={};  
var carModelHash = [];
var loginWin = null;

$(document).ready(function (v) {
    queryForm = new nui.Form("#queryForm"); 
    dgGrid = nui.get("dgGrid");
    loginWin = nui.get("loginWin");
    dgGrid.setUrl(getScoutGuestListUrl);
    dgGrid.on("beforeload",function(e){ 
        e.data.token = token;
    });
    dgGrid.on("select", function (e) {
        var params = {//电销
            mainId:e.record.id,
            guestSource:1,
            token:token
        }; 
        loadVisitHis(params);
    }); 

    dgGrid.on("drawcell", function (e) { //表格绘制
     var field = e.field;
     if(field == "orgid"){ 
        e.cellHtml = setColVal('query_orgid', 'orgid', 'orgname', e.value);
        }else if(field == "carBrandId"){//品牌
            e.cellHtml = setColVal('carBrandId', 'id', 'nameCn', e.value);
        }else if(field == "carModelId"){//车型
            e.cellHtml = setColVal('carModelId', 'carModelId', 'carModel', e.value);
        }else if(field == "visitStatus"){//跟踪状态
            e.cellHtml = setColVal('query_visitStatus', 'customid', 'name', e.value);
        }else if(field == "visitManId"){//营销员
            if(memHash[e.value]){
                e.cellHtml = memHash[e.value].empName || "";
            }
        }
    });
      


    var filter = new HeaderFilter(dgGrid, {
        columns: [
            { name: 'carModel' },
            { name: 'recorder' },
            { name: 'guestName' }
        ],
        callback: function (column, filtered) {
        },

        tranCallBack: function (field) {
        	var value = null;
        	switch(field){

	    	}
        	return value;
        }
    });
    document.onkeyup = function(event) {
        var e = event || window.event;
        var keyCode = e.keyCode || e.which;// 38向上 40向下
        if ((keyCode == 13)) { // F9
            query();
        }
    }
    
    initMember("visitManId",function(){
        memList = nui.get('visitManId').getData();
        memList.forEach(function(v) {
            memHash[v.empId] = v;
        });
    });
    nui.get('visitManId').setValue(currEmpId);
    init();
    query();
    
    //initM800(connect);
});

function init(){
    initComp("query_orgid");//公司组织
    initCarBrand("carBrandId");//车辆品牌
    //initInsureComp("insureCompCode");//保险公司
    initDicts({
        visitMode: "DDT20130703000021",//跟踪方式
        //visitStatus: "DDT20130703000081",//跟踪状态
        query_visitStatus: "DDT20130703000081"//跟踪状态
        //artType: "DDT20130725000001"//话术类型    
    });

}


function onCarBrandChange(e){     
    initCarModel("carModelId", e.value,"", function () {
        var data = nui.get("carModelId").getData();
        data.forEach(function (v) {
            carModelHash[v.id] = v;
        });
    });
}

/*
 *查询
 **/
 function query(){ 
    var data = queryForm.getData();
    var params = {}; 
    params.p = data;
    dgGrid.load(params,null,function(){
        //失败;
        showMsg("数据加载失败！","E");
    });
}

function add(){
    editWin("新增模板", {});
}

function edit(){
    var row = dgGrid.getSelected();
    if (row) {
        editWin("修改模板", row);
    } else {
        showMsg("请选中一条记录","W");
    }
}

function editWin(title, data){
   // data.artType = tree1.getData();
   mini.open({
    url: webPath + contextPath + "/com.hsweb.crm.basic.smsTpl_edit.flow?token="+ token,
    title: title, width: 500, height: 420,
    onload: function () {
        var iframe = this.getIFrameEl();
            //var data = { action: "edit", id: row.id };
            iframe.contentWindow.setData(data);
        },
        ondestroy: function (action) {
            //var iframe = this.getIFrameEl();
            dgGrid.reload();
        }
    });
}
function clearQueryForm(){
    queryForm.setData({});
}

function newClient(){
    mini.open({
        url: webPath + contextPath + "/com.hsweb.crm.manage.clientInfo_edit.flow?token="+ token,
        title: "新增客户资料", width: 520, height: 550,
        onload: function () { 
            var iframe = this.getIFrameEl();
            //var data = { action: "edit", id: row.id };
            iframe.contentWindow.setData({});
        },
        ondestroy: function (action) {
            //var iframe = this.getIFrameEl();
            dgGrid.reload();
        }
    });
}

function editClient(){
    var row = dgGrid.getSelected();
    if (row == undefined) {
        showMsg("请选中一条数据","W");
        return;
    }
    mini.open({
        url: webPath + contextPath + "/com.hsweb.crm.manage.clientInfo_edit.flow?token="+ token,
        title: "修改客户资料", width: 520, height: 550,
        onload: function () { 
            var iframe = this.getIFrameEl();
            //var data = { action: "edit", id: row.id };
            iframe.contentWindow.setData(row);
        },
        ondestroy: function (action) {
            //var iframe = this.getIFrameEl();
            dgGrid.reload();
        }
    });
}



/*function onEditClick(){
    //var data = investGrid.getSelected();
    if(data == null){
        showMsg("请先选择一条数据","W");
        return;
    }
    nui.open({
        url: webPath + contextPath+ "/com.hsweb.crm.manage.investDetail.flow?token="+ token,
        title: "业绩修改",
        allowResize:false,
        width: 400,
        height: 300,
        onload: function () {
            var iframe = this.getIFrameEl();
            iframe.contentWindow.setData(data);
         },
         ondestroy: function (action) {
             if(action == "ok"){
                 search();
             }
         }
    });
}
*/


function sendInfo(){
    var row = dgGrid.getSelected()||{};
    if (row == undefined) {
        showMsg("请选中一条数据","W");
        return; 
    }
    if (!row.mobile) {
        showMsg("该客户没有手机号码，无法发送短信","W");
        return; 
    }
    row.guestId = '';
    row.serviceType = 1;//电销
    row.guestSource = 1;
    nui.open({
        url: webPath + contextPath  + "/com.hsweb.crm.manage.sendInfo.flow?token="+token,
        title: "发送短信", width: 655, height: 280,
        onload: function () {
            var iframe = this.getIFrameEl();
            iframe.contentWindow.setData(row);
        },
        ondestroy: function (action) {
            //重新加载
            //query(tab);
            visitHis.reload();
        }
    });

}

function telInfo(e){
    var row = dgGrid.getSelected();
    if (row == undefined) {
        showMsg("请选中一条数据","W");
        return;
    }
    if(e){
        var data=e.record;
    }else{

        var data =row;
    }
    nui.open({
        url: webPath + contextPath  + "/manage/telTrack_info.jsp?token="+token,
        title: "电话跟踪", width: 650, height:350,
        onload: function () {
            var iframe = this.getIFrameEl();
            iframe.contentWindow.setScoutForm(data);
        },
        ondestroy: function (action) {
            //重新加载
            //dgGrid.reload();
            visitHis.reload();
        }
    });

}


function addRow() {
        var row = dgGrid.getSelected();
    if (row == undefined) {
        showMsg("请选中一条数据","W");
        return;
    }
    nui.open({
        url: webPath + contextPath + "/repair/RepairBusiness/BookingManagement/BookingManagementEdit.jsp?token="+token,
        title: "新增预约", width: 750, height: 400,
        onload: function () {
            var iframe = this.getIFrameEl();
            var data = {};
            data.mtAdvisorId = currEmpId;
            data.mtAdvisor = currUserName;
            data.contactorName = row.guestName;
            data.contactorTel = row.mobile;
            data.carBrandId = row.carBrandId;
            data.carNo = row.carNo;
            var param = { action: "add", data: data };
            iframe.contentWindow.SetData(param);
        },
        ondestroy: function (action) {
            dgGrid.reload();
        }
    });
}

// function signwUp() {
	
// layer.load(2, { shade: false })
//             // options.phoneNumber = '+8613302387912'
//             var  identity ={
//                 identifierType: 'PHONE_NUMBER',     //这个是固定的,无法自定义            
//                 identifier: '+8613302387912',      //这个由用户输入手机号（必须是手机号格式）         
//                 countryCode:'CN'   //这个是固定（前提是中国）
//             };
//             signUp(options,identity);

// }

// function signwDown() {
	
// }


function login() {
    if (loginWin.visible == false) {
        var atEl = document.getElementById("login");  
        loginWin.showAtEl(atEl, {xAlign:"right",yAlign:"below"});
    } else {
        loginWin.hide();
    }
}

function hideLoginWin() {
    loginWin.hide();
}  
// 
//function onLogin() {
//    var lmobile = nui.get("LoginMobile");
//    var VerificationCode = nui.get("VerificationCode");
//    if (checkMobile(lmobile.value)) { 
//        if (VerificationCode.value) {
//            //执行登录操作
//            signIn();
//        } else {
//            showMsg("请输入验证码", "W");
//        }
//    }
//}
// 
//function getCode() {
//    if (checkMobile(nui.get("LoginMobile").value)) { 
//    const verificationManager = client.getServiceLocator().get('verification');
//    const type = M800Verification.VerificationType.SMS;
//    // const type = M800Verification.VerificationType.IVR;
//     // const type = M800Verification.VerificationType.MULTI_DEVICE
//
//    options.phoneNumber = "+86" + nui.get("LoginMobile").value
//    console.log(options)
//  
//    verificationManager.startVerification(type, options)
//        .then((verification) => {
//
//            // sessionStorage.setItem("verificationInstance", JSON.stringify(verification))
//            console.log(verification)
//            verificationInstance = verification
//
//            showMsg("发送成功", "S");
//        })
//    }
//}
//
//function signIn() {
//    var VerificationCode = nui.get("VerificationCode");
//    //const verificationManager = client.getServiceLocator().get('verification');
//   // const verificationInstance = verificationManager.getCurrentVerification();
////       let identity = JSON.parse(sessionStorage.getItem('identity'))
////       let verification = JSON.parse(sessionStorage.getItem('verification'))
//    if(verificationInstance._state!='verify-ready'){
//        showMsg("验证码已失效，请重新获取", "W");
//        return false
//   }
//    verificationInstance.verify(VerificationCode.value)
//        .then((result) => {
//            console.log(result)
//            if (result.verification.result) {
//                console.log(options)
//                layer.load(2, { shade: false })
//                const { identity, verification } = result
//                signUp(options, identity, verification)
//            }
//        })
//        .catch((result) => {
//            showMsg(result.message, "S");
//
//        });
//}
//
//function signUp(opts, identity, verification) {
//    console.log(opts)
//
//    console.log(identity)
//    accountMgr.signUp(opts, identity, verification)
//        .then(({ jid, token }) => {
//            console.log(jid)
//            if (identity) {
//                $(".jid01").val(jid)
//            } else {
//                $(".jid02").val(jid)
//            }
//            if (!localStorage.getItem('jid')) {
//                localStorage.setItem("jid", jid)
//            }
//            console.log("链接服务中...")
//            connectA(jid)
//        })
//        .catch(res =>{
//             layer.closeAll()
//        })
//}
//
//function connectA(bareJid) {
//    layer.load()
//    let jid =''
//    if(bareJid){
//          jid = bareJid
//    }else{ 
//       jid =  localStorage.getItem('jid')
//    }
//     
//    return client.getConnection().connect(jid)
//        .then((res) => {
//            loginWin.hide();
//            document.getElementById("userStatus").style.color = '#62b900';
//            layer.closeAll()
//            layer.msg('连接成功');
//            console.log("连接成功")
//            console.log(res)
//            // getDeviceList()
//
//        })
//        .catch(err => {
//            layer.closeAll()
//            console.log(err)
//
//
//        })
//}
//
//function signOut() {
//    localStorage.removeItem("jid")
//    accountMgr.signOut().then(res =>{
//         layer.alert('退出成功');
//    })
//    document.getElementById("userStatus").style.color = '#2779aa';
//}
//
//function makeOffnetCall(){
//	callSessionManager = client.getServiceLocator().get('call');
//    let phone ='+86'+ nui.get("tarMobile").value;
//    callSessionManager.makeOffnetCall(phone);
//}