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
    <link href="style/media.css" rel="stylesheet"/>
    <link href="style/css.css" rel="stylesheet"/>
    <link href="css/bootstrap-datetimepicker.min.css" rel="stylesheet"/>
</head>
<!-- END HEAD -->
<!-- BEGIN BODY -->

<body style="background:#FaFaFa !important">


<div class="portlet tabbable">
    <div class="portlet-title">
        <div class="caption">
            <i class="fa fa-search"></i>搜索条件
        </div>
    </div>
    <div class="portlet-body">
        <div class="portlet-tabs">
            <div class="clearfix"></div>
            <div>
                <form action="?" method="get" class="clearfix">
                    <input type="hidden" name="handle_type" value="{$handle_type}">
                    <div class="form-body clearfix">
                        <div class="form-group col-md-5">
                            <label class="col-md-3 control-label">供应商名称</label>

                            <div class="col-md-9">
                                <input type="text" class="form-control input-sm" placeholder="供应商名称" name="search[vendor_name]" value="{$_REQUEST['search']['vendor_name']}">
                            </div>
                        </div>
                        <div class="form-group col-md-5">
                            <label class="col-md-3 control-label">采购者名称</label>

                            <div class="col-md-9">
                                <input type="text" class="form-control input-sm" placeholder="采购者名称 " name="search[username]" value="{$_REQUEST['search']['username']}">
                            </div>
                        </div>
                        <div class="form-group col-md-5">
                            <label class="col-md-3 control-label">订单号</label>

                            <div class="col-md-9">
                                <input type="text" class="form-control input-sm" placeholder=" 订单号 " name="search[order_no]" value="{$_REQUEST['search']['order_no']}">
                            </div>
                        </div>
                        <div class="form-group col-md-5">
                            <label class="col-md-3 control-label">操作者</label>

                            <div class="col-md-9">
                                <input type="text" class="form-control input-sm" placeholder="操作者" name="search[admin_user]" value="{$_REQUEST['search']['admin_user']}">
                            </div>
                        </div>
                    </div>
                    <div class="form-actions">
                        <div class="" style="text-align: center">
                            <button type="submit" class="btn btn-primary" style="width: 150px">
                                <i class="fa fa-search"></i>
                                搜索
                            </button>
                        </div>
                    </div>
                </form>
            </div>

        </div>
    </div>
</div>
<div class="portlet">
    <div class="portlet-title">
        <div class="caption">
            <i class="fa fa-comments"></i>
            签约订单列表
        </div>
    </div>

    <div class="portlet-body">
        <div class="table-responsive clearfix">
            <table class="table table-striped table-bordered table-hover" id="data_table" style="word-break: break-all">
                <thead>
                <tr>
                    <th>ID</th>
                    <th >采购者</th>
                    <th>供应商</th>
                    {*<th>负责人</th>*}
                    <th >服务内容</th>
                    <th>订单号</th>
                    <th class="list_none">签约时间</th>
                    <th class="list_none">产品档期</th>
                    <th>操作者</th>
                </tr>
                </thead>
                <tbody>
                {foreach $_data['rows'] as $k=>$v}
                    <tr role="row">
                        <td>{$v['id']}</td>
                        <td>{if !empty($v['username'])}
                            <a href="?search[username]={$v['username']}">
                                {$v['username']}
                            </a>
                                {else}
                                ----
                            {/if}
                        </td>
                        <td>
                            <a href="?search[vendor_name]={$v['vendor_name']}">
                            {$v['vendor_name']}
                                </a>
                        </td>
                        <td>
                        <a href="{$_root}{if !empty($v['product_id'])}service_info/{$v['product_id']}{else}set_info/{$v['product_set_id']}{/if}.html" target="_blank">
                            {$v['order_title']}</a>
                        </td>
                        <td>{$v['order_no']}</td>
                        <td class="list_none">{date('Y-m-d H:i:s',$v['create_time3'])}</td>
                        <td class="list_none">
                            {if !empty($v['start_time']) && !empty($v['end_time'])}
                            {date('Y-m-d',$v['start_time'])}--{date('Y-m-d',$v['end_time'])}
                            {else}
                                -------
                            {/if}
                        </td>
                        <td>
                            {if !empty($v['admin_username'])}
                            {$v['admin_username']}
                            {else}
                                -----
                            {/if}
                        </td>
                    </tr>
                {/foreach}
                </tbody>
            </table>
            <div class="pull-left" style="width:30%; padding: 10px 0;">

            </div>
            <div class="pull-right">
                <ul class="pagination">
                    {if $_data['page']['dpll']}
                        <li class="prev">
                            <a href="{$_data['page']['dup']}1" title="First"><i class="fa fa-angle-double-left"></i></a>
                        </li>
                        <li class="prev">
                            <a href="{$_data['page']['dup']}{$_data['page']['dp']-1}" title="Prev"><i class="fa fa-angle-left"></i></a>
                        </li>
                    {else}
                        <li class="prev disabled">
                            <a href="#" title="First"><i class="fa fa-angle-double-left"></i></a>
                        </li>
                        <li class="prev disabled">
                            <a href="#" title="Prev"><i class="fa fa-angle-left"></i></a>
                        </li>
                    {/if}
                    {for $i=$_data['page']['dpl'] to $_data['page']['dpr']}
                        <li{if $i==$_data['page']['dp']} class="active"{/if}>
                            <a href="{$_data['page']['dup']}{$i}">{$i}</a>
                        </li>
                    {/for}
                    <li class="disabled">
                        <a> {$_data['page']['dtp']}
                            ( {$_data['page']['dp']*$_data['page']['dn']}
                            /{$_data['page']['dt']} )</a>
                    </li>

                    {if $_data['page']['dprr']}
                        <li class="next">
                            <a href="{$_data['page']['dup']}{$_data['page']['dp']+1}" title="Next"><i class="fa fa-angle-right"></i></a>
                        </li>
                        <li class="next">
                            <a href="{$_data['page']['dup']}{$_data['page']['dtp']}" title="Last"><i class="fa fa-angle-double-right"></i></a>
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

    $('.resetVendor').click(function(){
        var vendor_id=$(this).attr('data-vid');
        $.post('?',{ id:vendor_id,action:'reset',list_type:'vendor' },function(data){
            if(data.status==1){
                window.location.reload();
            }else{
                alert(data.msg);
            }
        },'json')
    })
</script>
</body>
<!-- END BODY -->
</html>