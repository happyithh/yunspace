<!DOCTYPE html>
<html>
<head lang="en">
    <meta charset="UTF-8">
    <meta name="viewport"
          content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no,minimal-ui">
    <link type="text/css" rel="stylesheet" href="css/wechat.v1.0/ticket.css">
    <link type="text/css" rel="stylesheet" href="css/v1.0/global.css">
    <title>{if $order_done['event_title']}{$order_done['event_title']}{/if}[云·Space 活动售票]</title>
</head>
<body>
<div class="ticket-pdg15-container">
    <div class="ticket-pay-title" style="border-bottom: none;">
            <h2 style="">  <img src="{$headimgurl}" style="width: 50px;height: 50px;border-radius: 25px;  "></h2>
            <p style="font-size: 12px; line-height: 2.0em;text-align: center;width: 80%;margin: 20px auto;color: #666;"> 为方便查询票务,记得收藏本页面哦。您也可以到公众号『我的门票』中查看！</p>
    </div>
    {if !$order_list['waiting'] && !$order_done['ticketlist']}
        <div class="ticket-pay-list clearfix" style="border-top: 1px solid #ccc ">
            <p style="height: 25px;line-height: 25px;width: 90%;text-align: center;margin: 5px auto;">
                您还未选购任何票种，赶快去买两张吧！
            </p>
            <p style="height: 25px;line-height: 25px;width: 90%;text-align: center;margin: 5px auto;">
            <a href="{$_home}ticket/?event_id={$_REQUEST['event_id']}">点击现在就去买</a>
            </p>
        </div>
    {/if}
</div>

{if $order_list['waiting']}
{foreach $order_list['waiting'] as $k=>$v}
    <div class="ticket-pdg15-container">
        <div class="ticket-pay-title">
            <h2>
                您已经选购:{$v['event_title']}<span>{if $v['order_status']==0}(待支付){/if}{if $v['order_status']==1}(已支付){/if}</span></h2>
        </div>
        <ul class="ticket-pay-list clearfix">
            {foreach $v['order_detail'] as $kk=>$vv}
                <li class="clearfix">
                    <p class="ticket-list-p"><span class="ticket-name">{$vv['ticket_name']}：</span><span class="ticket-price fr">¥{$vv['ticket_price']}</span></p>

                    <p class="fr">x{$vv['ticket_num']}</p>
                </li>
            {/foreach}
        </ul>
        <div class="ticket-pay-num clearfix">
            <p class="fl">价格总计</p>

            <p class="fr col-magenta">￥{$v['order_price']}</p>
        </div>
        <div class="pay-btn-wrap">
            <a href="{$_home}ticket/payorderlist?order_no={$v['order_no']}"
               class="ticket-btn-pay btn-col-grey btn-tobepaid">立即支付</a>
        </div>
    </div>
{/foreach}
{/if}
<!---------------------已支付------------------------------>
{if $order_done['ticketlist']}
<div class="ticket-pdg15-container">

        <div class="ticket-pay-title">
            <h2>您已经选购:{$order_done['event_title']}<span>(已支付)</span></h2>
        </div>
                <ul class="ticket-pay-list clearfix">
                    {foreach $order_done['ticketlist'] as $k=>$v}
                        <li class="clearfix">
                            <p class="ticket-list-p"><span class="ticket-name">{$v['ticket_name']}：</span><span class="ticket-price fr">¥{$v['ticket_price']}</span></p>

                            <p class="fr">x{$v['ticket_num']}</p>
                        </li>
                    {/foreach}
                </ul>
        <div class="ticket-pay-num clearfix">
            <p class="fl">价格总计</p>

            <p class="fr col-magenta">￥{$order_done['total_price']}</p>
        </div>
        <div class="pay-btn-wrap btn-payments-wrap clearfix">
            <a href="{$_home}ticket/ticketlist?order_id={$order_done['ids']}&event_id={$order_done['event_id']}"
               class="ticket-btn-pay btn-col-grey">查看票号</a>
            <a href="{$_home}ticket/ticketcode?order_id={$order_done['ids']}&event_id={$order_done['event_id']}"
               class="ticket-btn-pay btn-col-grey btn-center">查看二维码</a>
            <button data-value="{$order_done['ids']}" data-event={$order_done['event_id']} class="ticket-btn-pay btn-col-grey sendmessage">发送短信</button>
        </div>
</div>
{/if}
<script src="js/v1.0/jquery-1.11.1.min.js"></script>
<script type="text/javascript">
    $(".sendmessage").on('click', function (e) {
        var order_num = $(this).attr("data-value");
        var order_event = $(this).attr("data-event");
        $.ajax({
            type: 'post',
            url: "/m/ticket/sendmessage",
            dataType: 'json',
            data: {
                order_id: order_num,
                order_event: order_event
            },
            success: function (data) {
                alert(data.msg);
            }
        })
    })

</script>
</body>
</html>