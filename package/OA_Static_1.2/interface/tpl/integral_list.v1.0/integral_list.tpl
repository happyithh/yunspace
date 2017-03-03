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
                    <input type="hidden" name="action" value="integral_list">
                    <div class="form-body clearfix">
                        <div class="form-group col-md-5">
                            <label class="col-md-3 control-label">创建时间</label>

                            <div class="col-md-4">
                                <input type='text' class="form-control date" placeholder="请选择开始时间"
                                       name="search[start_time]" value="{$_REQUEST['search']['start_time']}"/>
                            </div>
                            <div class="col-md-4 col-md-offset-1">
                                <input type='text' class="form-control date" placeholder="请选择结束时间"
                                       name="search[end_time]" value="{$_REQUEST['search']['end_time']}"/>
                            </div>
                        </div>

                        <div class="form-group col-md-5">
                            <label class="col-md-3 control-label">用户名</label>

                            <div class="col-md-9">
                                <input type="text" class="form-control input-sm" placeholder="用户名"
                                       name="search[fullname]" value="{$_REQUEST['search']['fullname']}">
                            </div>
                        </div>

                        <div class="form-group col-md-5">
                            <label class="col-md-3 control-label">积分</label>

                            <div class="col-md-9">
                                <input type="text" class="form-control input-sm" placeholder="积分"
                                       name="search[integral]" value="{$_REQUEST['search']['integral']}">
                            </div>
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
<div class="portlet ">
    <div class="portlet-title" style="padding: 6px;">
        <div class="caption">
            <i class="fa fa-comments"></i>
            积分列表
        </div>
    </div>

    <div class="portlet-body">

        <div class="table-responsive clearfix">
            <table class="table table-striped table-bordered table-hover" id="data_table"
                   style="word-break: break-all;float: left ">
                <thead>
                <tr>
                    <th>创建时间</th>
                    <th>需求id</th>
                    <th>用户id</th>
                    <th>用户名</th>
                    <th>积分</th>
                    <th>事项</th>
                </tr>
                </thead>
                {if !empty($_data['rows'])}
                    {foreach $_data['rows'] as $k=>$v}
                        <tr>
                            <td>{date("Y-m-d H:i:s",$v['create_time'])}</td>
                            <td>{$v['demand_id']}</td>
                            <td><a href="?action=integral_list&account_id={$v['account_id']}">{$v['account_id']}</a></td>
                            <td> {$v['fullname']}</td>
                            <td title="{$v['integral']}" class="args_title"> {$v['integral']}</td>
                            <td>{$v['intro']}</td>
                        </tr>
                    {/foreach}
                {/if}
                </thead>
                <tbody>
            </table>
            <div class="text-center">
                <ul class="pagination pull-right">
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
                            /{$_data['page']['dt']}
                            )</a></li>

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
</div>

<script src="{$_assets}plugins/jquery-1.11.0.min.js"
        type="text/javascript"></script>
<script src="{$_assets}scripts/_page.js"></script>
<script type="text/javascript" src="js/moment.min.js"></script>
<script type="text/javascript" src="js/zh-cn.js"></script>
<script type="text/javascript" src="js/bootstrap-datetimepicker.min.js"></script>
<script>
    $(document).ready(function () {
        $('.date').datetimepicker({
            format: 'YYYY-MM-DD',
            locale: 'zh-cn'
        });
        $(".args_title").on('click',function(){
         var   args_title = $(this).attr('title');
            $("#args_title").html(args_title);
        });
    })
</script>
</body>
<!-- END BODY -->
</html>