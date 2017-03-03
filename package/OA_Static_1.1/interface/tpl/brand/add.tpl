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

<body style="background:#FaFaFa !important">

<div class="portlet tabbable">
<div class="portlet-title">
    <div class="caption">
        <i class="fa fa-database"></i>合作品牌信息详情
    </div>
</div>
<div class="portlet-body" style="padding:10px 10px">
    <div class="form-body" style="min-height: 350px;">

        <form class="form-horizontal" role="form" action="?action=submit" method="post" enctype="multipart/form-data">
            <input type="hidden" name="id" value="{$data['id']}">

            <div class="row">
                <div class="col-md-6">
                    <div class="form-group">
                        <label class="control-label col-md-2">合作品牌名称<span class="required" aria-required="true">*</span></label>

                        <div class="col-md-10">
                            <input type="text" {*{if $data_edit['object_id']} disabled {/if}*}  class="form-control"
                                   placeholder="请输入合作品牌名称" name="title" value="{$data['title']}">
                        </div>
                    </div>
                </div>
                <div class="col-md-6">
                    <div class="form-group">
                        <label class="control-label col-md-2">营销标题</label>

                        <div class="col-md-10">
                            <input type="text" class="form-control" placeholder="请输入营销标题" name="attr[营销标题]"
                                   value="{$data['attr']['营销标题']}">
                        </div>
                    </div>
                </div>
                <div class="col-md-6">
                    <div class="form-group">
                        <label class="control-label col-md-2">品牌品类</label>

                        <div class="col-md-10">
                            <input type="text" class="form-control" name="attr[品牌品类]"
                                   value="{$data['attr']['品牌品类']}">
                        </div>
                    </div>
                </div>
                <div class="col-md-6">
                    <div class="form-group">
                        <label class="control-label col-md-2">产品形式</label>

                        <div class="col-md-10">
                            <input type="text" class="form-control" name="attr[产品形式]"
                                   value="{$data['attr']['产品形式']}">
                        </div>
                    </div>
                </div>
                <div class="col-md-6">
                    <div class="form-group">
                        <label class="control-label col-md-2">面积要求</label>

                        <div class="col-md-10">
                            <input type="text" class="form-control" name="attr[面积要求]"
                                   value="{$data['attr']['面积要求']}">
                        </div>
                    </div>
                </div>
                <div class="col-md-6">
                    <div class="form-group">
                        <label class="control-label col-md-2">落位要求</label>

                        <div class="col-md-10">
                            <input type="text" class="form-control" name="attr[落位要求]" value="{$data['attr']['落位要求']}">
                        </div>
                    </div>
                </div>
                <div class="col-md-6">
                    <div class="form-group">
                        <label class="control-label col-md-2">合作方式</label>

                        <div class="col-md-10">
                            <input type="text" class="form-control" name="attr[合作方式]" value="{$data['attr']['合作方式']}">
                        </div>
                    </div>
                </div>
                <div class="col-md-6">
                    <div class="form-group">
                        <label class="control-label col-md-2">合作周期</label>

                        <div class="col-md-10">
                            <input type="text" class="form-control" name="attr[合作周期]" value="{$data['attr']['合作周期']}">
                        </div>
                    </div>
                </div>
                <div class="col-md-6">
                    <div class="form-group">
                        <label class="control-label col-md-2">品牌简介</label>

                        <div class="col-md-10">
                            <textarea class="form-control " rows="3" name="des">{$data['des']}</textarea>
                        </div>
                    </div>
                </div>
                <div class="col-md-6">
                    <div class="form-group">
                        <label class="control-label col-md-2">状态</label>

                        <div class="col-md-10">
                            <select class="form-control" name="status">
                                <option value="1" {if $data['status']==1 || !isset($data)} selected {/if}>上线</option>
                                <option value="0" {if isset($data)&&$data['status']==0}selected {/if}>下线</option>
                            </select>
                        </div>
                    </div>
                </div>
                <div class="col-md-12">
                    <div class="form-group">
                        <label class="control-label col-md-1">品牌详情</label>

                        <div class="col-md-11">
                            {include "Admin::inc/html_umeditor.tpl" name="content" value=$data['content'] height=200}
                        </div>
                    </div>
                </div>
                <div class="col-md-12">
                    <div class="form-group">
                        <label class="control-label col-md-1">品牌logo<span class="required"
                                                                            aria-required="true">*</span></label>

                        <div class="col-md-4">
                            <div class="fileinput fileinput-new" data-provides="fileinput">
                                <div class="fileinput-new thumbnail" style="width: 200px; height: 150px;">
                                    {if $data['logo']}
                                        <img class="logo_src" src="{$data['logo']}" alt=""/>
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
                                        <input type="file" name="品牌banner" accept="image/jpeg,image/png,image/gif">
                                        <input type="hidden" class="logo" name="logo"
                                               value="{$data['logo']}">
                                    </span>
                                    {if $data['logo']}
                                        <a href="javascript:;" class="btn btn-danger remove_logo">移除</a>
                                    {else}
                                        <a href="form_component.html#" class="btn btn-danger fileinput-exists"
                                           data-dismiss="fileinput">移除</a>
                                    {/if}
                                </div>
                            </div>
                                <span class="required" aria-required="true" style="color: #e02222">（*建议上传尺寸为797*210的图片）
                                                                </span>
                        </div>

                        <div class="col-md-4">
                            <div class="fileinput fileinput-new" data-provides="fileinput">
                                <div class="fileinput-new thumbnail" style="width: 200px; height: 150px;">
                                    {if $data['mobile_logo']}
                                        <img class="mobile_logo_src" src="{$data['mobile_logo']}" alt=""/>
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
                                        <input type="file" name="品牌移动端banner" accept="image/jpeg,image/png,image/gif">
                                        <input type="hidden" class="mobile_logo" name="mobile_logo"
                                               value="{$data['mobile_logo']}">
                                    </span>
                                    {if $data['mobile_logo']}
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
                        <label class="control-label col-md-1">上传图片</label>

                        <div class="col-md-11">
                            {include file="brand/inc/public_upload.tpl"}
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
<link rel="stylesheet" type="text/css" href="{$_assets}plugins/bootstrap-fileinput/bootstrap-fileinput.css"/>
<script type="text/javascript" src="{$_assets}plugins/bootstrap-fileinput/bootstrap-fileinput.js"></script>
{*<script type="text/javascript" src="{$_assets}plugins/bootstrap-fileinput/bootstrap-fileinput.js"></script>*}
<script>
    //移除logo
    $(".remove_logo").click(function () {
        $(".logo").val("");
        $(".logo_src").attr("src", 'http://www.placehold.it/200x150/EFEFEF/AAAAAA&amp;text=no+image');
    });
    //移除移动端logo
    $(".remove_mobile_logo").click(function () {
        $(".mobile_logo").val("");
        $(".mobile_logo_src").attr("src", 'http://www.placehold.it/200x150/EFEFEF/AAAAAA&amp;text=no+image');
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