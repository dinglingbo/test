<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<!-- 
  - Author(s): Administrator
  - Date: 2019-04-10 09:50:50
  - Description:
-->

<head>
    <title>优惠券 模板</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
    <script src="<%= request.getContextPath() %>/common/nui/nui.js" type="text/javascript"></script>
    <style type="text/css">
        html,
        body {
            margin: 0px;
            padding: 0px;
            border: 0px;
            width: 100%;
            height: 100%;
            overflow: hidden;
        }

        body {
            font: 12px/150% tahoma, arial, Microsoft YaHei, Hiragino Sans GB, "\u5b8b\u4f53", sans-serif;
            -webkit-font-smoothing: antialiased;
            color: #666;
            background: #fff;
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

        .quan-item .q-price,
        .typ-txt {
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

        
        .quan-item .q-range {
            color: #999;
        }

        .quan-item .q-price {
            display: -webkit-flex;
            display: flex;
            -webkit-align-items: center;
            align-items: center;
            -webkit-justify-content: center;
            justify-content: center;
        }

        .quan-item .q-price div.titles {
            flex: 1;
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
    
    </style>
</head>

<body>

  
                <div class="quan-item quan-d-item quan-item-acoupon ">
                    <div class="q-opbtns "> 优惠券</div>
                    <div class="q-type">
                        <div class="q-price">
                            <div class="titles"><em>￥</em><strong class="num1">555</strong></div>
                            <div class="txt titles"> </div>
                        </div>
                        <div class="q-range">
                            <div class="typ-txt">保养券
                                <br><span style=";width: 7rem;display: inline-block;">库存：58</span>
                                <span style="">有效天数：123</span></div>
                            <div class="range-item" style="margin-top: 10px;">
                                优惠说明：后天到期，请及时使用</div>
                            <div class="range-item">适用说明：全国通用</div>
                        </div>
                    </div><span id="" class="check"></span>
                </div>
         



    <script type="text/javascript">
        nui.parse();
    </script>
</body>

</html>