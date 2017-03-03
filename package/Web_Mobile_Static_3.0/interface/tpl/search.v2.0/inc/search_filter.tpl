<div class="all-filter-text">
    {*<div class="filter_selected clearfix">*}
        {*<div class="filter_selected_item t1">*}
        {*200-500㎡&nbsp;&nbsp;<a href="#" class="ion-close-circled filter_selected_deleted" data-pack="default" data-tags="delete, trash, kill, x"></a>*}
        {*</div>*}
        {*<div class="vertical"></div>*}
        {*<div class="filter_selected_item t2">*}
        {*秀场展馆&nbsp;&nbsp;<a href="#" class="ion-close-circled filter_selected_deleted" data-pack="default" data-tags="delete, trash, kill, x"></a>*}
        {*</div>*}
        {*<div class="clear"></div>*}
    {*</div>*}
    <div class="tab_outside">
        <div class="filter_area">
            <div class="search_filter_title">空间面积</div>
            <ul class="filter_content">
                <li>不限</li>
                {foreach $page->getSize as $k=>$v}
                    <li data-size="{$k}">{$v}</li>
                {/foreach}
                <div class="clear"></div>
            </ul>
        </div>
        <div class="filter-line"></div>
        <div class="filter_type">
            <div class="search_filter_title">场地类型</div>
            <ul class="filter_content">
                <li>不限</li>
                {foreach $page->getCategory as $k=>$v}
                    {if $k!=112}
                        <li data-category="{$k}">{$v}</li>
                    {/if}
                {/foreach}
                <div class="clear"></div>
            </ul>
        </div>
        <div class="search_filter_btn">
            <a href="#" class="search_filter_reset">重置</a>
            <a href="#" class="search_filter_confirm">确定</a>

            <div class="clear"></div>
        </div>
    </div>
</div>
