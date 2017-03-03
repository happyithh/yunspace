<div class="s_left_c mt0">
    <div class="table-responsive">
        <table class="table table-bordered">
            <tr>
                <th style="background-color: #f6f6f6">更新时间</th>
                <th style="background-color: #f6f6f6">更新内容</th>
                <th style="background-color: #f6f6f6">操作人</th>
            </tr>
            {foreach $orderinfo['order_detail']['order_tracking'] as $k=>$v}
                <tr>
                    <td>{date('Y-m-d H:i:s',$v['更新时间'])}</td>
                    <td>{$v['操作内容']}</td>
                    <td>{$v['操作人']}</td>
                </tr>
            {/foreach}
        </table>
    </div>
    {if $orderinfo['is_vendor']}
        <div class="form-group">
            <form action="{$_root}product_set_order_operate" method="post">
                <input type="hidden" name="order_no" value="{$orderinfo['order_no']}" >
                <input type="hidden" name="action" value="order_tracking" >
                <label for="exampleInputEmail1">添加操作内容</label>
                <input type="text" name="operate_content" class="form-control" id="exampleInputEmail1" placeholder="" style="border-radius: 0px; box-shadow: none;">
                <span class="help-block"></span>
                <button type="submit" class="btn btn_confirm">提交</button>
                {if $orderinfo['order_detail']['ticket'] && $orderinfo['order_detail']['ticket']!=1}
                    <a id="ticket" href="javascript:;" class="btn btn-success">发票已寄出</a>
                {/if}
            </form>
        </div>
    {/if}
</div>
<script>
$('#ticket').click(function(){
    $.post('{$_root}product_set_order_operate',{ action:'ticket',order_no: "{$orderinfo['order_no']}" },function(data){
        if(data=='success'){
            $('#ticket').attr('style','display:none;');
        }
    })
})
</script>