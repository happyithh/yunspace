<!DOCTYPE html>
<html>
<head>
    {include file="inc/html_head.tpl"}
</head>
<body>
{include file="inc/header_nav.tpl"}
<div class="content eh_con">
    <div style="background: #000">
        <div class="banner">
            <img src="images/u0.jpg">
        </div>
    </div>
    <div class="wrap">
        <div class="page_nt">
            最新活动案例
        </div>
        <div class="eve_lc clearfix">
            {foreach $list['rows'] as $v}
                <div class="eve_list">
                    <a href="{$_root}event_info/{$v['id']}.html">
                        {if {$v['logo']}}
                            <img src="{Page_Site_Global::displayMedia($v['logo'],278,176,0)}">
                        {else}
                            <img width="278" height="176" src="img/s_logo.jpg">
                        {/if}
                    </a>
                    <span><a href="{$_root}event_info/{$v['id']}.html">{$v['event_name']}</a></span>
                </div>
            {/foreach}
        </div>

        <div class="pageing_wrap  clearfix" style="border-top:0; margin-top:30px;">
            <div class="paging">

                {if $list['page']['dpll']}
                    <a href="{$list['page']['dup']}1" title="First"><i class="fa fa-angle-double-left"></i></a>
                    <a href="{$list['page']['dup']}{$list['page']['dp']-1}" title="Prev"><i class="fa fa-angle-left"></i></a>
                {else}
                    <a href="#" title="First"><i class="fa fa-angle-double-left"></i></a>
                    <a href="#" title="Prev"><i class="fa fa-angle-left"></i></a>
                {/if}
                {for $i=$list['page']['dpl'] to $list['page']['dpr']}
                    <a href="{$list['page']['dup']}{$i}"{if $i==$list['page']['dp']} class="active"{/if}>{$i}</a>
                {/for}

                {if $list['page']['dprr']}
                    <a href="{$list['page']['dup']}{$list['page']['dp']+1}" title="Next"><i class="fa fa-angle-right"></i></a>
                    <a href="{$list['page']['dup']}{$list['page']['dtp']}" title="Last"><i class="fa fa-angle-double-right"></i></a>
                {else}
                    <a href="#" title="Next"><i class="fa fa-angle-right"></i></a>
                    <a href="#" title="Last"><i class="fa fa-angle-double-right"></i></a>
                {/if}
            </div>
        </div>
    </div>
</div>
<div style="margin-top:50px;" class="mt50"></div>
{include file="Web_Static::v2.0/html_footer.tpl"}
</body>
</html>