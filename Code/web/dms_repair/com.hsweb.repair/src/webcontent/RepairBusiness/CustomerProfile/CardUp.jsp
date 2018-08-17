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
    <script src="<%=webPath + repairDomain%>/repair/js/RepairBusiness/CustomerProfile/CardUp.js?v=1.1.8"></script>
	<style type="text/css">
	 a.ztedit{ height:18px; display:inline-block; background:url(../images/sjde.png) 40px -1px no-repeat; padding-right:22px; color:#888; text-decoration:none;}
        .addyytime a{width:82px;height:28px;line-height:36px;border:1px #a6e0f5 solid;display:block;float:left;text-decoration:none;text-align:center;color:#00b4f6;border-radius:4px;margin:0 15px 15px 0;}
        .addyytime a.hui{border:1px #e6e6e6 solid;color:#c8c8c8;background:#e6e6e6;}
        .addyytime a.xz{ border:1px #ff7800 solid; color:#fff; background:#ff7800;}
        a:link, a:visited { font-family: 微软雅黑, Arial, Helvetica, sans-serif; font-size: 14px; color: #555555; text-decoration: none; }
        a:hover { font-family: 微软雅黑, Arial, Helvetica, sans-serif; font-size: 14px; color: #df0024; text-decoration: none; }
        a {text-decoration:none;transition:all .4s ease;}
	</style>
</head>
<body>

    <div style=" width: 100%;  ">
        <div showCollapseButton="false" style="border:0; ">
            <div class="nui-toolbar" style="padding:0px;border-bottom:0;">   
            </div>
            <div class="nui-form" id="basicInfoForm">
                <table style="border-collapse:separate; border-spacing:0px 10px;">
                    <tr >
                    <td  style="display:none;">客户姓名：
						 <input class="nui-textbox" id="guestId" name="guestId" visible="true"  allowInput="true"/> 
                           
                        </td>
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
                    	  <td colspan="5">
                            <div class="addyytime">
                            </div>
                        </td>
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
							<a class="nui-button"onclick="getCard()">确认支付</a>
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