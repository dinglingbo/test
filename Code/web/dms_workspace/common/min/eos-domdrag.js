window.Drag=window.Drag||{};EOS.apply(Drag,{obj:null,init:function(d,h,f,b,e,a,i,g,j,c){d.onmousedown=Drag.start;d.hmode=i?false:true;d.vmode=g?false:true;d.root=h&&h!=null?h:d;if(d.hmode&&isNaN(parseInt(d.root.style.left))){d.root.style.left="0px"}if(d.vmode&&isNaN(parseInt(d.root.style.top))){d.root.style.top="0px"}if(!d.hmode&&isNaN(parseInt(d.root.style.right))){d.root.style.right="0px"}if(!d.vmode&&isNaN(parseInt(d.root.style.bottom))){d.root.style.bottom="0px"}d.minX=typeof f!="undefined"?f:null;d.minY=typeof e!="undefined"?e:null;d.maxX=typeof b!="undefined"?b:null;d.maxY=typeof a!="undefined"?a:null;d.xMapper=j?j:null;d.yMapper=c?c:null;d.root.onDragStart=new Function();d.root.onDragEnd=new Function();d.root.onDrag=new Function()},start:function(b){var c=Drag.obj=this;b=Drag.fixE(b);var d=parseInt(c.vmode?c.root.style.top:c.root.style.bottom);var a=parseInt(c.hmode?c.root.style.left:c.root.style.right);c.root.onDragStart(a,d);c.lastMouseX=b.clientX;c.lastMouseY=b.clientY;if(c.hmode){if(c.minX!=null){c.minMouseX=b.clientX-a+c.minX}if(c.maxX!=null){c.maxMouseX=c.minMouseX+c.maxX-c.minX}}else{if(c.minX!=null){c.maxMouseX=-c.minX+b.clientX+a}if(c.maxX!=null){c.minMouseX=-c.maxX+b.clientX+a}}if(c.vmode){if(c.minY!=null){c.minMouseY=b.clientY-d+c.minY}if(c.maxY!=null){c.maxMouseY=c.minMouseY+c.maxY-c.minY}}else{if(c.minY!=null){c.maxMouseY=-c.minY+b.clientY+d}if(c.maxY!=null){c.minMouseY=-c.maxY+b.clientY+d}}document.onmousemove=Drag.drag;document.onmouseup=Drag.end;return false},drag:function(f){f=Drag.fixE(f);var g=Drag.obj;var c=f.clientY;var d=f.clientX;var i=parseInt(g.vmode?g.root.style.top:g.root.style.bottom);var b=parseInt(g.hmode?g.root.style.left:g.root.style.right);var a,h;if(g.minX!=null){d=g.hmode?Math.max(d,g.minMouseX):Math.min(d,g.maxMouseX)}if(g.maxX!=null){d=g.hmode?Math.min(d,g.maxMouseX):Math.max(d,g.minMouseX)}if(g.minY!=null){c=g.vmode?Math.max(c,g.minMouseY):Math.min(c,g.maxMouseY)}if(g.maxY!=null){c=g.vmode?Math.min(c,g.maxMouseY):Math.max(c,g.minMouseY)}a=b+((d-g.lastMouseX)*(g.hmode?1:-1));h=i+((c-g.lastMouseY)*(g.vmode?1:-1));if(g.xMapper){a=g.xMapper(i)}else{if(g.yMapper){h=g.yMapper(b)}}Drag.obj.root.style[g.hmode?"left":"right"]=a+"px";Drag.obj.root.style[g.vmode?"top":"bottom"]=h+"px";Drag.obj.lastMouseX=d;Drag.obj.lastMouseY=c;Drag.obj.root.onDrag(a,h);return false},end:function(){document.onmousemove=null;document.onmouseup=null;Drag.obj.root.onDragEnd(parseInt(Drag.obj.root.style[Drag.obj.hmode?"left":"right"]),parseInt(Drag.obj.root.style[Drag.obj.vmode?"top":"bottom"]));Drag.obj=null},fixE:function(a){if(typeof a=="undefined"){a=window.event}if(typeof a.layerX=="undefined"){a.layerX=a.offsetX}if(typeof a.layerY=="undefined"){a.layerY=a.offsetY}return a}});