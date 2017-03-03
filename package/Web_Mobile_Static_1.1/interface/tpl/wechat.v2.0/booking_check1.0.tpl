<!DOCTYPE html>
<html>
<head lang="en">
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no,minimal-ui">
    <link type="text/css" rel="stylesheet" href="css/v1.0/style_public.css">
    <link type="text/css" rel="stylesheet" href="css/wechat.v2.0/booking.css">
    <title>{$event_info['title']}[云·Space 活动售票]</title>
</head>
<body>
<ul class="booking-nav clearfix">
    <li ><a href="{$_home}event_ticket/event_list">正在售票</a></li>
    <li class="active"><a href="{$_home}event_ticket/order_list" style="border: none;">我的订单</a></li>
</ul>

<div class="ticketcheck-list">
    {if $order_list}
        {foreach $order_list as $k=>$v}
            {if $v['order_status']==0}
                <div class="list-a">
                    <div class="check-list-title">
                        <p class="black">订单编号：{$v['order_no']}</p>
                        <p>下单时间：{date("Y-m-d H:i:s",$v['create_time'])}</p>
                    </div>
                    <div class="check-list-cont clearfix">
                        <div class="boki-img">
                            <img src="{$v['event_logo']|default:'img/wechat.v2.0/tkt_img1.jpg'}">
                            <span class="ck-tobepaid">待支付</span>
                        </div>
                        <div class="boki-details">
                            <h2>{$v['title']}</h2>
                            <p>票名：{$v['order_detail'][0]['ticket_name']}</p>
                            <p>时间：{date("Y-m-d",$v['activity_time'])}</p>
                            <p>{$v['order_ticket_num']}张<span class="line">|</span>总价：{$v['order_price']}元</p>
                            <div class="boki-details-btn">
                                <a href="pay_order_list?order_no={$v['order_no']}" class="fl bg-magenta">立即付款</a>
                                <a href="cancel_order?order_no={$v['order_no']}"  onclick="return confirm('您确定要取消订单吗？？')" class="fr bg-white">取消</a>
                            </div>
                        </div>
                    </div><!--check-list-cont-end-->
                </div>
            {/if}
            {if $v['order_status']==2}
                <a href="order_info?order_no={$v['order_no']}" class="list-a">
                    <div class="check-list-title">
                        <p class="black">订单编号：{$v['order_no']}</p>
                        <p>下单时间：{date("Y-m-d H:i:s",$v['create_time'])}</p>
                    </div>
                    <div class="check-list-cont clearfix">
                        <div class="boki-img">
                            <img src="{$v['event_logo']|default:'img/wechat.v2.0/tkt_img1.jpg'}">
                            <span class="ck-hvnotused">未使用</span>
                        </div>
                        <div class="boki-details">
                            <h2>{$v['title']}</h2>
                            <p>票名：{$v['order_detail'][0]['ticket_name']}</p>
                            <p>时间：{date("Y-m-d",$v['activity_time'])}</p>
                            <p>{$v['order_ticket_num']}张<span class="line">|</span>总价：{$v['order_price']}元</p>
                            <div class="boki-details-btn">
                                <p>未使用</p>
                            </div>
                        </div>
                    </div><!--check-list-cont-end-->
                </a>
            {/if}
            {if $v['order_status']==3}
                <a href="order_info?order_no={$v['order_no']}" class="list-a">
                    <div class="check-list-title">
                        <p class="black">订单编号：{$v['order_no']}</p>
                        <p>下单时间：{date("Y-m-d H:i:s",$v['create_time'])}</p>
                    </div>
                    <div class="check-list-cont clearfix">
                        <div class="boki-img">
                            <img src="{$v['event_logo']|default:'img/wechat.v2.0/tkt_img1.jpg'}">
                            <span class="ck-hvused">已使用</span>
                        </div>
                        <div class="boki-details">
                            <h2>{$v['title']}</h2>
                            <p>票名：{$v['order_detail'][0]['ticket_name']}</p>
                            <p>时间：{date("Y-m-d",$v['activity_time'])}</p>
                            <p>{$v['order_ticket_num']}张<span class="line">|</span>总价：{$v['order_price']}元</p>
                            <div class="boki-details-btn">
                                <p>已使用</p>
                            </div>
                        </div>
                    </div><!--check-list-cont-end-->
                </a>
            {/if}
            {if $v['order_status']==-1}
                <a href="order_info?order_no={$v['order_no']}" class="list-a">
                    <div class="check-list-title">
                        <p class="black">订单编号：{$v['order_no']}</p>
                        <p>下单时间：{date("Y-m-d H:i:s",$v['create_time'])}</p>
                    </div>
                    <div class="check-list-cont clearfix">
                        <div class="boki-img">
                            <img src="{$v['event_logo']|default:'img/wechat.v2.0/tkt_img1.jpg'}">
                            <span class="ck-hvcancel">已取消</span>
                        </div>
                        <div class="boki-details">
                            <h2>{$v['title']}</h2>
                            <p>票名：{$v['order_detail'][0]['ticket_name']}</p>
                            <p>时间：{date("Y-m-d",$v['activity_time'])}</p>
                            <p>{$v['order_ticket_num']}张<span class="line">|</span>总价：{$v['order_price']}元</p>
                            <div class="boki-details-btn">
                                <p>已取消</p>
                            </div>
                        </div>
                    </div><!--check-list-cont-end-->
                </a>
            {/if}
        {/foreach}
    {/if}
    {*<div class="list-a">*}
        {*<div class="check-list-title">*}
            {*<p class="black">订单编号：12345678</p>*}
            {*<p>下单时间：2015-08-04  12:00:32</p>*}
        {*</div>*}
        {*<div class="check-list-cont clearfix"">*}
            {*<div class="boki-img">*}
                {*<img src="img/wechat.v2.0/tkt_img1.jpg">*}
                {*<span class="ck-tobepaid">待支付</span>*}
            {*</div>*}
            {*<div class="boki-details">*}
                {*<h2>小王子文化艺术展</h2>*}
                {*<p>时间：2014.12.05</p>*}
                {*<p>1张<span class="line">|</span>总价：198.00元</p>*}
                {*<div class="boki-details-btn">*}
                    {*<a href="tobepay" class="fl bg-magenta">立即付款</a>*}
                    {*<a href="" class="fr bg-white">取消</a>*}
                {*</div>*}
            {*</div>*}
    {*</div><!--check-list-cont-end-->*}
    {*<a href="hvcancel" class="list-a">*}
        {*<div class="check-list-title">*}
            {*<p class="black">订单编号：12345678</p>*}
            {*<p>下单时间：2015-08-04  12:00:32</p>*}
        {*</div>*}
        {*<div class="check-list-cont clearfix">*}
            {*<div class="boki-img">*}
                {*<img src="img/wechat.v2.0/tkt_img1.jpg">*}
                {*<span class="ck-hvcancel">已取消</span>*}
            {*</div>*}
            {*<div class="boki-details">*}
                {*<h2>小王子文化艺术展</h2>*}
                {*<p>时间：2014.12.05</p>*}
                {*<p>1张<span class="line">|</span>总价：198.00元</p>*}
                {*<div class="boki-details-btn">*}
                    {*<p>已取消</p>*}
                {*</div>*}
            {*</div>*}
        {*</div><!--check-list-cont-end-->*}
    {*</a>*}
    {*<a href="hvused" class="list-a">*}
        {*<div class="check-list-title">*}
            {*<p class="black">订单编号：12345678</p>*}
            {*<p>下单时间：2015-08-04  12:00:32</p>*}
        {*</div>*}
        {*<div class="check-list-cont clearfix"">*}
            {*<div class="boki-img">*}
                {*<img src="img/wechat.v2.0/tkt_img1.jpg">*}
                {*<span class="ck-hvused">已使用</span>*}
            {*</div>*}
            {*<div class="boki-details">*}
                {*<h2>小王子文化艺术展</h2>*}
                {*<p>时间：2014.12.05</p>*}
                {*<p>1张<span class="line">|</span>总价：198.00元</p>*}
                {*<div class="boki-details-btn">*}
                    {*<p>已使用</p>*}
                {*</div>*}
            {*</div>*}
        {*</div><!--check-list-cont-end-->*}
    {*</a>*}
    {*<a href="hvnotused" class="list-a">*}
        {*<div class="check-list-title">*}
            {*<p class="black">订单编号：12345678</p>*}
            {*<p>下单时间：2015-08-04  12:00:32</p>*}
        {*</div>*}
        {*<div class="check-list-cont clearfix"">*}
            {*<div class="boki-img">*}
                {*<img src="img/wechat.v2.0/tkt_img1.jpg">*}
                {*<span class="ck-hvnotused">未使用</span>*}
            {*</div>*}
            {*<div class="boki-details">*}
                {*<h2>小王子文化艺术展小王子文化艺术展小王子文化</h2>*}
                {*<p>时间：2014.12.05</p>*}
                {*<p>1张<span class="line">|</span>总价：198.00元</p>*}
                {*<div class="boki-details-btn">*}
                    {*<p>未使用</p>*}
                {*</div>*}
            {*</div>*}
        {*</div><!--check-list-cont-end-->*}
    {*</a>*}
    {*<div href="tobepaid" class="list-a">*}
        {*<div class="check-list-title">*}
            {*<p class="black">订单编号：12345678</p>*}
            {*<p>下单时间：2015-08-04  12:00:32</p>*}
        {*</div>*}
        {*<div class="check-list-cont clearfix"">*}
            {*<div class="boki-img">*}
                {*<img src="img/wechat.v2.0/tkt_img1.jpg">*}
                {*<span class="ck-tobepaid">待支付</span>*}
            {*</div>*}
            {*<div class="boki-details">*}
                {*<h2>小王子文化艺术展</h2>*}
                {*<p>时间：2014.12.05</p>*}
                {*<p>1张<span class="line">|</span>总价：198.00元</p>*}
                {*<div class="boki-details-btn">*}
                    {*<a href="" class="fl bg-magenta">立即付款</a>*}
                    {*<a href="" class="fr bg-white">取消</a>*}
                {*</div>*}
            {*</div>*}
        {*</div><!--check-list-cont-end-->*}
    {*</div>*}
</div>
</body>
</html>