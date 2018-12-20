
var baseUrl = apiPath + repairApi + "/";



$(document).ready(function(v) {


	team();
	Project();
   
    

});



function team(){
	var data = [
	            {id:"0",name:"所有"},{id:"1",name:"中级技师"},{id:"2",name:"高级技师"}
	 ];
	var str = "";
	for(var i = 0;i<data.length;i++){
		str = str+"<a  class='none' 	>"+data[i].name+"</a>";
	}
	document.getElementById("team").innerHTML=str; 
}

function Project(){

	var data = [
	             {id:"0",name:"保养"},{id:"1",name:"维修"},{id:"2",name:"钣喷"}
	             ];
	var str = "";
	for(var i = 0;i<data.length;i++){
		str = str+"<a  class='none' style='padding: 0px 10px;margin-bottom: 0;border-radius: 4px;line-height: 24px;'>"+data[i].name+"</a>";
	}
	document.getElementById("Project").innerHTML=str; 
}