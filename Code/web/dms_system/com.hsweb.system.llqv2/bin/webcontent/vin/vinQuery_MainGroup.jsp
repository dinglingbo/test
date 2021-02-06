<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false" %>

<style type="text/css">
.part-img-container {
  border: 1px solid #ddd;
  position: relative;
}
.part-rect {
  border: 2px solid #06c;
  position: absolute;
}
.select-row{
   background:#89c3d6;
}
.part-rect_dash {
  border: 2px dashed #06c;
  position: absolute;
}

/*background: url(https://cdns.007vin.com/img/mum.gif) no-repeat center center*/

</style>

<div id="gridMainGroup" 
    class="nui-datagrid" 
    style="width:100%;height:100%;"
    showColumns="true"
    showPager="false"
    allowcellwrap="true"
    showSummaryRow="true">
    <div property="columns">                                           
    </div>
</div>
<div id="vin_part_img" showModal="true">
    <div  class="full-height"  style="width:100%; height: 100%; display: table">
      <div class="part-img-container j_part-img-container full-height"  style="display: table-cell; vertical-align: middle;text-align: center; ">
        <img class="j_part-img"  style="display:none;" alt="" usemap="#MyfirstMap"> 
        <map id="MyfirestMap" class="j_part-img-map" name="MyfirstMap"></map>
        <div class="j_part-map-rect"></div>
      </div>
    </div>
</div>