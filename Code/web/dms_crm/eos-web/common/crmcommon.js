var _crmWebRoot = webPath + crmDomain;
var _crmApiRoot = apiPath + crmApi;

const { Client, LogLevel } = M800Core;
const { READY, FEATURE_READY } = M800Core.ClientEvent;
const ConnectionEvent = M800Core.ConnectionEvent;
const { VerificationType } = M800Verification;
const Connection = M800Core.Connection;
const CallSessionEvent = M800Call.CallSessionEvent;
 
const appMeta = {

/*applicationKey: 'mappc741a4f4-e6cc-4685-884a-e3222958b0be',
applicationSecret: 'f6b3a584-a429-41fb-b203-faf6e3bf1e93',
developerKey: 'mdev9ac578cb-05f3-4180-80df-60ff9629a86e',
developerSecret: 'b13f64af-ab62-4fba-9c6b-f157b194ae4d',
applicationIdentifier: 'com.maaii-api.org.ruixinchangyin-comphs-1-prod',
carrier: 'ruixinchangyin-comphs-1-prod.m800-api.com',
capabilities: [],
applicationVersion: '1.0.0',*/

//     applicationKey: 'mapp6819136e-7c9f-4ee3-abe0-ecbd0df69e47',
//     applicationSecret: '7f3c03af-9e89-4ac1-b285-0431bcc2f9ca',
//     developerKey: 'mdev1e81c103-2b2e-437a-869b-f34430166a02',
//     developerSecret: '037057b4-e59a-4586-8c3b-2836751c4256',
//     applicationIdentifier: 'com.maaii-api.org.ruixinchangyin-comphs-1-test',
//     carrier: 'ruixinchangyin-comphs-1-test.m800-api.com',
//     capabilities: [], 
//     applicationVersion: '1.0.0', 
		
		applicationKey: 'mappc741a4f4-e6cc-4685-884a-e3222958b0be',
	    applicationSecret: 'f6b3a584-a429-41fb-b203-faf6e3bf1e93',
	    developerKey: 'mdev9ac578cb-05f3-4180-80df-60ff9629a86e',
	    developerSecret: 'b13f64af-ab62-4fba-9c6b-f157b194ae4d',
	    applicationIdentifier: 'com.maaii-api.org.ruixinchangyin-comphs-1-prod',
	    carrier: 'ruixinchangyin-comphs-1-prod.m800-api.com',
	    capabilities: [],
	    applicationVersion: '1.0.0',

};

const config = {
    imServers: ['https://mbosh.m800.com'], //signup.m800400.cn:443  signup-bk.m800400.cn:443
    signUpServers: ['https://signupv2.m800400.cn:443'], //https://signupv2.m800400.cn:443 https://signupv2.maaii.com
    verificationServers: ['https://ivs.m800400.cn', 'https://vs-bj.m800.com'],
    callServers: ['wss://webrtcgw.m800.com:443'],
    log: {level: M800Core.LogLevel.TRACE },
    // persistConnection: true 

}



let veriMgr;
let verificationInstance;
let accountMgr;

// let deviceManager;
let callSessionManager;
// let callSession;
const options = {
    language: 'zh',
    countryCode: 'cn',
    phoneNumber: '', //86 18529219548
};


function signOut() {
    localStorage.removeItem("jid");
    accountMgr.signOut().then(res =>{
 
         layer.alert('提出成功')
    })



}
//获取设备
function getDeviceList() {
    deviceManager.getActiveDeviceList().then((deviceList) => {

        console.log(deviceList)
        //  render  device  list
    }).catch((err) => {
        // handle  the error
    });
}

//断开设备
function closeDevice(deviceId) {
    deviceManager.kickDevice(deviceId).then(() => {
        //  device  kicked
    }).catch((err) => {
        // handle  the error
    });
}

//断开所有设备

function closeAllDevice() {
    deviceManager.kickOthers().then(() => {
        alert("断开成功")
    }).catch((err) => {
        console.log(err)
        //  handle  the error
    });
}

function layerCall(type, callSession) {
    layer.open({
        content: '通话中...',
        btn: ['挂断', '静音'],
        closeBtn: 0,
        yes: function(index, layero) {

            callSession.end();
            layer.close(index);
        },
        btn2: function(index) {
            const isCallMuted = callSession.isMuted();

            if (isCallMuted) {
                callSession.setMute(false); //解开静音
                $(".layui-layer-btn1").text("静音")

            } else {
                callSession.setMute(true); //设置静音
                $(".layui-layer-btn1").text("解静")
            }

            return false
        }

    });

}

function playSound(type) {
    if (type == 1) {
        var audio = document.getElementById('music');
        audio.play()
    }

    if (type == 2) {

        var audio = document.getElementById('musicIn');
        audio.play()
    }

}

