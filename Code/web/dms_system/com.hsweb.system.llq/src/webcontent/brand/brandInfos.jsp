<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false" %>

<div class="nui-splitter" style="width:100%;height:60px;" style="border:0;" handlerSize=0>
    <div size="15%" showCollapseButton="false" style="border:0;">
        <br/>
        <center id="groupButton">
            <a class="nui-button groupButton2" onclick="ntab.activeTab(ntab.getTab(0));">车型选择</a>&nbsp;
            <a class="nui-button groupButton2" onclick="showInfoRightGrid(gridSubGroup)">主组/分组</a>&nbsp;
            <a class="nui-button groupButton2" style="display:none;" onclick="showInfoRightGrid(gridParts)">零件</a>
        </center>
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
                <%@include file="/llq/vin/vinQuery_MainGroup.jsp" %>
            </div>
        </div>
        <div size="60%" showCollapseButton="false">
            <div class="nui-fit">
                <!--分组-->
                <%@include file="/llq/vin/vinQuery_SubGroup.jsp" %>
                <!--零件-->
                <%@include file="/llq/vin/vinQuery_Parts.jsp" %>
            </div>
        </div>
    </div>
</div>