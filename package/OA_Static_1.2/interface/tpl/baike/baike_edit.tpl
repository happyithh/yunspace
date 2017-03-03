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
    {include "OA_Static::public_css/public_css.tpl"}
    <link rel="stylesheet" type="text/css" href="{$_assets}plugins/bootstrap-fileinput/bootstrap-fileinput.css"/>
    <script src="{$_assets}plugins/jquery-1.11.0.min.js" type="text/javascript"></script>
    <script type="text/javascript" src="{$_assets}plugins/bootstrap-fileinput/bootstrap-fileinput.js"></script>
    <script type="text/javascript" src="{$_assets}plugins/select2/select2.min.js"></script>
</head>
<!-- END HEAD -->
<!-- BEGIN BODY -->

<body style="background:#FaFaFa !important">
<div class="portlet tabbable">
<div class="portlet-title">
    <div class="caption">
        <i class="fa fa-database" ></i>场地百科信息修改
        {if $data_edit['object_id']}
            <p style="color:#bd362f;margin-left: 30px;float: right;">(表单内容默认显示下面列表中的第一条，如有需要可点击【查看】切换)</p>
        {/if}
    </div>
</div>
<div class="portlet-body" style="padding:10px 10px">
<div class="form-body" style="min-height: 350px;">
{if $_data}
    <table class="table-list-h" cellpadding="0" cellspacing="0">
        <tr>
            <th width="10%">id</th>
            <th width="30%">百科名称</th>
            <th width="15%">修改时间</th>
            <th width="30%">状态</th>
            <th width="15%">操作</th>
        </tr>

        {foreach $_data as $k => $v}
            <tr>
                <td>{$v['id']}</td>
                <td>{$v['data_backup']['space_name']}</td>
                <td>{date('Y-m-d H:i:s',$v['create_time'] )}</td>
                <td>
                    {$status[$v['status']]}

                    {if $v['status']==2}
                        <div style="color: #f3565d;">【拒绝原因】:{$v['refuse_reason']}</div>
                    {/if}
                </td>
                <td>
                    {if $_REQUEST['history_id']== $v['id'] || empty( $_REQUEST['history_id'])}
                        <button class="btn btn-success btn-xs" disabled>查看</button>
                    {else}
                        <a class="btn btn-primary btn-xs" href="?action=detail&space_id={$v['object_id']}&tab_action=edit_space&tab=2&history_id={$v['id']}">查看</a>
                    {/if}
                </td>
            </tr>
        {/foreach}
    </table>
    <style>
        .table-list-h{
            border: 1px solid #ddd;
            border-left: none;
            width: 100%;
            max-width: 1000px;
            margin: 0 auto 15px;
        }
        .table-list-h th{
            text-align: center;
            padding: 5px 0;
            border-left: 1px solid #ddd;
        }
        .table-list-h td{
            text-align: center;
            padding: 5px 0;
            border-top: 1px solid #ddd;
            border-left:1px solid #ddd;
        }
    </style>
{/if}

