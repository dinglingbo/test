/**
 * Created by Administrator on 2018/3/17.
 */


//关闭窗口
function CloseWindow(action) {
    if (action == "close" && form.isChanged()) {
        if (confirm("数据被修改了，是否先保存？")) {
            saveData();
        }
    }
    if (window.CloseOwnerWindow)
        return window.CloseOwnerWindow(action);
    else window.close();
}
//取消
function onCancel() {
    CloseWindow("cancel");
}