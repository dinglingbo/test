window.nui = window.mini;
if (window.mini){
    window.mini.getClassByUICls = function(e) {
        e = e.toLowerCase();
        var d = this.uiClasses[e];
        if (!d) {
            e = e.replace("nui-", "mini-");
            d = this.uiClasses[e]
        }
        return d
    };
}

window.nui.parse();