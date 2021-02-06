<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8" session="false" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<!--
  - Author(s): Administrator
  - Date: 2018-12-03 18:34:32
  - Description:
-->
<head>
    <title>添加活动</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
    <script src="<%= request.getContextPath() %>/common/nui/nui.js" type="text/javascript"></script>
    <%@include file="/common/commonRepair.jsp"%>
    <script src="http://kindeditor.net/ke4/kindeditor-all-min.js?t=20160331.js" type="text/javascript"></script>
    <style type="text/css">
    html, body{
        margin:0px;padding:0px;border:0px;width:100%;height:100%;overflow:hidden;
    }
    .tbtext { 
        float: right;
        width: 90px;
        text-align: right;
    }
    .tbinput{
        width: 300px
    }

    *{padding: 0;margin: 0;}
    body {
        font: 12px/150% tahoma,arial,Microsoft YaHei,Hiragino Sans GB,"\u5b8b\u4f53",sans-serif;
        -webkit-font-smoothing: antialiased;
        color: #666;
        background: #fff;
    }
    a{text-decoration: none;}
    header{
        height: 45px;
        line-height: 45px;
        text-align: center;
        color: #fff;
        background-color: #ff9000;
        width: 100%;
        font-size: 1.1rem;
        position: absolute;
        top: 0;
    }
    .main{
        padding: 15px;
        margin-top: 50px;
    }
    .quan-item {
        width: 90%;
        position: relative;

        margin-bottom: 20px;
        height: auto;
        overflow: hidden;
        border: 1px solid #f1f1f1;
        background: #fff;
        font-family: "Microsoft YaHei";
    }
    .quan-item .q-type {
        float: right;
        width: 80%;
        padding: 5px 0;
    }
    .quan-item .q-price,.typ-txt {
        display: inline-block;
        display: block;
        color: #ff9000;
    }
    .quan-d-item .q-price {
        color: #ff9000;
        height: auto;
        overflow: hidden;
        padding: 5px 0;
    }
    .quan-item .q-price em {
        margin: 5px 0 0;
        font-family: verdana;
        font-size: 24px;
        font-style: normal;

    }
    .quan-item .q-price strong {
        margin: 0 10px 0 5px;
        font-size: 2rem;
        font-family: arial;
        _display: inline;
    }
    .quan-item .q-price .txt {
        line-height: 22px;
        font-size: 1rem;
    }

    .ftx-06, .ftx06 {
        color: #999;
    }
    .quan-item .q-range {
        color: #999;
    }
    .quan-item .q-price{
        display: -webkit-flex;
        display: flex;
        -webkit-align-items: center;
        align-items: center;
        -webkit-justify-content: center;
        justify-content: center;
    }
    .quan-item .q-price div.titles{
        flex:1;
    }
    .quan-d-item .q-opbtns {
        background: #ff9000;

    }
    .quan-item .q-opbtns {
        position: absolute;
        top: 0;
        bottom: 0;
        float: left;
        width: 15%;
        -webkit-writing-mode: vertical-lr;
        line-height: 25px;
        background: #ff9000;
        color: #fff;
        font-size: 1.2rem;
        /* padding: 0 15px; */
        height: 100%;
        display: -webkit-flex;
        display: flex;
        -webkit-align-items: center;
        align-items: center;
        -webkit-justify-content: center;
        justify-content: center;
        text-align: center;

    }

    .quan-item .q-opbtns::after {
        box-sizing: border-box;
        position: absolute;
        top: -3px;
        right: -3px;
        bottom: 0;
        content: "• • • • • • • • • • • • • • • • • • • • • • • • • • • • • • • • • • • • • • • • • • • • • • • • • • • • • • • • • • • • • • • • • • • • • • • • • • • • • • • • • • • • • • • • • • • • • • • • • • • • • • • • • • • • • • • • • • • • • • • • • • •";
        line-height: 10px;
        width: 7px;
        color: #fff;
        font-size: 18px;
        overflow: hidden;
        z-index: 1;
    }
    .useBtn{
        position: absolute;
        right: 10%;
        bottom: 10%;
    }
    .desc{font-size: 0.8rem;color: #ff9000;}
    .state {
        position: absolute;
        right: 2%;
        bottom: 1%;
        width: 69px;
        height: 69px;
        background: url(/Public/images/quan-state2.png) no-repeat;

    }
    .expired {
        color: #c3c3c3 !important;
    }
    .expired .q-price,.expired .typ-txt{
        color: #c3c3c3 !important;
    }
    .expired .q-opbtns{
        background-color: #c3c3c3;
    }
    .expired .state{
        background-position: 0 -83px;
    }
    .used .q-price,.used .typ-txt{
        color: #fa9899 !important;
    }
    .used .q-opbtns{
        background-color: #fa9899;
    }
    .used .state{
        background-position: 0 -241px;
    }
    .w {
        width: 98%;
        float: left;
        margin-top: 5px;
        margin-left: 2%;
    }
    .weui-icon-checked:before {
        display: block;
        content: "\EA08";
        color: #09bb07;
        font-size: 30px;
        position: absolute;
        right: 0;
        top: 10px;
    }
    .pagination {margin: 0px;}
    .footer {position:fixed; left:0px; bottom:0px; width:100%; height:50px;z-index:9999;}
    #main{
        height: auto;
        /* overflow: scroll; */
        margin-bottom: 50px;
    }


