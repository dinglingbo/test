<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false" %>
<%@include file="/common/commonRepair.jsp"%>	
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<!-- 
  - Author(s): Administrator
  - Date: 2019-02-18 09:38:27
  - Description:
-->
<head>
<title>培训</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
</head>
<style type="text/css">
  body {
            margin: 0;
            padding: 0;
            border: 0;
            width: 100%;
            height: 100%;
            overflow: hidden;
            font-family: "微软雅黑";
        }

        .liStyle {
            height: 180px;
            width: 250px;
            margin-right: 30px;
            margin-bottom:20px;
            display: inline-block; 
        }

        .videoDiv {
            width: 100%; 
            height: 80%;
            /* background-color: rgb(129, 151, 185); */
            /* border: 1px solid #ccc; */
            cursor:pointer
        }
        .videoCon{
            width: 100%;
            height: 100%;
        }
        .videoSpan {
            font-weight: bold;
            font-size: 18px;
        }
        .playDiv{
            z-index: 99;
            width: 100%; 
            height: 100%;
            position: absolute; 
            top:0;
            left:0;
        }
        .vwidht {
            width: 100%;
            height: 100%;
        }
        .spanClose{
            z-index: 999;
            display:inline-block;
            position:absolute;
            top:30px;
            right:30px;
            cursor:pointer;
            color: darkgray;
        }
</style>

</head>
<body>
<div class="nui-fit">     
        <ul>
                <li class="liStyle">
                    <div class="videoDiv" onclick="showPlayDiv(1)">
                        <video class="videoCon" id="video1"> 
                            <source src="https://mp4.vjshi.com/2019-04-14/eb92eed80a7d15afc46e3389ef9f8368.mp4" type="video/mp4"> 
                        </video>
                    </div>
                    <div style="margin-top:5px;"><span class="videoSpan">XXX视频教程第一集</span></div>
                </li>
                <li class="liStyle">
                    <div class="videoDiv" onclick="showPlayDiv(2)">
                        <video   class="videoCon" id="video1"> 
                            <source src="https://mp4.vjshi.com/2019-04-27/f03999cce061be310f3a2e64f8fd03bb.mp4" type="video/mp4"> 
                        </video>
                    </div>
                    <div style="margin-top:5px;"><span class="videoSpan">XXX视频教程第二集</span></div>
                </li>
                <li class="liStyle">
                    <div class="videoDiv" onclick="showPlayDiv(3)">
                            <video  class="videoCon" id="video1"> 
                                    <source src="https://mp4.vjshi.com/2018-01-10/6fbd8f4956bc14a6e14ce7dfa3d6ebdf.mp4" type="video/mp4"> 
                                </video>
                    </div>
                    <div style="margin-top:5px;"><span class="videoSpan">XXX视频教程第三集</span></div>
                </li>
                <li class="liStyle">
                    <div class="videoDiv" onclick="showPlayDiv(4)">
                            <video   class="videoCon" id="video1"> 
                                    <source src="https://mp4.vjshi.com/2018-11-18/ea7fdce8a7ac7a9285bc2c1c57d83acb.mp4" type="video/mp4"> 
                                </video>
                    </div>
                    <div style="margin-top:5px;"><span class="videoSpan">XXX视频教程第四集</span></div>
                </li>
                <li class="liStyle">
                    <div class="videoDiv" onclick="showPlayDiv(5)">
                            <video    class="videoCon" id="video1"> 
                                    <source src="https://mp4.vjshi.com/2018-11-18/ea7fdce8a7ac7a9285bc2c1c57d83acb.mp4" type="video/mp4"> 
                                </video>
                    </div>
                    <div style="margin-top:5px;"><span class="videoSpan">XXX视频教程第五集</span></div>
                </li>
                <li class="liStyle">
                    <div class="videoDiv" onclick="showPlayDiv(6)">
                            <video    class="videoCon" id="video1"> 
                                    <source src="https://mp4.vjshi.com/2018-11-18/ea7fdce8a7ac7a9285bc2c1c57d83acb.mp4" type="video/mp4"> 
                                </video>
                    </div>
                    <div style="margin-top:5px;"><span class="videoSpan">XXX视频教程第六集</span></div>
                </li>
            </ul>
            <div class="playDiv" id="playDiv" > 
                    <span class="fa fa-close fa-3x spanClose" onclick="stopPlay()"></span>
                    <p align="center" style="width:100%;height:100%;margin: 0;">
                            <video  controls class="vwidht" id="videoPlay">
                                <source src="https://mp4.vjshi.com/2019-04-27/f03999cce061be310f3a2e64f8fd03bb.mp4" type="video/mp4">
                            </video>
                        </p>
            </div>  
</div> 
	<script type="text/javascript">
        nui.parse();
        var videoPlay = document.getElementById("videoPlay");
        $("#playDiv").hide();
        // var list = document.getElementsByClassName("videoDiv");
        // for(var i = 0;i < list.length;i++){
        //     list[i].onclick=function(){
        //         this.style.display="block";
        //     };  
        // } 
        function showPlayDiv(e) {
            $("#playDiv").show();
            var videoUrl = 'https://mp4.vjshi.com/2018-11-18/ea7fdce8a7ac7a9285bc2c1c57d83acb.mp4';
            if(e == 1){
                videoUrl = "https://mp4.vjshi.com/2019-04-14/eb92eed80a7d15afc46e3389ef9f8368.mp4";
            }else if(e == 2){
                videoUrl = "https://mp4.vjshi.com/2019-04-27/f03999cce061be310f3a2e64f8fd03bb.mp4"; 
            }else if(e == 3){
                videoUrl = "https://mp4.vjshi.com/2018-01-10/6fbd8f4956bc14a6e14ce7dfa3d6ebdf.mp4" ; 
            }else if(e == 4){
                videoUrl = "https://mp4.vjshi.com/2018-11-18/ea7fdce8a7ac7a9285bc2c1c57d83acb.mp4" ; 
            }
            videoPlay.src = videoUrl;
            videoPlay.load();
            videoPlay.play();
        }

        function stopPlay() {
            videoPlay.pause();
            $("#playDiv").hide();
        }
    </script>
</body>
</html>