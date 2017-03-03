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
                    <div class="form-body clearfix">
                        <div class="form-group col-md-5">
                            <label class="col-md-3 control-label">选择日期</label>

                            <div class="col-md-3">
                                <input type='text' class="form-control date" name="month"
                                       value="{if empty($_REQUEST['month'])} {date('Y-m',time())}{else} {$_REQUEST['month']}{/if}"/>
                            </div>
                            <div class="col-md-3">
                                <input type='text' class="form-control" name="date_time"
                                       value="{$_REQUEST['date_time']}"/>
                            </div>
                        </div>
                        <div class="form-group col-md-5">
                            <label class="col-md-3 control-label">查询url</label>

                            <div class="col-md-9">
                                <input type="text" class="form-control input-sm" placeholder="url"
                                       name="url" value="{$_REQUEST['url']}">
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
    <div class="portlet-title" style="padding: 6px;">
        <div class="caption">
            <i class="fa fa-comments"></i>
            落地页统计
        </div>
    </div>
    <div class="portlet-body">
        <div class="form-body clearfix">
            <div class="form-group col-md-3">
                <label class="col-md-3 control-label">选择月份</label>

                <div class="col-md-9">

                    <input type='text' class="form-control date1" name="datetime"
                           value="{if empty($_REQUEST['datetime'])} {date('Ym',time())}{else} {$_REQUEST['datetime']}{/if}" />

                </div>
            </div>

            <div class="form-group col-md-3">
                <label class="col-md-3 control-label">开始id</label>

                <div class="col-md-9">
                    <input type='text' class="form-control" placeholder="开始id" name="start_id" value="{$_REQUEST['start_id']}" />
                </div>
            </div>

            <div class="form-group col-md-3">
                <label class="col-md-3 control-label">结束id</label>

                <div class="col-md-9">
                    <input type='text' class="form-control" placeholder="结束id" name="end_id" value="{$_REQUEST['end_id']}" />

                </div>
            </div>

            <div class="form-group col-md-2">
                <a href="javascript:;" class="btn btn-info update_data" >
                    <i class="fa fa-search"></i>
                    更新数据
                </a>
            </div>
        </div>
        <div class="table-responsive clearfix">
            <table class="table table-striped table-bordered table-hover" id="data_table"
                   style="word-break: break-all;float: left ">
                <thead>
                <tr>
                    <th>日期</th>
                    <th>落地页</th>
                    <th>一级</th>
                    <th>二级</th>
                    <th>三级</th>
                    <th>四级</th>
                    <th>四级以上</th>
                    <th>一级跳出</th>
                    <th>二级跳出</th>
                    <th>三级跳出</th>
                    <th>三级以上跳出</th>
                    <th>创建时间</th>
                </tr>
                </thead>
                <tbody>
                {if !empty($_data['rows'])}
                    {foreach $_data['rows'] as $k=>$v}
                        <tr>
                            <td>{date("Y-m-d",strtotime($v['datetime']))}</td>
                            <td>{$v['land_url']}</td>
                            <td>{$v['layer_1']}</td>
                            <td>{$v['layer_2']}</td>
                            <td>{$v['layer_3']}</td>
                            <td>{$v['layer_4']}</td>
                            <td>{$v['layer_5']}</td>
                            <td>{$v['land_1']}</td>
                            <td>{$v['land_2']}</td>
                            <td>{$v['land_3']}</td>
                            <td>{$v['land_4']}</td>
                            <td>{date("Y-m-d",$v['create_time'])}</td>
                        </tr>
                    {/foreach}
                {/if}
                </tbody>
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

<script src="{$_assets}plugins/jquery-1.11.0.min.js"
        type="text/javascript"></script>
<script src="{$_assets}scripts/_page.js"></script>
<script type="text/javascript" src="js/moment.min.js"></script>
<script type="text/javascript" src="js/zh-cn.js"></script>
<script type="text/javascript" src="js/bootstrap-datetimepicker.min.js"></script>
<script>
    $(document).ready(function () {
        $('.date').datetimepicker({
            format: 'YYYY-MM',
            locale: 'zh-cn'
        });
        $('.date1').datetimepicker({
            format: 'YYYYMM',
            locale: 'zh-cn'
        });
        $(".args_title").on('click',function(){
            var   args_title = $(this).attr('title');
            $("#args_title").html(args_title);
        });

        //更新数据
        $(".update_data").click(function(){
            $(this).addClass('disabled');
            var start_id=$("input[name=start_id]").val();
            var end_id=$("input[name=end_id]").val();
            var datetime=$("input[name=datetime]").val();
            $.post('http://{Core::$urls['host']}/static/api/track/count.jsonp', {
                start_id: start_id,
                end_id: end_id,
                datetime: datetime,
                action: "land"
            }, function (data) {
                if (data.status == 1) {
                    window.location.href="?start_id="+start_id+"&end_id="+end_id+"&datetime="+datetime;
                } else {
                    top.alert(data.msg);
                }
            }, "json");
        })
    })
</script>
</body>
<!-- END BODY -->
</html>