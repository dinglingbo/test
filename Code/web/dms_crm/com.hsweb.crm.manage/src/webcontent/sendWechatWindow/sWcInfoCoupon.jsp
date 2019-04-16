<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<!-- 
  - Author(s): Guine
  - Date: 2018-03-26 10:16:08
  - Description:
-->

<head>
    <title>优惠券-发送微信消息</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
    <%@include file="/common/commonRepair.jsp"%>

    <style>
     body { 
        margin: 0; 
        padding: 0;
        border: 0; 
        width: 100%;
        height: 100%; 
        overflow: hidden;
        font-family: "微软雅黑"; 
    }
    
    </style>
</head>

<body>
   
        <div id="form1" class="nui-form">
                <table style="width: 100%; border: 1px solid #e3e3e3;padding-left:5px;">						
                    <tr>
                        <td style="font-size: 9pt;display: flex;">
                            <label class="labeltext" >卡劵标题： </label>
                            <input id="couponTitle" name="couponTitle" class="nui-textbox inputLeft"  style="margin-right: 30px;"/>&nbsp;&nbsp;
                            <a class="nui-button" onclick="search()" plain="true" ><span class="fa fa-search fa-lg"></span>&nbsp;查询</a> 
                            <!-- <a class="nui-button" onclick="reset()" plain="true" ><span class="fa fa-refresh fa-lg"></span>&nbsp;重置</a> -->
                            <span class="separator"></span>
                            <!-- <a class="nui-button" onclick="add()" plain="true" ><span class="fa fa-plus fa-lg"></span>&nbsp;新增</a>
                            <a class="nui-button" onclick="edit()" plain="true" ><span class="fa fa-edit fa-lg"></span>&nbsp;编辑</a>
                            <a class="nui-button" onclick="deleteCoupon()" plain="true" ><span class="fa fa-remove fa-lg"></span>&nbsp;删除</a> -->
                            <a class="nui-button" onclick="pushCoupon()" plain="true"><span class="fa fa-toggle-right fa-lg"></span>&nbsp;发送</a>
                        </td>
                    </tr>
                </table>
            </div>
            
      <div class="nui-fit">
                <div id="cardCouponData" class="nui-datagrid" style="height:100%;" allowResize="true"
                    dataField="wxbCouponData" pageSize="12" showPageInfo="true" allowCellSelect="false" multiSelect="true">
                    <div property="columns">
                        <div type="checkcolumn" width="50" >选择</div>
                        <div field="couponTitle" headerAlign="center" align="center"  >卡劵标题</div>
                        <div field="couponNumber" headerAlign="center" align="center" width="65" >库存量</div>
                        <div field="couponDiscountsPrice" headerAlign="center" renderer="onCouponDiscountsPrice" align="center" width="65" >优惠价格</div>
                        <div field="couponType" headerAlign="center" align="center" renderer="onCouponType" width="65" >优惠劵类别</div>
                        <div field="couponBeginDate" headerAlign="center" align="center" width="90" dateFormat="yyyy-MM-dd" >有效开始日期</div>
                        <div field="couponEndDate" headerAlign="center" align="center" width="90" dateFormat="yyyy-MM-dd" >有效结束日期</div>
                        <div field="creator"  headerAlign="center" align="center"  width="70" >创建人</div>
                        <div field="createDate" headerAlign="center" align="center" width="140" dateFormat="yyyy-MM-dd HH:mm:ss" >创建时间</div>
                    </div>
                </div>
     </div>
        

    <script type="text/javascript">
        nui.parse();
        var pushUrl = apiPath+wechatApi+ '/com.hsapi.wechat.autoServiceBackstage.weChatCardCoupon.pushCardCoupon.biz.ext'
        var saveUrl = apiPath + repairApi +"/com.hsapi.repair.repairService.crud.saveRemindRecordMore.biz.ext";
        var pathapi=apiPath+wechatApi;
    	var pathweb=webPath+wechatDomain;
    	var cardCouponData = nui.get("cardCouponData");
        var mainList = [];
    	
    	$(function(){
    		cardCouponData.setUrl(pathapi+"/com.hsapi.wechat.autoServiceBackstage.weChatInterface.queryCardCouponChenDao.biz.ext");
			cardCouponData.load({
                map:{
                    orgid:currOrgId
                },
                token:token
            });
		});
		
		//优惠价格
		function onCouponDiscountsPrice(e){
			return Boolean(e.value) ? e.value+"元" : e.value;
		}
		
		//优惠劵类别
		function onCouponType(e){
			return e.value == 1 ?  "通用劵" : "专属劵" ;
		}
		
      function setData(rows) {
        mainList = rows;
      }
        
		//新增
		function add() {
			nui.open({
				url: pathweb+"/autoServiceSys/weChatCardCoupon/addCardCoupon.jsp",
				title: "添加优惠劵",
				width: 916,
				height: 530,
				onload: function() { //弹出页面加载完成
					var iframe = this.getIFrameEl();
					var data = {
						pageType: "add"
					}; //传入页面的json数据
					iframe.contentWindow.setFormData(data);
				},
				ondestroy: function(action) { //弹出页面关闭前
					console.log(action);
					if(action == 'saveSuccess') {
						nui.alert("添加成功", "系统提示");
						cardCouponData.reload();
					}else if(action == 'saveFail'){
						nui.alert("添加失败", "系统提示");
					}
				}
			});
		}
		
		//编辑
		function edit() {
			var row = cardCouponData.getSelected();
			if(row){
				nui.open({
					url: pathweb+"/autoServiceSys/weChatCardCoupon/addCardCoupon.jsp",
					title: "编辑优惠劵",
					width: 916,
					height: 530,
					onload: function() { //弹出页面加载完成
						var iframe = this.getIFrameEl();
						var data = {
							pageType: "edit",
							cardCouponData:row
						}; //传入页面的json数据
						iframe.contentWindow.setFormData(data);
					},
					ondestroy: function(action) { //弹出页面关闭前
						if(action == 'saveSuccess') {
							nui.alert("编辑成功", "系统提示");
							cardCouponData.reload();
						}else if(action == 'saveFail'){
							nui.alert("编辑失败", "系统提示");
						}
					}
				});
			}else{
				nui.alert("请选择一条数据");
			}
		}
		
		//删除优惠劵
		function deleteCoupon(){
			var row = cardCouponData.getSelected();
			if(row){
				row.couponDeleteStatus = 1;
				var json={cardCouponData:row};
				nui.ajax({
					url: pathapi+"/com.hsapi.wechat.autoServiceBackstage.weChatCardCoupon.editCardCoupon.biz.ext",
					type: 'POST',
					data: json,
					cache: false,
					async: false,
					contentType: 'text/json',
					success: function(text) {
						if(text.retures){
							nui.alert("删除成功", "系统提示");
							cardCouponData.reload();
						}else{
							nui.alert("删除失败", "系统提示");
						}
					}
				});
			}else{
				nui.alert("请选择一条数据");
			}
		}
		
		
		
		//搜索
    	function search(){
    		var formData = new nui.Form("#form1").getData();
        	cardCouponData.load({map:formData,token:token});
    	}
		
		//清空
    	function reset(){
    		var form = new nui.Form("#form1");
			form.reset();
    	}

        function pushCoupon() {
            var isSuccess = 0;
            var rows = cardCouponData.getSelecteds();
            if(rows.length < 1){
                showMsg("请选择优惠券",'W');
                return;
            }
            nui.mask({
            el : document.body,
            cls : 'mini-mask-loading',
            html : '发送中...'
        });
            nui.ajax({
                url:pushUrl,
                type:"post",
                async: false,
                data:{
                    userDataArray:mainList,
                    couponDataArray:rows
                },
                success:function(res){
                    nui.unmask(document.body);
                    if(res.errCode =='S'){
                        // showMsg("发送成功","S");
                        //isSuccess=1;
                       saveRecord(); 
           
                    }else{
                        showMsg("发送失败","E");
                    }
                    onClose();
                }
            })
            /* if(isSuccess){
                saveRecord();
            } */
        }


        function saveRecord() {
            var rows = cardCouponData.getSelecteds();
            var contentText = '';
            var contentId = '';
            for (var k = 0; k < rows.length; k++) {
                var element = rows[k];
                contentText += rows[k].couponTitle;
                contentId += rows[k].couponId;
                if(k != (rows.length-1)){
                    contentText += ',';
                    contentId +=  ',';
                }
                if( k == rows.length - 1 ){
                    //拼接对象
                    var pArr = [];
                    for (var i = 0; i < mainList.length; i++) {
                        var data = mainList[i];
                        var params ={
                            serviceType:data.serviceType,
                            mainId:data.id||'',
                            guestId:data.guestId||'',
                            carId:data.carId||'',
                            carNo: data.carNo || '',
                            visitMode:'011405',//微信卡券
                            visitContent:contentText,
                            guestSource:data.guestSource,
                            contentId:contentId
                        }
                        pArr.push(params);

                        if(i == mainList.length-1){
                            var paramData=nui.encode({params:pArr});
                            //开始
                            nui.ajax({
                                url:saveUrl,
                                type:'post',
                                async: false,
                                data:paramData,
                                success:function(res){
                                    if(res.errCode == 'S'){
                                            showMsg("发送成功！","S");
                                            
                                    }else{
                                            showMsg("发送失败！","E");
                                    }
                                    onClose() ;
                                },
                                error: function (jqXHR) {
                                    showMsg(jqXHR.responseText);
                                }
                            })
                            //结束

                        }

                    }
                    //结束拼接对象

                }
            }

            

            
   
}


        function onClose() {
            window.CloseOwnerWindow();
        }

        function CloseWindow(action) {
            if (action == "close") {

            } else if (window.CloseOwnerWindow)
                return window.CloseOwnerWindow(action);
            else
                return window.close();
        }

 

    	
    </script>
</body>

</html>