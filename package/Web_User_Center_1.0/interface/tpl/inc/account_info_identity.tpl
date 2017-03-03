<div class="portlet">
    <div class="portlet-body">
        <div class="table-responsive">
            <table class="table table-striped table-hover">
                <tbody>
                {foreach $__user['attr']['identity']['data'] as $k=>$v}
                    <tr>
                        <td>
                            {$k}
                        </td>
                        <td>
                            {$v}
                        </td>
                    </tr>
                {/foreach}
                <tr>
                    <td width="40%"></td>
                    <td></td>
                </tr>
                </tbody>
            </table>
        </div>
    </div>
</div>