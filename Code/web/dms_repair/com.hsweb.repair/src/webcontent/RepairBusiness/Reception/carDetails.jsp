<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false" %>
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
            <script src="<%= request.getContextPath() %>/repair/RepairBusiness/Reception/js/carDetails.js?v=1.1.27" type="text/javascript"></script>
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
        a.optbtn {
            width: 44px;
            /* height: 26px; */
            border: 1px #d2d2d2 solid;
            background: #f2f6f9;
            text-align: center;
            display: inline-block;
            /* line-height: 26px; */
            margin: 0 4px;
            color: #000000;
            text-decoration: none;
            border-radius: 5px;
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
                <input class="nui-combobox" name="identity" id="identity" valueField="customid" textField="name" width="100%"  visible="false" />
                 <input name="serviceTypeId"
                id="serviceTypeId" visible="false"
                class="nui-combobox"
                textField="name"
                valueField="id"/>
                <div id="editForm1" style="width:100%;height:100%;">
                    <div id="mainTabs" class="nui-tabs" name="mainTabs" activeIndex="0" style="width:100%; height:100%;" plain="false" onactivechanged="">
                        <div title="客户信息" id="main" name="main">
					<fieldset style="width:90%;border:solid 1px #aaa;margin-top:8px;position:relative;height:25%;">
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
                                  <!--   <tr>
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
                                    </tr> -->
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
                                        
                                        <tr>
							                <td class="form_label" align="right">
							                    <label>备注：</label>
							                </td>
							                <td colspan="3">
							                    <input class="nui-textbox" name="remark" width="80%" />
							                    
							                     <label>是否禁用：</label>
							                     <input type="checkbox" id="isDisabled" class="mini-checkbox"  name="isDisabled"  trueValue="1" falseValue="0" >
							                </td>
							           </tr>
                                        
                                    </table>
                                </div>
                            </fieldset>

                            <fieldset style="width:90%;border:solid 1px #aaa;margin-top:8px;position:relative;height:15%;">
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
                            <fieldset style="width:90%;border:solid 1px #aaa;margin-top:8px;position:relative;height:20%;">
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
                 <fieldset style="width:90%;border:solid 1px #aaa;margin-top:8px;min-height: 25%;">
                         <legend>联系人信息</legend>
                           <div class="nui-fit"> 
                            <div id="contactdatagrid" class="nui-datagrid"  showPager="false" sortMode="client" allowCellEdit="true" onrowdblclick="eaidContact()"
                                allowCellSelect="true" multiSelect="true"  editNextOnEnterKey="true" onDrawCell="onDrawCell" height="100%">
                                <div property="columns">

                                    <div field="id" class="nui-hidden" allowSort="true" align="left" headerAlign="center" width="" visible="false">
                                        联系人ID
                                    </div>
                                    <div field="guestId" class="nui-hidden" allowSort="true" align="left" headerAlign="center" width="" visible="false">
                                        客户ID
                                    </div>
                                    <div field="name" allowSort="true" align="left" summaryType="count" headerAlign="center" width="100">姓名</div>
                                     <div field="remark" allowSort="true" align="left"  headerAlign="center" width="100">备注</div>
                                    <div field="sex" allowSort="true" align="left" headerAlign="center" width="60" dataType="int">
                                        性别
                                    </div>
                                    <div field="mobile" allowSort="true" align="left" headerAlign="center" width="100" dataType="int">
                                        手机
                                    </div>
                                    <div field="identity" allowSort="true" align="left" headerAlign="center" width="70">身份</div>
                                    <div field="wechatServiceId" allowSort="true" align="left" headerAlign="center" width="80">微信服务号</div>                                                                        
                                    <div field="wechatOpenId" allowSort="true" align="left" headerAlign="center" width="160">微信ID</div>
                                </div>
                            </div> 
                        </div>
                                <!-- <table class="nui-form-table" style="width:99%">
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
                                    
                                </table> -->
                      </fieldset>
                   </div>


                        <div title="计次卡" id="main" name="main">
                            <div id="grid1" class="nui-datagrid" style="width:100%;height:100%;" selectOnLoad="true" totalField="page.count" dataField="data"
                                onrowdblclick="" allowCellSelect="true" url="">
                                <div property="columns">
                                    <div field="prdtName" name="prdtName" width="100" headerAlign="center" header="产品名称"></div>
                                    <div field="prdtType" name="prdtType" width="50" headerAlign="center" header="产品类别"></div>
                                    <div field="totalTimes" name="totalTimes" width="50" headerAlign="center" header="总次数"></div>
                                    <div field="useTimes" name="useTimes" width="50" headerAlign="center" header="已使用次数"></div>
                                    <div field="doTimes" name="doTimes" width="50" headerAlign="center" header="使用中次数"></div>
                                    <div field="balaTimes" name="balaTimes" width="50" headerAlign="center" header="剩余次数"></div>
                                </div>
                            </div>
                        </div>
                        <div title="订单项目" id="main" name="main">
                            <div id="grid3" class="nui-datagrid" style="width:100%;height:100%;" selectOnLoad="true" totalField="page.count" dataField="data"
                                onrowdblclick="" allowCellSelect="true" url="">
                                <div property="columns">
	                                  <div field="prdtName" name="prdtName" width="100" headerAlign="center" header="产品名称"></div>
							          <div field="prdtType" name="prdtType" width="60" headerAlign="center" header="产品类别"></div>
							          <div field="totalTimes" name="totalTimes" width="50" headerAlign="center" header="总数量"></div>
							          <div field="useTimes" name="useTimes" width="60" headerAlign="center" header="已使用数量"></div>
							          <div field="doTimes" name="doTimes" width="70" headerAlign="center" header="使用中数量"></div>
							          <div field="canUseTimes" name="canUseTimes" width="70" headerAlign="center" header="可使用数量"></div>
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
                         <div title="优惠券" id="main" name="main">
                            <div id="grid4" class="nui-datagrid" style="width:100%;height:100%;" selectOnLoad="true" showPager="true" totalField="page.count"
                                dataField="data" onrowdblclick="" allowCellSelect="true" url="">
                                <div property="columns">
                                    <div field="cardName" name="cardName" width="100" headerAlign="center" header="名称"></div>
                                    <div field="balaAmt" name="balaAmt" width="50" headerAlign="center" header="优惠金额"></div>
                                    <div field="balaAmt" name="balaAmt" width="50" headerAlign="center" header="使用说明"></div>
                                    <div field="modifyDate" name="modifyDate" width="100" headerAlign="center" header="到期日期" dateFormat="yyyy-MM-dd"></div>
                                    <div field="balaAmt" name="balaAmt" width="50" headerAlign="center" header="优惠券编码"></div>
                                    <div field="balaAmt" name="balaAmt" width="50" headerAlign="center" header="领券人"></div>
                                </div>
                            </div>
                        </div>
                        <div title="服务记录" id="main" name="main">
                        	显示客户所有车辆：<div  class="nui-checkbox" id="isAll" name="isAll" value="0" onclick="onSearch" trueValue="1" falseValue="0"></div>
                            <div id="mainGrid1" class="nui-datagrid" style="width:100%;height:95%;" 
                                  selectOnLoad="true" showPager="true" totalField="page.count"
                                 dataField="data" onrowdblclick="" allowCellSelect="true" url=""
                                onshowrowdetail="onShowRowDetail"
                                >
                                <div property="columns">
                                    <div type="expandcolumn" width="20" ><span class="fa fa-plus fa-lg"></span></div>
                                    <div field="id" name="id" width="60" headerAlign="center"  visible="false" header="工单ID"></div>
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

                        <div title="销售机会" id="sales" name="sales">
                        		<input class="nui-combobox" name="chanceType" id="chanceType" valueField="customid" textField="name"  visible="false" />
                                <a class="nui-button" iconCls="" plain="true" onclick="addSell()" id="auditBtn"><span class="fa fa-plus fa-lg"></span>&nbsp;新增销售机会</a>                   
					           <div id="carSellPointGrid" class="nui-datagrid" style="width:100%;height:95%;"
					               selectOnLoad="true"
					               showPager="true"
					               dataField="list"
					               idField="id"
					               allowCellSelect="true"
					               totalField="page.count"
					               editNextOnEnterKey="true"
					               url="">

					              <div property="columns">
					                  <div field="prdtName" name="prdtName" width="80" headerAlign="center" header="项目"></div>
					                  <div field="prdtAmt" name="amt" width="40" headerAlign="center" header="金额"></div>
					                  <div field="chanceType" name="type" width="60" headerAlign="center" header="机会类型"></div>
					                  <div field="status" name="status" width="50" headerAlign="center" header="阶段"></div>
					                  <div field="chanceMan" name="creator" width="80" headerAlign="center" header="商机所有者"></div>
					                <div field="nextFollowDate" name="nextFollowDate" width="100" dateFormat="yyyy-MM-dd " headeralign="center" >下次跟进时间</div>
					 				<div field="planFinishDate" name="planFinishDate" width="100" dateFormat="yyyy-MM-dd " headeralign="center" >预计成单时间</div>
					 				<div field="recorder" name="recorder" width="80"  headeralign="center" >创建人</div>
					           		<div field="recordDate" name="recordDate" width="100" dateFormat="yyyy-MM-dd " headeralign="center" >创建人日期</div>
					           		<div field="modifier" name="modifier" width="80"  headeralign="center" >修改人</div>
					           		<div field="modifyDate" name="modifyDate" width="100" dateFormat="yyyy-MM-dd " headeralign="center" >修改日期</div>
					                  <div field="cardTimesOpt" name="cardTimesOpt" width="80" headerAlign="center"  header="操作" align="center"></div>
					              </div>
					          </div>
                        </div>
                        <div title="回访记录" id="visit" name="visit">
                                <%@include file="/manage/maintainRemind/visitHistoryList.jsp" %>
                        </div>
                    </div>
                </div>
            </div>
  <div id="editFormDetail" style="display:none;padding:5px;position:relative;">
     <div  id="innerpackGrid" class="nui-datagrid"
	    style="width:100%;height:150px;"
	    dataField="data"
	    showPager="false"
	    showModified="false"
	    allowSortColumn="false" >
      <div property="columns">
    	   <div type="indexcolumn" headerAlign="center" name="index" visible="false">序号</div>
           <div headerAlign="center" field="orderIndex" width="25" align="right" name="num">序号</div>
           <div field="prdtName" headerAlign="center" allowSort="false" visible="true" width="100" header="套餐名称"></div>
           <div field="type" headerAlign="center" allowSort="false" visible="true" width="60" header="项目类型" align="center"></div>    
           <div field="serviceTypeId" headerAlign="center" name="pkgServiceTypeId" allowSort="false" visible="true" width="50" header="业务类型" align="center"> </div>
           <div field="subtotal" headerAlign="center" name="pkgSubtotal" allowSort="false" visible="true" width="60" header="套餐金额" align="center" ></div>
           <div field="rate" headerAlign="center" name="pkgRate" allowSort="false" visible="true" width="60" header="优惠率" align="center"></div>
           <div field="amt" headerAlign="center" name="pkgAmt"  allowSort="false" visible="true" width="60" header="原价" align="center"></div>
           <div field="workers" headerAlign="center"  allowSort="false" visible="true" width="60" header="施工员" align="center" name="workers"></div>
           <div field="workerIds" headerAlign="center" allowSort="false" visible="false" width="80" header="施工员" align="center"></div>  
           <div field="saleMan" headerAlign="center" allowSort="false" visible="true" width="50" header="销售员" align="center" name="saleMan"></div>
           <div field="saleManId" headerAlign="center" allowSort="false" visible="false" width="80" header="销售员" align="center"></div>
     </div>
   </div>
   <div id="innerItemGrid"
       borderStyle="border-bottom:0;"
       class="nui-datagrid"
       dataField="data"
       style="width: 100%;height:150px;"
       showPager="false"
       allowSortColumn="true">
      <div property="columns">
           <div type="indexcolumn" headerAlign="center" name="index" visible="false">序号</div>
           <div headerAlign="center" field="orderIndex" width="25" align="right" name="num">序号</div>
           <div field="prdtName" headerAlign="center" allowSort="false" visible="true" width="100">项目名称</div>
	       <div field="serviceTypeId" headerAlign="center" allowSort="false" visible="true" width="100" align="center">业务类型 </div>
	       <div field="qty" headerAlign="center" allowSort="false" visible="true" width="60" datatype="float" align="center" name="itemItemTime">工时/数量 </div>
	       <div field="unitPrice" name="itemUnitPrice" headerAlign="center" allowSort="false" visible="true" width="60" datatype="float" align="center">单价 </div>
	       <div field="rate" name="itemRate" headerAlign="center" allowSort="false" visible="true" width="60" datatype="float" align="center" >优惠率</div>            
	       <div field="subtotal"  name="itemSubtotal" headerAlign="center" allowSort="false" visible="true" width="70" datatype="float" align="center">金额</div>          
	       <div field="amt"  name="amt" headerAlign="center" allowSort="false" visible="false" width="70" datatype="float" align="center">总金额 </div>           
           <div field="workers" headerAlign="center" allowSort="false" visible="true" width="80" header="施工员" name="workers"  align="center"></div>
	       <div field="workerIds" headerAlign="center"  allowSort="false" visible="false" width="80" header="施工员" align="center"></div>  
	       <div field="saleMan" headerAlign="center" allowSort="false" visible="true" width="50" header="销售员" align="center" name="saleMan"></div>
	       <div field="saleManId" headerAlign="center"   allowSort="false" visible="false" width="80" header="销售员" align="center"></div> 
	       <div field="remark" headerAlign="center"   allowSort="false" visible="true" width="80" header="备注" align="center"></div>
      </div>
   </div>
</div>
            <script type="text/javascript">
                nui.parse();
            </script>
        </body>

        </html>