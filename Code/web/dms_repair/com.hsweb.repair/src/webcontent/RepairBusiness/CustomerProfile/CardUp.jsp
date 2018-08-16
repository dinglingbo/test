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
    <script src="<%=webPath + repairDomain%>/repair/js/RepairBusiness/CustomerProfile/CardUp.js?v=1.1.7"></script>

</head>
<body>

    <div style=" width: 100%;  ">
        <div showCollapseButton="false" style="border:0; ">
            <div class="nui-toolbar" style="padding:0px;border-bottom:0;">   
            </div>
            <div class="nui-form" id="basicInfoForm">
                <table style="border-collapse:separate; border-spacing:0px 10px;">
                    <tr >
                        <td  style="text-align: center; width:10%;">客户姓名：
						 <input class="nui-textbox" id="guestFullName" name="guestFullName" visible="true"  allowInput="true"/> 
                           
                        </td>
                    </tr >
                          <tr style="text-align: center;width:10%">
                        <td  class="form_label">
                            <label>客户电话：</label>
                             <input class="nui-textbox" id="mobile" name="mobile" allowInput="true" valueField=""  />
                        </td> 
                        </tr>
                    <tr>
                        <td align="center" class="form_label">
                        	<label >储值卡类型选择</label>         
                        </td>
                    </tr>
                    <tr>
                    	
                    </tr>
                </table>
                <table id="table" style="border-collapse:separate; border-spacing:0px 10px;">
                	<tr style="text-align: center;width:10%">
                		<td  >充值金额(元)：
                		<input id="up" class="nui-textbox" width="40%" />
                		</td>
					</tr>
					<tr>
						<td style="text-align: center;width:10%">会员折扣：
						<input class="nui-textbox" width="40%" />
						</td>
					</tr>
					<tr style="text-align: center;width:10%">
						<td  id="message">到账金额：
						</td>
					</tr>
					<tr>
						<td align="center" width:10>支付方式：</td>
					</tr>
					<tr align="center"  width:10>
						<td  id="radio"  class="nui-radiobuttonlist" textField="name" valueField="id" ></td>
					</tr>
					<tr align="center" >
						<td>
							<a class="nui-button"onclick="">确认支付</a>
						</td>
					</tr>
                
                </table>
         </div> 

        </div>
    </div>


    </div>
</body>
	<script type="text/javascript">

	</script>
</html>