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
</head>
<!-- END HEAD -->
<!-- BEGIN BODY -->

<body style="background:#FaFaFa !important">
<!-- BEGIN PAGE HEADER-->
<h3 class="page-title" style="float: left;">
    供应商信息介绍页
</h3>
<a href="javascript:history.go(-1)" class="back"><
    <返回
</a>

<div class="clear"></div>
<div class="portlet">
    <div class="portlet-body">
        <div>
            <div class="service_content">
                <div class="container-fluid">
                    <form action="?action=pass&id={$data['id']}" method="post" id="myform">
                        <div class="row form-horizontal">
                            <div class="col-md-12" style=" background-color: #f8f8f8; padding-top: 20px">
                                <div class="form-group">
                                    <label class="col-md-2 control-label"><b>供应商名称：</b></label>

                                    <div class="col-md-9">
                                        <input class="form-control input-lg" type="text" value="{$data['vendor_name']}" disabled>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="col-md-2 control-label"><b>服务范围：</b></label>

                                    <div class="col-md-9">
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
                                </div>
                                <div class="form-group">
                                    <label class="col-md-2 control-label"><b>品牌名称</b></label>

                                    <div class="col-md-9">
                                        <input class="form-control input-lg" type="text" value="{$data['base_info']['品牌名称']}" disabled>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="col-md-2 control-label"><b>地址</b></label>

                                    <div class="col-md-9">
                                        <input class="form-control input-lg" type="text" value="{$data['addr']}" disabled>
                                    </div>
                                </div>
                                {foreach $_vendor_attr as $k=>$v}
                                    <div class="form-group">
                                        <label class="col-md-2 control-label"><b>{$k}</b></label>

                                        <div class="col-md-9">
                                            <input class="form-control input-lg" type="text" value="{$data['attr'][$k]}" disabled>
                                        </div>
                                    </div>
                                {/foreach}
                                <div class="form-group">
                                    <label class="col-md-2 control-label"><b>业务性质</b></label>

                                    <div class="col-md-9">
                                        <textarea class="form-control" rows="3" disabled>{$data['base_info']['业务性质']}</textarea>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="col-md-2 control-label"><b>业务范围</b></label>

                                    <div class="col-md-9">
                                        <textarea class="form-control" rows="3" disabled>{$data['base_info']['业务范围']}</textarea>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="col-md-2 control-label"><b>团队简介</b></label>

                                    <div class="col-md-9">
                                        <textarea class="form-control" rows="3" disabled>{$data['base_info']['团队简介']}</textarea>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="col-md-2 control-label"><b>供应商介绍：</b></label>

                                    <div class="col-md-9">
                                        <textarea disabled name="data[des]" class="form-control" rows="5">{$data['des']}</textarea>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="col-md-2 control-label"><b>公司LOGO：</b></label>

                                    <div class="col-md-9 col-sm-12">
                                        <img src="{$data['logo']}" style="width: 200px; height: 150px;"/>
                                    </div>
                                </div>
                                {if $_REQUEST['handle_type']=='reject'}
                                    <div class="form-group">
                                        <label class="col-md-2 control-label"><b>拒绝理由：</b></label>

                                        <div class="col-md-9 col-sm-12">
                                            <textarea disabled class="form-control" rows="5">{$data['reject_reason']}</textarea>
                                        </div>
                                    </div>
                                {/if}
                                {if $_REQUEST['handle_type']=='waiting'}
                                    <div class="form-group">
                                        <label class="col-md-2 control-label"><b>请输入拒绝理由：</b></label>

                                        <div class="col-md-9 col-sm-12">
                                            <textarea id="refuseReason" name="reason" class="form-control" rows="3"></textarea>
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <div class="form-actions text-center">
                                            {*<a href="?action=pass&id={$data['id']}" class="btn btn-primary">通过</a>*}
                                            <button type="submit" class="btn btn-primary">
                                                通过
                                            </button>
                                            <button type="button" class="btn btn-danger" onclick="refuse()">
                                                拒绝
                                            </button>
                                        </div>
                                    </div>
                                {/if}
                            </div>
                        </div>
                    </form>
                </div>
            </div>
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
            $('#myform').attr('action', '?action=refuse&id={$data["id"]}');
            $('#myform').submit();
        }
    </script>
</body>
<!-- END BODY -->
</html>