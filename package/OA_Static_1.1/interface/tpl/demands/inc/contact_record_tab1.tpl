<div class="tab-content clearfix">
    <div class="">
        <form action="?action=add_contact_record" method="post">
            <div class="form-group col-md-12">
                <textarea class="form-control" rows="3" name="content"></textarea>
                <input type="hidden" name="contact_id" value="{$_REQUEST['contact_id']}"/>

                <div class="" style="text-align: right; margin-top: 15px">
                    <button type="submit" class="btn btn-primary">提交</button>
                </div>
            </div>
        </form>
        {foreach $_data['rows'] as $k=>$v}
            <div class="form-group col-md-12">
                <div class="well">
                    {$v['content']}
                </div>
                <div class="clearfix message_time"><span class="pull-left">发布时间：{$v['time']}</span><span
                            class="pull-right">{$v['admin_name']}</span></div>
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