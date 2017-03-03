<table class="track-table" cellpadding="0" cellspacing="0">
    <tr>
        <th width="30%">更新时间</th>
        <th width="30%">更新内容</th>
        <th width="40%">操作对象</th>
    </tr>
    {foreach $orderinfo['order_tracking'] as $k=>$v}
        <tr>
            <td>{date('Y-m-d H:i:s',$v['更新时间'])}</td>
            <td>{$v['操作内容']}</td>
            <td>{$v['操作人']}</td>
        </tr>
    {/foreach}
</table>