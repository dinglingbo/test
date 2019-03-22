<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false" %>
	<%@include file="/common/common.jsp"%>
<%@include file="/common/commonRepair.jsp"%>
    <!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
        <html>
        <!-- 
  - Author(s): localhost
  - Date: 2018-09-05 10:29:58
  - Description:
-->

        <head>
            <title>车辆详情</title>
            <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
            <script src="<%= request.getContextPath() %>/repair/RepairBusiness/Reception/js/carDetails.js?v=1.1.13" type="text/javascript"></script>
        </head>
        <style type="text/css">
            body {
                margin: 0;
                padding: 0;
                border: 0;
                width: 100%;
                height: 100%;
                overflow: hidden;
            }

            fieldset {
                margin: 0 auto;
                float: none;
            }
        </style>

        <body>
            <div class="nui-fit">
                <input class="nui-hidden" id="carId" name="carId" />
                <input class="nui-hidden" id="guestId" name="guestId" />
                <div id="editForm1" style="width:100%;height:100%;">
                    <div id="mainTabs" class="nui-tabs" name="mainTabs" activeIndex="0" style="width:100%; height:100%;" plain="false" onactivechanged="">
                        <div title="客户信息" id="main" name="main">
					<fieldset style="width:90%;border:solid 1px #aaa;margin-top:8px;position:relative;height:40%;">
                         <legend>客户信息</legend>
                             <div id="editForm4" style="padding:5px;">
                                <table class="nui-form-table" style="width:99%">
                                    <tr>
                                        <td class="form_label required" align="right">
                                            <label>客户名称：</label>
                                        </td>
                                        <td>
                                            <input class="nui-hidden" name="id" id="guestId" />
                                            <input class="nui-textbox" id="fullName" name="fullName" width="100%" onvaluechanged="onChanged(this.id)" />
                                        </td>
                                        <td class="form_label required" align="right">
                                            <label>手机号码：</label>
                                        </td>
                                        <td>
                                            <input class="nui-textbox" id="mobile" name="mobile" width="100%" onvaluechanged="onChanged(this.id)" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="form_label" align="right">
                                            <label>性别：</label>
                                        </td>
                                        <td>
                                            <input class="nui-combobox" data="[{value:'0',text:'男',},{value:'1',text:'女'},]" textField="text" valueField="value" name="sex"
                                                value="0" width="100%" />
                                        </td>
                                        <td class="form_label " align="right">
                                            <label>客户简称：</label>
                                        </td>
                                        <td>
                                            <input class="nui-textbox" id="shortName" name="shortName"  width="100%" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="form_label" align="right">
                                            <label>生日类型：</label>
                                        </td>
                                        <td>
                                            <input class="nui-combobox" data="[{value:'0',text:'农历',},{value:'1',text:'阳历'},]" textField="text" valueField="value" name="birthdayType"
                                                value="0" width="100%" />
                                        </td>
                                        <td class="form_label " align="right">
                                            <label>生日日期：</label>
                                        </td>
                                        <td>
                                            <input name="birthday" allowInput="false" class="nui-datepicker" width="100%" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="form_label" align="right">
                                            <label>备注：</label>
                                        </td>
                                        <td colspan="3">
                                            <input class="nui-textbox" name="remark" width="100%" />
                                        </td>
                                    </tr>
                                </table>
                          </div>
            </fieldset>
                            <fieldset style="width:90%;border:solid 1px #aaa;margin-top:8px;position:relative;">
                                <legend>车辆信息</legend>
                                <div id="editForm" style="padding:5px;">

                                    <table style="width:100%;" border="0" cellspacing="0" cellpadding="2px">
                                        <tr>
                                            <td style="width:80px;" align="right">车牌号：</td>
                                            <td style="width:150px;">
                                                <input class="nui-textbox" id="carNo" name="carNo" width="100%" allowInput="false" />
                                            </td>
                                            <td style="width:80px;" align="right">车架号(VIN)：</td>
                                            <td style="width:150px;">
                                                <input class="nui-textbox" id="vin" name="vin" width="100%" allowInput="false" />
                                            </td>
                                        </tr>
                                        <tr>

                                            <td style="width:80px;" align="right">品牌车型：</td>
                                            <td style="width:150px;">
                                                <input class="nui-textbox" id="carModel" name="carModel" width="100%" allowInput="false" />
                                            </td>
                                            <td style="width:80px;" align="right">发动机号：</td>
                                            <td style="width:150px;">
                                                <input class="nui-textbox" id="engineNo" name="engineNo" width="100%" allowInput="false" />
                                            </td>
                                        </tr>
                                        <!--                     <tr>
                        <td style="width:80px;"align="right">车辆颜色：</td>
                        <td style="width:150px;">
                            <input class="nui-textbox" id="color" name="color" width="100%" allowInput="false"/>
                        </td>
                        <td></td>
                        <td></td>
                    </tr> -->
                                        <tr>
                                            <td style="width:80px;" align="right">注册时间：</td>
                                            <td style="width:150px;">
                                                <input class="nui-datepicker" id="firstRegDate" name="firstRegDate" width="100%" allowInput="false" id="firstRegDate" />
                                            </td>
                                            <td style="width:80px;" align="right">年审到期：</td>
                                            <td style="width:150px;">
                                                <input class="nui-datepicker" id="annualVerificationDueDate" name="annualVerificationDueDate" width="100%" allowInput="false"
                                                />
                                            </td>
                                        </tr>
                                    </table>
                                </div>
                            </fieldset>

                            <fieldset style="width:90%;border:solid 1px #aaa;margin-top:8px;position:relative;height:20%;">
                                <legend>保养</legend>
                                <div id="editForm2" style="padding:5px;">

                                    <table style="width:100%;" border="0" cellspacing="0" cellpadding="2px">
                                        <tr>
                                            <td style="width:100px;" align="right">当前里程：</td>
                                            <td style="width:120px;">
                                                <input class="nui-textbox" name="lastComeKilometers" width="100%" allowInput="false" />
                                            </td>
                                            <td style="width:120px;" align="right">下次保养里程：</td>
                                            <td style="width:120px;">
                                                <input class="nui-textbox" name="careDueMileage" width="100%" allowInput="false" />
                                            </td>
                                            <td style="width:100px;" align="right">下次保养时间：</td>
                                            <td style="width:120px;">
                                                <input class="nui-datepicker" name="careDueDate" width="100%" allowInput="false" />
                                            </td>
                                        </tr>
                                    </table>
                                </div>
                            </fieldset>
                            <fieldset style="width:90%;border:solid 1px #aaa;margin-top:8px;position:relative;height:25%;">
                                <legend>保险</legend>
                                <div id="editForm3" style="padding:5px;">

                                    <table style="width:100%;" border="0" cellspacing="0" cellpadding="2px">
                                        <tr>
                                            <td style="width:80px;" align="right">交强险到期时间：</td>
                                            <td style="width:150px;">
                                                <input class="nui-datepicker" name="insureDueDate" width="100%" allowInput="false" />
                                            </td>
                                            <td style="width:80px;" align="right">商业险到期时间：</td>
                                            <td style="width:150px;">
                                                <input class="nui-datepicker" name="annualInspectionDate" width="100%" allowInput="false" />
                                            </td>
                                        </tr>

                                        <tr>
                                            <td style="width:80px;" align="right">交强险保单号：</td>
                                            <td style="width:150px;">
                                                <input class="nui-textbox" name="insureNo" width="100%" allowInput="false" />
                                            </td>
                                            <td style="width:80px;" align="right">商业险保单号：</td>
                                            <td style="width:150px;">
                                                <input class="nui-textbox" name="annualInspectionNo" width="100%" allowInput="false" />
                                            </td>
                                        </tr>
                                    </table>
                                </div>
                            </fieldset>
                <fieldset style="width:90%;border:solid 1px #aaa;margin-top:8px;position:relative;height:25%;">
                         <legend>联系人信息</legend>
                             <div id="editForm5" style="padding:5px;">
                                <table class="nui-form-table" style="width:99%">
                                    <tr>
                                        <td class="form_label required" align="right">
                                            <label>联系人名称：</label>
                                        </td>
                                        <td>
                                            <input class="nui-hidden" name="id" id="guestId" />
                                            <input class="nui-textbox" id="name" name="name" width="100%" onvaluechanged="onChanged(this.id)" />
                                        </td>
                                        <td class="form_label required" align="right">
                                            <label>手机号码：</label>
                                        </td>
                                        <td>
                                            <input class="nui-textbox" id="mobile" name="mobile" width="100%" onvaluechanged="onChanged(this.id)" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="form_label" align="right">
                                            <label>性别：</label>
                                        </td>
                                        <td>
                                            <input class="nui-combobox" data="[{value:'0',text:'男',},{value:'1',text:'女'},]" textField="text" valueField="value" name="sex"
                                                value="0" width="100%" />
                                        </td>
                                        <td class="form_label " align="right">
                                            <label>身份：</label>
                                        </td>
                                        <td>
                                            <input class="nui-combobox" name="identity" id="identity" valueField="customid" textField="name" width="100%" value="060301" />
                                        </td>
                                    </tr>
                                    
                                </table>
                          </div>
                      </fieldset>
                   </div>


                        <div title="计次卡" id="main" name="main">
                            <div id="grid1" class="nui-datagrid" style="width:100%;height:100%;" selectOnLoad="true" totalField="page.count" dataField="data"
                                onrowdblclick="" allowCellSelect="true" url="">
                                <div property="columns">
                                    <div field="prdtName" name="prdtName" width="100" headerAlign="center" header="产品名称"></div>
                                    <div field="prdtType" name="prdtType" width="50" headerAlign="center" header="产品类别"></div>
                                    <div field="totalTimes" name="totalTimes" width="50" headerAlign="center" header="总次数"></div>
                                    <div field="canUseTimes" name="canUseTimes" width="50" headerAlign="center" header="可使用次数"></div>
                                    <div field="doTimes" name="doTimes" width="50" headerAlign="center" header="使用中次数"></div>
                                    <div field="balaTimes" name="balaTimes" width="50" headerAlign="center" header="剩余次数"></div>
                                </div>
                            </div>
                        </div>
                        <div title="储值卡" id="main" name="main">
							
                            <div id="grid2" class="nui-datagrid" style="width:100%;height:100%;" selectOnLoad="true" showPager="true" totalField="page.count"
                                dataField="data" onrowdblclick="" allowCellSelect="true" url="">
                                <div property="columns">
                                    <div field="cardName" name="cardName" width="100" headerAlign="center" header="卡名称"></div>
                                    <div field="balaAmt" name="balaAmt" width="50" headerAlign="center" header="余额"></div>
                                    <div field="modifyDate" name="modifyDate" width="100" headerAlign="center" header="储值日期" dateFormat="yyyy-MM-dd"></div>
                                </div>
                            </div>
                        </div>
                        <div title="服务记录" id="main" name="main">
                            <div id="mainGrid1" class="nui-datagrid" style="width:100%;height:100%;" selectOnLoad="true" showPager="true" totalField="page.count"
                                dataField="data" onrowdblclick="" allowCellSelect="true" url="">
                                <div property="columns">
                                    <div field="carNo" name="carNo" width="60" headerAlign="center" header="车牌号"></div>
                                    <!--  <div field="guestFullName" name="guestFullName" width="55" headerAlign="center" header="客户姓名"></div>
	                <div field="guestMobile" name="guestMobile" width="80" headerAlign="center" header="客户手机"></div> -->
                                    <div field="contactName" name="contactName" width="70" headerAlign="center" header="联系人姓名"></div>
                                    <div field="contactMobile" name="contactMobile" width="80" headerAlign="center" header="联系人手机"></div>
                                    <div field="enterDate"  width="160px" headerAlign="center" dateFormat="yyyy-MM-dd HH:mm" header="进店日期">
									</div>
                                    <div field="enterKilometers" name="enterKilometers" width="60" headerAlign="center" allowsort="true" header="进厂里程"></div>
                                    <div field="mtAdvisor" name="mtAdvisor" width="70" headerAlign="center" header="服务顾问"></div>
                                    <div field="serviceCode" name="serviceCode" width="150" headerAlign="center" header="工单号"></div>
                                    <div field="outDate" name="outDate" width="110" headerAlign="center" header="结算日期" dateFormat="yyyy-MM-dd HH:mm"></div>
                                    <div field="balaAmt" name="balaAmt" width="50" headerAlign="center" header="金额"></div>
                                </div>
                            </div>
                        </div>
                        
                        <div title="历史维修记录(导入)" id="main" name="main">
                        <div class="nui-splitter" vertical="true" style="width: 100%; height: 100%;" allowResize="true">
					<div size="40%" showCollapseButton="true">
						<div class="nui-fit">

							<div class="nui-fit">
							<div id="datagrid1" dataField="oldMaintain" class="nui-datagrid" showPager="false" onDrawCell="onDrawCell" onselectionchanged="selectionChanged"
							 onrowclick="" allowSortColumn="true" style="width: 100%; height: 100%;" selectOnLoad="false">
								<div property="columns">
									<div type="indexcolumn" width="40px" header="序号"></div>
									<!-- 				<div type="checkcolumn" >选择</div> -->
									<div field="id" headerAlign="center" allowSort="true" visible="false">工单ID</div>
									<div field="serviceCode" headerAlign="center" allowSort="true" width="160px">工单号</div>
