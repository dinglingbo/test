<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8" session="false" %>

    <!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
    <html>
    <!--
  - Author(s): Administrator
  - Date: 2018-03-21 09:13:58
  - Description:
-->
 
    <head>
        <title>表单列表 详细
        </title>
        <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
        <script src="<%= request.getContextPath() %>/common/nui/nui.js" type="text/javascript"></script>
        <script src="<%= request.getContextPath() %>/bdb/js/constDef.js?v=1.0" type="text/javascript"></script>
        <%@include file="/common/common.jsp"%>
            <link href="<%=request.getContextPath()%>/common/nui/themes/blue2010/skin.css" rel="stylesheet" type="text/css" />
            <style type="text/css">
                body {
                    margin: 0;
                    padding: 0;
                    border: 0;
                    width: 100%;
                    height: 100%;
                    overflow: hidden;
                    font-family: "微软雅黑";
                }

                .red {
                    /* color: red; */
                }

                .right {
                    text-align: right;
                }

                .fwidtha {
                    width: 120px;
                }

                .fwidthb {
                    width: 120px;
                }

                .bt_trWidth {
                    width: 180px;
                }

                .textboxWidth {
                    width: 100%;
                }

                .htr {
                    height: 30px;
                }


                body .mini-grid-row-hover {
                    background: #BADDFF;
                }

                html body .mini-grid-row-selected {

                    background: #c7ebff;
                }


                .vpanel {
                    border: 1px solid #d9dee9;
                    margin: 10px 0px 0px 0px;
                    width: 39%;
                    height: 248px;
                    float: left;
                }

                .vpanel_heading {
                    border-bottom: 1px solid #d9dee9;
                    width: 100%;
                    height: 26px;
                    line-height: 26px;
                }

                .vpanel_heading span {
                    margin: 0 0 0 20px;
                    font-size: 14px;
                    font-weight: bold;
                }

                .vpanel_bodyww {
                    padding: 10 10 10 10px !important
                }


                .bottomTbText {
                    text-align: right;
                }

                .bottomTbCon {
                    padding: 0px 0px 0px 10px;
                    width: 150px;
                    font-size: 14px;
                    color: #09d95f;
                }
            </style>
    </head>

