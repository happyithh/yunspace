<div class="banner-img-search ">
    <div class="search-body">
        <div class="ion-ios-search-strong  search-icon hide"></div>
        <!--<div class="position-city">-->
            <!--<a href="javascript:;" class="city-option">-->
                <!--<div class="position-city-icon">-->
                    <!--<span class="ion-ios-location"></span>-->
                <!--</div>-->
                <!--<div class="position-city-name">-->
                    <!--{$city}-->
                <!--</div>-->
            <!--</a>-->
        <!--</div>-->
        <div class="search-input">
            {*<input type="text" placeholder="输入场地或供应商名称" class="search">*}
            <a href="{$_home}space" class="search">
                搜索场地库
                <span class="ion-ios-search-strong"></span>
            </a>
        </div>
        <div class="clear"></div>
    </div>
</div>

<div class="provide-activity">
    <a href="{$_home}inquiry" class="provide-act activity-demand">
        <span class="ion-paper-airplane"></span>
    </a>
</div>
<div class="provide-activity" style="top:140px; ">
    <a href="tel:400-056-0599" class="provide-act a2 activity-demand">
        <span class="ion-android-call"></span>
    </a>
</div>

<div class="nav-fix">
    <div class="nav-point">
        <span class="ion-navicon-round"></span>
    </div>
    <ul class="nav-fix-list">
        <li>
            <a href="{$_home}sites/112">
                <img src="img/index.v2.0/i1.png" alt="">
            </a>
        </li>
        <li>
            <a href="{$_home}sites/200">
                <img src="img/index.v2.0/i2.png" alt="">
            </a>
        </li>
        <li>
            <a href="{$_home}sites/400">
                <img src="img/index.v2.0/i3.png" alt="">
            </a>
        </li>
        <li>
            <a href="{$_home}sites/300" >
                <img src="img/index.v2.0/i4.png" alt="">
            </a>
        </li>
        <li>
            <a href="{$_home}user_center/">
                <img src="img/index.v2.0/i5.png" alt="" >
            </a>
        </li>
    </ul>
</div>





