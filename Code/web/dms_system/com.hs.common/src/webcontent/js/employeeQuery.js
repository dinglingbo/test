/**
 * Created by steven on 2018/1/31.
 */
baseUrl = apiPath + sysApi + "/";;
var gridUrl = baseUrl + "com.hsapi.system.employee.employeeMgr.employeeQuerys.biz.ext";
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
        nui.alert("数据加载失败！");
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
        params:params
    });
}



function edit(action) {
    var emp = {};
    
    if (action == 'new') {
    	data = {action: action};
    } else {
    	var row = grid.getSelected();
    	if (!row) {
    		alert("请选中一条记录");
    		return;
    	}
    	emp.empid = row.empid;  	
    }

    nui.open({
        url: baseUrl + "/common/employeeEdit.jsp",
        width: 680,         //宽度
        height: 430,        //高度
        title: "员工信息",      //标题 组织编码选择
        allowResize:true,
        onload: function () {
            var iframe = this.getIFrameEl();
            iframe.contentWindow.SetData(emp);
        },
        ondestroy: function (action) {  //弹出页面关闭前
            if (action == "OK") {       //如果点击“确定”
                var iframe = this.getIFrameEl();
                var data = iframe.contentWindow.GetData();
                data = nui.clone(data);    //必须。克隆数据。		               
                if (data) {
                    btnEdit.setValue(data.value);
                    btnEdit.setText(data.text);
                }
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
var dimssionUrl=baseUrl +"com.hsapi.system.employee.employeeMgr.employeeDimssion.biz.ext";
function dimssion(){
	var s = grid.getSelected();

	if (s!= undefined) {
	    nui.mask({
	        el : document.body,
	        cls : 'mini-mask-loading',
	        html : '离职中...'
	    });
        nui.ajax({
            url: dimssionUrl,
            type: 'post',
            data: nui.encode({
            	params: s
            }),
            cache: false,
            success: function (data) {
                if (data.errCode == "S"){
                	nui.unmask(document.body);
                	nui.alert("操作成功！");
                	grid.reload();
                    }else {
                    nui.unmask(document.body);
                    nui.alert("操作失败！");
                }
            },
            error: function (jqXHR, textStatus, errorThrown) {
                nui.alert(jqXHR.responseText);
            }
		});
        search();
	} else {
	    nui.alert("请选中一条数据！！");
	}
}

/*
*
*
*开通或关闭
*
*/
var stoporstartUrl= baseUrl +"com.hsapi.system.employee.employeeMgr.stopOrStartEmployee.biz.ext";

function stoporstart(){
    var emp = {};
    var row = grid.getSelected();
    if (!row) {
        alert("请选中一条记录");
        return;
    }
    	
    emp = row;
    emp.passWord='000000';
    nui.open({
        url: baseUrl + "/common/setAccount.jsp",
        width: 530,      //宽度
        height: 180,    //高度
        title: "设置密码",      //标题 组织编码选择
        allowResize:true,
        onload: function () {
            var iframe = this.getIFrameEl();
            iframe.contentWindow.SetData(emp);
        },
        ondestroy: function (action) {  //弹出页面关闭前
            if (action == "OK") {       //如果点击“确定”
                alert('开通帐号成功！');
            }
        }
    });
}
	

function changebutton(){
	var s = grid.getSelected ();
	if(s!= undefined ){
        if (s.isOpenAccount==0) btnisOpenAccount.setText("开通账号(&O)");
	    else btnisOpenAccount.setText("关闭账号(&O)");

        if (s.isDimission==0) btnisDimission.setText("离职(&D)");
        else btnisDimission.setText("复职(&D)");
	}
}
