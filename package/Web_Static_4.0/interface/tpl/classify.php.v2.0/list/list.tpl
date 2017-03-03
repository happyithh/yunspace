{if $page->getArticleList['rows']}
    {foreach $page->getArticleList['rows'] as $k=>$v}
        {if $v['img_set2']}
            <div class="classify_list">
                {*左侧list列表没有文字*}
                <div class="classify_list_img noword">
                    <a href="{$_home}article/{Func_NumEncode::e($v['id'])}.html">
                        <img src="{Page_Site_Global::displayMedia($v['img_set0'],"200","135")}">
                    </a>
                </div>
                <div class="classify_list_img noword">
                    <a href="{$_home}article/{Func_NumEncode::e($v['id'])}.html">
                        <img src="{Page_Site_Global::displayMedia($v['img_set1'],"200","135")}">
                    </a>
                </div>
                <div class="classify_list_img noword">
                    <a href="{$_home}article/{Func_NumEncode::e($v['id'])}.html">
                        <img src="{Page_Site_Global::displayMedia($v['img_set2'],"200","135")}">
                    </a>
                </div>
                <div class="clear"></div>
            </div>

        {elseif !$v['logo']}
            <div class="classify_list">
                {*左侧list列表没有图片*}
                <div class="classify_list_content noimage">
                    <div class="classify_list_title">
                        <a href="{$_home}article/{Func_NumEncode::e($v['id'])}.html" target="_blank"> {$v['title']}</a>
                    </div>
                    <div class="classify_list_word">
                        {mb_substr(strip_tags($v['des']),0,170,'utf-8')}

                    </div>
                    <div class="classify_list_icon clearfix">
                        <div class="icon_good"><a href="javascript:;" class="zan" data-id="{$v['id']}"><span>{$v['counter_praise']}</span></a></div>
                        <div class="icon_eye"><a href="javascript:;"><span>{$v['counter_view']}</span></a></div>
                        <div class="clear"></div>
                    </div>
                    <div class="clear"></div>
                </div>
                <div class="clear"></div>
            </div>
         {else}

            <div class="classify_list">
                <div class="classify_list_img">
                    <a href="{$_home}article/{Func_NumEncode::e($v['id'])}.html" target="_blank">
                        <img src="{Page_Site_Global::displayMedia($v['logo'],"200","135")}" title="{$v['title']}">
                    </a>
                </div>
                <div class="classify_list_content">
                    <div class="classify_list_title">
                        <a target="_blank"
                           href="{$_home}article/{Func_NumEncode::e($v['id'])}.html"> {$v['title']}</a>

                    </div>
                    <div class="classify_list_word">
                        {mb_substr(strip_tags($v['des']),0,108,'utf-8')}
                    </div>
                    <div class="classify_list_icon clearfix">
                        <div class="icon_good"><a href="javascript:;" class="zan" data-id="{$v['id']}"><span>
                                    {$v['counter_praise']}</span></a></div>
                        <div class="icon_eye"><a href="javascript:;"><span>{$v['counter_view']}</span></a></div>
                        <div class="clear"></div>
                    </div>
                    <div class="clear"></div>
                </div>
                <div class="clear"></div>
            </div>
        {/if}
    {/foreach}
{else}
    <div class="classify_list" style="text-align: center">
        抱歉没有找到
    </div>
    <script>
        $('.classify_load_more').hide();
    </script>
{/if}

