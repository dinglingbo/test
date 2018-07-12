/**
 * Created by steven on 2018/1/31.
 */
baseUrl = apiPath + sysApi + "/";
var gridUrl = baseUrl + "com.hsapi.system.tenant.employee.queryEmployee.biz.ext";
var grid;
var btnisDimission;
var btnisOpenAccount;
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
    var request = {
        "params":{

        }
    };

    grid.load(request,function(){
        //成功;
       // nui.alert("数据成功！");
    },function(){
        //失败;
        showMsg("数据加载失败!","W");
    });

    grid.on("drawcell", function (e){
    	onDrawCell(e);
    });
});



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

function getSearchParam() {
    var params = {};
    params.name = nui.get("name").getValue();
    params.mobile = nui.get("mobile").getValue();

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
    } else {
    	var row = grid.getSelected();
    	if (!row) {
    		nuialert("请选中一条记录");
    		return;
    	}
    	emp = row;  	
    }

    var url = webPath + sysDomain + "/common/employeeEdit.jsp?token="+token;
    var width = 680;
    var height = 430;
    if(currCompType == 'PART'){
        url = webPath + sysDomain + "/com.hs.common.partEmployeeEdit.flow?token="+token;
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
                    nui.unmask(document.body);
                    showMsg("操作成功!","S");

                    var newRow = {isOpenAccount: 0};
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

    if(row.isOpenAccount == 0 && !row.systemAccount){
        emp = row;
        emp.passWord='000000';
        nui.open({
            url: webPath + sysDomain + "/common/setAccount.jsp?token="+token,
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
    }

    if(row.isOpenAccount == 0 && row.systemAccount){
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
    	
    
}
	

function changebutton(){
	var s = grid.getSelected ();
	if(s){
        if (s.isOpenAccount==0) btnisOpenAccount.setText("<span class='fa fa-key'></span>&nbsp;开通账号");
	    else btnisOpenAccount.setText("<span class='fa fa-key'></span>&nbsp;关闭账号");

        if (s.isDimission==0) btnisDimission.setText("<span class='fa fa-user-times'></span>&nbsp;离职");
        else btnisDimission.setText("<span class='fa fa-user'></span>&nbsp;复职");
	}
}
function importGuest(){

    nui.open({
        targetWindow: window,
        url: webPath + sysDomain + "/com.hs.common.importEmployee.flow?token="+token,
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