<body>
	<div class="nui-toolbar">

		<input class="nui-combobox" id="area" emptytext="选择区域"
			textfield="deptName" valuefield="deptCode" allowinput="true"
			shownullitem="true" nullitemtext="请选择..."
			onvaluechanged="onAreaChange" datafield="complist"
			style="width: 110px; margin-right: 10px;"
			url="com.saas.commons.model.orgcomponent.getAreaName.biz.ext"
			valuefromselect="true"> <input class="nui-combobox"
			id="compName" emptytext="选择分店" textfield="shortName"
			valuefield="compID" allowinput="true" shownullitem="true"
			nullitemtext="请选择..." onvaluechanged="onStoreChange"
			datafield="complist" style="width: 110px; margin-right: 10px;"
			url="com.saas.commons.model.orgcomponent.getUserCompGover.biz.ext"
			valuefromselect="true"> <input class="nui-combobox"
			id="status" emptytext="选择保单状态" data="statusData" valuefield="id"
			textfield="text" width="125px" style="margin-right: 10px;"
			shownullitem="true" nullitemtext="请选择..." /> <input
			class="nui-textbox" id="carNum" emptytext="请输入车牌号" width="125px"
			style="margin-right: 10px;" /> <input class="nui-textbox" id="name"
			emptytext="请输入客户姓名" width="125px" style="margin-right: 10px;" /> <span
			style="display: inline-block;"> 订单日期 从： <input id="date1"
			class="nui-datepicker" />至 <input id="date2" class="nui-datepicker" />
		</span> <input class="nui-combobox" id="insurItemDef" emptytext="投保险种"
			textfield="customName" valuefield="customId" allowinput="true"
			shownullitem="true" nullitemtext="请选择..." datafield="data"
			url="com.hsapi.bdb.common.getInsuItemDef.biz.ext?params/paramType=insur_item"
			valuefromselect="true" visible="false"> <a class="nui-button"
			onclick="Search()" iconcls="icon-search" plain="false">查询( <u>Q</u>)
		</a>
	</div>

	<div class="nui-fit">
		<div class="nui-splitter" style="width: 100%; height: 100%;">
			<div size="15%" showCollapseButton="true">

				<div class="nui-fit">

					<div id="grid1" class="nui-datagrid gridborder"
						style="width: 100%; height: 100%;"
						url="com.hsapi.bdb.order.getStateOrderList.biz.ext"
						dataField="data" idField="id" sizeList="[20,30,50,100]"
						pageSize="20" totalField="page.count" showPager="true">
						<div property="columns">
							<div field="id" width="60" visible="false" headerAlign="center"
								align="center">订单号</div>
							<div field="licenseNo" width="70" headerAlign="center"
								align="center">车牌号码</div>
							<div field="name" width="70" headerAlign="center" align="center">客户姓名</div>
							<div field="" width="70" visible="false" headerAlign="center"
								align="">报价状态</div>

						</div>
					</div>
				</div>
			</div>
			<div showCollapseButton="true">


				<div class="nui-fit">
					<input id="creatorId" name="creatorId" class="nui-hidden" />
					<div class="" style="width: 100%; height: 370px;" id="form1">


						<div class="vpanel"
							style="width: 99%; height: auto; margin-top: 0px;">
							<div class="vpanel_heading"
								style="background-color: #f3f4f6; color: #2d95ff;">
								<span>客户信息</span>
							</div>
							<div class="vpanel_body vpanel_bodyww">

								<table class="tmargin">

									<tr class="htr">
										<td class="red right fwidtha">客户名称：</td>
										<td class="bt_trWidth"><input id="name" name="name"
											class="nui-textbox textboxWidth" borderStyle="border:0">
										</td>
										<td class="red right fwidtha">客户电话1：</td>
										<td class="bt_trWidth"><input id="mobile" name="mobile"
											class="nui-textbox textboxWidth" borderStyle="border:0">
										</td>
										<td class="red right fwidtha">客户电话2：</td>
										<td class="bt_trWidth"><input id="holderMobile"
											name="holderMobile" class="nui-textbox textboxWidth"
											borderStyle="border:0"></td>
									</tr>

									<tr class="htr">
										<td class="red right fwidtha">客户类别：</td>
										<td class="bt_trWidth"><input class="nui-combobox"
											id="status" emptytext="选择客户类别" data="clientType"
											valuefield="id" textfield="text" width="125px"
											style="margin-right: 10px;" shownullitem="true"
											nullitemtext="请选择..." /></td>
										<td class="red right fwidtha">投保地区：</td>
										<td class="bt_trWidth"><input id="cityCode"
											name="cityCode" class="nui-combobox textboxWidth"
											valuefield="cityCode" textfield="name" borderStyle="border:0">
										</td>
										<td class="red right fwidtha">地址：</td>
										<td class="bt_trWidth"><input id="holderAddress"
											name="holderAddress" class="nui-textbox textboxWidth"
											borderStyle="border:0"></td>
									</tr>


									<tr class="htr">
										<td class="red right fwidtha">客户备注1：</td>
										<td class="bt_trWidth" colspan="3"><input
											id="quoteRemark" name="quoteRemark"
											class="nui-textbox textboxWidth" borderStyle="border:0">
										</td>
									</tr>

									<tr class="htr">
										<td class="red right fwidtha">客户备注2：</td>
										<td class="bt_trWidth" colspan="3"><input id="payRemark"
											name="payRemark" class="nui-textbox textboxWidth"
											borderStyle="border:0"></td>
									</tr>


								</table>


							</div>
						</div>

						<div class="vpanel" style="width: 99%; height: auto;">
							<div class="vpanel_heading"
								style="background-color: #f3f4f6; color: #2d95ff;">
								<span>车辆信息</span>
							</div>
							<div class="vpanel_body vpanel_bodyww">

								<table class="tmargin">

									<tr class="htr">
										<td class="red right fwidtha">车牌号：</td>
										<td class="bt_trWidth"><input id="licenseNo"
											name="licenseNo" class="nui-textbox textboxWidth"
											borderStyle="border:0"></td>
										<td class="red right fwidtha">发动机号：</td>
										<td class="bt_trWidth"><input id="engineNo"
											name="engineNo" class="nui-textbox textboxWidth"
											borderStyle="border:0"></td>
										<td class="red right fwidtha">车架号：</td>
										<td class="bt_trWidth"><input id="carVin" name="carVin"
											class="nui-textbox textboxWidth" borderStyle="border:0">
										</td>
									</tr>

									<tr class="htr">
										<td class="red right fwidtha">注册日期：</td>
										<td class="bt_trWidth"><input id="registerDate"
											name="registerDate" format="yyyy-MM-dd"
											class="nui-datepicker textboxWidth" borderStyle="border:0">
										</td>
										<td class="red right fwidtha">品牌型号：</td>
										<td class="bt_trWidth"><input id="modelName"
											name="modelName" class="nui-textbox textboxWidth"
											borderStyle="border:0"></td>
										<td class="red right fwidtha">车型：</td>
										<td class="bt_trWidth"><input id="modelName2"
											name="modelName" class="nui-textbox textboxWidth"
											borderStyle="border:0"></td>
									</tr>
									<tr class="htr">
										<td class="red right fwidtha">新车购置价（￥）：</td>
										<td class="bt_trWidth"><input id="purchasePrice"
											name="purchasePrice" class="nui-textbox textboxWidth"
											borderStyle="border:0"></td>
										<td class="red right fwidtha">座位数：</td>
										<td class="bt_trWidth"><input id="seatCount"
											name="seatCount" class="nui-textbox textboxWidth"
											borderStyle="border:0"></td>
										<td class="red right fwidtha">排量（L）：</td>
										<td class="bt_trWidth"><input id="exhaustScale"
											name="exhaustScale" class="nui-textbox textboxWidth"
											borderStyle="border:0"></td>
									</tr>

									<tr class="htr">

									</tr>


									<!--
                          <tr class="htr">
                              <td class="red right fwidtha">过户车：</td>
                              <td class="bt_trWidth">
                                 <label><input name="Fruit1" type="radio" value="" />是</label>
                                 <label><input name="Fruit1" type="radio" value="" />否</label>
                             </td>
                             <td class="red right fwidtha">贷款车：</td>
                             <td class="bt_trWidth">
                                 <label><input name="Fruit" type="radio" value="" />是</label>
                                 <label><input name="Fruit" type="radio" value="" />否</label>
                             </td>            
                         </tr>
                            -->

									<tr class="htr">
										<td class="red right fwidtha">备注：</td>
										<td class="bt_trWidth" colspan="5"><input
											id="quoteRemark" name="quoteRemark"
											class="nui-textbox textboxWidth" borderStyle="border:0">
										</td>
									</tr>


								</table>


							</div>
						</div>

					</div>

					<div class="nui-fit" id="form2">
						<div id="tabs" name="tabs" class="nui-tabs" activeIndex="0"
							style="width: 100%; height: 100%;"
							bodyStyle="padding:0;border:0;">
							<div title="投保报价信息" name="tab1">
								<div class="vpanel"
									style="width: 99%; height: auto; margin-top: 0px;">
									<div class="vpanel_heading"
										style="background-color: #f3f4f6; color: #2d95ff;">
										<span>投保信息</span>
									</div>
									<div class="vpanel_body vpanel_bodyww">

										<table class="tmargin">

											<tr class="htr">
												<td class="red right fwidtha">投保公司：</td>
												<td class="bt_trWidth"><input id="insurerId"
													name="insurerId" class="nui-combobox textboxWidth"
													data="insurdata" valuefield="id" textfield="text"
													borderStyle="border:0">
												<td><a class="mini-button" onclick="changeCP()"
													id="changeInsurComp">切换保险公司</a></td>
											</tr>

											<tr class="htr">
												<td class="red right fwidtha">商业险到期时间：</td>
												<td class="bt_trWidth"><input id="lastBizExpireDate"
													name="lastBizExpireDate" format="yyyy-MM-dd"
													class="nui-datepicker textboxWidth" borderStyle="border:0">
												</td>
												<td class="red right fwidtha">交强险到期时间：</td>
												<td class="bt_trWidth"><input id="lastForceExpireDate"
													name="lastForceExpireDate" format="yyyy-MM-dd"
													class="nui-datepicker textboxWidth" borderStyle="border:0">
												</td>
											</tr>
											<tr class="htr">
												<td class="red right fwidtha">商业险总额:</td>
												<td class="bt_trWidth"><input id="bizTotal"
													name="bizTotal" class="nui-textbox textboxWidth"
													borderStyle="border:0"></td>
												<td class="red right fwidtha">交强险总额：</td>
												<td class="bt_trWidth"><input id="forceTotal"
													name="forceTotal" class="nui-textbox textboxWidth"
													borderStyle="border:0"></td>
												<td class="red right fwidtha">车船税总额：</td>
												<td class="bt_trWidth"><input id="taxTotal"
													name="taxTotal" class="nui-textbox textboxWidth"
													borderStyle="border:0"></td>
												<!-- <td class="red right fwidtha">总金额：</td>
												<td class="bt_trWidth"><input
													class="nui-textbox textboxWidth" borderStyle="border:0">
												</td> -->
											</tr>

											<!--
                    <tr class="htr">
                        <td class="red right fwidtha">被保险人：</td>
                        <td class="bt_trWidth"><input id="" name="" class="nui-textbox textboxWidth" borderStyle="border:0" ></td>
                        <td class="red right fwidtha">证件号码：</td>
                        <td class="bt_trWidth"><input id="" name="" class="nui-textbox textboxWidth" borderStyle="border:0" ></td>
                        <td class="red right fwidtha">证件类型：</td>
                        <td class="bt_trWidth"><input id="" name="" class="nui-textbox textboxWidth" borderStyle="border:0" ></td>
                    </tr>

                    <tr class="htr">
                        <td class="red right fwidtha">商业险保单号：</td>
                        <td class="bt_trWidth"><input id="" name="" class="nui-textbox textboxWidth" borderStyle="border:0" ></td>
                        <td class="red right fwidtha">交强险保单号：</td>
                        <td class="bt_trWidth"><input id="" name="" class="nui-textbox textboxWidth" borderStyle="border:0" ></td>
                    </tr>
                    -->

										</table>

									</div>
								</div>

								<!--
            <div class="vpanel" style="width:99%;height:150px;">
                <div class="vpanel_heading" style="background-color:#f3f4f6;color:#2d95ff;"><span>其他险种</span></div>
                <div class="vpanel_body vpanel_bodyww">


                    </div> 
            </div> 
            -->

							</div>

							<div title="险种信息" name="tab2">
								<div class="vpanel"
									style="width: 99%; height: auto; margin-top: 0px;">
									<div class="vpanel_body vpanel_bodyww">
										 <div class="nui-fit">
                                                <div id="insurItems" class="nui-datagrid" style="width: 100%; height:100%;" url="com.hsapi.bdb.background.getRenewInsurList.biz.ext" dataField="data" idField="id"
                                                    showPager="false" allowCellEdit="true" allowResize="true" allowCellSelect="true" multiSelect="true" editNextOnEnterKey="true"  editNextRowCell="true">
                                                    <div property="columns">
										 				<div field="field" width="70" headerAlign="center" align="center" >险种名称</div>
                                                        <div field="amount" width="70" headerAlign="center" align="center" >投保金额
														<!--  取消注释后，可对该字段下的表格进行操作<input property="editor"  class="mini-combobox" style="width:100%;" data="insurMoney5_500" textField="text" valueField="id" />  --> 
                                                       </div>
                                                        <div type="checkboxcolumn" field="buJiMian" width="70" visible="true" headerAlign="center" align="center">不计免赔</div>
                                                      
									
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
				<!--
    <div title="报价信息" name="tab2"  >
        <div class="vpanel" style="width:99%;height:auto;margin-top: 0px;">
            <div class="vpanel_heading" style="background-color:#f3f4f6;color:#2d95ff;"><span>车主信息</span></div>
            <div class="vpanel_body vpanel_bodyww">

               <table class="tmargin">


                <tr class="htr">
                    <td class="red right fwidtha">车主姓名：</td>
                    <td class="bt_trWidth"><input id="" name="" class="nui-textbox textboxWidth" borderStyle="border:0" ></td>
                    <td class="red right fwidtha">证件号码：</td>
                    <td class="bt_trWidth"><input id="" name="" class="nui-textbox textboxWidth" borderStyle="border:0" ></td>
                    <td class="red right fwidtha">证件类型：</td>
                    <td class="bt_trWidth"><input id="" name="" class="nui-textbox textboxWidth" borderStyle="border:0" ></td>
                </tr>

                <tr class="htr">
                    <td class="red right fwidtha">被保险人：</td>
                    <td class="bt_trWidth"><input id="" name="" class="nui-textbox textboxWidth" borderStyle="border:0" ></td>
                    <td class="red right fwidtha">证件号码：</td>
                    <td class="bt_trWidth"><input id="" name="" class="nui-textbox textboxWidth" borderStyle="border:0" ></td>
                    <td class="red right fwidtha">证件类型：</td>
                    <td class="bt_trWidth"><input id="" name="" class="nui-textbox textboxWidth" borderStyle="border:0" ></td>
                </tr>
            </table>

            </div> 
        </div> 

        <div class="vpanel" style="width:99%;height:auto;">
            <div class="vpanel_heading" style="background-color:#f3f4f6;color:#2d95ff;"><span>被保险人信息</span></div>
            <div class="vpanel_body vpanel_bodyww">

               <table class="tmargin">

                <tr class="htr">
                    <td class="red right fwidtha">被保险人姓名：</td>
                    <td class="bt_trWidth"><input id="" name="" class="nui-textbox textboxWidth" borderStyle="border:0" ></td>
                    <td class="red right fwidtha">证件号码：</td>
                    <td class="bt_trWidth"><input id="" name="" class="nui-textbox textboxWidth" borderStyle="border:0" ></td>
                    <td class="red right fwidtha">证件类型：</td>
                    <td class="bt_trWidth"><input id="" name="" class="nui-textbox textboxWidth" borderStyle="border:0" ></td>
                </tr>

                <tr class="htr">
                    <td class="red right fwidtha">被保险人电话：</td>
                    <td class="bt_trWidth"><input id="" name="" class="nui-textbox textboxWidth" borderStyle="border:0" ></td>
                    <td class="red right fwidtha">被保险人邮箱：</td>
                    <td class="bt_trWidth"><input id="" name="" class="nui-textbox textboxWidth" borderStyle="border:0" ></td>
                    <td class="red right fwidtha">住址：</td>
                    <td class="bt_trWidth"><input id="" name="" class="nui-textbox textboxWidth" borderStyle="border:0" ></td>
                </tr>
            </table>

            </div> 
        </div> 

    <div class="vpanel" style="width:99%;height:auto;">
        <div class="vpanel_heading" style="background-color:#f3f4f6;color:#2d95ff;"><span>投保人信息</span></div>
        <div class="vpanel_body vpanel_bodyww">

           <table class="tmargin">

             <tr class="htr">
                <td class="red right fwidtha">投保人姓名：</td>
                <td class="bt_trWidth"><input id="" name="" class="nui-textbox textboxWidth" borderStyle="border:0" ></td>
                <td class="red right fwidtha">证件号码：</td>
                <td class="bt_trWidth"><input id="" name="" class="nui-textbox textboxWidth" borderStyle="border:0" ></td>
                <td class="red right fwidtha">证件类型：</td>
                <td class="bt_trWidth"><input id="" name="" class="nui-textbox textboxWidth" borderStyle="border:0" ></td>
            </tr>

            <tr class="htr">
                <td class="red right fwidtha">投保人电话：</td>
                <td class="bt_trWidth"><input id="" name="" class="nui-textbox textboxWidth" borderStyle="border:0" ></td>
                <td class="red right fwidtha">投保人邮箱：</td>
                <td class="bt_trWidth"><input id="" name="" class="nui-textbox textboxWidth" borderStyle="border:0" ></td>
                <td class="red right fwidtha">住址：</td>
                <td class="bt_trWidth"><input id="" name="" class="nui-textbox textboxWidth" borderStyle="border:0" ></td>
            </tr>
            </table>

        </div> 
    </div> 

    <div class="vpanel" style="width:99%;height:150px;">
        <div class="vpanel_heading" style="background-color:#f3f4f6;color:#2d95ff;"><span>最新报价信息</span></div>
        <div class="vpanel_body vpanel_bodyww">

           <table class="tmargin">


           </table>
       </div> 
    </div> 


    </div> 


    <div title="跟进信息" name="tab3">

    </div>
    -->
			</div>
		</div>
	</div>
	
	<script type="text/javascript">

            nui.parse();

            var area = nui.get("area"); //区域
            var comp = nui.get("compName"); //店名
            var sta = nui.get("status"); //
            var carNum = nui.get("carNum"); //
            var tname = nui.get("name"); //
            var grid = nui.get("grid1");
            var grid_InsurItem = nui.get("insurItems");
            var form = new nui.Form("#form1");
            var form2 = new nui.Form("#form2");
            var amount='投保 ';
          
            //保险公司
    
     	
            
			 var nub=0;
			 var currRec;
            //var subform = new nui.Form("#subform");
            form.setEnabled(false);
            form2.setEnabled(false);
						
            var firstSelect = null;
            var MainRow = null;
            var nowPager = null;
            var firstload = 0;
        
            
            function changeCP(){
            	if(currRec){
	            	nub++;
	            	if(nub==currRec.insurerQuotes.length){
	            		nub = 0;
	            	}
	            	form2.setData(currRec.insurerQuotes[nub]);
            	}       
            }

            function onAreaChange(e) {
                var url = null;
                var record = e.selected;
                if (record) {
                    var url = "com.saas.commons.model.orgcomponent.getUserCompGover.biz.ext?action=oneArea&compid=" + record.deptCode;
                } else {
                    var url = "com.saas.commons.model.orgcomponent.getUserCompGover.biz.ext";
                }
                comp.load(url);
                nui.get("compName").setValue(null);
            }


            function onStoreChange(e) {
                var record = e.selected;
                if (record) {
                    area.setValue(record.areaID);
                } else {
                    area.setValue(null);
                }

            }

            function onGenderRenderer(e) {
                for (var i = 0, l = Cdata.length; i < l; i++) {
                    var g = Cdata[i];
                    if (g.id == e.value) return g.text;
                }
                return "";
            }

            function Search() {
                var date1 = nui.get("date1").getFormValue(); //
                var date2 = nui.get("date2").getFormValue(); //
                var params = {
                    compCode: comp.value,
                    status: sta.value,
                    insuredName: tname.value,
                    licenseNo: carNum.value,
                    startDate: date1,
                    endDate: date2
                };
                grid.load({ params: params });
            }



            function SetData(data, p, cityData) {
                MainRow = data;
                grid.load(p);
                nui.get("cityCode").setData(cityData);
                //nowPager = p;
            }

            grid.on("load", function (e) {
                if (firstload == 0) {
                    if (MainRow != null) {
                        var row = grid.findRow(function (row) {
                            if (row.id == MainRow.id) return true;
                        });
                        grid.select(row, true);
                        firstload = 1;
                    }
                }
            });


             grid.on("select", function (e) {
                var record = e.record;
                currRec = record;
                form.setData(record);
                nub = 0;
                form2.setData(record.insurerQuotes[nub]);
                if(record.insurerQuotes && record.insurerQuotes.length>1){
                	$("#changeInsurComp").show();
                }else{
               		$("#changeInsurComp").hide();
                }
         
                //subform.setData(record.insurerQuotes[0]);
                grid_InsurItem.setData(record.quoteOrderItem);
                //nui.alert("显示车牌号为"+record.licenseNo+"的信息");
            }); 

            grid_InsurItem.on("drawcell", function (e) {//drawcell
                var record = e.record;
                var column = e.field;
                var value = e.value;
                var insurItemDef = nui.get("insurItemDef").getData();
                if(column == "field"){
                    for(var i=0; i<insurItemDef.length; i++){
                        if(insurItemDef[i].customId == value){
                            e.cellHtml = insurItemDef[i].customName;
                            break;
                        }
                    }
                }
                if (column == "amount") {
                    if (value.toString().length == 4) {
                        if (value == 0 || value == 1 ) {
                            e.cellHtml = "不投保";
                        } else {
                        	e.cellHtml = value+"元 ";         
                        }
                    }else if(value.toString().length == 5){
                        if (value == 0 || value == 1) {
                            e.cellHtml = "不投保";
                        } else {
                            e.cellHtml = value.toString().substr(0,1)+"万 "; 
                        }
                    }else if(value.toString().length == 6){
                     	if (value == 0 || value == 1) {
                            e.cellHtml = "不投保";
                        } else {
                            e.cellHtml = value.toString().substr(0,2)+"万 "; 
                        }
                    }else{
                    	if (value == 0 || value == 1) {
                            e.cellHtml = "不投保";
                        } else {
                            e.cellHtml = value.toString().substr(0,3)+"万 "; 
                        }
                    }
                    	 //玻璃
                     if (record.field =="BoLi" || record.field =="HcXiuLiChang") {
                    if (value == 1) {
                        e.cellHtml = "国产 ";
                    } else {
                        e.cellHtml = "进口 ";
                    }
                } 
                }
                if (column == "buJiMian") {
                    if (value == 1) {
                        e.cellHtml = "√ ";
                    } else {
                        e.cellHtml = "× ";
                    }
                }
            });
       
	</script>
</body>
 
</html>