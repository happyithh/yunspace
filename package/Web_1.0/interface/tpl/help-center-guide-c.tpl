<!DOCTYPE html>
<html>
<head>
    {include file="inc/html_head.tpl"}
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

        <div class="pull-right nav2">
            {if $page->searchHelpCenter}
                {include file="help/help-center-search-list.tpl"}
            {elseif !empty($_REQUEST['search'])}
                {include file="help/help-center-notfound.tpl"}
            {else}
            <div class="nav-c">
                <div class="pull-left nav-c-1"> <h4>新手指南  <span> > </span> <strong>用户注册</strong></h4></div>
                <div class="pull-right nav-c-2"><a href="{$_root}help">返回首页>></a></div>
                <div class="clearfix"></div>
            </div>

            <div class="guide">
                <div class="flow">
                    <ul>
                        <li class="pull-left" ><a href="{$_route}guide.html"><div class="icon1"><i class="fa fa-user m2"></i><span>用户注册</span></div></a></li>
                        <li class="pull-left" ><a href="{$_route}guide/b.html"><div class="icon1"><i class="fa fa-suitcase m2"></i><span>供应商加盟</span></div></a></li>
                        <li class="pull-left" style="background: #00c3c3; color:#fff;"><a href="{$_route}guide/c.html"><div class="icon1"><i class="fa fa-chain m1"></i><span   style="color:#fff;">交易流程</span></div></a></li>
                        <li class="pull-left"><a href="{$_route}guide/d.html"><div class="icon1"><i class="fa fa-pencil-square m2"></i><span>供应商管理后台</span></div></a></li>
                        <li class="pull-left"><a href="{$_route}guide/e.html"><div class="icon1"><i class="fa fa-minus-square m2"></i><span>用户后台</span></div></a></li>
                    </ul>
                    <div class="clearfix"></div>
                </div>
                <div class="guide-1">
                    <img  class="img-responsive" src="images/jy1.jpg">
                    <img  class="img-responsive" src="images/jy2.jpg">
                    <img  class="img-responsive" src="images/jy3.jpg">
                    <img  class="img-responsive" src="images/jy4.jpg">
                    <img  class="img-responsive" src="images/jy5.jpg">
                    <img  class="img-responsive" src="images/jy6.jpg">
                    <img  class="img-responsive" src="images/jy7.jpg">
                    <img  class="img-responsive" src="images/jy8.jpg">
                    <img  class="img-responsive" src="images/jy9.jpg">
                    <img  class="img-responsive" src="images/jy10.jpg">
                    <img  class="img-responsive" src="images/jy11.jpg">
                    <img  class="img-responsive" src="images/jy12.jpg">
                    <img  class="img-responsive" src="images/jy13.jpg">
                </div>
            </div>
            {/if}
        </div>
        <div class="clearfix"></div>
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