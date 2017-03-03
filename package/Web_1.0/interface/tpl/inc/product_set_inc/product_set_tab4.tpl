<div class="s_left_c mt0">
    <div class="row comment">
        {if $orderinfo['order_status']>=0 && $orderinfo['is_vendor']}
            {if $orderinfo['create_time5']}
                <div class="col-md-2"><span>评价时间：</span></div>
                <div class="col-md-10">{date('Y-m-d H:i:s',$orderinfo['create_time5'])}</div>
                <div class="col-md-2"><span>质量效果：</span></div>
                <div class="col-md-10">{$orderinfo['order_complete']['质量效果']}分</div>
                <div class="col-md-2"><span>服务态度：</span></div>
                <div class="col-md-10">{$orderinfo['order_complete']['服务态度']}分</div>
                <div class="col-md-2"><span>响应速度：</span></div>
                <div class="col-md-10">{$orderinfo['order_complete']['响应速度']}分</div>
                <div class="col-md-2"><span>评价备注：</span></div>
                <div class="col-md-10">{$orderinfo['order_complete']['评价备注']}分</div>
            {else}
                交易进行中.....
            {/if}
        {/if}
    </div>
    {if $orderinfo['order_status']>=0 && (time() > $orderinfo['end_time']) && $orderinfo['is_buyer']}
        <form action="{$_root}product_set_order_operate">
            <input type="hidden" name="order_no" value="{$orderinfo['order_no']}" >
            <input type="hidden" name="action" value="evaluate" >
            <div class="row comment commenting">

                <div class="col-md-2"><span>质量效果：</span></div>
                <div class="col-md-10">
                    <label class="radio-inline">
                        <input type="radio" {if $orderinfo['order_complete']['质量效果'] ==1} checked {/if} name="data[质量效果]" value="1"> 1分
                    </label>
                    <label class="radio-inline">
                        <input type="radio" {if $orderinfo['order_complete']['质量效果'] ==2} checked {/if} name="data[质量效果]" value="2"> 2分
                    </label>
                    <label class="radio-inline">
                        <input type="radio" {if $orderinfo['order_complete']['质量效果'] ==3} checked {/if} name="data[质量效果]" value="3"> 3分
                    </label>
                    <label class="radio-inline">
                        <input type="radio" {if $orderinfo['order_complete']['质量效果'] ==4} checked {/if} name="data[质量效果]" value="4"> 4分
                    </label>
                    <label class="radio-inline">
                        <input type="radio" {if $orderinfo['order_complete']['质量效果'] ==5} checked {/if} name="data[质量效果]" value="5"> 5分
                    </label>
                </div>
                <div class="col-md-2"><span>服务态度：</span></div>
                <div class="col-md-10">

                    <label class="radio-inline">
                        <input type="radio" {if $orderinfo['order_complete']['服务态度'] ==1} checked {/if} name="data[服务态度]" value="1"> 1分
                    </label>
                    <label class="radio-inline">
                        <input type="radio" {if $orderinfo['order_complete']['服务态度'] ==2} checked {/if} name="data[服务态度]"  value="2"> 2分
                    </label>
                    <label class="radio-inline">
                        <input type="radio" {if $orderinfo['order_complete']['服务态度'] ==3} checked {/if} name="data[服务态度]" value="3"> 3分
                    </label>
                    <label class="radio-inline">
                        <input type="radio" {if $orderinfo['order_complete']['服务态度'] ==4} checked {/if} name="data[服务态度]" value="4"> 4分
                    </label>
                    <label class="radio-inline">
                        <input type="radio" {if $orderinfo['order_complete']['服务态度'] ==5} checked {/if} name="data[服务态度]" value="5"> 5分
                    </label>

                </div>
                <div class="col-md-2"><span>响应速度：</span></div>
                <div class="col-md-10">
                    <label class="radio-inline">
                        <input type="radio" {if $orderinfo['order_complete']['响应速度'] ==1} checked {/if} name="data[响应速度]" value="1"> 1分
                    </label>
                    <label class="radio-inline">
                        <input type="radio" {if $orderinfo['order_complete']['响应速度'] ==2} checked {/if} name="data[响应速度]" value="2"> 2分
                    </label>
                    <label class="radio-inline">
                        <input type="radio" {if $orderinfo['order_complete']['响应速度'] ==3} checked {/if} name="data[响应速度]" value="3"> 3分
                    </label>
                    <label class="radio-inline">
                        <input type="radio" {if $orderinfo['order_complete']['响应速度'] ==4} checked {/if} name="data[响应速度]" value="4"> 4分
                    </label>
                    <label class="radio-inline">
                        <input type="radio" {if $orderinfo['order_complete']['响应速度'] ==5} checked {/if}  name="data[响应速度]" value="5"> 5分
                    </label></div>
                <div class="col-md-2"><span>评价备注：</span></div>
                <div class="col-md-10">
                    <textarea name="data[评价备注]" class="form-control" rows="3" style="box-shadow: none; border-radius: 0px; margin-bottom: 5px;">{$orderinfo['order_complete']['评价备注']}</textarea>
                </div>
                <div class="col-md-offset-2 col-md-10">
                    <button type="submit" class="btn btn_confirm">提交</button>
                </div>
            </div>
        </form>
    {/if}
</div>