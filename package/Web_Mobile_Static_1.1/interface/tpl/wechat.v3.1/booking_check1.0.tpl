<!DOCTYPE html>
<html>
<head lang="en">
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no,minimal-ui">
    <link type="text/css" rel="stylesheet" href="css/v1.0/style_public.css">
    <link type="text/css" rel="stylesheet" href="css/wechat.v3.0/booking_new.css">
    {static "wechat.v3.0/tabChange.css"}
    <title>{$event_info['title']}[云·Space 活动售票]</title>
</head>
<script>
    function rule()
    {
//        $(".show-ticket").css("display","block");
//        $(".cover").css("display","block");

        $(".show-ticket").fadeIn();
        $(".cover").fadeIn();
    }

    function canghide()
    {
        $(".show-ticket").fadeOut();
        $(".cover").fadeOut();
    }
</script>
<body>
<ul class="booking-nav clearfix">
    <li ><a href="{$_home}event_ticket/event_list">正在售票</a></li>
    <li class="active"><a href="{$_home}event_ticket/order_list" style="border: none;">我的门票</a></li>
</ul>


<!--顶部的用户信息，头像，积分，手机号等-->
<div class="ticket-info">
    <div class="ticket-img">
        <img src="{$account_data['user_info']['headimgurl']}" alt="头像">
    </div>
    <div class="ticket-info-body">
        <div class="ticket-p">用户名：{$account_data['username']}</div>
        <div class="ticket-p">手机号：{$account_data['phone']}</div>
        <div class="ticket-p">我的积分：<span>{$account_data['integral']}</span></div>
    </div>
    <div class="ticket-help" onclick="rule()">
        <a href="javascript:;"><img src="img/wechat.v2.0/wenhao.png" alt="" ></a>
    </div>
</div>
<!--顶部的用户信息，头像，积分，手机号等-->



<!--门票的筛选项：全部，未付款(0)，未使用，已使用-->
<div class="tab-change">
    <ul class="tab-nav cle relative">
        {*<li class="col-4 fl"><a href="{$_home}event_ticket/order_list" class="nav-click {if !isset($order_status)}nav-click-active{/if}"  yun="tabChange/js/tabChange.js::tabChange@click" yun-id="1">全部</a></li>*}
        {*<li class="col-4 fl"><a href="{$_home}event_ticket/order_list?order_status=0" class="nav-click {if isset($order_status) && $order_status==0}nav-click-active{/if}"  yun="tabChange/js/tabChange.js::tabChange@click" yun-id="2">未付款</a></li>*}
        {*<li class="col-4 fl"><a href="{$_home}event_ticket/order_list?order_status=1" class="nav-click {if $order_status==1}nav-click-active{/if}"  yun="tabChange/js/tabChange.js::tabChange@click" yun-id="3">未使用</a></li>*}
        {*<li class="col-4 fl"><a href="{$_home}event_ticket/order_list?order_status=-1" class="nav-click {if $order_status==-1}nav-click-active{/if}"  yun="tabChange/js/tabChange.js::tabChange@click" yun-id="4">已使用</a></li>*}
        {*<li class="line col-4 absolute"></li>*}

        <li class="col-4 fl {if !isset($order_status)}nav-click-active{/if}"><a href="{$_home}event_ticket/order_list" class="nav-click">全部</a></li>
        <li class="col-4 fl {if isset($order_status) && $order_status==1}nav-click-active{/if}"><a href="{$_home}event_ticket/order_list?order_status=1" class="nav-click">未付款</a></li>
        <li class="col-4 fl {if $order_status==2}nav-click-active{/if}"><a href="{$_home}event_ticket/order_list?order_status=2" class="nav-click">已付款</a></li>
        <li class="col-4 fl {if $order_status==3}nav-click-active{/if}"><a href="{$_home}event_ticket/order_list?order_status=3" class="nav-click">已取消</a></li>
        <li class="line col-4 absolute"></li>
    </ul>
    {*tab内容*}
    {*<div class="tab-cont">*}
        {*<div class="tab cle tab-active">*}
            {*全部*}
        {*</div>*}
        {*<div class="tab cle">*}
            {*未付款*}
        {*</div>*}
        {*<div class="tab cle">*}
            {*未使用*}
        {*</div>*}
        {*<div class="tab cle">*}
            {*已使用*}
        {*</div>*}
    {*</div>*}
