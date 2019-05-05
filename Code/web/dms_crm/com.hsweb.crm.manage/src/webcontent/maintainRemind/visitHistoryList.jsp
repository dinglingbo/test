<%@ page language="java" contentType="text/html; charset=UTF-8"
  pageEncoding="UTF-8" session="false" %>
  <div class="nui-fit box">
        <input name="visitMode" id="visitMode" class="nui-combobox "textField="name" valueField="customid" visible="false"/>
    <div id="visitHis" dataField="list" class="nui-datagrid" style="width: 100%; height: 100%;"
        multiSelect="false" pageSize="20" showPageInfo="true" selectOnLoad="true"  onDrawCell="" onselectionchanged=""
        allowSortColumn="false" totalField='page.count' allowCellWrap="true" contextMenu="#gridMenu" pagerButtons="#playMenu">
        <div property="columns">
            <div type="indexcolumn" headerAlign="center" header="序号" width="40px"></div>
            <div field="visitDate" headerAlign="center" dateFormat="yyyy-MM-dd HH:mm" allowSort="true" width="110px">回访日期</div>
            <div field="serviceType" headerAlign="center" allowSort="true" width="90px">回访类型</div>
            <div field="visitMode" headerAlign="center" allowSort="true" width="80px">回访方式</div>
            <div field="visitContent" headerAlign="center" allowSort="true" width="200px">回访内容</div>
            <div field="visitMan" headerAlign="center" allowSort="true" width="90px">回访员</div>
            <div field="carNo" width="75" headerAlign="center"align="center">车牌号</div>
            <div field="contactorName" headerAlign="center" allowSort="true" width="100px">客户名称</div>
            <div field="recordId" headerAlign="center" allowSort="true" width="110px">通话详情</div>
        </div>
    </div>
    <ul id="gridMenu" class="mini-contextmenu" onbeforeopen="">              
	    <li name="remove"  onclick="edit"><span class="fa fa-edit fa-lg"></span>修改</li>        
	    <li name="remove"  onclick="onRemove"><span class="fa fa-remove fa-lg"></span>删除</li>        
    </ul>
    <div id="playMenu">
        <span class="separator">
        <video id="video" controls="" name="media" style="width:300px;height: 19.5px;">
            <source src="http://test.file.recency.cn/auto-record-20190313-3fd0f9af-5114-432d-8d61-ec74698e8db2.wav?sign=975fab600906e63d71ebfcdcf43c5757&amp;t=5cc04a50" type="audio/x-wav">
            </video>
            <!-- <span class="fa fa-remove fa-lg" style="vertical-align: 34%;"  click="playClose()" alt="关闭播放控件"></span> -->
            <a   herf="##"  onclick="playClose()" plain="true" style="width: 60px;" title="关闭播放控件"><span  class="fa fa-remove fa-lg"  style="vertical-align: 34%;cursor:pointer" ></span></a>
    </div>
   <!-- <div class="drag-box" id="voiceDiv">
        <!-- <video controls="" autoplay="" name="media" style="width:250px;height: 40px;">
            <source src="http://test.file.recency.cn/auto-record-20190313-3fd0f9af-5114-432d-8d61-ec74698e8db2.wav?sign=975fab600906e63d71ebfcdcf43c5757&amp;t=5cc04a50" type="audio/x-wav">
            </video> 
    </div> -->
</div>
<style>
.box{

}
.drag-box{
width:300px;
height: 100px;
background: #369;
position: absolute;
left:0;
top:0;
z-index: 999;
}
</style>
<script type="text/javascript">
    nui.parse();
    var hisUrl = apiPath + crmApi+ "/com.hsapi.crm.svr.visit.queryCrmVisitRecordSql.biz.ext";
    var delUrl = apiPath + crmApi+ "/com.hsapi.crm.svr.visit.delectVisitRecordById.biz.ext";
    var visitHis = null; //回访历史
    var serviceTypeList = [{},{ id: 1, text: '电销' }, { id: 2, text: '预约' }, { id: 3, text: '客户回访' }, { id: 4, text: '流失回访' }, { id: 5, text: '保养提醒' }, { id: 6, text: '商业险到期' }, { id: 7, text: '交强险到期' }, { id: 8, text: '驾照年审' }, { id: 9, text: '车辆年检' }, { id: 10, text: '生日' }, { id: 11, text: '其他' }];
    visitHis = nui.get("visitHis"); 
    visitHis.setUrl(hisUrl);
    var video = document.getElementById("video");

    initDicts({
        visitMode: "DDT20130703000021",//跟踪方式
        // visitStatus: "DDT20130703000081",//跟踪状态
        //query_visitStatus: "DDT20130703000081",//跟踪状态
        //artType: "DDT20130725000001"//话术类型        
    });
    $("#playMenu").hide();