function pauseSound() {

    var audio = document.getElementById('music');
    audio.pause()

    var audioIn = document.getElementById('musicIn');
    audioIn.pause()


}

function initM800(callback) {
    // const featuresToInit = new Set(['im', 'call']);
    client = new Client(appMeta, config);

    connection = client.getConnection();

    client.on(FEATURE_READY, (feature) => {
        console.log(`${feature} ready.`);
        if (feature === 'verification') {

            veriMgr = client.getServiceLocator().get('verification');
        }

        if (feature === 'call') {
            callSessionManager = client.getServiceLocator().get('call');

            callSessionManager.on(CallSessionEvent.OUTGOING_CALL, (calledSession) => {
                console.log(calledSession)
                // handle  state,  render  view  
                //加入对方接听，弹出框
                playSound(1)
                layer.confirm('正在呼叫...', {
                    btn: ['取消'] //按钮
                   
                }, function(index) {
                    layer.close(index);
                    calledSession.end();

                });


                calledSession.on(CallSessionEvent.STATE_CHANGED, (session, fromState, toState) => {


                    //  update  UI  based on  the transition  

                    if (toState == 'connecting') {

                        console.log("已接通")
                    }

                    if (toState == 'talking') {
                        pauseSound()
                        layer.closeAll();
                      
                        layerCall(1, calledSession) //监听对方接通，才调用,m如何监听对方接通
                    }

                    if (toState == 'ended') {
                        layer.closeAll();
                        // layer.alert("通话结束")
                    }


                });






            });


            callSessionManager.on(CallSessionEvent.INCOMING_CALL, (callSession) => {


                console.log(callSession)

                console.log(callSession.getId())
                playSound(2)

                layer.confirm('有电话', {
                    btn: ['接听', '拒接'] //按钮
                    ,closeBtn: 0
                }, function(index) {
                    layer.close(index);

                    // const callSessions =   callSessionManager.getCallSessionById('13302387912');

                    // console.log(callSessions)

                    answerCall(callSession)



                }, function(index) {
                    layer.close(index)
                    callSession.end('Busy');


                });


                callSession.on(CallSessionEvent.STATE_CHANGED, (session, fromState, toState) => {
                    //  update  UI  based on  the transition  

                    console.log(toState)

                    if (toState == 'connecting') {
                        pauseSound()
                        console.log("已接通")
                    }


                    if (toState == 'talking') {
                          alert("1111")
                        layerCall(2, callSession)
                    }

                    if (toState == 'ended') {
                        layer.closeAll();
                        // layer.alert("通话结束")
                    }
                });





            })


            callSessionManager.on(CallSessionEvent.CALL_CREATION_FAILED, ({
                uri,
                direction,
                code,
                message
            }) => {

                layer.alert(message)
            });

            callSessionManager.on(CallSessionEvent.CALL_ENDED, (session) => { //这个监听方法，双方都可以看到弹框

                console.log(session)
                const { type, context } = session.getCallSessionResult();
                const callSessionResult = session.getCallSessionResult();
                console.log(callSessionResult)


                if (type == 'cancelled') { //主叫方看到
                    layer.alert('你已取消呼叫',{closeBtn: 0})
                }

                if (type == 'missed') { //被叫方看到
                    layer.alert('你有未接来电',{closeBtn: 0})
                }

                if (type == 'no-answer') { //主叫方看到
                    layer.alert('对方无应答',{closeBtn: 0})
                }

                if (type == 'rejected' && !context) { //主叫方看到
                    layer.alert('你已挂断',{closeBtn: 0})
                }

                 if (type == 'rejected' && context) { //主叫方看到
                    layer.alert('对方忙',{closeBtn: 0})
                 }

                if (type == 'error') {
                    layer.alert('通话错误',{closeBtn: 0})
                }

                if (type == 'hung-up ') { //双方看到
                    layer.alert('通话结束',{closeBtn: 0})
                }

                //   if (type == 'hung-up') {
                //     layer.alert('通话结束',{closeBtn: 0})
                // }


                pauseSound()

            });

            // connection.getStatus()
            // console.log(connection.getStatus())
           // connection.on(ConnectionEvent.STATUS_CHANGED, (res)  =>  {     
           //       console.log(res)

           //              layer.alert(res)
             
           //      }); 

           }

        accountMgr = client.getServiceLocator().get('account');


    });

    client.on(READY, () => {
        console.log('core ready.');

        $('#websdk-version').text(`version: ${M800Core.version}`);
        // deviceManager = client.getServiceLocator().get('device');
        client.addFeature(M800Verification);
        client.addFeature(M800Im)
        client.addFeature(M800Call);




    });



    
    if(localStorage.getItem('jid')){
    	console.log(localStorage);
        let status = client.getConnection().getStatus()
        console.log(status)
         if(status=='disconnected'){
             callback()
         }
        
    }
            
   

}


