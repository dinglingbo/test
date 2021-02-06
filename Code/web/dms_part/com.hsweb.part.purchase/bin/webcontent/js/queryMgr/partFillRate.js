/**
 * Created by Administrator on 2018/2/8.
 */

var queryForm = null;
var grid = null;
$(document).ready(function(v)
{
    grid = nui.get("datagrid1");
    queryForm = new nui.Form("#queryForm");

    queryForm.setData({
        startDate:new Date,
        endDate:new Date
    });
});