<!doctype html>
<html>
<head>
    {include file="Web_Mobile_Static::activity_strategy.v2.0/inc.activity_strategy_meta.tpl"}
    {static "v1.0/global.css"}
    {static "activity_strategy.v2.0/act_strategy_header.css"}
    {static "activity_strategy.v2.0/activity_strategy.css"}
    {static "v1.0/jquery-1.11.1.min.js"}
    <link rel="stylesheet" href="plugins/ionicons-master/css/ionicons.min.css">
    <link rel="stylesheet" href="plugins/Swiper-master/css/swiper.min.css">
    <script src="plugins/Swiper-master/js/swiper.min.js"></script>
</head>
<body yun="activity_strategy.v2.0/activity_strategy_list.js::init">
<div yun="hide-app/hide-app.js::init"></div>
<div class="yun_find_info_header none">
    <div class="left">
        <a href="javascript:window.history.back();"><span class="ion-ios-arrow-back"></span></a>
    </div>
    <div class="center">
        <span>云发现</span>
    </div>
    <div class="right">
        <a href="{$_root}m/search/set_list"><span class="ion-ios-search-strong"></span></a>
    </div>
</div>
<div class="content content1">
    {include file="Web_Mobile_Static::activity_strategy.v2.0/inc.activity_strategy_header.tpl"}
    {*<div class="yun_find_info none">*}
        {*<div class="yun_find_img">*}
            {*<img src="img/activity_strategy/fxsx.png" alt="">*}
        {*</div>*}
        {*<div class="yun_find_title1">*}
            {*<p>云·发现<br/><span class="select_title">活动案例</span></p>*}
        {*</div>*}
    {*</div>*}

    <div class="yun_find"  yun="activity_strategy.v2.0/activity_strategy_list.js::showFinds@click" yun-show=".yun_find_nav">
        <div class="yun_find_title">
            {*<div class="yun_find_icon">*}
                {*<img src="img/activity_strategy/fx.png" alt="">*}
            {*</div>*}
            <div class="yun_find_p" data-category_id="{$category_id}">
                云·发现
            </div>
            <div class="clear"></div>

        </div>
        <p class="yun_find_more">
            <span class="ion-ios-arrow-down"></span>
        </p>
        {if $category_id!=0}
        <div class="find_selected">

            {*<div class="v">*}
                {*<img src="img/activity_strategy/zx.png" alt="云发现">*}
            {*</div>*}
            <div class="find_selected_p" style="line-height: 30px;">
                {foreach $allCategory as $k => $v}
                {if $v['id']==$category_id}{$v['name']}{/if}{/foreach}
            </div>
        </div>
        {/if}
        <div class="yun_find_nav none">
            <ul class="yun_find_nav_list"  data-last_id="{$v['id']}" >
                {foreach $allCategory as $k => $v}
                    {if $v['parent']==0 && $v['id']!='12'}
                <li>
                        <a href="{$_home}raiders/{$v['id']}" data-category_id="{$v['id']}"
                           class="yun_find_nav_li">

                            {*<a href="{$_home}raiders/{$v['id']}" data-category_id="{$v['id']}"*}
                               {*yun="activity_strategy.v2.0/activity_strategy_list.js::navClick@click"*}
                               {*class="yun_find_nav_li">*}

                            <div class="yun_find_nav_li_img">
                                {if $v['id']==1}
                                <img src="img/activity_strategy/zx.png" alt="活动资讯">
                                {/if}
                                {if $v['id']==23}
                                <img src="img/activity_strategy/gl.png" alt="活动攻略">
                                {/if}
                                {if $v['id']==6}
                                    <img src="img/activity_strategy/al.png" alt="活动案例">
                                {/if}
                            </div>
                            <div class="yun_find_nav_li_p">
                                {$v['name']}
                            </div>
                        </a>
                        <ul class="yun_find_nav_list_son" style="padding-top:25px;">
                            {foreach $allCategory as $kk => $vv}
                                {if $vv['parent']==$v['id']}
                            <li>
                                <a href="{$_home}raiders/{$vv['id']}">
                                    <b>·&nbsp;</b>{$vv['name']}
                                </a>
                            </li>
                            {/if}
                            {/foreach}
                            {*<li>*}
                                {*<a href="">*}
                                    {*<b>·&nbsp;</b>活动*}
                                {*</a>*}
                            {*</li>*}
                            {*<li>*}
                                {*<a href="">*}
                                    {*<b>·&nbsp;</b>活动*}
                                {*</a>*}
                            {*</li>*}
                            {*<li>*}
                                {*<a href="">*}
                                    {*<b>·&nbsp;</b>活动*}
                                {*</a>*}
                            {*</li>*}
                        </ul>

                </li>
                    {/if}
                {/foreach}
                {*<li>*}
                    {*<a href="javascript:;" class="yun_find_nav_li">*}
                        {*<div class="yun_find_nav_li_img">*}
                            {*<img src="img/activity_strategy/gl.png" alt="">*}
                        {*</div>*}
                        {*<div class="yun_find_nav_li_p">*}
                            {*活动方案*}
                        {*</div>*}
                    {*</a>*}
                {*</li>*}
                {*<li>*}
                    {*<a href="javascript:;" class="yun_find_nav_li">*}
                        {*<div class="yun_find_nav_li_img">*}
                            {*<img src="img/activity_strategy/al.png" alt="">*}
                        {*</div>*}
                        {*<div class="yun_find_nav_li_p">*}
                            {*活动案例*}
                        {*</div>*}
                    {*</a>*}
                {*</li>*}
                {*<li>*}
                    {*<a href="javascript:;" class="yun_find_nav_li">*}
                        {*<div class="yun_find_nav_li_img">*}
                            {*<img src="img/activity_strategy/wk.png" alt="">*}
                        {*</div>*}
                        {*<div class="yun_find_nav_li_p">*}
                            {*经验分享*}
                        {*</div>*}
                    {*</a>*}
                {*</li>*}
                {*<li>*}
                    {*<a href="javascript:;" class="yun_find_nav_li">*}
                        {*<div class="yun_find_nav_li_img">*}
                            {*<img src="img/activity_strategy/bk.png" alt="">*}
                        {*</div>*}
                        {*<div class="yun_find_nav_li_p">*}
                            {*活动资讯*}
                        {*</div>*}
                    {*</a>*}
                {*</li>*}
            </ul>
        </div>
    </div>


    {if $parent==0}
    <div class="show_find">
        {*{var_dump($parent)}*}
        {*{foreach $allCategory as $k => $v}*}
            {*{var_dump('hahahaha')}*}
        {*{if $category_id==$v['id']}*}
            {*{var_dump($v['parent'])}*}
        {*{/if}*}
        {*{/foreach}*}
        {*{if $parent==0}*}
        <div class="show_find_body swiper-container">
            <div class="show_find_body_list swiper-wrapper">
                {*{var_dump($banner['data'])}*}
                {foreach $banner_list as $k=>$v}
                <div class="show_find_body_li swiper-slide">
                    <a href="{$_home}raiders-info/{$v['id']}.html" style="color:#fff">
                        {*<img src="{$v['logo']}" alt="{$v['title']}">*}
                        {*<img src="{Page_Site_Global::displayMedia($v['logo'],100,100)}" alt="{$v['title']}">*}
                        <img src="{Page_Site_Global::displayMedia($v['logo'],750,540)}" alt="{$v['title']}">
                        <div class="bg-shadow" style="background: rgba(0,0,0,0.5);position: absolute;z-index:10;width: 100%;height: 100%;left:0;top:0;"></div>
                        <div class="show_find_body_li_title ">
                            {if mb_strlen($v['title'],'UTF-8')>20}
                                {mb_substr($v['title'],0,19,'UTF-8')}……
                            {else}{$v['title']}{/if}
                        </div>
                        <div class="show_find_body_li_des ">
                            {if mb_strlen($v['des'],'UTF-8')>50}
                                {mb_substr($v['des'],0,49,'UTF-8')}……
                            {else}{$v['des']}{/if}
                        </div>
                    </a>
                </div>
                {/foreach}
                {*<div class="show_find_body_li swiper-slide">*}
                    {*<img src="img/activity_strategy/hdp.png" alt="">*}
                    {*<div class="show_find_body_li_title ">*}
                        {*雨雾首次来到中国|纽约人均排队3小时*}
                    {*</div>*}
                    {*<div class="show_find_body_li_des ">*}
                        {*雨雾是一个150平米的超大艺术装置，它不断下着雨，你在里面任意走动却不会呗淋湿，让你产生能控制雨的错觉...*}
                    {*</div>*}
                {*</div>*}
                {*<div class="show_find_body_li swiper-slide">*}
                    {*<img src="img/activity_strategy/hdp.png" alt="">*}
                    {*<div class="show_find_body_li_title ">*}
                        {*雨雾首次来到中国|纽约人均排队3小时*}
                    {*</div>*}
                    {*<div class="show_find_body_li_des ">*}
                        {*雨雾是一个150平米的超大艺术装置，它不断下着雨，你在里面任意走动却不会呗淋湿，让你产生能控制雨的错觉...*}
                    {*</div>*}
                {*</div>*}
                {*<div class="show_find_body_li swiper-slide">*}
                    {*<img src="img/activity_strategy/hdp.png" alt="">*}
                    {*<div class="show_find_body_li_title ">*}
                        {*雨雾首次来到中国|纽约人均排队3小时*}
                    {*</div>*}
                    {*<div class="show_find_body_li_des ">*}
                        {*雨雾是一个150平米的超大艺术装置，它不断下着雨，你在里面任意走动却不会呗淋湿，让你产生能控制雨的错觉...*}
                    {*</div>*}
                {*</div>*}
            </div>
        </div>
        {*{else}heihei{/if}*}
        <div class="show_find_num">
            <div class="show_find_square"></div>
            <p class="img_num"></p>
        </div>
    </div>
    {else}{/if}

    <div class="act_strategy_content_list">
        <a href="" class="none act_strategy_li_clone" data-href="{$_home}raiders-info/" data-create_time="">
            <div class="act_strategy_content_li">
                <div class="act_strategy_content_li_img ">
                    {*<img src="img/activity_strategy/a1.png" alt="">*}
                    <img src="">
                </div>
                <div class="act_strategy_content_li_title">
                    {*民国图书馆--旧上海图书馆将重生，最快2017年开放*}
                </div>
                <div class="act_strategy_content_li_des">

                    {*小美在作文簿里写上长大后的愿望：一、我希望能有一个可爱的孩子；二、我还希望能有一个爱我的丈夫。结果，发现老师写了一句评语：“请注意先后顺序。”*}
                </div>
                <div class="act_strategy_content_li_footer">
                    <p></p>
                    <p>
                    </p>

                    <div class="number_all">

                        <div class="number_all_look">
                            <div class="number_all_look_img">
                                <p style="float:left;padding-top:2px;">
                                    <img src="img/activity_strategy/eye.png" alt="云发现">
                                </p>

                                <p style="float:left;padding-top:3px;"><span class="look_num"></span></p>
                            </div>
                        </div>
                        <div class="number_all_ok">
                            <div class="number_all_ok_img">
                                <p style="float:left;padding-top:2px;">
                                    <img src="img/activity_strategy/hand1.png" alt="云发现">
                                </p>

                                <p style="float:left;padding-top:3px;"><span class="ok_num"></span></p>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </a>
        {if !empty($rows)}
        <div class="act_strategy_all">
            {foreach $rows as $k => $v}
            <a href="{$_home}raiders-info/{$v['id']}.html" data-create_time="{$v['create_time']}">
                <div class="act_strategy_content_li">
                    {*<div class="act_strategy_content_li_img ">*}
                        {*<img src="img/activity_strategy/a1.png" alt="">*}
                        {*{if $v['logo']}*}
                            {*<img src="{Page_Site_Global::displayMedia($v['logo'],304,185)}" alt="{$v['title']}">*}
                        {*{else}*}
                            {*<img src="{Core::$urls['assets']}img/logo_a.png" alt="{$v['title']}">*}
                        {*{/if}*}
                    {*</div>*}
                    {if $v['logo']}
                    <div class="act_strategy_content_li_img ">
                        {*<img src="img/activity_strategy/a1.png" alt="">*}
                        {*{if $v['logo']}*}
                            {*<img src="{Page_Site_Global::displayMedia($v['logo'],100,50)}" alt="{$v['title']}">*}
                        <img src="{Page_Site_Global::displayMedia($v['logo'],718,424)}" alt="{$v['title']}">
                    </div>
                    {else}
                        {*<img src="{Core::$urls['assets']}img/logo_a.png" alt="{$v['title']}">*}
                    {/if}
                    <div class="act_strategy_content_li_title">
                        {$v['title']}
                        {*民国图书馆--旧上海图书馆将重生，最快2017年开放*}
                    </div>
                    <div class="act_strategy_content_li_des">
                        {if mb_strlen($v['des'],'UTF-8')>86}
                        {mb_substr($v['des'],0,85,'UTF-8')}……
                        {else}{$v['des']}{/if}
                        {*小美在作文簿里写上长大后的愿望：一、我希望能有一个可爱的孩子；二、我还希望能有一个爱我的丈夫。结果，发现老师写了一句评语：“请注意先后顺序。”*}
                    </div>
                    <div class="act_strategy_content_li_footer">
                        {*<p>{if $v['author']}{$v['author']}{else}来自网络{/if}&nbsp;&nbsp;&nbsp;</p>*}
                        <p>{Date('Y-m-d H:i:s',$v['create_time'])}
                        {*<p>&nbsp;&nbsp;&nbsp;{$page->getRaidersDetail['create_time']}*}
                        </p>
                        <div class="number_all">

                            <div class="number_all_look">
                                <div class="number_all_look_img">
                                    <p style="float:left;padding-top:4px;">
                                        <img src="img/activity_strategy/eye.png" alt="{$v['title']}">
                                    </p>

                                    <p style="float:left;padding-top:3px;"><span>&nbsp;&nbsp;{$v['counter_view']}</span></p>
                                </div>
                            </div>
                            <div class="number_all_ok">
                                <div class="number_all_ok_img">
                                    <p style="float:left;padding-top:4px;">
                                        <img src="img/activity_strategy/hand1.png" alt="{$v['title']}">
                                    </p>

                                 <p style="float:left;padding-top:3px;"><span>&nbsp;&nbsp;{$v['counter_praise']}</span></p>
                                </div>
                            </div>
                        </div>
                    </div>


                </div>
            </a>
            {/foreach}
        </div>
        {else}
            Sorry，没有查到您想要的，不过我们会积极拓展您想要的场地和服务。
            您还可拨打400-056-0599提交您的活动需求给我们，我们会尽快帮您找到合适的场地或服务。
        {/if}


        {*<a href="">*}
            {*<div class="act_strategy_content_li">*}
                {*<div class="act_strategy_content_li_img">*}
                    {*<img src="img/activity_strategy/a1.png" alt="">*}
                {*</div>*}
                {*<div class="act_strategy_content_li_title">*}
                    {*民国图书馆--旧上海图书馆将重生，最快2017年开放*}
                {*</div>*}
                {*<div class="act_strategy_content_li_des">*}
                    {*小美在作文簿里写上长大后的愿望：一、我希望能有一个可爱的孩子；二、我还希望能有一个爱我的丈夫。结果，发现老师写了一句评语：“请注意先后顺序。”*}
                {*</div>*}
                {*<div class="act_strategy_content_li_footer">*}
                    {*<p>作者&nbsp;&nbsp;&nbsp;</p>*}
                    {*<p>&nbsp;&nbsp;&nbsp;2015-05-07</p>*}
                {*</div>*}
            {*</div>*}
        {*</a>*}
        {*<a href="">*}
            {*<div class="act_strategy_content_li">*}
                {*<div class="act_strategy_content_li_img">*}
                    {*<img src="img/activity_strategy/a1.png" alt="">*}
                {*</div>*}
                {*<div class="act_strategy_content_li_title">*}
                    {*民国图书馆--旧上海图书馆将重生，最快2017年开放*}
                {*</div>*}
                {*<div class="act_strategy_content_li_des">*}
                    {*小美在作文簿里写上长大后的愿望：一、我希望能有一个可爱的孩子；二、我还希望能有一个爱我的丈夫。结果，发现老师写了一句评语：“请注意先后顺序。”*}
                {*</div>*}
                {*<div class="act_strategy_content_li_footer">*}
                    {*<p>作者&nbsp;&nbsp;&nbsp;</p>*}
                    {*<p>&nbsp;&nbsp;&nbsp;2015-05-07</p>*}
                {*</div>*}
            {*</div>*}
        {*</a>*}
        {*<a href="">*}
            {*<div class="act_strategy_content_li">*}
                {*<div class="act_strategy_content_li_img">*}
                    {*<img src="img/activity_strategy/a1.png" alt="">*}
                {*</div>*}
                {*<div class="act_strategy_content_li_title">*}
                    {*民国图书馆--旧上海图书馆将重生，最快2017年开放*}
                {*</div>*}
                {*<div class="act_strategy_content_li_des">*}
                    {*小美在作文簿里写上长大后的愿望：一、我希望能有一个可爱的孩子；二、我还希望能有一个爱我的丈夫。结果，发现老师写了一句评语：“请注意先后顺序。”*}
                {*</div>*}
                {*<div class="act_strategy_content_li_footer">*}
                    {*<p>作者&nbsp;&nbsp;&nbsp;</p>*}
                    {*<p>&nbsp;&nbsp;&nbsp;2015-05-07</p>*}
                {*</div>*}
            {*</div>*}
        {*</a>*}


    </div>
    <div style="background: #fff;">
        <div class="load_more none">
            <div class="load_more_img">
                <img src="img/activity_strategy/load.gif" alt="">
            </div>
            <div class="load_more_p">加载中...</div>
        </div>
    </div>

    <div class="loaded_all none">
        已加载全部
    </div>
</div>

{*{static "activity_strategy.v2.0/activity_strategy_list.js"}*}
{static "core/yunspace.js"}
{include "Web_Static::v2.0/html_tj.tpl"}
</body>
</html>