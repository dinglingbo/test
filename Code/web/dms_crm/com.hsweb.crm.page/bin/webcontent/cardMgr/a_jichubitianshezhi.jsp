<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8" session="false" %>
<%@ include file="/common/sysCommon.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<!--
  - Author(s): Administrator
  - Date: 2018-03-21 09:13:58
  - Description:
--> 
<head>
  <title>必填参数设置
  </title>
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
    font-family: "微软雅黑";
}

.red{
    /* color: red; */ 
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
    width: 60px;
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
    font-size:16px;
    font-weight:normal;
}
.vpanel_bodyww{
    padding : 10 10 10 10px !important

}




</style>
</head>
<body>

<div class="nui-fit" id= "form1">
    <input id="creatorId" name="creatorId" class="nui-hidden" />

    <div class="vpanel" style="width:1250px;height:auto;">
        <div class="vpanel_heading" style="background-color:#f3f4f6;color:#2d95ff;"><span>新建车辆操作</span></div>
        <div class="vpanel_body vpanel_bodyww">
         <table class="tmargin">
         <tr class="htr">
             <td class="red right fwidtha">车身颜色必填：</td>
             <td class="bt_trWidth"><div class="nui-checkbox"></div></td>
             <td class="red right fwidthb">VIN码必填：</td>
             <td class="bt_trWidth"><div class="nui-checkbox" ></div></td>
             <td class="red right fwidthb">车辆分类必填：</td>
             <td class="bt_trWidth"><div class="nui-checkbox"></div></td>
             <td class="red right fwidthb">发动机号必填：</td>
             <td class="bt_trWidth"><div class="nui-checkbox"></div></td>
              <td class="red right fwidthb">保险公司必填：</td>
             <td class="bt_trWidth"><div class="nui-checkbox"></div></td>
         </tr>         
         <tr class="htr">
             <td class="red right fwidtha">商业险到期日必填：</td>
             <td class="bt_trWidth"><div class="nui-checkbox"></div></td>
             <td class="red right fwidthb">交强险到期日必填：</td>
             <td class="bt_trWidth"><div class="nui-checkbox" ></div></td>
             <td class="red right fwidthb">车辆年检到期日必填：</td>
             <td class="bt_trWidth"><div class="nui-checkbox"></div></td>
             <td class="red right fwidthb">建档人必填：</td>
             <td class="bt_trWidth"><div class="nui-checkbox"></div></td>
         </tr>

     </table>
 </div>
</div>

    <div class="vpanel" style="width:1250px;height:auto;">
        <div class="vpanel_heading" style="background-color:#f3f4f6;color:#2d95ff;"><span>新建客户操作</span></div>
        <div class="vpanel_body vpanel_bodyww">
         <table class="tmargin">
         <tr class="htr">
             <td class="red right fwidtha">客户手机号码必填：</td>
             <td class="bt_trWidth"><div class="nui-checkbox"></div></td>
             <td class="red right fwidthb">客户性别必填：</td>
             <td class="bt_trWidth"><div class="nui-checkbox" ></div></td>
             <td class="red right fwidthb">车主证件号必填：</td>
             <td class="bt_trWidth"><div class="nui-checkbox"></div></td>
             <td class="red right fwidthb">客户级别必填：</td>
             <td class="bt_trWidth"><div class="nui-checkbox"></div></td>
              <td class="red right fwidthb">客户类型必填：</td>
             <td class="bt_trWidth"><div class="nui-checkbox"></div></td>
         </tr>         
         <tr class="htr">
             <td class="red right fwidtha">客户来源必填：</td>
             <td class="bt_trWidth"><div class="nui-checkbox"></div></td>
             <td class="red right fwidthb">会员号必填：</td>
             <td class="bt_trWidth"><div class="nui-checkbox" ></div></td>
             <td class="red right fwidthb">所在地区必填：</td>
             <td class="bt_trWidth"><div class="nui-checkbox"></div></td>
             <td class="red right fwidthb">详细地址必填：</td>
             <td class="bt_trWidth"><div class="nui-checkbox"></div></td>
         </tr>

     </table>
 </div>
</div>

    <div class="vpanel" style="width:1250px;height:auto;">
        <div class="vpanel_heading" style="background-color:#f3f4f6;color:#2d95ff;"><span>材料信息操作</span></div>
        <div class="vpanel_body vpanel_bodyww">
         <table class="tmargin">
         <tr class="htr">
             <td class="red right fwidtha">材料编码必填：</td>
             <td class="bt_trWidth"><div class="nui-checkbox"></div></td>
             <td class="red right fwidthb">业务分类必填：</td>
             <td class="bt_trWidth"><div class="nui-checkbox" ></div></td>
             <td class="red right fwidthb">零件号必填:</td>
             <td class="bt_trWidth"><div class="nui-checkbox"></div></td>
             <td class="red right fwidthb">参考调拨价必填：</td>
             <td class="bt_trWidth"><div class="nui-checkbox"></div></td>
              <td class="red right fwidthb">适用车型必填：</td>
             <td class="bt_trWidth"><div class="nui-checkbox"></div></td>
         </tr>         
         <tr class="htr">
             <td class="red right fwidtha">云材料使用必填：</td>
             <td class="bt_trWidth"><div class="nui-checkbox"></div></td>
             <td class="red right fwidthb">审核新建材料必填：</td>
             <td class="bt_trWidth"><div class="nui-checkbox" ></div></td>
             <td class="red right fwidthb">品牌必填：</td>
             <td class="bt_trWidth"><div class="nui-checkbox"></div></td>
             <td class="red right fwidthb">规格型号必填：</td>
             <td class="bt_trWidth"><div class="nui-checkbox"></div></td>
                          <td class="red right fwidthb">OE编码按：</td>
             <td class="bt_trWidth"><div class="nui-checkbox"></div></td>
         </tr>

         <tr class="htr">
             <td class="red right fwidtha">安全库存必填：</td>
             <td class="bt_trWidth"><div class="nui-checkbox"></div></td>
             <td class="red right fwidthb">供应商必填：</td>
             <td class="bt_trWidth"><div class="nui-checkbox" ></div></td>
         </tr>

     </table>
 </div>
