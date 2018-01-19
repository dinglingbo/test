IE4 = ! (navigator.appVersion.charAt(0) < "4" || navigator.appName == "Netscape")

var xo=0
var yo=0
var Ox = -1
var Oy = -1
var lineWidth=1

var rad = Math.PI/180
var maxY = 400
var color = "#228B22"

function print(str) {	
	return str;
}

function orgY(y) {
	return maxY-y
}
function outPlot(x,y,w,h) {
	return print('<div style="position:absolute;left:'+x+';top:'+y+';height:'+h+';width:'+w+';font-size:1px;background-color:'+color+'"></div>')
}

function Plot(x,y) {
	outPlot(x,y,1,1)
	if(Ox>=0 || Oy>=0) {
		ShowLine(Ox,Oy,x-Ox,y-Oy)		
	}
	Ox = x
	Oy = y
}

function ShowLine(x,y,w,h) {
	if(w<0) {
		x += w
		w = Math.abs(w)
	}
	if(h<0) {
		y += h
		h = Math.abs(h)
	}
	//if(w<1) w=1
	//if(h<1) h=1
	if(w<=1){
		if( lineWidth/2>=1 )
			x = x-lineWidth/2
		w=lineWidth
	}
	if(h<=1){
		if( lineWidth/2>=1 )
			y=y-lineWidth/2
		h=lineWidth
	}
	outPlot(x,y,Math.round(w),Math.round(h))
}

function LineTo(x,y) {
	Line(xo,yo,x,y)
}

 
 function getArrow(x0, y0, x1, y1,len,degree) {
		var sp = {x :　x0, y : y0};
		var ep = {x :　x1, y : y1};
		var theta = Math.atan((ep.y - sp.y) / (ep.x - sp.x));
		//flag2 判断线段是想向左还是向右
		var fx = (ep.x-sp.x>=0)?1:-1;//*注意=0即垂直的情况
		//计算箭头两端坐标
		var h1 = _scrollXOY(ep,theta,len,degree/2,-1,fx);
		var h2 = _scrollXOY(ep,theta,len,degree/2,1,fx);
		return {
			point1 : h1,
			point2 : h2
	};
};
 
 
//旋转坐标
function _scrollXOY(p,theta,len,degree,flag,flag2) {
	return {
		x:p.x-flag2*len*Math.cos(theta)+flag*len*Math.tan(degree* 0.017)*Math.sin(theta),
		y:p.y-flag2*len*Math.sin(theta)-flag*len*Math.tan(degree* 0.017)*Math.cos(theta)
	};
}; 


function LineArrow(x0, y0, x1, y1, degree , len){;
	var points = getArrow(x0, y0, x1, y1, degree , len)
	var result = Line(x0, y0, x1, y1);
	var arrX = new Array()
	var arrY = new Array()
	arrX[0] = points.point1.x;
	arrX[1] = points.point2.x;
	arrX[2] = x1;
	arrY[0] = points.point1.y;
	arrY[1] = points.point2.y;
	arrY[2] = y1;
	result += fillPolygon(arrX, arrY)
	return result;
}

function sign(n) {
	if(n>0)
		return 1
	if(n<0)
		return -1
	return n
}

function Line(x1,y1,x2,y2) {
	var result = "";
	if (x1 > x2)
	{
		var _x2 = x2;
		var _y2 = y2;
		x2 = x1;
		y2 = y1;
		x1 = _x2;
		y1 = _y2;
	}
	var dx = x2-x1, dy = Math.abs(y2-y1),
	x = x1, y = y1,
	yIncr = (y1 > y2)? -1 : 1;

	if (dx >= dy)
	{
		var pr = dy<<1,
		pru = pr - (dx<<1),
		p = pr-dx,
		ox = x;
		while ((dx--) > 0)
		{
			++x;
			if (p > 0)
			{
				result += this.mkDiv(ox, y, x-ox, lineWidth);
				y += yIncr;
				p += pru;
				ox = x;
			}
			else p += pr;
		}
		result += this.mkDiv(ox, y, x2-ox+1, lineWidth);
	}

	else
	{
		var pr = dx<<1,
		pru = pr - (dy<<1),
		p = pr-dy,
		oy = y;
		if (y2 <= y1)
		{
			while ((dy--) > 0)
			{
				if (p > 0)
				{
					result += this.mkDiv(x++, y, lineWidth, oy-y+1);
					y += yIncr;
					p += pru;
					oy = y;
				}
				else
				{
					y += yIncr;
					p += pr;
				}
			}
			result += this.mkDiv(x2, y2, lineWidth, oy-y2+1);
		}
		else
		{
			while ((dy--) > 0)
			{
				y += yIncr;
				if (p > 0)
				{
					result += this.mkDiv(x++, oy, lineWidth, y-oy);
					p += pru;
					oy = y;
				}
				else p += pr;
			}
			result += this.mkDiv(x2, oy, lineWidth, y2-oy+1);
		}
	}
	return result;
} 