//function loginMySystem(user, pass) {
//const jid = getJID(user); // maybe in the cloud
//if (jid === localStorage.getItem('jid')) {
// // same user, continue
// return;
//}
//// new user
//clearStorage();
//renderSignInSignUpFlow();
//}




//function renderSignInSignUpFlow(){

// const AuthenticationRequiredError = M800Core.error.AuthenticationRequiredError;
// try {
//   client.connect(jid);
// } catch (e) {
//   if (e instanceof AuthenticationRequiredError) {
//     renderSignInSignUp();
//     return;
//   }
//   handleError(e);
// }


//}


function answerCall(callSession) {
   
    callSession.answer();
}

function signUp(opts, identity, verification) {
    console.log(opts)

    console.log(identity)
    accountMgr.signUp(opts, identity, verification)
        .then(({ jid, token }) => {
            console.log(jid)
            if (identity) {
                $(".jid01").val(jid)
            } else {
                $(".jid02").val(jid)
            }
           

            if (!localStorage.getItem('jid')) {
                localStorage.setItem("jid", jid)
               
            }

            console.log("链接服务中...")

            connect(jid)


        })
        .catch(res =>{
             layer.closeAll()
        })


}

function connect(bareJid) {
    layer.load()
    let jid =''
    if(bareJid){
          jid = bareJid
    }else{
       jid =  localStorage.getItem('jid')
    }
    
    return client.getConnection().connect(jid)
        .then((res) => {
            layer.closeAll()
            layer.msg('连接成功');
            console.log("连接成功")
            console.log(res)
            // getDeviceList()

        })
        .catch(err => {
            layer.closeAll()
            console.log(err)


        })
}


function startCall(el) {
   if(!localStorage.getItem('jid')){
        layer.alert('请先登陆')
        return false
    }

  let jid = $(el).parent().siblings().find("input[name=jidCode]").val()

    callSessionManager.makeCall(jid)

}
function makeOffnetCall(){
      callSessionManager = client.getServiceLocator().get('call');

      let phone = $('#whphone').val()
      callSessionManager.makeOffnetCall(phone)
}
function makeOffnetCallTwo(){

     let phone = $('#nMphone').val() 
      callSessionManager.makeOffnetCall(phone)
}

function getCode() {
    // if (!$('input[name="phoneNumber"]').val()) {
    //     layer.alert('请输入手机号')
    //     return false
    // }

    const verificationManager = client.getServiceLocator().get('verification');

    const type = M800Verification.VerificationType.SMS;

    // const type = M800Verification.VerificationType.IVR;

     // const type = M800Verification.VerificationType.MULTI_DEVICE

    


    options.phoneNumber = "+86" + $('input[name="phoneNumber"]').val()

    console.log(options)

   

  
    verificationManager.startVerification(type, options)
        .then((verification) => {

            // sessionStorage.setItem("verificationInstance", JSON.stringify(verification))
            console.log(verification)
            verificationInstance = verification

            layer.alert('发送成功')
        })

}


function signUpNow(loginTyle) {
    // if(sessionStorage.getItem('jid')){
    //       let opts = JSON.parse(sessionStorage.getItem('opts'))
    //       let identity = JSON.parse(sessionStorage.getItem('identity'))
    //       let verification = JSON.parse(sessionStorage.getItem('verification'))
    //             signUp(options,identity,verification)
    //     }else{

    // let verificationInstance = JSON.parse(sessionStorage.getItem('verificationInstance'))


    const verificationManager = client.getServiceLocator().get('verification')
   



    if (loginTyle == 0) {


        if (!$('input[name="code"]').val()) {
            layer.alert('请输入验证码')
            return false
        }
      // const verificationInstance  =   verificationManager.getCurrentVerification();

      console.log(verificationManager.getCurrentVerification())
      console.log(verificationInstance)

       if(verificationInstance._state!='verify-ready'){

            layer.alert('验证码已失效，请重新获取')

            return false

       }
        verificationInstance.verify($('input[name="code"]').val())
            .then((result) => {
                console.log(result)
                if (result.verification.result) {
                    console.log(options)
                    layer.load(2, { shade: false })
                    const { identity, verification } = result

                    signUp(options, identity, verification)
                }

            })
            .catch((result) => {

                layer.alert(result.message)

            })
    }


    if (loginTyle == 1) {
        layer.load(2, { shade: false })
        signUp(options)
    }

     if (loginTyle == 2) {
        layer.load(2, { shade: false })
        // options.phoneNumber = '+8613302387912'
        let identity ={
            identifierType: 'PHONE_NUMBER',     //这个是固定的,无法自定义            
            identifier: '+8613302387912',      //这个由用户输入手机号（必须是手机号格式）         
            countryCode:'CN'   //这个是固定（前提是中国）
        }
        signUp(options,identity)
    }





}

