<%@ page language="java" contentType="text/html; charset=UTF-8"
  pageEncoding="UTF-8" session="false" %>
    <div id="mainTabs" class="nui-tabs" name="mainTabs" activeIndex="0" style="width:100%; height:100%;" plain="false" onactivechanged="activechangedmain()">
        <div title="随车物品">
            <div class="nui-fit box">
                <input name="visitMode" id="visitMode" class="nui-combobox " textField="name" valueField="customid" visible="false" />
                <div id="visitHis" dataField="list" class="nui-datagrid" style="width: 100%; height: 100%;" multiSelect="false" pageSize="20"
                    showPageInfo="true" selectOnLoad="true" onDrawCell="" onselectionchanged="" allowSortColumn="false" totalField='page.count'
                    allowCellWrap="true" contextMenu="#gridMenu" pagerButtons="#playMenu">
                    <div property="columns">
                        <div type="indexcolumn" headerAlign="center" header="序号" width="40px"></div>
                        <div field="visitDate" headerAlign="center" dateFormat="yyyy-MM-dd HH:mm" allowSort="true" width="110px">回访日期</div>
                        <div field="serviceType" headerAlign="center" allowSort="true" width="90px">回访类型</div>
                        <div field="visitMode" headerAlign="center" allowSort="true" width="80px">回访方式</div>
                        <div field="visitContent" headerAlign="center" allowSort="true" width="200px">回访内容</div>
                        <div field="visitMan" headerAlign="center" allowSort="true" width="90px">回访员</div>
                        <div field="carNo" width="75" headerAlign="center" align="center">车牌号</div>
                        <div field="contactorName" headerAlign="center" allowSort="true" width="100px">客户名称</div>
                        <div field="recordId" headerAlign="center" allowSort="true" width="110px">通话详情</div>
                    </div>
                </div>
                <ul id="gridMenu" class="mini-contextmenu" onbeforeopen="">
                    <li name="remove" onclick="edit">
                        <span class="fa fa-edit fa-lg"></span>修改</li>
                    <li name="remove" onclick="onRemove">
                        <span class="fa fa-remove fa-lg"></span>删除</li>
                </ul>
                <div id="playMenu">
                    <span class="separator">
                        <video id="video" controls="" name="media" style="width:300px;height: 19.5px;">
                            <source src="http://test.file.recency.cn/auto-record-20190313-3fd0f9af-5114-432d-8d61-ec74698e8db2.wav?sign=975fab600906e63d71ebfcdcf43c5757&amp;t=5cc04a50"
                                type="audio/x-wav">
                        </video>
                        <a herf="##" onclick="playClose()" plain="true" style="width: 60px;" title="关闭播放控件">
                            <span class="fa fa-remove fa-lg" style="vertical-align: 34%;cursor:pointer"></span>
                        </a>
                </div>
            </div>
        </div>
        <div title="服务记录" id="serviceRecord" name="serviceRecord">
            <div id="mainGrid1" class="nui-datagrid" style="width:100%;height:95%;" selectOnLoad="true" showPager="true" totalField="page.count"
                dataField="data" onrowdblclick="" allowCellSelect="true" url="" onshowrowdetail="onShowRowDetail">
                <div property="columns">
                    <!--                 <div type="expandcolumn" width="20" ><span class="fa fa-plus fa-lg"></span></div> -->
                    <div field="id" name="id" width="60" headerAlign="center" visible="false" header="工单ID"></div>
                    <div field="carNo" name="carNo" width="60" headerAlign="center" header="车牌号"></div>
                    <div field="contactName" name="contactName" width="70" headerAlign="center" header="联系人姓名"></div>
                    <div field="contactMobile" name="contactMobile" width="80" headerAlign="center" header="联系人手机"></div>
                    <div field="enterDate" width="160px" headerAlign="center" dateFormat="yyyy-MM-dd HH:mm" header="进店日期"></div>
                    <div field="enterKilometers" name="enterKilometers" width="60" headerAlign="center" allowsort="true" header="进厂里程"></div>
                    <div field="mtAdvisor" name="mtAdvisor" width="70" headerAlign="center" header="服务顾问"></div>
                    <div field="serviceCode" name="serviceCode" width="150" headerAlign="center" header="工单号"></div>
                    <div field="outDate" name="outDate" width="110" headerAlign="center" header="结算日期" dateFormat="yyyy-MM-dd HH:mm"></div>
                    <div field="balaAmt" name="balaAmt" width="50" headerAlign="center" header="金额"></div>
                </div>
            </div>
        </div>
        <div title="退货记录" id="returnMain" name="returnMain">
            <div id="mainGrid" class="nui-datagrid" style="width:100%;height:100%;" selectOnLoad="true" showPager="true" pageSize="50"
                totalField="page.count" sizeList=[20,50,100,200] dataField="list" onrowdblclick="" allowCellSelect="true" editNextOnEnterKey="true"
                onshowrowdetail="onShowRowDetail" allowCellEdit="true" url="">
                <div property="columns">
                    <div type="indexcolumn">序号</div>
                    <div type="expandcolumn" width="20">
                        <span class="fa fa-plus fa-lg"></span>
                    </div>
                    <div field="status" name="status" width="50" headerAlign="center" header="状态"></div>
                    <div field="serviceCode" name="serviceCode" width="110" headerAlign="center" header="工单号"></div>
                    <div field="carNo" name="carNo" width="80" headerAlign="center" header="车牌"></div>
                    <div field="recordDate" name="recordDate" width="100" headerAlign="center" header="开单时间" dateFormat="  yyyy-MM-dd HH:mm"></div>
                    <div field="carModel" name="carModel" width="80" headerAlign="center" header="品牌车型"></div>
                    <div field="carVin" name="carVin" width="80" headerAlign="center" header="车架号(VIN)"></div>
                    <div field="contactName" name="contactName" width="80px" headerAlign="center" header="联系人姓名"></div>
                    <div field="contactMobile" name="contactMobile" width="100px" headerAlign="center" header="联系人手机"></div>
                    <div field="mtAdvisor" name="mtAdvisor" width="50" headerAlign="center" header="服务顾问"></div>
                    <div field="mtAdvisorId" name="mtAdvisorId" width="50" headerAlign="center" header="服务顾问"></div>
                    <div field="partAmt" name="partAmt" width="40" headerAlign="center" header="结算金额"></div>
                    <div field="isSettle" name="isSettle" width="50" headerAlign="center" header="结算状态"></div>
                    <div field="remark" name="remark" width="100" headerAlign="center" header="备注"></div>
                </div>
            </div>
            <div id="editFormDetail" style="display:none;padding:5px;position:relative;">
                <div id="innerPartGrid" dataField="data" class="nui-datagrid" style="width: 100%; height: 100px;" showPager="false" allowSortColumn="true">
                    <div property="columns">
                        <div headerAlign="center" type="indexcolumn" width="20">序号</div>
                        <div field="partName" headerAlign="center" allowSort="false" visible="true" width="100" header="配件名称"></div>
                        <div field="partCode" headerAlign="center" allowSort="false" width="80px" header="配件编码" align="center"></div>
                        <!--            <div field="serviceTypeId" headerAlign="center" allowSort="false" visible="true" width="60" header="业务类型" align="center"> </div> -->
                        <div field="qty" headerAlign="center" allowSort="false" visible="true" width="60" datatype="int" align="center" header="退货数量"
                            name="partQty"> </div>
                        <div field="unitPrice" headerAlign="center" allowSort="false" visible="true" width="60" datatype="float" align="center" header="单价"
                            name="partUnitPrice"> </div>
                        <div field="amt" headerAlign="center" allowSort="false" visible="true" width="70" datatype="float" align="center" header="金额">
                        </div>
                        <div field="saleMan" headerAlign="center" allowSort="false" visible="true" width="50" header="销售员" align="center" name="saleMan"></div>
                        <div field="saleManId" headerAlign="center" allowSort="false" visible="false" width="80" header="销售员" align="center"></div>
                    </div>
                </div>
            </div>
        </div>
    </div>
        <style>
            .box {}

            .drag-box {
                width: 300px;
                height: 100px;
                background: #369;
                position: absolute;
                left: 0;
                top: 0;
                z-index: 999;
            }
        </style>
        <script type="text/javascript">
            nui.parse();
            var hisUrl = apiPath + crmApi + "/com.hsapi.crm.svr.visit.queryCrmVisitRecordSql.biz.ext";
            var delUrl = apiPath + crmApi + "/com.hsapi.crm.svr.visit.delectVisitRecordById.biz.ext";
            var visitHis = null; //回访历史
            var serviceTypeList = [{}, { id: 1, text: '电销' }, { id: 2, text: '预约' }, { id: 3, text: '客户回访' }, { id: 4, text: '流失回访' }, { id: 5, text: '保养提醒' }, { id: 6, text: '商业险到期' }, { id: 7, text: '交强险到期' }, { id: 8, text: '驾照年审' }, { id: 9, text: '车辆年检' }, { id: 10, text: '生日' }, { id: 11, text: '其他' }];
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
                } else if (e.field == "visitMode") {//跟踪方式
                    e.cellHtml = setColVal('visitMode', 'customid', 'name', e.value);
                } else if (e.field == 'recordId' && e.record.visitMode == '011401') {
                    e.cellHtml = '  <a class="nui-button" onclick="playVoice()" plain="true" style="cursor:pointer"><span class="fa fa-volume-up fa-lg"></span>&nbsp;播放通话语音</a>'
                    //e.cellHtml = '<a class="nui-button"  click="playVoice">播放通话语音</a>'
                }
            });
            visitHis.on("rowdblclick", function (e) {

            });

            function playVoice() {
                var row = visitHis.getSelected();
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
                visitHis.load({ params: params, token: token });
            }



            function edit() {
                var row = visitHis.getSelected();
                nui.open({
                    url: webPath + contextPath + '/manage/maintainRemind/visitHistoryListDet.jsp?token=' + token,
                    title: '修改', width: 600, height: 300,
                    onload: function () {
                        var iframe = this.getIFrameEl();
                        iframe.contentWindow.setData(row);
                    },
                    ondestroy: function (action) {
                        visitHis.reload();
                    }
                });
            }

            function onRemove() {
                var row = visitHis.getSelected();
                if (row) {
                    nui.confirm("确定删除记录？", "确定？",
                        function (action) {
                            if (action == "ok") {
                                nui.ajax({
                                    url: delUrl,
                                    type: "post",
                                    data: { visitRecord: row },
                                    success: function (res) {
                                        if (res.errCode == 'S') {
                                            showMsg("删除成功", "S");
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
            var baseUrl = apiPath + repairApi + "/";
            var mainGrid1 = null;
            mainGrid1 = nui.get("mainGrid1");
            mainGrid1.setUrl(baseUrl + "com.hsapi.repair.repairService.query.querySettleList.biz.ext");
            function activechangedmain() {
                var tabs = nui.get("mainTabs").getActiveTab();
                var row = visitHis.getSelected();
                if (tabs.name == "serviceRecord") {
                    //服务记录
                    var pa1 = {
                        carNo: row.carNo,
                        token: token
                    };
                    mainGrid1.load({ params: pa1 });
                } else if (tabs.name == "returnMain") {
                    mainGrid.setUrl(mainGridUrl);
                    var pa1 = {
                        carNo: row.carNo,
                        billTypeId: 5,
                        token: token
                    };
                    mainGrid.load({ params: pa1 });
                } else if (tabs.name == "sales") {
                    // 销售机会根据客户id查询
                    if (onSearchParams.guestId) {
                        var p = {
                            guestId: onSearchParams.guestId
                        };
                        carSellPointGrid.load({
                            params: p,
                            token: token
                        });
                    }
                } else if (tabs.name == "visit") {
                    // 回访记录根据联系人id查询
                    if (onSearchParams.contactorId || onSearchParams.carId) {
                        var p = {
                            guestSource: 0
                        };
                        if (onSearchParams.carId) {
                            p.carId = onSearchParams.carId;
                        } else if (onSearchParams.contactorId) {
                            p.guestId = onSearchParams.contactorId;
                        }
                        loadVisitHis(p);
                    }
                }
            }
            var editFormDetail = null;
            editFormDetail = document.getElementById("editFormDetail");
            var mainGrid = null;
            var mainGridUrl = baseUrl + "com.hsapi.repair.repairService.svr.qyeryMaintainList.biz.ext";
            mainGrid = nui.get("mainGrid");
            function onShowRowDetail(e) {
                var row = e.record;

                //将editForm元素，加入行详细单元格内
                var td = mainGrid.getRowDetailCellEl(row);
                td.appendChild(editFormDetail);
                editFormDetail.style.display = "";

                innerPartGrid.setData([]);

                var serviceId = row.id;
                innerPartGrid.load({
                    serviceId: serviceId,
                    token: token
                });
            }
            mainGrid.on("drawcell", function (e) {
                var record = e.record;
                if (e.field == "status") {
                    e.cellHtml = statusHash[e.value];
                } else if (e.field == "isSettle") {
                    if (e.value == 1) {
                        e.cellHtml = "已结算";
                    } else {
                        e.cellHtml = "未结算";
                    }
                } else if (e.field == "contactMobile") {
                    var value = e.value
                    value = "" + value;
                    var reg = /(\d{3})\d{4}(\d{4})/;
                    var value = value.replace(reg, "$1****$2");
                    //e.cellHtml = value;
                    if (e.value) {
                        if (record.openId) {
                            e.cellHtml = "<span id='wechatTag' class='fa fa-wechat fa-lg'></span>" + value;
                        } else {
                            e.cellHtml = "<span  id='wechatTag1' class='fa fa-wechat fa-lg'></span>" + value;
                        }
                    } else {
                        e.cellHtml = "";
                    }
                } else if (e.field == "serviceCode") {
                    e.cellHtml = '<a href="##" onclick="editSell(' + e.record._uid + ')">' + e.record.serviceCode + '</a>';
                } else if (e.field == "carNo") {
                    e.cellHtml = '<a href="##" onclick="showCarInfo(' + e.record._uid + ')">' + e.record.carNo + '</a>';
                }
            });
            var statusHash = {
                "0": "草稿",
                "1": "待归库",
                "2": "已归库",
                "3": "待结算",
                "4": "已结算",
                "5": "全部"

            };
        </script>