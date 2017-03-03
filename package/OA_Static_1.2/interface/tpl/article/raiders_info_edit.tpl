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
    <style>
        .readdata p {
            padding: 0
        }

        .text_right {
            margin-bottom: 30px;
            text-align: right;
        }
    </style>

    <!-- BEGIN JAVASCRIPTS(Load javascripts at bottom, this will reduce page load time) -->
    <!-- BEGIN CORE PLUGINS -->
    <script src="{$_assets}plugins/jquery-1.11.0.min.js"
            tab="text/javascript"></script>
    <script src="{$_assets}plugins/jquery-migrate-1.2.1.min.js"
            tab="text/javascript"></script>
    <!-- IMPORTANT! Load jquery-ui-1.10.3.custom.min.js before bootstrap.min.js to fix bootstrap tooltip conflict with jquery ui tooltip -->
    <script src="{$_assets}plugins/jquery-ui/jquery-ui-1.10.3.custom.min.js"
            tab="text/javascript"></script>
    <script src="{$_assets}plugins/bootstrap/js/bootstrap.min.js"
            tab="text/javascript"></script>
    <script src="{$_assets}plugins/bootstrap-hover-dropdown/bootstrap-hover-dropdown.min.js"
            tab="text/javascript"></script>
    <script src="{$_assets}plugins/jquery-slimscroll/jquery.slimscroll.min.js"
            tab="text/javascript"></script>
    <script src="{$_assets}plugins/jquery.blockui.min.js"
            tab="text/javascript"></script>
    <script src="{$_assets}plugins/uniform/jquery.uniform.min.js"
            tab="text/javascript"></script>
    <!-- END CORE PLUGINS -->
    <!-- BEGIN PAGE LEVEL PLUGINS -->
    <script tab="text/javascript"
            src="{$_assets}plugins/select2/select2.min.js"></script>
    <script tab="text/javascript"
            src="{$_assets}plugins/datatables/media/js/jquery.dataTables.min.js"></script>
    <script tab="text/javascript"
            src="{$_assets}plugins/datatables/plugins/bootstrap/dataTables.bootstrap.js"></script>
    <!-- END PAGE LEVEL PLUGINS -->
    <!-- BEGIN PAGE LEVEL SCRIPTS -->
    <script src="{$_assets}scripts/_page.js"></script>
</head>
<!-- END HEAD -->
<!-- BEGIN BODY -->