function MoveTo(x,y) {	
	Ox = Oy = -1
	xo = Math.round(x)
	yo = Math.round(y)
}

// 圆
function Cir(x,y,r) {
	var result = "";		
	MoveTo(x+r,y)
	for(i=0;i<=360;i+=5) {
		result += LineTo(r*Math.cos(i*rad)+x,r*Math.sin(i*rad)+y)
	}
	return result;
}

// 弧形
function Arc(x,y,r,a1,a2) {
	var result = "";
	MoveTo(r*Math.cos(a1*rad)+x,r*Math.sin(a1*rad)+y)
	for(i=a1;i<=a2;i++) {
		result += LineTo(r*Math.cos(i*rad)+x,r*Math.sin(i*rad)+y)
	}
	return result;
}

// 扇形
function Pei(x,y,r,a1,a2) {
	var result = "";
	MoveTo(x,y)
	for(var i=a1;i<=a2;i++) {
		result += LineTo(r*Math.cos(i*rad)+x,r*Math.sin(i*rad)+y)
	}
	result += LineTo(x,y)
	return result;
}

// 弹出扇形
function PopPei(x,y,r,a1,a2) {
	dx = r*Math.cos((a1+(a2-a1)/2)*rad)/10
	dy = r*Math.sin((a1+(a2-a1)/2)*rad)/10
	x += dx
	y += dy
	MoveTo(x,y)
	var result = "";
	for(var i=a1;i<=a2;i++) {
		result += LineTo(r*Math.cos(i*rad)+x,r*Math.sin(i*rad)+y)
	}
	result += LineTo(x,y)
	return result;
}

// 矩形
function Rect(x,y,w,h) {	
	MoveTo(x,y)
	var result = "";
	result += LineTo(x+w,y)
	result += LineTo(x+w,y+h)
	result += LineTo(x,y+h)
	result += LineTo(x,y)
	return result;
}

// 准星
function zhunxing(x,y) {
	var ox = xo
	var oy = yo
	var oColor = color
	color = "#000000"
	var result = "";
	result += Line(x-5,y,x+6,y)
	result += Line(x,y-6,x,y+5)
	result += print('<div style="position:absolute;font-size:10pt;left:'+(x+5)+';top:'+orgY(y+5)+';">['+x+','+y+']</div>')
	color = oColor
	xo = ox
	yo = oy
	return result
}
// 标注
function biaozhuStr(x,y,s) {
	return '<div style="position:absolute;font-size:10pt;left:'+x+';top:'+orgY(y)+';">'+s+'</div>'
}
function biaozhu(x,y,s,t) {
	var ox = xo
	var oy = yo
	var oColor = color
	point = "p01.gif"
	var result="";
	if(t==1) {
		result += print(biaozhuStr(x-5,y+6,"·"+s))
	}
	if(t==2) {
		result += print(biaozhuStr(xo+x*Math.cos(y*rad)-10,yo+x*Math.sin(y*rad),s))
	}
	color = oColor
	xo = ox
	yo = oy
	return result;
}

function mkDiv(x, y, w, h)
{
	return print('<div style="position:absolute;'+
		'left:' + x + 'px;'+
		'top:' + y + 'px;'+
		'width:' + w + 'px;'+
		'height:' + h + 'px;'+
		'clip:rect(0,'+w+'px,'+h+'px,0);'+
		'background-color:' + this.color +
		';overflow:hidden'+
		';"><\/div>')
}

