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
</head>
<!-- END HEAD -->
<!-- BEGIN BODY -->

<body style="background:#FaFaFa !important">
<div class="portlet">
    <div class="portlet-title">
        <div class="caption">
            <i class="fa fa-database"></i>需求详情
        </div>
    </div>
    <div class="portlet-body">
        <div class="container-fluid">
            <div class="clearfix col-md-12">
                <div class="col-md-10">
                    <div class="form-group clearfix readdata">
                        <label class="control-label col-md-3">联系人:</label>
                        <div class="col-md-9">
                            <p class="form-control-static">{$demand['username']}</p>
                        </div>
                    </div>
                </div>
                <div class="col-md-10">
                    <div class="form-group clearfix readdata">
                        <label class="control-label col-md-3">联系方式:</label>
                        <div class="col-md-9">
                            <p class="form-control-static">{$demand['phone']}</p>
                        </div>
                    </div>
                </div>
                <div class="col-md-10">
                    <div class="form-group clearfix readdata">
                        <label class="control-label col-md-3">具体要求:</label>
                        <div class="col-md-9">
                            <p class="form-control-static">{$demand['demand']['具体要求']}</p>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    {if $demand_recommend['demand_demo']}
        <div class="portlet-title">
            <div class="caption">
                <i class="fa fa-database"></i>需求回复
            </div>
        </div>
    <div class="tab-pane active" >
        <div>
            <table class="table table-striped table-bordered table-hover" style="word-break: break-all">
                <tr>
                    <th>回复时间</th>
                    <th>回复内容</th>
                </tr>
                {foreach $demand_recommend['demand_demo'] as $dk=>$dv}
                <tr>
                    <td>{date('Y-m-d H:i:s',$dv['create_time'])}</td>
                    <td>{htmlspecialchars($dv['demo'])}</td>
                </tr>
                {/foreach}
            </table>
        </div>
     </div>
    {/if}
    {if $demand_recommend['demand_product']['rows']}

    <div class="portlet-title">
        <div class="caption">
            <i class="fa fa-database"></i>推荐列表
        </div>
    </div>
    <div class="tab-content clearfix">
        <div class="tab-pane active" >
        <table class="table table-striped table-bordered table-hover" style="word-break: break-all">
            <thead>
            <tr>
                <th>产品名称</th>
                <th>推荐理由</th>
                <th>推荐时间</th>
                <th>操作</th>
            </tr>
            </thead>
            <tbody>
            {foreach $demand_recommend['demand_product']['rows'] as $key=>$value}
                <tr>
                    <td>{$value['product_name']}</td>
                    <td>{$value['demo']}</td>
                    <td>{date('Y-m-d H:i:s',$value['create_time'])}</td>
                    <td>
                        <a target="_blank" href="/service_info/{$value['product_id']}.html" class="btn btn-success btn-xs">查看</a>
                        <a target="_blank" href="?action=pdf&product_id={$value['product_id']}" class="btn btn-primary btn-xs">导出PDF</a>
                        <a  href="?action=create_order&product_id={$value['product_id']}&demand_id={$demand['id']}" class="btn btn-primary btn-xs">生成订单</a>
                    </td>
                </tr>
            {/foreach}
            </tbody>
        </table>
         </div>
         <div class="pull-right">
            <ul class="pagination">
                {if $demand_recommend['demand_product']['page']['dpll']}
                    <li class="prev">
                        <a href="{$demand_recommend['demand_product']['page']['dup']}1" title="First"><i class="fa fa-angle-double-left"></i></a>
                    </li>
                    <li class="prev">
                        <a href="{$demand_recommend['demand_product']['page']['dup']}{$demand_recommend['demand_product']['page']['dp']-1}" title="Prev"><i class="fa fa-angle-left"></i></a>
                    </li>
                {else}
                    <li class="prev disabled">
                        <a href="#" title="First"><i class="fa fa-angle-double-left"></i></a>
                    </li>
                    <li class="prev disabled">
                        <a href="#" title="Prev"><i class="fa fa-angle-left"></i></a>
                    </li>
                {/if}
                {for $i=$demand_recommend['demand_product']['page']['dpl'] to $demand_recommend['demand_product']['page']['dpr']}
                    <li{if $i==$demand_recommend['demand_product']['page']['dp']} class="active"{/if}>
                        <a href="{$demand_recommend['demand_product']['page']['dup']}{$i}">{$i}</a>
                    </li>
                {/for}
                <li class="disabled">
                    <a> {$demand_recommend['demand_product']['page']['dtp']} ( {$demand_recommend['demand_product']['page']['dp']*$demand_recommend['demand_product']['page']['dn']}/{$demand_recommend['demand_product']['page']['dt']} )</a></li>

                {if $demand_recommend['demand_product']['page']['dprr']}
                    <li class="next">
                        <a href="{$demand_recommend['demand_product']['page']['dup']}{$demand_recommend['demand_product']['page']['dp']+1}" title="Next"><i class="fa fa-angle-right"></i></a>
                    </li>
                    <li class="next">
                        <a href="{$demand_recommend['demand_product']['page']['dup']}{$demand_recommend['demand_product']['page']['dtp']}" title="Last"><i class="fa fa-angle-double-right"></i></a>
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
    {/if}
    <div class="portlet-title">
        <div class="caption">
            <i class="fa fa-database"></i>需求推荐
        </div>
    </div>
    <div class="portlet-body">
        <form class="form-horizontal" action="?action=recommend_submit" method="post">
            <input type="hidden" name="data[demand_id]" value="{$_REQUEST['demand_id']}" >
            <div class="form-group">
                <label for="inputEmail12" class="col-md-2">推荐产品：</label>
                <div class="col-md-4">
                    <div class="input-icon">
                        <input type="text" class="form-control" id="inputEmail12" placeholder="请输入产品地址" name="data[product_url]">
                    </div>
                </div>
            </div>
            <div class="form-group">
                <label for="inputEmail11" class="col-md-2">推荐理由：</label>
                <div class="col-md-4">
                    <div class="input-icon">
                        <textarea name="data[demo]" class="form-control" rows="5"></textarea>
                    </div>
                </div>
            </div>
            <div class="form-actions">
                <div class="form-group">
                    <div class="col-md-offset-2 col-md-10">
                        <button type="submit" class="btn btn-success">确认推荐</button>
                    </div>
                </div>
            </div>
        </form>
    </div>
