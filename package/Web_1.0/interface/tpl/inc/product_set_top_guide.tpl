<style>
    .nav-tabs {
        border-bottom: none;
    }

    .nav > li > a {
        padding: 0px;
        line-height: 60px;
        border-radius: 0px;
        color: #fff !important;
    }

    .nav-tabs > li.active > a, {
        background-color: transparent;
        border: none;
    }

    .nav-tabs .active a {
        background-color: transparent !important;
        border: none !important;
        color: #00c3c3 !important;
    }

    .nav-tabs li a:hover, .nav-tabs li a:focus {
        background-color: transparent !important;
        border: none !important;
        color: #00c3c3 !important;
    }
</style>


<script>
    $(document).ready(function () {
        $('#nav1').click(function () {
            $('html,body').animate({
                scrollTop: $('#pic').offset().top
            }, 500);
        });
        $('#nav2').click(function () {
            $('html,body').animate({
                scrollTop: $('#details').offset().top
            }, 500);
        });
        $('#nav3').click(function () {
            $('html,body').animate({
                scrollTop: $('#case1').offset().top
            }, 500);
        });
        $('#nav4').click(function () {
            $('html,body').animate({
                scrollTop: $('#remark').offset().top
            }, 500);
        });
        $('#nav5').click(function () {
            $('html,body').animate({
                scrollTop: $('#notice').offset().top
            }, 500);
        });

    });


    window.onscroll = function () {

        var scrollTop = document.documentElement.scrollTop || document.body.scrollTop;
        if (scrollTop < 500) {
            document.getElementById('top').style.display = 'none';
        } else {
            document.getElementById('top').style.display = 'block';
        }
    }
</script>

<div class="top_guide_p" id="top">
    <div class="top_guide_p_c">
        <div id="navbar-example">
            <ul class="nav nav-tabs top_guide_p_l" role="tablist">
                <li><a id="nav1" href="#pic">图片展示</a></li>
                <li><a id="nav2" href="#details">套餐详情</a>
                </li>
                {if $page->eventInfo}
                <li><a id="nav3" href="#case1">活动案例</a></li>
                {/if}
                <li><a id="nav4" href="#remark">服务备注</a>
                </li>
                <li><a id="nav5" href="#notice">预定须知</a>
                </li>
            </ul>
        </div>
        <div class="top_guide_p_r">
            {if $page->isBegin&&!$page->isEnd}
                <a href="{$_root}product_set_booking?id={$page->id}&version={$key}" class="btn btn_y"{$key}>
                    预定下单
                </a>
            {elseif $page->isEnd}
                <a href="#" class="btn  btn_y disabled"{$key}>
                    已经结束
                </a>
            {else}
                <a href="#" class="btn  btn_y disabled"{$key}>
                    敬请期待
                </a>
            {/if}
            <div class="product_icon mr35" style="margin-top: 12px;">
                <h5 class="icon">
                    <a data-url="{$_root}ajax_collect" class='collect' data-uid="{$smarty.session.user.id}" data-status data-id="{$page->id}" data-type="set" href="javascript:;"><i class="glyphicon glyphicon-heart-empty"></i>&nbsp;<span>收藏</span></a>
                </h5>
                <h5 class="icon" id="share">
                    <a onclick="showBox('{$_assets}')" href="javascript:;"><span class="fa fa-share-alt"></span>&nbsp;分享</a>
                </h5>
            </div>

        </div>
        <div class="clearfix"></div>
    </div>
</div>

{*<div class="top_guide_p" id="top">*}
{*<div class="top_guide_p_c">*}
{*<ul class="top_guide_p_l">*}
{*<li><a href="#pic">图片展示</a></li>*}
{*<li><a href="#details">套餐详情</a></li>*}
{*<li><a href="#case">活动案例</a></li>*}
{*<li><a href="#remark">服务备注</a></li>*}
{*<li><a href="#notice">预定须知</a></li>*}
{*</ul>*}
{*<div class="top_guide_p_r">*}
{*<button type="button" class="btn btn_y">立即预定*}
{*</button>*}
{*<div class="product_icon mr35">*}
{*<h5 class="icon" style="margin-top: 18px;">*}
{*<a data-url="{$_root}ajax_collect" id='collect' data-uid="{$smarty.session.user.id}" data-status data-id="{$page->id}" data-type="space" href="javascript:;"><i class="glyphicon glyphicon-heart-empty"></i>&nbsp;<span>收藏</span></a>*}
{*</h5>*}
{*<h5 class="icon" id="share" style="margin-top: 18px;">*}
{*<a onclick="showBox('{$_assets}')" href="javascript:;"><span class="fa fa-share-alt"></span>&nbsp;分享</a>*}
{*</h5>*}
{*</div>*}

{*</div>*}
{*<div class="clearfix"></div>*}
{*</div>*}
{*</div>*}