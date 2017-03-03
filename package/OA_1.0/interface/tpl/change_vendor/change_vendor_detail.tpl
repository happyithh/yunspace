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

<body style="background:#FaFaFa !important">
<div class="portlet">
    <div class="portlet-title">
        <div class="caption">
            <i class="fa fa-reorder"></i>
            {if $vendor}
                账户更改供应商信息
            {else}
                账户添加供应商信息
            {/if}
        </div>
    </div>
    <div class="portlet-body">
        <div class="tab-content clearfix">
            <div class="tab-pane fade active in" id="tab_1_1">
                {if $vendor}
                <h3 >原供应商信息</h3>
                    <table class="table table-striped table-bordered table-advance">
                        <tbody>
                        <tr>
                            <td style="width: 15%;">
                                <div class="information_left">
                                    供应商名称
                                </div>
                            </td>
                            <td>
                                <div class="hidden-xs" style="padding-left: 90px;">
                                    {$vendor['vendor_name']}
                                </div>
                            </td>
                        </tr>
                        {foreach $vendor['base_info'] as $k=>$v}
                            {if $v}
                                <tr>
                                    <td>
                                        <div class="information_left">
                                            {$k}
                                        </div>
                                    </td>
                                    <td>
                                        <div class="hidden-xs" style="padding-left: 90px;">
                                            {$v}
                                        </div>
                                    </td>
                                </tr>
                            {/if}
                        {/foreach}
                        {foreach $vendor['attr'] as $k=>$v}
                            {if $v}
                                <tr>
                                    <td>
                                        <div class="information_left">
                                            {$k}
                                        </div>
                                    </td>
                                    <td>
                                        <div class="hidden-xs" style="padding-left: 90px;">
                                            {$v}
                                        </div>
                                    </td>
                                </tr>
                            {/if}
                        {/foreach}
                        {if $vendor['des']}
                        <tr>
                            <td>
                                <div class="information_left">
                                    供应商描述
                                </div>
                            </td>
                            <td>
                                <div class="hidden-xs" style="padding-left: 90px;">
                                    {$vendor['des']}
                                </div>
                            </td>
                        </tr>
                        {/if}
                        {if $vendor['logo']}
                        <tr>
                            <td>
                                <div class="information_left">
                                    LOGO
                                </div>
                            </td>
                            <td>
                                <div class="hidden-xs" style="padding-left: 90px;">
                                    <img src="{$vendor['logo']}" width="100" height="100" >
                                </div>
                            </td>
                        </tr>
                        {/if}
                        </tbody>
                    </table>
                <hr>
                {/if}
                <h3 >新供应商信息</h3>
                <table class="table table-striped table-bordered table-advance">
                <tbody>
                <tr>
                    <td style="width: 15%;">
                        <div class="information_left">
                            供应商名称
                        </div>
                    </td>
                    <td>
                        <div class="hidden-xs" style="padding-left: 90px;">
                           {$change['vendor_name']}
                        </div>
                    </td>
                </tr>
                {foreach $change['base_info'] as $k=>$v}
                    {if $v}
                        <tr>
                            <td>
                                <div class="information_left">
                                    {$k}
                                </div>
                            </td>
                            <td>
                                <div class="hidden-xs" style="padding-left: 90px;">
                                    {$v}
                                </div>
                            </td>
                        </tr>
                {/if}
                {/foreach}
                {foreach $change['attr'] as $k=>$v}
                {if $v}
                    <tr>
                        <td>
                            <div class="information_left">
                                {$k}
                            </div>
                        </td>
                        <td>
                            <div class="hidden-xs" style="padding-left: 90px;">
                                {$v}
                            </div>
                        </td>
                    </tr>
                {/if}
                {/foreach}
                {if $change['des']}
                <tr>
                    <td>
                        <div class="information_left">
                            供应商描述
                        </div>
                    </td>
                    <td>
                        <div class="hidden-xs" style="padding-left: 90px;">
                            {$change['des']}
                        </div>
                    </td>
                </tr>
                {/if}
                {if $change['logo']}
                <tr>
                    <td>
                        <div class="information_left">
                            LOGO
                        </div>
                    </td>
                    <td>
                        <div class="hidden-xs" style="padding-left: 90px;">
                            <img src="{$change['logo']}" width="100" height="100" >
                        </div>
                    </td>
                </tr>
                {/if}
                </tbody>
                </table>
                <hr/>
                <div class="table-responsive clearfix">
                <form class="form-horizontal" action="?action=refuse&change_id={$change['id']}" method="post">
                    <div class="col-md-12">
                        <div class="form-group">
                            <label class="control-label col-sm-3" style="text-align: left">请输入拒绝理由</label>

                            <div class="col-sm-9">
                                <textarea id="refuseReason" name="refuse_reason" class="form-control" rows="3"></textarea>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-12">
                        <div class="form-group">
                            <div  style="padding-left: 30%;">
                                <a data-toggle="modal" href="#vendor" class="btn btn-info">绑定到已有供应商</a>
                                <a data-toggle="modal" href="#category" class="btn btn-primary" style="margin-left: 30px;" class="btn btn-primary">创建新的供应商</a>
                                <button type="submit" class="btn btn-danger" style="margin-left: 30px;">拒绝</button>
                            </div>
                        </div>
                    </div>
                </form>
                </div>
            </div>

        </div>
    </div>
