<!DOCTYPE html>
<!--[if IE 8]>
<html lang="en" class="ie8 no-js"> <![endif]-->
<!--[if IE 9]>
<html lang="en" class="ie9 no-js"> <![endif]-->
<!--[if !IE]><!-->
<html lang="en" class="no-js">
<!--<![endif]-->
<!-- BEGIN HEAD -->
<head>
    <title>{$title}</title>
    <meta content="" name="description"/>
    {include "Admin::inc/html_head.tpl"}
    <link href="style/css.css" rel="stylesheet"/>
    <link href="css/bootstrap-datetimepicker.min.css" rel="stylesheet"/>
</head>
<!-- END HEAD -->
<!-- BEGIN BODY -->

<body style="background:#FaFaFa !important">
</div>
<div class="portlet" >
    <div class="portlet-title" style="padding: 6px;">
        <div class="caption">
            <i class="fa fa-comments"></i>
            订单管理列表
        </div>
    </div>
    <div class="portlet-body">
        <div class="table-responsive clearfix">
            <table class="table table-striped table-bordered table-hover" id="data_table" style="word-break: break-all">
                <thead>
                <tr>
                    <th>购票人姓名</th>
                    <th>联系电话</th>
                    <th>活动名称</th>
                    <th>购票数量</th>
                    <th>购票时间</th>
                    <th>金额</th>
                    <th>操作</th>
                </tr>
                </thead>
                {foreach $data['rows'] as $k=>$v}
                    <tr>
                        <td>{$v['buyer_account_name']}</td>
                        <td>{$v['buyer_account_phone']}</td>
                        <td>{$v['event_title']}</td>
                        <td>{$v['order_ticket_num']} 张</td>
                        <td>{date('Y-m-d',$v['create_time2'])}</td>
                        <td>{$v['order_price_pay']} 元</td>
                        <td>
                            <a href="?action=detail&id={$v['id']}" class="btn btn-success btn-xs"><i class="fa fa-eye"></i>详情</a>

                        </td>
                    </tr>
                {/foreach}
                </thead>
                <tbody>

            </table>
            <div class="pull-left" style="width:30%; padding: 10px 0;">

            </div>
            <div class="pull-right">
                <ul class="pagination">
                    {if $data['page']['dpll']}
                        <li class="prev">
                            <a href="{$data['page']['dup']}1" title="First"><i class="fa fa-angle-double-left"></i></a>
                        </li>
                        <li class="prev">
                            <a href="{$data['page']['dup']}{$data['page']['dp']-1}" title="Prev"><i class="fa fa-angle-left"></i></a>
                        </li>
                    {else}
                        <li class="prev disabled">
                            <a href="#" title="First"><i class="fa fa-angle-double-left"></i></a>
                        </li>
                        <li class="prev disabled">
                            <a href="#" title="Prev"><i class="fa fa-angle-left"></i></a>
                        </li>
                    {/if}
                    {for $i=$data['page']['dpl'] to $data['page']['dpr']}
                        <li{if $i==$data['page']['dp']} class="active"{/if}>
                            <a href="{$data['page']['dup']}{$i}">{$i}</a>
                        </li>
                    {/for}
                    <li class="disabled">
                        <a> {$data['page']['dtp']}
                            ( {$data['page']['dp']*$data['page']['dn']}
                            /{$data['page']['dt']} )</a>
                    </li>

                    {if $data['page']['dprr']}
                        <li class="next">
                            <a href="{$data['page']['dup']}{$data['page']['dp']+1}" title="Next"><i class="fa fa-angle-right"></i></a>
                        </li>
                        <li class="next">
                            <a href="{$data['page']['dup']}{$data['page']['dtp']}" title="Last"><i class="fa fa-angle-double-right"></i></a>
                        </li>
                    {else}
                        <li class="next disabled">
                            <a href="#" title="Next"><i class="fa fa-angle-right"></i></a>
                        </li>
                        <li class="next disabled">
                            <a href="#" title="Last"><i class="fa fa-angle-double-right"></i></a>
                        </li>
                    {/if}
                </ul>
            </div>
        </div>
    </div>
</div>

<!-- BEGIN JAVASCRIPTS(Load javascripts at bottom, this will reduce page load time) -->
<!-- BEGIN CORE PLUGINS -->
<script src="{$_assets}plugins/jquery-1.11.0.min.js"
        type="text/javascript"></script>
<script src="{$_assets}scripts/_page.js"></script>
<script type="text/javascript" src="js/moment.min.js"></script>
<script type="text/javascript" src="js/zh-cn.js"></script>
<script type="text/javascript" src="js/bootstrap-datetimepicker.min.js"></script>
<script>
    $(document).ready(function(){
        $('.date').datetimepicker({
            format: 'YYYY-MM-DD',
            locale: 'zh-cn'
        });
    })
</script>
</body>
<!-- END BODY -->
</html>