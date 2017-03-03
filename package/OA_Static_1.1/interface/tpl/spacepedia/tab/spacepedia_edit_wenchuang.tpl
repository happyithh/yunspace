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
        .win_record tbody tr td{
            padding:10px;
            margin: 10px;
        }
        .win_record tbody tr {
            display:block;
            margin: 2px 0;
        }
    </style>
{/if}

<form class="form-horizontal" role="form" action="?" method="post" enctype="multipart/form-data">
<input type="hidden" name="space_id" value="{$_REQUEST['space_id']}">
<input type="hidden" name="action" value="{$_REQUEST['action']}">
<input type="hidden" name="tab_action" value="submit_spacepedia">
<input type="hidden" name="tab" value="">
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
        <label class="control-label col-md-2">所属供应商</label>

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
        <label class="control-label col-md-2">故事起源</label>

        <div class="col-md-10">
            <textarea type="text" class="form-control" name="data[wenchuang_attr][故事起源]">{$data_edit['data_backup']['wenchuang_attr']['故事起源']}</textarea>
        </div>
    </div>
</div>
{*<div class="col-md-6">*}
    {*<div class="form-group">*}
        {*<label class="control-label col-md-2">故事类型</label>*}

        {*<div class="col-md-10">*}
            {*<input id="select2_sample6" type="text" class="form-control select2" name="data[wenchuang_attr][故事类型]" value="{$data_edit['data_backup']['wenchuang_attr']['故事类型']}">*}
        {*</div>*}
    {*</div>*}
{*</div>*}
<div class="col-md-6">
    <div class="form-group">
        <label class="control-label col-md-2">故事概述</label>

        <div class="col-md-10">
            <textarea id="select2_sample6" type="text" class="form-control select2" name="data[wenchuang_attr][故事概述]">{$data_edit['data_backup']['wenchuang_attr']['故事概述']}</textarea>
        </div>
    </div>
</div>
<div class="col-md-6">
    <div class="form-group">
        <label class="control-label col-md-2">故事类型</label>

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
            <label class="control-label col-md-2">城市</label>

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
        <label class="control-label col-md-1">剧情简介</label>
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
{if $data_edit['data_backup']['other_demo']}
    <div class="col-md-12">
        <div class="form-group">
            <label class="control-label col-md-1">其他属性</label>
            <div class="col-md-11">
                {foreach $data_edit['data_backup']['other_demo'] as $key=>$value}
                    {if $key !='下载次数' && $key !='附件'}
                        <div class="input-group">
                                            <span class="input-group-addon">
                                                {$key}:
                                            </span>
                            <input type="text" class="form-control select2 tags_attr" name="data[other_demo][{$key}]"   value="{$value}" data-values="{implode(',',$value)}">
                        </div>
                    {/if}
                {/foreach}
            </div>
        </div>
    </div>
{/if}
{if $data_edit['data_backup']['other_demo']}
    <div class="col-md-12" id="accessory" style="">
        <div class="form-group">
            <label class="control-label col-md-1">上传附件</label>
            <div class="col-md-10">
                <div class="fileinput fileinput-new" data-provides="fileinput">
                                                        <span class="btn btn-default btn-file">
                                                            <span class="fileinput-new">选择文件</span>
                                                            <span class="fileinput-exists">重新选择 </span>
                                                            <input type="file" accept="application/zip,application/pdf" name="附件">
                                                        </span>
                    <span class="fileinput-filename">{$data_edit['data_backup']['other_demo']['附件']['filename']}</span>&nbsp;
                    <a href="javascript:void(0)" class="close fileinput-exists"
                       data-dismiss="fileinput"></a>
                    {if $data_edit['data_backup']['other_demo']['附件']}
                        <span class="fa fa-file"></span>

                        <input type="hidden" name="data[other_demo][附件][name]" value="{$data_edit['data_backup']['other_demo']['附件']['name']}">
                        <input type="hidden" name="data[other_demo][附件][size]" value="{$data_edit['data_backup']['other_demo']['附件']['size']}">
                        <input type="hidden" name="data[other_demo][附件][filename]" value="{$data_edit['data_backup']['other_demo']['附件']['filename']}">
                    {/if}
                    <br/><span style="font-size:12px; ">(请上传格式为.pdf的文件，大小不能超过8M)</span>
                </div>
            </div>
        </div>
    </div>
{/if}
<div class="col-md-12">
    <div class="form-group ">
        <label class="control-label col-md-1">获奖记录</label>
        <table id="win_record" class="win_record">
            <tbody>
            {foreach $data_edit['data_backup']['wenchuang_attr']['获奖记录'] as $k=>$v}
                <tr>
                    <td><input class="form-control" class=""  name="data[wenchuang_attr][获奖记录][win_time][]" value="{$v['win_time']}"> </td>
                    <td><input class="form-control" name="data[wenchuang_attr][获奖记录][active_name][]" value="{$v['active_name']}"></td>
                    <td><input class="form-control" name="data[wenchuang_attr][获奖记录][win_name][]" value="{$v['win_name']}"></td>
                    <td><input class="form-control" name="data[wenchuang_attr][获奖记录][win_actor][]" value="{$v['win_actor']}"></td>
                    <td><span class="btn btn-danger" onclick="remove_win(this)">移除</span></td>

                </tr>
            {/foreach}
            </tbody>
        </table>

        <a href="#winning" style="float: right;" data-toggle="modal" class="btn btn-success win_button">
            添加获奖记录
        </a>
    </div>
