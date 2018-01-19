<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>

<%@include file="/common/common.jsp"%>
<%@include file="/common/skins/skin0/component.jsp"%>

<html>
<head>
<title>Datacell</title>
<script>
		function myrefresh(value,entity,rowno,colno){
			return '<font color="red">'+value+'</font>';
		}
		function mmmm(value,entity,dataset,rn,cn){
			
			return getTextFromSelectByValue(value);
		}
		
		function getTextFromSelectByValue(value){
			
			return "<span style='color:red'>"+value+"</span>";
		
		}

</script>
</head>
<body >
	<r:datacell id="datacell1" width="500" height="300" pageSize="1000">
		<r:field fieldId="packageName" fieldName="packageName" onRefreshFunc="mmmm" >
			<select id="sssss"><option value="ss">ssoi</option><option value="ee">tttt</option></select>
		</r:field>
		<r:toolbar tools="edit" />
	</r:datacell>
	
	<script>
		var dd=$o('datacell1');
		dd.afterSelectRow=function(){
				var entity=dd.getEntity(dd.activeRow);
				//alert(entity.getProperty('packageName'));
				//entity.setProperty('packageName',"jjjj");
				//dd.refreshRow(dd.activeRow);
				
		}
		
		dd.showIndex=false;
		dd.dataXML="json";
		dd.dataset= Json2Dataset( myjson );

function myrefresh(){
	var dd=$o('datacell1');
			dd.dataXML="json";
		dd.dataset= Json2Dataset( newjson );
			dd.refresh();
}
		
	</script>
</body>
</html>