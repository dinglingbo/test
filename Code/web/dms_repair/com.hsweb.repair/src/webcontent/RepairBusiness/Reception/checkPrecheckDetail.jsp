<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" session="false" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@include file="/common/sysCommon.jsp"%>

<html>
<!-- 
  - Author(s): Administrator
  - Date: 2018-07-02 20:50:20
  - Description:
-->     
<head>
  <title>接车预检单</title>
  <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
  <style type="text/css">
  body {  
   margin: 0; 
   padding: 0;
   border: 0;
   width: 100%;
   height: 100%;
   overflow: hidden;
 }


 table
 {

  left:0;right:0;margin: 0 auto;
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
    <h2>查车单</h2>

    <table > 
      <tr>   
        <td class="tbtext">进场日期</td> 
        <td class="tbCtrl"><input  class="nui-textbox tabwidth" /></td>
        <td class="tbtext">预计交车日期</td> 
        <td class="tbCtrl"><input  class="nui-textbox tabwidth" /></td>


      </tr>
      <tr>   
        <td class="tbtext">车主</td> 
        <td class="tbCtrl"><input  class="nui-textbox tabwidth" /></td>
        <td class="tbtext">车主电话</td> 
        <td class="tbCtrl"><input  class="nui-textbox tabwidth" /></td>
        <td class="tbtext">级别</td> 
        <td class="tbCtrl"><input  class="nui-textbox tabwidth" /></td>
        <td class="tbtext">会员卡</td> 
        <td class="tbCtrl"><input  class="nui-textbox tabwidth" /></td>

      </tr>
      <tr>   
        <td class="tbtext">车牌</td> 
        <td class="tbCtrl"><input  class="nui-textbox tabwidth" /></td>
        <td class="tbtext">品牌车型</td> 
        <td class="tbCtrl" colspan="3"><input  class="nui-textbox tabwidth" /></td>
        <td class="tbtext">VIN码</td> 
        <td class="tbCtrl"><input  class="nui-textbox tabwidth" /></td>

      </tr>
      <tr>
       <td class="tbtext">油量</td>
       <td class="tbCtrl"><input class="nui-textbox tabwidth" /></td>
       <td class="tbtext">当前里程</td>
       <td class="tbCtrl"><input  class="nui-textbox tabwidth" /></td>
       <td class="tbtext">下次保养</td>
       <td class="tbCtrl"><input  class="nui-textbox tabwidth" /></td>
       <td class="tbtext">下次保养日期</td>
       <td class="tbCtrl"><input class="nui-textbox tabwidth" /></td>


     </tr>
     <tr >
      <td class="tbtext">服务顾问</td>
      <td class="tbCtrl"><input  class="nui-textbox tabwidth" /></td>
      <td class="tbtext">服务技师</td>
      <td class="tbCtrl"><input  class="nui-textbox tabwidth" /></td>
      <td class="tbtext">送修人</td>
      <td class="tbCtrl"><input  class="nui-textbox tabwidth" /></td>
      <td class="tbtext">联系方式</td>
      <td class="tbCtrl"><input  class="nui-textbox tabwidth" /></td>
    </tr>

  </table>
  <div style="text-align:center;margin-top: 20px;">
    <h1 style="margin: 10px 0px 10px 0px;display: inline;">粤A89379检查表</h1>
  </div>
  <div  class="vpanel" style="width:99%;height:100px;margin-left: auto;margin-right: auto;">
    <div class="vpanel_heading" style="background-color:#f3f4f6;color:#2d95ff;"><span>车辆环视图</span></div>
    <div class="vpanel_body">
      <table > 
        <tr>
            <td class=""> <div  class="nui-checkbox"  text="备胎" ></div></td> 
            <td class=""> <div  class="nui-checkbox"  text="警示牌" ></div></td> 
            <td class=""> <div  class="nui-checkbox"  text="点烟器" ></div></td> 
            <td class=""> <div  class="nui-checkbox"  text="千斤顶" ></div></td> 
            <td class=""> <div  class="nui-checkbox"  text="灭火器" ></div></td> 
            <td class=""> <div  class="nui-checkbox"  text="工具" ></div></td> 
            <td class=""> <div  class="nui-checkbox"  text="烟灰缸" ></div></td> 
  
        </tr>
      </table>

      
    </div> 
  </div>
  <div  class="vpanel" style="width:99%;height:100px;margin-left: auto;margin-right: auto;">
    <div class="vpanel_heading" style="background-color:#f3f4f6;color:#2d95ff;"><span>随车物品</span></div>
    <div class="vpanel_body">
      <table > 
        <tr>
            <td class=""> <div  class="nui-checkbox"  text="备胎" ></div></td> 
            <td class=""> <div  class="nui-checkbox"  text="警示牌" ></div></td> 
            <td class=""> <div  class="nui-checkbox"  text="点烟器" ></div></td> 
            <td class=""> <div  class="nui-checkbox"  text="千斤顶" ></div></td> 
            <td class=""> <div  class="nui-checkbox"  text="灭火器" ></div></td> 
            <td class=""> <div  class="nui-checkbox"  text="工具" ></div></td> 
            <td class=""> <div  class="nui-checkbox"  text="烟灰缸" ></div></td> 
  
        </tr>
      </table>
    </div> 
  </div>
  <div  class="vpanel" style="width:99%;height:100px;margin-left: auto;margin-right: auto;">
    <div class="vpanel_heading" style="background-color:#f3f4f6;color:#2d95ff;"><span>警告灯状态</span></div>
    <div class="vpanel_body">
<label>外观清洁度</label>
    </div> 
  </div>
  <div  class="vpanel" style="width:99%;height:100px;margin-left: auto;margin-right: auto;">
    <div class="vpanel_heading" style="background-color:#f3f4f6;color:#2d95ff;"><span>车辆外观检查</span></div>
    <div class="vpanel_body">

    </div> 
  </div>
  <div  class="vpanel" style="width:99%;height:100px;margin-left: auto;margin-right: auto;">
    <div class="vpanel_heading" style="background-color:#f3f4f6;color:#2d95ff;"><span>客户描述</span></div>
    <div class="vpanel_body">

      <input  class="nui-textarea " style="width:100%;height: 100px;border:0px;" />
    </div> 
  </div>


  <div  class="vpanel" style="width:99%;height:100px;margin-left: auto;margin-right: auto;margin-top: 40px;"> 
    <div class="vpanel_heading" style="background-color:#f3f4f6;color:#2d95ff;"><span>检测照片</span></div>
    <div class="vpanel_body">


    </div> 
  </div>

  <div style="width:100%;margin-top: 10px;">
    <a class="nui-button" onclick=""   plain="false" >保存</a>
    <a class="nui-button" onclick=""   plain="false" >退出</a>
  </div>
</div>
<script type="text/javascript">
 nui.parse();
</script>
</body>
</html>