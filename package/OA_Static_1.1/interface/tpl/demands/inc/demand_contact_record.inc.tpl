<div class="portlet-title" xmlns="http://www.w3.org/1999/html">
    <div class="caption">
        <i class="fa fa-database"></i>联系记录
        <button class="btn btn-primary btn-xs look" id="relation" onclick="relation(this)">添加联系记录</button>
    </div>
</div>
<div class="tab-content clearfix">
    <div class="tab-pane active">
        <table class="table table-striped table-bordered table-hover" id="data_table"
               style="word-break: break-all">
            <thead>
            <tr>
                <th>编号ID</th>
                <th>记录ID</th>
                <th>记录内容</th>
                <th>记录时间</th>
            </tr>
            </thead>
            <tbody>
            {foreach $contactRecord['rows'] as $key=>$value}
                <tr>
                    <td>{$value['id']}</td>
                    <td>{$value['contact_id']}</td>
                    <td>{$value['content']}</td>
                    <td>{$value['time']}</td>
                </tr>
            {/foreach}
            </tbody>
        </table>

        <form action="?action=add_contact_record" method="post" style="display: none" class="form_relation">

            <input type="hidden" name="phone" value="{$_demand['phone']}"/>
            <input type="hidden" name="demand_id" value="{$_demand['id']}"/>
            <textarea class="form-control" rows="3" name="content"></textarea>

            <div class="" style="text-align: right; margin-top: 15px">
                <button type="submit" class="btn btn-primary">提交联系记录</button>
            </div>
        </form>
    </div>
    <div class="tab-pane active">
        <div class="pull-right">
            <ul class="pagination">
                {if $contactRecord['page']['dpll']}
                    <li class="prev">
                        <a href="{$contactRecord['page']['dup']}1" title="First"><i
                                    class="fa fa-angle-double-left"></i></a>
                    </li>
                    <li class="prev">
                        <a href="{$contactRecord['page']['dup']}{$contactRecord['page']['dp']-1}" title="Prev"><i
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
                {for $i=$contactRecord['page']['dpl'] to $contactRecord['page']['dpr']}
                    <li{if $i==$contactRecord['page']['dp']} class="active"{/if}>
                        <a href="{$contactRecord['page']['dup']}{$i}">{$i}</a>
                    </li>
                {/for}
                <li class="disabled">
                    <a> {$contactRecord['page']['dtp']}
                        ( {$contactRecord['page']['dp']*$contactRecord['page']['dn']}
                        /{$contactRecord['page']['dt']} )</a></li>

                {if $productInfo['page']['dprr']}
                    <li class="next">
                        <a href="{$contactRecord['page']['dup']}{$contactRecord['page']['dp']+1}" title="Next"><i
                                    class="fa fa-angle-right"></i></a>
                    </li>
                    <li class="next">
                        <a href="{$contactRecord['page']['dup']}{$contactRecord['page']['dtp']}" title="Last"><i
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

</div>
<script>
    //添加联系记录
    function relation() {
        $("#relation").css('display', 'none');
        $(".form_relation").fadeIn(400);
        $(".form_relation .form-control").focus();
    }
</script>