function hideAllSelect(d){if(isIE&&d){var c=d.getElementsByTagName("select");for(var b=0;b<c.length;b++){c[b].back_display=c[b].style.display;c[b].style.display="none"}var a=getFrameDocuments(d);for(var b=0;b<a.length;b++){hideAllSelect(a[b])}}}function showAllSelect(d){if(isIE&&d){var c=d.getElementsByTagName("select");for(var b=0;b<c.length;b++){c[b].style.display=c[b].back_display}var a=getFrameDocuments(d);for(var b=0;b<a.length;b++){showAllSelect(a[b])}}}function getFrameDocuments(d){var a=[];if(isIE){var c=d.frames;for(var b=0;b<c.length;b++){a.push(c[b].document)}}else{var c=d.getElementsByTagName("iframe");for(var b=0;b<c.length;b++){a.push(c[b].contentDocument)}c=d.getElementsByTagName("frame");for(var b=0;b<c.length;b++){a.push(c[b].contentDocument)}}return a};