<div class="tab-content clearfix">
    <div class="">
        {foreach $_data['rows'] as $k=>$v}
            <div class="form-group col-md-12">
                <div class="well">
                    {if $v['media']}
                        {$v['media']['url']}
                    {else}
                        {$v['message']}
                    {/if}
                </div>
                <div class="clearfix message_time"><span class="pull-left">发送时间：{$v['create_time']}</span><span
                            class="pull-right">{$v['from_accoount_id']}</span></div>
            </div>
        {/foreach}
    </div>
    <div class="pull-right">
        <ul class="pagination">
            {if $_data['page']['dpll']}
                <li class="prev">
                    <a href="{$_data['page']['dup']}1" title="First"><i class="fa fa-angle-double-left"></i></a>
                </li>
                <li class="prev">
                    <a href="{$_data['page']['dup']}{$_data['page']['dp']-1}" title="Prev"><i
                                class="fa fa-angle-left"></i></a>
                </li>
            {else}
                <li class="prev disabled">
                    <a href="#" title="First"><i class="fa fa-angle-double-left"></i></a>
                </li>
                <li class="prev disabled">
                    <a href="#" title="Prev"><i class="fa fa-angle-left"></i></a>
                </li>
            {/if}
            {for $i=$_data['page']['dpl'] to $_data['page']['dpr']}
                <li{if $i==$_data['page']['dp']} class="active"{/if}>
                    <a href="{$_data['page']['dup']}{$i}">{$i}</a>
                </li>
            {/for}
            <li class="disabled">
                <a> {$_data['page']['dtp']} ( {$_data['page']['dp']*$_data['page']['dn']}/{$_data['page']['dt']} )</a>
            </li>

            {if $_data['page']['dprr']}
                <li class="next">
                    <a href="{$_data['page']['dup']}{$_data['page']['dp']+1}" title="Next"><i
                                class="fa fa-angle-right"></i></a>
                </li>
                <li class="next">
                    <a href="{$_data['page']['dup']}{$_data['page']['dtp']}" title="Last"><i
                                class="fa fa-angle-double-right"></i></a>
                </li>
            {else}
                <li class="next disabled">
                    <a href="#" title="Next"><i class="fa fa-angle-right"></i></a>
                </li>
                <li class="next disabled">
                    <a href="#" title="Last"><i class="fa fa-angle-double-right"></i></a>
                </li>
            {/if}
        </ul>
    </div>
</div>