</div>
{*绑定到原有供应商弹出层*}
<div class="modal fade" id="vendor" tabindex="-1" role="basic" aria-hidden="true" style="display: none;">
    <div class="modal-dialog">
        <div class="modal-content">
            <form action="?" method="post">
                <input type="hidden" name="action" value="bind_old"/>
                <input type="hidden" name="change_id" value="{$change['id']}"/>
                <input type="hidden" name="account_id" value="{$change['account_id']}"/>
                <input type="hidden" name="old_vendor_id" value="{$change['old_vendor_id']}"/>
                <div class="modal-body">
                    <table class="table" id="list_info">
                        <thead>
                        <th width="150">绑定到已有供应商</th>
                        </thead>
                        <tr>
                            <td>
                                <label>选择已有供应商</label>
                            </td>
                            <td>
                                <input type="hidden" id="select2_vendor" class="form-control" name="vendor_id">
                            </td>
                        </tr>
                    </table>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                    <button type="submit" class="btn btn-info">提交</button>
                </div>
        </div>
        </form>
    </div>
</div>
{*创建新的供应商选择分类*}
<div class="modal fade" id="category" tabindex="-1" role="basic" aria-hidden="true" style="display: none;">
    <div class="modal-dialog">
        <div class="modal-content">
            <form action="?" method="post">
                <input type="hidden" name="action" value="add_new"/>
                <input type="hidden" name="change_id" value="{$change['id']}"/>
                <div class="modal-body">
                    <table class="table" id="list_info">
                        <thead>
                        <th width="150">选择供应商分类</th>
                        </thead>
                        <tr>
                            <td>
                                <label>选择已有供应商</label>
                            </td>
                            <td>
                                <select multiple="multiple" class="multi-select" name="categories_id[]" id="change_vendor_multi" data-placeholder="Select...">
                                    {function show_category level=0}
                                        {foreach $_categories[$id] as $k=>$v}
                                            {if $v}
                                                <option value="{$k}">{str_repeat(' . . ', $lv)}
                                                    {$v}
                                                </option>
                                            {/if}
                                            {if $_categories[$k]}
                                                {show_category data=$_categories id=$k lv=$lv+1}
                                            {/if}
                                        {/foreach}
                                    {/function}
                                    {show_category data=$_categories id=0 lv=1}
                                </select>
                            </td>
                        </tr>
                    </table>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                    <button type="submit" class="btn btn-info">提交</button>
                </div>
        </div>
        </form>
    </div>
</div>
</body>
<script src="{$_assets}plugins/jquery-1.11.0.min.js" type="text/javascript"></script>
<script src="{$_assets}plugins/jquery-ui/jquery-ui-1.10.3.custom.min.js" type="text/javascript"></script>
<script src="{$_assets}plugins/bootstrap/js/bootstrap.min.js" type="text/javascript"></script>
<script type="text/javascript" src="{$_assets}plugins/select2/select2.min.js"></script>
<link rel="stylesheet" type="text/css" href="{$_assets}plugins/jquery-multi-select/css/multi-select.css"/>
<script type="text/javascript" src="{$_assets}plugins/jquery-multi-select/js/jquery.multi-select.js"></script>

<script>
    $('#change_vendor_multi').multiSelect({
        selectableOptgroup: true
    });
    $("#select2_vendor").select2({
        placeholder: "选择供应商",
        minimumInputLength: 1,
        ajax: { // instead of writing the function to execute the request we use Select2's convenient helper
            url: "?action=vendor_auto_complete",
            dataType: 'json',
            data: function (term, page) {
                return {
                    q: term, // search term
                    page_limit: 10
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
                $.ajax("?action=vendor_auto_complete", {
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

</script>
<!-- END BODY -->
</html>