/**
 * Created by steven on 2018/1/31.
 */
baseUrl = apiPath + sysApi + "/";
var gridUrl = baseUrl + "com.hsapi.system.tenant.employee.queryEmployee.biz.ext";
var companyUrl = baseUrl+"com.hsapi.system.basic.organization.getCompanyAll.biz.ext";
var deptUrl = baseUrl + "com.hsapi.system.tenant.employee.queryDept.biz.ext";
var deptSaveUrl = baseUrl + "com.hsapi.system.tenant.employee.saveDept.biz.ext";
var grid;
var deptGrid;
var btnisDimission;
var btnisOpenAccount;
var btnisIM;
var orgidsEl = null;
nui.parse();


var SignHash = {
    "0":"否",
    "1":"是"
};

var sexSignHash = {
    "1":"男",
    "0":"女"
};
var isDimissionEl=null;
var isDimissionList=[{"id":0,"value":"否"},{"id":1,"value":"是"}];
//var isArtificerEl=null;
//var isMtadvisorEl=null;
//var isPchsStockEl=null;
$(document).ready(function(v) {
	grid = nui.get("datagrid1");
    btnisDimission = nui.get("btnisDimission");
    btnisOpenAccount = nui.get("btnisOpenAccount");
    btnisIM = nui.get("btnisIM");
	grid.setUrl(gridUrl);
	orgidsEl = nui.get("orgids");
	isDimissionEl =nui.get('isDimission');
	isDimissionEl.setData(isDimissionList);
//	isArtificerEl =nui.get('isArtificer');
//	isMtadvisorEl =nui.get('isMtadvisor');
//	isPchsStockEl =nui.get('isPchsStock');
//	isArtificerEl.setData(isDimissionList);
//	isMtadvisorEl.setData(isDimissionList);
//	isPchsStockEl.setData(isDimissionList);
	deptGrid = nui.get("deptGrid");
	deptGrid.setUrl(deptUrl);
	
    if(currIsMaster==0){
    	orgidsEl.hide();
    }else{
    	getCompany();
    }
    
    var request = {
        "params":{
        	
        }
    };
    request.params = getSearchParam();
    grid.load(request,function(){
        //成功;
       // nui.alert("数据成功！");
    },function(){
        //失败;
        showMsg("数据加载失败!","W");
    });
    
    deptGrid.load();

	//search();
	
    grid.on("drawcell", function (e){
    	onDrawCell(e);
    });
    
    if(currIsMaster==1){
    	nui.get("selectComBtn").setVisible(true);
    }else{
    	nui.get("selectComBtn").setVisible(false);
    }
});

function getCompany(){
	var params = {};
	nui.ajax({
        url: companyUrl,
        type: 'post',
        async:false,
        data: nui.encode({
        	params: params,
            token: token
        }),
        cache: false,
        success: function (data) {
            if (data.errCode == "S"){
            	orgidsEl = nui.get("orgids");
                orgidsEl.setData(data.companyList);
            }else {
            	orgidsEl = nui.get("orgids");
                orgidsEl.setData([]);
            }
        },
        error: function (jqXHR, textStatus, errorThrown) {
            console.log(jqXHR.responseText);
        }
	});
}

function onDrawCell(e)  {
    switch (e.field)  {
        case "isOpenAccount":
            if(SignHash && SignHash[e.value]) {
                e.cellHtml = SignHash[e.value];
            }
            break;
        case "isDimission":
            if(SignHash && SignHash[e.value]) {
                e.cellHtml = SignHash[e.value];
            }
            break;
//        case "isArtificer":
//            if(SignHash && SignHash[e.value]) {
//                e.cellHtml = SignHash[e.value];
//            }
//            break;
        case "isMtadvisor":
            if(SignHash && SignHash[e.value]) {
                e.cellHtml = SignHash[e.value];
            }
            break;
        case "isStockman":
            if(SignHash && SignHash[e.value]) {
                e.cellHtml = SignHash[e.value];
            }
            break;
        case "isCanfreeCarnovin":
            if(SignHash && SignHash[e.value]) {
                e.cellHtml = SignHash[e.value];
            }
            break;
        case "isCanSettle":
            if(SignHash && SignHash[e.value]) {
                e.cellHtml = SignHash[e.value];
            }
            break;
//        case "isPchsStock":
//            if(SignHash && SignHash[e.value]) {
//                e.cellHtml = SignHash[e.value];
//            }
//            break;
        case "imCode":
            if(e.record.imCode != null && e.record.imCode != null && e.record.imDisabled == 0) {
                e.cellHtml = "是";
            }else {
            	e.cellHtml = "否";
            }
            break;
        case "sex":
            if(sexSignHash && sexSignHash[e.value]) {
                e.cellHtml = sexSignHash[e.value];
            }
            break;
        case "tel":
        	e.cellHtml = changedTel(e);
            break;
        default:
            break;
    }
}

