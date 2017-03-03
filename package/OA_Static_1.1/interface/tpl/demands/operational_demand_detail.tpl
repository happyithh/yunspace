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

</head>
<!-- END HEAD -->
<!-- BEGIN BODY -->
<style>
    td {
        word-break: break-all;
    }
</style>

<body style="background:#FaFaFa !important">
<div class="portlet">
    <div class="portlet-title">
        <div class="caption">
            <i class="fa fa-database"></i>需求详情
        </div>
        {*{if $_demand['demand_status'] == 0 || $_demand['demand_status'] == 5}*}
            {*{include "OA_Static::demands/inc/countdown.tpl"  value="{$_demand['end_time']}" }*}
            {*{include "OA_Static::Demand.v2.0/inc/handle_delay.tpl"  value="{$_demand['end_time']}" demand_id="{$_demand['id']}" }*}

        {*{/if}*}
    </div>
    <div class="portlet-body">
        <div class="container-fluid">
            <div class="row">
                <table class="table table-hover" style="border:0px;">
                    <tbody>
                    <tr>
                        <td>活动名称：</td>
                        <td>{$_demand['demand_name']}</td>
                    </tr>
                    <tr>
                        <td>更新时间：</td>
                        <td>{Date('Y-m-d H:i:s',$_demand['create_time'])}</td>
                    </tr>
                    <tr>
                        <td>联系人：</td>
                        <td>{if $_demand['username']}{$_demand['username']}{else}{$_demand['demand_name']}{/if}</td>
                    </tr>
                    <tr>
                        <td>联系电话：</td>
                        <td>{$_demand['phone']}</td>
                    </tr>
                    <tr>
                        <td>活动城市：</td>
                        <td>{$_demand['city']}</td>
                    </tr>
                    {if $_demand['demand_type']=='供应商加盟'}
                        <tr>
                            <td>公司名称：</td>
                            <td>{$_demand['demand']['公司名称']}</td>
                        </tr>
                        <tr>
                            <td>办公电话：</td>
                            <td>{$_demand['demand']['办公电话']}</td>
                        </tr>
                    {/if}
                    <tr>
                        <td>预算范围：</td>
                        <td>{$_demand['price_up']}至{$_demand['price_down']}</td>

                    </tr>
                    <tr>
                        <td>需求类型：</td>
                        <td>{{$_demand['demand_type']}}</td>
                    </tr>
                    <tr>
                        <td>业务类型：</td>
                        <td>{if $_demand['demand']['业务类型']}{$_demand['demand']['业务类型']}{else}{$_demand['demand']['活动类型']}{/if}</td>
                    </tr>

                    <tr>
                        <td>具体要求：</td>
                        <td>
                            {if $_demand['demand']['product_id']}
                                <p><a target="_blank"
                                      href="{$_root}service_info/{$_demand['demand']['product_id']}.html">点此查看产品链接</a>
                                </p>
                            {/if}
                            {if $_demand['demand']['set_id']}
                                <p><a target="_blank"
                                      href="{$_root}set_info/{$_demand['demand']['set_id']}.html">点此查看产品链接</a>
                                </p>
                            {/if}

                            {if $_demand['demand']['vendor_id']}
                                <p><a target="_blank" href="{$_root}vendor_info/{$_demand['demand']['vendor_id']}.html">点此查看详情</a>
                                </p>
                            {/if}
                            <p>{$_demand['demand']['具体要求']}</p>
                        </td>
                    </tr>
                    {if !empty($_demand['demand_reason'])}
                        <tr>
                            <td>拒绝理由：</td>
                            <td>{$_demand['demand_reason'][0]}
                                (备注：{$_demand['demand_reason'][1]})
                            </td>
                        </tr>
                    {/if}
                    <tr>
                        <td>其他信息</td>
                        <td>
                            {foreach $_demand['demand'] as $key=>$val}
                                {if is_array($val)}
                                    <p>{$key}:</p>
                                    {foreach $val as $k=>$v}
                                        <p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; {$k}:&nbsp;&nbsp;&nbsp;{$v}</p>
                                    {/foreach}
                                {else}
                                    <p>{$key}：&nbsp;&nbsp;&nbsp;{$val}</p>
                                {/if}
                            {/foreach}
                        </td>
                    </tr>

                    <tr>

                        <td colspan="2" style="background: #EEEEEE">
                            {if $_demand['demand_status'] != 5}
                                <a class="btn btn-success offer" style="float: right;margin-left: 5px;"
                                   data-pid="{$_demand['id']}">转为测试</a>
                            {/if}
                            {*{if ($_demand['demand_status'] == -1 || $_demand['demand_status'] == 1) AND empty($_demand['offer_id'])}*}
                                {*<a href="{$_home}operation/demand_tender?act=demand_offer&demand_id={$_demand['id']}"*}
                                   {*class="btn btn-info " style="float: right;margin-left: 5px;">转入报价系统</a>*}
                            {*{/if}*}
                            {if $_demand['demand_status'] == 0 || $_demand['demand_status'] == 5}
                                {if $_demand['demand_status'] == 5}
                                    <a class="btn btn-info  backout" style="float: right;margin-left: 5px;"
                                       data-backid="{$_demand['id']}">撤销测试</a>
                                {/if}
                                <form class="pull-right" action="?action=receive" method="post">
                                    <input type="hidden" value="{$_demand['id']}" name="demand_id">

                                    <button type="submit" class="btn btn-success">接受需求</button>
                                    <a class="btn btn-danger"
                                       href="#create_site_lokksite" data-toggle="modal"
                                       onclick="LookSite(this)" data-pid="{$_demand['id']}">放弃需求</a>
                                    {* <a class="btn btn-danger" href="?action=abandon&id={$_demand['id']}">放弃需求</a>*}
                                </form>
                            {/if}


                        </td>
                    </tr>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
    {include "OA_Static::demands/inc/demand_response.tpl"}
    {include "OA_Static::demands/inc/demand_recent.tpl"}
    <div class="modal fade" id="create_site_lokksite" tabindex="-1" role="basic" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                    <h4 class="modal-title">
                        拒绝理由</h4>
                </div>
                <div class="modal-body">

                    <table>
                        <tr>
                            <td>
                                关闭理由：
                            </td>
                            <td>
                                &bkarow;<input type="checkbox" name="reason" value="联系不到"> 联系不到
                            </td>
                            <td>
                                &bkarow; <input type="checkbox" value="恶意提交" name="reason"> 恶意提交
                            </td>
                            <td>
                                &bkarow; <input type="checkbox" name="reason" value="客户手机输入错误"> 客户手机输入错误
                            </td>
                            <td>
                                &bkarow;<input type="checkbox" value="重复" name="reason"> 重复
                            </td>
                            <td>
                                &bkarow;<input type="checkbox" value="其他原因" name="reason"> 其他原因
                            </td>
                        </tr>
                        <tr>
                            <td>
                                备注：
                            </td>
                            <td colspan="4"><textarea name="demo" class="form-control look_reason" rows="5"></textarea>
                            </td>
                        </tr>
                    </table>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">
                        取消
                    </button>
                    <button type="button" class="btn btn-success create_site_submit">
                        确定
                    </button>
                </div>

            </div>
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
<script src="{$_assets}scripts/app.js"></script>
<script src="{$_assets}scripts/_page.js"></script>
<script>

    $(document).ready(function () {
        $(".tags_select2").each(function () {
            $(this).select2({
                tags: $(this).data('values').split(',')
            })
        });

    });
    jQuery(document).ready(function () {
        App.init();
        TableManaged.init();
    });
    //放弃需求

    $('.create_site_submit').on('click', function () {
        var demo = $(".look_reason").val();
        var reason = document.getElementsByName('reason');
        var s = '';
        for (var i = 0; i < reason.length; i++) {
            if (reason[i].checked) s += reason[i].value + ',';  //如果选中，将value添加到变量s中
        }
        $.ajax({
            url: "?action=abandon&id={$_demand['id']}",
            data: {
                reason: s,
                demo: demo

            },

            dataType: "json"
        }).done(function (data) {

            if (data.status == 1) {
                top.alert(data.msg);
//                window.location.reload();
                history.go(-1)
            } else {
                top.alert(data.msg);
            }
        });

    });


    //转为测试
    $('.offer').on('click', function () {
        var id = $('.offer').data('pid');
        console.log(id);
        $.ajax({
            url: "?action=offer",
            data: {
                id: id

            },

            dataType: "json"
        }).done(function (data) {

            if (data.status == 1) {
                top.alert(data.msg);
                history.go(-1)
            } else {
                top.alert(data.msg);
            }
        });

    });

    //撤销测试
    $('.backout').on('click', function () {
        var id = $('.backout').data('backid');
        var action = 'backout';
        console.log(id);
        $.ajax({
            url: "?action=backout",
            data: {
                id: id

            },

            dataType: "json"
        }).done(function (data) {

            if (data.status == 1) {
                top.alert(data.msg);
                history.go(-1)
            } else {
                top.alert(data.msg);
            }
        });

    });

</script>
</body>
<!-- END BODY -->
</html>