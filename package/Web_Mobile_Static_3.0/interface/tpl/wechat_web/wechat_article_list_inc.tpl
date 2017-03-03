{if $data}
    {foreach $data as $k=>$v}
        <li data-updateTime="{$v['update_time']}">
            <a href="{if $v['is_lnk']&&$v['link']}{$v['link']}{else}{$home}wechat_web_article_info?id={$v['id']}{/if}">
                <div class="img-wp"><img src="{$v['image']}"></div>
                <div class="text">
                    <h5>{$v['title']}</h5>
                    <p>{$v['introduction']}</p>
                </div>
            </a>
        </li>
    {/foreach}
{/if}

