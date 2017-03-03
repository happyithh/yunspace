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
    <style>
        .cate:hover {
            font-weight: bold;
        }

        .position {
            position: absolute;
            right: 0px
        }

        @media (max-width: 1600px ) and (min-width: 990px) {
            .pull-right.butt-2 {
                width: 120px;
                top: 3px;
                padding-top: 0 !important;
            }

        }
    </style>
</head>
<!-- END HEAD -->
<!-- BEGIN BODY -->
<body style="background:#FaFaFa !important">


<div class="portlet tabbable">
<div class="portlet-title">
    <div class="caption">
        <i class="fa fa-database"></i>{$_table['name']}
    </div>
</div>
<div class="portlet-body">
    <div class="portlet-tabs">
        <ul class="nav nav-tabs"
            style="overflow: inherit; padding-left: 100px">
            <li style="padding: 5px 4px 0 0">
                <div>
                    <a class="btn btn-success" href="?action=add"><i class="fa fa-plus"></i></a>
                </div>
            </li>
        </ul>
        <div class="clearfix"></div>
        <div class="tab-content">
            <div class="tab-pane active">
                <div class="dd" id="nestable_list_3">


                    {*{$_category_tree|var_dump}*}
                    {*{$_category_info|var_dump}*}
                    <div class="row">
                        <div class="col-md-12">
                            <div class="tabbable tabbable-custom">
                                <div class="tab-content">
                                    <div class="tab-pane active" id="tab_1_1">
                                        {foreach $_category_tree[0] as $k=>$v}
                                            {if $v eq ''}
                                                {assign var="v" value="`$_category_info[$k][0]`"}
                                            {/if}
                                            <div class="col-md-12 cates" style="background:#f4f4f4;margin-bottom: 10px;">
                                                <h3 class="pull-left" style="line-height:40px">{$k}
                                                    .
                                                    {if $_category_info[$k][2]>=90}
                                                        <span class="label label-danger">已删除</span>
                                                    {/if}
                                                    {if $_category_info[$k][2]>4&&$_category_info[$k][2]<10}
                                                        <span class="label label-warning">已隐藏</span>
                                                    {/if}
                                                    <a href="?action=info&ids[]={$k}">{$v}</a>
                                                </h3>

                                                <div class=" pull-right butt-1" style="display:none;padding-top:10px;">
                                                    <a class="btn btn-default " href="?action=info&ids[]={$k}" style="margin-left:5px;">
                                                        <i class="fa fa-bars"></i>列表
                                                    </a>
                                                    <a class="btn btn-default" href="?action=edit&ids[]={$k}" style="margin-left:5px;">
                                                        <i class="fa fa-pencil"></i>编辑
                                                    </a>
                                                    {if $_category_info[$k][2]<90}
                                                        {if $_category_info[$k][2]>-1&&$_category_info[$k][2]<5}
                                                            <a class="btn btn-default" href="?action=update&ids[]={$k}&data[status]=5" style="margin-left:5px;">
                                                                <i class="fa fa-eye-slash"></i>隐藏
                                                            </a>
                                                        {elseif $_category_info[$k][2]>4&&$_category_info[$k][2]<10}
                                                            <a class="btn btn-default" href="?action=update&ids[]={$k}&data[status]=1" style="margin-left:5px;">
                                                                <i class="fa fa-eye-slash"></i>显示</a>
                                                        {/if}
                                                        <a class="btn btn-default " href="?action=update&ids[]={$k}&data[status]=90" style="margin-left:5px;">
                                                            <i class="fa fa-trash-o"></i>删除</a>
                                                    {else}
                                                        <a class="btn btn-default " href="?action=update&ids[]={$k}&data[status]=1" style="margin-left:5px;">
                                                            <i class="fa fa-trash-o"></i>恢复</a>
                                                        {if $_category_tree[$k]}
                                                            <a href="?action=delete&ids[]={$k}"
                                                               class="btn btn-default"><i class="fa fa-times"></i>
                                                                彻底删除</a>
                                                        {else}
                                                            <a href="?action=delete&ids[]={$k}"
                                                               class="btn btn-default"><i class="fa fa-times"></i>
                                                                彻底删除</a>
                                                        {/if}
                                                    {/if}
                                                </div>
                                            </div>
                                            <div class="clearfix"></div>
                                            <div class="row margin-bottom-20 " style="padding:0px;">
                                                {foreach $_category_info as $key=>$v}
                                                    {if $v[3] eq $k}
                                                        <div class="col-md-3 col-sm-6  col-xs-12 cate" style="margin-bottom:10px;">
                                                            <div class="col-md-12 cate cate_w" style="background:#f4f4f4;">
                                                                <p class="pull-left" style="line-height:40px;">{$key}
                                                                    .
                                                                    {if $_category_info[$key][2]>=90}
                                                                        <span class="label label-danger">已删除</span>
                                                                    {/if}
                                                                    {if $_category_info[$key][2]>4&&$_category_info[$key][2]<10}
                                                                        <span class="label label-warning">已隐藏</span>
                                                                    {/if}
                                                                    <a href="?action=productInfo&ids[]={$key}">{$v[0]}</a>
                                                                </p>

                                                                <div class="">
                                                                    <div class="pull-right butt-2" style="display:none;padding-top:10px;z-index:999; position:absolute;right:0px;">
                                                                        <a class="btn btn-default btn-xs" href="?action=productInfo&ids[]={$key}" style="margin-left:5px;">
                                                                            <i class="fa fa-bars"></i>列表
                                                                        </a>
                                                                        <a class="btn btn-default btn-xs" href="?action=edit&ids[]={$key}" style="margin-left:5px;">
                                                                            <i class="fa fa-pencil"></i>编辑
                                                                        </a>
                                                                        {if $_category_info[$key][2]<90}
                                                                            {if $_category_info[$key][2]>-1&&$_category_info[$key][2]<5}
                                                                                <a class="btn btn-default btn-xs" href="?action=update&ids[]={$key}&data[status]=5" style="margin-left:5px;">
                                                                                    <i class="fa fa-eye-slash"></i>隐藏
                                                                                </a>
                                                                            {elseif $_category_info[$key][2]>4&&$_category_info[$key][2]<10}
                                                                                <a class="btn btn-default btn-xs" href="?action=update&ids[]={$key}&data[status]=1" style="margin-left:5px;">
                                                                                    <i class="fa fa-eye-slash"></i>显示</a>
                                                                            {/if}
                                                                            <a class="btn btn-default btn-xs" href="?action=update&ids[]={$key}&data[status]=90" style="margin-left:5px;">
                                                                                <i class="fa fa-trash-o"></i>删除</a>
                                                                        {else}
                                                                            <a class="btn btn-default btn-xs" href="?action=update&ids[]={$key}&data[status]=1" style="margin-left:5px;">
                                                                                <i class="fa fa-trash-o"></i>恢复</a>
                                                                            {if $_category_tree[$key]}
                                                                                <a href="?action=delete&ids[]={$key}"
                                                                                   class="btn btn-default btn-xs" style="margin-left:5px;"><i class="fa fa-times"></i>
                                                                                    彻底删除</a>
                                                                            {else}
                                                                                <a href="?action=delete&ids[]={$key}"
                                                                                   class="btn btn-default btn-xs" style="margin-left:5px;"><i class="fa fa-times"></i>
                                                                                    彻底删除</a>
                                                                            {/if}
                                                                        {/if}
                                                                        <div class="clearfix"></div>

                                                                    </div>
                                                                </div>
                                                                <div class="clearfix"></div>
                                                            </div>
                                                        </div>
                                                    {/if}
                                                {/foreach}
                                            </div>
                                        {/foreach}
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>


                    <!-- BEGIN JAVASCRIPTS(Load javascripts at bottom, this will reduce page load time) -->
                    <!-- BEGIN CORE PLUGINS -->
                    <script src="{$_assets}plugins/jquery-1.11.0.min.js"
                            type="text/javascript"></script>
                    <script src="{$_assets}plugins/jquery-migrate-1.2.1.min.js"
                            type="text/javascript"></script>
                    <!-- IMPORTANT! Load jquery-ui-1.10.3.custom.min.js before bootstrap.min.js to fix bootstrap tooltip conflict with jquery ui tooltip -->
                    <script src="{$_assets}plugins/jquery-ui/jquery-ui-1.10.3.custom.min.js"
                            type="text/javascript"></script>
                    <script src="{$_assets}plugins/bootstrap/js/bootstrap.min.js"
                            type="text/javascript"></script>
                    <script src="{$_assets}plugins/bootstrap-hover-dropdown/bootstrap-hover-dropdown.min.js"
                            type="text/javascript"></script>
                    <script src="{$_assets}plugins/jquery-slimscroll/jquery.slimscroll.min.js"
                            type="text/javascript"></script>
                    <script src="{$_assets}plugins/jquery.blockui.min.js"
                            type="text/javascript"></script>
                    <script src="{$_assets}plugins/uniform/jquery.uniform.min.js"
                            type="text/javascript"></script>
                    <!-- END CORE PLUGINS -->
                    <link rel="stylesheet" type="text/css" href="{$_assets}plugins/jquery-nestable/jquery.nestable.css"/>
                    <!-- BEGIN PAGE LEVEL SCRIPTS -->
                    <script src="{$_assets}plugins/jquery-nestable/jquery.nestable.js"></script>
                    <!-- END PAGE LEVEL SCRIPTS -->
                    <script src="{$_assets}scripts/ui-nestable.js"></script>
                    <!-- BEGIN PAGE LEVEL PLUGINS -->
                    <script type="text/javascript"
                            src="{$_assets}plugins/select2/select2.min.js"></script>
                    <script type="text/javascript"
                            src="{$_assets}plugins/datatables/media/js/jquery.dataTables.min.js"></script>
                    <script type="text/javascript"
                            src="{$_assets}plugins/datatables/plugins/bootstrap/dataTables.bootstrap.js"></script>
                    <!-- END PAGE LEVEL PLUGINS -->
                    <!-- BEGIN PAGE LEVEL SCRIPTS -->
                    <script src="{$_assets}scripts/_page.js"></script>
                    <script>
                        $(document).ready(function () {
                            $(".cates").each(function (index, dom) {
                                $(dom).hover(function () {
                                    $(".butt-1").eq(index).show();
                                }, function () {
                                    $(".butt-1").eq(index).hide();
                                })
                            });
                            $(".cate").each(function (index, dom) {
                                $(dom).hover(function () {
                                    $(".butt-2").eq(index / 2).show();
                                }, function () {
                                    $(".butt-2").eq(index / 2).hide();
                                })
                            });

                            //响应式bug清除
//           var width=$(".cate_w").width();
//           alert(width);
//            if(width<=360){
//                 var html="<div class='clearfix'></div>";
//                $(html).before(".cate_w");
//                $(".butt-2").removeClass("position");
//            }else{
//                $(".butt-2").addClass("position");
//            }
                        })
                    </script>
</body>

<!-- END BODY -->
</html>