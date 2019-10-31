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
    <title>开通电子档案</title>
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
    width:300px;
}
.tbtext{
    float: right; 
    line-height: 40px;
    width:230px;
    text-align: right;
}
.mini-textbox{
    height: 28px;
    display: inline;
}
.mini-textbox-border{ 
    height: 25px;
} 
.mini-textbox-input{
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
                            <a class="nui-button" onclick="save('no')" plain="true" style="width: 60px;"><span class="fa fa-save fa-lg"></span>&nbsp;注册</a>
                            <a class="nui-button" onclick="Oncancel()" plain="true"  style="width: 60px;"><span class="fa fa-remove fa-lg"></span>&nbsp;取消</a>
                        </td>
                    </tr>
                </table>
            </div>
        <div class="form" id="basicInfoForm" name="basicInfoForm" style="width:950px;height:100%;left:0;right:0;margin: 0 auto;">
        		     
           <table  id="table1">
            <tr>
                <td class="tbtext">维修企业名称<span style="color:red">*</span></td>
                <td colspan="1"><input class="nui-textbox tabwidth" name="companyname" id="companyname"/></td>
                <td class="tbtext">维修企业登录密码<span style="color:red">*</span></td>
                <td><input class="nui-textbox tabwidth" name="companypassword" id="companypassword"/></td>

            </tr>               

		   <tr>
                <td class="tbtext">维修企业道路运输经营许可证号</td>
                <td colspan="1"><input class="nui-textbox tabwidth" name="companyroadtransportationlicense" id="companyroadtransportationlicense"/></td>
                <td class="tbtext">维修企业统一社会代码<span style="color:red">*</span></td>
                <td><input class="nui-textbox tabwidth" name="companyunifiedsocialcreditidentifier" id="companyunifiedsocialcreditidentifier"/></td>

           </tr> 
            <tr>
                <td class="tbtext">维修企业地址<span style="color:red">*</span></td>
                <td colspan="1"><input class="nui-textbox tabwidth" name="companyaddress" id="companyaddress"/></td>
                <td class="tbtext">维修企业邮政编码<span style="color:red">*</span></td>
                <td><input class="nui-textbox tabwidth" name="companypostalcode" id="companypostalcode"/></td>

            </tr>  
             <tr>
                <td class="tbtext">维修企业经济类型<span style="color:red">*</span></td>
               <td colspan="1"><input class="nui-textbox tabwidth" name="companyeconomicategory" id="companyeconomicategory"/></td>
               <!--  <td >
                  <input id="companyeconomicategory"
                         name="companyeconomicategory"
                         class="nui-buttonedit tabwidth"
                         emptyText=""
                         onbuttonclick="chooseContactor()"
                         placeholder="维修企业经济类型"
                         selectOnFocus="true" 
                         allowInput="false"
                         />
                  </td> -->
                <td class="tbtext">维修企业经营业务类别<span style="color:red">*</span></td>
               <!--  <td >
                  <input id="companycategory"
                         name="companycategory"
                         class="nui-buttonedit tabwidth"
                         emptyText=""
                         onbuttonclick="chooseContactor()"
                         placeholder="维修企业经济类型"
                         selectOnFocus="true" 
                         allowInput="false"
                         />
                  </td> -->
               <td><input class="nui-textbox tabwidth" name="companycategory" id="companycategory"/></td>

            </tr>  
             <tr>
                <td class="tbtext">维修企业联系人姓名<span style="color:red">*</span></td>
                <td colspan="1"><input class="nui-textbox tabwidth" name="companylinkmanname" id="companylinkmanname"/></td>
                <td class="tbtext">维修企业联系人电话<span style="color:red">*</span></td>
                <td><input class="nui-textbox tabwidth" name="companylinkmantel" id="companylinkmantel"/></td>
            </tr>  
            
              
            
             <tr>
                <td class="tbtext">维修企业负责人姓名<span style="color:red">*</span></td>
                <td colspan="1"><input class="nui-textbox tabwidth" name="companysuperintendentname" id="companysuperintendentname"/></td>
                <td class="tbtext">维修企业负责人电话<span style="color:red">*</span></td>
                <td><input class="nui-textbox tabwidth" name="companysupereintendenttel" id="companysupereintendenttel"/></td>
            </tr>   
           
         <tr>
                <td class="tbtext">道路运输经营许可证起始日期</td>
                
                <td colspan="1"><input class="nui-datepicker tabwidth" enabled="true" format="yyyy-MM-dd HH:mm" name="roadtransportationlicensestartdate" id="roadtransportationlicensestartdate"/></td>
                
               <!--  <td colspan="1"><input class="nui-textbox tabwidth" name="companylinkmanname" id="companylinkmanname"/></td> -->
                <td class="tbtext">道路运输经营许可证结束日期</td>
                <td colspan="1"><input class="nui-datepicker tabwidth" enabled="true" format="yyyy-MM-dd HH:mm" name="roadtransportationlicenseenddate" id="roadtransportationlicenseenddate"/></td>
                
            </tr> 

            <tr>
                <td class="tbtext">维修企业经营状态<span style="color:red">*</span></td>
               <!--  <td >
                  <input id="companyoperationstate"
                         name="companyoperationstate"
                         class="nui-buttonedit tabwidth"
                         emptyText=""
                         onbuttonclick="chooseContactor()"
                         placeholder="维修企业经济类型"
                         selectOnFocus="true" 
                         allowInput="false"
                         />
                  </td> -->
                <td colspan="1"><input class="nui-textbox tabwidth" name="companyoperationstate" id="companyoperationstate"/></td>
                <td class="tbtext">维修企业注册区域编码<span style="color:red">*</span></td>
                 <!-- <td >
                  <input id="companyadministrativedivisioncode"
                         name="companyadministrativedivisioncode"
                         class="nui-buttonedit tabwidth"
                         emptyText=""
                         onbuttonclick="chooseContactor()"
                         placeholder="维修企业经济类型"
                         selectOnFocus="true" 
                         allowInput="false"
                         />
                  </td> -->
                <td><input class="nui-textbox tabwidth" name="companyadministrativedivisioncode" id="companyadministrativedivisioncode"/></td>
            </tr> 
            
            <tr>
                <td class="tbtext">维修企业注册邮箱<span style="color:red">*</span></td>
                <td colspan="1"><input class="nui-textbox tabwidth" name="companyemail" id="companyemail"/></td>
                <td class="tbtext">接入支持服务商<span style="color:red">*</span></td>
                <!--<td >
                   <input id="support"
                         name="support"
                         class="nui-buttonedit tabwidth"
                         emptyText=""
                         onbuttonclick="chooseContactor()"
                         placeholder="维修企业经济类型"
                         selectOnFocus="true" 
                         allowInput="false"
                         />
                  </td> -->
                <td><input class="nui-textbox tabwidth" name="support" id="support"/></td>
            </tr> 
             <tr>
                <td class="tbtext">维修企业经营范围<span style="color:red">*</span></td>
                <td colspan="1"><input class="nui-textbox tabwidth" name="companylinkmanname" id="companylinkmanname"/></td>
            </tr> 
            
        </table>
   
    </div>
</div> 
<script type="text/javascript">

			
</script>
</body>
</html>