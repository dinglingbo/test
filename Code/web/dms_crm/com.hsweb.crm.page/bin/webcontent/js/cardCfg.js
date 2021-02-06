var grid1 = null;
var grid2 = null;
var tabs = null;
var _id = null;
$(document).ready(function (v)
{
   grid1 = nui.get("grid1");
   grid2 = nui.get("grid2");
   tabs = nui.get("tabs");
   
   tabs.on("activechanged",function(e){
	   _id = e.tab._id;
	   if(_id == 1){
		   grid1.load();
	   }else{
		   grid2.load();
	   }
   });
});

function onSearch(){
	if(_id == 1){
	   grid1.load();
   }else{
	   grid2.load();
   }
}

function addOrEditInsurance(comguest) 
{
	var title = "新增";
    if(comguest)
    {
        title = "修改";
    }
    nui.open({
      url : webPath + contextPath + "/page/cardMgr/cardStoredCgf.jsp",
      title : title,
      width : "830px",
      height : "370px",
      onload : function() {
    	  var iframe = this.getIFrameEl();
          var params = {};
          if (comguest) {
              params.comguest = comguest;
          }
          params.number = _id;
          iframe.contentWindow.setData(params);
      },
      ondestroy : function(action) {
      }
    });
}

function addInsurance()
{
    addOrEditInsurance();
}

function editInsurance(comguest) 
{
    addOrEditInsurance(comguest);
}

function add() {
    addInsurance();
}

function edit() {
	var row = null;
	if(_id == 1){
		row = grid1.getSelected();
	}else{
		row = grid2.getSelected();
	}
	
    if (row) {
        editInsurance(row);
    }
}

