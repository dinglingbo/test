function LookUp(a){this.id=a;PageControl.add(a,this);this.value=null;this.lookupBtn=null;this.lookupText=null;this.lookupUrl=null;this.lookupParam=null;this.lookupHidden=null;this.width=300;this.height=200;this.left=null;this.top=null;this.center=true;this.buttonImg=null;this.params=[];this.displayValue=null;this.container=null;this.onReturnFunc=null;this.useIeModel=false;this.dialogTitle=null;this.disabled=false;this.allowInput=true;this.readOnly=false}LookUp.prototype.init=function(){this.container=$id(this.id+"_container");this.lookupHidden=$id(this.id+"_hidden");this.lookupText=$id(this.id+"_input");this.lookupBtn=$id(this.id+"_button");this.lookupBtn.style.height="20px";this.button=this.lookupBtn;this.text=this.lookupText;this.hidden=this.lookupHidden;if(this.lookupWidth!=null){this.text.style.width=this.lookupWidth}var b=this;this.lookupBtn.src=contextPath+"/common/skins/skin0/images/lookup/lookup_button.gif";this.lookupBtn.onmouseover=function(){if(b.getDisabled()||b.getReadOnly()){return}this.src=contextPath+"/common/skins/skin0/images/lookup/lookup_button_over.gif"};this.lookupBtn.onmouseout=function(){if(b.getDisabled()||b.getReadOnly()){return}this.src=contextPath+"/common/skins/skin0/images/lookup/lookup_button.gif"};this.lookupBtn.onmousedown=function(){if(b.getDisabled()||b.getReadOnly()){return}this.src=contextPath+"/common/skins/skin0/images/lookup/lookup_button_down.gif"};this.lookupBtn.onmouseup=function(){if(b.getDisabled()||b.getReadOnly()){return}b.lookupBtn.src=contextPath+"/common/skins/skin0/images/lookup/lookup_button.gif";b.show()};function a(){if(!b.lookupText.readOnly&&(b.lookupText.value!=b.displayValue)){b.displayValue=b.lookupText.value;b.value=b.lookupText.value;b.lookupHidden.value=b.value}}this.setReadOnly(this.readOnly);this.setDisabled(this.disabled);eventManager.add(this.lookupText,"keyup",a)};LookUp.prototype.setReadOnly=function(a){this.readOnly=a;this.lookupText.readOnly=a||!this.allowInput;this.lookupBtn.style.cursor=a?"default":"pointer"};LookUp.prototype.getReadOnly=function(){return this.readOnly};LookUp.prototype.getValue=function(){this.refreshValue();return this.value};LookUp.prototype.setValue=function(a){if(a!==this.value){this.displayValue=a}this.value=a;this.refreshInput()};LookUp.prototype.setDisplayValue=function(a){this.displayValue=a;this.refreshInput()};LookUp.prototype.setFocus=function(){};LookUp.prototype.lostFocus=function(){};LookUp.prototype.show=function(){var lookup=this;if(this.disabled){return}if(lookup.beforeOpenDialog){if(lookup.beforeOpenDialog(lookup)===false){return}}this.refreshValue();var urlStr=this.getParamURL();var argument=[this.value,this.displayValue];function callBack(returnValue){try{if(lookup.onReturnFunc){var func=lookup.onReturnFunc;if((typeof lookup.onReturnFunc)=="string"){func=eval(lookup.onReturnFunc)}if(func(returnValue)!==false){lookup.value=returnValue[0];lookup.displayValue=returnValue[1]}}else{lookup.value=returnValue[0];lookup.displayValue=returnValue[1]}}catch(e){$handle(e);$error("returnValue of dialog is not a array")}lookup.refreshInput()}if(this.useIeModel){var retValue=window.showModalDialog(urlStr,argument,"width:"+this.width+";height:"+this.height+";left:"+this.left+";top:"+this.top+";");callBack(retValue)}else{showModal(urlStr,argument,callBack,this.width,this.height,this.left||"",this.top||"",this.dialogTitle)}};LookUp.prototype.refreshInput=function(){var a=this.displayValue!==null&&this.displayValue!==undefined?this.displayValue:this.value;this.lookupHidden.value=this.value;this.lookupText.value=a};LookUp.prototype.refreshValue=function(){this.value=this.lookupHidden.value;this.displayValue=this.lookupText.value};LookUp.prototype.getParamURL=function(){var a="";for(var b=0;b<this.params.length;b++){var d=this.params[b];a+="&"+d.key+"="+d.value}var c=addContextPath(this.lookupUrl);if(c.indexOf("?")>-1){c+=a}else{c+="?"+a.replace("&","")}return c};LookUp.prototype.addParam=function(a,b){this.params.push({key:a,value:encodeURIComponent(b)})};LookUp.prototype.clearParam=function(){this.params=[]};LookUp.prototype.setDisabled=function(a){this.disabled=a;if(a){this.lookupText.disabled=true;this.lookupHidden.disabled=true;this.lookupBtn.style.cursor="default"}else{this.lookupText.disabled=false;this.lookupHidden.disabled=false;this.lookupBtn.style.cursor="pointer"}};LookUp.prototype.getDisabled=function(){return this.disabled};LookUp.prototype.setPosition=function(d,b,c,a){if(this.container){this.container.style.display="";this.container.style.position="absolute";this.container.style.left=d;this.container.style.top=b;var e=getMaxZindex(document);if(this.container.style.zIndex!=e){this.container.style.zIndex=e}this.lookupText.style.width=c-17;this.lookupText.style.height=a;this.lookupText.style.position="absolute";this.lookupText.style.top="0px";this.lookupText.style.left="0px";this.container.style.width=c;this.container.style.height=a;this.lookupBtn.style.height=a;this.lookupBtn.style.position="absolute";this.lookupBtn.style.left=this.lookupText.style.width}};LookUp.prototype.hideEditor=function(){this.container.style.display="none";this.lookupBtn.style.display="none"};LookUp.prototype.showEditor=function(){this.container.style.display="";this.lookupBtn.style.display=""};LookUp.prototype.validate=function(){return true};LookUp.prototype.isFocus=function(){return false};LookUp.prototype.getDisplayValue=function(a){if(a==this.value){return this.displayValue}return a};