</div>


</body>
<!-- BEGIN JAVASCRIPTS(Load javascripts at bottom, this will reduce page load time) -->
<!-- BEGIN CORE PLUGINS -->
<script src="{$_assets}plugins/jquery-1.11.0.min.js"
        type="text/javascript"></script>
<script src="{$_assets}plugins/jquery-migrate-1.2.1.min.js"
        type="text/javascript"></script>
<!-- IMPORTANT! Load jquery-ui-1.10.3.custom.min.js before bootstrap.min.js to fix bootstrap tooltip conflict with jquery ui tooltip -->
<script src="{$_assets}plugins/jquery-ui/jquery-ui-1.10.3.custom.min.js"
        type="text/javascript"></script>
<script src="{$_assets}plugins/bootstrap/js/bootstrap.min.js"
        type="text/javascript"></script>
<script src="{$_assets}plugins/bootstrap-hover-dropdown/bootstrap-hover-dropdown.min.js"
        type="text/javascript"></script>
<script src="{$_assets}plugins/jquery-slimscroll/jquery.slimscroll.min.js"
        type="text/javascript"></script>
<script src="{$_assets}plugins/jquery.blockui.min.js"
        type="text/javascript"></script>
<script src="{$_assets}plugins/uniform/jquery.uniform.min.js"
        type="text/javascript"></script>
<!-- END CORE PLUGINS -->
<!-- BEGIN PAGE LEVEL PLUGINS -->
<script type="text/javascript"
        src="{$_assets}plugins/select2/select2.min.js"></script>
<script type="text/javascript"
        src="{$_assets}plugins/datatables/media/js/jquery.dataTables.min.js"></script>
<script type="text/javascript"
        src="{$_assets}plugins/datatables/plugins/bootstrap/dataTables.bootstrap.js"></script>
<!-- END PAGE LEVEL PLUGINS -->
<!-- BEGIN PAGE LEVEL SCRIPTS -->
<script src="{$_assets}scripts/_page.js"></script>
</body>
<!-- END BODY -->
</html>