<form class="form-horizontal" role="form" action="?" method="post" enctype="multipart/form-data">
    <input type="hidden" name="space_id" value="{$_REQUEST['space_id']}">
    <input type="hidden" name="action" value="edit_submit">
    {if $data_edit['object_id']} <input type="hidden" name="data[space_name]" value="{$data_edit['data_backup']['space_name']}">{/if}
    <div class="row">
        <div class="col-md-6">
            <div class="form-group">
                <label class="control-label col-md-2">场地百科名称<span class="required" aria-required="true">*</span></label>

                <div class="col-md-10">
                    <input type="text" {*{if $data_edit['object_id']} disabled {/if}*}  class="form-control" placeholder="请输入场地百科名称" name="data[space_name]" value="{$data_edit['data_backup']['space_name']}">
                    <input type="hidden" class="form-control" name="data[category_id]" value="{$category_id}">
                </div>
            </div>
        </div>
        <div class="col-md-6">
            <div class="form-group">
                <label class="control-label col-md-2">百科别名</label>

                <div class="col-md-10">
                    <input type="text" class="form-control" placeholder="请输入场地百科别名" name="data[nickname]" value="{$data_edit['data_backup']['nickname']}">
                </div>
            </div>
        </div>
        <div class="col-md-6">
            <div class="form-group">
                <label class="control-label col-md-2">所属供应商<span class="required" aria-required="true">*</span></label>

                <div class="col-md-10">
                    <input id="select2_sample6" type="hidden" class="form-control select2" name="data[vendor_id]" value="{$data_edit['data_backup']['vendor_id']}">
                </div>
            </div>
        </div>
        <div class="col-md-6">
            <div class="form-group">
                <label class="control-label col-md-2">营销标题</label>

                <div class="col-md-10">
                    <input type="text" class="form-control" name="data[attr][营销标题]" value="{$data_edit['data_backup']['attr']['营销标题']}">
                </div>
            </div>
        </div>
        <div class="col-md-6">
            <div class="form-group">
                <label class="control-label col-md-2">特色标签</label>

                <div class="col-md-10">
                    <input type="hidden" class="form-control select2 select2_special_tags" name="data[attr][特色标签]" data-values="{$data_edit['data_backup']['attr']['特色标签']}" value="{$data_edit['data_backup']['attr']['特色标签']}">
                </div>
            </div>
        </div>
        <div class="col-md-6">
            <div class="form-group">
                <label class="control-label col-md-2">场地地址</label>

                <div class="col-md-10">
                    <input type="text" class="form-control" name="data[addr]" value="{$data_edit['data_backup']['addr']}">
                </div>
            </div>
        </div>
        {if !$_tags_info}
            <div class="col-md-6">
                <div class="form-group">
                    <label class="control-label col-md-2">城市<span class="required" aria-required="true">*</span></label>

                    <div class="col-md-10">
                        <input type="text" class="form-control" name="data[attr][46]" value="{$data_edit['data_backup']['attr'][46]}">
                    </div>
                </div>
            </div>
        {/if}
        {*<div class="col-md-6">*}
        {*<div class="form-group">*}
        {*<label class="control-label col-md-2">场地等级</label>*}

        {*<div class="col-md-10">*}
        {*{foreach $level as $k=>$v}*}
        {*<label class="radio-inline">*}
        {*<input type="radio" name="data[level]" value="{$v}" {if $data_edit['data_backup']['level']=={$v}}checked="checked" {/if}>*}
        {*{$k}*}
        {*</label>*}
        {*{/foreach}*}
        {*</div>*}
        {*</div>*}
        {*</div>*}
        <div class="col-md-12">
            <div class="form-group">
                <label class="control-label col-md-1">场地描述<span class="required" aria-required="true">*</span></label>
                <div class="col-md-11">
                    {include "Admin::inc/html_umeditor.tpl" name="data[des]" value=$data_edit['data_backup']['des'] height=200}
                </div>
            </div>
        </div>
        {if $_tags_info}
            <div class="col-md-12">
                {foreach $_tags_info as $key=>$value}
                    <div class="form-group">
                        <label class="control-label col-md-1">{$key}</label>

                        <div class="col-md-11">
                            {foreach $value as $ik=>$iv}
                                <div class="input-group">
                        <span class="input-group-addon">
                            {if $iv['tags_name'] == '城市'}
                                <span style="color:#C63300">*</span>
                            {/if}
                            {$iv['tags_name']}:
                        </span>
                                    <input type="text" class="form-control select2 tags_attr" name="data[attr][{$ik}]"   value="{$data_edit['data_backup']['attr'][{$ik}]}" data-values="{implode(',',$iv['tags_value'])}">
                                </div>
                            {/foreach}
                        </div>
                    </div>
                {/foreach}
            </div>
        {/if}

        <div class="col-md-12">
            <div class="form-group">
                <label class="control-label col-md-1">百科banner</label>
                <div class="col-md-4">
                    <div class="fileinput fileinput-new" data-provides="fileinput">
                        <div class="fileinput-new thumbnail" style="width: 200px; height: 150px;">
                            {if $data_edit['data_backup']['logo']}
                                <img class="logo_src" src="{$data_edit['data_backup']['logo']}" alt=""/>
                            {else}
                                <img src="http://www.placehold.it/200x150/EFEFEF/AAAAAA&amp;text=no+image"
                                     alt=""/>
                            {/if}
                        </div>
                        <div class="fileinput-preview fileinput-exists thumbnail"style="max-width: 200px; max-height: 150px;"></div>
                        <div>
                            <span class="btn btn-default btn-file">
                                <span class="fileinput-new">选择PC端图片</span>
                                <span class="fileinput-exists">重新选择</span>
                                <input type="file" name="百科banner" accept="image/jpeg,image/png,image/gif">
                                <input type="hidden" name="data[logo]"  class="logo" value="{$data_edit['data_backup']['logo']}">
                            </span>
                            {if $data_edit['data_backup']['logo']}
                                <a href="javascript:;" class="btn btn-danger remove_logo">移除</a>
                            {else}
                                <a href="form_component.html#" class="btn btn-danger fileinput-exists" data-dismiss="fileinput">移除</a>
                            {/if}
                        </div>
                    </div>
                    <span class="required" aria-required="true" style="color: #e02222">（*请上传尺寸为1920*520的图片）</span>
                </div>

                <div class="col-md-4">
                    <div class="fileinput fileinput-new" data-provides="fileinput">
                        <div class="fileinput-new thumbnail" style="width: 200px; height: 150px;">
                            {if $data_edit['data_backup']['mobile_logo']}
                                <img class="mobile_logo_src" src="{$data_edit['data_backup']['mobile_logo']}" alt=""/>
                            {else}
                                <img src="http://www.placehold.it/200x150/EFEFEF/AAAAAA&amp;text=no+image"
                                     alt=""/>
                            {/if}
                        </div>
                        <div class="fileinput-preview fileinput-exists thumbnail" style="max-width: 200px; max-height: 150px;"></div>
                        <div>
                            <span class="btn btn-default btn-file">
                                <span class="fileinput-new">选择移动端图片</span>
                                <span class="fileinput-exists">重新选择</span>
                                <input type="file" name="百科移动端banner" accept="image/jpeg,image/png,image/gif">
                                <input type="hidden" name="data[mobile_logo]" class="mobile_logo" value="{$data_edit['data_backup']['mobile_logo']}">
                            </span>
                            {if $data_edit['data_backup']['mobile_logo']}
                                <a href="javascript:;" class="btn btn-danger remove_mobile_logo">移除</a>
                            {else}
                                <a href="form_component.html#" class="btn btn-danger fileinput-exists"
                                   data-dismiss="fileinput">移除</a>
                            {/if}
                        </div>
                    </div>
                    {*<span class="required" aria-required="true" style="color: #e02222">（*请上传尺寸为1920*520的图片）*}
                    {*</span>*}
                </div>
            </div>
        </div>
        <div class="col-md-12">
            <div class="form-group">
                <label class="control-label col-md-1">场地图片</label>

                <div class="col-md-11">
                    {include file="OA_Static::spacepedia/inc/public_upload.tpl"}
                </div>
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
</div>
</div>

<script>
    $(".tags_attr").each(function () {
        $(this).select2({
            tags: $(this).data('values').split(',')
        })
    });
    $('.select2_special_tags').each(function(){
        $(this).select2({
            tags: $(this).data('values').split(',')
        })
    });

    //移除logo
    $(".remove_logo").click(function(){
        $(".logo").val("");
        $(".logo_src").attr("src",'http://www.placehold.it/200x150/EFEFEF/AAAAAA&amp;text=no+image');
    });
    //移除移动端logo
    $(".remove_mobile_logo").click(function(){
        $(".mobile_logo").val("");
        $(".mobile_logo_src").attr("src",'http://www.placehold.it/200x150/EFEFEF/AAAAAA&amp;text=no+image');
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