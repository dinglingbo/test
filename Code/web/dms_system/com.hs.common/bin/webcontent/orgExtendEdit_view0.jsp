<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" session="false"%>
 <%@include file="/common/sysCommon.jsp"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<!-- 
  - Author(s): Administrator
  - Date: 2018-05-27 15:11:00
  - Description: 
--> 
<head>
    <title>门店信息</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
  	<script src="<%=webPath + contextPath%>/common/js/orgExtendEdit.js?v=2.1.4" type="text/javascript"></script>
  	<script src="<%=webPath + contextPath%>/common/js/qiniu.min.js" type="text/javascript"></script>
  	    <script src="https://cdn.staticfile.org/jquery/2.2.1/jquery.min.js"></script>
 	<link rel="stylesheet" href="https://cdn.bootcss.com/bootstrap/4.0.0-beta/css/bootstrap.min.css">
 	<script src="<%= request.getContextPath() %>/common/qiniu/qiniu1.0.14.js" type="text/javascript"></script>
  	<script src="https://cdn.staticfile.org/plupload/2.1.9/moxie.js"></script>
 	<script src="https://cdn.staticfile.org/plupload/2.1.9/plupload.dev.js"></script>  



  <style type="text/css">
    body {
       margin: 0;
       padding: 0;
       border: 0;
       width: 100%;
       height: 100%;
       overflow: hidden;
   }

    /*body.back{background:LightSteelBlue;}*/
   #table1
   {

    border-collapse:collapse;
    table-layout:fixed;
    font-weight:bold;
    left:0;right:0;   
    margin:0 auto;
    padding:1px 0px 1px 0px;


}
.pic { /* 页面logo图片 */
background-image: <%-- url(<%=request.getContextPath()%>/eos/A/jsp/Main.png) --%>;
background-repeat: no-repeat;
background-size: 100% 100%;
border-radius: 4px;
}

#table1  tr
{
  height:40px; 
} 
 .spanwidth
{
   width:10px; 
  display: inline-block;
} 

.tabwidth{
    width:800px;
}
.tbtext{
    float: right; 
    line-height: 40px;
}
.mini-textbox{
    height: 28px;
    display: inline;
}
.mini-textbox-border{ 
    height: 25px;
} 
.mini-textbox-input{/* 输入框的里面的高度 */
    height: 24px;
}

.mini-buttonedit {
    height: 28px;
}

.mini-buttonedit-border {
    height: 25px;
}

.mini-buttonedit-input {
    height: 24px;
}
.mini-buttonedit-buttons{
    top:3px;
    right: 10px;
}
.mini-buttonedit-button{
    border-left:0px;
}

.mini-buttonedit-button-pressed, .mini-buttonedit-popup .mini-buttonedit-button {
    background: #fff;
    color: #333333;
    border-width: 0px;
     border-left: 0px;
}

.mini-buttonedit-popup .mini-buttonedit-button
{
    background: #fff;
    border-width:0px;
    border-left: 0px ;
}

.mini-buttonedit-button-hover,
.mini-buttonedit-hover .mini-buttonedit-button
{
    color:#333;     
    background:#fff;
    border-width:0px;
    border-left: 0px ;
}
.checkboxwidth{
    width: 65px;
    margin-left:20px;
}
.textboxwidth{
    width:200px;
}
.inline{
    width:320px ;
    display:inline-block !important;
} 


.div1{

float: left;

height: 120px;

width: 120px;
position:relative;

}



.inputstyle{

    width: 120px;

    height: 120px;

    cursor: pointer;

    font-size: 30px;

    outline: medium none;

    position: absolute;

    filter:alpha(opacity=0);

    -moz-opacity:0;

    opacity:0; 

    left:0px;

    top: 0px;

}


