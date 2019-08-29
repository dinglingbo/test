<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false"%>
<%@include file="/common/commonRepair.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<!-- 
  - Author(s): Administrator
  - Date: 2018-08-15 17:18:09
  - Description:
-->
<head>
<title>费用登记</title>
<script src ="<%=request.getContextPath()%>/repair/js/RepairBusiness/Reception/billExpenseDetail.js?v=1.0.2">
</script>
<style type="text/css">
.vpanel_heading {
	border-bottom: 1px solid #d9dee9;
	width: 100%;
	height: 28px;
	line-height: 28px;
}

.vpanel_heading span {
	margin: 0 0 0 20px;
	font-size: 16px;
	font-weight: normal;
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
</style>
<div class="nui-fit">
	<div class="nui-fit">
		     <div class="nui-toolbar" style="padding:0px;border-bottom:0;">
                <table style="width:100%;">
                    <tr>
                        <td style="width:100%;">
                            <a class="nui-button" onclick="onOk()" plain="true" style="width: 60px;" id="onOk"><span class="fa fa-save fa-lg"></span>&nbsp;保存</a>
                            <a class="nui-button" onclick="onCancel()" plain="true"  style="width: 60px;"><span class="fa fa-remove fa-lg"></span>&nbsp;取消</a>
                            <a class="nui-button" iconCls="" onclick="onPrint()" plain="true" style="align:right"><span class="fa fa-print fa-lg"></span>&nbsp;打印</a>
                        </td>
                    </tr>
                </table>
            </div>
		<div class="" style="width:100%;height:50%;" >
			<div id="receiveGrid"
				borderStyle="border-bottom:1;"
				class="nui-datagrid"
				dataField="" style="width: 100%; height:100%;"
				allowCellSelect="true" allowCellEdit="true"
				showPager="false"showModified="false" allowSortColumn="true"
				oncelleditenter="onGuestValueChanged"
				selectOnLoad="true"
                onselectionchanged=""
                editNextOnEnterKey="true"
				>
				<div property="columns">
					<div type="indexcolumn" headerAlign="center" name="index" visible="true" width="15">序号</div>
					<div header="其它费用收入">
						<div property="columns">
							<div field="optBtn" name="optBtn" width="60" headerAlign="center" header="操作" align="center" ></div>
							<div field="typeId" type="comboboxcolumn" width="100" headerAlign="center" header="收入项目">
								<input  property="editor" enabled="true" id="billTypeList" name="list" data="rlist" dataField="rlist" class="nui-combobox" 
								        valueField="id" onvaluechanged="onbillRTypeChange" textField="name" url="" emptyText=""  vtype="required"/> 
							</div>
							<div field="amt" width="60" headerAlign="center" header="收入金额">
								<input property="editor" vtype="float" class="nui-textbox"  />
							</div>
							<!-- <div field="guestName"  width="120" headerAlign="center" header="往来单位">
							     <a href="javascript:selectGuest()" title="选择往来单位" style="text-decoration:none;">&nbsp;&nbsp;<span class="fa fa-edit fa-lg"></span></a>
					             <input property="editor" class="nui-textbox" id="guestId"/>
					             <input id="contactorName"
	                         name="contactorName"
	                         class="nui-buttonedit"
	                         emptyText=""
	                         onbuttonclick="chooseContactor()"
	                         placeholder="请选择联系人"
	                         selectOnFocus="true" 
	                         allowInput="false"
	                         />
							</div> -->
							<div field="guestName" headerAlign="center"
                     allowSort="false" visible="true" width="120" header="" align="center" name="guestName">
                                           往来单位 <a href="javascript:selectGuest()" title="选择往来单位" style="text-decoration:none;">&nbsp;&nbsp;<span class="fa fa-edit fa-lg"></span></a>
                    <input class="nui-textbox" property="editor" id="guestId"/> 
                </div>
							<div field="guestId"  width="120" headerAlign="center" header="往来单位id" visible="false">
							</div>
							<div field="remark" width="80" headerAlign="center" header="备注">
								<input property="editor" class="nui-textbox"/>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
		<div class="" style="width:100%;height:50%;" >
			<div id="payGrid"
				borderStyle="border-bottom:1;"
				class="nui-datagrid"
				dataField="" style="width: 100%; height:100%;"
				allowCellSelect="true" allowCellEdit="true"
				showPager="false"showModified="false" allowSortColumn="true"
				oncelleditenter="onGuestValueChanged1"
				selectOnLoad="true"
                onselectionchanged=""
                editNextOnEnterKey="true"
				>
				<div property="columns">
					<div type="indexcolumn" headerAlign="center" name="index" visible="true" width="15">序号</div>
					<div header="其它费用支出">
						<div property="columns">
							<div field="optBtn" name="optBtn" width="60" headerAlign="center" header="操作" align="center" ></div>
							<div field="typeId" type="comboboxcolumn" width="100" headerAlign="center" header="费用科目">
								<input  property="editor" enabled="true" id="billTypeList" name="list" data="plist" dataField="plist" class="nui-combobox" 
								valueField="id" onvaluechanged="onbillPTypeChange" textField="name" url="" emptyText=""  vtype="required"/> 
							</div>
							<div field="amt" width="60" summaryType="sum" headerAlign="center" header="支出金额">
								<input property="editor" vtype="float" class="nui-textbox"/>
							</div>
							<!-- <div field="guestName"  width="120" headerAlign="center" header="往来单位">
					             <input property="editor" class="nui-textbox" id="guestId1" />
							</div> -->
							<div field="guestName" headerAlign="center"
                     allowSort="false" visible="true" width="120" header="" align="center" name="guestName">
                                           往来单位 <a href="javascript:selectGuest1()" title="选择往来单位" style="text-decoration:none;">&nbsp;&nbsp;<span class="fa fa-edit fa-lg"></span></a>
                    <input class="nui-textbox" property="editor" id="guestId1"/> 
                </div>
							<div field="guestId"  width="120" headerAlign="center" header="往来单位id" visible="false">
							</div> 
							<div field="remark" width="80" headerAlign="center" header="备注">
								<input property="editor" class="nui-textbox"/>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>



</body>
<script type="text/javascript">
	
</script>
</html>