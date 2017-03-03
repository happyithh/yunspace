{*右侧*}
<div class="classify_rt clearfix">
    <ul class="classify_rt_img ">
        <li><a href="{$_root}space_library?action=form" class="static_link one"></a></li>
        <li><a href="{$_root}map2" class="static_link two"></a></li>
        <li><a href="{$_root}site_join" class="static_link three"></a></li>
        <li><a href="{$_root}database/paper" class="static_link four"></a></li>
        <li><a href="{$_root}winchance" class="static_link five"></a></li>
        <li><a href="{$_root}retail" class="static_link six"></a></li>
    </ul>
    <div class="fixed-rt-img none">
        <ul class="fixed-rt-icon clearfix">
            <li class="rt-icon1">一键租场地</li>
            <li class="rt-icon2">场地地图</li>
            <li class="rt-icon3">场地出租</li>
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
    <div id="new_articles">
        <div class="classify_rt_title">
            推荐文章
        </div>
        <ul class="hot_article_list">
            {if  $page->relateArticle}
            {foreach $page->relateArticle as $k=>$v}
                <li>
                    <div class="circle"></div>

                    <a href="{$_home}article/{Func_NumEncode::e($v['id'])}.html" class="consult-li" target="_blank">
                        {$v['title']}
                    </a>
                </li>
            {/foreach}
            {else}
                {foreach $page->isNewArticle as $k=>$v}
                    <li>
                        <div class="circle"></div>

                        <a href="{$_home}article/{Func_NumEncode::e($v['id'])}.html" class="consult-li" target="_blank">
                            {$v['title']}
                        </a>
                    </li>
                {/foreach}
            {/if}
        </ul>
    </div>
</div>
<div class="to-top none">
    <img src="img/classify.v2.0/tp.png" alt="" >
</div>
<script src="js/classify.v2.0/right_article.js"></script>
