<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false" %>
	<%@include file="/common/common.jsp"%>
	<%@include file="/common/commonRepair.jsp"%>	
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<!-- 
  - Author(s): Administrator
  - Date: 2018-08-15 17:18:09
  - Description:
-->
<head>
<title>会员卡充值</title>
    <script src="<%=webPath + repairDomain%>/repair/js/RepairBusiness/CustomerProfile/CardUp.js?v=1.1.5"></script>
	<style type="text/css">
	
	table {
            font-size: 12px;
        }
        
         .form_label {
            width: 84px;
        
        }
	 a.ztedit{ height:18px; display:inline-block; background:url(../images/sjde.png) 40px -1px no-repeat; padding-right:22px; color:#888; text-decoration:none;}
        .addyytime a{width:112px;height:35px;line-height:36px;border:1px #a6e0f5 solid;display:block;float:left;text-decoration:none;text-align:center;color:#00b4f6;border-radius:4px;margin:0 15px 15px 15px;}
        .addyytime a.hui{border:1px #e6e6e6 solid;color:#c8c8c8;background:#e6e6e6;}
        .addyytime a.xz{ border:1px #ff7800 solid; color:#fff; background:#ff7800;}
        a:link, a:visited { font-family: 微软雅黑, Arial, Helvetica, sans-serif; font-size: 14px; color: #555555; text-decoration: none; }
        a:hover { font-family: 微软雅黑, Arial, Helvetica, sans-serif; font-size: 14px; color: #df0024; text-decoration: none; }
        a {text-decoration:none;transition:all .4s ease;}
	</style>
</head>
<body>

    <div class="nui-fit" style=" width: 100%;  ">
        <div showCollapseButton="false" style="border:0; ">
            <div class="nui-toolbar" style="padding:0px;border-bottom:0;">   
            </div>
            <div class="nui-form" id="basicInfoForm">
                <table style="border-collapse:separate; border-spacing:0px 10px;">
                    <tr >
                   <td  style="display:none;"> 客户姓名：
						 <input class="nui-textbox" id="guestId" name="guestId" visible="true"  allowInput="false"/>         
                        </td>
                        <td  style=" width:55%;padding-left:90px;">客户姓名：
						 <input class="nui-textbox" id="guestFullName" name="guestFullName" visible="true"  allowInput="false"/> 
                        </td>
                        <td > 客户电话：
                             <input class="nui-textbox" id="mobile" name="mobile" allowInput="false" valueField=""  />
                        </td> 
                        </tr>
                    <tr >
                        <td  colspan="2" style=" text-align:center;">
                        	储值卡类型选择:       
                        </td>
                    </tr>
                    <tr>
                    	  <td colspan="5">
                            <div class="addyytime">
                            </div>
                        </td>
                    </tr>
                </table>
                <div class="nui-form" id="form1">
                <table id="table" style="border-collapse:separate; border-spacing:0px 10px; height: 120px">
                	<tr style="text-align: center;width:10%">
                		<td  >充值金额(元)：<span style="width:10px"></span>&nbsp;&nbsp;&nbsp;
                		<input id="rechargeAmt" name="rechargeAmt" class="nui-textbox" width="40%" allowInput="true" vtype="float;range:0,1000000"/>
                		</td>
					</tr>
					<tr style="text-align: center;width:10%">
                		<td  >赠送金额(元)：&nbsp;&nbsp;&nbsp;
                		<input id="giveAmt" name="giveAmt" class="nui-textbox" width="40%" vtype="float;range:0,100000" />
                		</td>
					</tr>
<!-- 					<tr> -->
<!-- 						<td style="text-align: center;width:10%">工时优惠率(%)： -->
<!-- 						<input  id="itemRate" name="itemRate" class="nui-textbox" width="40%" vtype="range:0,100" /> -->
<!-- 						</td> -->
<!-- 					</tr> -->
<!-- 					<tr> -->
<!-- 						<td style="text-align: center;width:10%">套餐优惠率(%)： -->
<!-- 						<input id="packageRate" name="packageRate" class="nui-textbox" width="40%"vtype="range:0,100"  /> -->
<!-- 						</td> -->
<!-- 					</tr> -->
<!-- 					<tr> -->
<!-- 						<td style="text-align: center;width:10%">配件优惠率(%)： -->
<!-- 						<input id="partRate" name="partRate"class="nui-textbox" width="40%" vtype="range:0,100" /> -->
<!-- 						</td> -->
<!-- 					</tr> -->
					<tr >
						<td style="text-align: center;width:10%">到账金额(元)：&nbsp;&nbsp;&nbsp;
						<input id="totalAmt" name="totalAmt"class="nui-textbox" width="40%"  allowInput="false" />
						</td>
					</tr>
					</table>
					<table style="width:100%;">
					<tr >
						<td align="right"  width="36%">支付方式：</td>
						<td  id="radio"  class="nui-radiobuttonlist" textField="name" valueField="id" ></td>
					</tr>
					<tr align="center" height="40px">
						<td colspan="2">
							<a class="nui-button"onclick="noPay()">保存</a>
							<a class="nui-button"onclick="pay()">确认支付</a>
						</td>
					</tr>          
                </table>
                </div>
         </div> 

        </div>
    </div>


    </div>
</body>
	<script type="text/javascript">

	</script>
</html>