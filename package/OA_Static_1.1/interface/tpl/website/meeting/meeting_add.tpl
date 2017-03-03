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

    <link rel="stylesheet" href="{$_assets}/plugins/bootstrap-fileinput/bootstrap-fileinput.css"/>
    <script type="text/javascript" src="{$_assets}/plugins/bootstrap-fileinput/bootstrap-fileinput.js"></script>
    <link href="css/bootstrap-datetimepicker.min.css" rel="stylesheet"/>
    <link rel="stylesheet" type="text/css" href="{$_assets}plugins/select2/select2.css"/>
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
            <i class="fa fa-reorder"></i>添加新套餐
        </div>
    </div>
    <div class="portlet-body">
        <form action="?action=submit_edit" method="post" class="clearfix form-horizontal"   enctype="multipart/form-data">
            <div class="form-body">
                <input  type="hidden" name="tid"  value="{$info['id']}"/>
                <input  type="hidden" class="hidden-space_item_name" name="space_item_name"  value="{$info['space_item_name']}"/>
                <div class="clearfix">
                    <div class="form-group col-md-9 space_item_name">
                        <label class="col-md-3 control-label">场地名-空间名</label>

                        <div class="col-md-6">
                            <div class="form-control" id="space_item"
                                 data-url="http://{Core::$urls['host']}/static/api/annual/meeting/space/auto/complete.jsonp">
                                <input type="text" name="space_item_name" placeholder="场地名-空间名" value="{$info['space_item_name']}">
                            </div>
                        </div>
                    </div>
                    {*<div class="form-group col-md-9">*}
                        {*<label class="col-md-3 control-label">场地名-空间名</label>*}

                        {*<div class="col-md-6">*}
                            {*<input type="text" class="form-control input-sm" placeholder="场地名-空间名" name="space_item_name" value="{$info['title']}">*}
                        {*</div>*}
                    {*</div>*}
                    <div class="form-group col-md-9">
                        <label class="col-md-3 control-label">场地简介</label>
                        <div class="col-md-9">
                            <input type="text" class="form-control input-sm" placeholder="场地简介" name="space_info" value="{$info['space_info']}">
                            <span style="font-size: 14px;color: #a94442;"> 包括标点符号，最多30个字符</span>
                        </div>
                    </div>
                    <div class="form-group col-md-9">
                        <label class="col-md-3 control-label">上线状态</label>

                        <div class="col-md-9">
                            <label class="radio-inline">
                                <input type="radio" name="status" value="1" {if !isset($info['status'])||$info['status']==1}checked{/if}>
                                上线
                            </label>
                            <label class="radio-inline">
                                <input type="radio" name="status" value="0" {if isset($info['status'])&&$info['status']==0}checked{/if}>
                                下线
                            </label>
                        </div>
                    </div>
                    {*{var_dump($category_list)}*}
                    <div class="form-group col-md-9">
                        <label class="col-md-3 control-label">所属套餐</label>
                        <div class="col-md-9">
                            <select name="category" class="form-control input-sm">
                                <option value="" >请选择</option>
                                {foreach $category_list as $k=>$v}
                                    <option value="{$v['category']}" {if $info['category']==$v['category']}selected {/if}>
                                        {$v['category']}
                                        {*{if $v['status'] == 0}*}
                                            {*<span>(已下线)</span>*}
                                        {*{/if}*}
                                        {*{if $v['status'] == -1}*}
                                            {*<span>(已删除)</span>*}
                                        {*{/if}*}
                                        {*{if $v['status'] == -2}*}
                                            {*<span>(已删除)</span>*}
                                        {*{/if}*}
                                    </option>
                                {/foreach}
                            </select>
                        </div>
                    </div>
                    <div class="form-group col-md-9">
                        <label class="col-md-3 control-label">套餐有效期</label>
                        <div class="col-md-2" >
                            <input type='text' class="form-control date" placeholder="请选择开始时间" name="start_time"
                                   value="{if !empty($info['start_time'])}{$info['start_time']}{/if}"/>
                        </div>
                        <div style="display: block;float: left;line-height: 30px;height: 30px;text-align: center;margin-left: 2px;">
                            ----
                        </div>
                        <div class="col-md-2" >
                            <input type='text' class="form-control date" placeholder="请选择结束时间" name="end_time"
                                   value="{if !empty($info['end_time'])}{$info['end_time']}{/if}"/>
                        </div>
                    </div>


                    <div class="form-group col-md-9">
                        <label class="col-md-3 control-label">场地原总价</label>
                        <div class="col-md-6">
                            <input type="text" class="form-control input-sm" placeholder="场地原总价" name="old_price" value="{$info['old_price']}">
                        </div>
                        <div class="col-md-2">
                            <span style="text-align: center;height: 30px;line-height: 30px;">/元</span>
                        </div>
                    </div>

                    <div class="form-group col-md-9">
                        <label class="col-md-3 control-label">云SPACE总价</label>
                        <div class="col-md-6">
                            <input type="text" class="form-control input-sm" placeholder="云SPACE总价" name="new_price" value="{$info['new_price']}">
                        </div>
                        <div class="col-md-2">
                            <span style="text-align: center;height: 30px;line-height: 30px;">/元起</span>
                        </div>
                    </div>

                    <div class="form-group col-md-9">
                        <label class="col-md-3 control-label">价格备注</label>
                        <div class="col-md-9">
                            <input type="text" class="form-control input-sm" placeholder="价格备注" name="remarks" value="{$info['remarks']}">
                        </div>
                    </div>
                    <div class="form-group col-md-9">
                        <label class="col-md-3 control-label">起订桌数</label>
                        <div class="col-md-9">
                            <input type="text" class="form-control input-sm" placeholder="起订桌数" name="start_seat" value="{$info['start_seat']}">
                        </div>
                    </div>
                    <div class="form-group col-md-9">
                        <label class="col-md-3 control-label">最大容纳桌数</label>
                        <div class="col-md-9">
                            <input type="text" class="form-control input-sm" placeholder="最大容纳桌数" name="max_seat" value="{$info['max_seat']}">
                        </div>
                    </div>

                    <div class="form-group col-md-9">
                        <label class="col-md-3 control-label">场地详情</label>

                        <div class="col-md-9">
                            {include "Admin::inc/html_umeditor.tpl" name="space_des" value=$info['space_des'] height=200}
                            <span style="font-size: 14px;color: #a94442;"> 图片大小至少800*500像素</span>
                            {*<textarea class="form-control" rows="5" name="content">{$info['content']}</textarea>*}
                        </div>

                    </div>
                    <div class="form-group col-md-9">
                        <label class="col-md-3 control-label">套餐详情</label>

                        <div class="col-md-9">
                            {include "Admin::inc/html_umeditor.tpl" name="annual_des" value=$info['annual_des'] height=200}
                            <span style="font-size: 14px;color: #a94442;"> 图片大小至少800*500像素</span>
                            {*<textarea class="form-control" rows="5" name="content">{$info['content']}</textarea>*}
                        </div>
                    </div>
                    <div class="form-group col-md-9">
                        <label class="col-md-3 control-label">预定详情（须知）</label>

                        <div class="col-md-9">
                            {include "Admin::inc/html_umeditor.tpl" name="book_des" value=$info['book_des'] height=200}
                            <span style="font-size: 14px;color: #a94442;"> 图片大小至少800*500像素</span>
                            {*<textarea class="form-control" rows="5" name="content">{$info['content']}</textarea>*}
                        </div>
                    </div>

                    <div class="form-group col-md-9">
                        <label class="col-md-3 control-label">封面图片<span class="required"
                                                                          aria-required="true">*</span></label>

                        <div class="col-md-4">
                            <div class="fileinput fileinput-new" data-provides="fileinput">
                                <div class="fileinput-new thumbnail" style="width: 200px; height: 150px;">
                                    {if $info['list_img']}
                                        <img class="logo_src" src="{$info['list_img']}" alt=""/>
                                    {else}
                                        <img src="http://res2.esf.leju.com/esf_www/statics/images/default-img/detail.png"
                                             alt=""/>
                                    {/if}
                                </div>
                                <div class="fileinput-preview fileinput-exists thumbnail"
                                     style="max-width: 200px; max-height: 150px;"></div>
                                <div>
                                    <span class="btn btn-default btn-file">
                                        <span class="fileinput-new">列表显示图片</span>
                                        <span class="fileinput-exists">重新选择</span>
                                        <input type="file" name="list_img_upload" accept="image/jpeg,image/png,image/gif">
                                        <input type="hidden" class="logo" name="list_img"
                                               value="{$info['list_img']}">
                                    </span>
                                    {if $info['list_img']}
                                        <a href="javascript:;" class="btn btn-danger remove_logo">移除</a>
                                    {else}
                                        <a href="form_component.html#" class="btn btn-danger fileinput-exists"
                                           data-dismiss="fileinput">移除</a>
                                    {/if}
                                </div>
                            </div>
                                <span class="required" aria-required="true" style="color: #e02222">（*上传尺寸为300*200 或比例3：2的图片） </span>
                        </div>

                        <div class="col-md-4">
                            <div class="fileinput fileinput-new" data-provides="fileinput">
                                <div class="fileinput-new thumbnail" style="width: 200px; height: 150px;">
                                    {if $info['recommend_img']}
                                        <img class="mobile_logo_src" src="{$info['recommend_img']}" alt=""/>
                                    {else}
                                        <img src="http://res2.esf.leju.com/esf_www/statics/images/default-img/detail.png"
                                             alt=""/>
                                    {/if}
                                </div>
                                <div class="fileinput-preview fileinput-exists thumbnail"
                                     style="max-width: 200px; max-height: 150px;"></div>
                                <div>
                                    <span class="btn btn-default btn-file">
                                        <span class="fileinput-new">推荐列表显示图片</span>
                                        <span class="fileinput-exists">重新选择</span>
                                        <input type="file" name="recommend_img_upload" accept="image/jpeg,image/png,image/gif">
                                        <input type="hidden" class="mobile_logo" name="recommend_img"
                                               value="{$info['recommend_img']}">
                                    </span>
                                    {if $info['recommend_img']}
                                        <a href="javascript:;" class="btn btn-danger remove_mobile_logo">移除</a>
                                    {else}
                                        <a href="form_component.html#" class="btn btn-danger fileinput-exists"
                                           data-dismiss="fileinput">移除</a>
                                    {/if}
                                </div>
                            </div>
                            <span class="required" aria-required="true" style="color: #e02222">（*上传尺寸为300*200 或比例3：2的图片） </span>
                            {*<span class="required" aria-required="true" style="color: #e02222">（*请上传尺寸为1920*520的图片）*}
                            {*</span>*}
                        </div>
                    </div>

                    <div class="form-group col-md-9">
                        <label class="control-label col-md-3">场地详情图片</label>

                        <div class="col-md-9">
                            {include file="website/meeting/meeting_public_upload.tpl"}
                            <span class="required" aria-required="true" style="color: #e02222">可多张。大小至少为600*400或 更大的3：2的比例的图片
                                                                </span>
                        </div>

                    </div>

                <div class="clearfix"></div>
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
<script type="text/javascript" src="js/moment.min.js"></script>
<script type="text/javascript" src="js/zh-cn.js"></script>
<script type="text/javascript" src="js/bootstrap-datetimepicker.min.js"></script>
<script type="text/javascript" src="js/qrcode.js"></script>
<script type="text/javascript" src="js/jquery.form.js"></script>
<script type="text/javascript" src="{$_assets}plugins/select2/select2.min.js"></script>
<script src="js/select2.js"></script>
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
    $(document).ready(function () {
        $('.date').datetimepicker({
            format: 'YYYY-MM-DD',
            locale: 'zh-cn'
        });
        $('#space_item').on('change',function(){
            $(".space_item_name").find('.select2-chosen').css("color","#222");
        });
        $(".space_item_name").find('.select2-chosen').text($('.hidden-space_item_name').val());
        if($(".space_item_name").find('.select2-chosen').text()==''){
            $(".space_item_name").find('.select2-chosen').text("请输入场地名称");
        }
        if($(".space_item_name").find('.select2-chosen').text()=='请输入场地名称'){
            $(".company-name").find('.select2-chosen').css("color","#909090");
        }
    });

</script>

</body>
</html>