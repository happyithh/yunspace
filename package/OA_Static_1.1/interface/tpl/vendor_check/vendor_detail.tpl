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
    <style>
        .hidden-xs {

            line-height: 28px;
            color: #666;
            float: left;
            font-size: 15px;
            display: block;
            width: 46%;
            margin: 0 2% 0 0;

        }
        .information_left{
            padding: 10px;
            line-height: 28px;
            font-size: 18px;
            float: left;
            width: 100%;
        }
        .hidden-xs span{
            display: block;
            width: 46%;
            float: left;
            margin: 0 2% 0 0;
            padding-left: 90px;
        }

    </style>
</head>
<!-- END HEAD -->
<!-- BEGIN BODY -->

<body style="background:#FaFaFa !important">
<!-- BEGIN PAGE HEADER-->
<h3 class="page-title" style="float: left;">
    供应商信息审核页
</h3>
<a href="javascript:history.go(-1)" class="back"><
    <返回
</a>

<div class="clear"></div>
<div class="portlet">
    <div class="portlet-body">
                    <table class="table table-striped table-bordered table-advance">
                        <tbody>
                        <form action="?action=check_vendor&handle_type=pass&id={$data['id']}&admin_name={$_REQUEST['admin_name']}" method="post" id="myform">
                            <tr>
                                <td style="width: 20%;">
                                    <div class="information_left">
                                        供应商名称
                                    </div>
                                </td>
                                <td>
                                    <div class="hidden-xs" style="padding-left: 90px;">
                                        {$data['vendor_name']}
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <div class="information_left">
                                        服务范围
                                    </div>
                                </td>
                                <td>
                                    <div  style="padding-left: 90px;">
                                        <select multiple="multiple" class="multi-select" name="categories_id[]" id="my_multi_select2" data-placeholder="Select...">
                                        {function show_category level=0}
                                        {foreach $_categories[$id] as $k=>$v}
                                        <option value="{$k}" {if in_array($k,$data['categories_id'])} selected="selected" {/if}>{str_repeat(' . . ', $lv)}
                                        {$k}
                                        . {$v}
                                        </option>
                                        {if $_categories[$k]}
                                        {show_category id=$k lv=$lv+1}
                                        {/if}
                                        {/foreach}
                                        {/function}
                                        {show_category id=0 lv=1}
                                        </select>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <div class="information_left">
                                        品牌名称
                                    </div>
                                </td>
                                <td>
                                    <div class="hidden-xs" style="padding-left: 90px;">
                                        {$data['base_info']['品牌名称']}
                                    </div>
                                </td>
                            </tr>
                            <tr>
                            <td >
                                <div class="information_left">
                                    地址
                                </div>
                            </td>
                            <td>
                                <div class="hidden-xs" style="padding-left: 90px;">
                                    {$data['addr']}
                                </div>
                            </td>
                            </tr>
                            {foreach $_vendor_attr as $k=>$v}
                            <tr>
                                <td >
                                    <div class="information_left">
                                        {$k}
                                    </div>
                                </td>
                                <td>
                                    <div class="hidden-xs" style="padding-left: 90px;">
                                        {$data['attr'][$k]}
                                    </div>
                                </td>
                            </tr>
                            {/foreach}
                            <tr>
                                <td >
                                    <div class="information_left">
                                        业务性质
                                    </div>
                                </td>
                                <td>
                                    <div class="hidden-xs" style="padding-left: 90px;">
                                        {$data['base_info']['业务性质']}
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <td >
                                    <div class="information_left">
                                        业务范围
                                    </div>
                                </td>
                                <td>
                                    <div class="hidden-xs" style="padding-left: 90px;">
                                        {$data['base_info']['业务范围']}
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <td >
                                    <div class="information_left">
                                        团队简介
                                    </div>
                                </td>
                                <td>
                                    <div class="hidden-xs" style="padding-left: 90px;">
                                        {$data['base_info']['团队简介']}
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <td >
                                    <div class="information_left">
                                        供应商介绍
                                    </div>
                                </td>
                                <td>
                                    <div class="hidden-xs" style="padding-left: 90px;">
                                        {$data['des']}
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <td >
                                    <div class="information_left">
                                        公司LOGO
                                    </div>
                                </td>
                                <td>
                                    <div class="hidden-xs" style="padding-left: 90px;">
                                        <img src="{$data['logo']}" style="width: 200px; height: 150px;"/>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <div class="information_left" >
                                        请输入拒绝理由
                                    </div>
                                </td>
                                <td>
                                    <div class="hidden-xs" style="padding-left: 90px;">
                                        <textarea id="refuseReason" name="reason" class="form-control" rows="3"></textarea>
                                </td>
                            </tr>
                            <tr >
                                <td  colspan="2" style="border-left:0;">
                                    <div  style="padding-left: 50%;">
                                        <button type="submit" class="btn btn-primary">
                                            通过
                                            </button>
                                            <button type="button" class="btn btn-danger" onclick="refuse()">
                                            拒绝
                                            </button>
                                    </div>
                                </td>
                            </tr>
                        </form>
                        </tbody>
                        </table>

        </div>
    </div>

    <!-- BEGIN PAGE LEVEL PLUGINS -->
    <script src="{$_assets}plugins/jquery-1.11.0.min.js" type="text/javascript"></script>
    <link rel="stylesheet" type="text/css" href="{$_assets}plugins/jquery-multi-select/css/multi-select.css"/>
    <script type="text/javascript" src="{$_assets}plugins/jquery-multi-select/js/jquery.multi-select.js"></script>
    <!-- END PAGE LEVEL PLUGINS -->
    <!-- BEGIN PAGE LEVEL SCRIPTS -->
    <script src="{$_assets}scripts/_page.js"></script>
    <script>
        $('#my_multi_select2').multiSelect({
            selectableOptgroup: true
        });
        function refuse() {
            $('#myform').attr('action', '?action=check_vendor&handle_type=refuse&id={$data["id"]}&admin_name={$_REQUEST['admin_name']}');
            $('#myform').submit();
        }
    </script>
</body>
<!-- END BODY -->
</html>