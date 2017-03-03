<table class="table table-striped table-bordered">
    <thead>
    <tr>
        <th width="30%">时间段</th>
        <th width="30%">未入驻IP数</th>
        <th width="30%">已入驻IP数</th>
    </tr>
    </thead>
    <tbody>
    {foreach $data as $k=>$v}
        <tr>
            <td>{$k}</td>
            <td>{if !empty($v[0])}{$v[0]}{/if}</td>
            <td>{if !empty($v[1])}{$v[1]}{/if}</td>
        </tr>
        {*<td>{array_sum( $v)}</td>*}
    {/foreach}
    </tbody>
</table>