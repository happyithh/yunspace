<!DOCTYPE html>
<html>
<head>
    <link rel="stylesheet" type="text/css" href="css/lightSlider.css">
    <link href='css/fullcalendar.css' rel='stylesheet'/>
    {*<link href='css/fullcalendar.print.css' rel='stylesheet' media="screen"/>*}
    <link href='css/jquery.fancybox.css' rel='stylesheet' media="screen"/>

    {include file="inc/html_head.tpl" owl=1}

</head>
<body>
{include file="inc/header_nav.tpl"}
<div class="content">
    <div class="bg_w">
        <div class="con wrap clearfix">
            <div class="crumbs fl ">
                <span class="back"><a href="javascript:history.go(-1)"><
                        返回</a> </span>
				<span class="navigation">
                    <a href="{$_root}">首页></a>
                    {foreach $info['parents'] as $k=>$v}
                        <a href="{$_root}space/{$v}">{$_category_info[$v][0]}
                            ></a>
                    {/foreach}
                    <a href="#">{$info['product_name']}</a>
				</span>

                <h1>{$info['product_name']}</h1>
                <div class="s_info2">
                    <span class="s_btn" data-toggle="modal" data-target="#openMap"><a href="javascript:void(0)"> <i class="fa fa-map-marker"></i>&nbsp;{$info['addr']}</a></span>
                </div>
                <div class="s_info">
                    <span>地址：</span>{$info['addr']}
                    <span class="s_btn" data-toggle="modal" data-target="#openMap"><a href="javascript:void(0)">查看地图</a></span>
                </div>
            </div>
            <div class="fr t_cl">
                <div class="text-r mb10">
                    <font class="par">{$info['counter_view']}</font>
                    人已浏览
                </div>
                <div class="sac">
                     <span onclick="showBox('{$_assets}')" class=" s_share_btn s_btn inline-block bgc" ><a href="javascript:;">分享</a></span>
                       <span data-url="{$_root}ajax_collect" class="s_btn inline-block bgc" id='collect' data-uid="{$smarty.session.user.id}" data-status data-id="{$info['id']}" data-type="space"><a href="javascript:;">{$msg}
                                加入收藏</a></span>
                </div>
            </div>
        </div>
    </div>
    <div class="con wrap clearfix">
        <!-- 左边一块 -->
        <div class="s_left fl" id="s_left">
            <div class="t_tap clearfix" id="home_content_tap">
                {foreach $info['media'] as $k=>$v}
                    <span data-banner="{$v[0]}"{if $v[0]==2} class="active"{/if}>{$k}</span>
                {/foreach}
            </div>
            <!-- 内页banner -->
            <div class="server_inner_banner" style="display:block">
                <ul id="imageGallery" class="gallery list-unstyled">
                    {foreach $info['media'] as $k=>$v}
                        {foreach $v[1] as $vv}
                            <li data-thumb="{Page_Site_Global::displayMedia($vv[1],275,195)}">
                                {if $vv[2]}
                                    <a href="{$vv[2]}" class="imageBox videoBox" data-fancybox-group="gallery">
                                        <img src="{Page_Site_Global::displayMedia($vv[1],768,0,2)}" title="{$info['attr']['城市']}{$info['product_name']}-{$info['attr']['基本信息>适合活动类型']}-{$vv[0]}">
                                    </a>
                                {else}
                                    <a href="{Page_Site_Global::displayMedia($vv[1],768,0,1)}" class="imageBox" data-fancybox-group="gallery">
                                        <img src="{Page_Site_Global::displayMedia($vv[1],768,0,1)}" title="{$info['attr']['城市']}{$info['product_name']}-{$info['attr']['基本信息>适合活动类型']}-{$vv[0]}">
                                    </a>
                                {/if}
                            </li>
                        {/foreach}
                    {/foreach}
                </ul>
            </div>
            <div id="wap_left">
                <!-- js动态添加 -->
                <!-- 手机响应式 -->
            </div>
            <div class="s_left_c  conw_s">
                <div class="s_title">适合活动类型</div>
                <div class="clearfix">
                    {if strpos($info['attr']['基本信息>适合活动类型'],',')}
                        {foreach explode(',',$info['attr']['基本信息>适合活动类型']) as $k=>$v}
                            <span class="category"><a href="{$_root}space?filter[基本信息>适合活动类型]={$v}"><font>{$v}</font></a></span>
                        {/foreach}
                    {/if}
                </div>
                <div class="s_title">基本属性</div>
                <div class="clearfix">
                    {foreach $info['attr'] as $k=>$v}
                        {if strpos($k,'基本信息>')===0}
                            {if $k !='基本信息>适合活动类型'}
                                <span><font>{tplDisplayShortAttrName($k)}
                                        : &nbsp;</font> {$v|default:'-'}</span>
                            {/if}
                        {/if}
                    {/foreach}
                </div>
            </div>
            <div class="thd">
                活动案例
            </div>
            <div class="thd_list border1">
                {foreach $event as $v}
                    <div class="list_c">
                        <div class="list_img">
                            <a href="{$_root}event_info/{$v['event_id']}.html"><img src="{$v['logo']}"></a>
                        </div>
                        <div class="list_wz">
                            <h3>
                                <a href="{$_root}event_info/{$v['event_id']}.html" class="me_in">{$v['case_name']}</a>
                                <a class="see_m" href="{$_root}event_info/{$v['event_id']}.html">查看详情</a>
                            </h3>
						<span>
							{mb_substr(strip_tags($v['des']),0,150,'utf-8')}
                            ...
						</span>
                        </div>
                    </div>
                {/foreach}
            </div>
        </div>
        <!-- 左边一块结束 -->
        <!-- 右边一块 -->
        <div class="s_right fr">
            <div class="supplier border1 text_c" id="supplier">
                <div class="s_name">
                    <a href="{$_root}vendor_info/{$info['vendor']['id']}.html">
                    <span><font>供应商
                            : </font>{$info['vendor']['vendor_name']}</span>
                    </a>
                </div>
                <div class="dbl">

                    {*<span class="s_btn inline-block bgc2"><a href="#">五星推荐</a></span>*}
                </div>
                <div class="s_price text_c">
                    <span class="y_pri">参考价格</span>
                    <span class="s_yuan">{if $info['price']>100}{$info['price']}{$info['attr']['价格单位']}{else}面议{/if}</span>
                    {*<span class="s_yuan">面议</span>*}
                    <span class="now_d"><a href="{$_root}booking?id={$info['id']}">立即预定</a></span>
                    <span><a href="{$_root}demand_submit/ask?id={$info['id']}" class="sdc" id="submitrequest">预约咨询</a></span>
                    <a href="{$_root}demand_submit/look?id={$info['id']}" class="sdc" id="submitrequest">我要实地查看</a>
                </div>
            </div>
            <div class="showDate border1">
                <div id="showDate">

                </div>
                <div class="datp clearfix">
                    <div class="c1">
                        <span></span>

                        <p>已预定</p>
                    </div>
                    <div class="c2">
                        <span></span>

                        <p>意向预定</p>
                    </div>
                    <div class="c3">
                        <span></span>

                        <p>未预定</p>
                    </div>
                </div>
            </div>
            <div class="border1 s_kj" id="s_kj">
                <div class="kj_ti">空间介绍</div>
                <div class="">
                    {$info['des']}
                </div>
            </div>

            {*<div class="title2">其他空间推荐</div>*}
            {*<div class="w_lc else_w">*}
            {*<div class="c_info m_bl like_kj">*}
            {*<a href="#"><img data-original="images/home_12.jpg" src="images/home_12.jpg" style="display: inline;"></a>*}

            {*<div class="bb1">*}
            {*<a href="#">红坊-城市雕塑艺术中心</a>*}
            {*</div>*}
            {*<div class="clearfix">*}
            {*<span class="fl"><font class="par">621</font> 人已预定</span>*}
            {*<span class="fr"><font class="par">10</font> 人已预定</span>*}
            {*</div>*}
            {*</div>*}
            {*</div>*}


        </div>
    </div>
