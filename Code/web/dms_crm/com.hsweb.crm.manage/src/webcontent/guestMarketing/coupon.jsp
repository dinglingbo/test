<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8" session="false" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<!-- 
  - Author(s): Administrator
  - Date: 2018-12-05 18:34:59
  - Description:
-->
<head>
  <title>优惠券</title>
  <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
  <script src="<%= request.getContextPath() %>/common/nui/nui.js" type="text/javascript"></script>
  <link rel="stylesheet" href="https://cdn.bootcss.com/weui/1.1.2/style/weui.min.css">
  <style type="text/css">
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
    width: 47%;
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



<script type="text/javascript">
 nui.parse();

 var data = {
  "total": 4,
  "rows": [
  {
    "id": "33157",
    "title": "优惠100",
    "price": "0.11",
    "price_market": "0.00",
    "integral": "0.00",
    "member_price": "0.00",
    "detail": "<p>回家第三季度实际</p>",
    "remark": null,
    "thumb": "",
    "pic": "",
    "images": null,
    "stock": "98",
    "buy_num": null,
    "delivery": null,
    "start_time": "0",
    "end_time": "0",
    "offer_desc": "",
    "suitable_desc": "",
    "identify": "SP1201812040002",
    "store_id": null,
    "type": "2",
    "cat_id": null,
    "category_id": null,
    "category_name": null,
    "status": "1",
    "cid": "1",
    "recommond": "0",
    "can_give": "1",
    "times": "0",
    "use_times": "0",
    "expire_date": "10",
    "isdel": "0",
    "isaudit": "1",
    "auditname": "qpcs",
    "audittime": "2018-12-04",
    "is_convert": "0",
    "score": "0.0",
    "favorable_rate": "0.00",
    "voter": "0",
    "sales_count": "0",
    "is_ratify": "1",
    "is_newsdiscount": "0",
    "is_sales": "0",
    "shared_num": "0",
    "read_num": "0",
    "norm": null,
    "is_coupon_center": "1",
    "send_num": "1",
    "send_percent": "1",
    "add_time": "1543946161",
    "update_time": "1543946300",
    "statement": null
  },
  {
    "id": "33150",
    "title": "深度刹车保养",
    "price": "0.01",
    "price_market": "450.00",
    "integral": "0.00",
    "member_price": "0.01",
    "detail": "<p style=\"margin-top: 0px; margin-bottom: 0px; white-space: normal; word-break: break-all; overflow-wrap: break-word; padding: 0px; color: rgb(102, 102, 102); line-height: 1.6; text-align: justify;\"><span style=\"font-family: 微软雅黑, &quot;Microsoft YaHei&quot;; font-size: 18px;\">刹车作为汽车安全系统里至关重要的部分，保证刹车的正常，才能保证出行的安全。所以，刹车的日常保养是必须要非常重视的。</span></p><p style=\"margin-top: 0px; margin-bottom: 0px; font-size: 0.3rem; white-space: normal; word-break: break-all; overflow-wrap: break-word; padding: 0px; color: rgb(102, 102, 102); line-height: 1.6; text-align: justify; font-family: &quot;Hiragino Sans GB&quot;, &quot;Helvetica Neue&quot;, Helvetica, STHeiTi, &quot;Microsoft Yahei&quot;, sans-serif;\"><img src=\"http://wx.baisyi.net/Uploads/UMeditor/20180906/5b90eda773fc5.jpg\"/></p><p style=\"margin-top: 0px; margin-bottom: 0px; white-space: normal; word-break: break-all; overflow-wrap: break-word; padding: 0px; color: rgb(102, 102, 102); line-height: 1.6; text-align: justify;\"><span style=\"font-weight: 700; word-break: break-all; overflow-wrap: break-word;\"><span style=\"font-family: 微软雅黑, &quot;Microsoft YaHei&quot;; font-size: 18px;\">为什么要做刹车深度保养？<span style=\"word-break: break-all; overflow-wrap: break-word;\"></span></span></span></p><p style=\"margin-top: 0px; margin-bottom: 0px; white-space: normal; word-break: break-all; overflow-wrap: break-word; padding: 0px; color: rgb(102, 102, 102); line-height: 1.6; text-align: justify;\"><span style=\"font-family: 微软雅黑, &quot;Microsoft YaHei&quot;; font-size: 18px;\"><span style=\"word-break: break-all; overflow-wrap: break-word;\">1.</span>刹车系统是汽车最重要的部件，事关行车安全；<span style=\"word-break: break-all; overflow-wrap: break-word;\"></span></span></p><p style=\"margin-top: 0px; margin-bottom: 0px; white-space: normal; word-break: break-all; overflow-wrap: break-word; padding: 0px; color: rgb(102, 102, 102); line-height: 1.6; text-align: justify;\"><span style=\"font-family: 微软雅黑, &quot;Microsoft YaHei&quot;; font-size: 18px;\"><span style=\"word-break: break-all; overflow-wrap: break-word;\">2.</span>刹车油含水量超标、导致刹车距离延长、刹车偏软；<span style=\"word-break: break-all; overflow-wrap: break-word;\"></span></span></p><p style=\"margin-top: 0px; margin-bottom: 0px; white-space: normal; word-break: break-all; overflow-wrap: break-word; padding: 0px; color: rgb(102, 102, 102); line-height: 1.6; text-align: justify;\"><span style=\"font-family: 微软雅黑, &quot;Microsoft YaHei&quot;; font-size: 18px;\"><span style=\"word-break: break-all; overflow-wrap: break-word;\">3.</span>刹车系统摩擦面常被油污、粉尘粘附，致使摩擦系数降低，刹车距离延长，严重会导致刹车失灵；<span style=\"word-break: break-all; overflow-wrap: break-word;\"></span></span></p><p style=\"margin-top: 0px; margin-bottom: 0px; white-space: normal; word-break: break-all; overflow-wrap: break-word; padding: 0px; color: rgb(102, 102, 102); line-height: 1.6; text-align: justify;\"><span style=\"font-family: 微软雅黑, &quot;Microsoft YaHei&quot;; font-size: 18px;\"><span style=\"word-break: break-all; overflow-wrap: break-word;\">4.</span>刹车分泵活动部位容易产生油污，导致刹车分泵活动部位卡滞，产生偏磨及拖刹现象，致使刹车效率降低，严重会导致刹车失灵；<span style=\"word-break: break-all; overflow-wrap: break-word;\"></span></span></p><p style=\"margin-top: 0px; margin-bottom: 0px; white-space: normal; word-break: break-all; overflow-wrap: break-word; padding: 0px; color: rgb(102, 102, 102); line-height: 1.6; text-align: justify;\"><span style=\"font-family: 微软雅黑, &quot;Microsoft YaHei&quot;; font-size: 18px;\"><span style=\"word-break: break-all; overflow-wrap: break-word;\">5.</span>汽车行驶一段时间后，轴头部位会产生腐蚀和高温咬死现象，<span style=\"word-break: break-all; overflow-wrap: break-word;\">9</span>成以上车辆都会产生轮胎难于拆卸，从而会导致轮胎螺丝断裂的危险。</span><span style=\"font-family: &quot;Hiragino Sans GB&quot;, &quot;Helvetica Neue&quot;, Helvetica, STHeiTi, &quot;Microsoft Yahei&quot;, sans-serif; font-size: 0.3rem;\"><span style=\"word-break: break-all; overflow-wrap: break-word;\"></span></span></p><p style=\"margin-top: 0px; margin-bottom: 0px; font-size: 0.3rem; white-space: normal; word-break: break-all; overflow-wrap: break-word; padding: 0px; color: rgb(102, 102, 102); line-height: 1.6; text-align: justify; font-family: &quot;Hiragino Sans GB&quot;, &quot;Helvetica Neue&quot;, Helvetica, STHeiTi, &quot;Microsoft Yahei&quot;, sans-serif;\"><span style=\"word-break: break-all; overflow-wrap: break-word;\">&nbsp;<img src=\"http://wx.baisyi.net/Uploads/UMeditor/20180906/5b90edfc94659.jpg\"/></span></p><p style=\"margin-top: 0px; margin-bottom: 0px; white-space: normal; word-break: break-all; overflow-wrap: break-word; padding: 0px; color: rgb(102, 102, 102); line-height: 1.6; text-align: justify;\"><span style=\"font-family: 微软雅黑, &quot;Microsoft YaHei&quot;; font-size: 18px;\"><span style=\"font-weight: 700; word-break: break-all; overflow-wrap: break-word;\">刹车系统保养<span style=\"word-break: break-all; overflow-wrap: break-word;\">5</span></span><span style=\"font-weight: 700; word-break: break-all; overflow-wrap: break-word;\">大标准<span style=\"word-break: break-all; overflow-wrap: break-word;\"></span></span></span></p><p style=\"margin-top: 0px; margin-bottom: 0px; white-space: normal; word-break: break-all; overflow-wrap: break-word; padding: 0px; color: rgb(102, 102, 102); line-height: 1.6; text-align: justify;\"><span style=\"font-family: 微软雅黑, &quot;Microsoft YaHei&quot;; font-size: 18px;\"><span style=\"word-break: break-all; overflow-wrap: break-word;\">1.</span>更换刹车油时做；<span style=\"word-break: break-all; overflow-wrap: break-word;\"></span></span></p><p style=\"margin-top: 0px; margin-bottom: 0px; white-space: normal; word-break: break-all; overflow-wrap: break-word; padding: 0px; color: rgb(102, 102, 102); line-height: 1.6; text-align: justify;\"><span style=\"font-family: 微软雅黑, &quot;Microsoft YaHei&quot;; font-size: 18px;\"><span style=\"word-break: break-all; overflow-wrap: break-word;\">2.</span>轮胎难于拆卸轴头生锈时；<span style=\"word-break: break-all; overflow-wrap: break-word;\"></span></span></p><p style=\"margin-top: 0px; margin-bottom: 0px; white-space: normal; word-break: break-all; overflow-wrap: break-word; padding: 0px; color: rgb(102, 102, 102); line-height: 1.6; text-align: justify;\"><span style=\"font-family: 微软雅黑, &quot;Microsoft YaHei&quot;; font-size: 18px;\"><span style=\"word-break: break-all; overflow-wrap: break-word;\">3.</span>刹车有异响；<span style=\"word-break: break-all; overflow-wrap: break-word;\"></span></span></p><p style=\"margin-top: 0px; margin-bottom: 0px; white-space: normal; word-break: break-all; overflow-wrap: break-word; padding: 0px; color: rgb(102, 102, 102); line-height: 1.6; text-align: justify;\"><span style=\"font-family: 微软雅黑, &quot;Microsoft YaHei&quot;; font-size: 18px;\"><span style=\"word-break: break-all; overflow-wrap: break-word;\">4.</span>有偏刹或拖刹时；<span style=\"word-break: break-all; overflow-wrap: break-word;\"></span></span></p><p style=\"margin-top: 0px; margin-bottom: 0px; white-space: normal; word-break: break-all; overflow-wrap: break-word; padding: 0px; color: rgb(102, 102, 102); line-height: 1.6; text-align: justify;\"><span style=\"font-family: 微软雅黑, &quot;Microsoft YaHei&quot;; font-size: 18px;\"><span style=\"word-break: break-all; overflow-wrap: break-word;\">5.</span>更换或保养刹车碟、刹车皮、刹车分泵时。</span><span style=\"font-family: &quot;Hiragino Sans GB&quot;, &quot;Helvetica Neue&quot;, Helvetica, STHeiTi, &quot;Microsoft Yahei&quot;, sans-serif; font-size: 0.3rem;\"><span style=\"word-break: break-all; overflow-wrap: break-word;\"></span></span></p><p style=\"margin-top: 0px; margin-bottom: 0px; font-size: 0.3rem; white-space: normal; word-break: break-all; overflow-wrap: break-word; padding: 0px; color: rgb(102, 102, 102); line-height: 1.6; text-align: justify; font-family: &quot;Hiragino Sans GB&quot;, &quot;Helvetica Neue&quot;, Helvetica, STHeiTi, &quot;Microsoft Yahei&quot;, sans-serif;\"><span style=\"word-break: break-all; overflow-wrap: break-word;\">&nbsp;<img src=\"http://wx.baisyi.net/Uploads/UMeditor/20180906/5b90ee0dd791f.jpg\"/></span></p><p style=\"margin-top: 0px; margin-bottom: 0px; white-space: normal; word-break: break-all; overflow-wrap: break-word; padding: 0px; color: rgb(102, 102, 102); line-height: 1.6; text-align: justify;\"><span style=\"font-weight: 700; word-break: break-all; overflow-wrap: break-word;\"><span style=\"font-family: 微软雅黑, &quot;Microsoft YaHei&quot;; font-size: 18px;\">刹车深度保养的好处<span style=\"word-break: break-all; overflow-wrap: break-word;\"></span></span></span></p><p style=\"margin-top: 0px; margin-bottom: 0px; white-space: normal; word-break: break-all; overflow-wrap: break-word; padding: 0px; color: rgb(102, 102, 102); line-height: 1.6; text-align: justify;\"><span style=\"font-family: 微软雅黑, &quot;Microsoft YaHei&quot;; font-size: 18px;\"><span style=\"word-break: break-all; overflow-wrap: break-word;\">1.</span>清洁刹车系统油污及粉尘；<span style=\"word-break: break-all; overflow-wrap: break-word;\"></span></span></p><p style=\"margin-top: 0px; margin-bottom: 0px; white-space: normal; word-break: break-all; overflow-wrap: break-word; padding: 0px; color: rgb(102, 102, 102); line-height: 1.6; text-align: justify;\"><span style=\"font-family: 微软雅黑, &quot;Microsoft YaHei&quot;; font-size: 18px;\"><span style=\"word-break: break-all; overflow-wrap: break-word;\">2.</span>预防汽车轮毂生锈腐蚀，防止刹车卡死，让轮胎拆卸更加自如；<span style=\"word-break: break-all; overflow-wrap: break-word;\"></span></span></p><p style=\"margin-top: 0px; margin-bottom: 0px; white-space: normal; word-break: break-all; overflow-wrap: break-word; padding: 0px; color: rgb(102, 102, 102); line-height: 1.6; text-align: justify;\"><span style=\"font-family: 微软雅黑, &quot;Microsoft YaHei&quot;; font-size: 18px;\"><span style=\"word-break: break-all; overflow-wrap: break-word;\">3.</span>润滑刹车分泵及其活动轴，消除刹车噪音和异响，减少磨损；<span style=\"word-break: break-all; overflow-wrap: break-word;\"></span></span></p><p style=\"margin-top: 0px; margin-bottom: 0px; white-space: normal; word-break: break-all; overflow-wrap: break-word; padding: 0px; color: rgb(102, 102, 102); line-height: 1.6; text-align: justify;\"><span style=\"font-family: 微软雅黑, &quot;Microsoft YaHei&quot;; font-size: 18px;\"><span style=\"word-break: break-all; overflow-wrap: break-word;\">4.</span>提升刹车灵敏度，让驾驶更安全；<span style=\"word-break: break-all; overflow-wrap: break-word;\"></span></span></p><p style=\"margin-top: 0px; margin-bottom: 0px; white-space: normal; word-break: break-all; overflow-wrap: break-word; padding: 0px; color: rgb(102, 102, 102); line-height: 1.6; text-align: justify;\"><span style=\"font-family: 微软雅黑, &quot;Microsoft YaHei&quot;; font-size: 18px;\"><span style=\"word-break: break-all; overflow-wrap: break-word;\">5.</span>涂抹耐高温材料，耐高温达<span style=\"word-break: break-all; overflow-wrap: break-word;\">1100</span>度。预防轮胎高温咬死（烧结），便于轮胎拆卸。</span><span style=\"font-family: &quot;Hiragino Sans GB&quot;, &quot;Helvetica Neue&quot;, Helvetica, STHeiTi, &quot;Microsoft Yahei&quot;, sans-serif; font-size: 0.3rem;\"><span style=\"word-break: break-all; overflow-wrap: break-word;\"></span></span></p><p style=\"margin-top: 0px; margin-bottom: 0px; font-size: 0.3rem; white-space: normal; word-break: break-all; overflow-wrap: break-word; padding: 0px; color: rgb(102, 102, 102); line-height: 1.6; text-align: justify; font-family: &quot;Hiragino Sans GB&quot;, &quot;Helvetica Neue&quot;, Helvetica, STHeiTi, &quot;Microsoft Yahei&quot;, sans-serif;\"><img src=\"http://wx.baisyi.net/Uploads/UMeditor/20180906/5b90eec9858bb.jpg\"/></p><p><br/></p>",
    "remark": "",
    "thumb": "/Uploads/1/images/20181122/thumb_5bf5847a76774.jpg",
    "pic": "/Uploads/1/images/20181122/5bf5847a76774.jpg",
    "images": "/Uploads/1/images/20181122/thumb_5bf584783a711.jpg",
    "stock": "483583",
    "buy_num": "10000",
    "delivery": "2",
    "start_time": "1536224333",
    "end_time": "1567760333",
    "offer_desc": "",
    "suitable_desc": "1.刹车片维护2.刹车油更换3.四轮定位4.四轮动平衡",
    "identify": "GN210201809060002",
    "store_id": null,
    "type": "2",
    "cat_id": "6",
    "category_id": "6",
    "category_name": "汽车保养",
    "status": "1",
    "cid": "1",
    "recommond": "1",
    "can_give": "1",
    "times": "1",
    "use_times": "0",
    "expire_date": "365",
    "isdel": "0",
    "isaudit": "1",
    "auditname": "麻涛",
    "audittime": "2018-10-07",
    "is_convert": "0",
    "score": "0.0",
    "favorable_rate": "0.00",
    "voter": "0",
    "sales_count": "25",
    "is_ratify": "1",
    "is_newsdiscount": "1",
    "is_sales": "1",
    "shared_num": "0",
    "read_num": "0",
    "norm": "{\"name\":[\"深度刹车保养\"],\"number\":[\"1\"],\"expire\":[\"365\"]}",
    "is_coupon_center": "1",
    "send_num": "145",
    "send_percent": "0",
    "add_time": "1536542113",
    "update_time": "1543945720",
    "statement": ""
  },
  {
    "id": "32957",
    "title": "空调清洗",
    "price": "388.00",
    "price_market": "488.00",
    "integral": "0.00",
    "member_price": "200.00",
    "detail": "<p><img src=\"http://wx.baisyi.com/Uploads/UMeditor/20180730/5b5ed6da81443.jpg\" style=\"\"/></p><p><img src=\"http://wx.baisyi.com/Uploads/UMeditor/20180730/5b5ed6e0d9b38.jpg\" style=\"\"/></p><p><br/></p><p><img src=\"http://wx.baisyi.com/Uploads/UMeditor/20180730/5b5ed8a318948.jpg\" style=\"\"/></p><p><img src=\"http://wx.baisyi.com/Uploads/UMeditor/20180730/5b5ed8a933cd7.jpg\" style=\"\"/></p><p></p><p><img src=\"http://wx.baisyi.com/Uploads/UMeditor/20180730/5b5ed85d12d10.jpg\" style=\"\"/></p><p><img src=\"http://wx.baisyi.com/Uploads/UMeditor/20180730/5b5ed85f5c9d0.jpg\" style=\"\"/></p><p></p><p><img src=\"http://wx.baisyi.com/Uploads/UMeditor/20180730/5b5ed7044799b.jpg\" style=\"\"/></p><p><br/></p>",
    "remark": "",
    "thumb": "/Uploads/images/20180911/thumb_5b97b24f92d22.jpg",
    "pic": "/Uploads/images/20180911/5b97b24f92d22.jpg",
    "images": "/Uploads/images/20180911/thumb_5b97b25156c19.png",
    "stock": "9944",
    "buy_num": "9999",
    "delivery": "2",
    "start_time": "1532880000",
    "end_time": "1564502399",
    "offer_desc": "",
    "suitable_desc": "",
    "identify": "GN201807300001",
    "store_id": null,
    "type": "2",
    "cat_id": "336",
    "category_id": "336",
    "category_name": "洗车美容",
    "status": "1",
    "cid": "1",
    "recommond": "1",
    "can_give": "1",
    "times": "1",
    "use_times": "0",
    "expire_date": "365",
    "isdel": "0",
    "isaudit": "1",
    "auditname": "殷亮",
    "audittime": "2018-11-08",
    "is_convert": "0",
    "score": "0.0",
    "favorable_rate": "0.00",
    "voter": "0",
    "sales_count": "0",
    "is_ratify": "1",
    "is_newsdiscount": "1",
    "is_sales": "1",
    "shared_num": "0",
    "read_num": "0",
    "norm": "{\"name\":[\"空调清洗\"],\"number\":[\"1\"],\"expire\":[\"365\"]}",
    "is_coupon_center": "0",
    "send_num": "38",
    "send_percent": "0",
    "add_time": "1536542108",
    "update_time": "1543946006",
    "statement": ""
  },
  {
    "id": "32930",
    "title": "零公里机油-合成合金装甲5W-40 4L",
    "price": "500.00",
    "price_market": "680.00",
    "integral": "0.00",
    "member_price": "270.00",
    "detail": "<p><img src=\"http://wx.baisyi.com/Uploads/UMeditor/20180718/5b4f0104538fb.jpg\" style=\"\"/></p><p><img src=\"http://wx.baisyi.com/Uploads/UMeditor/20180718/5b4f010a701f2.jpg\" style=\"\"/></p><p><img src=\"http://wx.baisyi.com/Uploads/UMeditor/20180718/5b4f011038d25.jpg\" style=\"\"/></p><p><img src=\"http://wx.baisyi.com/Uploads/UMeditor/20180718/5b4f0351e6838.jpg\"/></p><p><img src=\"http://wx.baisyi.com/Uploads/UMeditor/20180718/5b4f0114c7853.jpg\" style=\"\"/></p><p><img src=\"http://wx.baisyi.com/Uploads/UMeditor/20180718/5b4f0119bb74e.jpg\" style=\"\"/></p><p><img src=\"http://wx.baisyi.com/Uploads/UMeditor/20180718/5b4f011f9067c.jpg\" style=\"\"/></p><p><img src=\"http://wx.baisyi.com/Uploads/UMeditor/20180718/5b4f0124e60da.jpg\" style=\"\"/></p><p><img src=\"http://wx.baisyi.com/Uploads/UMeditor/20180718/5b4f013314eea.png\" style=\"\"/></p><p><img src=\"http://wx.baisyi.com/Uploads/UMeditor/20180718/5b4f013ac2bb4.png\" style=\"\"/></p><p><img src=\"http://wx.baisyi.com/Uploads/UMeditor/20180718/5b4f0142c6fc1.png\" style=\"\"/></p><p><img src=\"http://wx.baisyi.com/Uploads/UMeditor/20180718/5b4f014a64331.jpg\" style=\"\"/></p><p><br/></p>",
    "remark": "",
    "thumb": "/Uploads/images/20180911/thumb_5b97b34a696c3.jpg",
    "pic": "/Uploads/images/20180911/5b97b34a696c3.jpg",
    "images": "/Uploads/images/20180911/thumb_5b97b34c78011.jpg",
    "stock": "98",
    "buy_num": "9999",
    "delivery": "2",
    "start_time": "1531843200",
    "end_time": "1563465599",
    "offer_desc": "",
    "suitable_desc": "包含保养工时费、检测费及4升对等机油，不包含机油格、空气格。",
    "identify": "GN201807180003",
    "store_id": null,
    "type": "2",
    "cat_id": "338",
    "category_id": "338",
    "category_name": "保养快修",
    "status": "1",
    "cid": "1",
    "recommond": "1",
    "can_give": "1",
    "times": "1",
    "use_times": "0",
    "expire_date": "365",
    "isdel": "0",
    "isaudit": "1",
    "auditname": "殷亮",
    "audittime": "2018-11-08",
    "is_convert": "0",
    "score": "0.0",
    "favorable_rate": "0.00",
    "voter": "0",
    "sales_count": "0",
    "is_ratify": "1",
    "is_newsdiscount": "1",
    "is_sales": "1",
    "shared_num": "0",
    "read_num": "0",
    "norm": "{\"name\":[\"零公里机油00-合成合金装甲5W-40 4L\"],\"number\":[\"1\"],\"expire\":[\"365\"]}",
    "is_coupon_center": "0",
    "send_num": "1",
    "send_percent": "1",
    "add_time": "1536542108",
    "update_time": "1543921158",
    "statement": ""
  }
  ],
  "code": 200,
  "pageCount": 1
};


