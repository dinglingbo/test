function ComboSelect(a){this.dataType=EOS.dataType;this.xtype="combo";this.id=a;this.Obj=a;this.inputObject=null;this.eventObject=null;this.hiddenObject=null;this.canClose=true;this.container=null;this.focusStatus=false;this.mouseOffset=null;this.showStatus=false;this.win=window;this.textField=null;this.valueField=null;this.filterField=null;this.submitXpath=null;this.xpath=null;this.dataXML=null;this.showMoreDay=true;this.date=null;this.timer=null;this.timeSelect=null;this.width=null;this.optionsWidth=null;this.optionsHeight="180px";this.allowInput=false;this.filterField=null;this.startWith=true;this.isFirst=true;this.__subComponent=[];this.defaultText="";this.validateFunc=function(){return true};this.validate=this.validateFunc;this.isFirstLoad=true;this.initParamFunc=null;this.nullText=null;this.filterType="startwith";this.showValue=false;this._showAll=true;this.queryReturnValue=null;this.queryParamsInfo=null;this.queryInoutParams=null;PageControl.add(this.id,this)}ComboSelect.prototype.onPageLoad=function(){PageControl.registerRelation(this.linkId,this.id);var b=this;function a(){b.init();b.loadData();b.refresh()}if(EOS.loader.isReady){a()}else{eventManager.add(window,"load",a)}};ComboSelect.prototype.reset=function(){this.value=this.resetValue;this.setValue(this.value)};ComboSelect.currentComboSelect=null;ComboSelect.editorContainer=null;ComboSelect.doc=document;ComboSelect.prototype.showEditor=function(a){this.container.style.display="";try{this.inputObject.focus()}catch(b){}};ComboSelect.prototype.hideEditor=function(a){this.hide();if(this.container){this.container.style.display="none"}};ComboSelect.prototype.getSelectEntity=function(){return this.selectEntity};ComboSelect.prototype.setValue=function(d,c){var b=this.getEntityByValue(d);if(!b){if(this.allowInput){this.hiddenObject.value=d;this.inputObject.value=d;return true}else{return false}}var a=b.__index;return this.selectOptionByIndex(a,c)};ComboSelect.prototype.selectOptionByIndex=function(a,b){var c=this.optionsTable.tBodies[0].rows;if(!isNaN(a)&&c&&c.length>0){this.selectOption(c[a],b);return true}return false};ComboSelect.prototype.getValue=function(){if(!this.allowInput){return this.hiddenObject.value}var a=this.getEntityByText();return a?a.getProperty(this.valueField):this.inputObject.value};ComboSelect.prototype.getDisplayValue=function(a){var b=this.getEntityByValue(a);return b?b.getProperty(this.textField):a};ComboSelect.prototype.getText=function(){return this.inputObject.value};ComboSelect.prototype.getEntityByValue=function(a,e){var f=this.dataset?this.dataset.getLength():0;if(this.hiddenObject!=undefined){a=""+(a||this.hiddenObject.value||"")}(e===true)&&(a=a.toLowerCase());for(var d=0;d<f;d++){var c=this.dataset.get(d);c.__index=d;var b=c?c.getProperty(this.valueField):null;if(b!==undefined&&b!==null){(e===true)&&(b=(""+b).toLowerCase());if(a===b){return c}}}return null};ComboSelect.prototype.getEntityByText=function(a,e){var f=this.dataset?this.dataset.getLength():0;if(this.inputObject!=undefined){a=""+(a||this.inputObject.value||"")}(e===true)&&(a=a.toLowerCase());for(var d=0;d<f;d++){var c=this.dataset.get(d);var b=c?c.getProperty(this.textField):null;if(b!==undefined&&b!==null){(e===true)&&(b=(""+b).toLowerCase());if(a===b){c.__index=d;return c}}}return null};ComboSelect.prototype.setWidth=function(a){this.width=a+"";this.initSize()};ComboSelect.prototype.getWidth=function(){return this.width};ComboSelect.prototype.initSize=function(){if(this.width){this.width=this.width+"";this.container.style.width=this.width;if(this.container.offsetWidth!=0){if(this.width.indexOf("%")!=-1){if(isFF){this.inputObject.style.width=this.width}else{if(isIE){this.container.style.width="";this.inputObject.style.width=this.width}}}else{if(this.width.indexOf("px")!=-1){this.inputObject.style.width=this.width.replace("px","")-17}else{this.inputObject.style.width=this.width-17}}}}};ComboSelect.prototype.setPosition=function(f,b,c,a){try{this.hide();if(this.container){this.width=c||this.width;this.height=a||this.height;this.container.style.position="absolute";this.container.style.width=c;var g=getMaxZindex(document);if(this.container.style.zIndex!=g){this.container.style.zIndex=g}this.container.style.display=isFF?"-moz-inline-box":"inline";this.container.style.top=b;this.container.style.left=f;this.eventObject.style.height=a;this.container.style.height=a;this.inputObject.style.height=a;this.inputObject.style.width=c-17}}catch(d){}};ComboSelect.prototype.init=function(){var combo=this;if(this.inited===true||this.beforeInit()===false){return}if(this.isIeMode==true){this.inited=true;this.select=$id(this.id+"_select");this.select.readOnly=this.readOnly;this.select.disabled=this.disabled;this.select.style.width=this.width;this.select.onchange=function(){var entity=this.options[this.selectedIndex].entity;this.selectEntity=entity;combo._onChange();combo.setSubComponent(entity)};return}this.filterField=this.filterField||this.textField;this.container=$id(this.id+"_container");this.inputObject=$id(this.id+"_input");this.hiddenObject=$id(this.id+"_hidden");this.readonly=(this.readonly===true||this.readonly===false)?this.readonly:this.readOnly;this.inputObject.readOnly=!!this.readonly;this.hiddenObject.readOnly=!!this.readonly;this.inputObject.disabled=!!this.disabled;this.hiddenObject.disabled=!!this.disabled;this.eventObject=$id(this.id+"_button");this.button=this.eventObject;this.button.style.verticalAlign="bottom";this.text=this.inputObject;this.hidden=this.hiddenObject;this.resetValue=this.value;var form=getFormByObj(this.inputObject);if(form!=null){initEosControlReset(form,this)}var comboSelect=this;this.eventObject.src=COMBOSELECT_BTN;this.eventObject.onmouseover=function(){if(comboSelect.getDisabled()||comboSelect.getReadOnly()){return}this.src=COMBOSELECT_BTN_OVER};this.eventObject.onmouseout=function(){if(comboSelect.getDisabled()||comboSelect.getReadOnly()){return}this.src=COMBOSELECT_BTN};this.eventObject.onmousedown=function(){if(comboSelect.getDisabled()||comboSelect.getReadOnly()){return}this.src=COMBOSELECT_BTN_DOWN};this.initSize();this.inputObject.value=this.defaultText;this.validate=(typeof this.validateFunc)=="string"?eval(this.validateFunc):this.validateFunc;this.startWith=(this.filterType.toLowerCase()!="like");this.initEvent();this.inited=true;this.afterInit()};ComboSelect.prototype.isFocus=function(){return this.focusStatus};ComboSelect.prototype.cancleFilter=function(a){var c=this.optionsTable.tBodies[0].rows;for(var b=0;b<c.length;b++){c[b].style.display=""}return c.length};ComboSelect.prototype.filter=function(){var a=this.inputObject.value;var b=0;if(a!==undefined&&a!==null){b=this.doFilter(a)}else{b=this.cancleFilter(a)}return b};ComboSelect.prototype.getFilterNum=function(){var c=0;var b=this.optionsTable.tBodies[0].rows;for(var a=0;a<b.length;a++){if(b[a].style.display!="none"){c++}}return c};ComboSelect.prototype.doFilter=function(k,a){var l=this.optionsTable.tBodies[0].rows;k=k||this.inputObject.value||"";k=k.toLowerCase();var e=0;var h=null;var c=false;for(var d=0;d<l.length;d++){var b=this.dataset.get(d);var g=b?b.getProperty(this.filterField):null;l[d].style.display=a===false?"":"none";if(this.selectOptionRow==l[d]){c=true}if(g!==undefined&&g!==null){g=(""+g).toLowerCase();var j=g.indexOf(k);if(this.startWith&&j==0||!this.startWith&&j>=0){l[d].style.display="";if(!h){h=l[d];this.activeOption(h)}e++}}}if(c){}return e};ComboSelect.prototype._syncInputValue=function(){if(this.hiddenObject.value!==this.inputObject.value){this.hiddenObject.value=this.inputObject.value;this.selectEntity=new Entity();this.selectEntity.setProperty(this.valueField,this.hiddenObject.value);this.selectEntity.setProperty(this.textField,this.hiddenObject.value);return true}return false};ComboSelect.prototype._onChange=function(){if(this.onChangeFunc){if(typeof(this.onChangeFunc)=="string"){this.onChangeFunc=eval(this.onChangeFunc)}this.onChangeFunc(this.selectEntity,this)}};ComboSelect.prototype.onInputBlur=function(){var g=this;if(checkInput(this.inputObject)==false){return}var d=true;if(this.validate){d=this.validate()}if(d){if(!g.showStatus){var c=g.getFilterNum();var f=g.hiddenObject.value;var b=g.getEntityByRow(g.activeOptionRow);var a,e;if(b){a=b.getProperty(g.valueField);e=b.getProperty(g.textField)}if(f!=a&&e==g.inputObject.value){g.selectOption()}else{if(g.allowInput){}else{if(!g.allowInput){g.selectOption(g.selectOptionRow,(f!=a))}}}}}};ComboSelect.prototype.initEvent=function(){var c=this;var f=","+[EOSKey.TAB,EOSKey.ENTER,EOSKey.SHIFT,EOSKey.CTRL,EOSKey.PAUSE,EOSKey.CAPSLOCK,EOSKey.PAGEUP,EOSKey.PAGEDOWN,EOSKey.END,EOSKey.HOME,EOSKey.LEFT,EOSKey.UP,EOSKey.RIGHT,EOSKey.DOWN,EOSKey.INSERT,EOSKey.WIN,EOSKey.WIN_R,EOSKey.MENU,EOSKey.F1,EOSKey.F2,EOSKey.F3,EOSKey.F4,EOSKey.F5,EOSKey.F6,EOSKey.F7,EOSKey.F8,EOSKey.F9,EOSKey.F10,EOSKey.F11,EOSKey.F12,EOSKey.NUMLOCK,EOSKey.SCROLLLOCK].join(",")+",";function a(g){if(c.getDisabled()||c.getReadOnly()){return}if(this.optionsTable&&this.optionsTable.tBodies&&this.optionsTable.tBodies[0]){return}g=g||window.event;$error("key:"+g.keyCode);eventManager.stopEvent(g);if(g.keyCode==EOSKey.ENTER){eventManager.stopEvent();if(!c.showStatus){c.show(true)}else{var h=c.getFilterNum();if(h>0||!c.allowInput){c.selectOption(c.actionOptionRow)}c.hide()}}else{if(g.keyCode==EOSKey.ESC){if(c.showStatus){c.hide()}else{PageControl.setFocus(c);c.show(true)}eventManager.stopEvent(g)}else{if(g.keyCode==EOSKey.UP){if(!c.showStatus){c.show(true)}else{c.activePrevOption()}eventManager.stopEvent(g)}else{if(g.keyCode==EOSKey.DOWN){if(!c.showStatus){c.show(true)}else{c.activeNextOption()}eventManager.stopEvent(g)}else{if(f.indexOf(","+g.keyCode+",")<0&&(!c.beforeFilter||c.beforeFilter(c,g.keyCode)!==false)){c.show();eventManager.stopEvent(g);if(c.afterFilter){c.afterFilter(c)}if(c.afterFilter){c.afterFilter(c)}var h=c.filter();if(c.allowInput){if(c._syncInputValue()){c._onChange()}}}}}}}eventManager.stopEvent()}function d(g){if(c.getDisabled()||c.getReadOnly()){return}if(g.keyCode!=EOSKey.ESC){return}g=g||window.event;if(g.keyCode==EOSKey.ENTER){eventManager.stopEvent();var h=c.getFilterNum();if(h<1&&c.allowInput){if(c._syncInputValue()){c._onChange()}}}else{if(g.keyCode==EOSKey.TAB){c.onInputBlur()}else{if(f.indexOf(","+g.keyCode+",")<0&&(!c.beforeFilter||c.beforeFilter(c,g.keyCode)!==false)){var h=c.filter();eventManager.stopEvent(g);if(c.afterFilter){c.afterFilter(c)}c.show()}}}}function e(h){if(c.getDisabled()||c.getReadOnly()){return}h=h||window.event;var g=eventManager.getWheel(h);if(g<0){c.activeNextOption();c.selectOption()}else{if(g>0){c.activePrevOption();c.selectOption()}}eventManager.stopEvent()}function b(){eventManager.stopEvent();if(c.getDisabled()||c.getReadOnly()){return}c.eventObject.src=COMBOSELECT_BTN_OVER;if(c.showStatus){c.hide()}else{c.show(true)}}if(!this.inputObject.readOnly){eventManager.add(this.inputObject,"blur",function(g){c.onInputBlur(g)})}this.container.onmousedown=function(){var g=eventManager.getElement();if(g==c.inputObject){if(c.showStatus){eventManager.stopEvent()}try{c.inputObject.focus()}catch(h){}}else{if(g==c.eventObject){if(c.showStatus){eventManager.stopEvent()}}}};eventManager.add(this.inputObject,"keyup",a);eventManager.add(this.eventObject,"click",function(){eventManager.stopEvent()});eventManager.add(this.eventObject,"mouseup",b);eventManager.add(this.inputObject,"focus",function(){c.inputObject.select()})};ComboSelect.prototype.show=function(d){PageControl.addtoStack(this);if(this.optionsDiv&&this.optionsDiv.style&&!this.disabled){if(this.optionsWidth&&this.optionsWidth.indexOf("%")>0){this.optionsDiv.style.width=this.container.clientWidth*parseInt(this.optionsWidth)/100}else{this.optionsDiv.style.width=this.optionsWidth||isFF?this.container.offsetWidth-8:this.container.offsetWidth}if(d===true){if(this.optionsTable&&this.optionsTable.tBodies&&this.optionsTable.tBodies[0]){this.cancleFilter()}}this.optionsDiv.style.display="block";var h=getMaxZindex(document);if(this.optionsDiv.style.zIndex!=h){this.optionsDiv.style.zIndex=h}var a=this.inputObject.clientHeight;var j=this.optionsDiv.clientHeight;var b=getScreenPosition(this.inputObject,this.win);b={top:b[1]+a,left:b[0]};var i={top:b.top,left:b.left};this.optionsDiv.style.display="none";if(isIE){if(document.body.offsetHeight<(b.top+j)){if(b.top-j-a>0){i.top-=j;i.top-=a}}}else{if(document.body.scrollHeight<(b.top+j)){if(b.top-j-a>0){i.top-=j;i.top-=a}}}setElementXY(this.optionsDiv,[i.left,i.top]);this.optionsDiv.style.display="block";try{this.inputObject.focus()}catch(g){}this.showStatus=true;if(isIE){var f=this.optionsDiv.firstChild;f.style.width=f.nextSibling.offsetWidth;f.style.height=f.nextSibling.offsetHeight;f.style.top=f.nextSibling.offsetTop;f.style.left=f.nextSibling.offsetLeft}var c=this.optionsDiv.firstChild.nextSibling;initShadow(c);if(isFF){c.nextSibling.style.width=this.optionsDiv.offsetWidth+7}}};ComboSelect.prototype.hide=function(){if(this.optionsDiv&&this.optionsDiv.style){this.optionsDiv.style.display="none"}this.showStatus=false};ComboSelect.prototype.onLoadData=function(){};ComboSelect.prototype.addParam=function(a,b){this.paramList=this.paramList||[];this.paramList.push({key:a,value:b})};ComboSelect.prototype.loadData=function(){if(this.beforeLoadData()===false){return}if(!this.linkId&&!this.queryAction&&this.xpath){var xmlZone=document.getElementById(this.id+"_xml");this.dataXML=xmlZone?xmlZone.innerHTML:null}else{if(this.linkId&&this.linkId.indexOf("xml:")==0){var xmlZone=document.getElementById(this.linkId.substring(4));this.dataXML=xmlZone?xmlZone.innerHTML:null}else{if(this.linkId&&this.isFirstLoad){this.isFirstLoad=false;var linkCombo=$id(this.linkId);if(linkCombo&&linkCombo.xtype=="combo"){var parentValue=linkCombo.getSelectEntity();if(parentValue){this.freshFromEntity(parentValue)}}return}}}var xmlDom;var _dataXML=this.dataXML;this.dataset=new Dataset();if(this.nullText!==null){if(!this.isIeMode){var emptyEntity=new Entity();emptyEntity.setProperty(this.valueField,"");emptyEntity.setProperty(this.textField,this.nullText);this.setValue("");this.dataset.addEntity(emptyEntity)}else{}}if(_dataXML){this.dataset.appendDataset(Dataset.create(_dataXML,this.xpath));return}if(this.onLoadData()!==false){if(!this.queryAction){return}var ajax=new HideSubmit(this.queryAction);var param="";var paramFn="";if(this.initParamFunc){try{paramFn=eval(this.initParamFunc+"(ajax)")}catch(e){try{paramFn=eval(this.initParamFunc+"()")}catch(e1){$handle(e1)}}}if(this.dataType=="json"){param={};EOS.apply(param,this.queryParam);EOS.apply(param,this.pageParam);EOS.apply(param,paramFn)}else{param="";param+=this.queryParam||"";param+=this.pageParam||"";param+=paramFn||""}if(this.filterID){var form=$id(this.filterID);if(form){for(var i=0;i<form.elements.length;i++){var elem=form.elements[i];if(elem.name){ajax.addParam(elem.name,elem.value)}}}}if(this.paramList){for(var i=0;i<this.paramList.length;i++){var elem=this.paramList[i];if(elem){ajax.addParam(elem.key,elem.value)}}}if(this.queryReturnValue){ajax.setOutParam(this.queryReturnValue)}if(this.queryParamsInfo){ajax.setParamsInfo(this.queryParamsInfo)}if(this.queryInoutParams){ajax.setInoutParam(this.queryInoutParams)}var _this=this;ajax.onSuccess=function(){var pagecond=0;if(_this.dataType=="json"&&ajax.retJson){var xp=_this.xpath;var arr=ajax.retJson;if(xp){xp=xp.split("/");for(var i=0,len=xp.length;i<len;i++){arr=arr[xp[i]]}}_this.dataset=Json2Dataset(arr);if(ajax.retJson.page){pagecond=ajax.retJson.page.length}}else{xmlDom=ajax.retDom;_this.dataset=Dataset.create(xmlDom,_this.xpath,null);pagecond=xmlDom.selectSingleNode("/root/data/page")}if((_this.nullText!==null&&_this.nullText!==undefined)&&!_this.isIeMode){var emptyEntity=new Entity();emptyEntity.setProperty(_this.valueField,"");emptyEntity.setProperty(_this.textField,_this.nullText);_this.setValue("");_this.dataset.insertEntity(emptyEntity,true,0)}else{}if(_this.afterLoadData){_this.afterLoadData()}};ajax.loadData(param)}};ComboSelect.prototype.getEntityByRow=function(b){if(!b){return null}var c=b.getAttribute("__entity_rowno")/1;var a=this.dataset.get(c);return a};ComboSelect.prototype.disable=function(){this.disabled=true;this.inputObject.disabled=true;this.hiddenObject.disabled=true;this.hide()};ComboSelect.prototype.enable=function(){this.disabled=false;this.inputObject.disabled=false;this.hiddenObject.disabled=false};ComboSelect.prototype.setDisabled=function(a){if(a){this.disable()}else{this.enable()}if(a){this.eventObject.style.cursor="default"}else{this.eventObject.style.cursor="pointer"}};ComboSelect.prototype.getDisabled=function(a){return this.disabled};ComboSelect.prototype.setReadonly=function(a){this.inputObject.readOnly=a||true};ComboSelect.prototype.setReadOnly=function(a){this.readonly=a;this.inputObject.readOnly=a;if(a){this.eventObject.style.cursor="default"}else{this.eventObject.style.cursor="pointer"}};ComboSelect.prototype.getReadOnly=function(a){return this.readonly};ComboSelect.prototype.firstOptionRow=function(d,a){var c=this.optionsTable.tBodies[0].rows;d=d||0;a=a||c.length;d=d<0?0:d;a=a<0?0:a;a=a>c.length?c.length:a;d=d>a?a:d;for(var b=d;b<a;b++){if(c[b].style.display!="none"){return c[b]}}return null};ComboSelect.prototype.lastOptionRow=function(d,a){var c=this.optionsTable.tBodies[0].rows;d=d||0;a=a===0?0:(a||c.length);d=d<0?0:d;a=a>c.length-1?c.length-1:a;a=a<0?0:a;d=d>a?a:d;if(c.length>0){for(var b=a;b>=d;b--){if(c[b].style.display!="none"){return c[b]}}}return null};ComboSelect.prototype.activePrevOption=function(b){b=b||this.activeOptionRow;var c=0;if(b){c=b.rowIndex-1}var a=this.lastOptionRow(0,c);if(a&&a!=b){this.activeOption(a)}};ComboSelect.prototype.activeNextOption=function(c){c=c||this.activeOptionRow;var a=0;if(c){a=c.rowIndex+1}var b=this.firstOptionRow(a);if(b&&b!=c){this.activeOption(b)}};ComboSelect.prototype.activeOption=function(a){if(this.activeOptionRow){removeClass(this.activeOptionRow,"eos-selectoption")}addClass(a,"eos-selectoption");this.autoScroll(a);this.activeOptionRow=a};ComboSelect.prototype.selectOption=function(row,refreshSub){this._showAll=true;var _change=this.selectOptionRow!=row;row=row||this.activeOptionRow;if(!row){return}var entity=this.getEntityByRow(row);if(entity){if(this.activeOptionRow){removeClass(this.activeOptionRow,"eos-selectoption")}if(row.offsetTop<this.optionsDivCore.scrollTop+2){this.optionsDivCore.scrollTop=row.offsetTop}if(row.offsetTop>this.optionsDivCore.scrollTop+this.optionsDivCore.clientHeight-4){this.optionsDivCore.scrollTop=row.offsetTop-this.optionsDivCore.clientHeight+row.offsetHeight}this.selectEntity=entity;this.inputObject.value=this.selectEntity.getProperty(this.textField);this.hiddenObject.value=this.selectEntity.getProperty(this.valueField);if(this.activeOptionRow){removeClass(this.activeOptionRow,"eos-selectoption")}this.selectOptionRow=row;this.activeOptionRow=row;addClass(this.activeOptionRow,"eos-selectoption");if(this.onChangeFunc&&!this.isFirst){if(typeof(this.onChangeFunc)=="string"){this.onChangeFunc=eval(this.onChangeFunc)}this.isFirst=false;_change&&this.onChangeFunc(this.selectEntity,this)}this.isFirst=false}if(refreshSub!==false){this.setSubComponent(entity)}};ComboSelect.prototype.registerSubComponent=function(b){var a=PageControl.getOne(b);a.parentCmp=this;this.__subComponent.push(a)};ComboSelect.prototype.setSubComponent=function(b){var d;if(b){d=b.name;b.name=this.submitXpath||d}for(var c=0;c<this.__subComponent.length;c++){var a=this.__subComponent[c];if(a&&a.freshFromEntity){a.freshFromEntity(b)}}if(b){b.name=d}};ComboSelect.prototype.freshFromEntity=function(a){if(this.queryAction){if(a){if(this.dataType=="json"){this.queryParam=a.toJson()}else{this.queryParam=a.toString()}}else{this.queryParam=null}this.loadData()}else{if(this.linkField){if(a){this.dataset=a.getProperty(this.linkField);if(!this.dataset){this.dataset=new Dataset(this.linkField);a.setProperty(this.linkField,this.dataset)}}else{this.dataset=new Dataset(this.linkField)}}}this.refresh()};ComboSelect.prototype.refresh=function(h){this.init();if(this.isIeMode==true){var s=this.dataset?this.dataset.getLength():0;while(this.select.options.length!=0){this.select.options.remove(this.select.options[0])}if(this.nullText!==null){var m=new Option();m.text=this.nullText;m.value="";this.select.options.add(m)}for(var i=0;i<s;i++){var j=this.dataset.get(i);var k=j.getProperty(this.valueField);var c=j.getProperty(this.textField);var m=new Option();m.text=c;m.value=k;if(k==this.value){m.selected=true}m.entity=j;this.select.options.add(m)}var m=this.select.options[this.selectedIndex||0];if(m!=null){j=m.entity}if(j!=null){}this.setSubComponent(j);return}if(this.beforeRefresh()===false){return}var e=this;this.dataset=h||this.dataset;var s=this.dataset?this.dataset.getLength():0;if(this.noOrgOptionsHeight==true){this.optionsHeight=((s>10?10:s)*21+2)}if(this.optionsDiv){removeElement(this.optionsDiv)}this.optionsDiv=$createElement("div");this.optionsDiv.className="eos-combo-optiondiv";this.inputObject.value="";this.hiddenObject.value="";function b(){var o=eventManager.getElement();if(o!=e.eventObject&&!e.inputObject.getAttribute("_isFocus")&&!e.eventObject.getAttribute("_isFocus")){if(!e.allowInput){e.inputObject.value=e.selectEntity.getProperty(e.textField);e.hiddenObject.value=e.selectEntity.getProperty(e.valueField)}e.hide()}}if(!this.optionsHeight){this.noOrgOptionsHeight=true;this.optionsHeight=((s>10?10:s)*21+2)}this.optionsDiv.style.height=this.optionsHeight;document.body.appendChild(this.optionsDiv);this.optionsDiv.onmousedown=function(){eventManager.stopEvent()};function l(u){u=u||window.event;var o=u.srcElement||u.target;eventManager.stopPropagation();if(o.tagName.toLowerCase()!="tr"){while((o=o.parentNode)){if(o.tagName&&o.tagName.toLowerCase()=="tr"&&o.getAttribute("__entity_rowno")){break}}}var t=getParentByTagName(o,"table");return t&&t.className=="eos-combo-optiontable"?o:null}function n(o){if(e.selectOptionRow){removeClass(e.selectOptionRow,"eos-selectoption")}e.optionsDiv.setAttribute("_isOver",true);var t=l(o);addClass(t,"eos-selectoption");if(e.activeOptionRow==t){return}if(e.activeOptionRow){removeClass(e.activeOptionRow,"eos-selectoption")}e.activeOptionRow=t}function d(o){e.optionsDiv.setAttribute("_isOver",false)}function q(o){var t=l(o);if(t){e.selectOption(t)}e.hide();try{e.inputObject.focus()}catch(u){}}eventManager.add(this.optionsDiv,"mouseover",n);eventManager.add(this.optionsDiv,"mouseout",function(){setTimeout(d,300)});eventManager.add(this.optionsDiv,"click",q);function r(){eventManager.stopPropagation()}eventManager.add(this.optionsDiv,"mousedown",r);var p=['<div class="eos-combo-optiondiv-core"><table  class="eos-combo-optiontable" border="0" cellspacing="0" cellpadding="0" width="100%" ><tbody>'];for(var i=0;i<s;i++){var j=this.dataset.get(i);var k=j.getProperty(this.valueField);var c=j.getProperty(this.textField);p.push('<tr __entity_rowno="'+i+'" >');p.push("<td><div><nobr>");p.push(c==""?" ":c);p.push("</nobr></div></td>");if(this.showValue){p.push("<td><div>");p.push(k);p.push("</div></td>")}p.push("</tr>")}p.push("</tbody></table ></div>");var a=window.isIE?"<iframe src='"+blankURL+'\' SCROLLING="no" style="overflow:hidden;position:absolute;z-index:-1;" frameborder="0" ></iframe>':'<span style="display:none;"></span>';this.optionsDiv.innerHTML=a+p.join("\n");this.optionsDiv.childNodes[1].style.height=this.optionsDiv.style.height;this.optionsDiv.childNodes[1].style.width=this.optionsDiv.style.width;this.optionsDivCore=this.optionsDiv.childNodes[1];this.optionsTable=this.optionsDivCore.firstChild;var f=false;if(this.value){this.setValue(this.value,false)}else{if(this.optionsTable&&this.optionsTable.tBodies&&this.optionsTable.tBodies[0]){var g=this.optionsTable.tBodies[0].rows;if(g&&g.length>0){this.selectOption(g[0]);f=true}}}if(!f){this.setSubComponent(this.getEntityByValue(this.value))}this.afterRefresh()};ComboSelect.prototype.autoScroll=function(e){var c=e.offsetTop;var a=c+e.offsetHeight;var d=this.optionsDivCore.scrollTop;var b=d+this.optionsDivCore.clientHeight;if(c<d){this.optionsDivCore.scrollTop=c}else{if(a>b){this.optionsDivCore.scrollTop=d+a-b}}};ComboSelect.prototype.boundTree=function(b,d,a){if($id(b)==null){alert("Can not find tree:"+treeID);return}var c;if($id(b).model!=null){c=$id(b+"_container")}else{c=$id(b+"_container").parentNode}d=d||"";a=a||"";this.afterRefresh=function(){this.hidden.value=d;this.text.value=a;this.optionsDiv.childNodes[1].appendChild(c);c.onclick=function(){eventManager.stopPropagation()}}};ComboSelect.prototype.beforeInit=function(){};ComboSelect.prototype.afterInit=function(){};ComboSelect.prototype.beforeLoadData=function(){};ComboSelect.prototype.afterLoadData=function(){};ComboSelect.prototype.beforeRefresh=function(){};ComboSelect.prototype.afterRefresh=function(){};