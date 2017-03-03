{foreach $article_list as $k=>$v}
    {if !empty($v['logo'])}
<div class="article-li padding-right">
    <a href="{$_home}article/{$v['id']}.html">
        <header class="article-li-header">
            {$v['title']}
        </header>
        <!-- 图片为主的文章 -->
        <!-- <div class="article-li-body-one">
            <div class="article-li-body-img">
              <img src="img/comment/art_03.png" alt="">
              <img src="img/comment/art_03.png" alt="">
              <img src="img/comment/art_03.png" alt="">
            </div>
        </div> -->
        <!-- 只有一张图片 -->
            <div class="article-li-body-two">
                <!-- 图片为主的文章 -->
                <div class="article-li-body-only">
                    <img src="{$v['logo']}" alt="">
                </div>
            </div>
    </a>
        <footer class="article-li-footer">
            <p>{$v['author']|default:"云SPACE"}</p>

            <p><span class="fa fa-thumbs-o-up"></span>&nbsp;<span>{$v['counter_praise']}</span></p>

            <p><span class="fa fa-eye"></span>&nbsp;<span>{$v['counter_view']}</span></p>
        </footer>

</div>
    {else}
    <div class="article-li">
        <a href="{$_home}article/{$v['id']}.html">
            <header class="article-li-header">
                {$v['title']}
            </header>
        </a>
        <footer class="article-li-footer">
            <p>{$v['author']|default:"云SPACE"}</p>

            <p><span class="fa fa-thumbs-o-up"></span>&nbsp;<span>{$v['counter_praise']}</span></p>

            <p><span class="fa fa-eye"></span>&nbsp;<span>{$v['counter_view']}</span></p>
        </footer>

    </div>
    {/if}
{/foreach}