function fillPolygon(array_x, array_y)
	{
		var result = "";
		var i;
		var y;
		var miny, maxy;
		var x1, y1;
		var x2, y2;
		var ind1, ind2;
		var ints;

		var n = array_x.length;

		if (!n) return;
		miny = array_y[0];
		maxy = array_y[0];
		for (i = 1; i < n; i++)
		{
			if (array_y[i] < miny)
				miny = array_y[i];

			if (array_y[i] > maxy)
				maxy = array_y[i];
		}
		for (y = miny; y <= maxy; y++)
		{
			var polyInts = new Array();
			ints = 0;
			for (i = 0; i < n; i++)
			{
				if (!i)
				{
					ind1 = n-1;
					ind2 = 0;
				}
				else
				{
					ind1 = i-1;
					ind2 = i;
				}
				y1 = array_y[ind1];
				y2 = array_y[ind2];
				if (y1 < y2)
				{
					x1 = array_x[ind1];
					x2 = array_x[ind2];
				}
				else if (y1 > y2)
				{
					y2 = array_y[ind1];
					y1 = array_y[ind2];
					x2 = array_x[ind1];
					x1 = array_x[ind2];
				}
				else continue;

				if ((y >= y1) && (y < y2))
					polyInts[ints++] = Math.round((y-y1) * (x2-x1) / (y2-y1) + x1);

				else if ((y == maxy) && (y > y1) && (y <= y2))
					polyInts[ints++] = Math.round((y-y1) * (x2-x1) / (y2-y1) + x1);
			}
			polyInts.sort(integer_compare);

			for (i = 0; i < ints; i+=2)
			{
				w = polyInts[i+1]-polyInts[i]
				result += this.mkDiv(polyInts[i], y, polyInts[i+1]-polyInts[i]+1, 1);
			}
		}
		return result;
	}

function integer_compare(x,y)
{
	return (x < y) ? -1 : ((x > y)*1);
}
 
function drawText(val, fontSize, left, top, width, height, zoomQuotiety){
	zoomQuotiety = zoomQuotiety || 1;
	return '<input type="text" readonly style="background:transparent;position:absolute;border:0;' +
			'font-size:' + Math.round(fontSize * zoomQuotiety) + 'pt;'+
			'left:' + Math.round(left * zoomQuotiety) + 'px;top:' + Math.round(top * zoomQuotiety)+
				'px;width:' + Math.round(width * zoomQuotiety) + 'px;height:' + Math.round(height * zoomQuotiety)+
			'px;text-align:center'+
			'" value="' + val + '">\r\n';
}


function decrease(ptBegin, ptEnd, toImg) {
//  判断起点是否为对称图行
	if(toImg.width != toImg.height){
		return decreaseRectangle(ptBegin, ptEnd, toImg);
	}
	var len = toImg.width/2;
    var dx = ptEnd.x - ptBegin.x;
    var dy = ptEnd.y - ptBegin.y;
    var xIsLarge = false, yIsLarge = false;
    if (dx < 0) xIsLarge = true;
    if (dy < 0) yIsLarge = true;
    if (dx == 0 && dy == 0) return ptEnd;
    if (dx == 0) {
    	len = toImg.height/2;        	
        if (yIsLarge)
            return {x : ptEnd.x, y : ptEnd.y + len};
        else
            return {x : ptEnd.x, y : ptEnd.y - len};
    }

    if (dy == 0) {
        if (xIsLarge)
            return {x : ptEnd.x + len, y : ptEnd.y};
        else
            return {x : ptEnd.x - len, y : ptEnd.y};
    }

    dx = Math.abs(dx);
    dy = Math.abs(dy);

    var decline = Math.sqrt(Math.pow(dx, 2) + Math.pow(dy, 2));
    var _x = len * dx / decline;
    var _y = len * dy / decline;

    if (xIsLarge && yIsLarge) {
        return {x : ptEnd.x + _x, y : ptEnd.y + _y};
    } else if (xIsLarge) {
        return {x : ptEnd.x + _x, y : ptEnd.y - _y}
    } else if (yIsLarge) {
        return {x : ptEnd.x - _x, y : ptEnd.y + _y}
    } else {
        return {x : ptEnd.x - _x, y : ptEnd.y - _y};
    }
}

function decreaseBegin(ptBegin, ptEnd, fromImg) {
	//判断起点是否为对称图行
	if(fromImg.width != fromImg.height){
		return decreaseBeginRectangle(ptBegin, ptEnd, fromImg);
	}
	var len = fromImg.width/2;
    var dx = ptEnd.x - ptBegin.x;
    var dy = ptEnd.y - ptBegin.y;
    var xIsLarge = false, yIsLarge = false;
    if (dx < 0) xIsLarge = true;
    if (dy < 0) yIsLarge = true;
    if (dx == 0 && dy == 0) return ptBegin;
    if (dx == 0) {
    	len = fromImg.height/2;
        if (yIsLarge)//yEnd <yBegin
            return {x : ptBegin.x, y : ptBegin.y -len};
        else//yEnd >yBegin
            return {x : ptBegin.x, y : ptBegin.y +len};
    }

    if (dy == 0) {
        if (xIsLarge)//xEnd <xBegin
            return {x : ptBegin.x - len, y : ptBegin.y};
        else//xEnd >xBegin
            return {x : ptBegin.x + len, y : ptBegin.y};
    }

    dx = Math.abs(dx);
    dy = Math.abs(dy);

    var decline = Math.sqrt(Math.pow(dx, 2) + Math.pow(dy, 2));
    var _x = len * dx / decline;
    var _y = len * dy / decline;

    if (xIsLarge && yIsLarge) {
        return {x : ptBegin.x - _x, y : ptBegin.y - _y};
    } else if (xIsLarge) {
        return {x : ptBegin.x - _x, y : ptBegin.y + _y};
    } else if (yIsLarge) {
        return {x : ptBegin.x + _x, y : ptBegin.y - _y};
    } else {
        return {x : ptBegin.x + _x, y : ptBegin.y + _y};
    }
}