$(data.rows).each(function(k,v) {
  console.dir(v);
  list += ' <div class="w"  onclick="check(this)" data-index="'+v.id+'" data-title="'+v.title+'">\n' +
  '<div class="quan-item quan-d-item quan-item-acoupon ">\n' +
  '<div class="q-opbtns "> 优惠券</div><div class="q-type"><div class="q-price">\n' +
  '<div class="titles"><em>￥</em><strong class="num1">'+v.price+'</strong></div>\n' +
  '<div class="txt titles"> </div> </div><div class="q-range"><div class="typ-txt"> '+v.title+'' +
  '<br><span style=";width: 7rem;display: inline-block;">库存：'+v.stock+'</span>' +
  '<span style="">有效天数：'+v.expire_date+'</span></div><div class="range-item" style="margin-top: 10px;">' +
  '优惠说明：'+v.offer_desc+'</div><div class="range-item">适用说明：'+v.suitable_desc+'</div></div>\n' +
  '</div><span id="" class="check"></span></div></div>'
});


var list = '';
$("#newslist .container >div").remove();
$(data.rows).each(function(k,v) {
  console.dir(v);
  list += ' <div class="w" onclick="check(this)" data-index="'+v.id+'" data-title="'+v.title+'">\n' +
  '<div class="quan-item quan-d-item quan-item-acoupon ">\n' +
  '<div class="q-opbtns "> 优惠券</div><div class="q-type"><div class="q-price">\n' +
  '<div class="titles"><em>￥</em><strong class="num1">'+v.price+'</strong></div>\n' +
  '<div class="txt titles"> </div> </div><div class="q-range"><div class="typ-txt"> '+v.title+'' +
  '<br><span style=";width: 7rem;display: inline-block;">库存：'+v.stock+'</span>' +
  '<span style="">有效天数：'+v.expire_date+'</span></div><div class="range-item" style="margin-top: 10px;">' +
  '优惠说明：'+v.offer_desc+'</div><div class="range-item">适用说明：'+v.suitable_desc+'</div></div>\n' +
  '</div><span id="" class="check"></span></div></div>'
});
$("#newslist .container").prepend(list);


</script>
</body>
</html>