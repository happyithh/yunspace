{static "home.v2.0/slide.css"}
{static "js/bootstrap.min.js"}

<div id="carousel-example-generic" class="carousel slide" data-ride="carousel">
    <!-- Indicators -->
    <ol class="carousel-indicators">
        {if $banner}
            {foreach $banner as $k=>$val}
                <li data-target="#carousel-example-generic" data-slide-to="{$k}"  class="carousel-gui {if $k==0} active{/if}" ></li>
            {/foreach}
        {else}
            <li data-target="#carousel-example-generic" data-slide-to="0" class="carousel-gui active"></li>
        {/if}
        {*<li data-target="#carousel-example-generic" data-slide-to="0" class="carousel-gui active"></li>*}
        {*<li data-target="#carousel-example-generic" data-slide-to="1" class="carousel-gui"></li>*}
        {*<li data-target="#carousel-example-generic" data-slide-to="2" class="carousel-gui"></li>*}
        {*<li data-target="#carousel-example-generic" data-slide-to="3" class="carousel-gui"></li>*}
        {*<li data-target="#carousel-example-generic" data-slide-to="4" class="carousel-gui"></li>*}
    </ol>
    <div class="icon-mouse">
        <img src="img/home.v2.0/sb.png" alt="">
    </div>
    <!-- Wrapper for slides -->
    <div class="carousel-inner" role="listbox"   style="overflow-x: hidden">
        {if $banner }
            {foreach $banner as $k=>$val}
                <div class="item {if $k==0} active {/if}">
                    <a href="{$val['url']}">
                        <img src="{$val['path']}" title="{$val['title']}" alt="{$val['title']}">
                    </a>
                </div>
            {/foreach}
        {else}
            <div class="item active">
                <a href="javascript:void(0)">
                    <img src="img/home.v2.0/img_main_5.jpg" title="云.space，活动场地专家" alt="云.space，活动场地专家">
                </a>
            </div>
        {/if}
        {*<div class="item active">*}
            {*<img src="img/home.v3.0/banner1.jpg" alt="...">*}
        {*</div>*}
        {*<div class="item">*}
            {*<img src="img/home.v3.0/banner2.jpg" alt="...">*}
        {*</div>*}
        {*<div class="item">*}
            {*<img src="img/home.v3.0/banner3.jpg" alt="...">*}
        {*</div>*}
    </div>
    <a class="left carousel-control" href="#carousel-example-generic" role="button" data-slide="prev">
        <span class="glyphicon glyphicon-chevron-left" aria-hidden="true"></span>
        <span class="sr-only ion-ios-arrow-left" style="display: block;line-height: 558px;font-size: 50px;"></span>
    </a>
    <a class="right carousel-control" href="#carousel-example-generic" role="button" data-slide="next">
        <span class="glyphicon glyphicon-chevron-right" aria-hidden="true"></span>
            <span class="sr-only ion-ios-arrow-right " style="display: block;line-height: 558px;font-size: 50px;">
            </span>
    </a>
    <div class="range-room-bg">
        <div class="range-room ">
            <div class="range-room-con">
                <div class="r-r-p" style="width:19%;line-height: 40px">
                    我要办一场约
                </div>
                <div class="r-r-select" style="width:18%">
                    <div class="r-r-s-title select-click select1"  style="line-height: 40px;"><div class="par1">50人</div> <span class="ion-arrow-down-b"  style="line-height: 40px;"></span></div>
                    <input type="text" class="select-input hide person-input per-in" value="50人"/>
                    <div class="drop-down-home dropDown hide " style="border: 1px solid #ededed;border-top: 0px;background: #fff;top:50px;">
                        <ul>
                            <li>50人</li>
                            <li>100人</li>
                            <li>300人</li>
                            <li>500人</li>
                            <li>1000人</li>
                            <li>2000+人</li>
                        </ul>
                    </div>
                </div>
                <div class="r-r-p" style="line-height: 40px;width:6%">
                    的
                </div>
                <div class="r-r-select distance" style="width:27%" >
                    <div class="r-r-s-title select-click select1 "  style="line-height: 40px;"><div class="par2">路演/展览/发布会</div> <span class="ion-arrow-down-b"  style="line-height: 40px;"></span></div>
                    <input type="text" class="select-input hide no-show act-in cate-input" value="路演/展览/发布会"/>
                    <div class="drop-down-home dropDown hide" style="border: 1px solid #ededed;border-top: 0px;background: #fff;top:50px;">
                        <ul style="height:204px;">
                            <li>派对/典礼/沙龙</li>
                            <li>年会/晚会/演出</li>
                            <li>路演/展览/发布会</li>
                            <li>会议/讲座</li>
                            <li>团建/拓展</li>
                        </ul>
                    </div>
                </div>
                <div class="r-r-button"  style="line-height: 40px;">
                    <button  type="button" style="line-height: 40px;" class="f-room">提交</button>
                </div>
            </div>

        </div>
        <div class="party-title">
            <span class="ion-ios-bell"></span>&nbsp提交活动需求后，30分钟内获多个精准场地报价
        </div>

    </div>


    <!-- Controls -->
    {*<a class="left carousel-control" href="#carousel-example-generic" role="button" data-slide="prev">*}
        {*<span class="glyphicon glyphicon-chevron-left" aria-hidden="true"></span>*}
        {*<span class="sr-only">Previous</span>*}
    {*</a>*}
    {*<a class="right carousel-control" href="#carousel-example-generic" role="button" data-slide="next">*}
        {*<span class="glyphicon glyphicon-chevron-right" aria-hidden="true"></span>*}
        {*<span class="sr-only">Next</span>*}
    {*</a>*}
</div>