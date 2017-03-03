<table class="table table-striped table-bordered">
    <thead>
    <tr>
        <th width="20%">时间段</th>
        {foreach $step as $k=>$v}
            <th width="16%">{$v}</th>
        {/foreach}
    </tr>
    </thead>
    <tbody>
    {foreach $data as $k=>$v}
    <tr>
        <td>{$k}</td>
        {foreach $v as $kk=>$vv}
            <td>{$vv}</td>
        {/foreach}
    </tr>
        {*<td>{array_sum( $v)}</td>*}
    {/foreach}
    </tbody>
</table>