<body style="background:#FaFaFa !important">
<div class="portlet tabbable">

    <div class="portlet-body" style="padding:10px 10px">

        <div class="portlet-tabs">
            <div class="tabbable">
                <div class="tab-content clearfix">


                    <div class="portlet tabbable">
                        <div class="portlet-title">
                            <div class="caption">
                                <i class="fa fa-database"></i>文章信息
                            </div>
                        </div>
                        <form class="form-horizontal" role="form" action="?" method="post" enctype="multipart/form-data">
                            <div class="portlet-body form">
                                <input type="hidden" name="action" value="is_submit">
                                {*<input type="hidden" name="id" value="{$_data['id']}">*}
                                <input type="hidden" name="id" value="{$_REQUEST['id']}">
                                <input type="hidden" name="logo" value="{$_data['logo']}">

                                <div class="form-body">
                                    <div class="row">
                                        <div class="col-md-6">
                                            <div class="form-group">
                                                <label class="control-label col-md-2">标题<span class="required"
                                                                                              aria-required="true">*</span></label>

                                                <div class="col-md-10">
                                                    <input type="text" class="form-control" placeholder="文章标题"
                                                           name="title"
                                                           value="{$_data['title']}">
                                                </div>
                                            </div>
                                        </div>


                                        <div class="col-md-6">
                                            <div class="form-group">
                                                <label class="control-label col-md-2">作者/来源</label>

                                                <div class="col-md-10">
                                                    <div class="col-md-6" style="padding-left: 0px;">
                                                    <input type="text" class="form-control" name="author" placeholder="输入作者" value="{$_data['author']}">
                                                        </div>
                                                    <div class="col-md-6" style="line-height: 40px;color: #e02222">
                                                        <input name="is_hot" type="checkbox" value="1"  {if $_data['is_hot']==1}checked="checked"{/if}/>设置为云发现轮播图（置顶）&nbsp;&nbsp;&nbsp;&nbsp;<input name="is_good" type="checkbox" value="1"  {if $_data['is_good']==1}checked="checked"{/if}/>推荐
                                                    </div>

                                                </div>
                                                {*<input name="is_hot" type="checkbox" value="1" {if $_data['is_hot']==1}checked="checked"{/if}/>推荐置顶*}
                                            </div>
                                        </div>
                                        <div class="col-md-6">
                                            <div class="form-group">
                                                <label class="control-label col-md-2">类别<span class="required"
                                                                                              aria-required="true">*</span></label>

                                                <div class="col-md-10">
                                                    {*{var_dump($category_name)}*}
                                                    <select class="form-control input-sm" name="category_id" id="library">
                                                        <option value=''>全部</option>
                                                        {foreach $category_name as $key=>$value}

                                                            <option class="parent" {if $_data['category_id']==$value['id']} selected {/if}
                                                                    value="{$value['id']}"  data-parent="{$value['parent']}">{if $value['parent']==0}{$value['name']}{else}&nbsp;&nbsp;---{$value['name']}{/if}</option>
                                                        {/foreach}
                                                    </select>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-md-6">
                                            <div class="form-group">
                                                <label class="control-label col-md-2">状态<span class="required"
                                                                                              aria-required="true">*</span></label>

                                                <div class="col-md-10">
                                                    <select name="status" class="form-control input-sm">
                                                        {foreach $status as $key=>$val}
                                                            <option {if {$_data['status']}==$key}selected{/if}
                                                                    value="{$key}">{$val}</option>
                                                        {/foreach}
                                                    </select>
                                                </div>
                                            </div>
                                        </div>

                                        <div class="col-md-6">
                                            <div class="form-group">
                                                <label class="control-label col-md-2">关键词<span class="required"
                                                                                               aria-required="true">*</span></label>
                                                <div class="col-md-10">


                                                    <input type="text" class="form-control input-sm select2 tags_select2" value="{implode(',',$_data['tags_info'])}" name="tags_info"   data-values="{implode(',',$attr)}">

                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-md-6">
                                            <div class="form-group">
                                                <label class="control-label col-md-2">修改时间</label>
                                                <div class="col-md-10">
                                                    <input type="text" class="form-control" name="create_time" placeholder="时间格式例如：2015-01-01 00:00:01" {if !empty($_data['create_time'])}value="{date('Y-m-d H:i:s',$_data['create_time'])}"{else}value=""{/if}>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-md-6">

                                        </div>
                                        <div class="col-md-6">

                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-md-6">

                                        </div>
                                        <div class="col-md-6">

                                        </div>

                                    </div>
                                    <div class="row">



                                        <div class="col-md-12">

                                            <div class="col-md-6">
                                                <div class="form-group">
                                                    <label class="col-md-2 control-label">封面缩略图</label>

                                                    {*<input type="hidden" name="logo" value="{$_data['logo']}">*}
                                                    <div class="col-md-10">
                                                        <div class="fileinput fileinput-new" data-provides="fileinput">
                                                            <div class="fileinput-new thumbnail col-md-6" >
                                                                {if $_data['logo']}
                                                                    <img src="{$_data['logo']}" alt=""/>
                                                                {else}
                                                                    <img src="http://www.placehold.it/200x150/EFEFEF/AAAAAA&amp;text=no+image"
                                                                         alt=""/>
                                                                {/if}

                                                            </div>
                                                            <div style="margin-top: 50px;" class="col-md-6">
                                                                <input name="hide_logo" type="checkbox" value="1"
                                                                       {if $_data['hide_logo']==1}checked="checked"{/if}/>勾选则在详情页展示
                                                                logo，不勾选则不展示
                                                            </div>
                                                            <div style="clear:both"></div>
                                                            <div class="fileinput-preview fileinput-exists thumbnail"
                                                                 style="max-width: 200px; max-height: 150px;">
                                                            </div>
                                                            <div>
                                                                <span class="btn btn-default btn-file">
                                                                    <span class="fileinput-new">选择图片</span>
                                                                    <span class="fileinput-exists">重新选择</span>
                                                                    <input type="file" name="logo_f"  accept="image/jpeg,image/png,image/gif">
                                                                </span>
                                                                <a href="form_component.html#" class="btn btn-danger fileinput-exists"
                                                                   data-dismiss="fileinput">移除</a>
                                                                <span class="required" aria-required="true" style="color: #e02222">（*如栏目选择为活动文库，
                                                                    请勿上传，封面缩略图建议尺寸为304*185）
                                                                </span>

                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-md-6">
                                            <div class="form-group">
                                                <label class="control-label col-md-2">跳转链接</label>

                                                <div class="col-md-6">
                                                    <input  class="form-control" name="is_jump" value="{$_data['is_jump']}" placeholder="如果需要文章跳转至专题页，请填写！"/>
                                                </div>
                                            </div>

                                        </div>
                                        <div class="col-md-6">
                                            <div class="form-group">
                                                <label class="control-label col-md-2">原文链接</label>

                                                <div class="col-md-6">
                                                    <input  class="form-control" name="original_link" value="{$_data['original_link']}" placeholder="原文链接"/>
                                                </div>
                                            </div>

                                        </div>
                                        <div class="col-md-12">
                                            <div class="form-group">
                                                <label class="control-label col-md-1">文章简介<span class="required"
                                                                                                aria-required="true">*</span></label>

                                                <div class="col-md-11">
                                                    <textarea class="form-control " rows="3"
                                                              name="des">{$_data['des']}</textarea>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-md-12">
                                        </div>


                                        {*添加附加信息，如地址，信息，开馆时间等*}
                                        {*<div class="col-md-12">*}
                                        {*<div class="form-group">*}
                                        {*<label class="control-label col-md-1">详情描述</label>*}
                                        {*<div class="col-md-11">*}
                                        {*{include "Admin::inc/html_umeditor.tpl" name="detail_des"  value=$_data['detail_des'] height=100}<span class="required" aria-required="true" style="color: red">（详情描述：活动内容或场地内容的附加信息，如活动地点、活动时间、开放时间等信息）*}
                                        {*</span>*}
                                        {*</div>*}
                                        {*</div>*}
                                        {*</div>*}

                                        <div class="col-md-12">
                                            <div class="form-group">
                                                <label class="control-label col-md-1">文章内容<span class="required"
                                                                                                aria-required="true">*</span></label>
                                                <div class="col-md-11">
                                                    {include "Admin::inc/html_umeditor.tpl" name="cont" value=$_data['cont'] height=300}
                                                </div>
                                            </div>
                                        </div>



                                        {*<div class="col-md-12">*}

                                            {*<div class="col-md-6">*}
                                                {*<div class="form-group">*}
                                                    {*<label class="col-md-2 control-label">封面缩略图</label>*}

                                                    {*<div class="col-md-10">*}
                                                        {*<div class="fileinput fileinput-new" data-provides="fileinput">*}
                                                            {*<div class="fileinput-new thumbnail col-md-6" >*}
                                                                {*{if $_data['logo']}*}
                                                                    {*<img src="{$_data['logo']}" alt=""/>*}
                                                                {*{else}*}
                                                                    {*<img src="http://www.placehold.it/200x150/EFEFEF/AAAAAA&amp;text=no+image"*}
                                                                         {*alt=""/>*}
                                                                {*{/if}*}

                                                            {*</div>*}
                                                            {*<div style="margin-top: 50px;" class="col-md-6">*}
                                                                {*<input name="hide_logo" type="checkbox" value="1"*}
                                                                       {*{if $_data['hide_logo']==1}checked="checked"{/if}/>选择则在详情页展示*}
                                                                {*logo，不选择则不展示*}
                                                            {*</div>*}
                                                            {*<div style="clear:both"></div>*}
                                                            {*<div class="fileinput-preview fileinput-exists thumbnail"*}
                                                                 {*style="max-width: 200px; max-height: 150px;">*}
                                                            {*</div>*}
                                                            {*<div>*}
                                                                {*<span class="btn btn-default btn-file">*}
                                                                    {*<span class="fileinput-new">选择图片</span>*}
                                                                    {*<span class="fileinput-exists">重新选择</span>*}
                                                                    {*<input type="file" name="logo" accept="image/jpeg,image/png,image/gif">*}
                                                                {*</span>*}
                                                                {*<a href="form_component.html#" class="btn btn-danger fileinput-exists"*}
                                                                   {*data-dismiss="fileinput">移除</a>*}
                                                                {*<span class="required" aria-required="true" style="color: #e02222">（*如栏目选择为活动文库，*}
                                                                    {*请勿上传封面缩略图）*}
                                                                {*</span>*}

                                                            {*</div>*}
                                                        {*</div>*}
                                                    {*</div>*}
                                                {*</div>*}
                                            {*</div>*}
                                        {*</div>*}




                                        <div class="col-md-12" id="accessory" style="display: none">
                                            <div class="form-group">
                                                <label class="control-label col-md-1">上传附件<span class="required"
                                                                                                aria-required="true">*</span></label>
                                                <div class="col-md-10">
                                                    <div class="fileinput fileinput-new" data-provides="fileinput">
                                                        <span class="btn btn-default btn-file">
                                                            <span class="fileinput-new">选择文件</span>
                                                            <span class="fileinput-exists">重新选择 </span>
                                                            <input type="file" accept="zip,rar,pdf,txt,doc,jpg,docx,pptx,ppt,xlsx,xls,png" name="accessory">
                                                        </span>
                                                        <span class="fileinput-filename">{$_data['accessory']['filename']}</span>&nbsp;
                                                        <a href="javascript:void(0)" class="close fileinput-exists"
                                                           data-dismiss="fileinput"></a>
                                                        {if $_data['accessory']}
                                                            <span class="fa fa-file"></span>

                                                            <input type="hidden" name="accessory[name]" value="{$_data['accessory']['name']}">
                                                            <input type="hidden" name="accessory[size]" value="{$_data['accessory']['size']}">
                                                            <input type="hidden" name="accessory[filename]" value="{$_data['accessory']['filename']}">
                                                        {/if}
                                                        <br/><span style="font-size:12px; ">(请上传格式为.zip.jpg.rar.pdf.txt.doc.docx.pptx.ppt.xlsx.xls.png的文件，大小不能超过50M)</span>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>


                                        <div class="col-md-6">
                                            <div class="form-group">
                                                <label class="control-label col-md-2">详情描述1</label>

                                                <div class="col-md-10">
                                                    <input type="text" class="form-control" name="detail_des[]"
                                                           placeholder="如 活动地点：上海长宁区淮海西路570号F211"
                                                           value="{$_data['detail_des'][0]}">
                                                </div>

                                            </div>
                                        </div>
                                        <div class="col-md-6">
                                            <div class="form-group">
                                                <label class="control-label col-md-2">详情描述2</label>

                                                <div class="col-md-10">
                                                    <input type="text" class="form-control" name="detail_des[]"
                                                           placeholder="如 交通方式：地铁3、4、10号线虹桥路站4号口出"
                                                           value="{$_data['detail_des'][1]}">
                                                </div>

                                            </div>
                                        </div>
                                        <div class="col-md-6">
                                            <div class="form-group">
                                                <label class="control-label col-md-2">详情描述3</label>

                                                <div class="col-md-10">
                                                    <input type="text" class="form-control" name="detail_des[]"
                                                           placeholder="如 活动时间：2015-10-1~2015-10-31"
                                                           value="{$_data['detail_des'][2]}">
                                                </div>

                                            </div>
                                        </div>
                                        <div class="col-md-6">
                                            <div class="form-group">
                                                <label class="control-label col-md-2">详情描述4</label>

                                                <div class="col-md-10">
                                                    <input type="text" class="form-control" name="detail_des[]"
                                                           placeholder="如 开放时间：周二至周日10:00-17:30（17:00停止入馆）"
                                                           value="{$_data['detail_des'][3]}">
                                                </div>

                                            </div>
                                        </div>
                                        <div class="col-md-6">
                                            <div class="form-group">
                                                <label class="control-label col-md-2"></label>
                                                <div class="col-md-10">
                                        <span class="required" aria-required="true" style="color: #e02222">（*详情描述：活动内容或场地内容的附加信息，如活动地点、活动时间、开放时间等信息）
                                            </span>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                    </div>

                    <div class="form-group">
                    </div>

                    <div class="form-actions text-center">
                        <button type="reset" class="btn btn-default">
                            重置
                        </button>
                        <button type="submit" class="btn btn-success" >
                            提交
                        </button>
                    </div>
                    </form>
                    {*{var_dump($attr)}*}
                </div>
                <link rel="stylesheet" type="text/css" href="{$_assets}plugins/bootstrap-fileinput/bootstrap-fileinput.css"/>
                <script type="text/javascript" src="{$_assets}plugins/bootstrap-fileinput/bootstrap-fileinput.js"></script>
                <script>

                    $(document).ready(function(){
                        $(".tags_select2").each(function () {
                            $(this).select2({
                                tags: $(this).data('values').split(',')
                            })
                        });
                        $("#select2_sample6").select2({
                            placeholder: "选择套餐",
                            minimumInputLength: 1,
                            ajax: { // instead of writing the function to execute the request we use Select2's convenient helper
                                url: "?action=edit&set_auto_complete=1",
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
                                    $.ajax("?action=edit&set_auto_complete=1", {
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


                    });

                    $(document).ready(function () {

                        var sel =  $("#library").children('option:selected').val()
                        var par = $("#library").children('option:selected').data("parent")
                        if(sel == 12 || par ==12){
                            $('#accessory').css('display','block');
                        }
                        $("#library").change(function(){
                            var category_id = $(this).children('option:selected').val();
                            var parent = $(this).children('option:selected').data("parent");
                            if(category_id == 12 || parent == 12){
                                $('#accessory').css('display','block');}else{
                                $('#accessory').css('display','none');
                            }
                        });
                    });
                </script>