function search() {
    var param = getSearchParam();
    doSearch(param);
}

function getSearchParam(){
    var params = {};
    params.empName = nui.get("name").getValue().replace(/\s+/g, "");
    params.empTel = nui.get("mobile").getValue().replace(/\s+/g, "");
    params.isDimission =nui.get("isDimission").getValue();
//    params.isArtificer =nui.get("isArtificer").getValue();
//    params.isMtadvisor =nui.get("isMtadvisor").getValue();
//    params.isPchsStock =nui.get("isPchsStock").getValue();
    var orgidsElValue = orgidsEl.getValue();
    if(orgidsElValue==null||orgidsElValue==""){
        if(currIsMaster == "1"){
        	params.tenantId = currTenantId;
        }else{
        	params.orgid = currOrgId;
        }
    }else{
    	params.orgid=orgidsElValue;
    }
    return params;
}

function doSearch(params) {
    grid.load({
        params:params,
        token:token
    });
}



function edit(action) {
    var emp = {};
    
    if (action == 'new') {
    	data = {action: action};
    } else if(action =='edit'){
    	var row = grid.getSelected();
    	if (!row) {
    		nui.alert("请选中一条记录");
    		return;
    	}
    	emp = row;  	
    }

//    var url = webPath + contextPath + "/com.hs.common.employeeEdit.flow?token="+token;
    var width = 680;
//    var height = 550;
//    if(currCompType == 'PART'){
        url = webPath + contextPath + "/com.hs.common.partEmployeeEdit.flow?token="+token;
        height = 350;
//    }

    nui.open({
        url: url,
        width: width,         //宽度
        height: height,        //高度
        title: "员工信息",      //标题 组织编码选择
        allowResize:true,
        onload: function () {
            var iframe = this.getIFrameEl();
            iframe.contentWindow.SetInitData(emp);
        },
        ondestroy: function (action) {  //弹出页面关闭前
            if (action == "ok") {       //如果点击“确定”
                search();
            }
        }
    });	    
}
/*
*
*
*离职
*
*/
var dimssionUrl=baseUrl +"com.hsapi.system.tenant.employee.employeeDimssion.biz.ext";
function dimssion(){
	var s = grid.getSelected();

	if (s) {
	    nui.mask({
	        el : document.body,
	        cls : 'mini-mask-loading',
	        html : '处理中...'
	    });
        nui.ajax({
            url: dimssionUrl,
            type: 'post',
            async:false,
            data: nui.encode({
            	params: s,
                token: token
            }),
            cache: false,
            success: function (data) {
                if (data.errCode == "S"){
                	nui.unmask(document.body);
                	showMsg("操作成功!","S");
                	//grid.reload();
                }else {
                    nui.unmask(document.body);
                    showMsg("操作失败!","W");
                }

            },
            error: function (jqXHR, textStatus, errorThrown) {
                console.log(jqXHR.responseText);
            }
		});
                
        search();
        
	} else {
	    showMsg("请选中一条数据!","S");
	}
}