</div>
<div class="col-md-12">
    <div class="form-group">
        <label class="control-label col-md-1">百科banner</label>
        <div class="col-md-4">
            <div class="fileinput fileinput-new" data-provides="fileinput">
                <div class="fileinput-new thumbnail" style="width: 200px; height: 150px;">
                    {if $data_edit['data_backup']['logo']}
                        <img  class="logo_src" src="{$data_edit['data_backup']['logo']}" alt=""/>
                    {else}
                        <img src="http://www.placehold.it/200x150/EFEFEF/AAAAAA&amp;text=no+image"
                             alt=""/>
                    {/if}
                </div>
                <div class="fileinput-preview fileinput-exists thumbnail"
                     style="max-width: 200px; max-height: 150px;"></div>
                <div>
                                    <span class="btn btn-default btn-file">
                                        <span class="fileinput-new">选择PC端图片</span>
                                        <span class="fileinput-exists">重新选择</span>
                                        <input type="file" name="百科banner" accept="image/jpeg,image/png,image/gif">
                                        <input type="hidden" class="logo" name="data[logo]" value="{$data_edit['data_backup']['logo']}">
                                    </span>
                    {if $data_edit['data_backup']['logo']}
                        <a href="javascript:;" class="btn btn-danger remove_logo">移除</a>
                    {else}
                        <a href="form_component.html#" class="btn btn-danger fileinput-exists" data-dismiss="fileinput">移除</a>
                    {/if}
                </div>
            </div>
                                <span class="required" aria-required="true" style="color: #e02222">（*请上传尺寸为1920*520的图片）
                                                                </span>
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
                <div class="fileinput-preview fileinput-exists thumbnail"
                     style="max-width: 200px; max-height: 150px;"></div>
                <div>
                                    <span class="btn btn-default btn-file">
                                        <span class="fileinput-new">选择移动端图片</span>
                                        <span class="fileinput-exists">重新选择</span>
                                        <input type="file" name="百科移动端banner" accept="image/jpeg,image/png,image/gif">
                                        <input type="hidden" class="mobile_logo" name="data[mobile_logo]" value="{$data_edit['data_backup']['mobile_logo']}">
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
            {include file="spacepedia/inc/public_upload.tpl"}
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
{******添加获奖记录******}
<div class="modal fade" id="winning" tabindex="-1" role="basic" aria-hidden="true">
    <div class="modal-dialog" style="position: fixed;top:20%;left: 20%">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
                <h4 class="modal-title">
                    添加获奖记录</h4>
            </div>
            <div class="modal-body base-info">

                <table width="80%">
                    <tr>
                        <td>获奖时间</td>
                        <td colspan="4">
                            <input class="form-control form-control date" value="" rows="5"  style="margin-bottom: 10px" >
                        </td>
                    </tr>
                    <tr>
                        <td>活动名称</td>
                        <td colspan="4">
                            <input class="form-control active_name" value="" rows="5"  style="margin-bottom: 10px" >
                        </td>
                    </tr>
                    <tr>
                        <td>获奖项目</td>
                        <td colspan="4">
                            <input class="form-control win_name" value=""  rows="5"  style="margin-bottom: 10px" >
                        </td>
                    </tr>
                    <tr>
                        <td>获奖演员</td>
                        <td colspan="4">
                            <input class="form-control win_actor" value=""  rows="5"  style="margin-bottom: 10px" >
                        </td>
                    </tr>
                </table>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">
                    取消
                </button>
                <button type="button" class="btn btn-success" onclick="win_info(this)" data-dismiss="modal">
                    确定
                </button>
            </div>

        </div>
    </div>