</style>
</head>
<body>

    <div class="nui-fit">
       <div class="nui-toolbar" style="padding:0px;">
        <table style="width:80%;">
            <tr>
                <td style="width:80%;">
                    <a class="nui-button" iconCls="" plain="true" onclick="onOk"><span class="fa fa-save fa-lg"></span>&nbsp;保存</a>
                    <a class="nui-button" iconCls="" plain="true" onclick="onCancel"><span class="fa fa-close fa-lg"></span>&nbsp;取消</a>
                </td>
            </tr>
        </table>
    </div>
    <div style="position: absolute;top:32px;right: 4px; width: 550px;height: 190px; ">

      <div class="" id="main">
<!--         <p>暂无记录</p>
-->
<div id="newslist">
  <div class="container">

     <nav class="text-center news-page hidden-xs" style="clear: both">
       <ul  id="example" class="pagination pagination-lg">
       </ul>
   </nav>
   <nav class="text-center news-page visible-xs">
    <ul class="pagination pagination-sm">

    </ul>
</nav>

</div>
</div>


</div>



</div>
<div class="nui-fit" id="form1">
  <table style="width:100%;line-height:30px;">
    <tr>
        <td class="tbtext"><label>卡券名称：</label></td>
        <td><input class="nui-textbox tbinput" name="title" style="" onvaluechanged="valueChanged(e)"></td>
    </tr>
    <tr>
        <td class="tbtext"><label>市场价：</label></td>
        <td><input class="nui-textbox tbinput" name="price" style="" onvaluechanged="valueChanged(e)"></td>
    </tr>
    <tr>
        <td class="tbtext"><label>库存：</label></td>
        <td><input class="nui-textbox tbinput" name="stock" style="" onvaluechanged="valueChanged(e)"></td>
    </tr>
    <tr>
        <td class="tbtext"><label>有效期天数：</label></td>
        <td><input class="nui-textbox tbinput" name="expireDate" style="" onvaluechanged="valueChanged(e)""></td>
    </tr>
    <tr>
        <td class="tbtext"><label>优惠说明：</label></td>
        <td><input class="nui-textbox tbinput" name="offerDesc"id="offerDesc" style="" onvaluechanged="valueChanged(e)"></td>
    </tr>
    <tr>
        <td class="tbtext"><label>适用说明：</label></td>
        <td><input class="nui-textbox tbinput" name="suitableDesc"id="suitableDesc" style="" onvaluechanged="valueChanged(e)"></td>
    </tr>
    <tr>
        <td class="tbtext"><label>自动审核：</label></td>
        <td colspan="3">
            <div id="" name="" class="mini-checkbox" readOnly="false" text="" onvaluechanged=""></div>
            <span style="margin-left: 30px;">可转送：
                <div id="" name="" class="mini-checkbox" readOnly="false" text="" onvaluechanged="" ></div>
            </span>
            <span style="margin-left: 30px;">领券中心：
                <div id="" name="" class="mini-checkbox" readOnly="false" text="" onvaluechanged="" ></div>
            </span>
        </td>
    </tr>
    
    <tr  style="height: 200px;">
        <td class="tbtext"><label>产品描述：</label></td>
        <td colspan="3">

         <div name="editor" id="editor1" rows="1000" cols="80" style="width:100%;height:200px;"></div>

     </td>
 </tr>

</table>
</div>
</div>
<script type="text/javascript">
   nui.parse();
   var editor1 = KindEditor.create('#editor1');
   var form = new nui.Form("form1");
setCouponData();
function valueChanged(e) {
    setCouponData();
}

function setCouponData() {
    var  v = form.getData();
    var list = '';
    $("#newslist .container >div").remove();
    console.dir(v);
    list += ' <div class="w" onclick="check(this)" data-index="'+v.id+'" data-title="'+v.title+'">\n' +
    '<div class="quan-item quan-d-item quan-item-acoupon ">\n' +
    '<div class="q-opbtns "> 优惠券</div><div class="q-type"><div class="q-price">\n' +
    '<div class="titles"><em>￥</em><strong class="num1">'+v.price+'</strong></div>\n' +
    '<div class="txt titles"> </div> </div><div class="q-range"><div class="typ-txt"> '+v.title+'' +
    '<br><span style=";width: 7rem;display: inline-block;">库存：'+v.stock+'</span>' +
    '<span style="">有效天数：'+v.expireDate+'</span></div><div class="range-item" style="margin-top: 10px;">' +
    '优惠说明：'+v.offerDesc+'</div><div class="range-item">适用说明：'+v.suitableDesc+'</div></div>\n' +
    '</div><span id="" class="check"></span></div></div>';

    $("#newslist .container").prepend(list);

}

</script>
</body>
</html>