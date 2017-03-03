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
    <!-- IMPORTANT! Load jquery-ui-1.10.3.custom.min.js before bootstrap.min.js to fix bootstrap tooltip conflict with jquery ui tooltip -->
    <script src="{$_assets}plugins/jquery-1.11.0.min.js" type="text/javascript"></script>
    <script src="{$_assets}plugins/jquery-ui/jquery-ui-1.10.3.custom.min.js" type="text/javascript"></script>
    <script src="{$_assets}plugins/bootstrap/js/bootstrap.min.js" type="text/javascript"></script>
    <script src="{$_assets}plugins/bootstrap-hover-dropdown/bootstrap-hover-dropdown.min.js" type="text/javascript"></script>
    <script src="{$_assets}plugins/jquery-slimscroll/jquery.slimscroll.min.js" type="text/javascript"></script>
    <script src="{$_assets}plugins/jquery.blockui.min.js" type="text/javascript"></script>
    <script src="{$_assets}plugins/uniform/jquery.uniform.min.js" type="text/javascript"></script>
    <!-- END CORE PLUGINS -->
    <!-- BEGIN PAGE LEVEL PLUGINS -->
    <script type="text/javascript"
            src="{$_assets}plugins/select2/select2.min.js"></script>
    <script type="text/javascript"
            src="{$_assets}plugins/datatables/media/js/jquery.dataTables.min.js"></script>
    <script type="text/javascript"
            src="{$_assets}plugins/datatables/plugins/bootstrap/dataTables.bootstrap.js"></script>

</head>
<!-- END HEAD -->
<!-- BEGIN BODY -->
<body style="background:#FaFaFa !important">
    <input type="hidden" name="product_id" value="{$_REQUEST['id']}">
    <input type="hidden" name="action" value="{$_REQUEST['action']}">
    {*<input type="hidden" name="is_submit" value="1">*}
    <input type="hidden" name="tab" value="{$_REQUEST['tab']}">
    <input type="hidden" name="id" value="{$account_id['vendor_account_id']}">
    <input type="hidden" name="supplier_id" value="{$_data['vendor_id']}">
    <input type="hidden" id="data-pid1" value="{$_data['id']}">
<div class="portlet tabbable">
<div class="portlet-title">
    <div class="caption">
        <i class="fa fa-database"></i>服务详情
    </div>
