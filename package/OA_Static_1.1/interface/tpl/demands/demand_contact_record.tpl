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
    <div class="portlet-body">
        <ul class="nav nav-tabs">
            <li {if $_REQUEST['tab']==1 || !$_REQUEST['tab']} class="active"{/if}>
                <a href="?action=demand_contact_record&contact_id={$_REQUEST['contact_id']}&tab=1">联系记录</a>
            </li>
            <li {if $_REQUEST['tab']==2} class="active"{/if}>
                <a href="?action=demand_contact_record&contact_id={$_REQUEST['contact_id']}&demand_id={$_REQUEST['demand_id']}&tab=2">消息记录</a>
            </li>
        </ul>
        <div class="tab-content clearfix">
            {if $_REQUEST['tab']==1 || !$_REQUEST['tab']}
                {include file="OA_Static::demands/inc/contact_record_tab1.tpl"}
            {elseif $_REQUEST['tab']==2}
                {include file="OA_Static::demands/inc/contact_record_tab2.tpl"}
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