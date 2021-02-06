<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@include file="/common/commonPart.jsp"%>
<html>
<!-- 
  - Author(s): Administrator
  - Date: 2018-01-24 23:12:35
  - Description:
-->
<head>
<title>客户级别</title>
<script src="<%=webPath + contextPath%>/repair/cfg/js/guestType.js?v=1.0.3"></script>
<style type="text/css">
.title {
	text-align: right;
	display: inline-block;
}

.title-width1 {
	width: 75px;
}

.title-width2 {
	width: 90px;
}
.left{
    text-align: left;
}
.right{
    text-align: right;
}  
.fwidtha{
    width: 60px;
}
.fwidthb{
    width: 60px;
}
.htr{
    height: 20px;
}
/* .mainwidth{
    width: 700px;
} */
.tmargin{
    margin-top: 10px;
    margin-left: 70px;
    margin-bottom: 10px;
}

.vpanel{
    border:0px solid #d9dee9;
    margin:0px 0px 0px 0px;
    height:248px;
    float:left;
}
.vpanel_heading{
    border-bottom:1px solid #d9dee9;
    width:100%;
    height:28px;
    line-height:28px;
}
.vpanel_heading span{
    margin:0 0 0 20px;
    font-size:8px;
    font-weight:normal;
}
.vpanel_bodyww{
    padding : 10 10 10 10px !important

}

.required {
    color: red;
}

.tbtext{
    text-align: right;
}

</style>
</head>
<body>


        <div>
            <div id="editForm" class="form">
            		<div class="nui-toolbar" style="padding:0px;border-bottom:0;">
			            <table style="width:80%;">
			                <tr>
			                    <td style="width:80%;">
			                        <a class="nui-button" iconCls="" plain="true" onclick="onOk()"><span class="fa fa-save fa-lg"></span>&nbsp;保存</a>
			                        <a class="nui-button" iconCls="" plain="true" onclick="onCancel"><span class="fa fa-close fa-lg"></span>&nbsp;取消</a>
			                    </td>
			                </tr>
			            </table>
			        </div>
                    <input id="orgid" name="orgid" width="100%" class="nui-hidden" >
                    <input class="nui-hidden" name="id"/>
                    <table class="tmargin" width="100%">
                        <tr class="htr">
                            <td class="tbtext required">客户级别名称:</td>
                            <td >
                                <input name="name" class="nui-textbox" width="200px" id="name"/>
                                <input name="isDisabled" class="nui-checkbox" width="50px" text="是否禁用" trueValue="1" falseValue="0"/>
                            </td>
                        </tr>
                    </table>
                    <hr>
                    <table class="tmargin" width="100%">
                        <tr class="htr">
                            <td class="tbtext">折扣适用范围:</td>
                            <td >
                                <input name="discountRangeBill" class="nui-checkbox" width="50px" text="工单" trueValue="1" falseValue="0"/>
                                <input name="discountRangeWash" class="nui-checkbox" width="50px" text="洗车单" trueValue="1" falseValue="0"/>
                                <input name="discountRangeRetail" class="nui-checkbox" width="50px" text="零售单" trueValue="1" falseValue="0"/>
                                <input name="discountRangeClaims" class="nui-checkbox" width="50px" text="理赔单" trueValue="1" falseValue="0"/>
                            </td>
                        </tr>
                    </table>

                    <div style="height: 180px;">
                        <div class="nui-fit">
                                <div id="contentGrid" class="nui-datagrid" style="width: 80%; height: 100%; margin-left: 10%; "
                                        showPager="false"
                                        dataField="resList"
                                        sortMode="client"
                                        allowCellSelect="true"
                                        allowCellEdit="true"
                                        showModified="false"
                                        url="">
                                    <div property="columns">
                                        <div type="indexcolumn">序号</div>
                                        <div allowSort="true" field="serviceTypeName" width="80" headerAlign="center" align="center" header="业务类型"></div>
                                        <div allowSort="true" field="packageDiscountRate" headerAlign="center" header="套餐优惠(0.1-1.00)">
                                                <input property="editor" class="nui-spinner" format="0.00"  value="0" maxValue="1.00" showButton="false"/>
                                        </div>
                                        <div allowSort="true" field="itemDiscountRate" headerAlign="center" header="项目优惠(0.1-1.00)">
                                                <input property="editor" class="nui-spinner" format="0.00"  value="0" maxValue="1.00" showButton="false"/>
                                        </div>
                                        <div allowSort="true" field="partDiscountRate" headerAlign="center" header="配件优惠(0.1-1.00)">
                                                <input property="editor" class="nui-spinner" format="0.00"  value="0" maxValue="1.00" showButton="false"/>
                                        </div>
                                    </div>
                                </div>
                            </div>
                    </div>
                    
                    <hr>
                    <table class="tmargin" width="100%">
                        <tr class="htr">
                            <td class="tbtext">积分系统启用:</td>
                            <td >
                                <input name="integralDisabled" class="nui-checkbox" text="" value="0" trueValue="1" falseValue="0"/>
                            </td>
                        </tr>
                        <tr class="htr">
                            <td class="tbtext">消费100元兑换:</td>
                            <td >
                                <input name="integralAdd" class="nui-spinner" width="180px" format="0" 
                                       id="integralAdd" maxValue="127" showButton="false"/>积分
                            </td>
                        </tr>
                        <tr class="htr">
                            <td class="tbtext">产生积分:</td>
                            <td >
                                <input name="integralBillAdd" class="nui-checkbox" width="50px" text="工单" trueValue="1" falseValue="0"/>
                                <input name="integralWashAdd" class="nui-checkbox" width="50px" text="洗车单" trueValue="1" falseValue="0"/>
                                <input name="integralRetailAdd" class="nui-checkbox" width="50px" text="零售单" trueValue="1" falseValue="0"/>
                                <input name="integralClaimsAdd" class="nui-checkbox" width="50px" text="理赔单" trueValue="1" falseValue="0"/>
                            </td>
                        </tr>
                        <tr class="htr">
                            <td class="tbtext">抵扣100元消费:</td>
                            <td >
                                <input name="integralReduce" class="nui-spinner" width="180px" format="0" 
                                    id="integralReduce" maxValue="127" showButton="false"/>积分
                            </td>
                        </tr>
                        <tr class="htr">
                            <td class="tbtext">使用积分:</td>
                            <td >
                                <input name="integralBillReduce" class="nui-checkbox" width="50px" text="工单" trueValue="1" falseValue="0"/>
                                <input name="integralWashReduce" class="nui-checkbox" width="50px" text="洗车单" trueValue="1" falseValue="0"/>
                                <input name="integralRetailReduce" class="nui-checkbox" width="50px" text="零售单" trueValue="1" falseValue="0"/>
                                <input name="integralClaimsReduce" class="nui-checkbox" width="50px" text="理赔单" trueValue="1" falseValue="0"/>
                            </td>
                        </tr>
                    </table>
    
              </div>
        </div>
    
<!--         <div style="text-align: center;">    -->
<!--                 <a class="nui-button" iconCls="" plain="false" onclick="onOk">保存</a>&nbsp;&nbsp;&nbsp;&nbsp; -->
<!--                 <a class="nui-button" iconCls="" plain="false" onclick="onCancel">取消</a> -->
<!--         </div> -->
            
        
 
</body>
</html>