</div>
<form class="form-horizontal" role="form" action="?" method="post">
<div>
    <div class="portlet-body form">
        {if $_data['update_status']==2}<span class="btn btn-warning btn-xs">产品信息审核中...</span>{/if}
        <input type="hidden" name="list_type" value="product">
        <input type="hidden" name="is_submit" value="1">
        <input type="hidden" name="product_id" value="{$_data['id']}">
        <div class="form-body">
            <div class="row">
                <div class="col-md-6">
                    <div class="form-group">
                        <label class="control-label col-md-2">服务名称</label>

                        <div class="col-md-10">
                            <input type="text" class="form-control" placeholder="Title" name="data[product_name]" value="{$_data['product_name']}">
                        </div>
                    </div>
                </div>
                <div class="col-md-6">
                    <div class="form-group">
                        <label class="control-label col-md-2">所属供应商</label>

                        <div class="col-md-10">
                            <div class="col-md-12 input-group select">
                                <input id="select2_sample6" type="hidden" class="form-control select2" name="data[vendor_id]" value="{$_data['vendor_id']}">
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-md-6">
                    <div class="form-group">
                        <label class="control-label col-md-2">价格</label>

                        <div class="col-md-10">
                            <div class="input-group">
                                <input id="price" type="text" class="form-control" placeholder="Price" name="data[price]" value="{abs($_data['price'])}">
                                {*<span class="input-group-addon">元/天</span>*}
                                 <span class="input-group-addon">
                                    <input type="checkbox" name="data[attr_new][起价]" value="1" {if $_data['attr_new']['起价']}checked{/if}> 起价
                                </span>
                                  <span class="input-group-addon">
                                    <input type="checkbox" name="hide_price" value="1" {if $_data['price']<0}checked{/if}> 隐藏
                                  </span>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-md-6">
                    <div class="form-group">
                        <label class="control-label col-md-2">计价单位</label>

                        <div class="col-md-10">
                            <div class="input-group col-md-12">
                                <input type="text" class="form-control" name="data[attr_new][计价单位]" placeholder="不填写默认为一口价"
                                       value="{$_data['attr_new']['计价单位']}">                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-md-6">
                    <div class="form-group">
                        <label class="control-label col-md-2">计价上限/下限</label>

                        <div class="col-md-10">
                            <div class="input-group input-range">
                                <input  type="text" class="form-control" name="data[attr_new][计价下限]" placeholder="计价下限"
                                        value="{$_data['attr_new']['计价下限']}">
                                <span class="input-group-addon">
                                ~</span>
                                <input type="text" class="form-control" name="data[attr_new][计价上限]" placeholder="计价上限"
                                       value="{$_data['attr_new']['计价上限']}">

                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-md-6">
                    <div class="form-group">
                        <label class="control-label col-md-2">地址</label>

                        <div class="col-md-10">
                            <input type="text" class="form-control" name="data[addr]" value="{$_data['addr']}">
                        </div>
                    </div>
                </div>
                <div class="col-md-6">
                    <div class="form-group">
                        <label class="control-label col-md-2">面积</label>

                        <div class="col-md-10">
                            <div class="input-group">
                                <input type="text" class="form-control" name="data[product_size]" value="{$_data['product_size']}">
                                <span class="input-group-addon">平方米</span>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-md-6">
                    <div class="form-group">
                        <label class="control-label col-md-2">搜索排序优先级</label>

                        <div class="col-md-10">
                            {*<label class="radio-inline">*}
                                {*<input type="radio" name="data[order_lv]" value="4" {if $_data['order_lv']==4}checked="checked" {/if}>*}
                                {*高++*}
                            {*</label>*}
                            <label class="radio-inline">
                                <input type="radio" name="data[order_lv]" value="3" {if $_data['order_lv']==3}checked="checked" {/if}>
                                A
                            </label>
                            <label class="radio-inline">
                                <input type="radio" name="data[order_lv]" value="2" {if $_data['order_lv']==2}checked="checked" {/if}>
                                B
                            </label>
                            <label class="radio-inline">
                                <input type="radio" name="data[order_lv]" value="1" {if $_data['order_lv']==1}checked="checked" {/if}>
                                C
                            </label>
                            <label class="radio-inline">
                                <input type="radio" name="data[order_lv]" value="0" {if $_data['order_lv']==0}checked="checked" {/if}>
                                D
                            </label>
                            <label class="radio-inline">
                                <input type="radio" name="data[order_lv]" value="-1" {if $_data['order_lv']==-1}checked="checked" {/if}>
                                E
                            </label>
                            <label class="radio-inline">
                                <input type="radio" name="data[order_lv]" value="-2" {if $_data['order_lv']==-2}checked="checked" {/if}>
                                F
                            </label>
                            <label class="radio-inline">
                                <input type="radio" name="data[order_lv]" value="-3" {if $_data['order_lv']==-3}checked="checked" {/if}>
                                G
                            </label>
                            <label class="radio-inline">
                                <span style="color:#bd362f">(*默认为D)</span>
                            </label>
                        </div>
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="col-md-12">
                    <div class="form-group">
                        <label class="control-label col-md-1">服务描述</label>

                        <div class="col-md-11">
                            {include "Admin::inc/html_umeditor.tpl" name="data[des]" value=$_data['des'] height=200}
                            {*<textarea class="form-control wysihtml5" rows="8" name="data[des]">{$_data['des']}</textarea>*}
                        </div>
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="col-md-12">
                    {foreach $_tags_info as $key=>$value}
                        <div class="form-group">
                            <label class="control-label col-md-1">{$key}</label>

                            <div class="col-md-11">
                                {foreach $value as $ik=>$iv}
                                    <div class="input-group">
                                        <span class="input-group-addon">
                                            {$iv['tags_name']}:
                                        </span>
                                        <input type="text" class="form-control select2 tags_select2" name="data[attr_new][{$ik}]" value="{$_data['attr_new'][{$ik}]}" data-values="{implode(',',$iv['tags_value'])}">
                                    </div>
                                {/foreach}
                            </div>
                        </div>
                    {/foreach}
                </div>
            </div>
        </div>
    </div>
