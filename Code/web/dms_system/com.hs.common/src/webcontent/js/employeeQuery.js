/**
 * Created by steven on 2018/1/31.
 */
baseUrl = apiPath + sysApi + "/";
var gridUrl = baseUrl + "com.hsapi.system.tenant.employee.queryEmployee.biz.ext";
var companyUrl = baseUrl+"com.hsapi.system.basic.organization.getCompanyAll.biz.ext";
var grid;
var btnisDimission;
var btnisOpenAccount;
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

$(document).ready(function(v) {
	grid = nui.get("datagrid1");
    btnisDimission = nui.get("btnisDimission");
    btnisOpenAccount = nui.get("btnisOpenAccount");
	grid.setUrl(gridUrl);
	orgidsEl = nui.get("orgids");
	
	
	
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
                orgidsEl.setData(data.companyList);
            }else {
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
        case "sex":
            if(sexSignHash && sexSignHash[e.value]) {
                e.cellHtml = sexSignHash[e.value];
            }
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

    var url = webPath + contextPath + "/com.hs.common.employeeEdit.flow?token="+token;
    var width = 680;
    var height = 550;
    if(currCompType == 'PART'){
        url = webPath + contextPath + "/com.hs.common.partEmployeeEdit.flow?token="+token;
        height = 250;
    }

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
