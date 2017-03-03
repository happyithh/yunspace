<!DOCTYPE html>
<html>
<head>
    {include file="inc/html_head.tpl"}
</head>
<body>
{include file="inc/header_nav1.tpl"}
<div class="content">
    <div class="wbs" style="padding-bottom: 30px;">
        <div class="booking_step  wrap">
            <ul class="clearfix">
                <li class="active">
                    <span>1</span>

                    <p>预定下单</p>
                </li>
                <li>
                    <span>2</span>

                    <p>订单审核</p>
                </li>
                <li>
                    <span>3</span>

                    <p>交易签约</p>
                </li>
                <li>
                    <span>4</span>

                    <p>订单支付</p>
                </li>
                <li>
                    <span>5</span>

                    <p>订单结算</p>
                </li>
            </ul>
        </div>
    </div>
    <div class="wrap clearfix mt45">
        <form action="booking_submit" method="post" >
            <input type="hidden" name="id" value="{$_REQUEST['id']}">
            <input type="hidden" name="booking" value="1">
            <input type="hidden" name="data[price]" value="{$info['price']*100}">
            <style>
                .checkbox-inline + .checkbox-inline, .checkbox-inline {
                    margin-left: 0;
                    margin-right: 10px;
                }
            </style>
            <div class="s_left fl booking">
                {if $has_schedule}
                    {include file="inc/booking_schedule.tpl"}
                {/if}
                <div class="s_left_c mt0 conw_s form-horizontal">
                    <div class="form-group">
                        <label for="inputEmail3" class="col-sm-2 control-label">活动类型</label>
                        <div class="col-sm-9">
                            {foreach $_vendor_attr['attr']['活动类型'] as $v}
                                <label class="checkbox-inline"><input type="checkbox" name="data[event_type][]"
                                                                      value="{$v}">{$v}
                                </label>
                            {/foreach}
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="inputEmail3" class="col-sm-2 control-label">备注</label>

                        <div class="col-sm-10">
                            <textarea class="form-control" rows="10" name="data[memo]"></textarea>
                        </div>
                    </div>
                </div>
            </div>
            <div class="s_right fr">
                <div class="border1 xgb bpb">
                    <p><font>服务内容
                            : </font>{$info['product_name']}
                    </p>
                    <p><font>供应商
                            : </font>{$info['vendor']['vendor_name']}
                    </p>
                </div>
                <div class="border1 xgb bta bpb">
                    <div class="s_price text_c">
                        <span class="y_pri">预定价格</span>
                        <span class="s_yuan">{if $info['price']>100}￥{$info['price']}{$info['attr']['价格单位']}{else}面议{/if}</span>
                    <span class="now_d">
                        {*<button type="submit">*}
                            {*提交预定订单*}
                        {*</button>*}
                        <a href="#confirm" data-toggle="modal">
                            提交预定订单
                        </a>
                    </span>
                    </div>
                </div>
            </div>
            {include file="inc/html_confirm.tpl"}
        </form>
    </div>
</div>
<div style="margin-top:50px;" class="mt50"></div>
{include file="inc/html_footer.tpl"}
</body>
</html>