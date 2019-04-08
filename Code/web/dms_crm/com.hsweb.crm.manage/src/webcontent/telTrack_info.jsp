<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8" session="false" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<!-- 
  - Author(s): Administrator
  - Date: 2018-11-23 16:15:51
  - Description:
-->
<head>
  <title>Title</title>
  <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
  <script src="<%= request.getContextPath() %>/common/nui/nui.js" type="text/javascript"></script>
  <%@include file="/common/commonRepair.jsp"%>
</head>
<body> 

  <div class="nui-fit">

    <!--联系内容-->
    <%@include file="../manage/telTrack_tab1.jsp" %>
</div>

<script type="text/javascript">
    var visStatus = [{customid:"060701",name:"继续跟踪"},
    {customid:"060702",name:"终止跟踪"},
    {customid:"060703",name:"重点跟踪"},
    {customid:"060704",name:"已来厂/已成交"}];
    nui.parse();
    var mainId = null;
    var mainData = null;
    var baseUrl = apiPath + crmApi + "/"; 
    var saveUrl= apiPath + repairApi + '/com.hsapi.repair.repairService.crud.saveRemindRecord.biz.ext';
    var upUrl= apiPath + crmApi + '/com.hsapi.crm.svr.svr.updateCrmGuest.biz.ext';
    var dgScoutDetail  = nui.get("dgScoutDetail");
    var form1 = new nui.Form("#form1");
    var carModelHash = [];
    init();
 

	nui.get("saveScout").focus();
	document.onkeyup=function(event){
	var e=event||window.event;
	var keyCode=e.keyCode||e.which;//38向上 40向下
	
	if((keyCode==27)) { //ESC
	onClose();
	}
	};


    dgScoutDetail.on("drawcell", function (e) { //表格绘制
        var field = e.field;
        if(field == "scoutResult"){//跟踪结果
            e.cellHtml = setColVal('scoutResult', 'value', 'text', e.value);
        }else if(field == "scoutMode"){//跟踪方式
            e.cellHtml = setColVal('scoutMode', 'customid', 'name', e.value);
        }
    });


   function init(){
    //initComp("query_orgid");//公司组织
    //initCarBrand("carBrandId");//车辆品牌
    //initCarModel("carModelId");//车辆车型
    //initInsureComp("insureCompCode");//保险公司
    initDicts({
        scoutMode: "DDT20130703000021",//跟踪方式
       // visitStatus: "DDT20130703000081",//跟踪状态
        //query_visitStatus: "DDT20130703000081",//跟踪状态
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



function setScoutForm(record){
    mainData =record;
    $(".saveGroup").show();
    mainId = record.id;
    record.scoutMode = '011401';
    form1.setData(record);
    var currGuest = record;
    //触发选择事件
    //nui.get("carBrandId").doValueChanged();
    
    var params = {
      "p":{ 
        "def":{
                "ds":"DB10_MYSQL_WB_CRM", //数据源 必填
                "url":"com.hsapi.crm.data.crmTelsales.getScoutDetail",  //命名SQL路径 必填
                "page":true
            },
            "orgid": currOrgId,
            "guestId": currGuest.guestId
        },
        token:token
    }
    dgScoutDetail.load(params);
}




//保存跟踪
function saveScout(){
	//saveRecord() ;
  //var url =baseUrl+ "com.hsapi.crm.telsales.crmTelsales.saveScout.biz.ext";
  doSave(form1,saveRecord);
}


function doSave(tform,callBack){
    //验证
    if(!formValidate(tform)){
      showMsg("请完善信息!","W");
      return ;
  }
  var  data = tform.getData(true);
  var p ={
      id:mainId,
      nextScoutDate:data.nextScoutDate,
      visitStatus:data.visitStatus,
      priorScoutDate:mainData.nextScoutDate
  };

  try {
      nui.ajax({
        url: upUrl,
        type: 'post',
        data: nui.encode({
          crmGuest:p
      }),
        cache: false,
        success: function (data) {
          if (data.errCode == "S"){
            
            if(callBack){
              callBack();
          }
                    //tform.setData(currGuest);
                    dgScoutDetail.reload();
                }else {
                    showMsg('保存失败',"E");
                }
            },
            error: function (jqXHR, textStatus, errorThrown) {
              showMsg(jqXHR.responseText);
          }
      });
  }
  finally {        
  }  
}

function saveRecord() {
    var data = form1.getData();
    var params ={
        serviceType:1,//电销
        mainId:mainId,
        // guestId:data.guestId||'',
        guestId:'',
        carId:'',
        carNo:data.carNo||'',
        visitStatus:data.visitStatus||'',
        visitResult:data.scoutResult||'',
        visitMode:data.scoutMode||'',
        careDueDate:data.nextScoutDate||'',
        visitContent:data.scoutContent||'',
        nextVisitDate:data.nextScoutDate||'',
        guestSource:1
    }
    nui.ajax({
        url:saveUrl,
        type:'post',
        data:{
            params:params
        },
        success:function(res){
            if(res.errCode == 'S'){
                showMsg("保存成功！","S");
            }else{
                showMsg("保存失败！","E");
            }
            onClose();
        },
            error: function (jqXHR, textStatus, errorThrown) {
              showMsg(jqXHR.responseText);
          }
    })
    
}


      //选择话术
      function selTalkArt(){
         var data = {action: "sel"};
         data.url = webPath + contextPath+"/basic/talkArtTpl.jsp";
         data.width = 880;
         data.height = 520;
         openTalkArt(data, "选择话术");
     }
//收藏话术
function colleTalkArt(){
  var data = {action: "new"};
  data.artType = "";//nui.get("artType").getData();
  data.url = webPath + contextPath +"/com.hsweb.crm.basic.talkArtTpl_edit.flow?token="+token;
  data.width = 480;
  data.height = 340;
  data.content = nui.get("scoutContent").getValue();
  openTalkArt(data, "收藏话术");
}

function openTalkArt(data, title){
  mini.open({
    url: data.url,
    title: title, width: data.width, height: data.height,
    onload: function () {
      var iframe = this.getIFrameEl();
      iframe.contentWindow.setData(data);
  },
  ondestroy: function (action) {
      if(action == "ok"){
        nui.get("scoutContent").setValue(this.getIFrameEl().contentWindow.getData().content);
    }
}
});
}


function CloseWindow(action) {
if (action == "close") {
} else if (window.CloseOwnerWindow)
return window.CloseOwnerWindow(action);
else
return window.close();
}

function onClose(){
window.CloseOwnerWindow(); 
}
</script>
</body>
</html>