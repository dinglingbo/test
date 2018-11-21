var queryForm; //查询表单
var dgGrid; //列表
var baseUrl = apiPath + crmApi + "/"; 
var queryDatumMgrListUrl = baseUrl+"com.hsapi.crm.telsales.crmTelsales.getDatumMgrList.biz.ext";
var tracker;
var tree1;
var tree2;
var currType1Node;//品牌
var currType2Node;//营销员
var memList = [];
var memHash={};

var assignStatus;

$(document).ready(function(v){
    queryForm = new nui.Form("#queryForm");
    assignStatus = nui.get("assignStatus");
    tracker = nui.get("tracker");
    memList = nui.get("tree2");
    tree1 = nui.get("tree1");
   //tree2 = nui.get("tree2");
    dgGrid = nui.get("dgGrid");
    dgGrid.setUrl(queryDatumMgrListUrl);
//    dgGrid.on("beforeload",function(e){
//    	e.data.token = token;
//    });
    dgGrid.load({token :token});
    dgGrid.on("drawcell", function (e) { //表格绘制
        var field = e.field;
        if(field == "orgid"){
            e.cellHtml = setColVal('query_orgid', 'orgid', 'orgname', e.value);
        }else if(field == "carBrandId"){//品牌
            e.cellHtml = setColVal('tree1', 'id', 'nameCn', e.value);
        //}else if(field == "carModelId"){//车型
            //e.cellHtml = setColVal('carModelId', 'carModelId', 'carModel', e.value);
        }else if(field == "visitManId"){//营销员
            if(memHash[e.value]){
            	e.cellHtml = memHash[e.value].empName || "";
            }
        }else if(field == "visitStatus"){//跟踪状态
            e.cellHtml = setColVal('visitStatus', 'customid', 'name', e.value);
        }

    });
    initMember("tree2",function(){
        memList = memList.getData();
        memList.forEach(function(v) {
			memHash[v.empId] = v;
		});
        nui.get("tree2").setData(memList);
        query1();
    });
    
    init();
    query(0);
    
    document.onkeyup = function(event) {
        var e = event || window.event;
        var keyCode = e.keyCode || e.which;// 38向上 40向下
        

        if ((keyCode == 13)) { // F9
        	query(0);
        }
    }
 
});

function init(){
    initComp("query_orgid");//公司组织
    initCarBrand("tree1");//车辆品牌
    //initInsureComp("insureCompCode");//保险公司
    initDicts({
        //isCome: "DDT20150303000004",//来厂状态
        visitStatus: "DDT20130703000081"//跟踪状态
    });

    
}
/*
 *查询
 **/
function query(e){
    var params = {};
    var data = getQueryValue();
    if(e == 0){
    	data = queryForm.getData();
    }
    params.p = data;

//    dgGrid.load(params,null,function(){
//        //失败;
//        showMsg("数据加载失败！");
//    });

    dgGrid.load({p:params.p,token:token});

}

function query1(){

    tracker.setData(memList);//设置营销员下拉数据
}
function clearQueryForm(){
    queryForm.setData({});
    currType1Node = null;//品牌
    currType2Node = null;//营销员
    setMenu1(nui.get("typeAll"), assignStatus, -1);
}

/*
 *设置菜单
 **/
function setMenu1(obj, target, value){
    target.setValue(value);
    target.setText(obj.getText());   
    //query(0);     
    var params={ 
            assignStatus:value 
        };
    dgGrid.load({p:params,token:token});
}

/*
 *快速查询参数
 **/
function getQueryValue(){
    var params = queryForm.getData();
    params.assignStatus = assignStatus.getValue();
    
    if(currType1Node){//品牌
        params.carBrandId = currType1Node.id;
    }
    
    if(currType2Node){//营销员
        params.visitManId = currType2Node.empId;
    }
    
    return params;
}

//品牌
function onType1DbClick(e){
    var node = e.node || currType1Node;
    if(!node){
        return;
    }
    
    currType1Node = node;
    query(1);    
}

//营销员
function onType2DbClick(e){
    var node = e.node || currType2Node;
    if(!node){
        return;
    }
    
    currType2Node = node;
    query(1);    
}

//设置跟踪状态、营销员
function updateField(field, value){
    var rows = dgGrid.getSelecteds();
    if(rows.length==0){
        showMsg("请选择记录数据！","W");
        return;
    }
    var params = [];
    for(var i=rows.length - 1; i>=0; i--){
        var obj={id: rows[i].id};
        obj[field] = value;
        params.push(obj);
    }
    
    var url = baseUrl + "com.hsapi.crm.telsales.crmTelsales.updateGuest.biz.ext";
    callAjax(url, {datas: params}, processAjax, reLoadMain, null);
}

//分配营销员
function assignTracker(){
    var value = tracker.getValue();
    if(!value){
        showMsg("请选择营销员！","W");
        return false;
    }
    updateField("visitManId", value);
}

function reLoadMain(data, json){
    if(json.errCode == "S"){
        showMsg("设置成功！","S");
        dgGrid.reload();
    }
}

function add(){
    editWin("新增模板", {});
}

//修改资料
function editGuestInfo(){
    var row = dgGrid.getSelected();
    if (row) {
        editWin("修改模板", row);
    } else {
    	showMsg("请选中一条记录","W");
    }
}

function editWin(title, data){
    data.artType = tree1.getData();
    nui.open({
        url: webPath + contextPath+ "/com.hsweb.crm.manage.investDetail.flow?token="+ token,
        title: title, width: 400, height: 300,
        onload: function () {
            var iframe = this.getIFrameEl();
            //var data = { action: "edit", id: row.id };
            iframe.contentWindow.setData(data);
        },
        ondestroy: function (action) {
            //var iframe = this.getIFrameEl();
            dgGrid.reload();
        }
    });
}