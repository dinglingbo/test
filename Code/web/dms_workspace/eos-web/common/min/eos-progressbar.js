var EOSProgressCache={};var ProgressBar=function(d){d=d||"eos_pageProgressBar";this.winWidth=160;this.winHeight=60;this.id=d;var b="__progressbar_"+d+"_title";EOSProgressCache[d]=this;var a=$id(d);if(!a){a=$create("div");a.id=d;a.className="eos-popwin";a.style.width="100px";var c=['<div  class="eos-popwin-body">','<div style="margin:5px;margin-top:15px" ><div class="eos-progress-icon"></div>','<span id="__progressbar_'+d+'_title" ></span></div>',"</div>"].join("\n");a.innerHTML=c;document.body.appendChild(a)}this.isHidden=true;this.container=a;this.titleBar=$id("__progressbar_"+d+"_title");this.show=function(j,h,f){j=j||"Please Waiting ...";this.titleBar.innerHTML=j;var g;this.container.style.width=this.winWidth+"px";this.container.style.height=this.winHeight+"px";this.container.style.display="";if(h&&f){this.container.style.left=h+"px";this.container.style.top=f+"px"}else{if(typeof(h)=="object"&&h.offsetLeft){g=h;h=g.offsetLeft+(g.offsetWidth-this.winWidth)/2;f=g.offsetTop+(g.offsetHeight-this.winHeight)/2;this.container.style.left=h+"px";this.container.style.top=f+"px"}else{moveDivToCenter(this.container)}}try{this.container.focus()}catch(i){}this.isHidden=false};this.hide=function(){if(this.container){this.container.style.display="none"}this.isHidden=true}};function showProgressBar(e,d,b,a){var c=EOSProgressCache[e]||null;if(!c){c=new ProgressBar(e)}c.show(d,b,a);return c}function hideProgressBar(b){b=b||"eos_pageProgressBar";var a=EOSProgressCache[b]||null;if(a){a.hide()}return a}function hideAllProgressBar(){for(var a in EOSProgressCache){EOSProgressCache[a].hide()}};