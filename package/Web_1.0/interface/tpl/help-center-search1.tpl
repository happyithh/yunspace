<!DOCTYPE html>
<html>
<head>
    {include file="inc/html_head.tpl"}
    <script type="text/javascript" src="js/highlight.js"></script>
    <link rel="stylesheet " type="text/css" href="css/help-center.css">
</head>
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

                <div class="pull-right nav2 se_li_list">
                    {if $page->searchHelpCenter}
                        {include file="help/help-center-search-list.tpl"}
                    {else}
                        {include file="help/help-center-notfound.tpl"}

                    {/if}
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
</html>