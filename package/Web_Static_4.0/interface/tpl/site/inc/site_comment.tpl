{static "baike.v1.0/baike_comment.css"}
{static "baike.v1.0/noresult.css"}
<div class="baike-comment fl">
    {include file="Web_Static::site/inc/collection_title.tpl"}
    {*<header class="baike-comment-list">*}
        {*<ul class="baike-comment clearfix">*}
            {*<li><a href="" class="kinds kinds-active"><span>全部</span></a></li>*}
            {*<li><a href="" class="kinds"><span>点赞最多</span> <span>10</span></a></li>*}
            {*<li><a href="" class="kinds"><span>点赞最多</span> <span>10</span></a></li>*}
        {*</ul>*}
    {*</header>*}
    {if count($page->getBaikeCommentsList)>0}
    <div class="comment-body">
        <ul class="comment-body-list">
            {*{var_dump($comments)}*}
            {foreach $page->getBaikeCommentsList as $k=>$v}
            <li>
                <div class="comment-img fl">
                    {*<img src="" alt="">*}
                    {if !empty($v['user_info']['headimgurl'])}
                        <img src="{$v['user_info']['headimgurl']}" alt="">
                    {else}
                        <img src="img/content/no_head.png" alt="">
                    {/if}
                </div>
                <div class="comment-li-body fl">
                    <div class="comment-person-name clearfix">
                        <a href=""><span>{$v['user_info']['nickname']}</span></a>
                        {*<a href=""><span>{$v['content']}</span></a>*}
                    </div>
                    <div class="comment-person-content"><span>{$v['content']}</span></div>
                    <footer class="comment-footer">
                        <div class="comment-time fl"><span>{date('Y-m-d H:i:s',$v['create_time'])}</span></div>
                        <div class="comment-other fr">
                            <a href="javascript:;" data-code="{Core::$urls['host']}/m/site/{$page->info['space_name']}-讨论组-PC-Like"
                               data-code_id="4" data-text="扫描后进行评论,"
                               data-title="微信扫描二维码，进入讨论组" class="call-back">
                                <span><img src="img/v4.0/call_06.jpg" alt=""></span>
                                <code>
                                    {*{$v['count_reply']}*}
                                    0
                                </code>
                            </a>

                            <a href="javascript:;" >
                                <span><img src="img/v4.0/zan_03.jpg" alt=""></span>
                                <code>{$v['is_good']}</code>
                            </a>
                        </div>
                    </footer>
                </div>
            </li>
            {/foreach}
        </ul>
    </div>
    {else}
    {include file="Web_Static::site/inc/news_noresult_1.tpl"}
    {/if}
</div>
<div class="news_content_right fr person_side">
    {*{include file="Web_Static::site/inc/person_side.tpl"}*}
</div>
<div class="clear"></div>

{include file="Web_Static::inc/code.tpl"}
{static "v4.0/jquery-1.11.1.min.js"}
{static "core/yunspace.js"}
<script type="text/template" id="baike-comment-list">
    <li>
        <div class="comment-img fl">
            <img src="" alt="">
        </div>
        <div class="comment-li-body fl">
            <div class="comment-person-name clearfix">
                <a href=""><span>小胖子</span></a>
                <a href=""><span>小胖子小胖子小胖子小胖子小胖子小胖子</span></a>
            </div>
            <div class="comment-person-content"><span>情不自禁地流泪了</span></div>
            <footer class="comment-footer">
                <div class="comment-time fl"><span>12-03 21:45</span></div>
                <div class="comment-other fr">
                    <a href="javascript:;">
                        <span><img src="img/v4.0/call_06.jpg" alt=""></span>
                    </a>
                    <a href="javascript:;" >
                        <span><img src="img/v4.0/zan_03.jpg" alt=""></span>
                        <code>299</code>
                    </a>
                </div>
            </footer>

        </div>
    </li>
</script>
