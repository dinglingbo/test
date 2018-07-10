

$(document).ready(function (v)
{
	nui.ajax({
        url: "com.hs.annual_project.search.search_main.biz.ext",
        type: "post",
        cache: false,
        async: false,
        data: {
           param : param
        },
        success: function(text) {
        	
        }
    });
});