//     ;(function(){
// var oBox = document.querySelector('.box');
// var oDrag = document.querySelector('.drag-box');
 
// oDrag.onmousedown = function(ev){
// var oEvent = ev || event;
// var disX = oEvent.clientX - oDrag.offsetLeft;
// var disY = oEvent.clientY - oDrag.offsetTop;
 
// document.onmousemove = function(ev){
// var oEvent = ev || event;
// let left = oEvent.clientX - disX;
// let top = oEvent.clientY - disY;
 
// left<=0 && (left = 0);
// top<=0 && (top = 0);
// left>=(oBox.offsetWidth - oDrag.offsetWidth) && (left = oBox.offsetWidth - oDrag.offsetWidth);
 
// top>=(oBox.offsetHeight - oDrag.offsetHeight) && (top = oBox.offsetHeight - oDrag.offsetHeight);
 
// document.title = left+','+top;
// oDrag.style.left = left +'px';
// oDrag.style.top = top +'px';
// };
// document.onmouseup = function(){
// document.onmousemove=null;
// document.onmouseup=null;
// };
// return false;
// };
// })()



    visitHis.on("drawcell", function (e) {
        if (e.field == "serviceType") {
            e.cellHtml = serviceTypeList[e.value].text;
        } else if(e.field == "visitMode"){//跟踪方式
            e.cellHtml = setColVal('visitMode', 'customid', 'name', e.value);
        }else if(e.field == 'recordId' && e.record.visitMode == '011401'){
            e.cellHtml = '  <a class="nui-button" onclick="playVoice()" plain="true" style="cursor:pointer"><span class="fa fa-volume-up fa-lg"></span>&nbsp;播放通话语音</a>'
            //e.cellHtml = '<a class="nui-button"  click="playVoice">播放通话语音</a>'
        }
    });
    visitHis.on("rowdblclick", function (e) {

    });

    function playVoice() {
    var row =visitHis.getSelected();
    $("#playMenu").show();
    video.load();
    video.play();
    // nui.open({
    //         url: webPath + contextPath +'/manage/maintainRemind/playVoice.jsp?token='+token,
    //         title: '播放文件', width: 600, height:300 ,
    //         onload: function () {
    //             var iframe = this.getIFrameEl();

    //         },
    //         ondestroy: function (action) {
    //         }
    //     });
} 

function playClose() {
    $("#playMenu").hide();
    video.pause();
}


    function loadVisitHis(params) {//guestSource: 0系统客户  1电销客户
        // var params = {//系统
        //     guestId:guestId,
        //     guestSource:guestSource,
        //     token:token
        // };

        // var params = {//电销
        //     mainId:mainId,
        //     guestSource:guestSource,
        //     token:token
        // };
        visitHis.load({ params:params,token:token });
    }



function edit() {
    var row =visitHis.getSelected();
    nui.open({
            url: webPath + contextPath +'/manage/maintainRemind/visitHistoryListDet.jsp?token='+token,
            title: '修改', width: 600, height:300 ,
            onload: function () {
                var iframe = this.getIFrameEl();
                iframe.contentWindow.setData(row);
            },
            ondestroy: function (action) {
                visitHis.reload();
            }
        });
}

function onRemove(){
	var row =visitHis.getSelected();
	if(row){
	       	 nui.confirm("确定删除记录？", "确定？",
            function (action) {
                if (action == "ok") {
                		nui.ajax({
							url:delUrl,
							type:"post",
							data:{visitRecord:row},
							success:function(res){
								if(res.errCode == 'S'){
									showMsg("删除成功","S");
									 visitHis.reload();
								}
							}
						});
                } else {
                    return;
                }
            }
        );
	}
}


</script>