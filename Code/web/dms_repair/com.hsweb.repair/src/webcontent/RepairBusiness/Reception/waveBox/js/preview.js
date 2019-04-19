$(document).ready(function(v) {

});

function setData(url) {
	$("#picture").attr("src",url||webPath + contextPath + "/common/images/logo.jpg");
}
//取消
function onCancel() {
    CloseWindow("cancel");
}
//关闭窗口
function CloseWindow(action) {
    if (window.CloseOwnerWindow)
        return window.CloseOwnerWindow(action);
    else window.close();
}