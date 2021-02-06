<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8" session="false" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<!-- 
  - Author(s): Administrator
  - Date: 2018-07-02 20:50:20
  - Description:
-->     
<head>  
  <title>结算收银</title>
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

/* 
 table
 {

  left:0;right:0;margin: 0 auto;
  } */


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


  .vpanel{
    border:1px solid #d9dee9;
    margin:10px 0px 0px 20px;
    width:39%;
    height:248px;

  }
  .vpanel_heading{
    border-bottom:1px solid #d9dee9;
    width:100%;
    height:28px;
    line-height:28px;
  }
  .vpanel_heading span{
    margin:0 0 0 20px;
    font-size:16px;
    font-weight:normal;
  }
  .vpanel_bodyww{
    padding : 10 10 10 10px !important

  }
</style>
</head>
<body>
  <div class="nui-fit">
    <h2>结算收银</h2>


    <div  class="vpanel" style="width:99%;height:auto;margin-left: auto;margin-right: auto;">
      <div class="vpanel_heading" style="background-color:#f3f4f6;color:#2d95ff;"><span>客户信息</span></div>
      <div class="vpanel_body">
        <table > 
          <tr>
            <td class=""> 客户姓名</td> 
            <td class="" style="width: 150px;"> <label></label></div></td> 
            <td class=""> 车牌号</td> 
            <td class="" style="width: 150px;"> <label></label></div></td> 
            <td class=""> 客户级别</div></td> 
            <td class="" style="width: 150px;"> <label></label></div></td> 
            <td class=""> 原单详情>></div></td> 

          </tr>
        </table>


      </div> 
    </div>
    <div  class="vpanel" style="width:99%;height:auto;margin-left: auto;margin-right: auto;">
      <div class="vpanel_heading" style="background-color:#f3f4f6;color:#2d95ff;"><span>结算信息</span></div>
      <div class="vpanel_body">
        <table > 
          <tr>
            <td class=""> 应收金额</td> 
            <td class=""> <label>￥555</label></td> 

          </tr>
          <tr>
            <td class=""> 优惠信息</td> 
            <td class=""> <label>￥555</label></td> 

          </tr>

          <tr>
            <td class=""> 结算金额</td> 
            <td class=""> <label>￥555</label></td> 

          </tr>

          <tr>
            <td class=""> 备注</td> 
            <td class=""> <input  class="nui-textbox " style="width:100%;"/></td> 

          </tr>
        </table>
      </div> 
    </div>
    <div  class="vpanel" style="width:99%;height:auto;margin-left: auto;margin-right: auto;">
      <div class="vpanel_heading" style="background-color:#f3f4f6;color:#2d95ff;"><span>收银信息</span></div>
      <div class="vpanel_body">
        <table > 
         <tr>
          <td class=""> 储蓄卡</td> 
          <td class=""> <a class="nui-button" onclick=""   plain="false" >添加储蓄卡</a></td> 

          <tr>
            <td class=""> 收款方式</td> 
            <td class="">  <input  class="nui-combobox" /> <input  class="nui-textbox" /> <input  class="nui-textbox" /></td> 

          </tr>


          <tr>
            <td class=""> </td> 
            <td class="">  <a class="nui-button" onclick=""   plain="false" >添加收款方式</a></td> 

          </tr>
        </tr>
        <tr>
          <td class=""> 实收金额</td> 
          <td class=""> <label>￥555</label></td> 

        </tr>
        <tr>
          <td class=""> 收银优惠</td> 
          <td class=""> <label></label></td> 
          <td class=""> <div  class="nui-checkbox"  text="无限制" ></div></td> 

        </tr>

        <tr>
          <td class=""> 挂账金额</td> 
          <td class=""> <label>￥555</label></td> 

        </tr>


        <tr>
          <td class=""> 发票类型</td> 
          <td class=""> 
            <div  class="nui-checkbox"  text="不开票" ></div>
            <div  class="nui-checkbox"  text="增值税普通发票" ></div>
            <div  class="nui-checkbox"  text="增值税专用发票" ></div>
        </td> 

        </tr>
          <tr>
            <td class=""> 备注</td> 
            <td class=""> <input  class="nui-textbox " style="width:100%;"/></td> 

          </tr>
      </table>
    </div> 
  </div>

  <div style="width:100%;margin-top: 10px;">
    <a class="nui-button" onclick=""   plain="false" >收款</a>
    <a class="nui-button" onclick=""   plain="false" >结算</a>
    <a class="nui-button" onclick=""   plain="false" >打印</a>
    <a class="nui-button" onclick=""   plain="false" >退出</a>
  </div>
</div>
<script type="text/javascript">
 nui.parse();
</script>
</body>
</html>