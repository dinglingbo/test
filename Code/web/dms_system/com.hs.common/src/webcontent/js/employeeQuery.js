/**
 * Created by steven on 2018/1/31.
 */
var baseUrl = window._rootUrl || "http://127.0.0.1:8080/default/";
var gridUrl = baseUrl + "com.hsapi.system.employee.employeeMgr.employeeQuery.biz.ext";
nui.parse();
var grid = nui.get("datagrid1");

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

function onDrawCell(e) {
    switch (e.field) {
        case "sex":
            e.cellHtml = e.value== 1 ? "男" : "女";
        break;
    }
}

function edit(action) {    
    var data;
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
        width: 600,      //宽度
        height: 290,    //高度
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
                if(data){
                    btnEdit.setValue(data.value);
                    btnEdit.setText(data.text);
                }
            }
        }
    });	    
}
