/**
 * Created by Administrator on 2018/4/27.
 */
var gridUrl = apiPath + repairApi + "/com.hsapi.repair.baseData.cardTimes.queryCardTimesList.biz.ext";
var CardUrl = webPath + partDomain + "/repair/CardTimes/CardTimesBase.jsp";
var getTimes = apiPath + repairApi + "/com.hsapi.repair.baseData.cardTimes.getCardTimesDe.biz.ext";
var grid = null;
/*进来该页面，加载套餐列表数据*/
$(document).ready(function (v)
{
    grid  = nui.get("datagrid1");
    grid.setUrl(gridUrl);
    grid.load();
});


//编辑
function searchOne() {

  var row = grid.getSelected();
  if (row) {
    nui.open({
      url:CardUrl,
      title: "计次卡基本信息",
      width: 1200,
      height: 600,
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
    
          //重新刷新页面
        function refresh(){
            var form = new  nui.Form("#queryform");
            var json = form.getData(false,false);
            grid.load(json);//grid查询
            nui.get("update").enable();
          }

              
          var hash = new Array("草稿","已提交","未提交");

          function onDrawCell(e)
          {
        	
            switch (e.field)
            {
                
                case "sellAmt":
                    e.cellHtml = "￥"+e.value;
                    break;
                case "ser":
                    e.cellHtml = "￥";
                    break;
                case "status":
                /*e.cellHtml = e.value==1?"禁用":"启用";*/
                	e.cellHtml = hash[e.value];
                    break; 
                //测试的
                case "id":
                    /*e.cellHtml = e.value==1?"禁用":"启用";*/
                    	e.cellHtml = getData(id);
                        break; 
                    
                default:
                    break;
            }
        }

//      这只是测试的，如何传递参数到逻辑流？？
     
          function getData(id){      
          var id = nui.clone(id);
          var json = nui.encode({"Id":id});
          var data = null;
          $.ajax({
            url:getTimes,
            type:'POST',
            data:json,
            cache:false,
            contentType:'text/json',                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                
            success:function(text){
            var obj = nui.decode(text);
            data = obj.cardTimDe;
            }
            });
          return data;
          }