</div>
{if $info['addr']}
    {include file="inc/baidu_map_in_info.tpl" addr=$info['addr']}
{/if}
<script type="text/javascript" src="js/bootstrap-datetimepicker.js"></script>
<script type="text/javascript" src="js/jquery.lightSlider.js"></script>
<script type="text/javascript" src="js/moment.min.js"></script>
<script src='js/fullcalendar.js'></script>
<script src='js/jquery.fancybox.js'></script>
<script src='js/collect.js'></script>
<script type="text/javascript" src='js/banner.js'></script>
<script type="text/javascript">
    $(document).ready(function () {
    var showDate = $('#showDate').fullCalendar({
            header: {
                left: 'prev',
                center: 'title',
                right: 'next'
            },
            // start: '2015-02-01',
            // defaultDate: '2015-02-12',
            aspectRatio: 1,
            height: 500,
            contentHeight: 300,
            editable: true,
            timezone: true,
            eventLimit: true, // allow "more" link when too many events
            dayNamesShort: [
                '日', '一', '二', '三', '四', '五', '六'
            ],
            events: '{$_root}json_product_schedule/?product_id={$info['id']}',
            monthNamesShort: [
                '一月', '二月', '三月', '四月', '五月', '六月', '七月', '八月', '九月', '十月', '十一月', '十二月'

            ],
            monthNames: [
                '一月', '二月', '三月', '四月', '五月', '六月', '七月', '八月', '九月', '十月', '十一月', '十二月'
            ]
        });

    });
</script>
{include file="inc/html_share.tpl"}
{include file="Web_Static::v2.0/html_footer.tpl"}
</body>
</html>