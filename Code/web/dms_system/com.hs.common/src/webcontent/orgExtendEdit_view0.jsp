<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" session="false"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<!-- 
  - Author(s): Administrator
  - Date: 2018-05-27 15:11:00
  - Description:
--> 
<head>
    <title>门店信息</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
    <script src="<%=request.getContextPath()%>/common/nui/nui.js" type="text/javascript"></script>
    <link href="//netdna.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css" rel="stylesheet">
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

    border-collapse:collapse;
    table-layout:fixed;
    font-weight:bold;
    left:0;right:0;   
    margin:0 auto;
    padding:1px 0px 1px 0px;


}
.pic { /* 页面logo图片 */
	background-image: url(<%=request.getContextPath()%>/eos/A/jsp/Main.png);
background-repeat: no-repeat;
background-size: 100% 100%;
border-radius: 4px;
}

table tr
{
  height:40px; 
} 
table tr td span
{
  width:10px;
  display: inline-block;
}

.tabwidth{
    width:800px;
}
.tbtext{
    float: right; 
    line-height: 40px;
}
.mini-textbox{
    height: 28px;
    display: inline;
}
.mini-textbox-border{ 
    height: 25px;
} 
.mini-textbox-input{/* 输入框的里面的高度 */
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
</style> 
</head> 
<body>
    <div class="nui-fit">  
        <div style="width:950px;height:100%;left:0;right:0;margin: 0 auto;">
           <table >

            <tr >
                <td class="tbtext">LOGO图片<span></span></td>
                <td  colspan="5" class="tabwidth"><div class="pic"  style="width:64px;height:64px;border:1px solid #ccc; "></div></td>

            </tr> 

            <tr>
                <td class="tbtext">企业号<span></span></td>
                <td colspan="5"><input class="nui-textbox tabwidth"/></td>

            </tr>    
            
            <tr>
                <td class="tbtext">公司名称<span></span></td>
                <td colspan="5"><input class="nui-textbox tabwidth"/></td>

            </tr>               

            <tr>
                <td style="width:100px;text-align:right;" class="tbtext">省份<span style="color:red">*</span></td>
                <td style="width:200px;text-align:left;"><input class="nui-combobox textboxwidth"/></td>
                <td style="width:100px;text-align:right;"class="tbtext">城市<span style="color:red">*</span></td>
                <td style="width:200px;text-align:left;"><input class="nui-combobox textboxwidth"/></td>
                <td style="width:100px;text-align:right;"class="tbtext">地区<span style="color:red">*</span></td>
                <td style="width:200px;text-align:left;"><input class="nui-combobox textboxwidth"/></td>

            </tr> 

            <tr>
                <td class="tbtext">详细地址<span></span></td>
                <td colspan="5"><input class="nui-textbox tabwidth"/></td>

            </tr>
            <tr>
                <td class="tbtext">组合地址<span></span></td>
                <td colspan="5"><input class="nui-textbox tabwidth"/></td>

            </tr>

            <tr>
                <td class="tbtext">经度<span style="color:red"></span></td>
                <td colspan="5" ><input class="nui-textbox inline " style="" />
                    <span style="width:450px;float: right;text-align: right;">纬度<input class="nui-textbox inline" style="margin-left: 10px;"/></span>
                </td>

            </tr>
            <tr>
                <td class="tbtext">开店日期<span></span></td>
                <td colspan="5"><input class="nui-textbox tabwidth"/></td>

            </tr>           
            <tr>
                <td class="tbtext">公司电话<span></span></td>
                <td colspan="5"><input class="nui-textbox tabwidth"/></td>
            </tr>           
            <tr>
                <td class="tbtext">网站<span></span></td>
                <td colspan="5"><input class="nui-textbox tabwidth"/></td>

            </tr>         
            <tr>
                <td class="tbtext">报表标题<span></span></td>
                <td colspan="5"><input class="nui-textbox tabwidth"/></td>

            </tr>

            <tr>
                <td class="tbtext">主修品牌<span></span></td>
                <td colspan="5"><input class="nui-textbox tabwidth"/></td>

            </tr>


            <tr>
                <td class="tbtext">救援电话<span></span></td>
                <td colspan="5"><input class="nui-textbox tabwidth"/></td>

            </tr>           
            
            <tr>
                <td class="tbtext">广告语1<span></span></td>
                <td colspan="5"><input class="nui-textbox tabwidth"/></td>

            </tr>           
            <tr>
                <td class="tbtext">广告语2<span></span></td>
                <td colspan="5"><input class="nui-textbox tabwidth"/></td>

            </tr>

            <tr>
                <td class="tbtext">电子档案对接省份<span style="color:red"></span></td>
                <td colspan="5" ><input class="nui-textbox inline " style="" />
                    <span style="width:450px;float: right;text-align: right;">电子档案维修厂编号<input class="nui-textbox inline" style="margin-left: 10px;"/></span>
                </td>


            </tr>

            <tr>
                <td class="tbtext">电子档案用户名<span style="color:red"></span></td>
                <td colspan="5" ><input class="nui-textbox inline " style="" />
                    <span style="width:450px;float: right;text-align: right;">电子档案密码<input class="nui-textbox inline" style="margin-left: 10px;"/></span>
                </td>


            </tr>


            <tr>
                <td class="tbtext">备注<span></span></td>
                <td colspan="5"><input class="nui-textbox tabwidth"/></td>

            </tr>


            <tr>
                <td class="tbtext">建档人<span style="color:red"></span></td>
                <td colspan="5" ><input class="nui-textbox inline " style="" />
                    <span style="width:450px;float: right;text-align: right;">建档日期<input class="nui-textbox inline" style="margin-left: 10px;"/></span>
                </td>

            </tr>
            

            <tr>
                <td class="tbtext">最后操作人<span style="color:red"></span></td>
                <td colspan="5" ><input class="nui-textbox inline " style="" />
                    <span style="width:450px;float: right;text-align: right;">建档日期<input class="nui-textbox inline" style="margin-left: 10px;"/></span>
                </td>

            </tr>
        </table>
        <div style="text-align: center;margin-top: 10px;margin-bottom: 20px;">
            <a class="nui-button " style="margin-right:10px;" iconcls="" plain="false" onclick=""><i class="fa fa-plus"></i>&nbsp;新建并继续</a>
            <a class="nui-button " style="margin-right:10px;" iconcls="" plain="false" onclick=""><i class="fa fa-save"></i>&nbsp;保存退出</a>
            <a class="nui-button " style="margin-right:10px;" iconcls="" plain="false" onclick=""><i class="fa fa-sign-out"></i>&nbsp;退出</a>

        </div> 
    </div>
</div> 
<script type="text/javascript">
  nui.parse();

</script>
</body>
</html>