<!-- 									<div field="billTypeId" headerAlign="center" allowSort="true" width="60px">
										工单类型</div> -->
									<div field="guestName" headerAlign="center" allowSort="true" width="70px">
										客户姓名</div>
									<div field="mobile" headerAlign="center" allowSort="true" width="100px">
										客户电话</div>
									<div field="carNo" headerAlign="center" allowSort="true" width="80px">
										车牌号</div>
									<div field="enterDate"  width="160px" headerAlign="center" dateFormat="  yyyy-MM-dd HH:mm">
										进店日期</div>
									<div field="distance" headerAlign="center" allowSort="true" width="60px">
										里程数</div>
									<div field="carVin" headerAlign="center" allowSort="true" width="120px">
										车架号（VIN）</div>
									<div field="itemAmt" headerAlign="center" allowSort="true" width="60px">
										工时金额</div>
									<div field="partAmt" headerAlign="center" allowSort="true" width="60px">
										配件金额</div>
									<div field="packageAmt" headerAlign="center" allowSort="true" width="60px">
										套餐金额</div>
									<div field="agiosum" headerAlign="center" allowSort="true" width="60px">
										优惠金额</div>
									<div field="banlansum" headerAlign="center" allowSort="true" width="60px">
										结算金额</div>	
									<div field="outDate"  width="160px" headerAlign="center" dateFormat="  yyyy-MM-dd HH:mm">
										结算日期</div>
									<div field="mtAdvisor" headerAlign="center" allowSort="true" width="60px">
										维修顾问</div>
									<div field="remark" renderer="onstatus" headerAlign="center" allowSort="true" width="120px">备注</div>
