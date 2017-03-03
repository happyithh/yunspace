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
    <!-- IMPORTANT! Load jquery-ui-1.10.3.custom.min.js before bootstrap.min.js to fix bootstrap tooltip conflict with jquery ui tooltip -->
    <script src="{$_assets}plugins/jquery-1.11.0.min.js" type="text/javascript"></script>
    <script src="{$_assets}plugins/jquery-ui/jquery-ui-1.10.3.custom.min.js" type="text/javascript"></script>
    <script src="{$_assets}plugins/bootstrap/js/bootstrap.min.js" type="text/javascript"></script>
    <script src="{$_assets}plugins/bootstrap-hover-dropdown/bootstrap-hover-dropdown.min.js" type="text/javascript"></script>
    <script src="{$_assets}plugins/jquery-slimscroll/jquery.slimscroll.min.js" type="text/javascript"></script>
    <script src="{$_assets}plugins/jquery.blockui.min.js" type="text/javascript"></script>
    <script src="{$_assets}plugins/uniform/jquery.uniform.min.js" type="text/javascript"></script>
    <!-- END CORE PLUGINS -->
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
    <link rel="stylesheet" type="text/css" href="{$_assets}plugins/bootstrap-wysihtml5/bootstrap-wysihtml5.css"/>
    <script type="text/javascript" src="{$_assets}plugins/bootstrap-wysihtml5/wysihtml5-0.3.0.js"></script>
    <script type="text/javascript" src="{$_assets}plugins/bootstrap-wysihtml5/bootstrap-wysihtml5.js"></script>
    <link rel="stylesheet" type="text/css" href="{$_assets}plugins/typeahead/typeahead.css">
    <script src="{$_assets}plugins/typeahead/typeahead.bundle.min.js" type="text/javascript"></script>
    <link rel="stylesheet" type="text/css" href="{$_assets}plugins/jquery-tags-input/jquery.tagsinput.css"/>
    <script type="text/javascript" src="{$_assets}plugins/jquery-tags-input/jquery.tagsinput.min.js"></script>


</head>
<!-- END HEAD -->
<!-- BEGIN BODY -->

<body style="background:#FaFaFa !important">
<div class="portlet tabbable">
<div class="portlet-title">
    <div class="caption">
        <i class="fa fa-database"></i>帮助中心填写
    </div>
</div>

<form class="form-horizontal" role="form" action="?" method="post">
    <input type="hidden" name="action" {if !empty($data[0]['id'])}value ='edit'{else} value="add" {/if} >
    <input type="hidden" name="id" value="{$data[0]['id']}" >
    <input type="hidden" name="submit" value="1" >

<div class="form-actions text-center">
    <div class="portlet-body form text-center">
        <div class="form-body" >
            <div class="row" >
                <div class="col-md-12">
                    <div class="form-group" >
                        <label class="control-label col-md-1">帮助类型</label>
                        <div class="col-md-11"  style="text-align:center">
                            <select class="form-control" name="category" >
                                <option>请选择</option>
                                {foreach $category as $k=>$v}
                                        <option value=" {$v}" {if $v==$data[0]['category']} selected="selected" {/if}>
                                            {$v}
                                        </option>

                                {/foreach}
                            </select>
                        </div>
                    </div>
                </div>
            </div>
            <div class="row" >
                <div class="col-md-12">
                    <div class="form-group" >
                        <label class="control-label col-md-1">帮助标题</label>
                        <div class="col-md-11" >
                            <input type="text" class="form-control"  placeholder="例如：订单如何预订？" name="title" value="{$data[0]['title']}">
                        </div>
                    </div>
                </div>
                </div>

            <div class="row">
                <div class="col-md-12">
                    <div class="form-group">
                        <label class="control-label col-md-1">服务描述</label>
                        <div class="col-md-11">
                            {include "Admin::inc/html_umeditor.tpl" name="contents" value=$data[0]['contents'] height=300}
                        </div>
                    </div>
                </div>
            </div>

            </div>
            </div>
        </div>
    </div>
</div>
<div  style="margin-left: 180px;">
    <button type="reset" class="btn btn-default">
        重置
    </button>
    <button type="submit" class="btn btn-success">
        提交
    </button>
</div>
</form>
</div>
<script>
    jQuery(document).ready(function () {
        $('.wysihtml5').wysihtml5();
        $(".tags_select2").each(function () {
            $(this).select2({
                tags: $(this).data('values').split(',')
            })
        });
        $('.tags').tagsInput({
            width: 'auto'
        });
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