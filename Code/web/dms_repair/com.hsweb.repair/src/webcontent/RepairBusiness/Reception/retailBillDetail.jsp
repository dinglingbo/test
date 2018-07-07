<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" session="false" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ include file="/common/sysCommon.jsp"%>

<html>
<!-- 
  - Author(s): Administrator
  - Date: 2018-07-02 19:02:07
  - Description: 
-->  
<head>
    <title>工单</title>
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
       <table style="left:0;right:0;margin: 0 auto;"> 
          <tr>   
            <td class="tbtext">销售期</td> 
            <td class="tbCtrl"><input  class="nui-textbox tabwidth" /></td>
        </tr>
        <tr>   
            <td class="tbCtrl" colspan="4"><input  class="nui-textbox tabwidth" /></td>
            <td class="tbtext">销售人员</td> 
            <td class="tbCtrl"><input  class="nui-textbox tabwidth" /></td>
            <td class="tbtext">业务分类</td> 
            <td class="tbCtrl"><input  class="nui-textbox tabwidth" /></td>

        </tr>
   

    </table>
    <div style="width:100%;margin-top: 10px;">
        <a class="nui-button" onclick=""   plain="false" >零售历史</a>
    </div>
    <div>
        <div id="datagrid1" class="nui-datagrid" showPager="false">
            <div property="columns">

                <div field="partName" width="100" headerAlign="center" align="center">材料名称</div>
                <div field="" width="100" headerAlign="center" align="center">业务分类</div>
                <div field="" width="100" headerAlign="center" align="center">工时</div>
                <div field="" width="100" headerAlign="center" align="center">单价</div>
                <div field="" width="100" headerAlign="center" align="center">工时费</div>
                <div field="" width="100" headerAlign="center" align="center">折扣</div>
                <div field="" width="100" headerAlign="center" align="center">折后金额</div>
                <div field="" width="100" headerAlign="center" align="center">库存</div>
                <div field="" width="100" headerAlign="center" align="center">领取</div>
                <div field="" width="100" headerAlign="center" align="center">领料人</div>
                <div field="" width="100" headerAlign="center" align="center">增项</div>
                <div field="" width="100" headerAlign="center" align="center">备注</div>
                <div field="" width="100" headerAlign="center" align="center">删除</div>
            </div>
        </div>
    </div>




    <table > 
        <tr>   
            <td class="tbtext">备注</td> 
            <td style="width: 700px" class="tbCtrl"><input  class="nui-textarea tabwidth" style="height: 100px;"/></td>


        </tr>

        <tr>   
            <td class="tbtext">应收总计</td> 
            <td  class="tbCtrl">￥0.00 =  材料费小计：￥0.00 </td>
     
        </tr>

    </table>
    <div style="width:100%;margin-top: 10px;text-align: center;">
        <a class="nui-button" onclick=""   plain="false" >保存</a>

        <a class="nui-button" onclick=""   plain="false" >价参</a>
        <a class="nui-button" onclick=""   plain="false" >退出</a>
    </div>

</div>
<script type="text/javascript">
 nui.parse();

        var grid = nui.get("datagrid1");
        grid.on("cellclick",function(e){
        var record = e.record;
        var column = e.column;
        if(column.field == "itemName"){
          try{
            nui.open({
              url : "com.hsweb.part.baseData.partDetail.flow",
              title : "添加工时",
              width : "600px",
              height : "400px",
              onload : function() {
                var iframe = this.getIFrameEl();
                iframe.contentWindow.setInitData();
              },
              ondestroy : function(action) {
              }
            });
          }finally{}
        }

      });   

</script>
</body>
</html>