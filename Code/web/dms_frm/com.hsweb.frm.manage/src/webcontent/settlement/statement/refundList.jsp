<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false"%>
<%@include file="/common/commonPart.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<!-- 
  - Author(s): Administrator
  - Date: 2018-02-10 12:12:52
  - Description:
-->
<head>
<title>储值卡退款</title>
<script
	src="<%=request.getContextPath()%>/manage/settlement/js/refundList.js?v=1.0.9"></script>
    <style type="text/css">
        body { 
            margin: 0;
            padding: 0;
            border: 0;
            width: 100%;
            height: 100%;
            Foverflow: hidden;
        }
        .btnType{
            font-family:Verdana;
            font-size: 14px;
            text-align: center;
            height: 40px;
            width: 120px;
            line-height:40px;
        }
        .title {
            width: 80px;
            text-align: right;
        }
        .required {
            color: red;
        }



.tishi{
	margin-top: 5px;
}
.btn .mini-buttonedit{
	height:36px;
}
.btn .aa{
	height:36px;
	width: 300px;
}
.btn .mini-buttonedit .mini-corner-all{
	height:33px;
	background: #368bf447;
}
.btn .aa .mini-corner-all{
	height:33px;
}
.mini-corner-all .nui-textbox{
	height:30px;
}
.btn .mini-corner-all .mini-buttonedit-input{
	font-size: 16px;
	margin-top: 8px;
	
}
.btn .mini-corner-all .mini-textbox-input{
	font-size: 14px;
	margin-top: 8px;
	
}

    </style>
</head>
<body>
	<div class="nui-toolbar" style="padding:2px;height:48px;position: relative;">
    <table class="table" id="table1" border="0" style="width:100%;border-spacing:0px 0px;">
        <tr>            
            <td class="btn">
                	<div class="nui-autocomplete" emptyText="客户查询(输入的内容长度要求大于或是等于3)"
                    style="width:400px;height: 50px !important;"  popupWidth="600" textField="text" valueField="id" 
                    id="search_key" url="" value="carNo"   searchField="key" multiSelect="false" 
                    dataField="list" placeholder="请输入..."  >     
                    <div property="columns">
                        <div header="客户名称" field="guestFullName" width="30" headerAlign="center"></div>
                        <div header="客户手机" field="guestMobile" width="60" headerAlign="center"></div>
                        <div header="车牌号" field="carNo" width="40" headerAlign="center"></div>
                        <div header="联系人名称" field="contactName" width="30" headerAlign="center"></div>
                        <div header="联系人手机" field="mobile" width="60" headerAlign="center"></div>
                        <div header="车架号(VIN)" field="vin" width="70" headerAlign="center"></div>
                    </div>
                </div>
                <input id="search_name"
                name="search_name"
                class="nui-textbox aa"
                emptyText="车牌号/客户名称/手机号/VIN码"
                onbuttonclick="onSearchClick()"
                visible="false"
                enabled="false"
                showClose="false"
                allowInput="true"/>
                <a class="nui-button" iconCls="" plain="true" onclick="add()" id="addBtn"><span class="fa fa-history fa-lg"></span>&nbsp;切换客户</a>
                <a class="nui-button" onclick="refund()" plain="true"> <span class="fa fa-user-circle fa-lg"></span>&nbsp;退款</a>
				<a class="nui-button" onclick="refundRecord()" plain="true"> <span class="fa fa-user-circle fa-lg"></span>&nbsp;退款记录</a>
            </td> 
          </tr>
        </table>
      </div>

				<div class="nui-fit">
					<div id="datagrid1" dataField="data" class="nui-datagrid"
						pageSize="50" onDrawCell="onDrawCell"
						onselectionchanged="selectionChanged" onrowclick=""
						allowSortColumn="true" style="width: 100%; height: 100%;">
						<div property="columns">
							<div type="indexcolumn">序号</div>
							<div field="id" headerAlign="center" allowSort="true"
								visible="false">会员卡ID</div>
							<div field="guestName" headerAlign="center" align="center"
								allowSort="true">客户名称</div>
							<div field="cardName" headerAlign="center" align="center"
								allowSort="true">会员卡名称</div>
							<div field="rechargeAmt" headerAlign="center" align="center"
								allowSort="true">充值金额</div>
							<div field="giveAmt" headerAlign="center" align="center"
								allowSort="true">赠送金额</div>
							<div field="totalAmt" headerAlign="center" align="center"
								allowSort="true">总金额</div>
							<div field="useAmt" headerAlign="center" align="center"
								allowSort="true">已使用金额</div>
							<div field="balaAmt" headerAlign="center" align="center"
								allowSort="true">剩余金额</div>	
							<div field="refundAmt" headerAlign="center" align="center"
								allowSort="true">已退款金额</div>									
							<div field="saleMan" headerAlign="center" align="center"
								allowSort="true">销售员</div>
							<div field="recordDate"  align="center"
								headerAlign="center" dateFormat="yyyy-MM-dd HH:ss" allowSort="true">充值日期</div>
						</div>
					</div>
				</div>

</body>
</html>