</div>

    <div class="vpanel" style="width:1250px;height:auto;">
        <div class="vpanel_heading" style="background-color:#f3f4f6;color:#2d95ff;"><span>项目信息操作</span></div>
        <div class="vpanel_body vpanel_bodyww">
         <table class="tmargin">
         <tr class="htr">
             <td class="red right fwidtha">云项目使用：</td>
             <td class="bt_trWidth"><div class="nui-checkbox"></div></td>
         </tr>         
     </table>
 </div>
</div>

    <div class="vpanel" style="width:1250px;height:auto;">
        <div class="vpanel_heading" style="background-color:#f3f4f6;color:#2d95ff;"><span>工单新建/修改操作</span></div>
        <div class="vpanel_body vpanel_bodyww">
         <table class="tmargin">
         <tr class="htr">
             <td class="red right fwidtha">交车时间必填：</td>
             <td class="bt_trWidth"><div class="nui-checkbox"></div></td>
             <td class="red right fwidthb">维修类型必填：</td>
             <td class="bt_trWidth"><div class="nui-checkbox" ></div></td>
             <td class="red right fwidthb">当前里程必填：</td>
             <td class="bt_trWidth"><div class="nui-checkbox"></div></td>
             <td class="red right fwidthb">下次保养里程必填：</td>
             <td class="bt_trWidth"><div class="nui-checkbox"></div></td>
              <td class="red right fwidthb">保养日期必填：</td>
             <td class="bt_trWidth"><div class="nui-checkbox"></div></td>
         </tr>         
         <tr class="htr">
             <td class="red right fwidtha">快捷出库必填：</td>
             <td class="bt_trWidth"><div class="nui-checkbox"></div></td>
             <td class="red right fwidthb">快捷入库必填：</td>
             <td class="bt_trWidth"><div class="nui-checkbox" ></div></td>
             <td class="red right fwidthb">销售业务分类必填：</td>
             <td class="bt_trWidth"><div class="nui-checkbox"></div></td>
             <td class="red right fwidthb">来电途径必填：</td>
             <td class="bt_trWidth"><div class="nui-checkbox"></div></td>
                      <td class="red right fwidthb">一车多工单：</td>
             <td class="bt_trWidth"><div class="nui-checkbox"></div></td>
         </tr>
         <tr class="htr">
             <td class="red right fwidtha">送修人必填：</td>
             <td class="bt_trWidth"><div class="nui-checkbox"></div></td>
             <td class="red right fwidthb">服务顾问必填：</td>
             <td class="bt_trWidth"><div class="nui-checkbox" ></div></td>
         </tr>
     </table>
 </div>
</div>

    <div class="vpanel" style="width:1250px;height:auto;">
        <div class="vpanel_heading" style="background-color:#f3f4f6;color:#2d95ff;"><span>查车单新建/修改操作</span></div>
        <div class="vpanel_body vpanel_bodyww">
         <table class="tmargin">
         <tr class="htr">
             <td class="red right fwidtha">油量必填：</td>
             <td class="bt_trWidth"><div class="nui-checkbox"></div></td>
             <td class="red right fwidthb">当前里程必填：</td>
             <td class="bt_trWidth"><div class="nui-checkbox" ></div></td>
             <td class="red right fwidthb">下次保养里程必填：</td>
             <td class="bt_trWidth"><div class="nui-checkbox"></div></td>
             <td class="red right fwidthb">下次保养日期必填：</td>
             <td class="bt_trWidth"><div class="nui-checkbox"></div></td>
 </tr>  
     </table>
 </div>
</div>

    <div class="vpanel" style="width:1250px;height:auto;">
        <div class="vpanel_heading" style="background-color:#f3f4f6;color:#2d95ff;"><span>预检单新建/修改操作</span></div>
        <div class="vpanel_body vpanel_bodyww">
         <table class="tmargin">
         <tr class="htr">
             <td class="red right fwidtha">油量必填：</td>
             <td class="bt_trWidth"><div class="nui-checkbox"></div></td>
             <td class="red right fwidthb">当前里程必填：</td>
             <td class="bt_trWidth"><div class="nui-checkbox" ></div></td>
             <td class="red right fwidthb">下次保养里程必填：</td>
             <td class="bt_trWidth"><div class="nui-checkbox"></div></td>
             <td class="red right fwidthb">下次保养日期必填：</td>
             <td class="bt_trWidth"><div class="nui-checkbox"></div></td>
 </tr>       

     </table>
 </div>
</div>


</div>
<script type="text/javascript">
    nui.parse();
</script>
</body>
</html>