</div>
<div class="portlet-body">
<div class="tabbable tabbable-custom boxless" style="padding: 20px ;">
<ul class="nav nav-tabs">
    <li class="active">
        <a href="form_image_crop.html#tab_2" data-toggle="tab">图片/视频</a>
    </li>
    {*<li>*}
        {*<a href="form_image_crop.html#tab_3" data-toggle="tab">活动案例</a>*}
    {*</li>*}
</ul>
<div class="tab-content">
<!--      ---------------------------图片/视频  start-------------------------------      -->
<div class="tab-pane active" id="tab_2">
    {include file="Admin::inc/plupload.tpl"}
    <script>
        uploader.onFileUploaded = function (file, path) {
            UploadFiles.add(file, path);
        }
        var UploadFiles = {
            media_id: 0,
            add: function (file, path) {
                if (UploadFiles.media_id < 1) {
                    UploadFiles.media_id = $('#upload_files tr').size() + 10;
                }
                UploadFiles.media_id++;
                var newFile = $('#upload_files').parents('table').find('.hidden').clone().removeClass('hidden');
                newFile.find('img').attr('src', path);
                newFile.appendTo('#upload_files');
                newFile.find('input').each(function () {
                    $(this).attr('name', $(this).attr('name').replace('$$', UploadFiles.media_id));
                });
                newFile.find('input:eq(0)').val(path);
                newFile.find('input:eq(1)').val(file.name);
                newFile.find('input:eq(2)').select2({
                    tags: UploadFiles.tags.split(',')
                });
            },
            remove: function (o) {
                $(o).parents('tr').remove();
            },
            up: function (o) {
                var tr = $(o).parents('tr');
                tr.after(tr.prev());
            },
            down: function (o) {
                var tr = $(o).parents('tr');
                tr.before(tr.next());
            },
            tags: '@主图,外景图片,内景图片,平面图,视频'
        };
    </script>
    <style>
        .table td {
            vertical-align: middle !important;
        }

        .table .thumbnail {
            margin-bottom: 0;
        }

        .table td img {
            border-radius: 4px;
        }

        .table .btns i {
            cursor: pointer;
        }

        .table1 td {
            padding: 5px;
        }

            }
    </style>
    <table class="table table-hover">
        <thead>
        <tr>
            <th width="80">缩略图</th>
            <th>名称</th>
            <th width="50%">标签</th>
            <th width="60">操作</th>
        </tr>
        <tr class="hidden">
            <td>
                <img src="" style="height: 80px; width: 80px; display: block;">
            </td>
            <td>
                <input type="hidden" name="data[media][$$][path]">
                <input class="form-control" type="text" name="data[media][$$][name]">
            </td>
            <td>
                <input class="form-control select2" type="text" name="data[media][$$][tags]">
                <input class="form-control" type="text" name="data[media][$$][video]">
            </td>
            <td class="btns">
                <i class="fa fa-long-arrow-up" onclick="UploadFiles.up(this)"></i>
                <i class="fa fa-long-arrow-down" onclick="UploadFiles.down(this)"></i>
                <i class="fa fa-trash-o" onclick="UploadFiles.remove(this)"></i>
            </td>
        </tr>
        </thead>
        <tbody id="upload_files">
        {foreach $_data['media'] as $k=>$v}
            <tr>
                <td>
                    <img src="{$v['path']}" style="height: 80px; width: 80px; ">
                </td>
                <td>
                    <input type="hidden" name="data[media][{$k}][path]" value="{$v['path']}">
                    <input class="form-control" type="text" name="data[media][{$k}][name]" value="{$v['name']}">
                </td>
                <td>
                    <input class="form-control select2 tags_select3 tags_select3_product" type="text" name="data[media][{$k}][tags]" value="{$v['tags']}">
                    <input class="form-control" type="text" name="data[media][{$k}][video]" value="{$v['video']}">
                </td>
                <td class="btns">
                    <i class="fa fa-long-arrow-up" onclick="UploadFiles.up(this)"></i>
                    <i class="fa fa-long-arrow-down" onclick="UploadFiles.down(this)"></i>
                    <i class="fa fa-trash-o" onclick="UploadFiles.remove(this)"></i>
                </td>
            </tr>
        {/foreach}
        </tbody>
    </table>
