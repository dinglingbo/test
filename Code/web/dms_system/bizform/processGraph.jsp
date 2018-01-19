<%@page import="com.primeton.bps.web.control.I18nUtil"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false" %>
	
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<!-- 
  - Author(s): yangyong
-->
<head>
<title><%=I18nUtil.getMessage(request, "bps.bizform.ProcessGraph") %></title>
<%@include file="/bizform/bizformCommon.jsp" %>
</head>
<body>
	<div class="container">
		<div class="procContainer">
			<div id="processGraph" class="nui-bps-processgraph" showParticipants="true" showZoomCombo="false"></div>
		</div>
		<div class="zoomContainer">
			<div class="zoom" onclick="zoomIncrease()">+</div> 
			<div class="zoom" onclick="zoomDecrease()">-</div>
		</div>
	</div>
	<script type="text/javascript">
    	nui.parse();
	    var processGraph = nui.get("processGraph");
	    processGraph.setProcInstID(bps.components.core.getPageContext().processInstID);
	    processGraph.load();

		var quotieties = [0.4,0.55,0.7,0.85,1,1.5,2];
		var currentIndex = 4;

	    function zoomIncrease() {
			currentIndex = getCurrentPos();
			currentIndex ++;
			if(currentIndex > quotieties.length-1){
				 return;
			}
			processGraph.setZoomQuotiety(quotieties[currentIndex]);
	    	processGraph.load();
	    }

		function zoomDecrease(){
			currentIndex = getCurrentPos();
			currentIndex --;
			if(currentIndex < 0){
				 return;
			}
			processGraph.setZoomQuotiety(quotieties[currentIndex]);
	    	processGraph.load();
		}
		
		function getCurrentPos(){
			var curZoom = processGraph.getZoomQuotiety();
			for(var i=0;i<quotieties.length;i++){
				if(curZoom==quotieties[i]){
					return i;
				}
			}
		}
    </script>
</body>
</html>
