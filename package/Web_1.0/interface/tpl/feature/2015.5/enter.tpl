<!DOCTYPE html>
<html>
<head>
    <script type='text/javascript'>
        function uaredirect(murl){
            try {
                if(document.getElementById("bdmark") != null){
                    return;
                }
                var urlhash = window.location.hash;
                if (!urlhash.match("fromapp")){
                    if ((navigator.userAgent.match(/(iPhone|iPod|Android|ios|iPad)/i))) {
                        location.replace(murl);
                    }
                }
            } catch(err){ }
        }
        uaredirect('http://www.yunspace.com.cn/feature_mobile/2015.5/publish/index.html');
    </script>
    {include file="inc/html_head.tpl" owl=1}
    <link rel="stylesheet" href="css/enter.css"/>
</head>
<body>
{include file="inc/header_nav.tpl"}

<div class="main">
    <div id="carousel-example-generic" class="carousel slide" data-ride="carousel">
        <!-- Indicators -->
        <ol class="carousel-indicators">
            <li data-target="#carousel-example-generic" data-slide-to="0" class="active"></li>
            <li data-target="#carousel-example-generic" data-slide-to="1"></li>
            <li data-target="#carousel-example-generic" data-slide-to="2"></li>
        </ol>

        <!-- Wrapper for slides -->
        <div class="carousel-inner" role="listbox">
            <div class="item active">
                <a href="http://www.yunspace.com.cn/set_info/2.html"><img src="images/finger-moving_02.jpg" alt=""></a>
            </div>
            <div class="item">
                <a href="http://www.yunspace.com.cn/set_info/2.html"><img src="images/banner1_02.png" alt=""></a>
            </div>
            <div class="item">
                <a href="http://www.yunspace.com.cn/set_info/2.html"><img src="images/banner02_03.jpg" alt=""></a>
            </div>
        </div>

        <!-- Controls -->
        <a class="left carousel-control" href="#carousel-example-generic" role="button" data-slide="prev">
            <span class="glyphicon glyphicon-chevron-left" aria-hidden="true"></span>
            <span class="sr-only">Previous</span>
        </a>
        <a class="right carousel-control" href="#carousel-example-generic" role="button" data-slide="next">
            <span class="glyphicon glyphicon-chevron-right" aria-hidden="true"></span>
            <span class="sr-only">Next</span>
        </a>
    </div>
    <div class="more">
        <p class="more_p">更多超值套餐</p>

        <div class="wrap clearfix">

            <a href="{$_route}publish.html">
                <div class="more_meal_i more_meal_i_bg1">
                    <p class="more_meal_i_p">发布会</p>
                </div>
            </a>

            <a href="{$_route}tasting.html" >
                <div class="more_meal_i  more_meal_i_bg3" style="margin-right:0px; margin-left:20px;">
                    <p  class="more_meal_i_p">派对酒会</p>
                </div>
            </a>
            <a href="{$_route}salon.html">
                <div  class="more_meal_i more_meal_i_bg4" style="margin-right:0px; margin-left:20px;">
                    <p  class="more_meal_i_p">沙&nbsp;&nbsp;龙</p>
                </div>
            </a>
            <a href="{$_route}annual_meeting.html">
                <div  class="more_meal_i more_meal_i_bg5" style="margin-right:0px; margin-top: 20px;">
                    <p  class="more_meal_i_p">年&nbsp;&nbsp;会</p>
                </div>
            </a>
        </div>
    </div>

    <div class="yun_service">
        <p class="more_p">云Space超值服务</p>
        <ul class="wrap clearfix">
            <li class="service_list">
                <img src="images/f1.jpg" alt="" class="service_img"/>
            </li>
            <li class="service_list">
                <p class="service_text">
                    签到台布置：签到板、指示牌，活动执行将为您置办的有条有理!</p>
            </li>
            <li class="service_list">
                <img src="images/f2.jpg" alt="" class="service_img"/>
            </li>
            <li class="service_list" style="background: #9d8fc5;color:#ffffff">
                <p class="service_text">
                    舞台搭建：专业人员将根据您的需求进行主题舞台搭配组合而成</p>
            </li>
            <li class="service_list">
                <p class="service_text" style="background: #f0a5a5;color:#ffffff">
                    灯光设计：不同主题，不同的灯光效果，满足您对现场灯光的极致要求.</p>
            </li>
            <li class="service_list">
                <img src="images/f4.jpg" alt="" class="service_img"/>
            </li>
            <li class="service_list">
                <p class="service_text">
                    音响效果：发布会伊始，契合主题的音乐美轮美奂，萦绕四周，随着会议
                    的进行，带动全场氛围，进入高潮！</p>
            </li>
            <li class="service_list">
                <img src="images/f3.jpg" alt="" class="service_img"/>
            </li>
            <li class="service_list">
                <img src="images/f6.jpg" alt="" class="service_img"/>
            </li>
            <li class="service_list">
                <p class="service_text">
                    无线mic：完美音质！无杂音、无啸叫、无断频！好mic传播好声音！</p>
            </li>
            <li class="service_list">
                <img src="images/f5.jpg" alt="" class="service_img"/>
            </li>
            <li class="service_list" style="background: #9d8fc5;color:#ffffff">
                <p class="service_text" style="background: #40c6ab">
                    现场拍摄：视觉艺术家-专业摄影师现场跟踪实拍，记录会议实况，抓住每
                    一个动感闪耀瞬间!</p>
            </li>
            <li class="service_list">
                <p class="service_text" style="background: #78bee8;color:#ffffff">
                    会议纪实：专业摄像师，全程跟踪实拍，记录会议的每一个点滴，传承企业
                    品牌经典！</p>
            </li>
            <li class="service_list">
                <img src="images/f7.jpg" alt="" class="service_img"/>
            </li>
            <li class="service_list">
                <p class="service_text">
                    云·SPACE：国内专业活动的商业服务平台。集空间和活动供应商的展示、管理、预定为一体！</p>
            </li>
            <li class="service_list">
                <img src="images/f8.jpg" alt="" class="service_img"/>
            </li>
        </ul>

    </div>
</div>
<script>
    $('.carousel').carousel({
        interval: 4000
    })
</script>
{include file="inc/html_footer.tpl"}
</body>
