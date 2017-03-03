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
    <div class="alert alert-info" role="alert">
        <strong>微信售票订单详情</strong>
    </div>
    <ol class="breadcrumb">
        <li><a href="{$_home}">云SPACE首页</a></li>
        <li><a href="{$_home}wechat_ticket">微信售票活动列表</a></li>
        <li><a href="{$_home}wechat_ticket?action=order&event_id={$data['order_info']['event_id']}"> 微信售票订单列表</a></li>
        <li class="active">订单详情</li>
    </ol>
    <div class="panel panel-default">
        <div class="panel-body">
            {*<form class="form-horizontal">*}
                <h3>基本信息</h3>
                <div class="form-group">
                    <label for="act_name" class="col-sm-2 control-label">活动名称</label>
                    <div class="col-sm-10">
                        <input type="input" class="form-control" value="{$data['order_info']['event_title']}" id="act_name" placeholder="">
                    </div>
                </div>
                <div class="form-group">
                    <label for="inputPassword3" class="col-sm-2 control-label">购票人姓名</label>
                    <div class="col-sm-10">
                        <input type="input" class="form-control"  placeholder="" value=" {$data['order_info']['buyer_account_name']}" disabled>
                    </div>
                </div>
                <div class="form-group">
                    <label for="inputPassword3" class="col-sm-2 control-label">联系方式</label>
                    <div class="col-sm-10">
                        <input type="input" class="form-control"  placeholder="" value=" {$data['order_info']['buyer_account_phone']}" disabled>
                    </div>
                </div>
                <div class="form-group">
                    <label for="inputPassword3" class="col-sm-2 control-label">订单号</label>
                    <div class="col-sm-10">
                        <input type="input" class="form-control"  placeholder="" value=" {$data['order_info']['order_no']}" disabled>
                    </div>
                </div>
                <div class="form-group">
                    <label for="inputPassword3" class="col-sm-2 control-label">购票票数</label>
                    <div class="col-sm-10">
                        <input type="input" class="form-control"  placeholder="" value="{$data['order_info']['order_ticket_num']} 张" disabled>
                    </div>
                </div>
                <div class="form-group">
                    <label for="inputPassword3" class="col-sm-2 control-label">支付金额</label>
                    <div class="col-sm-10">
                        <input type="input" class="form-control"  placeholder="" value="{$data['order_info']['order_price_pay']} {if $data['order_info']['price_is_score']==1}积分{else}元{/if}" disabled>
                    </div>
                </div>
            <div class="form-group">
                <label for="inputPassword3" class="col-sm-2 control-label">支付时间</label>
                <div class="col-sm-10">
                    <input type="input" class="form-control"  placeholder="" value="{if !empty($data['order_info']['create_time2'])}{date('Y-m-d',$data['order_info']['create_time2'])}{else}-------{/if}" disabled>
                </div>
            </div>
                <div class="form-group">
                    <label for="inputPassword3" class="col-sm-2 control-label">门票详情</label>
                    <div class="col-sm-10">
                        <table class="table table-striped table-bordered table-hover">
                            <thead>
                            <tr>
                                <th width="20%"> 票 号</th>
                                <th width="20%">门 票 类 型</th>
                                <th width="10%">状 态</th>
                                <th width="20%">门 票 时 间</th>
                                <th width="15%">票 价</th>
                                <th width="15%">操作</th>
                            </tr>
                            </thead>
                            <tbody class="sortable">
                            {if $data['ticket_info']}
                                {foreach $data['ticket_info'] as $k=>$v}
                                    <tr>
                                        <td>
                                            <input type="text" class="form-control"
                                                   value="{$v['ticket_num']}" readonly/>
                                        </td>
                                        <td>
                                            <input type="text" class="form-control"
                                                   value="{$v['ticket_detail']}" readonly/>
                                        </td>
                                        <td>
                                            <input type="text" class="form-control"
                                                   value="{if $v['status']==0}未使用{elseif $v['status']==1}已使用 {/if}"
                                                   readonly/>
                                        </td>
                                        <td>
                                            <input type="text" class="form-control"
                                                   value="{if empty($v['event_time'])}通 用{else}{$v['event_time']}{/if}"
                                                   readonly/>
                                        </td>
                                        <td>
                                            <input type="text" class="form-control" name="eventstock[{$k}]"
                                                   value="{$v['ticket_price']} {if $data['order_info']['price_is_score']==1}积分{else}元{/if}" readonly/>
                                        </td>
                                        <td>{if $v['status']==0}<button class="btn btn-success check_ticket" data-value="{$v['ticket_num']}">检票</button>{/if}</td>
                                    </tr>
                                {/foreach}
                            {else}
                                <tr>
                                    <td rowspan="5">没有门票</td>
                                </tr>
                            {/if}

                            </tbody></table>
                    </div>
                </div>
            {if  !empty($data['order_info']['addressInfo'])}
                <h3>收货地址信息</h3>
                <div class="form-group">
                    <label for="inputPassword3" class="col-sm-2 control-label">姓名</label>
                    <div class="col-sm-10">
                        <input type="input" class="form-control"  value="{$data['order_info']['addressInfo']['name']}" placeholder="">
                    </div>
                </div>
                <div class="form-group">
                    <label for="inputPassword3" class="col-sm-2 control-label">电话</label>
                    <div class="col-sm-10">
                        <input type="input" class="form-control" value="{$data['order_info']['addressInfo']['phone']}"  placeholder="">
                    </div>
                </div>
                <div class="form-group">
                    <label for="inputPassword3" class="col-sm-2 control-label">地址</label>
                    <div class="col-sm-10">
                        <input type="input" class="form-control" value="{$data['order_info']['addressInfo']['address_content']}"  placeholder="">
                    </div>
                </div>
            {if $data['order_info']['order_status']==1 }
                <h3>物流信息</h3>
                <div class="form-group">
                    <label for="inputPassword3" class="col-sm-2 control-label">物流来源</label>
                    <div class="col-sm-10">
                        <input type="input" class="form-control"  value="{$data['order_info']['logisticsInfo']['name']}" {if $data['order_info']['status']==-9 || $data['order_info']['order_status']==-2}display{/if}  placeholder="">
                    </div>
                </div>
                <div class="form-group">
                    <label for="inputPassword3" class="col-sm-2 control-label">物流单号</label>
                    <div class="col-sm-10">
                        <input type="input" value="{$data['order_info']['logisticsInfo']['order_no']}" {if $data['order_info']['status']==-9 || $data['order_status']==-2}display{/if}  class="form-control"  placeholder="">
                    </div>
                </div>
                <div class="form-group">
                    <label for="inputPassword3" class="col-sm-2 control-label">物流状态</label>
                    <div class="col-md-10">
                        <label class="radio-inline">
                            <input type="radio" name="logisticsInfo[status]" value="0" checked="">
                            未寄出
                        </label>
                        <label class="radio-inline">
                            <input type="radio" name="logisticsInfo[status]" value="1" {if $data['order_info']['logisticsInfo']['status']==1}checked{/if} >
                            已寄出
                        </label>
                    </div>
                </div>
                {*<input type="hidden" name="id" value="{$data['order_info']['id']}"/>*}
            {/if}
                {*<div class="form-group">*}
                    {*<div class="col-sm-offset-2 col-sm-10">*}
                        {*<button type="submit" class="btn btn-default">重置</button>*}
                        {*<button type="submit" class="btn btn-success">提交</button>*}
                    {*</div>*}
                {*</div>*}
            {*</form>*}
            {/if}
        </div>
    </div>

</div>


<!-- jQuery文件。务必在bootstrap.min.js 之前引入 -->
<script src="//cdn.bootcss.com/jquery/1.11.3/jquery.min.js"></script>
<!-- 最新的 Bootstrap 核心 JavaScript 文件 -->
<script src="//cdn.bootcss.com/bootstrap/3.3.5/js/bootstrap.min.js"></script>
{static "core/yunspace.js"}
<script>
    $(".check_ticket").click(function(){
        var ticket_num = $(this).attr('data-value');
        var urlPath = "wechat/ticket/check.jsonp";
        YunSpace.api(urlPath,{
            ticket_num:ticket_num
        },function(data){
            if(data.status==1){
                alert('验票成功');
                window.location.reload();
            }else{
                alert(data.msg);
            }
        });
    });

</script>
</body>
</html>