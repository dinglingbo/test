/**
 * Created by Administrator on 2018/4/27.
 */
//var queryFormUrl = apiPath + repairApi + "/ com.hsapi.repair.baseData.cardTimes.test.biz.ext";
var queryFormUrl = apiPath + repairApi + "/com.hsapi.repair.baseData.cardTimes.queryCardTimesList.biz.ext";
var CardUrl = webPath + contextPath + "/repair/DataBase/Card/rpsCardTimesBase.jsp?token="+token;
//var getTimes = apiPath + repairApi + "/com.hsapi.repair.baseData.cardTimes.getCardTimesDe.biz.ext";
var grid = null;
var queryForm = null;
/*进来该页面，加载套餐列表数据*/
$(document).ready(function (v)
{
    grid  = nui.get("datagrid1");
    queryForm = new nui.Form("#queryForm");
    var date = new Date();
    var sdate = new Date();
    sdate.setMonth(date.getMonth()-3);
   
    var startDate = mini.get("startDate");
    //startDate.setValue(sdate);
    
    var endDate = mini.get("endDate");
    endDate.setValue(date);
    
    
    var query = {
    		startDate:sdate,
    		endDate:date
    }; 
    grid.setUrl(queryFormUrl);
    grid.load({
    	query:query,
    	token : token
    });
       
   //alert(date.format('dd/MM/yyyy hh:mm:ss'));
    //date.dateFormat("yyyy-MM-dd hh:mm:ss");
});


//查看
function searchOne() {

  var row = grid.getSelected();
  if (row) {
    nui.open({
      url:CardUrl,
      title: "计次卡基本信息",
      width: 1200,
      height: 620,
      onload: function () {
    	var iframe = this.getIFrameEl();
        var data = row;
        //直接从页面获取，不用去后台获取
        
        iframe.contentWindow.setData(data);
        
        },
         
        });
      } else {
        nui.alert("请选中一条记录","提示");
      }
    }
    
 
//增加次卡套餐
var addcardTimeUrl = webPath + contextPath  + "/repair/DataBase/Card/timesCardList.jsp?token"+token;
function dealtWithCard(){	
 	nui.open({
 		url : addcardTimeUrl,
 		title : "次卡办理",
 		width : 965,
 		height : 573,
 		onload : function() {
 		    var iframe = this.getIFrameEl();
 			iframe.contentWindow.setStely();
 		},
 		/*ondestroy : function(action) {// 弹出页面关闭前
 			if (action == "saveSuccess") {
 				grid.reload();
 			}
 		}*/
 	});
 	
 }
 
 
  //重新刷新页面
function refresh(){
    var form = new  nui.Form("#queryform");
    var json = form.getData(false,false);
    grid.load(json);//grid查询
    nui.get("update").enable();
	/*grid  = nui.get("datagrid1");
    grid.setUrl(gridUrl);
    grid.load();*/
  }

      
  var hash = new Array("草稿","已提交","已结算");

  //剩余次数
  var balaTimes = null;
  //总次数
  var totalTimes = null;
  //剩余可使用次数
  var canUseTimes = null;
  var id = null;
  function onDrawCell(e)
  {
	  var  d = totalTimes;
	
    switch (e.field)
    {
        
    case "sellAmt":
        e.cellHtml = "￥"+e.value;
        break;
    case "status":
    /*e.cellHtml = e.value==1?"禁用":"启用";*/
    	e.cellHtml = hash[e.value];
        break; 
    /*case "pastDate":
    	e.cellHtml = (e.value == -1 ? "永久有效":e.value);
    	break;*/
  /*  case "id":
    	id = e.value;
    	break;*/
    default:
        break;
    }
}

 //快速查询
 
 function onSearch()
 {
	var query = queryForm.getData();
	grid.load({
    	query:query,
    	token : token
    });
 }
 
 //查明细
 var searchDetialUrl = apiPath + repairApi + "/com.hsapi.repair.baseData.cardTimes.getCardTimesDe.biz.ext";
 function searchDetial(id){
	 
	 var infor = null;
	 var json = nui.encode({
		 Id:id,
		 token:token
	 });
	 nui.ajax({
	        url : searchDetialUrl,
	        type : 'POST',
	        data : json,
	        cache : false,
	        contentType : 'text/json',
	        success : function(text) 
	        {
	            var object = nui.decode(text);
	            var cardTimeDe = object.cardTimDe;
	            if(cardTimeDe != null)
	            {
	            	for(var i = 0;i<cardTimeDe.length;i++)
	            	{
	            		infor = infor + cardTimeDe[i].prdtName + "总次数【"+ cardTimeDe[i].balaTimes+"】,剩余次数【"+cardTimeDe[i].balaTimes+"】"
	            	}
	            }
	        }
	 });
	 
	 return infor;
	
 }
  
