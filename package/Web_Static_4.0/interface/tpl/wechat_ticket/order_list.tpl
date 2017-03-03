<!DOCTYPE html>
<html lang="en">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" href="//cdn.bootcss.com/bootstrap/3.3.5/css/bootstrap.min.css">
    <!-- 可选的Bootstrap主题文件（一般不用引入） -->
    <link rel="stylesheet" href="//cdn.bootcss.com/bootstrap/3.3.5/css/bootstrap-theme.min.css">
    <!--[if lt IE 9]>
    <script src="//cdn.bootcss.com/html5shiv/3.7.2/html5shiv.min.js"></script>
    <script src="//cdn.bootcss.com/respond.js/1.4.2/respond.min.js"></script>
    <![endif]-->
    <title>云Space后台管理登陆</title>

</head>
<body>
<div class="container">
    <div class="panel panel-default">
        <div class="panel-body">
            <div class="alert alert-info" role="alert">
                <strong>微信售票订单列表</strong>
            </div>
            <ol class="breadcrumb">
                <li><a href="{$_home}">云SPACE首页</a></li>
                <li><a href="{$_home}wechat_ticket">微信售票活动列表</a></li>
                <li class="active">微信售票订单列表</li>
            </ol>
            <div class="table-responsive">
                <table class="table table-bordered table-striped">
                    <thead>
                    <tr class="info">
                        <th>购票人姓名</th>
                        <th>联系电话</th>
                        <!--<th>活动名称</th>-->
                        <th>购票数量</th>
                        <th>购票时间</th>
                        <th>付款时间</th>
                        <th>订单金额</th>
                        <th>付款金额</th>
                        <th>操作</th>
                    </tr>
                    <tr>
                        <form action="?" method="get">
                            <input type="hidden" name="action" value="order">
                            <input type="hidden" name="event_id" value="{$request['event_id']}">
                            <td></td>
                            <td> <input type="text" name="phone" value="{$request['phone']}" class="form-control" placeholder="输入手机号"></td>
                            <td></td>
                            <td></td>
                            <td></td>
                            <td></td>
                            <td></td>
                            <td> <button class="btn btn-primary" type="submit">搜索</button></td>
                        </form>
                    </tr>
                    </thead>
                    <tbody>
                    {if $order_list['rows']}
                        {foreach $order_list['rows'] as $k=>$v}
                            <tr>
                                <td>{$v['fullname']}</td>
                                <td>{$v['buyer_account_phone']}</td>
                                <!--<td>{$v['event_title']}</td>-->
                                <td>{$v['order_ticket_num']} 张</td>
                                <td>{date('Y-m-d',$v['create_time'])}</td>
                                <td>{if !empty($v['create_time2'])}{date('Y-m-d H:i:s',$v['create_time2'])}{else}-----{/if}</td>
                                <td>{$v['order_price']} {if $v['price_is_score']==1}积分{else}元{/if}</td>
                                <td>{$v['order_price_pay']} {if $v['price_is_score']==1}积分{else}元{/if}</td>
                                <td>
                                    <a href="?action=detail&order_no={$v['order_no']}" class="btn btn-success"><i class="fa fa-eye"></i>详情</a>
                                </td>
                            </tr>
                        {/foreach}
                    {else}
                        <tr>
                            <td colspan="8" style="text-align: center;font-size: 16px;">本活动下没有订单</td>
                        </tr>
                    {/if}
                    </tbody>
                </table>
                <nav>

                    <ul class="pagination">
                        {if $order_list['page']['dpll']}
                            {*<li class="prev">*}
                                {*<a href="{$order_list['page']['dup']}1" title="First"><i class="fa fa-angle-double-left"></i></a>*}
                            {*</li>*}
                            <li class="prev">
                                <a href="{$order_list['page']['dup']}{$order_list['page']['dp']-1}" title="Prev"><i class="fa fa-angle-left"></i></a>
                            </li>
                        {else}
                            {*<li class="prev disabled">*}
                                {*<a href="#" title="First"><i class="fa fa-angle-double-left"></i></a>*}
                            {*</li>*}
                            {*<li class="prev disabled">*}
                                {*<a href="#" title="Prev"><i class="fa fa-angle-left"></i></a>*}
                            {*</li>*}
                            <li class="disabled">
                                <a href="#" aria-label="Previous"><span aria-hidden="true">«</span></a>
                            </li>
                        {/if}
                        {for $i=$order_list['page']['dpl'] to $order_list['page']['dpr']}
                            <li{if $i==$order_list['page']['dp']} class="active"{/if}>
                                <a href="{$order_list['page']['dup']}{$i}">{$i}</a>
                            </li>
                        {/for}
                        <li class="disabled">
                            <a> {$order_list['page']['dtp']}
                                ( {$order_list['page']['dp']*$order_list['page']['dn']}
                                /{$order_list['page']['dt']} )</a>
                        </li>

                        {if $order_list['page']['dprr']}
                            <li class="next">
                                <a href="{$order_list['page']['dup']}{$order_list['page']['dp']+1}" title="Next"><i class="fa fa-angle-right"></i></a>
                            </li>
                            {*<li class="next">*}
                                {*<a href="{$order_list['page']['dup']}{$order_list['page']['dtp']}" title="Last"><i class="fa fa-angle-double-right"></i></a>*}
                            {*</li>*}
                        {else}
                            {*<li class="next disabled">*}
                                {*<a href="#" title="Next"><i class="fa fa-angle-right"></i></a>*}
                            {*</li>*}
                            <li>
                                <a href="#" aria-label="Next">
                                    <span aria-hidden="true">»</span>
                                </a>
                            </li>
                            {*<li class="next disabled">*}
                                {*<a href="#" title="Last"><i class="fa fa-angle-double-right"></i></a>*}
                            {*</li>*}
                        {/if}
                    </ul>
                </nav>
            </div>
        </div>
    </div>

</div>


<!-- jQuery文件。务必在bootstrap.min.js 之前引入 -->
<script src="//cdn.bootcss.com/jquery/1.11.3/jquery.min.js"></script>
<!-- 最新的 Bootstrap 核心 JavaScript 文件 -->
<script src="//cdn.bootcss.com/bootstrap/3.3.5/js/bootstrap.min.js"></script>
</body>
</html>