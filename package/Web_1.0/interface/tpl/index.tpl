<!DOCTYPE html>
<html>
<head>
    {*{include file="Web_Static::v2.0/html_goto_mobile.tpl" url="m/"}*}
    {include file="inc/html_head.tpl" owl=1}
</head>
<body>
<div class="about-us">
<h1>云·Space－商业空间短租平台</h1>
<p>云·SPACE，国内专业活动的商业服务平台。集空间和活动供应商的展示、管理、预定为一体，力求在海量场地中为活动方定位优质精选场地，嫁接最合适的活动供应商，完善活动配套服务。通过线上平台以及后台完善的服务体系，突破传统组织活动归属不清晰、资源不对称、价格不透明等缺陷，为公关活动生态系统的有机成长创造更大的环境和市场。</p>
</div>

{include file="Web_Static::v2.0/html_header3.1.tpl"}
<div class="content">
    <div class="panel-group" id="accordion" role="tablist" aria-multiselectable="true">
        <div class="panel panel-default activity_form">
            <div class="panel-heading" role="tab" id="headingTwo">
                <h4 class="panel-title activity_form_title">
                    <a class="collapsed" data-toggle="collapse" data-parent="#accordion" href="#collapseTwo"
                       aria-expanded="false" aria-controls="collapseTwo" style="display: block; text-align: center;">
                        我要办活动
                    </a>
                </h4>
            </div>
            <div id="collapseTwo" class="panel-collapse collapse" role="tabpanel" aria-labelledby="headingTwo">
                <div class="panel-body">
                    <div>
                        <form action="{$_root}demand_submit" method="post">
                            <div class="solution_right" style="padding: 0 10px">
                                <div class="s_title mb15">
                                    <div class="pull-left">
                                        活动类型
                                    </div>
                                    <div class="pull-right">
                                        <select class="form-control screening" name="data[活动类型]">
                                            {foreach $vendor_attr['活动类型'] as $v}
                                                <option>{$v}</option>
                                            {/foreach}
                                        </select></div>
                                    <div class="clear"></div>
                                </div>

                                <div class="s_title mb15">
                                    <div class="pull-left">
                                        活动人数
                                    </div>
                                    <div class="pull-right">
                                        <select class="form-control screening" name="data[活动人数]">
                                            <option>1-30人</option>
                                            <option>30-50人</option>
                                            <option>50-100人</option>
                                            <option>100-200人</option>
                                            <option>200-400人</option>
                                            <option>400-600人</option>
                                            <option>600-800人</option>
                                            <option>800-1000人</option>
                                            <option>1000人以上</option>

                                        </select>
                                    </div>
                                    <div class="clear"></div>
                                </div>
                                <div class="s_title mb15">
                                    <div class="pull-left" style="float: none;">
                                        活动城市
                                    </div>
                                    <div class="pull-right">
                                        <select class="form-control screening1" name="data[活动城市]">
                                            {foreach $_REQUEST['cities'] as $v}
                                                <option {if $v==$_COOKIE['city']}selected="selected" {/if}>{$v}</option>
                                            {/foreach}
                                            <option>其他</option>
                                        </select>
                                    </div>
                                    <div class="clear"></div>
                                </div>

                                <div class="s_title mb15">
                                    <div class="pull-left" style="float: none;">
                                        活动需求
                                    </div>
                                    <div class="pull-right">
                                        <textarea class="form-control screening1" rows="5" name="data[具体要求]"></textarea>
                                    </div>
                                    <div class="clear"></div>
                                </div>

                                <div class="s_title mb15">
                                    <div class="pull-left" style="float: none;">
                                        联系人姓名
                                    </div>
                                    <div class="pull-right">
                                        <input class="form-control screening1" name="data[联系人]">
                                    </div>
                                    <div class="clear"></div>
                                </div>
                                <div class="s_title mb15">
                                    <div class="pull-left" style="float: none;">
                                        联系人电话
                                    </div>
                                    <div class="pull-right">
                                        <input class="form-control screening1" name="data[联系电话]">
                                    </div>
                                    <div class="clear"></div>
                                </div>
                                {*<div class="checkbox checkbox_solution">*}
                                {*<label><input type="checkbox" value="寻求场地" name="data[需求][]" checked="checked">寻求场地</label>*}
                                {*<label><input type="checkbox" value="配套服务" name="data[需求][]">配套服务</label>*}
                                {*</div>*}
                                <div class="s_title mb15">
                                    <button type="submit" class="btt">
                                        我要办活动
                                    </button>
                                </div>
                                <p style=" text-align:center; color: #666; margin-top: 10px; font-size: 13px;">
                                    工作人员将在30分钟之内与您联系
                                </p>
                            </div>
                        </form>
                        <div class="clear"></div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div class="wrap con clearfix banner_wrap">
        <div class="fl left_nav clearfix" id="left_nav">
            <ul>
                {foreach $left_nav as $k=>$v}
                    {if $v[0]}
                        <li>
                        <span><a href="{$_root}{$v[1]}/{$k}">{$v[0]}</a>
                            <i class="fa fa-angle-right"></i></span>

                            <p {if !$k}style="display: none"{/if}>
                                {foreach $v[2] as $vk=>$vv}
                                    {if $vv}
                                        <a href="{$_root}{$v[1]}/{$vk}">{$vv}</a>
                                    {/if}
                                {/foreach}
                            </p>

                            <div class="all_w">
                                <span><a href="{$_root}{$v[1]}/{$k}">{$v[0]}</a></span>

                                <div><!-- js添加 --></div>
                            </div>
                        </li>
                    {/if}
                {/foreach}
            </ul>
        </div>
        <div id="banner" class="owl-carousel owl-theme fl">
            {foreach $banner as $v}
                <div class="item">
                    {if $v['url']}
                        <a href="{$v['url']}" target="_blank"><img class="lazyOwl"
                                                   data-src="{Page_Site_Global::displayMedia($v['path'],650,0,0)}"
                                                   alt="{$v['title']}"></a>
                    {else}
                        <a href="javascript:void(0)"><img class="lazyOwl"
                                                          data-src="{Page_Site_Global::displayMedia($v['path'],650,0,0)}"
                                                          alt="{$v['title']}"></a>
                    {/if}
                </div>
            {/foreach}
        </div>
        <div class="right_form fr">

            <div>
                <form action="{$_root}demand_submit" method="post">
                    <div class="solution_right" style="padding: 0 10px">
                        <div class="s_title mb15">
                            <div class="pull-left">
                                活动类型
                            </div>
                            <div class="pull-right">
                                <select class="form-control screening" name="data[活动类型]">
                                    {foreach $vendor_attr['活动类型'] as $v}
                                        <option>{$v}</option>
                                    {/foreach}
                                </select></div>
                            <div class="clear"></div>
                        </div>

                        <div class="s_title mb15">
                            <div class="pull-left">
                                活动人数
                            </div>
                            <div class="pull-right">
                                <select class="form-control screening" name="data[活动人数]">
                                    <option>1-30人</option>
                                    <option>30-50人</option>
                                    <option>50-100人</option>
                                    <option>100-200人</option>
                                    <option>200-400人</option>
                                    <option>400-600人</option>
                                    <option>600-800人</option>
                                    <option>800-1000人</option>
                                    <option>1000人以上</option>

                                </select>
                            </div>
                            <div class="clear"></div>
                        </div>
                        <div class="s_title mb15">
                            <div class="pull-left" style="float: none;">
                                活动城市
                            </div>
                            <div class="pull-right">
                                <select class="form-control screening1" name="data[活动城市]">
                                    {foreach $_REQUEST['cities'] as $v}
                                        <option {if $v==$_COOKIE['city']}selected="selected" {/if}>{$v}</option>
                                    {/foreach}
                                    <option>其他</option>
                                </select>
                            </div>
                            <div class="clear"></div>
                        </div>

                        <div class="s_title mb15">
                            <div class="pull-left" style="float: none;">
                                活动需求
                            </div>
                            <div class="pull-right">
                                <textarea class="form-control screening1" rows="5" name="data[具体要求]"></textarea>
                            </div>
                            <div class="clear"></div>
                        </div>

                        <div class="s_title mb15">
                            <div class="pull-left" style="float: none;">
                                联系人姓名
                            </div>
                            <div class="pull-right">
                                <input class="form-control screening1" name="data[联系人]">
                            </div>
                            <div class="clear"></div>
                        </div>
                        <div class="s_title mb15">
                            <div class="pull-left" style="float: none;">
                                联系人电话
                            </div>
                            <div class="pull-right">
                                <input class="form-control screening1" name="data[联系电话]">
                            </div>
                            <div class="clear"></div>
                        </div>
                        {*<div class="checkbox checkbox_solution">*}
                        {*<label><input type="checkbox" value="寻求场地" name="data[需求][]" checked="checked">寻求场地</label>*}
                        {*<label><input type="checkbox" value="配套服务" name="data[需求][]">配套服务</label>*}
                        {*</div>*}
                        <div class="s_title mb15">
                            <button type="submit" class="btt">
                                我要办活动
                            </button>
                        </div>
                        <p style=" text-align:center; color: #666; margin-top: 10px; font-size: 13px;">
                            工作人员将在30分钟之内与您联系
                        </p>
                    </div>
                </form>
                <div class="clear"></div>
            </div>
        </div>
    </div>

    <div class="con wrap clearfix tap_n">
        <div class="con_tap_o fl" id="h_tap">
            <span class="active">热门空间</span>
            <span id="secTapTri">最新空间</span>
        </div>
        <div class="fr">
		<span class="tap_nav_r">
			<a href="{$_root}space/" class="wwz">查看更多</a>
		</span>
        </div>
    </div>
    <div class="con wrap tap_con clearfix">
        <!-- 第一个tap -->
        <div class="mytap" style="display:block">
            <div class="tap_l fl c_info">
                <a href="{$_root}service_info/{$recommend_space[0]['id']}.html"><img
                            data-original="{Page_Site_Global::displayMedia($recommend_space[0]['logo'],440,293)}"></a>

                <div class="bb1">
                    <a href="{$_root}service_info/{$recommend_space[0]['id']}.html">{$recommend_space[0]['product_name']}</a>
                </div>
                <div class="clearfix">
                    {$recommend_space[0]['addr']}
                    {*<span class="fl"><font class="par">{$recommend_space[0]['counter_view']}</font> 次浏览</span>*}
                    {*<span class="fr"><font class="par">{$recommend_space[0]['counter_follow']}</font> 人已收藏</span>*}
                </div>
            </div>
            <div class="tap_r fl">
                {foreach $recommend_space as $k=>$v}
                    {if $k>0&$k<7}
                        <div class="t_content">
                            <a href="{$_root}service_info/{$v['id']}.html"><img
                                        data-original="{Page_Site_Global::displayMedia($v['logo'],275,195)}"></a>
                            <a href="{$_root}service_info/{$v['id']}.html"><span>{$v['product_name']}</span></a>
                        </div>
                    {/if}
                {/foreach}
            </div>
        </div>
        <!-- 第一个tap结束 -->
        <!-- 第二个tap -->
        <div class="mytap" id="sectap">
            <div class="tap_l fl c_info">
                <a href="{$_root}service_info/{$newly_space[0]['id']}.html"><img
                            data-original="{Page_Site_Global::displayMedia($newly_space[0]['logo'],440,293)}"></a>

                <div class="bb1">
                    <a href="{$_root}service_info/{$newly_space[0]['id']}.html">{$newly_space[0]['product_name']}</a>
                </div>
                <div class="clearfix">
                    {$v['addr']}
                    {*<span class="fl"><font class="par">{$newly_space[0]['counter_view']}</font> 次浏览</span>*}
                    {*<span class="fr"><font class="par">{$newly_space[0]['counter_follow']}</font> 人已收藏</span>*}
                </div>
            </div>
            <div class="tap_r fl">
                {foreach $newly_space as $k=>$v}
                    {if $k&&$k<7}
                        <div class="t_content">
                            <a href="{$_root}service_info/{$v['id']}.html"><img
                                        data-original="{Page_Site_Global::displayMedia($v['logo'],275,195)}"></a>
                            <a href="{$_root}service_info/{$v['id']}.html"><span>{$v['product_name']}</span></a>
                        </div>
                    {/if}
                {/foreach}
            </div>
        </div>
        <!-- 第二个tap结束 -->
    </div>
    {*<div class="join">*}
    {*<img src="img/yun-banner.jpg" usemap="#Map"/>*}
    {*<map name="Map">*}
    {*<area shape="rect" coords="634,225,873,324" href="{$_root}user_center/vendor_register">*}
    {*</map>*}
    {*</div>*}
    {if $recommend_shopping}
        <div class="con wrap clearfix tap_n">
            <div class="fl con_t">
                热门商场
            </div>
            <div class="fr">
                <span class="tap_nav_r"><a href="{$_root}space/114" class="wwz">查看更多</a></span>
            </div>
        </div>
        <div class="con wrap clearfix">
            <div class="clearfix w_lc">
                {foreach $recommend_shopping as $k=>$v}
                    {if $k<5}
                        <div class="c_info m_bl">
                            <a href="{$_root}service_info/{$v['id']}.html"><img
                                        data-original="{Page_Site_Global::displayMedia($v['logo'],275,195)}"></a>

                            <div class="bb1">
                                <a href="{$_root}service_info/{$v['id']}.html">{$v['product_name']}</a>
                            </div>
                            <div class="clearfix">
                                {$v['addr']}
                                {*<span class="fl"><font class="par">{$v['counter_view']}</font> 次浏览</span>*}
                                {*<span class="fr"><font class="par">{$v['counter_follow']}</font> 人已收藏</span>*}
                            </div>
                        </div>
                    {/if}
                {/foreach}
            </div>
        </div>
    {/if}
    {if $recommend_show}
        <div class="con wrap clearfix tap_n">
            <div class="fl con_t">
                热门秀场
            </div>
            <div class="fr">
                <span class="tap_nav_r"><a href="{$_root}space/113" class="wwz">查看更多</a></span>
            </div>
        </div>
        <div class="con wrap clearfix">
            <div class="clearfix w_lc">
                {foreach $recommend_show as $k=>$v}
                    {if $k<5}
                        <div class="c_info m_bl">
                            <a href="{$_root}service_info/{$v['id']}.html"><img
                                        data-original="{Page_Site_Global::displayMedia($v['logo'],275,195)}"></a>

                            <div class="bb1">
                                <a href="{$_root}service_info/{$v['id']}.html">{$v['product_name']}</a>
                            </div>
                            <div class="clearfix">
                                {$v['addr']}
                                {*<span class="fl"><font class="par">{$v['counter_view']}</font> 次浏览</span>*}
                                {*<span class="fr"><font class="par">{$v['counter_follow']}</font> 人已收藏</span>*}
                            </div>
                        </div>
                    {/if}
                {/foreach}
            </div>
        </div>
    {/if}
    {if $recommend_special}
        <div class="con wrap clearfix tap_n">
            <div class="fl con_t">
                热门新奇场地
            </div>
            <div class="fr">
                <span class="tap_nav_r"><a href="{$_root}space/124" class="wwz">查看更多</a></span>
            </div>
        </div>
        <div class="con wrap clearfix">
            <div class="clearfix w_lc">
                {foreach $recommend_special as $k=>$v}
                    {if $k<5}
                        <div class="c_info m_bl">
                            <a href="{$_root}service_info/{$v['id']}.html"><img
                                        data-original="{Page_Site_Global::displayMedia($v['logo'],275,195)}"></a>

                            <div class="bb1">
                                <a href="{$_root}service_info/{$v['id']}.html">{$v['product_name']}</a>
                            </div>
                            <div class="clearfix">
                                {$v['addr']}
                                {*<span class="fl"><font class="par">{$v['counter_view']}</font> 次浏览</span>*}
                                {*<span class="fr"><font class="par">{$v['counter_follow']}</font> 人已收藏</span>*}
                            </div>
                        </div>
                    {/if}
                {/foreach}
            </div>
        </div>
    {/if}
    {*<div class="con wrap clearfix tap_n">*}
    {*<div class="fl con_t">*}
    {*热门空间预定*}
    {*</div>*}
    {*<div class="fr">*}
    {*<span class="tap_nav_r"><a href="{$_root}space" class="wwz">查看更多</a></span>*}
    {*</div>*}
    {*</div>*}
    {*<div class="con wrap clearfix">*}
    {*<div class="clearfix w_lc">*}
    {*{foreach $recommend_space2 as $k=>$v}*}
    {*<div class="c_info m_bl">*}
    {*<a href="{$_root}service_info/{$v['id']}.html"><img data-original="{Page_Site_Global::displayMedia($v['logo'],275)}"></a>*}

    {*<div class="bb1">*}
    {*<a href="{$_root}service_info/{$v['id']}.html">{$v['product_name']}</a>*}
    {*</div>*}
    {*<div class="clearfix">*}
    {*<span class="fl"><font class="par">{$v['counter_view']}</font> 次浏览</span>*}
    {*<span class="fr"><font class="par">{$v['counter_follow']}</font> 人已收藏</span>*}
    {*</div>*}
    {*</div>*}
    {*{/foreach}*}
    {*</div>*}
    {*</div>*}
    {if $recommend_service}
        <div class="con wrap clearfix tap_n">
            <div class="fl con_t">
                热门配套服务
            </div>
            <div class="fr">
                <span class="tap_nav_r"><a href="{$_root}service/" class="wwz">查看更多</a></span>
            </div>
        </div>
        <div class="con wrap clearfix">
            <div class="clearfix w_lc">
                {foreach $recommend_service as $k=>$v}
                    <div class="c_info m_bl">
                        <a href="{$_root}service_info/{$v['id']}.html"><img
                                    data-original="{Page_Site_Global::displayMedia($v['logo'],275,195)}"></a>

                        <div class="bb1">
                            <a href="{$_root}service_info/{$v['id']}.html">{$v['product_name']}</a>
                        </div>
                        <div class="clearfix">
                            <span class="fl"><font class="par">{$v['order_counter_view']}</font> 次浏览</span>
                            <span class="fr"><font class="par">{$v['counter_follow']+12}</font> 人已收藏</span>
                        </div>
                    </div>
                {/foreach}
            </div>
        </div>
    {/if}
    {if $newly_event}
        <div class="con wrap clearfix tap_n">
            <div class="fl con_t">
                热门活动案例
            </div>
            <div class="fr">
                <span class="tap_nav_r"><a href="{$_root}event" class="wwz">查看更多</a></span>
            </div>
        </div>
        <div class="con wrap clearfix">
            {*<div class="counter">*}
            {*<div class="counter_left">*}
            {*<h4>热门标签</h4>*}
            {*</div>*}
            {*<div class="counter_right">*}
            {*<button type="button" class="btn btn-primary make_tab">*}
            {*商业广场*}
            {*</button>*}
            {*</div>*}
            {*<div class="clear"></div>*}
            {*<hr>*}
            {*</div>*}
            <div class="clearfix w_lc">
                {foreach $newly_event as $v}
                    <div class="c_info m_bl">
                        <a href="{$_root}event_info/{$v['id']}.html"><img data-original="{$v['logo']}"
                                                                          style="display: inline; "></a>

                        <div>
                            <a href="{$_root}event_info/{$v['id']}.html">{$v['event_name']}</a>
                        </div>

                    </div>
                {/foreach}
            </div>
        </div>
    {/if}
