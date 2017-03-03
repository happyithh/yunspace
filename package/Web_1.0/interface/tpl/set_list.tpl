<!DOCTYPE html>
<html>
<head>
    {include file="Web_Static::v2.0/html_goto_mobile.tpl" url="m/set_list"}
    {include file="Web::inc/html_head.tpl" owl=1}
    {include file="Web::inc/set_list/set-list_html.tpl"}
    {static "home.v2.0/homepage.css"}
    {static "home.v2.0/homepage.js"}
</head>
<body>
{include file="Web_Static::v2.0/html_header3.1.tpl"}
<div class="wrap con clearfix">
    <p class="location">
        <a href="{$_root}">{$_COOKIE['city']}</a>
        &nbsp;>&nbsp;<a href="{$_root}set_list">超值套餐</a>
        {if $page->categoryId}
            &nbsp;>&nbsp;
            <a href="">{$page->allCategory[$page->categoryId]}</a>
        {/if}
    </p>

    <div id="list_content"></div>
    {include file="Web::inc/set_list/set_list_filter.tpl"}
    <div class="set_list_left">
        <div class="indexes1">
            <div class="indexes_left">
                <a href="?{$page->filterString}sort=1"><span
                            {if !$_REQUEST['sort'] ||$_REQUEST['sort']==1 }class="active" {/if}>综合</span></a>
                <a href="?{$page->filterString}sort=2"><span {if $_REQUEST['sort']==2}class="active" {/if}>最新</span></a>
                <a href="?{$page->filterString}sort=3"><span
                            {if $_REQUEST['sort']==3}class="active" {/if}> 最热</span></a>
            </div>
            <div class="indexes_middle">
                <div class="checkbox">

                </div>
            </div>
            <div class="indexes_right">
                {*<span class="glyphicon glyphicon-map-marker"></span>*}
            </div>
            <div class="show_way">
                <div id="show_window" style="border-right: none;" class="act" onclick="show_window(this)">
                    <i class="fa fa-th-large"></i></div>
                <div id="show_list" onclick="show_list(this)" style="none">
                    <i class="fa fa-list"></i></div>
            </div>
            <div class="clearfix"></div>
        </div>
        <div class="se_li_list">

            <ul class="set_list ">
                {foreach $page->getSetList['rows'] as $val}
                    <li>
                        <div class="set_pro">
                            <div class="set_img">
                                <a href="/set_info/{$val->id}.html">
                                    <img src="{Page_Site_Global::displayMedia($val->logo,275,195)}">
                                </a>

                                <div class="addr">{$val->addr}</div>
                            </div>
                            <div class="set_infm">
                                <div class="set_name">
                                    <h1>
                                        <a href="/set_info/{$val->id}.html"> {$val->set_name}</a>
                                    </h1></div>
                                <div class="set_icon"><span><img
                                                src="img/set_list/icon01.jpg"></span>{mb_substr($val->attr_index['城市'],0,2,'utf-8')}
                                </div>
                                <div class="set_icon set_icon-b"><span><img src="img/set_list/icon02.jpg"></span>
                                    {mb_substr($val->version,0,6,'utf-8')}</div>
                                <div class="set_icon1"><span><img
                                                src="img/set_list/icon03.jpg"></span>{$val->attr_index['人数']}</div>
                                <div class="clearfix"></div>
                            </div>
                            <div class="set_infm2">
                                <div class="price">
                                    {if $val->detail['套餐价']}
                                        ￥{$val->detail['套餐价']}
                                        {if $val->detail['计价单位']}
                                            /{$val->detail['计价单位']}
                                        {/if}
                                    {else}
                                        面议
                                    {/if}
                                </div>
                                {if $val->hours >= 1}
                                    <div class="date">
                                        {$val->hours}
                                    </div>
                                {/if}
                                <div class="clearfix"></div>
                            </div>
                        </div>
                    </li>
                {/foreach}
            </ul>
            {*套餐列表  start*}
            <div class="list_l fl clearfix list_ll" style="display: none;">
                {foreach $page->getSetList['rows'] as $val}
                    <div class="se_li_list">
                        <div class="fl img_list">
                            <a href="/set_info/{$val->id}.html">
                                <img src="{Page_Site_Global::displayMedia($val->logo,275,195)}">
                            </a>
                        </div>
                        <div class="tw clearfix">
                            <div class="fl wz">
                                <h1>
                                    <a href="/set_info/{$val->id}.html">{$val->set_name}</a>
                                </h1>
                                    <span>
                            <font>地址:</font>{$val->addr}
                            </span>
                            <span class="type">
                                <font>标签: </font>
                                {$val->attr_index['标签']}
                            </span>
                            </div>
                            <div class="fr mene">

                                <span class="mena_m">

                                    {if $val->detail['套餐价']}
                                        ￥{$val->detail['套餐价']}
                                        {if $val->detail['计价单位']}
                                            /{$val->detail['计价单位']}
                                        {/if}
                                    {else}
                                        面议
                                    {/if}</span>

                                <div class="dbl">

                                </div>
                            </div>
                        </div>
                    </div>
                {/foreach}
            </div>
            {* 套餐列表 end*}
            {if $page->getSetList['page']['dt'] !=0}
                <div class="pagers">
                    {if $page->getSetList['page']['dpll']}
                        <a href="{$page->getSetList['page']['dup']}1" title="First">第一页</a>
                        <a href="{$page->getSetList['page']['dup']}{$page->getSetList['page']['dp']-1}"
                           title="Prev">上一页</a>
                    {else}
                        <a href="" class="prev first gray"><span>&laquo;&nbsp;</span>第一页</a>
                        <a href="" class="prev gray">&lt;&nbsp;上一页</a>
                    {/if}
                    {for $i=$page->getSetList['page']['dpl'] to $page->getSetList['page']['dpr']}
                        <a href="{$page->getSetList['page']['dup']}{$i}"{if $i==$page->getSetList['page']['dp']} class="active"{/if}>{$i}</a>
                    {/for}

                    {if $page->getSetList['page']['dprr']}
                        <a href="{$page->getSetList['page']['dup']}{$page->getSetList['page']['dp']+1}"
                           title="Next">下一页&nbsp;&gt;</a>
                        <a href="{$page->getSetList['page']['dup']}{$page->getSetList['page']['dtp']}"
                           title="Last">最后页&nbsp;&raquo;</a>
                    {else}
                        <a href="" class="next gray">下一页&nbsp;&gt;</a>
                        <a href="" class="next last gray">最后页<span>&nbsp;&raquo;</span></a>
                    {/if}
                </div>
                {if $page->getSetList['page']['dt']<3 &&$page->getSetList['page']['dt']>=1}
                    <div class="fl clearfix">
                        {include file="inc/service_list_fl_no_result.v2.1.tpl"}
                    </div>
                {/if}
            {else}
                <div class=" fl clearfix" style="width:930px">
                    {include file="inc/service_list_fl_no_result.v2.tpl"}
                </div>
            {/if}
        </div>
    </div>
    <div class="list_right">
        <div class="list_right_title">
            同类热门<span>推广</span>
        </div>
        {foreach $page->getSetListHot as $val}
            <div class="list_right_body">
                <div class="t_content1">
                    <a href="/set_info/{$val['id']}.html">
                        {*<img src="{Page_Site_Global::displayMedia($val['logo'],275,195)}">*}
                        {if $val['logo']}
                            <img src="{Page_Site_Global::displayMedia($val['logo'],275,195)}"
                                 title="{$val['set_name']}">
                        {else}
                            <img src="{Core::$urls['assets']}img/logo_a.png" title="{$val['set_name']}">
                        {/if}
                    </a>
                    <a href="/set_info/{$val['id']}.html"><span>{$val['set_name']}</span></a>
                </div>
            </div>
        {/foreach}
    </div>
</div>
<script type="text/javascript">

    function show_window(o) {
        $(o).addClass('act');
        $('#show_list').removeClass('act');
        $('.set_list').show();
        $('.list_ll').hide();
        document.cookie = "showType=show_window";
    }
    function show_list(o) {
        $(o).addClass('act');
        $('#show_window').removeClass('act');
        $('.list_ll').show();
        $('.set_list').hide();
        document.cookie = 'showType=show_list';
    }
    //读取cookies
    function getCookie(name) {
        var arr, reg = new RegExp("(^| )" + name + "=([^;]*)(;|$)");
        if (arr = document.cookie.match(reg)) {
            return decodeURI(arr[2]);
        } else {
            return null;
        }
    }
    var showType = getCookie('showType');
    if (showType == 'show_list') {
        $('#show_list').click();
    } else {
        $('#show_window').click();
    }
</script>
<div style="margin-top:50px;" class="mt50"></div>
{include file="Web_Static::v2.0/form.tpl"}
{include file="Web_Static::v2.0/html_footer.tpl"}
</body>
</html>