{*<div class="banner">*}
    {*<img src="img/wechat_year/banner.jpg">*}
    {*<a class="active-expalin-btn js-expalin-btn js-btn" href="javascript:;">活动说明</a>*}
{*</div>*}
<div class="year_body_advance">
    <img src="img/wechat_year/11_9.jpg" alt="" class="year_body_advance_banner">
    <a class="active-expalin-btn js-expalin-btn js-btn" href="javascript:;"><span class="ion-ios-list-outline" style="font-size: 13px">&nbsp;</span>活动说明</a>
</div>
<div class="clear"></div>
<div class="year_join_person">
    <span class="ion-stats-bars" style="font-size: 20px;">&nbsp;</span><span>已有{$year_all}位参与投票咯</span>
</div>
<div class="comn-wrap">
    <!--随机展示四个年会主题-->
{foreach $year_arr as $k=>$v}
    <div class="comn">
        <div class="comn-theme">
            <div class="comn-theme-img">
                <img src="{$v['img_h']}">
                <div class="text-bg">
                    <div class="text">
                        <h2>{$v['title']}</h2>
                        <p>{$v['des']}</p>
                    </div>
                    <div class="comn-theme-vote">
                        <a  href="{$_home}year/vote?year_id={$v['year_id']}" class="btn-{$v['color']} vote-btn js-vote-btn js-btn" year_id="{$v['year_id']}">立刻投票 抢礼品抢门票</a>
                        <div class="vote-numb">
                            <i></i>
                            {if $is_voted}
                                <p>已投共{intval($v['counter_all'])}票/本周{intval($v['counter'])}票</p>
                            {else}
                                <p>投票后查看投票情况</p>
                            {/if}
                        </div>
                    </div>
                </div><!--text-bg-end-->
            </div><!--comn-theme-img-end-->
        </div>
        <div class="comn-list">
            {foreach $v['detail'] as $kk=>$vv}
            <a class="cont" href="{$vv['href']}">
                <p class="fl text">{$vv['img_title']}</p>
                <div class="fr s-img">
                    <img src="{$vv['img']}">
                </div>
            </a>
            {/foreach}
        </div>
    </div>
{/foreach}
</div><!--comn-wrap-end-->

<div class="copy">
    <p>Copyright©2015</p>
    <p>云·SPACE 沪ICP备12039278号-2</p>
</div>

<div class="consult-btn-wrap">
    <a class="consult-btn js-btn js-consult-btn" href="javascript:;">我要办年会</a>
</div>