</div>
<!--顶部的用户信息，头像，积分，手机号等-->
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
                            <p>{$v['order_ticket_num']}张<span class="line">|</span>总价：{$v['order_price']}{if $v['price_is_score']==1}积分{else}元{/if}</p>
                            <div class="boki-details-btn">
                                <a href="pay_order_list?order_no={$v['order_no']}{if $v['price_is_score']==1}&price_is_score=1{/if}" class="fl bg-magenta">立即付款</a>
                                <a href="cancel_order?order_no={$v['order_no']}"  onclick="return confirm('您确定要取消订单吗？？')" class="fr bg-white">取消</a>
                            </div>
                        </div>
                    </div><!--check-list-cont-end-->
                </div>
            {/if}
            {if $v['order_status']==11}
                <a href="order_info?order_no={$v['order_no']}{if $v['price_is_score']==1}&price_is_score=1{/if}" class="list-a">
                    <div class="check-list-title">
                        <p class="black">订单编号：{$v['order_no']}</p>
                        <p>下单时间：{date("Y-m-d H:i:s",$v['create_time'])}</p>
                    </div>
                    <div class="check-list-cont clearfix">
                        <div class="boki-img">
                            <img src="{$v['event_logo']|default:'img/wechat.v2.0/tkt_img1.jpg'}">
                            <span class="ck-hvnotused">电子票未使用</span>
                        </div>
                        <div class="boki-details">
                            <h2>{$v['title']}</h2>
                            <p>票名：{$v['order_detail'][0]['ticket_name']}</p>
                            <p>时间：{date("Y-m-d",$v['activity_time'])}</p>
                            <p>{$v['order_ticket_num']}张<span class="line">|</span>总价：{$v['order_price']}{if $v['price_is_score']==1}积分{else}元{/if}</p>
                            <div class="boki-details-btn">
                                <p>电子票未使用</p>
                            </div>
                        </div>
                    </div><!--check-list-cont-end-->
                </a>
            {/if}
            {if $v['order_status']==12}
                <a href="order_info?order_no={$v['order_no']}{if $v['price_is_score']==1}&price_is_score=1{/if}" class="list-a">
                    <div class="check-list-title">
                        <p class="black">订单编号：{$v['order_no']}</p>
                        <p>下单时间：{date("Y-m-d H:i:s",$v['create_time'])}</p>
                    </div>
                    <div class="check-list-cont clearfix">
                        <div class="boki-img">
                            <img src="{$v['event_logo']|default:'img/wechat.v2.0/tkt_img1.jpg'}">
                            <span class="ck-hvused">电子票已使用</span>
                        </div>
                        <div class="boki-details">
                            <h2>{$v['title']}</h2>
                            <p>票名：{$v['order_detail'][0]['ticket_name']}</p>
                            <p>时间：{date("Y-m-d",$v['activity_time'])}</p>
                            <p>{$v['order_ticket_num']}张<span class="line">|</span>总价：{$v['order_price']}{if $v['price_is_score']==1}积分{else}元{/if}</p>
                            <div class="boki-details-btn">
                                <p>电子票已使用</p>
                            </div>
                        </div>
                    </div><!--check-list-cont-end-->
                </a>
            {/if}
            {if $v['order_status']==13}
            <a href="order_info?order_no={$v['order_no']}{if $v['price_is_score']==1}&price_is_score=1{/if}" class="list-a">
                <div class="check-list-title">
                    <p class="black">订单编号：{$v['order_no']}</p>
                    <p>下单时间：{date("Y-m-d H:i:s",$v['create_time'])}</p>
                </div>
                <div class="check-list-cont clearfix">
                    <div class="boki-img">
                        <img src="{$v['event_logo']|default:'img/wechat.v2.0/tkt_img1.jpg'}">
                        <span class="ck-shiti">自取</span>
                    </div>
                    <div class="boki-details">
                        <h2>{$v['title']}</h2>
                        <p>票名：{$v['order_detail'][0]['ticket_name']}</p>
                        <p>时间：{date("Y-m-d",$v['activity_time'])}</p>
                        <p>{$v['order_ticket_num']}张<span class="line">|</span>总价：{$v['order_price']}{if $v['price_is_score']==1}积分{else}元{/if}</p>
                        <div class="boki-details-btn">
                            <p>自取</p>
                        </div>
                    </div>
                </div><!--check-list-cont-end-->
            </a>
        {/if}
            {if $v['order_status']==14}
                <a href="order_info?order_no={$v['order_no']}{if $v['price_is_score']==1}&price_is_score=1{/if}" class="list-a">
                    <div class="check-list-title">
                        <p class="black">订单编号：{$v['order_no']}</p>
                        <p>下单时间：{date("Y-m-d H:i:s",$v['create_time'])}</p>
                    </div>
                    <div class="check-list-cont clearfix">
                        <div class="boki-img">
                            <img src="{$v['event_logo']|default:'img/wechat.v2.0/tkt_img1.jpg'}">
                            <span class="ck-shiti">已寄出</span>
                        </div>
                        <div class="boki-details">
                            <h2>{$v['title']}</h2>
                            <p>票名：{$v['order_detail'][0]['ticket_name']}</p>
                            <p>时间：{date("Y-m-d",$v['activity_time'])}</p>
                            <p>{$v['order_ticket_num']}张<span class="line">|</span>总价：{$v['order_price']}{if $v['price_is_score']==1}积分{else}元{/if}</p>
                            <div class="boki-details-btn">
                                <p>已寄出</p>
                            </div>
                        </div>
                    </div><!--check-list-cont-end-->
                </a>
            {/if}
            {if $v['order_status']==15}
                <a href="order_info?order_no={$v['order_no']}{if $v['price_is_score']==1}&price_is_score=1{/if}" class="list-a">
                    <div class="check-list-title">
                        <p class="black">订单编号：{$v['order_no']}</p>
                        <p>下单时间：{date("Y-m-d H:i:s",$v['create_time'])}</p>
                    </div>
                    <div class="check-list-cont clearfix">
                        <div class="boki-img">
                            <img src="{$v['event_logo']|default:'img/wechat.v2.0/tkt_img1.jpg'}">
                            <span class="ck-shiti">未寄出</span>
                        </div>
                        <div class="boki-details">
                            <h2>{$v['title']}</h2>
                            <p>票名：{$v['order_detail'][0]['ticket_name']}</p>
                            <p>时间：{date("Y-m-d",$v['activity_time'])}</p>
                            <p>{$v['order_ticket_num']}张<span class="line">|</span>总价：{$v['order_price']}{if $v['price_is_score']==1}积分{else}元{/if}</p>
                            <div class="boki-details-btn">
                                <p>未寄出</p>
                            </div>
                        </div>
                    </div><!--check-list-cont-end-->
                </a>
            {/if}
            {if $v['order_status']==-1}
                <a href="order_info?order_no={$v['order_no']}{if $v['price_is_score']==1}&price_is_score=1{/if}" class="list-a">
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
                            <p>{$v['order_ticket_num']}张<span class="line">|</span>总价：{$v['order_price']}{if $v['price_is_score']==1}积分{else}元{/if}</p>
                            <div class="boki-details-btn">
                                <p>已取消</p>
                            </div>
                        </div>
                    </div><!--check-list-cont-end-->
                </a>
            {/if}
        {/foreach}
        {else}
        <div class="no-content">
            <div class="no-title">
        这里还没有信息
                </div>
        </div>
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

