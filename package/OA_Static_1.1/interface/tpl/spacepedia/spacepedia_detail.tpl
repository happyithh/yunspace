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
    {if $_REQUEST['tab_action']=="edit_space"}
        {if $data_edit['data_backup']['category_id']==200}
            {include "spacepedia/tab/spacepedia_edit_wenchuang.tpl"}
        {else}
            {include "spacepedia/tab/spacepedia_edit.tpl"}
        {/if}
    {elseif $_REQUEST['tab_action']=="edit_item"}
        {include "spacepedia/tab/item_edit.tpl"}
    {else}
        {include "spacepedia/tab/spacepedia_detail_and_item_list.tpl"}
    {/if}
<script>
    $(".tags_select3_product").each(function () {
        $(this).select2({
            tags: UploadFiles.tags.split(',')
        })
    });
</script>
</body>
<!-- END BODY -->
</html>