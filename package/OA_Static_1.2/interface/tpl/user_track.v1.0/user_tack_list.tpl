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
                    <input type="hidden" name="action" value="track_list">
                    <input type="hidden" name="type" value="{$type}">


                    <div class="form-body clearfix">
                        <div class="form-group col-md-5">
                            <label class="col-md-3 control-label">选择月份</label>

                            <div class="col-md-9">

                                <input type='text' class="form-control date" name="month"
                                value="{if empty($_REQUEST['month'])} {date('Y-m-d',time())}{else} {$_REQUEST['month']}{/if}"/>

                            </div>
                        </div>

                        <div class="form-group col-md-5">
                            <label class="col-md-3 control-label">用户id</label>

                            <div class="col-md-9">
                                <input type="text" class="form-control input-sm" placeholder="用户id"
                                       name="search[string]" value="{$_REQUEST['search']['string']}">
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
            用户轨迹
        </div>
    </div>

    <div style="width: 100%;height: 100%; margin: 5px 20px;float: left;" class="col-md-12" id="args_title">
    </div>
    <div class="portlet-body">

        <div class="table-responsive clearfix">
            <table class="table table-striped table-bordered table-hover" id="data_table"
                   style="word-break: break-all;float: left ">
                <thead>
                <tr>
                    <th>创建时间</th>
                    <th>session_id</th>
                    <th>用户id</th>
                  {*  <th>用户名称</th>
                    <th>手机号</th>
                    <th>邮箱</th>*}
                    <th>IP</th>
                    <th>页面</th>
                    <th>来源</th>
                    <th>记录</th>
                </tr>
                </thead>
                {if !empty($_data['rows'])}
                    {foreach $_data['rows'] as $k=>$v}
                        <tr>
                            <td>{date("Y-m-d H:i:s",$v['create_time'])}</td>
                            <td><a href="?session_id={$v['session_id']}&month={$_REQUEST['month']}">{$v['session_id']}</a></td>
                            <td>{$v['user_id']}</td>
                         {*   <td><a href="?func_type={$v['func']}&month={$_REQUEST['month']}">{$v['username']}</a></td>
                            <td>{$v['phone']}</td>
                            <td>{$v['email']}</td>*}
                            <td title="{$v['args']}" class="args_title"> {$v['ip']}</td>
                            <td>{$v['url']}</td>
                            <td>{$v['referer']}</td>
                            <td>{$v['log']}</td>
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
            format: 'YYYYMM',
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