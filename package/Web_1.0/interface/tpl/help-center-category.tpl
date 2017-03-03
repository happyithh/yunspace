<!DOCTYPE html>
<html>
<head>
    {include file="inc/html_head.tpl"}
    <link rel="stylesheet " type="text/css" href="css/help-center.css">
</head>
{if $page->helpCategory[0]['category']}
<body>
{include file="inc/header_nav.tpl"}
<div class="content">
    <div class="con wrap">
        <a href="{$_root}">{$_COOKIE['city']}</a>
        >
        <a href="{$_root}help">帮助中心</a>
    </div>
    {include file="help/help-center-search.tpl"}
    <div class="content1">
        {include file="help/help-center-left1.tpl"}
                <div class="pull-right nav2">
                    <ul>
                        <div class="nav-b"><h4>{$page->helpCategory[0]['category']}</h4></div>
                        {foreach $page->helpCategory as $k=>$v}
                            <li><a href="{$_route}info/{$v['id']}.html"> · {$v['title']}</a> </li>
                            <input type="hidden" name="id" value="{$v['id']}">
                            <input type="hidden" name="category" value="{$v['category']}">
                        {/foreach}
                    </ul>

                    <div class="clearfix"></div>
                </div>
                <div class="clearfix"></div>

        </div>
    </div>
</div>
<div style="margin-top:50px;" class="mt50"></div>
{include file="Web_Static::v2.0/html_footer.tpl"}
<script>
    $(function(){
        $('#question').click(function() {
        $('.menu-a').slideToggle();
        })
    })
</script>

</body>
{else}
    {include file="404.tpl"}
{/if}
</html>