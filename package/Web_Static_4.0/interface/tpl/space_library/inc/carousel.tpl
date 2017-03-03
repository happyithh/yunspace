{static "v4.0/ionicons.min.css"}
{static "space_library/carousel.css"}
{static "home.v2.0/slide.css"}
{static "js/bootstrap.min.js"}

<div id="carousel-example-generic" class="carousel slide" data-ride="carousel" data-home="{$_home}">
    <!-- Indicators -->
    <ol class="carousel-indicators" style="bottom:139px!important;">
        <li data-target="#carousel-example-generic" data-slide-to="0" class="carousel-gui"></li>
        <li data-target="#carousel-example-generic" data-slide-to="1" class="carousel-gui"></li>
        <li data-target="#carousel-example-generic" data-slide-to="2" class="carousel-gui"></li>
        <li data-target="#carousel-example-generic" data-slide-to="3" class="carousel-gui"></li>
        <li data-target="#carousel-example-generic" data-slide-to="4" class="carousel-gui"></li>
        <li data-target="#carousel-example-generic" data-slide-to="5" class="carousel-gui"></li>
    </ol>
    <!-- Wrapper for slides -->
    <div class="carousel-inner" role="listbox"   style="overflow-x: hidden">
        <div class="item">
            <a href="{$_home}meeting">
            <img src="img/space_library/ban_year.jpg" alt="年会一站式贴心服务">
            </a>
        </div>
        <div class="item">
            <img src="img/space_library/ban1.jpg" alt="线下活动场地,活动场所">
        </div>
        <div class="item">
            <img src="img/space_library/ban2.jpg" alt="发布会场地,发布会场所">
        </div>
        <div class="item">
            <img src="img/space_library/ban3.jpg" alt="会议场地,会议酒店,会场">
        </div>
        <div class="item">
            <img src="img/space_library/ban4.jpg" alt="派对场地,沙龙场地,聚会场地">
        </div>
        <div class="item">
            <img src="img/space_library/ban5.jpg" alt="商场场地,商场中庭">
        </div>
        <div class="item">
            <img src="img/space_library/ban6.jpg" alt="高校场地,校园场地,大学场地">
        </div>
    </div>
    <a class="left carousel-control" href="#carousel-example-generic" role="button" data-slide="prev">
        {*<span class="glyphicon glyphicon-chevron-left" aria-hidden="true"></span>*}
        {*<span class="sr-only ion-ios-arrow-left" style="display: block;line-height: 558px;font-size: 50px;"></span>*}
    </a>
    <a class="right carousel-control" href="#carousel-example-generic" role="button" data-slide="next">
        {*<span class="glyphicon glyphicon-chevron-right" aria-hidden="true"></span>*}
            {*<span class="sr-only ion-ios-arrow-right " style="display: block;line-height: 558px;font-size: 50px;">*}
            {*</span>*}
    </a>
    <div class="range-room-bg">
        <div class="black-bg"></div>
        <div class="range-room">
            <div class="range-room-con">
                <div class="r-r-p" style="width:19%;line-height: 40px">
                    我要办一场约
                </div>
                <div class="r-r-select" style="width:18%">
                    <div class="r-r-s-title select-click select1"  style="line-height: 40px;"><div class="par1">50-100人</div> <span class="ion-arrow-down-b"  style="line-height: 40px;"></span></div>
                    <div class="drop-down-home">
                        <ul class="space-person-num clearfix">
                            <li>50人以下</li>
                            <li>50-100人</li>
                            <li>100-300人</li>
                            <li>300-500人</li>
                            <li>500人以上</li>
                        </ul>
                    </div>
                </div>
                <div class="r-r-p" style="line-height: 40px;width:6%">
                    的
                </div>
                <div class="r-r-select distance" style="width:27%" >
                    <div class="r-r-s-title select-click select1 "  style="line-height: 40px;"><div class="par2">路演/展览/发布会</div> <span class="ion-arrow-down-b"  style="line-height: 40px;"></span></div>
                    <div class="drop-down-home clearfix">
                        <ul class="space-type">
                            <li>派对/典礼/沙龙</li>
                            <li>年会/晚会/演出</li>
                            <li>路演/展览/发布会</li>
                            <li>拍摄/比赛/见面会</li>
                            <li>会议/讲座</li>
                            <li>团建/拓展</li>
                            <li>其他活动</li>
                        </ul>
                    </div>
                </div>
                <div class="r-r-button"  style="line-height: 40px;">
                    <button  type="button" style="line-height: 40px;" class="f-room">一键租场地</button>
                </div>
            </div>

        </div>
        <div class="party-title">
            <span class="ion-ios-bell"></span>&nbsp提交活动需求后，30分钟内(工作日)获多个场地方直接报价，直接联系场地方
        </div>

    </div>
    <div class="carousel-top-code">
        <a href="{$_home}"><span style="padding-left:0">首页</span></a>>
        <a href="javascript:;" class="carousel-change-city" id="carousel-change-city">
            <span>{if $_COOKIE['city']}{$_COOKIE['city']}{else}上海{/if}</span>
            <ul ></ul>
        </a>
    </div>
</div>
{static "space_library/carousel.js"}
