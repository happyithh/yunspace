<ul class="set_intro">
    {foreach $page->tags as $tk=>$tv}
        <li>
            <p class="title"> {$tk}</p>
            <div class="text-row" >
                {foreach $tv as $ttk=>$ttv}
                    {if $page->productInfo['attr_new'][$ttk]}
                        <div class="left-text">
                            <c>{$ttv['tags_name']}
                                ：
                            </c>{str_replace(',','、',$page->productInfo['attr_new'][$ttk])}
                        </div>
                    {/if}
                {/foreach}
            </div>
        </li>
    {/foreach}
</ul>