</div>
    <!-- --------------------------------图片/视频结束------------------------------------   -->
</div>
</div>
</div>
<div class="form-actions text-center">
    <button type="reset" class="btn btn-default">
        重置
    </button>
    <button type="submit" class="btn btn-success">
        提交
    </button>
</div>
</form>
</div>
<script>
    jQuery(document).ready(function () {
        $(".tags_select2").each(function () {
            $(this).select2({
                tags: $(this).data('values').split(',')
            })
        });

        $(".tags_select3_product").each(function () {
            $(this).select2({
                tags: UploadFiles.tags.split(',')
            })
        });
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
    {*//案例*}
    {*EventCaseStatus = {*}
        {*online: function (obj) {*}
            {*var case_id = $(obj).attr('data-eid');*}
            {*var status = $(obj).attr('data-status');*}
            {*var product_id = $('#data-pid1').val();*}
            {*if (status == 0) {*}
                {*var btn_message = '恢复';*}
                {*var online_message = '已删除';*}
                {*var online_message_class = 'btn btn-danger btn-xs';*}
                {*var online_status = 1;*}
                {*var online_class = 'btn btn-success btn-xs';*}
            {*} else if (status == 1) {*}
                {*var btn_message = '删除';*}
                {*var online_message = '已上线';*}
                {*var online_message_class = 'btn btn-success btn-xs';*}
                {*var online_status = 0;*}
                {*var online_class = 'btn btn-danger btn-xs';*}
            {*}*}
            {*$.post('{$_home}marketing/department_vendor?', {*}
                {*case_id: case_id,*}
                {*case_online: status,*}
                {*tab: 'product',*}
                {*id:{$account_id['vendor_account_id']},*}
                {*product_id: product_id,*}
                {*action: 'detail'*}

            {*}, function (data) {*}
{*//                console.log(data)*}
                {*if (data != 'success') {*}
                    {*alert('操作失败,可能是网络异常,请稍候再试!');*}
                {*} else {*}
                    {*$(obj).text(btn_message);*}
                    {*$(obj).removeClass().addClass(online_class);*}
                    {*$(obj).parents('tr').find('td').eq(3).find('.online_message span').removeClass().addClass(online_message_class);*}
                    {*$(obj).parents('tr').find('td').eq(3).find('.online_message span').text(online_message);*}
                    {*$(obj).attr('data-status', online_status);*}
                {*}*}
            {*})*}
        {*}*}
    {*}*}
    function addCaseUrl() {
        if (confirm('您确定将本页修改的数据已经保存？现在将要去添加案例？')) {
            location.href = "{$_home}marketing/department_vendor?action=detail&tab=product&id={$account_id['vendor_account_id']|default:415}&handle_type=case&product_id={$_REQUEST['id']}";
        }
    }
</script>
</body>
<!-- END BODY -->
</html>