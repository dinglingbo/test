/**
 * Created by Administrator on 2018/4/27.
 */
var gridUrl = apiPath + repairApi + "/com.hsapi.repair.baseData.crud.queryPackage.biz.ext";
var grid = null;
var resultData = {};
$(document).ready(function (v)
{
    grid  = nui.get("datagrid1");
    grid.setUrl(gridUrl);
    var formData = new nui.Form("#queryform").getData(false,false);
    grid.load(formData);
});
     
//选择
function edit() {
	var row = grid.getSelected();
	if (row) {
        resultData.package1= row;
        CloseWindow("ok");
	      } else {
	        nui.alert("请选择一个工时","提示");
	 }
}

function CloseWindow(action)
{
	if (window.CloseOwnerWindow)
		return window.CloseOwnerWindow(action);
	else window.close();
}

          //重新刷新页面
          function refresh(){
            var form = new  nui.Form("#queryform");
            var json = form.getData(false,false);
            grid.load(json);//grid查询
            nui.get("update").enable();
          }

          //查询
          function search() {

            var form = new nui.Form("#queryform");
            var json = form.getData(false,false);
            grid.load(json);//grid查询
          }

          //重置查询条件
          function reset(){
            var form = new nui.Form("#queryform");//将普通form转为nui的form
            form.reset();
          }

          //enter键触发查询
          function onKeyEnter(e) {
            search();
          }

          //当选择列时
          function selectionChanged(){
            var rows = grid.getSelecteds();
            if(rows.length>1){
              nui.get("update").disable();
            }else{
              nui.get("update").enable();
            }
          }

          function onDrawCell(e)
          {
            var hash = new Array("按原价比例","按折后价比例","按产值比例","固定金额");
            switch (e.field)
            {
                case "useRange":
                    e.cellHtml = e.value==1?"连锁":"本店";
                    break;
                case "canModify":
                    e.cellHtml = e.value==1?"是":"否";
                    break;
                case "packageRate":
                    e.cellHtml = e.value+"%";
                    break;
                case "itemRate":
                    e.cellHtml = e.value+"%";
                    break;
                case "partRate":
                    e.cellHtml = e.value+"%";
                    break;
                case "salesDeductType":
                    e.cellHtml = hash[e.value];
                    break;
                case "status":
                e.cellHtml = e.value==1?"禁用":"启用";
                    break; 
                default:
                    break;
            }
        }


        function getData()
        {
            return resultData;
        }
        function setData(data)
        {
            list = data.list||[];
            nui.get("selectBtn").show();
        }