<!-- 									<div field="recorder" headerAlign="center" allowSort="true" width="100px">建档人</div>
									<div field="recordDate" name="planFinishDate" width="110px" headerAlign="center" dateFormat="  yyyy-MM-dd HH:mm">
										建档日期</div> -->
								</div>
								</div>
							</div>
						</div>
					</div>
					<div size="60%" showCollapseButton="true">
						<div class="nui-fit">
							<div id="datagrid2" dataField="oldPart" class="nui-datagrid" showPager="false" onDrawCell="onDrawCell" 
							 onrowclick="" allowSortColumn="true" style="height: 50%" allowRowSelect="false">
								<div property="columns">
									<div type="indexcolumn" width="40px" header="序号"></div>
									<!-- 				<div type="checkcolumn" >选择</div> -->
									<div field="id" headerAlign="center" allowSort="true" visible="false">ID</div>


									<div field="partName" headerAlign="center" allowSort="true" width="90px">
										配件名称</div>
									<div field="partBrandId" headerAlign="center" allowSort="true" width="80px">
										配件品牌</div>
									<div field="unitPrice" headerAlign="center" allowSort="true" width="60px">
										单价</div>
									<div field="qty" headerAlign="center" allowSort="true" width="100px">
										数量</div>
									<div field="unit" headerAlign="center" allowSort="true" width="60px">
										单位</div>
