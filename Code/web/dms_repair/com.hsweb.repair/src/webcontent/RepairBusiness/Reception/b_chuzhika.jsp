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
    <title>营销-创建套餐</title>
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





   #table_A tr
   {
      height:40px;
  }
  table tr td span
  {

      display: inline-block;
  }


  #table_A tr
  {
      height:40px;
  }
  table tr td span
  {
 
      display: inline-block;
  }

  .tabwidth{
      width:100%;
  }
  .tbtext{
      float: right;
      line-height: 40px;
  }
  .tbCtrl{
    width: 150px;
}
.mini-textbox{
  height: 28px;
}
.mini-textbox-border{
  height: 25px;
}
.mini-textbox-input{/* 输入框的里面的高度 */
  height: 24px;
}

.checkboxwidth{
  width: 65px;
  margin-left:20px;
}

.mini-tabs-header{
    height: 30px;
}

.mini-button-text{
    line-height: 26px;
} 




/* ////////////////下拉框样式/////////////////////////////// */
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
    background: #fff;
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
/* /////////////////////////////////////////////// */
.red{
    color: red;
}
.right{
    text-align: right;
}
.fwidtha{
    width: 120px;
}
.fwidthb{
    width: 120px;
}
.bt_trWidth{
    width: 170px;
}
.textboxWidth{
    width:100%;
}
.htr{
    height: 30px;
}
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
            <td class="tbtext">卡名称</td> 
            <td class="tbCtrl"><input  class="nui-textbox tabwidth" /></td>
            <td class="tbCtrl" colspan="3">
                适用范围<label><input name="Fruit" type="radio" value="" />单店卡</label>
                <label><input name="Fruit" type="radio" value="" />连锁卡</label>
            </td>

        </tr>
        <tr>  
            <td class="tbtext">充值金额</td> 
            <td class="tbCtrl" ><input  class="nui-textbox tabwidth" /></td>
            <td class="tbtext">赠送金额</td> 
            <td class="tbCtrl"><input  class="nui-textbox tabwidth" /></td>
            <td class="tbtext">总金额</td> 
            <td class="tbCtrl"><input  class="nui-textbox tabwidth" /></td>

        </tr>

        <tr>
            <td class="tbtext"></td> 
            <td class="tbCtrl"><div id="ck1" name="product" class="mini-checkbox" text="允许开卡时修改金额"></div></td> 
        </tr>


        <tr>
            <td class="tbtext">有效期</td> 
            <td class="tbCtrl" ><input  class="nui-textbox tabwidth" /></td>
            <td class="tbtext">永久有效</td> 
            <td class="tbCtrl"><div id="ck1" name="product" class="mini-checkbox" ></div></td> 

        </tr>

        <tr>
            <td class="tbtext">卡说明</td> 
            <td class="tbCtrl" colspan="5"><input  class="nui-textbox tabwidth" /></td>

        </tr>

        <tr>
            <td class="tbtext">使用条款</td> 
            <td class="tbCtrl" colspan="5"><input  class="nui-textbox tabwidth" /></td>

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