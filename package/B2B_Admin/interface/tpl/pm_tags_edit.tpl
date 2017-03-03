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
    <link rel="stylesheet" type="text/css" href="{$_assets}plugins/jquery-tags-input/jquery.tagsinput.css"/>
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
    <div class="portlet-body form">
        <form class="form-horizontal" role="form" action="?" method="post">
            <input type="hidden" name="action" value="{if $_REQUEST['ids']}update{else}insert{/if}">
            <input type="hidden" name="url_to" value="{$_REQUEST['url_to']}">
            <input type="hidden" name="ids[0]" value="{$_REQUEST['ids'][0]}">

            <div class="form-body">
                <div class="form-group">
                    <label class="col-md-3 control-label">上级标签</label>
                    <div class="col-md-6 col-sm-12">
                        {if !$_REQUEST['ids'][0] || $_REQUEST['type']=='parent_tags'}
                            <input class="form-control"  name="data[parent_id]" type="hidden" value="0">
                            <input class="form-control"  name="" type="text" disabled value="顶级">
                        {else}
                            <select class="form-control select2me" data-placeholder="Select..." name="data[parent_id]">
                                {*<option value="0">顶级</option>*}
                                {function show_category level=0}
                                    {foreach $_tags[$id] as $k=>$v}
                                        <option value="{$k}" {if $k==$_REQUEST['ids'][0] || $k==$_data['parent_id']}selected="selected" {/if}>{str_repeat(' . . ', $lv)}
                                            {$v}
                                        </option>
                                    {/foreach}
                                {/function}
                                {show_category data=$_tags id=0 lv=1}
                            </select>
                        {/if}
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-md-3 control-label">标签名</label>

                    <div class="col-md-6 col-sm-12">
                        <input type="text" class="form-control" placeholder="Tags Name" name="data[tags_name]" value="{$_data['tags_name']}">
                    </div>
                </div>
                {if $_REQUEST['ids'][0] && $_REQUEST['type']!='parent_tags'}
                <div class="form-group">
                    <label class="col-md-3 control-label">标签值</label>
                    <div class="col-md-6 col-sm-12">
                        <textarea class="form-control" rows="10" name="data[tags_value]">{$_data['tags_value']}</textarea>
                        <span>(每个值之间以逗号隔开)</span>
                    </div>

                </div>
                <div class="form-group">
                    <label class="col-md-3 control-label">标签类型</label>

                    <div class="col-md-6 radio-list">
                        <label class="col-md-3">单选
                            <input type="radio" class="form-control" name="data[tags_type]" value="0" {if $_data['tags_type']==0}checked {/if}>
                        </label>
                        <label class="col-md-3">多选
                            <input type="radio" class="form-control" name="data[tags_type]" value="1" {if $_data['tags_type']==1}checked {/if}>
                        </label>
                    </div>
                </div>
                {/if}
                <div class="form-group">
                    <label class="col-md-3 control-label">排序优先级</label>

                    <div class="col-md-3 col-sm-12">
                        <input type="text" class="form-control" placeholder="Sort" name="data[sort_weight]" value="{$_data['sort_weight']}">
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

    <!-- BEGIN JAVASCRIPTS(Load javascripts at bottom, this will reduce page load time) -->
    <!-- BEGIN CORE PLUGINS -->
    <script src="{$_assets}plugins/jquery-1.11.0.min.js" type="text/javascript"></script>
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
    <script type="text/javascript" src="{$_assets}plugins/select2/select2.min.js"></script>
    <script type="text/javascript" src="{$_assets}plugins/jquery-tags-input/jquery.tagsinput.min.js"></script>
    <script type="text/javascript" src="{$_assets}plugins/datatables/media/js/jquery.dataTables.min.js"></script>
    <script type="text/javascript" src="{$_assets}plugins/datatables/plugins/bootstrap/dataTables.bootstrap.js"></script>
    <!-- END PAGE LEVEL PLUGINS -->
    <!-- BEGIN PAGE LEVEL SCRIPTS -->
    <script src="{$_assets}scripts/app.js"></script>
    <script src="{$_assets}scripts/_page.js"></script>
    <script>
        jQuery(document).ready(function () {
            App.init();
            $('.tags').tagsInput({
                width: 'auto'
            });
        });
        var FormAttr = {
            attr_id: 0,
            add: function (o) {
                if (FormAttr.attr_id < 1) {
                    FormAttr.attr_id = $('#form_attr tr').size() + 10;
                }
                FormAttr.attr_id++;
                var newAttr = $(o).parents('table').find('.hidden').clone().removeClass('hidden');
                newAttr.appendTo('#form_attr');
                newAttr.find('input').each(function () {
                    $(this).attr('name', $(this).attr('name').replace('$$', FormAttr.attr_id));
                });
//                newAttr.find('input:eq(1)').tagsInput({
//                    width: 'auto'
//                });
            },
            remove: function (o) {
                $(o).parents('tr').remove();
            },
            up: function (o) {
                var tr = $(o).parents('tr');
                tr.after(tr.prev());
            },
            down: function (o) {
                var tr = $(o).parents('tr');
                tr.before(tr.next());
            }
        };
    </script>
</body>

<!-- END BODY -->
</html>