</div>
{*<script src="{$_assets}plugins/jquery-1.11.0.min.js"*}
{*type="text/javascript"></script>*}
<script src="{$_assets}plugins/bootstrap/js/bootstrap.min.js"
tab="text/javascript"></script>
<link rel="stylesheet" type="text/css" href="{$_assets}plugins/bootstrap-fileinput/bootstrap-fileinput.css"/>
{*<script src="{$_assets}scripts/_page.js"></script>*}
<script type="text/javascript" src="js/moment.min.js"></script>
<script type="text/javascript" src="js/zh-cn.js"></script>
<script type="text/javascript" src="js/bootstrap-datetimepicker.min.js"></script>
<script type="text/javascript" src="{$_assets}plugins/bootstrap-fileinput/bootstrap-fileinput.js"></script>
{*<script type="text/javascript" src="{$_assets}plugins/bootstrap-fileinput/bootstrap-fileinput.js"></script>*}
<script>
    $(document).ready(function () {
        $('.date').datetimepicker({
            format: 'YYYY-MM-DD',
            locale: 'zh-cn'
        });
    });
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
    function win_info(e){
        var win_time = '<td style="padding: 10px;margin: 10px;"><input class="form-control" name="data[wenchuang_attr][获奖记录][win_time][]" value='+$('.date').val()+'></td>'
        var active_name = '<td style="padding: 10px;margin: 10px;"><input class="form-control" name="data[wenchuang_attr][获奖记录][active_name][]" value='+$('.active_name').val()+'></td>'
        var win_name = '<td style="padding: 10px;margin: 10px;"><input class="form-control" name="data[wenchuang_attr][获奖记录][win_name][]" value='+$('.win_name').val()+'></td>'
        var win_actor = '<td style="padding: 10px;margin: 10px;"><input class="form-control" name="data[wenchuang_attr][获奖记录][win_actor][]" value='+$('.win_actor').val()+'></td>'
        var remove_button = '<td style="padding: 10px;margin: 10px;"><span class="btn btn-danger" onclick="remove_win(this)">移除</span></td>'
//        var remove_button ='<td style="padding:5px;margin: 5px;" ></td>'
        if($('.date').val()!='' && $('.active_name').val()!='' && $('.win_name').val()!='' && $('.win_actor').val()!=''){
            $('#win_record tbody').append('<tr>'+win_time+active_name+win_name+win_actor+remove_button+'</tr>');

        }
    }
    function remove_win(e){
        $(e).parent('td').parent('tr').remove();
    }

</script>

