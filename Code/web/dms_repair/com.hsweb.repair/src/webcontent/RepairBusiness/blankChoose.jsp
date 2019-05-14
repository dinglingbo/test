<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" session="false" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@include file="/common/commonRepair.jsp"%>

<html>
<!-- 
  - Author(s): Administrator
  - Date: 2018-07-02 19:02:07 
  - Description:  
-->   
<head>
    <title>钣喷项目</title>
    <script src="<%=request.getContextPath()%>/repair/js/DataBase/Item/blankChoose.js?v=1.0.5"></script>
    <%-- <script src="<%=request.getContextPath()%>/repair/js/DataBase/Item/item_special.js?v=1.0.0"></script> --%>
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
        .btnType{
            font-family:Verdana;
            font-size: 14px;
            text-align: center;
            height: 40px;
            width: 120px;
            line-height:40px;
        }
        .title {
            width: 80px;
            text-align: right;
        }
        .required {
            color: red;
        }

        #guestInfo a:link { 
        font-size: 12px; 
        color: #578ccd; 
        text-decoration: none; 
        } 
        #guestTab a:link { 
        font-size: 12px; 
        color: #578ccd; 
        text-decoration: none; 
        }   
        #guestInfo a:visited { 
        font-size: 12px; 
        color: #578ccd; 
        text-decoration: none; 
        } 
        #guestInfo a:hover { 
        font-size: 12px; 
        color: #578ccd; 
        text-decoration: underline; 
        }  

        #wechatTag{
            color:#62b900;
        }
        #wechatTag1{
            color:#ccc;
        }
        /* font-family:Verdana;color:white;background:#62b900;padding:0px 8px;border-radius:90px; display:block;  padding:4px 15px;*/
        a.healthview{ background:#78c800; font-size:13px; color:#fff; text-decoration:none;  padding:0px 8px; border-radius:20px;}
        a.healthview:hover{ background:#f00000;color:#fff;text-decoration:none;}

        a.chooseClass{ background:#578ccd; font-size:13px; color:#fff; text-decoration:none;  padding:0px 8px; border-radius:20px;}
        a.chooseClass:hover{ background:#f00000;color:#fff;text-decoration:none;}
        
        a.optbtn {
            width: 52px;
            /* height: 26px; */
            border: 1px #d2d2d2 solid;
            background: #f2f6f9;
            text-align: center;
            display: inline-block;
            /* line-height: 26px; */
            margin: 0 4px;
            color: #000000;
            text-decoration: none;
            border-radius: 5px;
        }

        .statusview{background:#78c800; color:#fff; padding:3px 20px; border-radius:20px;}

        .nvstatusview{color: #5a78a0;padding:3px 20px; border-radius:20px;border: 1px solid;}

        .bottomfont{font-size: 20px;}

        .showhealthcss{color: #5a78a0;padding:3px 20px;border: 1px solid;}
 	#comment_bubble {

    width: 140px;
    height: 100px;
    background: #78c800c2;
    position: relative;
    -moz-border-radius: 12px;
    -webkit-border-radius: 12px;
    border-radius: 12px;
} 
  
/*  #search:before {
    content: "";
    width: 0;
    height: 0;
    right: 100%;
    top: 12px;
    position: absolute;
    border-top: 8px solid transparent;
    border-right: 18px solid #cac52afc;
    border-bottom: 8px solid transparent;
}   */
.tishi{
	margin-top: 5px;
}
.btn .mini-buttonedit{
	height:36px;
}
.btn .aa{
	height:36px;
	width: 300px;
}
.btn .mini-buttonedit .mini-corner-all{
	height:33px;
	background: #368bf447;
}
.btn .aa .mini-corner-all{
	height:33px;
}
.mini-corner-all .nui-textbox{
	height:30px;
}
.btn .mini-corner-all .mini-buttonedit-input{
	font-size: 16px;
	margin-top: 8px;
	
}
.btn .mini-corner-all .mini-textbox-input{
	font-size: 14px;
	margin-top: 8px;
	
}

    </style>
</head>
<body>
<!-- multiSelect="true" -->
<!-- <div class="nui-toolbar" style="padding:2px;height:38px;position: relative;">
    <table class="table" id="table1" border="0" style="width:100%;border-spacing:0px 0px;">
      <td>
        <label style="font-family:Verdana;font-size:8px">钣金</label>
        <label style="font-family:Verdana;font-size:8px">备注:</label>
        <label style="font-family:Verdana;font-size:8px">大钣金
        <input name="isDisabled" class="nui-checkbox" trueValue="1" falseValue="0"/>
        </label>
        <label style="font-family:Verdana;font-size:8px">小钣金
        <input name="isDisabled" class="nui-checkbox" trueValue="1" falseValue="0"/>
        </label>
        <span>&nbsp;&nbsp;&nbsp;&nbsp;</span>
        <label style="font-family:Verdana;font-size:8px">
          <input name="isDisabled" class="nui-checkbox" trueValue="1" falseValue="0"/>调整工时
        </label>
        <span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span>
        <label style="font-family:Verdana;font-size:8px">
          <input name="isDisabled" class="nui-checkbox" trueValue="1" falseValue="0"/>大版金
        </label>
        <label style="font-family:Verdana;font-size:8px">
          <input name="isDisabled" class="nui-checkbox" trueValue="1" falseValue="0"/>小版金
        </label>
      </td>
      <td>
         <span class="separator"></span>
        <label style="font-family:Verdana;font-size:8px">喷漆</label>
        <label style="font-family:Verdana;font-size:8px">备注:</label>
        <label style="font-family:Verdana;font-size:8px">喷漆
        <input name="isDisabled" class="nui-checkbox" trueValue="1" falseValue="0"/>
        </label>
        <span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span>
        <label style="font-family:Verdana;font-size:8px">
          <input name="isDisabled" class="nui-checkbox" trueValue="1" falseValue="0"/>调整工时
        </label>
        <span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span>
        <label style="font-family:Verdana;font-size:8px">
          <input name="isDisabled" class="nui-checkbox" trueValue="1" falseValue="0"/>全车喷漆
        </label>
      </td>
 
	    <td  style='height: 100%'>
        <a class="nui-button" id="selectBtn" iconCls="" onclick="choose()" plain="true" visible="true"><span class="fa fa-check fa-lg"></span>&nbsp;确定</a>
        </td>
		<td  style='height: 100%'>
		<a class="nui-button" id="selectBtn" iconCls="" onclick="choose()" plain="true" visible="true"><span class="fa fa-close fa-lg"></span>&nbsp;取消</a>
        </td>
    			
    </table>
ondrawsummarycell="onDrawSummaryCell"
</div> -->
<div class="nui-fit">
       
 <div style="float:left;width:71%;height:600px;background:#fff;">
	     <div id="blankGrid" class="nui-datagrid" style="width: 100%;height:100%"
			showPager="false" sortMode="client" allowCellEdit="true"
			allowCellSelect="true" multiSelect="true" showsummaryrow = "true"
			editNextOnEnterKey="true" onDrawCell="onDrawCell"  
			onvaluechanged = "onValueChanged"			
			>
	    <div property="columns">
	       <div type="indexcolumn">序号</div>
		   <div field="itemNameo" name="itemName" headerAlign="center" allowSort="false" visible="true" width="120px">名称</div>
		   <div field="itemNamet" name="code" headerAlign="code" allowSort="false" visible="false" width="120px">喷漆名称</div>
		   <div field="itemCodeo" name="itemCodeo" headerAlign="code" allowSort="false" visible="false" width="120px">编码</div>
		   <div field="itemCodet" name="itemCodet" headerAlign="itemCodet" allowSort="false" visible="false" width="120px">编码</div>
		   <div field="msCode" name="msCode" headerAlign="msCode" allowSort="false" visible="false" width="120px">显示图片编码</div>
		   <div field="Ido" name="itemIdo" headerAlign="itemIdo" allowSort="false" visible="false" width="120px">id</div>
		   <div field="Idt" name="itemIdt" headerAlign="itemIdt" allowSort="false" visible="false" width="120px">id</div>
		   <div field="itemTimeo" name="itemTimeo" headerAlign="itemTimeo" allowSort="false" visible="false" width="120px">数量</div>
		   <div field="itemTimet" name="itemTimet" headerAlign="itemTimet" allowSort="false" visible="false" width="120px">数量</div>
		   <div field="unitPricet" name="unitPricet" headerAlign="unitPricet" allowSort="false" visible="false" width="120px">单价</div>
		   <div field="unitPriceo" name="unitPriceo" headerAlign="unitPriceo" allowSort="false" visible="false" width="120px">单价</div>
		   <div field="rateo" name="rateo" headerAlign="rateo" allowSort="false" visible="false" width="120px">优惠率</div>
		   <div field="ratet" name="ratet" headerAlign="ratet" allowSort="false" visible="false" width="120px">优惠率</div>
		   <div field="nameId" name="nameId" headerAlign="code" allowSort="false" visible="false" width="120px">名称Id</div>
            <div field="amto" allowSort="true" align="left"
				headerAlign="center" width="">
				原价 <input class="nui-textbox" selectOnFocus="true" width="60%" vtype="float" datatype="float"  name="amt" property="editor" onvaluechanged ="onValueChangedAmto"/>
			</div>
            <div field="subtotalo" allowSort="false" align="left"
				headerAlign="center" width="">
				折后价 <input class="nui-textbox" vtype="float" datatype="float" name="subtotal" property="editor" onvaluechanged ="onValueChangedSubtotalo"/>
			</div>
            <div field="typeCode" headerAlign="center" allowSort="false" visible="true" align="center" name="action">维修动作
                <input class="nui-combobox" showNullItem="true" name="chanceType"  valueField="customid" id="setAction" textField="name"  property="editor" data="statusList" emptyText=""/>
            </div>
           <div type="checkboxcolumn" trueValue="1" falseValue="0" field="isPaint" name="isPaint" value="1" width="60" headerAlign="center" header="是否喷漆" allowsort="true"></div>
           <div field="amtt" allowSort="true" align="left"
				headerAlign="center" width="">
				喷漆原价 <input class="nui-textbox"  vtype="float" datatype="float"  name="amt" property="editor" onvaluechanged ="onValueChangedAmtt"/>
			</div>
            <div field="subtotalt" allowSort="false" align="left"
				headerAlign="center" width="">
				喷漆折后价 <input class="nui-textbox" vtype="float" datatype="float" name="subtotalq" property="editor" onvaluechanged ="onValueChangedSubtotalt"/>
			</div>
           <div field="blankOptBtn" name="blankOptBtn" width="80" headerAlign="center" header="操作" align="center" ></div>
      </div>
     </div>            
 </div>   
     
  <!-- <div style="float:left;width:40%;height:500px;background:#fff;">     -->
      <!-- <div style="width:291px;height:475px;overflow-y:auto;overflow-x:hidden;background:#fff;" id="sp-itemlist-1">
      </div> --> 
      <!--钣金-->
      <div style="float:left;position:absolute;width:350px;height:500px;top:0;right:0;background:#c8c8c8;" data-pathtype="1" id="path-list-1">
        <img id="imgShow" src="" style="position:absolute;top:30px;left:0;z-index:0;width:100%;transform:scale(0.95);"/>
        <svg style="position:absolute;top:10px;left:0;z-index:1;width:100%;height:100%;transform:scale(0.95);" version="1.1" id="svg-group-1" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" x="0px" y="0px" width="640px" height="840px" viewBox="0 0 616.141 808.839" enable-background="new 0 0 616.141 808.839" xml:space="preserve">
          <!--左前反光镜-->
          <path data-name="钣金（左前反光镜）" data-cpno="001" data-code="path-201" select-type="0" fill-opacity="0" fill="#000000" stroke="none" stroke-miterlimit="10" d="M134.5119 118.494L161.1221 115.527L165.109 111.4474L167.9832 104.3081L167.9832 97.44694L167.3342 92.25473L156.9498 87.89697C156.9498 87.89697 147.5 62.648 121.167 55.315C121.167 55.315 104 52.315 84.667 64.482C84.667 64.482 74.334 73.149 70.834 80.815C70.834 80.815 69.834 88.148 70.834 94.982C70.834 94.982 72.501 105.649 87.334 111.649C87.333 111.648 112.6789 119.994 134.5119 118.494Z" transform="matrix(1,0,0,1,0,0) matrix(1,0,0,1,0,0) matrix(1,0,0,1,0,0)"/>
          <!--右前反光镜-->
          <path data-name="钣金（右前反光镜）" data-cpno="018" data-code="path-202" select-type="0" fill-opacity="0" fill="#000000" stroke="none" stroke-miterlimit="10" d="M480.1041 118.3704L452.5358 115.6198L448.4562 110.8911L446.7873 105.4207L446.1382 98.93045L446.88 92.25473L457.2954 87.77333C457.4499 87.15522 466.628 62.648 492.961 55.315C492.961 55.315 510.128 52.315 529.461 64.482C529.461 64.482 539.794 73.149 543.294 80.815C543.294 80.815 544.294 88.148 543.294 94.982C543.294 94.982 541.628 105.649 526.794 111.649C526.794 111.648 501.9999 119.2523 480.1041 118.3704Z" transform="matrix(1,0,0,1,0,0) matrix(1,0,0,1,0,0) matrix(1,0,0,1,0,0) matrix(1,0,0,1,0,0) matrix(1,0,0,1,0,0)"/>
          <!--左前保险杠-->
          <path data-name="钣金（左前保险杠）" data-cpno="002" data-code="path-203" select-type="0" fill-opacity="0" d="M 188.6294 68.99996 L 213.6294 61.99997 L 244.6294 56.99997 L 276.6294 53.99997 L 306.2585 52.99997 L 306.2585 104 L 255.6294 104 L 231.6294 106 L 203.6294 109 L 183.6294 114 L 172.6294 118 L 178.6294 108 L 182.6294 94.99996 L 186.6294 81.99996 L 188.6294 68.99996 Z" fill="#000000" stroke="none" />
          <!--右前保险杠-->
          <path data-name="钣金（右前保险杠）" data-cpno="019" data-code="path-204" select-type="0" fill-opacity="0" d="M424 69L397 62L367 57L342 55L307.7417 53L307.7417 104L343 104L394 107L430 112L441 116L437 111L433 104L430 94L427 81L424 69Z" fill="#000000" stroke="none" />
          <!--前中网-->
          <path data-name="钣金（前中网）" data-cpno="035" data-code="path-205" select-type="0" fill-opacity="0" d="M173 120L171 160L203 154L227 149L249 145L275 143L293 142L311 142L333 143L359 146L378 148L394 151L416 156L432 160L442 162L441 119L429 115L413 113L394 110L366 108L342 107L307 107L273 107L254 107L230 109L206 112L188 116L173 120Z" fill="#000000" stroke="none" />
          <!--机盖-->
          <path data-name="钣金（机盖）" data-cpno ="036" data-code="path-206" select-type="0" fill-opacity="0" d="M172 162L233 150L272 146L308 145L342 147L377 150L410 157L443 165L445 253L446 260L448 267L453 271L440 268L428 266L419 267L407 272L403 276L397 284L392 292L387 303L383 314L379 324L375 335L374 341L238 341L233 322L228 307L222 293L215 281L209 274L200 268L188 266L177 268L167 270L158 273L165 268L168 259L170 249L171 206L172 162Z" fill="#000000" stroke="none" transform="matrix(0.9999999,0,0,0.9999999,-0.9270707,0.6177921)" />
          <!--左前叶子板-->
          <path data-name="钣金（左前叶子板）" data-cpno="005" data-code="path-207" select-type="0" fill-opacity="0" d="M61 158L88 138L98 133L109 128L115 127L126 128L130 129L137 131L142 135L145 140L146 146L146 149L147 155L150 177L152 195L154 212L155 230L159 273L51 283L68 278L80 274L88 270L95 264L103 257L109 248L114 234L115 221L112 208L105 194L94 180L85 172L74 164C74 164 60 158 61 158Z" fill="#000000" stroke="none" />
          <!--右前叶子板-->
          <path data-name="钣金（右前叶子板）" data-cpno="022" data-code="path-208" select-type="0" fill-opacity="0" d="M456 273L467 152L469 140L471 134L473 132L481 129L489 127L496 127L503 127L514 131L527 138L554 158L544 162L536 167L527 173L518 181L511 190L504 201L501 210L499 220L499 232L501 243L505 251L514 260L523 267L533 274L547 280L562 283C562 283 456 272 456 273Z" fill="#000000" stroke="none" />
          <!--左前轮胎-->
          <path data-name="钣金（左前轮胎）" data-cpno="006" data-code="path-209" select-type="0" fill="#000000" stroke="none" fill-opacity="0" transform="matrix(1.047,0,0,1.047,-15.44572,-21.84915)" d="M 106.5161 230.5003 C 106.5161 255.6955 86.09133 276.1203 60.89611 276.1203 C 35.70088 276.1203 15.27611 255.6955 15.27611 230.5003 C 15.27611 205.3051 35.70088 184.8803 60.89611 184.8803 C 86.09133 184.8803 106.5161 205.3051 106.5161 230.5003 Z" />
          <!--右前轮胎-->
          <path data-name="钣金（右前轮胎）" data-cpno="023" data-code="path-210" select-type="0" fill="#000000" stroke="none" fill-opacity="0" transform="matrix(1.047,0,0,1.047,504.1195,-21.50634)" d="M 106.5161 230.5003 C 106.5161 255.6955 86.09133 276.1203 60.89611 276.1203 C 35.70088 276.1203 15.27611 255.6955 15.27611 230.5003 C 15.27611 205.3051 35.70088 184.8803 60.89611 184.8803 C 86.09133 184.8803 106.5161 205.3051 106.5161 230.5003 Z" />
          <!--左前门饰条-->
          <path data-name="钣金（左前门饰条）" data-cpno="004" data-code="path-211" select-type="0" fill-opacity="0" fill="#000000" stroke="none" stroke-miterlimit="10" d="M 0 45.273 L 53.5 45.273 L 53.5 167.023 L 0 167.023 Z" />
          <!--左前车门-->
          <path data-name="钣金（左前车门）" data-cpno="008" data-code="path-212" select-type="0" fill-opacity="0" fill="#000000" d="M214.167,390.315c-0.333-10.833-10.5-24.833-10.5-24.833l-47.333-51.667&#xD;&#xA;c-22.333-25.667-56.5-20.833-56.5-20.833c-29.833,2.833-32.5,15.333-32.5,15.333v82.333h146.834&#xD;&#xA;			C214.167,390.437,214.167,390.315,214.167,390.315z" transform="matrix(1,0,0,1,0,0) " stroke="none" />
          <!--左前门把手-->
          <path data-name="钣金（左前门把手）" data-cpno="003" data-code="path-213" select-type="0" fill-opacity="0" fill="#000000" stroke="none" stroke-miterlimit="10" d="M37.5,14.398c0,0-0.25,5.5,1.5,8.25c0,0,6,9.25,19,12.75&#xD;&#xA;	c0,0,12,4.25,35.5,6.25c0,0,25.25,0.5,35,0c0,0,10.75-1.75,12.75-2.5c0,0,5.25-1,9.25-7.5l3.5-7.25c0,0,1-2.75,0-7.75&#xD;&#xA;	c0,0-7.875-17.375-48.125-16.625C105.875,0.023,46.75,0.398,37.5,14.398z" />
          <!--左A柱-->
          <path data-name="钣金（左A柱）" data-cpno="007" data-code="path-214" select-type="0" fill-opacity="0" fill="#000000" d="M140.5,288.648c0,0,52.5,30,75.5,83l20-28c0,0-11.75-40-19.25-52c0,0-12.817-27.75-31.909-19.5&#xD;&#xA;		L140.5,288.648z" transform="matrix(1,0,0,1,0,0) " stroke="none" />
          <!--右A柱-->
          <path data-name="钣金（右A柱）" data-cpno="024" data-code="path-215" select-type="0" fill-opacity="0" fill="#000000" d="M473.766,288.648c0,0-52.5,30-75.5,83l-20-28c0,0,11.75-40,19.25-52c0,0,12.817-27.75,31.908-19.5&#xD;&#xA;		L473.766,288.648z" transform="matrix(1,0,0,1,0,0) " stroke="none" />
          <!--右前车门-->
          <path data-name="钣金（右前车门）" data-cpno="025" data-code="path-216" select-type="0" fill-opacity="0" fill="#000000" d="M401.961,390.315c0.333-10.833,10.5-24.833,10.5-24.833l47.333-51.667&#xD;&#xA;			c22.334-25.667,56.5-20.833,56.5-20.833c29.834,2.833,32.5,15.333,32.5,15.333v82.333H401.96&#xD;&#xA;			C401.96,390.437,401.961,390.315,401.961,390.315z" transform="matrix(1,0,0,1,0,0) " stroke="none" />
          <!--右前车把手-->
          <path data-name="钣金（右前车把手）" data-cpno="020" data-code="path-217" select-type="0" fill-opacity="0" fill="#000000" stroke="none" stroke-miterlimit="10" d="M576.628,14.398c0,0,0.25,5.5-1.5,8.25c0,0-6,9.25-19,12.75&#xD;&#xA;	c0,0-12,4.25-35.5,6.25c0,0-25.25,0.5-35,0c0,0-10.75-1.75-12.75-2.5c0,0-5.25-1-9.25-7.5l-3.5-7.25c0,0-1-2.75,0-7.75&#xD;&#xA;	c0,0,7.875-17.375,48.125-16.625C508.253,0.023,567.378,0.398,576.628,14.398z" />
          <!--左下边梁-->
          <path data-name="钣金（左下边梁）" data-cpno="011" data-code="path-218" select-type="0" fill-opacity="0" fill="#000000" stroke="none" stroke-miterlimit="10" d="M 0 282.669 L 51 282.669 L 51 503.648 L 0 503.648 Z" />
          <!--左后门饰条-->
          <path data-name="钣金（左后门饰条）" data-cpno="015" data-code="path-219" select-type="0" fill-opacity="0" fill="#000000" stroke="none" stroke-miterlimit="10" d="M 0 639.148 L 53.5 639.148 L 53.5 760.898 L 0 760.898 Z" />
          <!--右前门饰条-->
          <path data-name="钣金（右前门饰条）" data-cpno="021" data-code="path-220" select-type="0" fill-opacity="0"  fill="#000000" stroke="none" stroke-miterlimit="10" d="M 562.641 45.273 L 616.141 45.273 L 616.141 167.023 L 562.641 167.023 Z" />
          <!--右下边梁-->
          <path data-name="钣金（右下边梁）" data-cpno="028" data-code="path-221" select-type="0" fill-opacity="0"  fill="#000000" stroke="none" stroke-miterlimit="10" d="M 561.987 282.669 L 616.14 282.669 L 616.14 503.398 L 561.987 503.398 Z" />
          <!--右后门饰条-->
          <path data-name="钣金（右后门饰条）" data-cpno="032" data-code="path-222" select-type="0" fill-opacity="0" fill="#000000" stroke="none" stroke-miterlimit="10" d="M 562.641 639.148 L 616.141 639.148 L 616.141 760.898 L 562.641 760.898 Z" />
          <!--左B柱-->
          <path data-name="钣金（左B柱）" data-cpno="009" data-code="path-223" select-type="0" fill-opacity="0" fill="#000000" d="M214.168,390.648H67.333v49.75h146.634C214.249,417.446,214.179,393.666,214.168,390.648z" transform="matrix(1,0,0,1,0,0) " stroke="none" />
          <!--车顶-->
          <path data-name="钣金（车顶）" data-cpno="037" data-code="path-224" select-type="0" fill-opacity="0" d="M239 345L375 345L396 375L397 486L386.5203 501.977L377 516L234.4623 516.4411L226.6739 501.2352L219 486L219 374L239 345Z" fill="#000000" stroke="none" />
          <!--右B柱-->
          <path data-name="钣金（右B柱）" data-cpno="026" data-code="path-225" select-type="0" fill-opacity="0" fill="#000000" d="M401.96,390.648h146.834v49.75H402.161C401.88,417.446,401.949,393.666,401.96,390.648z" transform="matrix(1,0,0,1,0,0) " stroke="none" />
          <!--左后车门-->
          <path data-name="钣金（左后车门）" data-cpno="010" data-code="path-226" select-type="0" fill-opacity="0" fill="#000000" d="M67.333,499.315c36.167,10.167,42.667,38,42.667,38l36,6.5l66.167-59.667&#xD;&#xA;			c1.046-4.482,1.556-23.799,1.8-43.75H67.333V499.315z" transform="matrix(1,0,0,1,0,0) " stroke="none" />
          <!--左后门把手-->
          <path data-name="钣金（左后门把手）" data-cpno="016" data-code="path-227" select-type="0" fill-opacity="0" fill="#000000" stroke="none" stroke-miterlimit="10" d="M37.5,780.516c0,0-0.25,5.5,1.5,8.25c0,0,6,9.25,19,12.75&#xD;&#xA;	c0,0,12,4.25,35.5,6.25c0,0,25.25,0.5,35,0c0,0,10.75-1.75,12.75-2.5c0,0,5.25-1,9.25-7.5l3.5-7.25c0,0,1-2.75,0-7.75&#xD;&#xA;	c0,0-7.875-17.375-48.125-16.625C105.875,766.141,46.75,766.516,37.5,780.516z" />
          <!--右后车门-->
          <path data-name="钣金（右后车门）" data-cpno="027" data-code="path-228" select-type="0" fill-opacity="0" fill="#000000" d="M548.794,499.315c-36.166,10.167-42.666,38-42.666,38l-36,6.5l-66.167-59.667&#xD;&#xA;			c-1.046-4.482-1.556-23.799-1.8-43.75h146.633V499.315z" transform="matrix(1,0,0,1,0,0) " stroke="none" />
          <!--右后车把手-->
          <path data-name="钣金（右后车把手）" data-cpno="033" data-code="path-229" select-type="0" fill-opacity="0" fill="#000000" stroke="none" stroke-miterlimit="10" d="M583.99,780.516c0,0,0.25,5.5-1.5,8.25c0,0-6,9.25-19,12.75&#xD;&#xA;	c0,0-12,4.25-35.5,6.25c0,0-25.25,0.5-35,0c0,0-10.75-1.75-12.75-2.5c0,0-5.25-1-9.25-7.5l-3.5-7.25c0,0-1-2.75,0-7.75&#xD;&#xA;	c0,0,7.875-17.375,48.125-16.625C515.615,766.141,574.74,766.516,583.99,780.516z" />
          <!--左后轮胎-->
          <path data-name="钣金（左后轮胎）" data-cpno="014" data-code="path-230" select-type="0" fill="#000000" stroke="none" fill-opacity="0" transform="matrix(1.047,0,0,1.047,-15.658,336.5715)" d="M 106.5161 230.5003 C 106.5161 255.6955 86.09133 276.1203 60.89611 276.1203 C 35.70088 276.1203 15.27611 255.6955 15.27611 230.5003 C 15.27611 205.3051 35.70088 184.8803 60.89611 184.8803 C 86.09133 184.8803 106.5161 205.3051 106.5161 230.5003 Z" />
          <!--右后轮胎-->
          <path data-name="钣金（右后轮胎）" data-cpno="031" data-code="path-231" select-type="0" fill="#000000" stroke="none" fill-opacity="0" transform="matrix(1.047,0,0,1.047,503.9094,336.544)" d="M 106.5161 230.5003 C 106.5161 255.6955 86.09133 276.1203 60.89611 276.1203 C 35.70088 276.1203 15.27611 255.6955 15.27611 230.5003 C 15.27611 205.3051 35.70088 184.8803 60.89611 184.8803 C 86.09133 184.8803 106.5161 205.3051 106.5161 230.5003 Z"/>
          <!--右C柱-->
          <path data-name="钣金（右C柱）" data-cpno="029" data-code="path-232" select-type="0" fill-opacity="0" fill="#000000" d="M396.539,492.107c0,0,1.167,10.856-16.333,27.615c0,0,17.499,36.925,43.667,74.592c0,0,4,4.001,3.166-5.166&#xD;&#xA;		c0,0,2.168-25.666,27-38.333C454.039,550.815,414.706,513.233,396.539,492.107z" transform="matrix(1,0,0,1,0,0) " stroke="none" />
          <!--左C柱-->
          <path data-name="钣金（左C柱）" data-cpno="012" data-code="path-233" select-type="0" fill-opacity="0" fill="#000000" d="M216,492.107c0,0-1.167,10.856,16.333,27.615c0,0-17.5,36.925-43.667,74.592c0,0-4,4.001-3.167-5.166&#xD;&#xA;		c0,0-2.167-25.666-27-38.333C158.5,550.815,197.833,513.233,216,492.107z" transform="matrix(1,0,0,1,0,0) " stroke="none" />
          <!--左后叶子板-->
          <path data-name="钣金（左后叶子板）" data-cpno="013" data-code="path-234" select-type="0" fill-opacity="0" d="M183 595L182.54 595.0661L171 595L171 578L170 575L167 570L165 568L163 568L160 570L157 577L145 695L142 688L138 684L134 682L130 681L125 680L120 681L115 682L108 684L102 685L95 685L89 684L84 683L78 679L73 674L69 667L65 658L63 650L62 639L64 639L67 638L70 637L74 635L81 631L90 622L105 601L111 585L113 575L113 568L156 553L160 555L163 557L166 559L170 563L173 566L176 570L179 575L181 579L182 583L183 587L183 591C183 591 182 595 183 595Z" fill="#000000" stroke="none" />
          <!--后尾盖-->
          <path data-name="钣金（后尾盖）" data-cpno="038" data-code="path-235" select-type="0" fill-opacity="0" d="M235 520L376 520L422 598L443 598L444 645L170 645L171 598L189 598L210 567L227 538C227 538 235 519 235 520Z" fill="#000000" stroke="none" />
          <!--右后叶子板-->
          <path data-name="钣金（右后叶子板）" data-cpno="030" data-code="path-236" select-type="0" fill-opacity="0" d="M429 595L429.0383 595.1192L443 595L443 577L448 569L451 569L453 570L456 573L457 576L468 694L475 684L479 682L484 680L489 681L495 683L503 684L508 684L516 685L519 684L526 684L530 683L535 679L541 673L545 666L549 656L551 646L552 640L545 638L539 635L534 631L526 626L518 618L511 607L507 597L504 587L502 574L504 563L456 552L454 553L451 555L449 557L446 559L444 561L442 564L439 567L437 570L435 574L433.4437 578.1854L431.4437 582.1854L430.4437 585.9272L429.2782 590.9471L429.2635 595.0663" fill="#000000" stroke="none" />
          <!--右后保险杠-->
          <path data-name="钣金（右后保险杠）" data-cpno="034" data-code="path-237" select-type="0" fill-opacity="0" d="M308.8224 712.2623L417.1174 711.3351L417 717L418 722L420 725L423 728L427 729L430 730L436 732L441 734L444 737L447 740L448 744L449 747L445 750L437 753L424 755L409 757L397 757L379 758L308.8224 758.9922C308.8224 758.2505 308.8224 711.2622 308.8224 712.2623Z" fill="#000000" stroke="none" />
          <!--左后保险杠-->
          <path data-name="钣金（左后保险杠）" data-cpno="017" data-code="path-238" select-type="0" fill-opacity="0" d="M198 712L307.1535 712.0767L307.1535 758.0651L278 758L183 755L175 753L168 750L165 746L168 740L172 736L177 733L181 732L186 730L191 727L194 725L196 721L198 717C198 717 197 711 198 712Z" fill="#000000" stroke="none" />
          <!--后尾盖垂直面-->
          <path data-name="钣金（后尾盖垂直面）" data-cpno="039" data-code="path-239" select-type="0" fill-opacity="0" d="M170 648L444 649L444 661L436 671L428 684L422 695L417 709L197 710L195 701L190 689L181 674L176 666L171 659C171 659 170 647 170 648Z" fill="#000000" stroke="none" transform="matrix(0.9999999,0,0,0.9999999,-0.09294968,-0.2782772)" />
		</svg>
      </div>
   <!--  </div> -->
    
    <div style="height: 10%;"></div>
</div>

<div style="background-color: #cfddee;position:absolute; top:83%;width:100%;height: 17%; z-index:900;">
    <div id="statustable" style="float: left;height:100%;font-size:16px;color:#5a78a0;padding-left:20px;">
    	<table  style='height: 100%'>
    		<tbody>
    			<tr>
    				<td >
			        <label>钣金优惠：</label>
			            <input class="nui-textbox"    inputStyle="color:red;font-weight:bold;font-size:14px;"  enabled="false" name="totalAmt"/>
			      	</td>
    				<td  >
			        <label>钣金总价：</label>
			            <input class="nui-textbox" inputStyle="color:red;font-weight:bold;font-size:14px;" enabled="false"  id="totalAmt" name="totalAmt"/>
			      	</td>
    			</tr>
    			<tr>
    				<td  >
			        <label>喷漆优惠：</label>
			            <input class="nui-textbox" inputStyle="color:red;font-weight:bold;font-size:14px;" enabled="false"  id="totalAmt" name="totalAmt"/>
			      	</td>
    				<td>
			        <label>喷漆总价：</label>
			            <input class="nui-textbox" inputStyle="color:red;font-weight:bold;font-size:14px;" enabled="false"  id="totalAmt" name="totalAmt"/>
			      	</td>
    			</tr>
    		</tbody>
    	</table>
    </div>
     <div id="sellForm" class="form"  style="float:right;height: 100%;padding-right: 20px;">
    	 <table style='height: 100%'>
    		<tbody>
    			<tr>
    				<!-- <td  style='height: 100%'>
			        <a class="nui-button" id="selectBtn" iconCls="" onclick="choose()" plain="true" visible="true"><span class="fa fa-check fa-lg"></span>&nbsp;确定</a>
			        </td>
    				<td  style='height: 100%'>
    				<a class="nui-button" id="selectBtn" iconCls="" onclick="choose()" plain="true" visible="true"><span class="fa fa-check fa-lg"></span>&nbsp;取消</a>
			        </td> -->
			        <td >
						<a id="settle" style="    width: 120px;
							height: 40px;
							font-size: 18px;
							background: #578ccd;
							color: #fff;
							text-align: center;
							display: block;
							border-radius: 5px;
							text-decoration: none;
							line-height: 2;" 
							href="javascript:void(0)" onclick="insItem()">确定</a>
					</td>
					<td >
						<a id="ysettle" style="    width: 120px;
							height: 40px;
							font-size: 18px;
							background: #2ac476;
							color: #fff;
							text-align: center;
							display: block;
							border-radius: 5px;
							line-height: 2;
							text-decoration: none;" 
							href="javascript:void(0)" onclick="onCancel()" >取消</a>
					</td>
    			</tr>
    		</tbody>
    	</table>
    	<!-- <table  style='height: 100%'>
    		<tbody>
    			<tr>
    				<td >
			        <label>钣金优惠：</label>
			            <input class="nui-textbox"    inputStyle="color:red;font-weight:bold;font-size:14px;"  enabled="false" name="totalAmt"/>
			      	</td>
    				<td  >
			        <label>钣金总价：</label>
			            <input class="nui-textbox" inputStyle="color:red;font-weight:bold;font-size:14px;" enabled="false"  id="totalAmt" name="totalAmt"/>
			      	</td>
    			</tr>
    			<tr>
    				<td  >
			        <label>喷漆优惠：</label>
			            <input class="nui-textbox" inputStyle="color:red;font-weight:bold;font-size:14px;" enabled="false"  id="totalAmt" name="totalAmt"/>
			      	</td>
    				<td>
			        <label>喷漆总价：</label>
			            <input class="nui-textbox" inputStyle="color:red;font-weight:bold;font-size:14px;" enabled="false"  id="totalAmt" name="totalAmt"/>
			      	</td>
    			</tr>
    		</tbody>
    	</table> -->
    </div> 
</div>
 
<script type="text/javascript">
 nui.parse();
</script>
</body>
</html>