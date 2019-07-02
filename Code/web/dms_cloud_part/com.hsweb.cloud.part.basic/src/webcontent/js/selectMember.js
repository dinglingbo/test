

var baseUrl = apiPath + cloudPartApi + "/"
var roleGrid = null;
var deductMemGrid = null;
var haveSelectGrid =null;
var pname = null;
var memName = null;
var roleUrl = baseUrl+"com.hsapi.cloud.part.baseDataCrud.crud.queryDeductRole.biz.ext";
var deductMemUrl = baseUrl+"com.hsapi.cloud.part.baseDataCrud.crud.queryDeductMember.biz.ext";
var haveSelectGridUrl = baseUrl+"com.hsapi.cloud.part.baseDataCrud.crud.queryDeductMem.biz.ext";
var frole = {};
var typehash = {
	"1":"按销售金额提成",
	"2":"按销售毛利提成"
}
var roleHash ={};
var serviceId =null;
var typeList = [{id:"1",name:"按销售金额提成"},{id:"2",name:"按销售毛利提成"}];
var haveSelectHash={};
$(document).ready(function(v)
{
	roleGrid = nui.get("roleGrid");
	roleGrid.setUrl(roleUrl);
	roleGrid.on("preload",function(e){
		var result=e.result;
		var resultList=result.data;
		for(var i=0;i<resultList.length;i++){
			roleHash[resultList[i].id]=resultList[i];
		}
        
    });
	
	deductMemGrid = nui.get("deductMemGrid");
	deductMemGrid.setUrl(deductMemUrl);
	deductMemGrid.on("beforeload",function(e){
        e.data.token = token;
    });
	
	haveSelectGrid=nui.get('haveSelectGrid');
	haveSelectGrid.setUrl(haveSelectGridUrl);
	
	
	roleGrid.on("selectionchanged",function(e) {
		var row = e.selected;
		var roleId = row.id;
		
		if(roleId) {
			frole.id = roleId;
			frole.name = row.name;
			var params = {
				roleId: roleId
			};
			deductMemGrid.load({
				token:token,
				params:params
			});
		}else {
			deductMemGrid.setData([]);
			frole.id = null;
			frole.name = null;
		}
	});
	
	deductMemGrid.on("drawcell",function(e){
		var data =deductMemGrid.getData();
		var selectdData =[];
		deductMemGrid.deselectAll();
		for(var i=0;i<data.length;i++){
			if(haveSelectHash[data[i].id]){
				deductMemGrid.select(data[i]);
			}
		}
	});
	deductMemGrid.on("selectionchanged",function(e) {
		var row = e.selected;
		var deductMemId = row.id;
		
	});
	
	haveSelectGrid.on("drawcell",function(e){
        switch (e.field)
        {
            case "roleId":
                if(roleHash[e.value])
                {
//                    e.cellHtml = brandHash[e.value].name||"";
                	if(roleHash[e.value].name){
                		
                		e.cellHtml = roleHash[e.value].name;
                	}else{
                		e.cellHtml = brandHash[e.value].name||"";
                	}
                }
                else{
                    e.cellHtml = "";
                }
                break;
            default:
                break;
        }
    });

	roleGrid.load();
});

var saveUrl=baseUrl+"com.hsapi.cloud.part.baseDataCrud.crud.saveBillDeductMem.biz.ext";
function save(){
	var roleId =roleGrid.getSelected().id;
	var data =[];
	var rows = deductMemGrid.getSelecteds();
	for(var i=0;i<rows.length;i++){
		var temp={};
		temp.orgid =currOrgid;
		temp.serviceId = nui.get("serviceId").getValue();
		temp.roleId =roleId;
		temp.deductMemId =rows[i].id;
		temp.deductMemName =rows[i].name;
		temp.creatorId =currEmpId;
		temp.creator =currUserName;
		temp.createDate =format(new Date(), 'yyyy-MM-dd HH:mm:ss');
		temp.operatorId =currEmpId;
		temp.operator =currUserName;
		temp.operateDate =format(new Date(), 'yyyy-MM-dd HH:mm:ss');
		data.push(temp);
	}
	nui.mask({
		el : document.body,
		cls : 'mini-mask-loading',
		html : "保存中..."
	});
    nui.ajax({
        url:saveUrl,
        type:"post",
        data:JSON.stringify({
        	data:data,
        	orgid: currOrgid,
        	serviceId :nui.get("serviceId").getValue(),
        	roleId:roleId,
            token:token
        }),
        success:function(data)
        {
            nui.unmask();
            data = data||{};
            if(data.errCode == "S")
            {
            	nui.unmask();
            	showMsg(data.errMsg||"保存成功","S");
            	haveSelectGrid.reload(function(data){
            		var data =data.data;
            		haveSelectHash={};
            		data.forEach(function(v){
            			haveSelectHash[v.deductMemId]=v;
                	});
            		deductMemGrid.relaod();
            	});
            }
            else{
            	nui.unmask();
                showMsg(data.errMsg||"保存失败","E");
            }
        },
        error:function(jqXHR, textStatus, errorThrown){
        	nui.unmask();
            //  nui.alert(jqXHR.responseText);
            console.log(jqXHR.responseText);
        }
    });
}

function close(){
	window.CloseOwnerWindow();	
}
function search(){
	var params ={};
	var name =nui.get('name').getValue();
	if(!roleGrid.getSelected()){
		return;
	}
	var roleId =roleGrid.getSelected().id;
	if(!roleId){
		showMsg("请先选择角色","W");
	}
	params.roleId =roleId;
	params.name =name
	deductMemGrid.load({
		token:token,
		params:params
	});
}

function CloseWindow(action) {
	if (action == "close") {
	} else if (window.CloseOwnerWindow)
		return window.CloseOwnerWindow(action);
	else
		return window.close();
}
function setData(serviceId){
	nui.get('serviceId').setValue(serviceId);
	serviceId =serviceId;
	haveSelectGrid.load({serviceId:serviceId,orgid:currOrgid},function(data){
		var data =data.data;
		haveSelectHash={};
		data.forEach(function(v){
			haveSelectHash[v.deductMemId]=v;
    	});
	});
}