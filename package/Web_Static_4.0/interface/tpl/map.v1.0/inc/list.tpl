{*********场地列表***********}
<ul class="mcont-list-cont">
    {foreach $list['rows'] as  $val}
        <li class="clearfix">
            {if $val['logo']}
            <div class="mcont-img">
                <a href="{$_root}site/{Func_Url::str_urlencode($val['space_name'],1)}" target="_blank">
                    <img src="{Page_Site_Global::displayMedia($val['logo'],275,195)}">
                </a>
            </div>
            {/if}
            <div class="mcont-details">
                <h2><a href="{$_root}site/{Func_Url::str_urlencode($val['space_name'],1)}" target="_blank">{$val['space_name']}</a></h2>
                <p>{implode("\\",$val['activity_type'])}</p>
                <div class="m-info">
                    <span>浏览量：{$val['click']} </span>
                    <span class="zshu">指数：{round($val['order_index']/10)}</span>
                </div>
            </div><!--mcont-details-end-->
            <div class="mcont-inquiry clearfix">
                <span class="icon-c icon-inq-gray"></span>
                <div class="mcont-inquiry-details j_search_date" data-city="{$val['city']}" data-id="{$val['id']}" data-name="{$val['space_name']}">
                    <span class="icon-c icon-inq-white"></span>
                    <p>查询档期和价格</p>
                </div>
            </div>
        </li>
    {/foreach}
</ul>
{if $list['rows']}
    <div class="pagers" id="pagers">
        {if $list['page']['dpll']}
            {*<a href="javascript:;" data-value="1" title="First">第一页</a>*}
            <a href="javascript:;" data-value="{$list['page']['dp']-1}"
               title="Prev">上一页</a>
        {else}
            {*<a href="javascript:;" data-value="1" class="prev first gray"><span>&laquo;&nbsp;</span>第一页</a>*}
            {*<a href="javascript:;" data-value="" class="prev gray">&lt;&nbsp;上一页</a>*}
        {/if}
        {*{for $i=$list['page']['dpl'] to $list['page']['dpr']}*}
            {*<a href="javascript:;" data-value="{$i}"{if $i==$list['page']['dp']} class="active"{/if}>{$i}</a>*}
        {*{/for}*}

        {if $list['page']['dprr']}
            <a href="javascript:;" data-value="{$list['page']['dp']+1}"
               title="Next">下一页&nbsp;&gt;</a>
            {*<a href="javascript:;" data-value="{$list['page']['dtp']}"*}
               {*title="Last">最后页&nbsp;&raquo;</a>*}
        {else}
            {*<a href="javascript:;" data-value="" class="next gray">下一页&nbsp;&gt;</a>*}
            {*<a href="javascript:;" data-value="" class="next last gray">最后页<span>&nbsp;&raquo;</span></a>*}
        {/if}

        <div class="clearfix"></div>
    </div>
{/if}