<div class="cover none" onclick="canghide()">
</div>
<div class="show-ticket none">
    <div class="show-content">
    <p class="h-title">积分规则</p>
    <hr /><br />
    <p class="quest">Q：什么是云·SPACE积分？</p>
    <p class="answer"><span class="quest">A：</span>云·SPACE积分是由云·SPACE发放的，对用户访问及参与云·SPACE活动行为的回馈。</p>
    <br />
    <p class="quest">Q：积分有什么用？</p>
    <p class="answer"><span class="quest">A：</span>积分可以消费，用来兑换活动门票，也可用来参与抽奖，以及后续云·SPACE提供的其他积分增值服务项目。</p>
    <br />
    <p class="quest">Q：积分如何获取？</p>
    <p class="answer"><span class="quest">A：</span>云·SPACE不定期会举办线上活动，用户参与活动可获得相应的积分；以及云·SPACE其他获得积分的形式。</p>
    <br />
    <p class="quest">Q：积分是否会过期或者清零？</p>
    <p class="answer"><span class="quest">A：</span>积分永远不会清零。</p>
    <br />
    </div>
    <button class="submit score_submit" onclick="canghide()">确定</button>
</div>
{static "v1.0/jquery-1.11.1.min.js"}
{static "core/yunspace.js"}
</body>
</html>