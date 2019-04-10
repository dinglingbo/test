<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false" %>

<style type="text/css">
.part-img-container {
  border: 1px solid #ddd;
  position: relative;
}
.part-rect {
  border: 2px solid #06c;
  position: absolute;
}
.select-row{
   background:#89c3d6;
}
.part-rect_dash {
  border: 2px dashed #06c;
  position: absolute;
}
.car{
	background:#ffffff;
}
.part-span{
   font-size:13px;
   color:#2779aa;
}

</style>

<div class="nui-splitter" style="width:100%;height:60px;" style="border:0;" handlerSize=0>
    <div size="100%" showCollapseButton="false" style="border:0;">
        <br/>
        <left id="groupButton">
            <a class="nui-button groupButton2" onclick="ntab.activeTab(ntab.getTab(0));">车型选择</a>&nbsp;
            <a class="nui-button groupButton2" onclick="showInfoRightGrid(subGroups)">主组/分组</a>&nbsp;
            <a class="nui-button groupButton2" style="display:none;" onclick="showInfoRightGrid(gridParts)">零件</a>
            <sapn style="padding-left:30%"></sapn>
            <a class="nui-button groupButton2" style="display:none;" onclick="lastGroup">上一主组</a>
            <a class="nui-button groupButton2" style="display:none;" onclick="nextGroup">下一主组</a>
            <a class="nui-button groupButton2" style="display:none;" onclick="lastSubGroup">上一分组</a>
            <a class="nui-button groupButton2" style="display:none;" onclick="nextSubGroup">下一分组</a>
        </left>
    </div>
    <div showCollapseButton="false" style="border:0;">
        <br/>
        <div id="topNav">
            <!--
            <a style="cursor:pointer" onclick="showInfoRightGrid(eval('dg1'))"><B>选择主组</B></a>
            -->
        </div>
        <br/><br/>
    </div>
</div> 
<div class="nui-fit">
    <div class="nui-splitter" style="width:100%; height:100%;display:;" id="panel1">
        <div size="40%" showCollapseButton="false">
            <div class="nui-fit">
                <!--主组-->
                <%@include file="/epc/vin/vinQuery_MainGroup.jsp" %>
            </div>
        </div>
        <div size="60%" showCollapseButton="false">
            <div class="nui-fit">
                <!--分组-->
                <%@include file="/epc/vin/vinQuery_SubGroup.jsp" %>
                <!--零件-->
<%--                 <%@include file="/epc/vin/vinQuery_Parts.jsp" %> --%>
<!--                 零件2 -->
                <%@include file="/epc/vin/vinQuery_Parts2.jsp" %>
            </div>
        </div>
    </div>
</div>