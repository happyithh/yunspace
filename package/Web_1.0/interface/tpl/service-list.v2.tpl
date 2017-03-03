<!DOCTYPE html>
<html>
<head>
    {if $page->is_space}
        {include file="Web_Static::v2.0/html_goto_mobile.tpl" url="m/space"}
    {else}
        {include file="Web_Static::v2.0/html_goto_mobile.tpl" url="m/service"}
    {/if}
    {include file="inc/html_head.tpl" owl=1}
    <link href="css/list.css" rel="stylesheet">
    <script type="text/javascript" src="js/highlight.js"></script>
    {static "home.v2.0/homepage.css"}
    {static "home.v2.0/homepage.js"}
</head>
<body>
{include file="Web_Static::v2.0/html_header3.1.tpl"}
<p class="site_location">
    <a href="{$_root}">{$_COOKIE['city']}</a>
    {if !$page->is_space}&nbsp;>&nbsp;
    <a href="{$_root}service">配套服务</a>{/if}
    {foreach $page->topCategoryId['parents'] as $v}
        &nbsp;>&nbsp;
        <a href="">{$page->allCategory[$v][0]}</a>
    {/foreach}
</p>

<div class="wrap con" style="margin-top: 10px;" id="list_content">
    {include file="inc/service-list.v2.filter.tpl"}
    <div class="list_left">
        <div class="indexes">
            <div class="indexes_left">
                <a href="{$___urls['path']}?orderBy=1"><span {if $page->request['orderBy']==1|| $page->request['orderBy']==''} class="active" {/if}>综合</span></a>
                <a href="{$___urls['path']}?orderBy=2"><span {if $page->request['orderBy']==2} class="active" {/if} >最新</span></a>
                <a href="{$___urls['path']}?orderBy=3"><span {if $page->request['orderBy']==3} class="active" {/if} >最热</span></a>
                {*<a href="{$_root}{$___urls['route']}?{$page->filterString}orderBy=1"><span {if $_REQUEST['orderBy']==1|| $_REQUEST['orderBy']==''} class="active" {/if}>综合</span></a>*}
                {*<a href="{$_root}{$___urls['route']}?{$page->filterString}orderBy=2"><span {if $_REQUEST['orderBy']==2} class="active" {/if} >最新</span></a>*}
                {*<a href="{$_root}{$___urls['route']}?{$page->filterString}orderBy=3"><span {if $_REQUEST['orderBy']==3} class="active" {/if} >最热</span></a>*}
            </div>
            <div class="indexes_middle">
                <div class="checkbox">
                    {*<label>*}
                    {*<a href="{$_root}{$___urls['route']}?{$page->filterString}discount=1">*}
                    {*<span style="display: inline-block;width: 15px;height: 15px;border: 1px solid #ccc;border-radius: 1px;" {if $_REQUEST['discount']==1} class="glyphicon glyphicon-ok" {/if}>*}
                    {*</span>*}
                    {*<span>折扣</span>*}
                    {*</a>*}
                    {*</label>*}
                    {*<label>*}
                    {*<a href="{$_root}{$___urls['route']}?{$page->filterString}signing=1">*}
                    {*<span style="display: inline-block;width: 15px;height: 15px;border: 1px solid #ccc;border-radius: 1px;" {if $_REQUEST['signing']==1} class="glyphicon glyphicon-ok"{/if}>*}
                    {*</span>*}
                    {*<span>签约</span>*}
                    {*</a>*}
                    {*</label>*}
                </div>
            </div>
            <div class="indexes_right">
                {*<span class="glyphicon glyphicon-map-marker"></span>*}
            </div>
            <div class="show_way">
                <div style="margin-right: 10px; border:0px" class="" >
                    <a href="http://{Core::$urls['host']}/map" style="color: #00c3c3" target="_blank">
                        <i class="fa fa-map-marker"></i>
                        地图找场地
                    </a>

                </div>
                <div id="show_window" style="border-right: none;" class="act" onclick="show_window(this)">
                    <i class="fa fa-th-large"></i>
                </div>
                <div id="show_list" onclick="show_list(this)" style="none">
                    <i class="fa fa-list"></i>
                </div>
            </div>
            <div class="clearfix"></div>
        </div>
        {if $page->getSpaceList['page']['dt']!=0}
            <div class="se_li_list" style="border-bottom: none;">
                <ul class="product_list get_more_list">
                    {include file="inc/service-list.v2.body-card.tpl"}
                </ul>
                <div class="list_l fl clearfix get_more_list list_ll">
                    {include file="inc/service-list.v2.body-list.tpl"}
                </div>
                        <div class="pagers">
                            {if $page->getSpaceList['page']['dpll']}
                                <a href="{$page->getSpaceList['page']['dup']}1" title="First">第一页</a>
                                <a href="{$page->getSpaceList['page']['dup']}{$page->getSpaceList['page']['dp']-1}"
                                   title="Prev">上一页</a>
                            {else}
                                <a href="" class="prev first gray"><span>&laquo;&nbsp;</span>第一页</a>
                                <a href="" class="prev gray">&lt;&nbsp;上一页</a>
                            {/if}
                            {for $i=$page->getSpaceList['page']['dpl'] to $page->getSpaceList['page']['dpr']}
                                <a href="{$page->getSpaceList['page']['dup']}{$i}"{if $i==$page->getSpaceList['page']['dp']} class="active"{/if}>{$i}</a>
                            {/for}

                            {if $page->getSpaceList['page']['dprr']}
                                <a href="{$page->getSpaceList['page']['dup']}{$page->getSpaceList['page']['dp']+1}"
                                   title="Next">下一页&nbsp;&gt;</a>
                                <a href="{$page->getSpaceList['page']['dup']}{$page->getSpaceList['page']['dtp']}"
                                   title="Last">最后页&nbsp;&raquo;</a>
                            {else}
                                <a href="" class="next gray">下一页&nbsp;&gt;</a>
                                <a href="" class="next last gray">最后页<span>&nbsp;&raquo;</span></a>
                            {/if}
                    
                    <div class="clearfix"></div>
                </div>
            </div>
            {if $page->getSpaceList['page']['dt']<3 &&$page->getSpaceList['page']['dt']>=1}
                <div class="fl clearfix">
                    {include file="inc/service_list_fl_no_result.v2.1.tpl"}
                </div>
            {/if}
        {else}
            <div class="fl clearfix">
                {include file="inc/service_list_fl_no_result.v2.tpl"}
            </div>
        {/if}

        <div class="load_list">
            <button type="button" data-dp="2" onclick="get_more_page(this)" class="btn btn-default btn-lg btn-block">
                加载更多...
            </button>
        </div>

    </div>
    <div class="list_right">
        <div class="list_right_title">
            同类热门<span>推广</span>
        </div>
        <div class="list_right_body">
            {foreach $page->guessYouLike as $v}
                <div class="t_content1">
                    <a href="{$_root}service_info/{$v['id']}.html">
                        {*<img src="{Page_Site_Global::displayMedia($v['logo'],275,195)}">*}
                        {if $v['logo']}
                        <img src="{Page_Site_Global::displayMedia($v['logo'],275,195)}" title="{$v['product_name']}">
                        {else}
                        <img src="{Core::$urls['assets']}img/logo_a.png" title="{$v['product_name']}">
                        {/if}
                    </a>
                    <a href="{$_root}service_info/{$v['id']}.html"><span>{$v['product_name']}</span></a>
                </div>
            {/foreach}
        </div>
    </div>
    <div class="clearfix"></div>
</div>
<script type="text/javascript">

    function show_window(o) {
        $(o).addClass('act');
        $('#show_list').removeClass('act');
        $('.product_list').show();
        $('.list_ll').hide();
        document.cookie = "showType=show_window";
    }
    function show_list(o) {
        $(o).addClass('act');
        $('#show_window').removeClass('act');
        $('.list_ll').show();
        $('.product_list').hide();
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
    /**
     *加载更多页
     *
     */
    function get_more_page(obj) {
        var _this = $(obj);
        var dp = _this.data('dp');
        $.ajax({
            url: window.location.href,
            type: 'get',
            data: {
                'request_devices': 'mobile',
                'dp': dp
            },
            success: function (data) {
                if (data) {
                    _this.data('dp', (dp * 1 + 1));
                    $(data).appendTo('.get_more_list');
                }
            }
        });
    }
</script>
{include file="Web_Static::v2.0/form.tpl"}
{include file="Web_Static::v2.0/html_footer.tpl"}
</body>
</html>