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
    <script src="js/jquery-1.9.1.min.js"></script>
    <title>{$title}</title>
    <meta content="" name="description"/>
    {include "Admin::inc/html_head.tpl"}
    <style>
        table tr th {
            text-align: center;
        }

        table tr td input {
            width: 150px;
            height: 30px;
        }

        img {
            width: 180px;
            height: 180px;
        }
    </style>
</head>
<!-- END HEAD -->
<!-- BEGIN BODY -->

<body style="background:#FaFaFa !important">
<div class="portlet">
    <div class="portlet-title">
        <div class="caption">
            <i class="fa fa-reorder"></i>添加测试接口
        </div>
    </div>
    <div class="portlet-body">
        {if !empty($_REQUEST['id'])}
        <form action="?action=test_interface&tab=edit_submit" method="post" class="clearfix form-horizontal">
            {else}
            <form action="?action=test_interface&tab=add_submit" method="post" class="clearfix form-horizontal">
                {/if}
                <div class="form-body">
                    <input type="hidden" name="id" value="{$info['id']}"/>
                    <input type="hidden" name="submit" value="1"/>

                    <div class="clearfix">
                        <div class="form-group col-md-9">
                            <label class="col-md-3 control-label">接口名称</label>

                            <div class="col-md-9">
                                <input type="text" class="form-control input-sm" placeholder="接口名称"
                                       name="interface_name"
                                       value="{$info['interface_name']}">
                            </div>
                        </div>
                        <div class="form-group col-md-9">
                            <label class="col-md-3 control-label">接口分类</label>

                            <div class="col-md-9">
                                <select class="form-control" name='category'>
                                    <option>请选择</option>
                                    {foreach $category as $k=>$v}
                                        <option  value=" {$v}" {if $v==$info['category']} selected="selected" {/if}>
                                          {$v}
                                        </option>
                                    {/foreach}
                                </select>
                                {*<input type="text" class="form-control input-sm" placeholder="接口分类" name="category"*}
                                       {*value="{$info['category']}">*}
                            </div>
                        </div>
                        <div class="form-group col-md-9">
                            <label class="col-md-3 control-label">接口说明</label>

                            <div class="col-md-9">
                                <textarea class="form-control" placeholder="描述接口的用途" rows="5"
                                          name="des">{$info['des']}</textarea>
                            </div>
                        </div>
                        <div class="form-group col-md-9">
                            <label class="col-md-3 control-label">传递类型</label>

                            <div class="col-md-9">
                                <label class="radio-inline">
                                    <input type="radio" name="type" value="POST"
                                           {if isset($info) && $info['type']=='POST'}checked="checked" {elseif empty($info['type'])}
                                           checked="checked" {/if}>
                                    POST
                                </label>
                                <label class="radio-inline">
                                    <input type="radio"
                                           name="type"   value="GET" {if isset($info) && $info['type']=='GET'} checked="checked" {/if}>
                                    GET
                                </label>
                            </div>
                        </div>

                    </div>


                    <div class="form-group col-md-9">
                        <label class="col-md-3 control-label">添加接口参数</label>

                        <div class="col-md-9">
                            <textarea class="form-control" placeholder="接口参数" rows="5"
                                      id="data" name="data">{$info['data']}</textarea>
                        </div>

                    </div>
                    <div class="clearfix"></div>
                    <div class="form-actions text-center">
                        <button type="reset" class="btn btn-default">
                            重置
                        </button>
                        <a onclick="submitAdd(this)" class="btn btn-success">
                            提交
                        </a>
                    </div>
            </form>
    </div>
</div>
</body>
<script>
    function submitAdd(e) {
        var id = $('input[name="id"]').val();
        var interface_name = $('input[name="interface_name"]').val();
        var category = $('select[name="category"]').val();
        var type = $('input[name="type"]:checked').val();
        var des = $('textarea[name="des"]').val();
        var data = $('textarea[name="data"]').val();
        var tab = 'testInterfaceAdd';
        YunSpace.api('test/interface.jsonp', {
                    id: id,
                    interface_name: interface_name,
                    category: category,
                    type: type,
                    des: des,
                    data: data,
                    tab: tab
                },
                function (data) {
                    if(data.status==1){
                        top.alert(data.msg);
                        window.location.href = 'interface'
                    }else{
                        top.alert(data.msg);
                    }

                })
    }
</script>
{static "core/yunspace.js"}
</html>