{*<div class="banner-img-search search-scroll">*}
{*<div class="search-body search-body-scroll">*}
{*<span class="ion-ios-search-strong"></span>*}
{*<div class="position-city">*}
{*<a href="">*}
{*<div class="position-city-icon">*}
{*<span class="ion-ios-location"></span>*}
{*</div>*}
{*<div class="position-city-name">*}
{*上海市*}
{*</div>*}
{*</a>*}
{*</div>*}
{*<div class="search-input">*}
{*<input type="text" placeholder="输入场地或供应商名称" class="search">*}
{*<a href="">场地/商圈/配套服务</a>*}
{*</div>*}
{*<div class="clear"></div>*}
{*</div>*}
{*</div>*}
<div class="content">
    <div class="banner1">
        <div class="banner-img">
            <img src="img/index.v2.0/tb.jpg" alt="">
        </div>
        <div class="logo">
            <img src="img/index.v2.0/logo_m_0520.png" alt="云SPACE">
        </div>
        <div class="banner1-act">
            <p class="banner1-act-title">
                一场经典的活动 = 好创意 + 好场地
            </p>
            <p class="banner1-des1">
                全国数万家场地资源，打造你的专属服务
            </p>
            <a class="banner1-act-link activity-demand" href="{$_home}inquiry">
                <span class="yj-icon" ></span>&nbsp;&nbsp;一键租场地
            </a>
        </div>
        <ul class="des">
            <li>
                <a href="{$_home}sites/112">
                    <img src="img/index.v2.0/i1.png" alt="空间场地">
                    <p class="des-li">空间</p>
                </a>
            </li>
            <li>
                <a href="{$_home}sites/200">
                    <img src="img/index.v2.0/i2.png" alt="超值套餐">
                    <p>文创</p>
                </a>
            </li>
            <li>
                <a href="{$_home}sites/400">
                    <img src="img/index.v2.0/i3.png" alt="配套服务">
                    <p>资讯</p>
                </a>
            </li>
            <li>
                <a href="{$_home}sites/300">
                    <img src="img/index.v2.0/i4.png" alt="云·发现">
                    <p>发现</p>
                </a>
            </li>
        </ul>
        {*<div class="phone-free">*}
            {*<a href="tel:400-056-0599" style="color:#fff;display: block"><span class="ion-android-call"></span>&nbsp;&nbsp;400-056-0599</a>*}
        {*</div>*}
    </div>
    <div class="find">
       好阅读，与你共享
    </div>
    <div class="banner5">
        <a href="{$_home}articles">
        <div class="banner5-img">
            <div class="banner5-img1">
                <div class="img">
                    <img src="img/index.v2.0/yd.jpg" alt="">
                </div>
            </div>
            <!--<div class="banner5-con">-->
                <!--<p class="banner5-p1">我有靠谱的活动资源</p>-->
                <!--<p class="banner5-p2">成为云SPACE的活动供应商，立即获取客户和收益</p>-->
                <!--<a href="{$_home}vendor_join" class="banner5-btn">加入供应商</a>-->
            <!--</div>-->
        </div>
        </a>
    </div>
    <div class="find">
        精选推荐
    </div>
    <div class="banner4">

        <ul class="banner4-list">
            {foreach $everydayRecommend as $k=>$v}
            <li>
                <a href="{$_home}site/{Func_Url::str_urlencode($v['space_name'])}">
                    <div class="banner4-img">
                        {if !empty($v['mobile_logo'])}
                            <img src="{Page_Site_Global::displayMedia($v['mobile_logo'],640,424)}" alt="">
                        {else}
                            <img src="{Page_Site_Global::displayMedia($v['logo'],640,424)}" alt="">
                        {/if}
                    </div>
                    <div class="bg-cover">
                        <p class="banner4-title">{$v['space_name']}</p>
                        <p class="banner4-des">
                            {if !empty($v['attr']['营销标题'])}{$v['attr']['营销标题']}
                            {elseif !empty($v['addr'])}
                                {$v['addr']}
                            {else}
                                ......
                            {/if}
                        </p>
                        <div class="bn-data">
                            <p><span>{$v['click']}</span></p>
                            <p><span>{$v['sum']}</span></p>
                        </div>
                    </div>
                </a>
            </li>
            {/foreach}
        </ul>
    </div>
    <div class="find">
        发现·文创
    </div>
    <div class="banner4">

        <ul class="banner4-list">
            {foreach $findData['pic_space'] as $k=>$v}
                {if $k<3}
            <li>
                <a href="{$_home}site/{Func_Url::str_urlencode($v['space_name'])}">
                    <div class="banner4-img">
                        {if !empty($v['mobile_logo'])}
                            <img src="{Page_Site_Global::displayMedia($v['mobile_logo'],640,424)}" alt="">
                        {else}
                            <img src="{Page_Site_Global::displayMedia($v['logo'],640,424)}" alt="">
                        {/if}
                    </div>
                    <div class="bg-cover">
                        <p class="banner4-title">{$v['space_name']}</p>
                        <p class="banner4-des">
                            {if !empty($v['attr']['营销标题'])}{$v['attr']['营销标题']}
                            {elseif !empty($v['addr'])}
                                {$v['addr']}
                            {else}
                                ......
                            {/if}
                        </p>
                        <div class="bn-data">
                            <p><span>{$v['click']}</span></p>
                            <p><span>{$v['sum']}</span></p>
                        </div>
                    </div>
                </a>
            </li>
                {/if}
            {/foreach}
            {foreach $wenChuangData['pic_space'] as $k=>$v}
                {if $k<1}
            <li>
                <a href="{$_home}site/{Func_Url::str_urlencode($v['space_name'])}">
                    <div class="banner4-img">
                        {if !empty($v['mobile_logo'])}
                            <img src="{Page_Site_Global::displayMedia($v['mobile_logo'],640,424)}" alt="">
                        {else}
                            <img src="{Page_Site_Global::displayMedia($v['logo'],640,424)}" alt="">
                        {/if}
                    </div>
                    <div class="bg-cover">
                        <p class="banner4-title">{$v['space_name']}</p>
                        <p class="banner4-des">
                            {if !empty($v['attr']['营销标题'])}{$v['attr']['营销标题']}
                            {elseif !empty($v['addr'])}
                                {$v['addr']}
                            {else}
                                ......
                            {/if}
                        </p>
                        <div class="bn-data">
                            <p><span>{$v['click']}</span></p>
                            <p><span>{$v['sum']}</span></p>
                        </div>
                    </div>
                </a>
            </li>
                {/if}
            {/foreach}

        </ul>
    </div>
    <div class="find js-find">
        城市合伙人
    </div>
    <div class="banner5">
        <div class="banner5-img">
            <div class="banner5-img1">
                <img src="img/index.v2.0/p1.jpg" alt="">
            </div>
            <div class="banner5-con">
                <p class="banner5-p1">云·SPACE城市合伙人</p>
                <p class="banner5-p2">共享商业地产万亿元市场</p>
                <a href="{$_home}city_collaborate" class="banner5-btn" style="background:#ff308e">立即加入</a>
            </div>
        </div>
    </div>
    <div class="find js-find">
        场地招募
    </div>
    <div class="banner5">
        <div class="banner5-img">
            <div class="banner5-img1">
                <img src="img/index.v2.0/banner8.jpg" alt="">
            </div>
            <div class="banner5-con">
                <p class="banner5-p1">我有场地要出租</p>
                <p class="banner5-p2">云SPACE助您轻松解决场地烦恼</p>
                <a href="http://www.yunspace.com.cn/m/sitejoin" class="banner5-btn">出租场地</a>
            </div>
        </div>
    </div>
    {*<div class="find">*}
        {*爆&nbsp;料*}
    {*</div>*}
    {*<div class="banner5">*}
        {*<div class="banner5-img">*}
            {*<div class="banner5-img1">*}
                {*<img src="img/index.v2.0/banner9.jpg" alt="">*}
            {*</div>*}
            {*<div class="banner5-con">*}
                {*<p class="banner5-p1">提供身边朋友的活动需求</p>*}
                {*<p class="banner5-p2">他们获得免费服务，您也可以获得收益</p>*}
                {*<a href="{$_home}broke_news" class="banner5-btn" style="background: #ff308e">提供线索</a>*}
            {*</div>*}
        {*</div>*}
    {*</div>*}
    <!--<div class="find js-find">-->
        <!--集&nbsp;采-->
    <!--</div>-->
    <!--<div class="banner5">-->
        <!--<div class="banner5-img">-->
            <!--<div class="banner5-img1">-->
                <!--<img src="img/index.v2.0/007.jpg" alt="">-->
            <!--</div>-->
            <!--<div class="banner5-con">-->
                <!--<p class="banner5-p1">云·SPACE集采会员</p>-->
                <!--<p class="banner5-p2">优质场地也能更优惠(最高降30%)</p>-->
                <!--<a href="http://d15.yunspace.com.cn/feature_mobile/2015.9/jicai/index.html" class="banner5-btn" style="background: #158eff">申请体验</a>-->
            <!--</div>-->
        <!--</div>-->
    <!--</div>-->
    {*<div class="find js-find">*}
        {*活动*}
    {*</div>*}
    {*<div class="banner5">*}
        {*<div class="banner5-img">*}
            {*<div class="banner5-img1">*}
                {*<img src="img/index.v2.0/winchuang.jpg" alt="">*}
            {*</div>*}
            {*<div class="banner5-con">*}
                {*<p class="banner5-p1">提供身边朋友的活动需求</p>*}
                {*<p class="banner5-p2">他们获得免费服务，您也可以获得收益</p>*}
                {*<a href="{$_home}winchance" class="banner5-btn" style="background: #ff308e">提供线索</a>*}
            {*</div>*}
        {*</div>*}
    {*</div>*}
    <div class="find js-find">
        文创项目
    </div>
    <div class="banner5">
        <div class="banner5-img">
            <div class="banner5-img1" style="background: #000;">
                <img src="img/index.v2.0/winchuang.jpg" alt="">
            </div>
            <div class="banner5-con">
                <p class="banner5-p1">云·SPACE文创项目</p>
                <p class="banner5-p2">将文化创意与商业体态结合</p>
                <a href="{$_home}winchance" class="banner5-btn" style="background: #f38f8f">点击进入</a>
            </div>
        </div>
    </div>
    <div class="footer">
        Copyright©2015 云·SPACE 沪ICP备12039278号-2
    </div>
</div>