Integer = {};
Integer.MAX_VALUE = 18014398509481984;

function decreaseRectangle(begin, end, endRect) {
	var k = (end.y-begin.y)/(end.x - begin.x);
	var xLine1 = end.x - endRect.width/2;
	var xLine2 = end.x + endRect.width/2;
	var yLine1 = end.y - endRect.height/2;
	var yLine2 = end.y + endRect.height/2;
	var p1 = getCrossPointByLine(end, k, {x : xLine1, y : yLine1}, Integer.MAX_VALUE);
	var p2 = getCrossPointByLine(end, k, {x : xLine1, y : yLine1}, 0);
	var p3 = getCrossPointByLine(end, k, {x : xLine2, y : yLine2}, Integer.MAX_VALUE);
	var p4 = getCrossPointByLine(end, k, {x : xLine2, y : yLine2}, 0);
	var validPoint1 = null;
	var validPoint2 = null;
	if(validatePoint(end, endRect, p1)){
		validPoint1 = p1;
	}
	if(validatePoint(end, endRect, p2)){
		validPoint1 = p2;
	}
	if(validatePoint(end, endRect, p3)){
		validPoint2 = p3;
	}
	if(validatePoint(end, endRect, p4)){
		validPoint2 = p4;
	}
	var dx = begin.x - end.x;
	var dy = begin.y - end.y;
	return {x : dx>0?Math.max(validPoint1.x, validPoint2.x) : Math.min(validPoint1.x, validPoint2.x), 
			y : dy>0?Math.max(validPoint1.y, validPoint2.y) : Math.min(validPoint1.y, validPoint2.y)};
}

function getCrossPointByLine(point, k, point2, k2) {
	var yLine = point2.y;
	var x = point.x;
	var y = point.y;
	if(k2==0){
		x = Math.round((yLine-point.y)/k+point.x);
		y = yLine;
		return {x:x,y:y};
	}
	var xLine = point2.x;
	if(k2 == Integer.MAX_VALUE){
		x = xLine;
		y = Math.round(k*(x - point.x)+point.y);
	}
	return {x:x,y:y};
}


function validatePoint(begin, rect, p) {
	return Math.abs(p.x-begin.x) <= rect.width/2 && 
		Math.abs(p.y-begin.y) <= rect.height/2;
}


function decreaseBeginRectangle( begin, end, beginRect) {
	var k = (end.y-begin.y)/(end.x - begin.x);
	var xLine1 = begin.x - beginRect.width/2;
	var xLine2 = begin.x + beginRect.width/2;
	var yLine1 = begin.y - beginRect.height/2;
	var yLine2 = begin.y + beginRect.height/2;
	var p1 = getCrossPointByLine(begin, k, { x : xLine1, y : yLine1}, Integer.MAX_VALUE);
	var p2 = getCrossPointByLine(begin, k, { x : xLine1, y : yLine1}, 0);
	var p3 = getCrossPointByLine(begin, k, { x : xLine2, y : yLine2}, Integer.MAX_VALUE);
	var p4 = getCrossPointByLine(begin, k, { x : xLine2, y : yLine2}, 0);
	var validPoint1 = null;
	var validPoint2 = null;
	if(validatePoint(begin, beginRect, p1)){
		validPoint1 = p1;
	}
	if(validatePoint(begin, beginRect, p2)){
		validPoint1 = p2;
	}
	if(validatePoint(begin, beginRect, p3)){
		validPoint2 = p3;
	}
	if(validatePoint(begin, beginRect, p4)){
		validPoint2 = p4;
	}
	var dx = end.x - begin.x;
	var dy = end.y - begin.y;
	return {x : dx>0?Math.max(validPoint1.x, validPoint2.x) : Math.min(validPoint1.x, validPoint2.x), 
			y : dy>0?Math.max(validPoint1.y, validPoint2.y) : Math.min(validPoint1.y, validPoint2.y)};
}