</style> 
</head> 
<body class="back">
    <div class="nui-fit">  
    <div class="nui-toolbar" style="padding:0px;">
                <table style="width:100%;">
                    <tr>
                        <td style="width:100%;">
                            <a class="nui-button" onclick="save('no')" plain="true" style="width: 60px;"><span class="fa fa-save fa-lg"></span>&nbsp;保存</a>
                            <a class="nui-button" onclick="Oncancel()" plain="true"  style="width: 60px;"><span class="fa fa-remove fa-lg"></span>&nbsp;取消</a>
                        </td>
                    </tr>
                </table>
            </div>
        <div class="form" id="basicInfoForm" name="basicInfoForm" style="width:950px;height:100%;left:0;right:0;margin: 0 auto;">
        		     
           <table  id="table1">

            <tr >
                <td class="tbtext">LOGO图片<span class="spanwidth"></span>   </td>
                <td  colspan="5" class="tabwidth" >
                <div class="page-header" id="btn-uploader">
	                	<div class="div1" id="faker" onchange="xmTanUploadImg(this)">
				            <img id="xmTanImg" style="width: 100px;height: 100px" onchange="xmTanUploadImg(this)" src="<%= request.getContextPath() %>/common/images/logo.jpg"/>
				            <div id="xmTanDiv"></div>
				        </div>
			        </div>


						 <input  class="nui-textbox" id="logoImg" name="logoImg"  style="display:none" >
                </td>
				
            </tr> 

            <tr>
                <td class="tbtext">企业号<span style="color:red">*</span></td>
                <td colspan="5"><input class="nui-textbox tabwidth" name="code" id="code" vtype="maxLength:5"/></td>
				<td><input class="nui-textbox tabwidth" name="orgid" id="orgid" visible="false"/></td>
            </tr>    
            
            <tr>
                <td class="tbtext">公司全称<span style="color:red">*</span></td>
                <td colspan="3"><input class="nui-textbox tabwidth" name="name" id="name"/></td>
                <td class="tbtext">公司简称<span style="color:red">*</span></td>
                <td><input class="nui-textbox tabwidth" name="shortName" id="shortName"/></td>

            </tr>               

		
            <tr>
                <td style="width:100px;text-align:right;" class="tbtext">省份<span style="color:red">*</span></td>
                <td style="width:200px;text-align:left;"><input class="nui-combobox textboxwidth" name="provinceId" id="provinceId"  allowinput="true" valueField="code" textField="name" data="list" onvaluechanged="onProvinceChange" /></td>
                <td style="width:100px;text-align:right;"class="tbtext">城市<span style="color:red">*</span></td>
                <td style="width:200px;text-align:left;"><input class="nui-combobox textboxwidth" name="cityId" id="cityId" onvaluechanged="onCityChange"  allowinput="true"  allowinput="true" valueField="code" textField="name" /></td>
                <td style="width:100px;text-align:right;"class="tbtext">地区<span style="color:red">*</span></td>
                <td style="width:200px;text-align:left;"><input class="nui-combobox textboxwidth" name="countyId"  valueField="code" textField="name" allowinput="true" id="countyId" allowinput="true" onvaluechanged="onCountyChange"/></td>

            </tr> 

            <tr>
                <td class="tbtext">详细地址<span style="color:red">*</span></td>
                <td colspan="5"><input class="nui-textbox tabwidth" name="streetAddress" id="streetAddress" onvaluechanged="onStreetChange"/></td>

            </tr>
            <tr>
                <td class="tbtext">组合地址<span class="spanwidth"></span></td>
                <td colspan="5"><input class="nui-textbox tabwidth" enabled="true" name="address" id="address"/></td>

            </tr>

            <tr>
                <td class="tbtext">经度<span class="spanwidth" style="color:red" ></span></td>
                <td colspan="5" ><input class="nui-textbox inline " style="" name="longitude" id="longitude"/>
                    <span style="width:450px;float: right;text-align: right;">纬度<input class="nui-textbox inline" style="margin-left: 10px;" name="latitude" id="latitude"/></span>
                </td>

            </tr>
                        <tr>
                <td class="tbtext">开户银行<span style="color:red" ></span></td>
                <td colspan="5" ><input class="nui-textbox inline " style="" name="bankName" id="bankName"/>
                    <span style="width:450px;float: right;text-align: right;">银行账号<input class="nui-textbox inline" style="margin-left: 10px;" name="bankAccountNumber" id="bankAccountNumber"/></span>
                </td>

            </tr>
            <tr>
                <td class="tbtext">开店日期<span style="color:red">*</span></td>
                <td colspan="5"><input class="nui-datepicker tabwidth" enabled="true" format="yyyy-MM-dd hh:MM" name="softOpenDate" id="softOpenDate"/></td>

            </tr>           
            <tr>
                <td class="tbtext">公司电话<span style="color:red">*</span></td>
                <!-- <td colspan="4"><input class="nui-textbox tabwidth" name="tel" id="tel" onvalidation="onMobileValidation"/></td> -->
                <td colspan="4"><input class="nui-textbox tabwidth" name="tel" id="tel" /></td>
            </tr>           
            <tr>
                <td class="tbtext">网站<span class="spanwidth"></span></td>
                <td colspan="5"><input class="nui-textbox tabwidth" id="webaddress" name="webaddress"/></td>

            </tr>         


            <tr>
                <td class="tbtext">主修品牌<span class="spanwidth"></span></td>
                <td colspan="5"><input class="nui-textbox tabwidth" name="mainBrandId" id="mainBrandId"/></td>

            </tr>


            <tr>
                <td class="tbtext">救援电话<span class="spanwidth"></span></td>
                <td colspan="5"><input class="nui-textbox tabwidth" name="rescueTel" id="rescueTel"/></td>

            </tr>           
            
            <tr>
                <td class="tbtext">广告语1<span class="spanwidth"></span></td>
                <td colspan="5"><input class="nui-textbox tabwidth" name="slogan1" id="slogan1"/></td>

            </tr>           
            <tr>
                <td class="tbtext">广告语2<span class="spanwidth"></span></td>
                <td colspan="5"><input class="nui-textbox tabwidth" name="slogan2" id="slogan2"/></td>

            </tr>

            <tr>
                <td class="tbtext">电子档案对接省份<span style="color:red"></span></td>
                <td colspan="5" ><input class="nui-textbox inline " style="width: 255px;" name="eRecordProvince" id="eRecordProvince" />
                    <span style="width:500px;float: right;text-align: right;">电子档案维修厂编号
                    <input class="nui-textbox inline" style="margin-left: 10px;" name="eRecordRepairNo" id="eRecordRepairNo"/></span>
                </td>


            </tr>

              <tr>
                <td class="tbtext">电子档案登录地址<span class="spanwidth"></span></td>
                <td colspan="5"><input class="nui-textbox tabwidth" name="eTokenUrl" id="eTokenUrl"/></td>

            </tr>
             <tr>
                <td class="tbtext">电子档案推送地址<span class="spanwidth"></span></td>
                <td colspan="5"><input class="nui-textbox tabwidth" name="ePushUrl" id="ePushUrl"/></td>

            </tr>
            <tr>
                <td class="tbtext">电子档案用户名<span style="color:red"></span></td>
                <td colspan="5" ><input class="nui-textbox inline " style="" name="eRecordUser" id="eRecordUser"/>
                    <span style="width:450px;float: right;text-align: right;">电子档案密码<input class="nui-textbox inline" style="margin-left: 10px;" name="eRecordPwd" id="eRecordPwd"/></span>
                </td>


            </tr>
            <tr>
                <td class="tbtext">财务编号<span style="color:red"></span></td>
                <td colspan="5" >
                    <input class="nui-textbox inline " style="" name="kingId" id="kingId"/>
                    <span style="width:450px;float: right;text-align: right;">
                                   账簿编号<input class="nui-textbox inline" style="margin-left: 10px;" name="bookId" id="bookId"/></span>
                </td>


            </tr>
            <tr>
                <td class="tbtext">备注<span class="spanwidth"></span></td>
                <td colspan="5"><input class="nui-textbox tabwidth"/></td>

            </tr>


            <tr>
                <td class="tbtext">建档人<span style="color:red" ></span></td>
                <td colspan="5" ><input class="nui-textbox inline " readonly="readonly" style="" name="recorder" id="recorder" enabled="false" />
                    <span style="width:450px;float: right;text-align: right;">建档日期<input class="nui-textbox inline" readonly="readonly" style="margin-left: 10px;" name="recordDate" id="recordDate" enabled="false"/></span>
                </td>

            </tr>
            
            <tr>
                <td class="tbtext">最后操作人<span style="color:red"></span></td>
                <td colspan="5" ><input class="nui-textbox inline " style="" name="modifier" id="modifier" readonly="readonly" enabled="false"/>
                    <span style="width:450px;float: right;text-align: right;">最后操作日期<input readonly="readonly" class="nui-textbox inline" style="margin-left: 10px;" name="modifyDate" id="modifyDate" enabled="false"/></span>
                </td>

            </tr>
        </table>
   
    </div>
</div> 
<script type="text/javascript">

			
</script>
</body>
</html>