<!-- 									<div field="amt" headerAlign="center" allowSort="true" width="60px">
										金额</div> -->
									<div field="subtotal" headerAlign="center" allowSort="true" width="60px">
										小计</div>
									<div field="saleMan" headerAlign="center" allowSort="true" width="60px">
										销售员</div>
<!-- 									<div field="recorder" headerAlign="center" allowSort="true" width="60px">建档人</div>
									<div field="recordDate" name="planFinishDate" width="110px" headerAlign="center" dateFormat="  yyyy-MM-dd HH:mm">
										建档日期</div> -->
								</div>
							</div>
							<div id="datagrid3" dataField="oldItem" class="nui-datagrid" showPager="false" onDrawCell="onDrawCell" 
							 onrowclick="" allowSortColumn="true" style="height: 50%" allowRowSelect="false">
								<div property="columns">
									<div type="indexcolumn" width="40px" header="序号"></div>
									<!-- 				<div type="checkcolumn" >选择</div> -->
									<div field="id" headerAlign="center" allowSort="true" visible="false">ID</div>


									<div field="itemName" headerAlign="center" allowSort="true" width="80px">
										项目名称</div>
<!-- 									<div field="itemTime" headerAlign="center" allowSort="true" width="60px">
										项目时间</div> -->
									<div field="unitPrice" headerAlign="center" allowSort="true" width="60px">
										项目单价</div>
<!-- 									<div field="amt" headerAlign="center" allowSort="true" width="60px">
										项目金额</div> -->
<!-- 									<div field="rate" headerAlign="center" allowSort="true" width="60px">
										优惠率</div>
									<div field="discountAmt" headerAlign="center" allowSort="true" width="60px">
										优惠金额</div> -->
<!-- 									<div field="partAmt" headerAlign="center" allowSort="true" width="60px">
										配件金额</div> -->
									<div field="subtotal" headerAlign="center" allowSort="true" width="60px">
										项目小计</div>
									<div field="workers" headerAlign="center" allowSort="true" width="60px">
										维修人</div>
									<div field="beginDate" name="planFinishDate" width="110px" headerAlign="center" dateFormat="  yyyy-MM-dd HH:mm">
										开始时间</div>
									<div field="finishDate" name="planFinishDate" width="110px" headerAlign="center" dateFormat="  yyyy-MM-dd HH:mm">
										完工时间</div>
									<div field="saleMan" renderer="onstatus" headerAlign="center" allowSort="true" width="60px">销售员</div>
								</div>
							</div>
						</div>
					</div>

				</div>
                        </div>
                    </div>
                </div>
            </div>
            <script type="text/javascript">
                nui.parse();
            </script>
        </body>

        </html>