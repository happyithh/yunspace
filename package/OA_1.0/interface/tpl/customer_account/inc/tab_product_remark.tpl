<div class="portlet tabbable">
<div class="portlet-title">
    <div class="caption">
        <i class="fa fa-database"></i>添加服务备注
    </div>
</div>

<div class="portlet-body" style="padding-right: 30px;">
<div class="container-fluid">
<form class="form-horizontal" action="?" method="post">
<input type="hidden" name="product_id" value="{$_REQUEST['product_id']}">
<input type="hidden" name="action" value="{$_REQUEST['action']}">
<input type="hidden" name="is_submit_remark" value="1">
<input type="hidden" name="tab" value="{$_REQUEST['tab']}">
<input type="hidden" name="id" value="{$_REQUEST['id']}">
<input type="hidden" name="remark_id" value="{$remarkInfo['id']}">
<div class="row">
    <h5><strong class="col-md-3">服务名称</strong></h5><br/>
    <div class="col-md-10">
        <div class="form-group">
            <label class="col-md-2">服务名称</label>

            <div class="col-md-8">
                <input type="text" disabled class="form-control" name="" value="{$remarkInfo['product_name']}">
            </div>
        </div>
    </div>
</div>
<div class="row">
    <h5><strong class="col-md-3">合作信息</strong></h5><br/>
    <div class="col-md-10">
        <div class="form-group">
            <label class="col-md-2" style="padding-top: 5px;">合作底价</label>
            <div class="col-md-8">
                <div class="input-group">
                    <input type="text" class="form-control" name="data[cooperate_price]" value="{$remarkInfo['cooperate_price']}">
                    <span class="input-group-addon">元/单位</span>
                </div>
            </div>
        </div>
    </div>
    <div class="col-md-10">
        <div class="form-group">
            <label class="col-md-2" style="padding-top: 5px;">佣金比例</label>
            <div class="col-md-8">
                <div class="input-group">
                    <input type="text" class="form-control" name="data[charges_proportion]" value="{$remarkInfo['charges_proportion']}">
                    <span class="input-group-addon">%</span>
                </div>
            </div>
        </div>
    </div>
    <div class="col-md-10">
        <div class="form-group">
            <label class="col-md-2" style="padding-top: 5px;">佣金规则</label>
            <div class="col-md-8">
                <div class="input-group col-md-12">
                    <textarea class="form-control" name="data[charges_rules]" rows="3" placeholder="请输入佣金规则">{$remarkInfo['charges_rules']}</textarea>
                </div>
            </div>
        </div>
    </div>
</div>
<div class="row">
    <h5><strong class="col-md-3">成交信息</strong></h5><br/>

    <div class="col-md-10">
        <div class="form-group">
            <label class="col-md-2">成交量</label>

            <div class="col-md-8">
                <input type="text" class="form-control" name="" value="{$complete_order}">
            </div>
        </div>
    </div>
    <div class="col-md-10">
        <div class="form-group">
            <label class="col-md-2">取消量</label>

            <div class="col-md-8">
                <input type="text" class="form-control" name="" value="{$total_order-$complete_order}">
            </div>
        </div>
    </div>
    <div class="col-md-10">
        <div class="form-group">
            <label class="col-md-2">成交率</label>

            <div class="col-md-8">
                <input type="text" class="form-control" name="" value="{sprintf("%.2f", ($complete_order/$total_order)*100)}%">
            </div>
        </div>
    </div>
</div>
<div class="row">
    <h5><strong  class="col-md-3">交易评价</strong></h5>
    <div class="table-scrollable" style="padding: 0px 15px; border: 0px;">
        <table class="table table-striped table-bordered table-hover" style="border: 1px solid #ddd;">
            <thead>
            <tr>
                <th scope="col" width="150">
                    客户名称
                </th>
                <th scope="col">
                    评价内容
                </th>
            </tr>
            </thead>
            <tbody>
            {foreach $orderInfo['rows'] as $rk=>$rv}
                <tr>
                    <td>
                        {$rv['username']}
                    </td>
                    <td>
                        {if $rv['order_complete']}
                            {foreach $rv['order_complete'] as $ck=>$cv}
                                {$ck}:{$cv}<br/>
                            {/foreach}
                        {/if}
                    </td>
                </tr>
            {/foreach}
            </tbody>
        </table>
    </div>

</div>
<div class="row">
    <h5><strong  class="col-md-3">商户评级</strong></h5><br/>

    <div class="col-md-10">
        <div class="form-group">
            <label class="col-md-2">综合评分</label>

            <div class="col-md-8">
                <p class="form-control-static" style="padding: 0px; margin: 0px;">
                    5分
                </p>
            </div>
        </div>
    </div>
    <div class="col-md-10">
        <div class="form-group">
            <label class="col-md-2">客户评分</label>

            <div class="col-md-8">
                <p class="form-control-static" style="padding: 0px; margin: 0px;">
                    分
                </p>
            </div>
        </div>
    </div>
    <div class="col-md-10">
        <div class="form-group">
            <label class="col-md-2">执行评分</label>

            <div class="col-md-8">
                <div class="radio-list">
                    <label class="radio-inline" style="padding-top: 0px;">
                        <span><input type="radio" name="data[admin_score]"  value="1" {if $remarkInfo['admin_score']==1}checked{/if} ></span>
                        1分</label>
                    <label class="radio-inline" style="padding-top: 0px;">
                        <span class="checked"><input type="radio" name="data[admin_score]"  value="2" {if $remarkInfo['admin_score']==2}checked{/if}></span>
                        2分</label>
                    <label class="radio-inline" style="padding-top: 0px;">
                        <span><input type="radio" name="data[admin_score]"  value="3" {if $remarkInfo['admin_score']==3}checked{/if}></span>
                        3分</label>
                    <label class="radio-inline" style="padding-top: 0px;">
                        <span><input type="radio" name="data[admin_score]" value="4" {if $remarkInfo['admin_score']==4}checked{/if}></span>
                        4分</label>
                    <label class="radio-inline" style="padding-top: 0px;">
                        <span><input type="radio" name="data[admin_score]" value="5" {if $remarkInfo['admin_score']==5}checked{/if}></span>
                        5分</label>
                </div>
            </div>
        </div>
    </div>
</div>
<div class="row">
    <h5><strong  class="col-md-3">内部备注(一条备注信息一行)</strong></h5>
    <div class="col-md-10">
        <textarea class="form-control" rows="10" placeholder="请输入备注内容" name="data[admin_demo]">{$remarkInfo['admin_demo']}</textarea>
    </div>
</div>
<div class="form-actions text-center">
    <button type="reset" class="btn btn-default">
        重置
    </button>
    <button type="submit" class="btn btn-success">
        提交
    </button>
</div>
</form>
</div>
</div>
</div>