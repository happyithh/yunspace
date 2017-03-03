<!DOCTYPE html>
<html>
<head>
    {include file="inc/html_head.tpl"}
    <link rel="stylesheet " type="text/css" href="css/help-center.css">
</head>
{if $page->helpDetail[0]['contents']}
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

                    <div class="nav-c">
                        <div class="pull-left nav-c-1"> <h4>{$page->helpDetail[0]['category']}  <span> > </span> <strong>{$page->helpDetail[0]['title']}</strong></h4></div>
                        <div class="pull-right nav-c-2"><a href="{$_root}help">返回首页>></a></div>
                        <div class="clearfix"></div>
                    </div>
                    <div class="text1">

                        <p>
                            {$page->helpDetail[0]['contents']}

                        </p>

                    </div>

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