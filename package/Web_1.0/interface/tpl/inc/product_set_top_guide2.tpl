<style>
    .nav-tabs {
        border-bottom: none;
    }

    .nav > li > a {
        padding: 0px;
        line-height: 50px;
        border-radius: 0px;
        color: #24252f!important;
        width: 120px;
        text-align: center;
        height: 50px;
        font-weight: bold;
    }

    .nav-tabs > li.active > a, {
        background-color: transparent;
        border: none;
    }

    .nav-tabs .active a {
        background-color: #fff!important;
        color: #00c3c3 !important;
        border-top:2px solid #00c3c3!important;
        border-left: none!important;
        border-right: none!important;
        line-height: 48px;
    }

    .nav-tabs li a:hover, .nav-tabs li a:focus {
        background-color: #fff!important;
        color: #00c3c3 !important;
        border-top:2px solid #00c3c3!important;
        border-left: none!important;
        border-right: none!important;
        line-height: 48px;
    }
</style>

<div class="top_guide_p" id="top">
    <div class="top_guide_p_c">
        <div id="navbar-example">
            <ul class="nav nav-tabs top_guide_p_l" role="tablist">
                <li><a id="nav1" href="#introduction">商品介绍</a></li>
                <li><a id="nav2" href="#schedule">服务日程</a></li>
                <li><a id="nav3" href="#case">活动案例</a></li>
                <li><a id="nav4" href="#notice">预定须知</a></li>
            </ul>
            <div class="top_guide_p_r">

                {if $page->isBegin&&!$page->isEnd}
                    <a href="{$_root}product_set_booking?id={$page->id}&version={$key}" class="btn_b"{$key}>
                        预定下单
                    </a>
                {elseif $page->isEnd}
                    <a href="#" class="btn_y disabled"{$key}>
                        已经结束
                    </a>
                {else}
                    <a href="#" class="btn_y disabled"{$key}>
                        敬请期待
                    </a>
                {/if}
                <a data-toggle="modal" href="#openDemanAsk" ask_id="{$page->id}" ask_type="5" class="btn_y demandAsk">预约咨询</a>
                    <div class="clearfix"></div>
            </div>
            <div class="share" >
                <h7 class="icon" id="share">
                    <a onclick="showBox('{$_assets}')" href="javascript:;"><span class="fa fa-share-alt"></span>&nbsp;分享</a>
                </h7>
                <h7 class="icon">
                    <a data-url="{$_root}ajax_collect" class='collect' data-uid="{$smarty.session.user.id}" data-status data-id="{$page->id}" data-type="set" href="javascript:;"><i class="glyphicon glyphicon-heart-empty"></i>&nbsp;<span>收藏</span></a>
                </h7>
            </div>
            <div class="clearfix"></div>
        </div>


    </div>
</div>