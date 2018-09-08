var mainGrid = null;

$(document).ready(function () {
	mainGrid = nui.get("mainGrid");
});

function onSearch(){

    mainGrid.load({
        token: token
    });
}