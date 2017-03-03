{*右侧*}
<div class="classify_rt1 clearfix">
    {*icon区*}
    <div class="fixed-rt-img">
        <ul class="fixed-rt-icon clearfix">
            <li class="rt-icon1">一键租场地</li>
            <li class="rt-icon2">场地地图</li>
            <li class="rt-icon3">场地加盟</li>
            <li class="rt-icon4">资料文库</li>
            <li class="rt-icon5">文创项目库</li>
            <li class="rt-icon6">零售</li>
        </ul>
        <div class="show-link">
            <a href="{$_root}space_library?action=form" class="link-true link-img1"></a>
            <a href="{$_root}map2" class="link-true link-img2"></a>
            <a href="{$_root}site_join" class="link-true link-img3"></a>
            <a href="{$_root}database/paper" class="link-true link-img4"></a>
            <a href="{$_root}winchance" class="link-true link-img5"></a>
            <a href="{$_root}retail" class="link-true link-img6"></a>
            {* link-img6*}
            <ul class="small-icon-list">
                <li class="small-icon1"></li>
                <li class="small-icon2"></li>
                <li class="small-icon3"></li>
                <li class="small-icon4"></li>
                <li class="small-icon5"></li>
                <li class="small-icon6"></li>
            </ul>
        </div>
    </div>

    {*热门文章区*}
    <div class="hot_articles">
        {*热门文章区*}
        <div class="classify_right_title">
            <span class="classify_right_title_word">热门文章</span>
        </div>
        <div class="classify_right_content">
            {foreach $page->isNewArticle as $val}
            <div class="classify_right_article">
                <div class="classify_right_article_title">
                    <p>{$val['title']}</p>
                </div>
                <div class="classify_right_article_content none">
                    <p style="height: 45px;text-indent: 2em">
                        <a href="{$_home}article/{Func_NumEncode::e($val['id'])}.html" target="_blank">
                            {mb_substr(strip_tags($val['des']),0,200,'utf-8')}
                        </a>
                    </p>
                    <div class="classify_right_icon">
                        <div class="icon_good icon_good1"><a href="javascript:;" class="zan" data-id="{$val['id']}"><span>{$val['counter_praise']}</span></a>
                        </div>
                        <div class="icon_eye icon_eye1"><a href="javascript:;"><span>{$val['counter_view']}</span></a></div>
                        <div class="clear"></div>
                    </div>
                </div>
            </div>
            {/foreach}

        </div>

        {*热门TAG*}
        <div class="classify_right_title">
            <span class="classify_right_title_word">热门TAG</span>
        </div>
        <ul class="hot_tag">
         {$hotTags=Api_Article_GetRelateArticle::getHotTags($page->handleAction)}
            {foreach $hotTags as $key=>$val}
            <li><a href="{$_home}article_tags?tags={$key}" target="_blank">{$key}</a></li>
           {/foreach}
            <div class="clear"></div>
        </ul>

            {*广告位*}
            <div  class=" classify_right_bottom" yun="pa/pa.js::add" yun-name="Article-Right-A"></div>
    </div>


</div>
<div class="to-top none">

</div>
<script src="js/classify.v2.0/right_article.v2.1.js"></script>

