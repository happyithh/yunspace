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
    <script src="{$_assets}plugins/jquery-1.11.0.min.js"
            type="text/javascript"></script>
    <script type="text/javascript" src="{$_assets}plugins/select2/select2.min.js"></script>

</head>
<!-- END HEAD -->
<!-- BEGIN BODY -->

<body style="background:#FaFaFa !important">

<div class="portlet tabbable">
    <div class="portlet-title">
        <div class="caption">
            <i class="fa fa-database"></i>场地百科审核信息
        </div>
    </div>
    <div class="portlet-body form-horizontal">
        <div class="portlet-tabs">
            <div class="tabbable">
                <div class="tab-content clearfix">
                    <table class="table table-striped table-bordered table-hover" id="data_table"
                           style="word-break: break-all">
                        <tbody >
                        <tr>
                            <th style="width:7%">百科ID</th>
                            <td>#{$_data['id']}</td>
                        </tr>
                        <tr>
                            <th>百科名称</th>
                            <td>{$_data['space_name']}</td>
                        </tr>
                        <tr>
                            <th>百科别名</th>
                            <td>{$_data['nickname']}</td>
                        </tr>
                        <tr>
                            <th>城市</th>
                            <td>{$_data['city']}</td>
                        </tr>
                        <tr>
                            <th>地址</th>
                            <td>{$_data['addr']}</td>
                        </tr>
                        <tr>
                            <th>类型</th>
                            <td>{$category_info[$_data['category_id']]["name"]}</td>
                        </tr>
                        <tr>
                            <th>PC-Banner</th>
                            <td><img width="100" height="100" src="{$_data['logo']}"></td>
                        </tr>
                        <tr>
                            <th>移动-Banner</th>
                            <td><img width="100" height="100" src="{$_data['mobile_logo']}"></td>
                        </tr>
                        </tbody>
                    </table>
                    <div class="form-body" style="min-height: 350px;">
                        <form class="form-horizontal" role="form" action="?" method="post">
                            <input type="hidden" name="action" value="refuse">
                            <input type="hidden" name="history_id" value="{$_REQUEST['history_id']}">
                            <input type="hidden" name="month" value="{$month}">
                            <div class="form-group">
                                <label class="col-md-3 control-label"><strong>请输入拒绝理由:</strong></label>
                                <div class="col-md-9">
                                    <input type="text" placeholder="请输入拒绝原因" class="form-control input-sm select2 tags_select2" value="" name="reason"   data-values="{implode(',',$rejectreason)}" id="refuseReason">
                                </div>
                            </div>
                            <div class="form-group">
                                <div class="form-actions text-center">
                                    <a href="?action=pass&history_id={$_REQUEST['history_id']}&status=1&month={$month}" class="btn btn-success">通过并上线</a>
                                    <a href="?action=pass&history_id={$_REQUEST['history_id']}&month={$month}" class="btn btn-primary">通过</a>
                                    <button type="submit" class="btn btn-danger">拒绝</button>
                                </div>
                            </div>
                        </form>
                    </div>

                </div>
            </div>
        </div>
    </div>
</div>








<!-- BEGIN JAVASCRIPTS(Load javascripts at bottom, this will reduce page load time) -->
<!-- BEGIN CORE PLUGINS -->


<script>
    $(".tags_attr").each(function () {
        $(this).select2({
            tags: $(this).data('values').split(',')
        })
    });

    $("#select2_sample6").select2({
        placeholder: "选择供应商",
        minimumInputLength: 1,
        ajax: { // instead of writing the function to execute the request we use Select2's convenient helper
            url:"http://{Core::$urls['host']}/static/api/vendor/auto/complete.jsonp",
            data: function (term, page) {
                return {
                    q: term, // search term
                    page_limit: 10
                };
            },
            dataType: 'json',
            results: function (data, page) { // parse the results into the format expected by Select2.
                // since we are using custom formatting functions we do not need to alter remote JSON data
                return {
                    results: data.data.items
                };
            }
        },
        initSelection: function (element, callback) {
            var id = $(element).val();
            if (id !== "") {
                $.ajax("http://{Core::$urls['host']}/static/api/vendor/auto/complete.jsonp", {
                    data: {
                        id: id
                    },
                    dataType: "json"
                }).done(function (data) {
                            console.log(data);
                            callback(data.data.items[0]);
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

</script>
</body>
<!-- END BODY -->
</html>