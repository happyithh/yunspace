{*********AJAX  带分页 场地列表***********}
{if $list['rows']}
    {include "Web_Static::map.v1.0/inc/list.tpl"}
{else}
    {include "Web_Static::map.v1.0/inc/no_result_v1.tpl"}
{/if}