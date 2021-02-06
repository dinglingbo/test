<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8" session="false" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<!-- 
  - Author(s): Administrator
  - Date: 2018-07-02 19:02:07 
  - Description:  
-->   
<head>
  <title>保险设置</title>
  <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
  <script src="<%= request.getContextPath() %>/common/nui/nui.js" type="text/javascript"></script>

  <style type="text/css">
  body { 
   margin: 0;
   padding: 0;
   border: 0;
   width: 100%;
   height: 100%;
   overflow: hidden;
}

.tbtext{

  line-height: 30px;
}
/* .tbCtrl{
  width: 200px;
} */
.tmargin{
  margin-top: 10px;
  margin-bottom: 10px;
}
</style>
</head>
<body>
  <div class="nui-fit">
   <table  style=" left:0;right:0;margin: 0 auto;"> 
    <tr>   
        <td class="tbtext">保险公司</td> 
        <td class="tbCtrl" colspan="4"><input  class="nui-textbox tabwidth"  style="width:100%"/></td>
    </tr>
    <tr> 
        <td class="tbtext">业务状态</td> 
        <td class="tbCtrl" colspan="4">   
            <input type="radio" name="settleTypeId" id="radio1" value="1" checked>启用
            <input type="radio" name="settleTypeId" id="radio2" value="2" >禁用
        </tr>

        <tr>   
            <td class="tbtext" colspan="2"><lable style="font-size: 14px;font-weight:550;">保险公司返点给门店</lable></td> 
            <td style="width:75px;"></td>
            <td class="tbtext" colspan="2"><lable style="font-size: 14px;font-weight:550;">门店返点给车主</lable></td> 

        </tr>
        <tr>   
            <td class="tbtext">商业险返点(%)</td> 
            <td class="tbCtrl"><input  class="nui-textbox tabwidth" /></td>
            <td></td>
            <td class="tbtext">商业险返点(%)</td> 
            <td class="tbCtrl"><input  class="nui-textbox tabwidth" /></td>

        </tr>
        <tr>   
            <td class="tbtext">交强险返点(%)</td> 
            <td class="tbCtrl"><input  class="nui-textbox tabwidth" /></td>
            <td></td>
            <td class="tbtext">交强险返点(%)</td> 
            <td class="tbCtrl"><input  class="nui-textbox tabwidth" /></td>

        </tr>
        <tr>   
            <td class="tbtext">车船税返点(%)</td> 
            <td class="tbCtrl"><input  class="nui-textbox tabwidth" /></td>
            <td></td>
            <td class="tbtext">车船税返点(%)</td> 
            <td class="tbCtrl"><input  class="nui-textbox tabwidth" /></td>

        </tr>
                <tr>   
            <td class="tbtext" colspan="5"> <hr style="width:100%;float: left;"></td>

        </tr>

        <tr>   
            <td class="tbtext">商业险提成</td> 
            <td class="tbCtrl">
                <input type="radio" name="settleTypeId" id="radio1" value="1" checked>启用
                <input type="radio" name="settleTypeId" id="radio2" value="2" >禁用
            </td>
            <td></td>
            <td class="tbtext">提成金额</td> 
            <td class="tbCtrl"><input  class="nui-textbox tabwidth" /></td>

        </tr>

        <tr>   
            <td class="tbtext">交强险提成</td> 
            <td class="tbCtrl">
                <input type="radio" name="settleTypeId" id="radio1" value="1" checked>启用
                <input type="radio" name="settleTypeId" id="radio2" value="2" >禁用
            </td>
            <td></td>
            <td class="tbtext">提成金额</td> 
            <td class="tbCtrl"><input  class="nui-textbox tabwidth" /></td>

        </tr>

        <tr>   
            <td class="tbtext">车船税提成</td> 
            <td class="tbCtrl">
                <input type="radio" name="settleTypeId" id="radio1" value="1" checked>启用
                <input type="radio" name="settleTypeId" id="radio2" value="2" >禁用
            </td>
            <td></td>
            <td class="tbtext">提成金额</td> 
            <td class="tbCtrl"><input  class="nui-textbox tabwidth" /></td>

        </tr>


    </table>





    <div style="width:100%;margin-top: 10px;text-align: center;">
        <a class="nui-button" onclick=""   plain="false" >保存</a>

        <a class="nui-button" onclick=""   plain="false" >退出</a>
    </div>

</div>
<script type="text/javascript">
 nui.parse();
</script>
</body>
</html>