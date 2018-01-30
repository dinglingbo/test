function DictRadioGroup(a){this.id=a;this.value=null;this.container=$id(this.id+"_container");this.radioes=this.container.getElementsByTagName("input");this.container.onmousedown=function(){eventManager.stopPropagation()};this.hiddenInput=new Object();this.jsonObj=null;this.initEvent();PageControl.add(a,this)}DictRadioGroup.prototype.init=function(){};DictRadioGroup.prototype.initEvent=function(){var d=this;function c(){EOS.event.fireEvent(d.id,"change");d.refreshValue()}for(var b=0;b<this.radioes.length;b++){var a=this.radioes[b];eventManager.add(a,"click",c)}eventManager.add(this.container,"keypress",c)};DictRadioGroup.prototype.refreshInput=function(){str=this.hiddenInput.value;for(var b=0;b<this.radioes.length;b++){var a=this.radioes[b];if(a.value==str){a.checked=true}else{a.checked=false}}};DictRadioGroup.prototype.refreshValue=function(){var c;for(var b=0;b<this.radioes.length;b++){var a=this.radioes[b];if(a.checked){c=a.value;break}}this.hiddenInput.value=c};DictRadioGroup.prototype.setValue=function(a){EOS.event.fireEvent(this.id,"change");this.hiddenInput.value=a;this.refreshInput()};DictRadioGroup.prototype.getValue=function(){this.refreshValue();return this.hiddenInput.value};DictRadioGroup.prototype.setFocus=function(){var c=false;for(var b=0;b<this.radioes.length;b++){var a=this.radioes[b];if(a.checked==true){a.focus();c=true;break}if(!c){this.radioes[0].focus()}}};DictRadioGroup.prototype.lostFocus=function(){};DictRadioGroup.prototype.showEditor=function(){var b=getMaxZindex();this.container.style.zIndex=b;this.container.style.display="";addClass(this.container.firstChild,"dict_comp");if(this.isDcEdit==true){var a=this.container.firstChild;a.style.width=a.firstChild.offsetWidth;initShadow(a)}this.setFocus()};DictRadioGroup.prototype.hideEditor=function(){this.container.style.display="none"};DictRadioGroup.prototype.setPosition=function(d,c,b,a){this.container.style.position="absolute";this.container.zIndex=9999;this.container.style.left=d+"px";this.container.style.top=c+"px"};DictRadioGroup.prototype.isFocus=function(){return true};DictRadioGroup.prototype.validate=function(){return true};DictRadioGroup.prototype.getDisplayValue=function(b){if(b==null){b=this.getValue()}if(!this.jsonObj){return b}var a=this.jsonObj[b];return a!==undefined&&a!==null?a:b};