/*
*
*
*开通或关闭
*
*/
var stoporstartUrl= baseUrl +"com.hsapi.system.tenant.employee.openOrCloseUser.biz.ext";
function stoporstart(){
    var emp = {};
    var row = grid.getSelected();
    if (!row) {
        showMsg("请选中一条记录!","W");
        return;
    }

    if(row.isOpenAccount == 1){
    
        emp.isOpenAccount = 0;
        emp.empid = row.empid;
        emp.systemAccount = row.systemAccount;

        nui.mask({
            el : document.body,
            cls : 'mini-mask-loading',
            html : '处理中...'
        });
        nui.ajax({
            url: stoporstartUrl,
            type: 'post',
            async:false,
            data: nui.encode({
                comMember: emp,
                type: 0,
                token: token
            }),
            cache: false,
            success: function (data) {
                if (data.errCode == "S"){
                	var newRow = {isOpenAccount: 0};
                	grid.updateRow(row, newRow);
                    nui.unmask(document.body);
                    showMsg("操作成功!","S");
            

                }else {
                    nui.unmask(document.body);
                    showMsg("操作失败!","W");
                }

            },
            error: function (jqXHR, textStatus, errorThrown) {
                console.log(jqXHR.responseText);
            }
        });

    }else if(row.isOpenAccount == 0 && !row.systemAccount){
        emp = row;
        emp.passWord='000000'; 
        nui.open({
            url: webPath + contextPath + "/common/setAccount.jsp?token="+token,
            width: 330,      //宽度
            height: 180,    //高度
            title: "设置密码",      //标题 组织编码选择
            allowResize:true,
            onload: function () {
                var iframe = this.getIFrameEl();
                iframe.contentWindow.SetInitData(emp);
            },
            ondestroy: function (action) {  //弹出页面关闭前
                if (action == "OK") {       //如果点击“确定”
                    showMsg('开通帐号成功!',"s");
                    search();
                }
            }
        });

    }else if(row.isOpenAccount == 0 && row.systemAccount){

        emp.isOpenAccount = 1;
        emp.empid = row.empid;
        emp.systemAccount = row.systemAccount;

        nui.mask({
            el : document.body,
            cls : 'mini-mask-loading',
            html : '处理中...'
        });
        nui.ajax({
            url: stoporstartUrl,
            type: 'post',
            async:false,
            data: nui.encode({
                comMember: emp,
                type: 1,
                token: token
            }),
            cache: false,
            success: function (data) {
                if (data.errCode == "S"){
                    nui.unmask(document.body);
                    showMsg("操作成功!","S");

                    var newRow = {isOpenAccount: 1};
                    grid.updateRow(row, newRow);

                }else {
                    nui.unmask(document.body);
                    showMsg("操作失败!","W");
                }

            },
            error: function (jqXHR, textStatus, errorThrown) {
                console.log(jqXHR.responseText);
            }
        });

    }
    search();	
    
}
	

function changebutton(){
	var s = grid.getSelected ();
	if(s){
        if (s.isOpenAccount==0) btnisOpenAccount.setText("<span class='fa fa-key'></span>&nbsp;开通账号");
	    else btnisOpenAccount.setText("<span class='fa fa-key'></span>&nbsp;关闭账号");

        if (s.isDimission==0){
        	btnisDimission.setText("<span class='fa fa-user-times'></span>&nbsp;离职");
        	btnisOpenAccount.setVisible(true);
        }else{
        	btnisDimission.setText("<span class='fa fa-user'></span>&nbsp;复职");
        	btnisOpenAccount.setVisible(false);
        }
        
        if (((s.imCode=="" || s.imCode == null) && s.imDisabled == 0) || s.imDisabled == 1){
        	btnisIM.setText("<span class='fa fa-key'></span>&nbsp;开通聊天");
        }else{
        	btnisIM.setText("<span class='fa fa-key'></span>&nbsp;关闭聊天");
        }
	}
}
function importGuest(){

    nui.open({
        // targetWindow: window,
        url: webPath + contextPath + "/com.hs.common.importEmployee.flow?token="+token,
        title: "员工导入", 
        width: 930, 
        height: 560,
        allowDrag:true,
        allowResize:true,
        onload: function ()
        {
        },
        ondestroy: function (action)
        {
            search();
        }
    });
}
function resetPassword(){
    var rows = grid.getSelecteds();
    if(rows.length>0){
        nui.confirm("确定将密码重置为000000？","系统提示",
        function(action){
          if(action=="ok"){
             var json = nui.encode({members:rows,token:token});
             var a= nui.loading("正在重置中,请稍等...","提示");
             $.ajax({
               url:apiPath + sysApi + "/com.hsapi.system.tenant.employee.resetPassword.biz.ext",
               type:'POST',
               data:json,
               cache: false,
               contentType:'text/json',
               success:function(text){
                   nui.hideMessageBox(a);
                 var returnJson = nui.decode(text);
                 if(returnJson.errCode == 'S'){
                     showMsg("重置密码成功", "S");
                     grid.reload();
                 }else{
                     showMsg("重置密码失败", "W");
                     grid.unmask();
                 }
               }
             });
          }
        });
    }else{
        nui.alert("请选中一条记录！");
    }
 }

