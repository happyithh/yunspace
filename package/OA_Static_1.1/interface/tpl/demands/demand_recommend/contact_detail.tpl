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
    <script src="{$_assets}plugins/jquery-1.11.0.min.js" type="text/javascript"></script>
    <script src="{$_assets}plugins/bootstrap/js/bootstrap.min.js" type="text/javascript"></script>
    <script type="text/javascript" src="{$_assets}plugins/select2/select2.min.js"></script>
    <title>{$title}</title>
    <meta content="" name="description"/>
    {include "Admin::inc/html_head.tpl"}
    <style>
        @media (max-width: 520px) {
            .list_none {
                display: none;
            }

            .table-responsive table tbody tr td {
                white-space: inherit !important;
            }

        }
    </style>
</head>
<!-- END HEAD -->
<!-- BEGIN BODY -->

<body style="background:#FaFaFa !important">
<div class="portlet">
    <div class="portlet-title">
        <div class="caption">
            <i class="fa fa-reorder"></i>联系人详情
        </div>
    </div>
    <div class="portlet-body">
        <blockquote class="hero">
            <h2>{$data['username']}</h2>
            {if ($data['is_my'])||$data['is_admin']}
                {if !$data['account_id']}
                    <span style="float: right;margin-right: 10px;">
                    <a class="btn btn-success" href="?id={$data['id']}&tab=bind" style="color: #fff">绑定云·Space账号</a>
                </span>
                {else}
                    <span style="float: right;margin-right: 10px;">
                    <a data-id="{$data['id']}" class="btn btn-danger" href="javascript:;" onclick="ListOperator.unbind_account(this)" style="color: #fff">解除绑定</a>
                </span>
                {/if}
            {/if}
            {if $data['is_admin']}
                <span style="float: right;margin-right: 10px;">
                <a class="btn btn-primary" href="javascript:;" style="color: #fff" onclick="ListOperator.change_receiver(this)">
                    分配负责人
                </a>
            </span>
                {if !$data['is_my'] && empty($_REQUEST['admin_name']) && empty($data['admin_id'])}
                    <span style="float: right;margin-right: 10px;">
                    <a class="btn btn-primary" href="{$route}?action=get&id={$data['id']}" style="color: #fff">领取</a>
                </span>
                {/if}
            {/if}
            <span style="float: right;margin-right: 10px;">
                <a class="btn btn-success" href="?id={$data['id']}&tab=edit" style="color: #fff">修改信息</a>
            </span>

            <div class="form-body">
                <div class="row">
                    <div class="col-md-6">
                        {if $data['account']}
                            <div class="col-md-12">
                                <div class="form-group">
                                    <label class="control-label col-md-4">关联账号</label>

                                    <div class="col-md-8">
                                        <p style="font-size: 14px;" id="online_id">
                                            {$data['account']['username']}{if $data['account_id']}&nbsp;
                                                <span class="label label-info">已绑定</span>
                                            {/if}
                                        </p>
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-12">
                                <div class="form-group">
                                    <label class="control-label col-md-4">状态</label>

                                    <div class="col-md-8">
                                        <p style="font-size: 14px;" id="online_id">
                                            {if $data['account']['identity_time']>0}已实名认证{else}未认证{/if}
                                        </p>
                                    </div>
                                </div>
                            </div>
                        {/if}
                        <div class="col-md-12">
                            <div class="form-group">
                                <label class="control-label col-md-4">姓名</label>

                                <div class="col-md-8">
                                    <p style="font-size: 14px;" id="online_id">
                                        {$data['username']}
                                    </p>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-12">
                            <div class="form-group">
                                <label class="control-label col-md-4">手机号</label>

                                <div class="col-md-8">
                                    <p style="font-size: 14px;">
                                        {if !$data['is_my'] && !$data['is_admin']}****{else}{$data['phone']}{/if}
                                    </p>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-12">
                            <div class="form-group">
                                <label class="control-label col-md-4">业务类型</label>

                                <div class="col-md-8">
                                    <p style="font-size: 14px;">
                                        {$data['business']}
                                    </p>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-12">
                            <div class="form-group">
                                <label class="control-label col-md-4">业务子类</label>

                                <div class="col-md-8">
                                    <p style="font-size: 14px;" id="online_message">
                                        {$data['sub_business']}
                                    </p>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </blockquote>
        <ul class="nav nav-tabs">
            <li {if $_REQUEST['tab']==1} class="active"{/if}>
                <a href="?id={$data['id']}&tab=1">联系记录</a>
            </li>
            {if $data['is_my']||$data['is_admin']}
                <li {if $_REQUEST['tab']==3} class="active"{/if}>
                    <a href="?id={$data['id']}&phone={$data['phone']}&tab=3">需求详情</a>
                </li>
            {/if}
            <li {if $_REQUEST['tab']==2} class="active"{/if}>
                <a href="?id={$data['id']}&tab=2">其他信息</a>
            </li>
        </ul>
        <div data-pid class="modal" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                        <h4 class="modal-title" id="myModalLabel">
                            更换【{$data['username']}】的领取人</h4>
                    </div>
                    <div class="modal-body">
                        <div class="col-sm-12 input-group">
                            <div class="col-sm-12 select">
                                <input type="hidden" id="select2_change" class="form-control select2" name="admin_id">
                                <input type="hidden" id="contact_id" value="{$data['id']}">
                                <input type="hidden" id="is_urgent" value="{$is_urgent}">
                                {*<input type="hidden" id="prev_admin_id" class="form-control select2" name=prev_admin_id" value="{$data['admin_id']}">*}
                            </div>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-default" data-dismiss="modal">
                            取消
                        </button>
                        <button type="button" class="btn btn-success" id="change_receiver_button">
                            确定
                        </button>
                    </div>
                </div>
            </div>
        </div>
        <div class="tab-content clearfix">
            {if $_REQUEST['tab']==2}
                {include file="contacts/contact_detail_tab2.tpl"}
            {elseif $_REQUEST['tab']==3}
                {if $_REQUEST['demand_id']}
                    {include file="demands/demand_recommend/tab_demand_recommend.tpl"}
                {else}
                    {include file="demands/contact_detail_tab3.tpl"}
                {/if}
            {elseif $_REQUEST['tab']=='edit'&&($data['is_my']||$data['is_admin'])}
                {include file="contacts/contact_detail_tab_edit.tpl"}
            {elseif $_REQUEST['tab']=='bind'&&($data['is_my']||$data['is_admin'])}
                {include file="contacts/contact_detail_tab_bind.tpl"}
            {else}
                {include file="contacts/contact_detail_tab1.tpl"}
            {/if}
        </div>
    </div>
</div>
<script>
    $(document).ready(function () {
        //弹框
        ListOperator = {
            change_receiver: function (obj) {
                $('#myModal').modal('show');
            },
            unbind_account: function (obj) {
                var contact_id = $(obj).attr('data-id');
                $.post('?action=unbind_account', {
                    contact_id: contact_id
                }, function (data) {
                    if (data != 'success') {
                        alert('解除绑定失败！！');
                    } else {
                        window.location.reload();
                    }
                })
            }
        }
//    });
        $('#change_receiver_button').click(function () {
            $.post('?action=ajax_change_receiver', {
                admin_id: $("#select2_change").val(),
                is_urgent: $("#is_urgent").val(),
                contact_id: $("#contact_id").val(),
                id: {$data['id']}
            }, function (data) {
                console.log(data);
                if (data.status == 1) {
                    $('#myModal').modal('hide');
                    window.location.reload();
                } else {
                    alert(data.msg);
                }
            }, 'json')
        });
        //更换管理员列表
        $("#select2_change").select2({
            placeholder: "选择管理员",
            minimumInputLength: 1,
            ajax: { // instead of writing the function to execute the request we use Select2's convenient helper
                url: "?action=ajax_admin_json",
                dataType: 'json',
                data: function (term, page) {
                    return {
                        q: term, // search term
                        page_limit: 10,
                        id:{$data['id']}
                    };
                },
                results: function (data, page) { // parse the results into the format expected by Select2.
                    // since we are using custom formatting functions we do not need to alter remote JSON data
                    return {
                        results: data.items
                    };
                }
            },
            initSelection: function (element, callback) {
                var id = $(element).val();
                if (id !== "") {
                    $.ajax("?action=ajax_admin_json", {
                        data: {
                            id: id
                        },
                        dataType: "json"
                    }).done(function (data) {
                        console.log(data);
                        callback(data.items[0]);
                    });
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
            return repo.full_name;
        }

        function formatRepoSelection(repo) {
            return repo.full_name || repo.text;
        }

    })

</script>
</body>
<!-- END BODY -->
</html>