</div>
</div>

<script type="text/javascript" src="js/owl.carousel.min.js"></script>
<script type="text/javascript" src="js/jquery.lazyload.js"></script>
{if !$_COOKIE['js_city'] }
    <script type="text/javascript" src="http://int.dpool.sina.com.cn/iplookup/iplookup.php?format=js"></script>
{/if}
<script type="text/javascript">
    $("#banner").owlCarousel({

        navigation: true, // Show next and prev buttons
        slideSpeed: 300,
        paginationSpeed: 400,
        singleItem: true,
        lazyLoad: true,
        autoPlay: 6000,
        autoplayTimeout: 6000,
        navigationText: ['上一个', '下一个']

    });

    $(document).ready(function () {
        $(".content img").lazyload({
            placeholder: "{$_assets}images/vendor.jpg",
            effect: "fadeIn"
        });
        {if !$_COOKIE['js_city'] }
        if (remote_ip_info) {
            if (remote_ip_info.province == '北京') {
                $('.top_select_city').val('北京').trigger('change');
            } else if (remote_ip_info.province == '广东') {
                $('.top_select_city').val('广州').trigger('change');
            } else if (remote_ip_info.province == '深圳') {
                $('.top_select_city').val('深圳').trigger('change');
            } else if (remote_ip_info.province == '四川') {
                $('.top_select_city').val('成都').trigger('change');
            } else if (remote_ip_info.province == '浙江') {
                $('.top_select_city').val('杭州').trigger('change');
            } else {
                $('.top_select_city').val('上海').trigger('change');
            }
        }
        {/if}
    });
</script>

{*{include file="inc/html_footer.tpl" brand=1}*}
<div style="margin-top:50px;" class="mt50"></div>
{include file="Web_Static::v2.0/form.tpl"}
{include file="Web_Static::v2.0/html_footer.tpl" brand=1}
{static "core/yunspace.js"}
</body>
</html>