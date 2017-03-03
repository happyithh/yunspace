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
    <script src="{$_assets}plugins/jquery-1.11.0.min.js" type="text/javascript"></script>
    <style>
        h5{ background-color: #f8f8f8; padding: 10px;}
        .form-actions{ margin-top: -15px;}
        ul li{ list-style: none;}
        .tab-pane{ padding-top: 10px;}
        .add-first{ width: 30%; padding: 0px 15px;}
        .add-second{ width: 30%; padding:0px 15px;}
        .add-second1{ width: 30%; padding:0px 15px;}
        @media (max-width: 768px){
            .add-first{ width: 100%;}
            .add-second{ width: 100%;}
            .add-second1{ width: 100%;}
        }
    </style>
</head>
<!-- END HEAD -->
<!-- BEGIN BODY -->
<body style="background:#FaFaFa !important">


<div class="portlet tabbable">
<div class="portlet-title">
    <div class="caption">
        <i class="fa fa-database"></i>产品属性设置
    </div>

</div>

<div class="portlet-body form">
<form class="form-horizontal" role="form" action="?" method="post">


<div class="tabbable tabbable-custom boxless" style="padding: 20px ;">
<ul class="nav nav-tabs">
    <li class="active">
        <a href="form_image_crop.html#tab_1" data-toggle="tab">空间服务</a>
    </li>
    <li>
        <a href="form_image_crop.html#tab_2" data-toggle="tab">配套服务</a>
    </li>

</ul>
<div class="tab-content" style="height: auto; overflow: hidden;">
<div class="tab-pane active" id="tab_1">
<div class="col-md-12">
<div style="margin-bottom: 20px;">
    <button type="button" class="btn btn-primary">
       <span class="glyphicon glyphicon-plus add-bf">&nbsp;添加一级分类</span>
    </button>
    <div class="form-group add-first">
    <input type="text" class="form-control input-lg" style="margin-top: 10px;">
        <button type="button" class="btn btn-success add-confirm" style="margin-top: 10px;">确定</button>
    </div>
</div>
    <ul>
        <li>
            <div class="checkbox">
                <label>
                    <input type="checkbox"> 地理位置<a href="#" class="btn btn-primary btn-xs add-bs" style="margin-left: 10px;">添加</a>
                </label>
            </div>
            <ul>
                <li>
                    <div class="checkbox">
                        <label>
                            <input type="checkbox"> 所属城市
                        </label>
                    </div>
                </li>
                <li>
                    <div class="checkbox">
                        <label>
                            <input type="checkbox"> 具体地址
                        </label>
                    </div>
                </li>
                <li>
                    <div class="checkbox">
                        <label>
                            <input type="checkbox"> 行政区域
                        </label>
                    </div>
                </li>
                <li>
                    <div class="checkbox">
                        <label>
                            <input type="checkbox"> 所属商圈
                        </label>
                    </div>
                </li>
                <li>
                    <form class="form-horizontal">
                        <div class="form-group add-second">
                            <input type="text" class="form-control">
                            <button type="button" class="btn btn-success btn-xs add-cs" style="margin-top: 10px;">确定</button>
                        </div>
                    </form>
                </li>
            </ul>

        </li>

    </ul>
    <ul>
        <li>
            <div class="checkbox">
                <label>
                    <input type="checkbox"> 使用规格<a href="#" class="btn btn-primary btn-xs add-bs1" style="margin-left: 10px;">添加</a>
                </label>
            </div>
            <ul>
                <li>
                    <div class="checkbox">
                        <label>
                            <input type="checkbox"> 用电量
                        </label>
                    </div>
                </li>
                <li>
                    <div class="checkbox">
                        <label>
                            <input type="checkbox"> 空间吊点
                        </label>
                    </div>
                </li>
                <li>
                    <div class="checkbox">
                        <label>
                            <input type="checkbox"> 灯具高度
                        </label>
                    </div>
                </li>
                <li>
                    <form class="form-horizontal">
                        <div class="form-group add-second1">
                            <input type="text" class="form-control">
                            <button type="button" class="btn btn-success btn-xs add-cs1" style="margin-top: 10px;">确定</button>
                        </div>
                    </form>
                </li>
            </ul>

        </li>

    </ul>

</div>

</div>
<div class="tab-pane" id="tab_2">
    <div class="col-md-12">
        <div style="margin-bottom: 20px;">
            <button type="button" class="btn btn-primary">
                <span class="glyphicon glyphicon-plus add-bf">&nbsp;添加一级分类</span>
            </button>
            <div class="form-group add-first">
                <input type="text" class="form-control input-lg" style="margin-top: 10px;">
                <button type="button" class="btn btn-success add-confirm" style="margin-top: 10px;">确定</button>
            </div>
        </div>
        <ul>
            <li>
                <div class="checkbox">
                    <label>
                        <input type="checkbox"> 地理位置<a href="#" class="btn btn-primary btn-xs add-bs" style="margin-left: 10px;">添加</a>
                    </label>
                </div>
                <ul>
                    <li>
                        <div class="checkbox">
                            <label>
                                <input type="checkbox"> 所属城市
                            </label>
                        </div>
                    </li>
                    <li>
                        <div class="checkbox">
                            <label>
                                <input type="checkbox"> 具体地址
                            </label>
                        </div>
                    </li>
                    <li>
                        <div class="checkbox">
                            <label>
                                <input type="checkbox"> 行政区域
                            </label>
                        </div>
                    </li>
                    <li>
                        <div class="checkbox">
                            <label>
                                <input type="checkbox"> 所属商圈
                            </label>
                        </div>
                    </li>
                    <li>
                        <form class="form-horizontal">
                            <div class="form-group add-second">
                                <input type="text" class="form-control">
                                <button type="button" class="btn btn-success btn-xs add-cs" style="margin-top: 10px;">确定</button>
                            </div>
                        </form>
                    </li>
                </ul>

            </li>

        </ul>
        <ul>
            <li>
                <div class="checkbox">
                    <label>
                        <input type="checkbox"> 使用规格<a href="#" class="btn btn-primary btn-xs add-bs1" style="margin-left: 10px;">添加</a>
                    </label>
                </div>
                <ul>
                    <li>
                        <div class="checkbox">
                            <label>
                                <input type="checkbox"> 用电量
                            </label>
                        </div>
                    </li>
                    <li>
                        <div class="checkbox">
                            <label>
                                <input type="checkbox"> 空间吊点
                            </label>
                        </div>
                    </li>
                    <li>
                        <div class="checkbox">
                            <label>
                                <input type="checkbox"> 灯具高度
                            </label>
                        </div>
                    </li>
                    <li>
                        <form class="form-horizontal">
                            <div class="form-group add-second1">
                                <input type="text" class="form-control">
                                <button type="button" class="btn btn-success btn-xs add-cs1" style="margin-top: 10px;">确定</button>
                            </div>
                        </form>
                    </li>
                </ul>

            </li>

        </ul>

    </div>
</div>

</div>
</div>
</div>

<div class="form-actions text-center">
    <button type=" reset" class="btn btn-default">
        重置
    </button>
    <button type="submit" class="btn btn-success">
        提交
    </button>
</div>
</form>
</div>
<script type="text/javascript">
    $(document).ready(function(){
        $('.add-first').hide();
        $('.add-bf').click(function() {
           $('.add-first').toggle();
        });
        $('.add-confirm').click(function() {
            $('.add-first').hide();
        });

        $('.add-second').hide();
        $('.add-bs').click(function() {
            $('.add-second').toggle();
        });
        $('.add-cs').click(function() {
            $('.add-second').hide();
        });

        $('.add-second1').hide();
        $('.add-bs1').click(function() {
            $('.add-second1').toggle();
        });
        $('.add-cs1').click(function() {
            $('.add-second1').hide();
        });
    });
</script>

<!-- BEGIN JAVASCRIPTS(Load javascripts at bottom, this will reduce page load time) -->
<!-- BEGIN CORE PLUGINS -->
<script src="{$_assets}plugins/jquery-migrate-1.2.1.min.js" type="text/javascript"></script>
<!-- IMPORTANT! Load jquery-ui-1.10.3.custom.min.js before bootstrap.min.js to fix bootstrap tooltip conflict with jquery ui tooltip -->
<script src="{$_assets}plugins/jquery-ui/jquery-ui-1.10.3.custom.min.js" type="text/javascript"></script>
<script src="{$_assets}plugins/bootstrap/js/bootstrap.min.js" type="text/javascript"></script>
<script src="{$_assets}plugins/bootstrap-hover-dropdown/bootstrap-hover-dropdown.min.js"
        type="text/javascript"></script>
<script src="{$_assets}plugins/jquery-slimscroll/jquery.slimscroll.min.js" type="text/javascript"></script>
<script src="{$_assets}plugins/jquery.blockui.min.js" type="text/javascript"></script>
<script src="{$_assets}plugins/uniform/jquery.uniform.min.js" type="text/javascript"></script>
<!-- END CORE PLUGINS -->
<!-- BEGIN PAGE LEVEL PLUGINS -->
<link rel="stylesheet" type="text/css" href="{$_assets}plugins/jquery-tags-input/jquery.tagsinput.css"/>
<link rel="stylesheet" type="text/css" href="{$_assets}plugins/typeahead/typeahead.css">
<link rel="stylesheet" type="text/css" href="{$_assets}plugins/bootstrap-wysihtml5/bootstrap-wysihtml5.css"/>
{*<link rel="stylesheet" type="text/css" href="{$_assets}plugins/select2/select2.css"/>*}
<script type="text/javascript" src="{$_assets}plugins/select2/select2.min.js"></script>
<script type="text/javascript" src="{$_assets}plugins/jquery-tags-input/jquery.tagsinput.min.js"></script>
<script src="{$_assets}plugins/typeahead/handlebars.min.js" type="text/javascript"></script>
<script src="{$_assets}plugins/typeahead/typeahead.bundle.min.js" type="text/javascript"></script>
<script type="text/javascript" src="{$_assets}plugins/datatables/media/js/jquery.dataTables.min.js"></script>
<script type="text/javascript" src="{$_assets}plugins/datatables/plugins/bootstrap/dataTables.bootstrap.js"></script>
<script type="text/javascript" src="{$_assets}plugins/bootstrap-wysihtml5/wysihtml5-0.3.0.js"></script>
<script type="text/javascript" src="{$_assets}plugins/bootstrap-wysihtml5/bootstrap-wysihtml5.js"></script>
<!-- END PAGE LEVEL PLUGINS -->
<!-- BEGIN PAGE LEVEL SCRIPTS -->
<script src="{$_assets}scripts/app.js"></script>
<script src="{$_assets}scripts/_page.js"></script>

</body>

<!-- END BODY -->
</html>