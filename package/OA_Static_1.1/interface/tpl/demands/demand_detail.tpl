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

<script src="{$_assets}plugins/jquery-1.11.0.min.js"
        type="text/javascript"></script>
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
        <div style="float: right">
            {*<a href="{$_home}operation/demand_offer?demand_id={$_demand['id']}&type=1"*}
               {*class="btn btn-primary" style="height: 25px;line-height: 12px;">提交至报价系统获取报价</a>*}
            &nbsp;&nbsp;
            <a href="?action=demand_edit_tpl&demand_id={$_demand['id']}"
               class="btn btn-primary" style="height: 25px;line-height: 12px;">编辑需求</a>
            &nbsp;

            <a href="?action=contact_detail_from&phone={$_demand['phone']}"
               class="btn btn-success" style="height: 25px;line-height: 12px;">编辑联系人</a>
        </div>
    </div>
    <div class="portlet-body">
        <div class="container-fluid">
            <div class="row">
                <table class="table table-hover" style="border:0px;">
                    <tbody>
                    <tr>
                        <td>更新时间：</td>
                        <td>{Date('Y-m-d H:i:s',$_demand['create_time'])}</td>
                    </tr>
                    <tr>
                        <td>姓名：</td>
                        <td>{if $_demand['username']}{$_demand['username']}{else}{$_demand['demand']['联系人']}{/if}</td>
                    </tr>
                    <tr>
                        <td>电话：</td>
                        <td>{$_demand['phone']}</td>
                    </tr>
                    <tr>
                        <td>活动城市：</td>
                        <td>{$_demand['city']}</td>
                    </tr>
                    <tr>
                        <td>预算范围：</td>
                        <td>{$_demand['price_up']}至{$_demand['price_down']}</td>
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
                        <td>活动名称：</td>
                        <td>{{$_demand['demand_name']}}</td>
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
                                <p><a target="_blank" href="{$_root}set_info/{$_demand['demand']['set_id']}.html">点此查看产品链接</a>
                                </p>
                            {/if}

                            {if $_demand['demand']['vendor_id']}
                                <p><a target="_blank" href="{$_root}vendor_info/{$_demand['demand']['vendor_id']}.html">点此查看详情</a>
                                </p>
                            {/if}
                            <p>{$_demand['demand']['具体要求']}</p>
                        </td>
                    </tr>
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
                    </tbody>
                </table>
            </div>
        </div>
    </div>
    <div class="portlet">
        <div class="portlet-title">
            <div class="caption">
                <i class="fa fa-database"></i>分配负责人
            </div>
        </div>
        <div style="padding: 10px  50px;">
            <div class="portlet" style="padding: 10px ">
                负责人信息:
                <br>

                <div>
                    <table style="width: 350px;">
                        <tr>
                            <td style="width: 100px"> 名&nbsp;称:</td>
                            <td style="width: 250px;">{$admin_info['fullname']}</td>
                        </tr>
                        <tr>
                            <td> 手机号:</td>
                            <td>{$admin_info['phone']}</td>
                        </tr>
                        <tr>
                            <td> 所在城市：</td>
                            <td>{$admin_info['city']}</td>
                        </tr>
                        <tr>
                            <td> 所在部门：</td>
                            <td>{$admin_info['department_name']}</td>
                        </tr>
                        <tr>
                            <td> 所在组：</td>
                            <td>{$admin_info['team_name']}</td>
                        </tr>
                    </table>

                </div>
            </div>
            <div class="portlet">
                <select class="form-control input-sm" id="{$_demand['id']}"
                        onchange="demand.getAdmin(this)" style="width: 40%;">
                    <option value=0>分配负责人</option>
                    {foreach $admin as $key=>$value}
                        <option data-admin-id="{$value['admin_id']}"
                                value="{$value['response_account_id']}" {if $value['response_account_id']==$_demand['response_account_id']} selected{/if}>{$value['fullname']}</option>
                    {/foreach}
                </select>
            </div>
        </div>
    </div>
    {***************进度记录**********}
    {include "OA_Static::demands/inc/demand_step_record.inc.tpl"}
    {***************推荐记录**********}
    {include "OA_Static::demands/inc/demand_recommend.inc.tpl"}
    {***************联系记录***********}
    {include "OA_Static::demands/inc/demand_contact_record.inc.tpl"}
    {***************报价记录************}
    {include "OA_Static::demands/inc/demand_scheme.tpl"}

</body>
<!-- BEGIN JAVASCRIPTS(Load javascripts at bottom, this will reduce page load time) -->
<!-- BEGIN CORE PLUGINS -->

{static "core/yunspace.js"}
<script src="js/demands/demands_change_select.js" type="text/javascript"></script>
<script src="{$_assets}plugins/bootstrap/js/bootstrap.min.js"
        type="text/javascript"></script>
<script type="text/javascript"
        src="{$_assets}plugins/select2/select2.min.js"></script>
<!-- END PAGE LEVEL PLUGINS -->
<script>
    $("#search_product_all").select2({
        placeholder: "选择产品或者套餐",
        minimumInputLength: 1,
        ajax: {
            url: 'http://' + window.location.host + "/static/api/product/search/all.json?action=all",
            dataType: 'json',
            data: function (term, page) {
                return {
                    account_id: $("#search_product_all").data('account_id'),
                    q: term
                };
            },
            results: function (data, page) { // parse the results into the format expected by Select2.
                // since we are using custom formatting functions we do not need to alter remote JSON data

                return {
                    results: data.data
                };
            }
        },

        formatResult: formatRepo, // omitted for brevity, see the source of this page
        formatSelection: formatRepoSelection, // omitted for brevity, see the source of this page
        escapeMarkup: function (m) {
            return m;
        } // we do not want to escape markup since we are displaying html in results
    });
    function formatRepo(repo) {
        if (repo.loading) return repo.text;
        return repo.name;
    }
    function formatRepoSelection(repo) {
        if (repo.product_id) {
            $("#search_product_all").attr('product_id', repo.product_id);
        } else {
            $("#search_product_all").attr('set_id', repo.set_id);
        }
        return repo.name || repo.text;
    }

    var demandOperation = {
        //推荐提交
        recommendSubmit: function (e) {
            var set_id = $("#search_product_all").attr('set_id');
            var product_id = $("#search_product_all").attr('product_id');
            var demo = $("#reason").val();
            var demand_id = $("#demand_id").val();
            if (!product_id && !set_id) {
                top.alert('请选择您要推荐的服务！');
                return false;
            }
            $.ajax({
                type: 'get',
                url: '?action=ajaxRecommendSubmit',
                data: {
                    demand_id: demand_id,
                    set_id: set_id,
                    demo: demo,
                    product_id: product_id
                },
                dataType: 'json',
                success: function (data) {
                    if (data.status == 1) {
                        top.alert(data.msg);
                        window.location.reload();
                    } else {
                        top.alert(data.msg);
                    }
                }
            });
        }
    };
</script>
</body>
<!-- END BODY -->
</html>