function selectCom(){
	var row = grid.getSelected();
    if(row){
    	nui.open({
            // targetWindow: window,
            url: webPath + contextPath + "/common/employeeHaveCompany.jsp?token="+token,
            title: "选择兼职公司", 
            width: 730, 
            height: 360,
            allowDrag:true,
            allowResize:true,
            onload: function ()
            { 
            	var iframe = this.getIFrameEl();
                iframe.contentWindow.setDataSelect(row);
            },
            ondestroy: function (action)
            {
                
            }
        });  
    }else{
        nui.alert("请选中一条记录！");
    }
}

function lookCom(){
	var row = grid.getSelected();
    if(row){
    	nui.open({
            // targetWindow: window,
            url: webPath + contextPath + "/common/existCompany.jsp?token="+token,
            title: "兼职公司", 
            width: 700, 
            height: 300,
            allowDrag:true,
            allowResize:true,
            onload: function ()
            { 
            	var iframe = this.getIFrameEl();
                iframe.contentWindow.setData(row);
            },
            ondestroy: function (action)
            {
                
            }
        });  
    }else{
        nui.alert("请选中一条记录！");
    }
}

function stoporstartIM() {
	var emp = {};
	var type = "";
    var row = grid.getSelected();
    if (!row) {
        showMsg("请选中一条记录!","W");
        return;
    }
    
    if(row.imCode == null || row.imCode == "" || row.imDisabled == 1) {
    	type = "open";
    }else {
    	type = "close";
    }
    
    nui.mask({
        el : document.body,
        cls : 'mini-mask-loading',
        html : '处理中...'
    });
    nui.ajax({
        url: apiPath + sysDomain + "/com.hsapi.system.tenant.employee.openOrCloseIM.biz.ext",
        type: 'post',
        async:false,
        data: nui.encode({
            empId: row.empid,
            type: type,
            token: token
        }),
        cache: false,
        success: function (data) {
            if (data.errCode == "S"){
                nui.unmask(document.body);
                showMsg("操作成功!","S");
                
                search();

            }else {
                nui.unmask(document.body);
                showMsg("操作失败!","W");
            }

        },
        error: function (jqXHR, textStatus, errorThrown) {
            console.log(jqXHR.responseText);
        }
    });
}



function changedTel(e) {
    var value = e.value;
    var res = {};
    value = "" + value;
    if(e.value){
        if(e.record.openId){
            res =  '<span id="wechatTag" class="fa fa-wechat fa-lg"></span>&nbsp;'+value;
                /*e.cellHtml = "<span id='wechatTag' class='fa fa-wechat fa-lg'></span>"+value;*/
        }else{
            res =  '<span id="wechatTag1" class="fa fa-wechat fa-lg"></span>&nbsp;'+value;
        }
    }else{
        res="";
    }
    return res;
}

function addDept() {
	/*deptGrid.findRow(function(row){
		var id = row.id;
		var deptName = row.deptName;
		if((id == null || id == "") && (deptName == null || deptName == "")){
			deptGrid.removeRow(row);
		}
	});*/
	var newRow = {};
	deptGrid.addRow(newRow);
	deptGrid.beginEditRow(newRow);
}

function editDept() {
	var row = deptGrid.getSelected();
	if(row) {
		deptGrid.beginEditRow(row);
	}else {
		showMsg("请选中一条记录!","W");
	}
}

function saveDept() {
	deptGrid.commitEdit();
	
	var row = deptGrid.findRow(function(row){
		var id = row.id;
		var deptName = row.deptName;
		if(deptName == null || deptName == ""){
			return true;
		}
	});
	if(row) {
		showMsg("存在部门名称为空的数据，请完善后再保存","W");
		return;
	}
	
	nui.mask({
        el : document.body,
        cls : 'mini-mask-loading',
        html : '处理中...'
    });
    nui.ajax({
        url: deptSaveUrl,
        type: 'post',
        async:false,
        data: nui.encode({
        	add: deptGrid.getChanges("added"),
        	update: deptGrid.getChanges("modified"),
            token: token
        }),
        cache: false,
        success: function (data) {
            if (data.errCode == "S"){
            	nui.unmask(document.body);
            	showMsg("保存成功!","S");
            	//grid.reload();
            }else {
                nui.unmask(document.body);
                showMsg("保存失败!","W");
            }

        },
        error: function (jqXHR, textStatus, errorThrown) {
            console.log(jqXHR.responseText);
            nui.unmask(document.body);
        }
	});
    
    deptGrid.load();
}










