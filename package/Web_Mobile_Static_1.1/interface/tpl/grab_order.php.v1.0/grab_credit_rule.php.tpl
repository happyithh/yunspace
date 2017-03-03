<!DOCTYPE html>
<html>
<head lang="en">
    {include "Web_Mobile_Static::v1.0/head_meta.tpl"}
    {static "v1.0/global.css"}
    {static "grab_order.v1.0/grab.css"}
</head>
<body class="body-fff">
<div class="wrapper">
    <div class="grap-credit-rule">
        <h3>积分规则</h3>

        <div class="credit-rule-details">
            <h5>增加积分</h5>
            <ol>
                <li>更新需求进度，进度对应分值为：
                    <p><span class="text">已电话客户</span><span class="red">+2</span>分</p>

                    <p><span class="text">初步意向客户</span><span class="red">+4</span>分</p>

                    <p><span class="text">上门拜访客户</span><span class="red">+6</span>分</p>

                    <p><span class="text">强意向客户</span><span class="red">+8</span>分</p>

                    <p><span class="text">商务洽谈客户</span><span class="red">+10</span>分</p>
                </li>
                <li>需求成交后，可获得相应的成交积分：
                    <p>成交积分=该单的抢单积分<span class="red">*7</span></p>

                    <p>（抢单因预算不同所需积分数额不同）</p>
                </li>
                <li>抢单后，有过更新进度再关闭订单，则加上抢单时扣减的积分</li>
                <li>其他可增加积分的事项届时会酌情调整。</li>
            </ol>
            <h5>扣减积分</h5>
            <ol style="border: none">
                <li>抢单：抢单时需根据预算额度扣减相应的积分。</li>
                <li>抢单后，未有任何更新进度，直接关闭订单的需扣减积分:
                    扣减积分=该单的抢单积分<span class="red">*2</span>
                    （抢单因预算不同所需积分数额不同）。
                </li>
                <li>其他应减少积分的事项届时会酌情调整。</li>
            </ol>
        </div>
    </div>
</div>
<!--wrapper-end-->
</body>
</html>