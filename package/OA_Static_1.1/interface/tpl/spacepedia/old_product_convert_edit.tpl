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
    <script src="{$_assets}plugins/jquery-1.11.0.min.js" type="text/javascript"></script>
    <script type="text/javascript" src="{$_assets}plugins/select2/select2.min.js"></script>
    <link rel="stylesheet" type="text/css" href="{$_assets}plugins/bootstrap-fileinput/bootstrap-fileinput.css"/>
    <script type="text/javascript" src="{$_assets}plugins/bootstrap-fileinput/bootstrap-fileinput.js"></script>
</head>
<!-- END HEAD -->
<!-- BEGIN BODY -->

<body style="background:#FaFaFa !important">
<div class="portlet tabbable">
    <div class="portlet-title">
        <div class="caption">
            <i class="fa fa-database"></i>转换为场地百科
        </div>
    </div>
    <div class="portlet-body form-horizontal">
        <ul class="nav nav-tabs">
            <li class="spacepedia {if $_REQUEST['tab']=="spacepedia"}active{/if}">
                <a href="javascript:;">场地百科</a>
            </li>
            <li class="space_item {if $_REQUEST['tab']=="space_item"}active{/if}">
                <a href="javascript:;">子空间</a>
            </li>
        </ul>

        <div class="form-body" style="min-height: 350px;">
            <form class="form-horizontal" role="form" action="?" method="post" enctype="multipart/form-data">
                <input type="hidden" name="product_id" value="{$_product['id']}">
                <input type="hidden" name="space_id" value="{$_data['id']}">
                <input type="hidden" name="action" value="is_submit">

                <div class="tab-content clearfix">
                    <div id="spacepedia">
                        {include "spacepedia/inc/old_product_spacepedia_edit.tpl"}
                    </div>
                    <div id="space_item">
                        {include "spacepedia/inc/old_product_space_item_edit.tpl"}
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
$(document).ready(function () {
    $('.spacepedia').click(function(){
        $(this).addClass("active");
        $(".space_item").removeClass("active");
        $('#spacepedia').show();
        $('#space_item').hide();
    });
    $('.space_item').click(function(){
        $(this).addClass("active");
        $(".spacepedia").removeClass("active");
        $('#spacepedia').hide();
        $('#space_item').show();
    });

    if($(".spacepedia").hasClass('active')){
        $('#space_item').hide();
        $('#spacepedia').show();
    }else if($(".space_item").hasClass('active')){
        $('#space_item').show();
        $('#spacepedia').hide();
    }

    $(".tags_attr").each(function () {
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
</script>
</body>
<!-- END BODY -->
</html>