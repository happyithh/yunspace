<!DOCTYPE html>
<html>
<head>
    {include file="inc/html_head.tpl"}
    <link href="css/package_booking.css" rel="stylesheet">
</head>
<body>
{include file="inc/header_nav1.tpl"}
<div class="content">
    <div class="wrap clearfix">
    <h5 class="order">{if $productSet['attr_index']['城市']}{$productSet['attr_index']['城市']}{else}{$_COOKIE['city']} {/if}> 套餐预订 > 套餐名称：<span>{$productSet['set_name']}</span></h5>
    <div class="order_name">
        <div class="order_pic">
            {if $productSet['logo']}
                <img src="{Page_Site_Global::displayMedia($productSet['logo'],200,170)}"/>
            {else}
                <img src="img/s_logo.jpg"/>
            {/if}
        </div>
        <div class="order_left">
            <p class="order_title">{$productSet['set_name']}</p>
            <p class="order_tag">地址：{if $productSet['addr']}{$productSet['addr']}{else}{$_COOKIE['city']} {/if}</p>
            <p class="order_tag">类别：{$productSet['category_name']}</p>
            <p class="order_tag">人数：{$productSet['attr_index']['人数']}人</p>
            <p class="order_tag">天数：{$productSet['attr_index']['天数']}</p>
            <p class="order_tag">有效期：{$productSet['attr_index']['开始时间']} 至 {$productSet['attr_index']['结束时间']}</p>
            <p class="order_price">¥{$productSet['detail']['套餐价']}
                {if $productSet['detail']['计价单位']}
                    /{$productSet['detail']['计价单位']}
                {/if}
            </p>
        </div>
        <div class="order_right">
            <p class="order_information">预定信息（{$productSet['version']}）</p>
            {if $productSet['detail']['市场价']}
                <p class="order_type">
                    <span>市场价：¥ {$productSet['detail']['市场价']}
                        {if $productSet['detail']['计价单位']}
                            /{$productSet['detail']['计价单位']}
                        {/if}
                    </span>
                </p>
            {/if}
            <p class="order_type">
                <span>优惠价：¥ {$productSet['detail']['套餐价']}
                    {if $productSet['detail']['计价单位']}
                        /{$productSet['detail']['计价单位']}
                    {/if}
                </span>
                {if $productSet['detail']['市场价']}
                <span>{sprintf('%.1f',$productSet['detail']['套餐价']/$productSet['detail']['市场价']*10)}折</span>
                {/if}
            </p>
            {if $productSet['detail']['计价单位'] && $orderinfo['order_detail']['order_number']}
                <p class="order_type">预订数量：
                    {$orderinfo['order_detail']['order_number']}{$productSet['detail']['计价单位']}
                </p>
            {/if}
            <p class="order_type">所选档期：
                {date('Y-m-d',$orderinfo['start_time'])}
            </p>
            <p class="order_type">
                <span>订单总金额：</span>
                <span>¥{$orderinfo['order_price']}</span>
            </p>
        </div>
        <div class="clearfix"></div>

    </div>
        <div class="booking_step1  wrap">
            <ul class="clearfix">
                <li>
                    <span>1</span>

                    <p>预定下单</p>
                    <div class="supplement">{date('Y-m-d H:i', $orderinfo['create_time'])}</div>
                </li>

                <li {if $orderinfo['create_time']&&!$orderinfo['create_time2']} class="active_order" {/if}>
                    <span class="active_span">2</span>
                    <p class="active_p">订单审核</p>
                    <div class="supplement supplement_active">
                    {if $orderinfo['create_time2']}
                       {date('Y-m-d H:i', $orderinfo['create_time2'])}
                    {elseif $orderinfo['create_time']}
                        {if $orderinfo['order_status']==-1}
                            取消中...
                        {elseif $orderinfo['order_status']==-2}
                            已取消
                        {elseif $orderinfo['order_status']==-3}
                            未通过审核
                        {else}
                            档期确认中...
                        {/if}
                    {/if}
                    </div>
                </li>
                <li {if $orderinfo['create_time2']&&!$orderinfo['create_time4']} class="active_order"{/if}>
                    <span class="active_span">3</span>

                    <p  class="active_p">交易支付</p>
                    <div  class="supplement supplement_active">
                        {if $orderinfo['create_time4']}
                           {date('Y-m-d H:i', $orderinfo['create_time4'])}
                        {elseif $orderinfo['create_time2']}
                            <div>
                                {if $orderinfo['order_status']==-1}
                                    取消中...
                                {elseif $orderinfo['order_status']==-2}
                                    已取消
                                {elseif $orderinfo['order_status']==-3}
                                    未通过审核
                                {else}
                                    待支付...
                                {/if}
                            </div>
                        {/if}
                    </div>
                </li>
                <li {if $orderinfo['create_time4'] && (time() < $orderinfo['end_time'])} class="active_order"{/if}>
                    <span class="active_span">4</span>

                    <p class="active_p">活动进行</p>
                    <div  class="supplement supplement_active">
                        {if $orderinfo['create_time4']}
                            {if time() > $orderinfo['end_time']}
                            {date('Y-m-d H:i', $orderinfo['end_time'])}
                            {else}
                                <div>
                                    {if $orderinfo['order_status']==-1}
                                        取消中...
                                    {elseif $orderinfo['order_status']==-2}
                                        已取消
                                    {elseif $orderinfo['order_status']==-3}
                                        未通过审核
                                    {else}
                                        订单追踪...
                                    {/if}
                                </div>
                            {/if}
                        {/if}
                    </div>
                </li>
                <li {if (time() > $orderinfo['end_time']) && $orderinfo['create_time4']} class="active_order"{/if}>
                    <span class="active_span">5</span>

                    <p class="active_p">订单完成</p>
                    <div class="supplement supplement_active">
                        {if $orderinfo['create_time5']}
                            {date('Y-m-d H:i', $orderinfo['create_time5'])}
                        {/if}
                    </div>
                </li>
            </ul>
        </div>

        <script>
            $(document).ready(function() {
                $('.order_topic li').eq({$_REQUEST['tab']-1}).addClass('order_topic_active');
            });
        </script>
           <div class="order_handle">
               {if $orderinfo['order_status']>=0 && $orderinfo['is_buyer']}
                   <form action="{$_root}product_set_order_operate" method="post">
                       <input type="submit" value="取消订单"  class="btn">
                       <input type="text"  class="form-control cancel_input" id="exampleInputEmail1" name="cancel_reason" placeholder="请填写取消理由">
                       <input type="hidden" name="order_no" value="{$orderinfo['order_no']}" >
                       <input type="hidden" name="action" value="cancel" >
                   </form>
               {elseif $orderinfo['order_status']==-1 && $orderinfo['is_vendor']}
                   <form action="{$_root}product_set_order_operate" method="post">
                       <input type="submit" value="确认取消订单"  class="btn">
                       <input  class="form-control cancel_input" id="exampleInputEmail1" type="text"value="{$orderinfo['order_close_info']['reason']}" disabled>
                       <input type="hidden" name="order_no" value="{$orderinfo['order_no']}" >
                       <input type="hidden" name="action" value="confirm_cancel" >
                   </form>
               {/if}
               {*<button type="button" class="btn" style="background-color: #00c3c3;">合同签订</button>*}
               <div class="clearfix"></div>
           </div>
            <div class="s_left fl booking">
                {if $_REQUEST['tab'] != 5}
                    <div class="order_topic">
                         <ul>
                             <li>
                                <a href="?tab=1">预定详情</a>
                             </li>
                             {if $orderinfo['create_time2']}
                                 <li>
                                     <a href="?tab=2">支付详情</a>
                                 </li>
                             {else}
                                 <li>支付详情</li>
                             {/if}
                             {*{if $orderinfo['create_time3']}*}
                                 <li>
                                     <a href="?tab=3">订单跟踪</a>
                                 </li>
                             {*{else}*}
                                 {*<li>订单跟踪</li>*}
                             {*{/if}*}
                             {if time() > $orderinfo['end_time']}
                                 <li>
                                     <a href="?tab=4">服务评价</a>
                                 </li>
                             {else}
                                 <li>服务评价</li>
                             {/if}

                         </ul>
                    </div>
                {/if}
                {if $_REQUEST['tab']==1}
                    {include file='inc/product_set_inc/product_set_tab1.tpl'}
                {elseif $_REQUEST['tab']==2}
                    {if $is_transfer==1}
                        {include file='inc/product_set_inc/product_set_tab2_1.tpl'}
                    {else}
                        {include file='inc/product_set_inc/product_set_tab2.tpl'}
                    {/if}

                {elseif $_REQUEST['tab']==3}
                    {include file='inc/product_set_inc/product_set_tab3.tpl'}
                {elseif $_REQUEST['tab']==4}
                    {include file='inc/product_set_inc/product_set_tab4.tpl'}
                {elseif $_REQUEST['tab']==5}
                    {include file='inc/product_set_inc/product_set_tab5.tpl'}
                {/if}
            </div>
            <div class="s_right fr">
                <div class="order_t"><i class="fa fa-file-text-o"></i>&nbsp;&nbsp;订单信息</div>
                <div class="border1 bpb order_content">
                    <div class="row">
                        <div class="col-sm-4 order_content_topic">订单号：</div>
                        <div class="col-sm-8" style="font-size: 10px">{$orderinfo['order_no']}</div>
                        <div class="col-sm-4 order_content_topic">创建时间：</div>
                        <div class="col-sm-8">{date('Y-m-d H:i:s',$orderinfo['create_time'])}</div>
                        <div class="col-sm-4 order_content_topic">商品名称：</div>
                        <div class="col-sm-8"><a href="{$_root}set_info/{$orderinfo['product_set_id']}.html" class="order_content_main">{$orderinfo['order_title']}</a></div>
                        <div class="col-sm-4 order_content_topic">服务商：</div>
                        <div class="col-sm-8"><a href="{$_root}vendor_info/{$orderinfo['vendor_id']}.html" class="order_content_main">{$orderinfo['vendor_name']}</a></div>
                        <div class="col-sm-4 order_content_topic">采购方：</div>
                        <div class="col-sm-8">{$orderinfo['buyer_fullname']}</div>
                        <div class="col-sm-4 order_content_topic">套餐价：</div>
                        <div class="col-sm-8">
                            ¥{$productSet['detail']['套餐价']}
                            {if $productSet['detail']['计价单位']}
                                /{$productSet['detail']['计价单位']}
                            {/if}
                        </div>
                        {if $productSet['detail']['计价单位'] && $orderinfo['order_detail']['order_number']}
                            <div class="col-sm-4 order_content_topic">预订数量：</div>
                            <div class="col-sm-8">{$orderinfo['order_detail']['order_number']}{$productSet['detail']['计价单位']}</div>
                        {/if}
                        <div class="col-sm-4 order_content_topic">订单金额：</div>
                        <div class="col-sm-8">¥{$orderinfo['order_price']}</div>
                        <div class="col-sm-4 order_content_topic">合同详情：</div>
                        <div class="col-sm-8"><a href="#" class="order_content_main" data-toggle="modal" data-target=".bs-example-modal-lg">套餐签约合同</a></div>
                        <div class="modal fade bs-example-modal-lg" tabindex="-1" role="dialog" aria-labelledby="myLargeModalLabel" aria-hidden="true">
                            {include file="inc/product_set_agreement.tpl"}
                        </div>
                        {if $orderinfo['order_detail']['ticket']}
                            <div class="col-sm-4 order_content_topic">开票信息：</div>
                            <div class="col-sm-8">{$orderinfo['buyer_fullname']}{if $orderinfo['order_detail']['ticket']==1}(已寄出){else}(未寄出){/if}</div>
                        {elseif $orderinfo['is_buyer']}
                            <div class="col-sm-4 order_content_topic">需要发票：</div>
                            <div class="col-sm-8"><a href="{$_root}product_set_order_operate?action=need_ticket&order_no={$orderinfo['order_no']}" id="need_ticket" class="btn btn-info">需要发票</a></div>
                        {/if}

                        <div class="col-sm-4 order_content_topic">咨询投诉：</div>
                        <div class="col-sm-8">400-056-0599</div>
                    </div>
                    <a class="btn btn_print" target="_blank" href="{$_root}product_set_order_operate?action=order_print&order_no={$orderinfo['order_no']}">订单打印</a>
                    <div class="clearfix"></div>
                </div>
            </div>
    </div>
</div>
{include file="inc/html_footer.tpl"}
</body>
</html>