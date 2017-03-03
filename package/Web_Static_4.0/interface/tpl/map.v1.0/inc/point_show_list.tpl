{if $list}
    <ul class="mcont-list-cont">
        {foreach $list as  $val}
            <li class="clearfix">
                <div class="mcont-img">
                    <a href="{$_home}site/{Func_Url::str_urlencode($val['space_name'])}">
                        <img src="{Page_Site_Global::displayMedia($val['logo'],275,195)}">
                    </a>
                </div>
                <div class="mcont-details">
                    <h2><a href="{$_home}site/{Func_Url::str_urlencode($val['space_name'])}">{$val['space_name']}</a></h2>
                    <p>{implode("\\",$val['activity_type'])}</p>
                    <div class="m-info">
                        <span>浏览量：{$val['click']} </span>
                        <span class="zshu">指数：{round($val['order_index']/10)}</span>
                    </div>
                </div><!--mcont-details-end-->
                <div class="mcont-inquiry clearfix">
                    <span class="icon-c icon-inq-gray"></span>
                    <div class="mcont-inquiry-details">
                        <span class="icon-c icon-inq-white"></span>
                        <p>查询档期和价格</p>
                    </div>
                </div>
            </li>
        {/foreach}
    </ul>
{else}
    {include "Web_Static::map.v1.0/inc/no_result_v1.tpl"}
{/if}