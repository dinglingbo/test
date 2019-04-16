/**
 * Created by Administrator on 2018/4/27.
 */
var getUrl = apiPath + repairApi + "/com.hsapi.repair.baseData.cardTimes.getCardTimes.biz.ext";

var form = null;
var form1 = null
//页面加载时获取 form
$(document).ready(function (v)
{
	form = new nui.Form("#dataform1");//获取表单的
	form1 = new nui.get("datagrid1");//获取表格的
		    
});


function setData(data){
	 data = nui.clone(data);
	 var json = nui.encode({
		 cardTimes:data,
		 token : token	 
	 });
	$.ajax({
	   url:getUrl,
	  type:'POST',
	  data:json,
	  cache:false,
	  contentType:'text/json',                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                
	  success:function(text){
	  
	    var obj = nui.decode(text);
	    
	    form.setData(obj.cardTimes);
	    
	    if(obj.cardTimes.periodValidity == -1){
	    	nui.get("periodValidity").setValue("永久有效") ;
	    }
	    form.setChanged(false);
	    form1.setData(obj.cardTimesDe);    
	    //form1.setChanged(false);表格没有这个属性
	  }
  });
}


//这是表格才有的属性
function onDrawCell(e)
{
	var hash = new Array("套餐", "项目", "配件");
  switch (e.field)
  {
      
      case "oldPrice":
          e.cellHtml = "￥"+e.value;
          break;
      case "sellPrice":
          e.cellHtml = "￥"+e.value;
          break;
      case "oldAmt":
    	  e.cellHtml = "￥"+e.value;
          break; 
      case "sellAmt":
          e.cellHtml = "￥"+e.value;
          break; 
  	case "prdtType":
		e.cellHtml = hash[e.value - 1];
		break;
      default:
          break;
  }

}






