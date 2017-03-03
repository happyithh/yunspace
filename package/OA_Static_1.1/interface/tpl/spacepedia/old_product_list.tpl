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
</head>
<!-- END HEAD -->
<!-- BEGIN BODY -->

<body style="background:#FaFaFa !important">

<div class="portlet tabbable">
    <div class="portlet-title">
        <div class="caption">
            <i class="fa fa-search"></i>搜索条件
        </div>
    </div>
    <div class="portlet-body">
        <div class="portlet-tabs">
            <div class="clearfix"></div>
            <div>
                <form action="?" method="get" class="clearfix">
                    <input type="hidden" name="handle_type" value="{$_data['other']['handle_type']}">
                    <div class="form-body clearfix">
                        <div class="form-group col-md-5">
                            <label class="col-md-3 control-label">产品名称</label>

                            <div class="col-md-9">
                                <input type="text" class="form-control input-sm" placeholder="产品ID / 名称" name="search[title]" value="{$_REQUEST['search']['title']}">
                            </div>
                        </div>
                        <div class="form-group col-md-5">
                            <label class="col-md-3 control-label">城市</label>

                            <div class="col-md-9">
                                <input type="text" class="form-control input-sm" placeholder="请输入要搜索的城市" name="search[city]" value="{$_REQUEST['search']['city']}">
                            </div>
                        </div>
                        <div class="form-group col-md-5">
                            <label class="col-md-3 control-label">产品类型</label>

                            <div class="col-md-9">
                                <select class="form-control input-sm" name="search[category_id]">
                                    <option value=0>不限
                                    </option>
                                    {foreach $_data['other']['categoryList'][112] as $lk=>$lv}
                                        <option value="{$lk}" {if $lk==$_REQUEST['search']['category_id']} selected="selected" {/if}>{$lv}
                                    {/foreach}
                                </select>
                            </div>
                        </div>
                    </div>
                    <div class="form-actions">
                        <div class="" style="text-align: center">
                            <button type="submit" class="btn btn-primary" style="width: 150px">
                                <i class="fa fa-search"></i>
                                搜索
                            </button>
                        </div>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>


<div class="portlet">
    <div class="portlet-title">
        <div class="caption">
            <i class="fa fa-comments"></i>
            旧场地列表
        </div>
    </div>
    <div class="portlet-tabs" style="position:relative">
        <ul class="nav nav-tabs" style="overflow: inherit; padding-left: 100px">
            <li class="{if $_data['other']['handle_type']=='abandon'}active{/if}">
                <a href="?{if !empty($_REQUEST['search'])}handle_type=abandon&{$_data['other']['urls']}{else}list_type=product&handle_type=abandon{/if}">已丢弃</a>
            </li>
            <li class="{if $_data['other']['handle_type']=='convert'}active{/if}">
                <a href="?{if !empty($_REQUEST['search'])}handle_type=convert&{$_data['other']['urls']}{else}list_type=product&handle_type=convert{/if}">已转换</a>
            </li>
            <li class="{if $_data['other']['handle_type']=='online'}active{/if}">
                <a href="?{if !empty($_REQUEST['search'])}handle_type=online&{$_data['other']['urls']}{else}list_type=product&handle_type=online{/if}">未转换</a>
            </li>
        </ul>
    </div>
    <div class="portlet-body">
        <div class="table-responsive clearfix">
            <table class="table table-striped table-bordered table-hover" id="data_table" style="word-break: break-all">
                <thead>
                <tr>
                    <th class="list_none">产品ID</th>
                    <th>产品名称</th>
                    <th>产品类型</th>
                    {*<th>供应商名称</th>*}
                    <th class="list_none">城市</th>
                    <th >面积</th>
                    <th class="list_none">创建时间</th>
                    <th class="list_none">更新时间</th>
                    {if $_data['other']['handle_type']=='online' || $_data['other']['handle_type']=='abandon'}
                        <th class="list_none">操作</th>
                    {/if}
                </tr>
                </thead>
                <tbody>
                {foreach $_data['rows'] as $k=>$v}
                    <tr>
                        <td class="list_none">{$v['id']}</td>
                        <td class="list_size">
                            {if $v['status']==2}
                                <a target="_blank" href="http://{Core::$urls['host']}/service_info/{md5($v['id'])}/{$v['id']}.html">{$v['product_name']}</a>
                                <span class="btn btn-warning btn-xs">审核中</span>
                            {elseif $v['status']==3}
                                {$v['product_name']}
                                <span class="btn btn-danger btn-xs">已拒绝</span>
                            {elseif $v['status']==-2}
                                {$v['product_name']}
                                <span class="btn btn-danger btn-xs">已删除</span>
                            {elseif $v['status']==1}
                                <a target="_blank" href="http://{Core::$urls['host']}/service_info/{md5($v['id'])}/{$v['id']}.html">{$v['product_name']}</a>
                                <span class="btn btn-success btn-xs">上线</span>
                            {elseif $v['status']==0}
                                {$v['product_name']}
                                <span class="btn btn-success btn-xs">下线</span>
                            {/if}
                        </td>
                        <td class="list_size">
                            {$_data['other']['_category'][$v['category_id']][0]}
                        </td>
                        {*<td class="list_size">{$v['vendor_name']}</td>*}
                        <td class="list_none">{$v['attr_new'][46]}</td>
                        <td class="list_size">{$v['product_size']}</td>
                        <td class="list_none">{date('Y-m-d H:i:s',$v['create_time'])}</td>
                        <td class="list_none">{if $v['update_time']>1430713953}{date('Y-m-d H:i:s',$v['update_time'])}{else}--{/if}</td>
                        {if $_data['other']['handle_type']=='online'}
                            <td>
                                <a href="#space_item" data-toggle="modal" data-pname="{$v['product_name']}" data-pid="{$v['id']}" class="btn btn-xs btn-info add_to_pedia">添加到场地百科</a>
                                <a href="?action=abandon_recover&product_id={$v['id']}&is_convert=-1" class="btn btn-xs btn-danger">丢弃</a>
                            </td>
                        {elseif $_data['other']['handle_type']=='abandon'}
                            <td>
                                <a href="?action=abandon_recover&product_id={$v['id']}&is_convert=0" class="btn btn-xs btn-success">恢复</a>
                            </td>
                        {/if}
                    </tr>
                {/foreach}
                </tbody>
            </table>
            <div class="pull-right">
                <ul class="pagination">
                    {if $_data['page']['dpll']}
                        <li class="prev">
                            <a href="{$_data['page']['dup']}1" title="First"><i class="fa fa-angle-double-left"></i></a>
                        </li>
                        <li class="prev">
                            <a href="{$_data['page']['dup']}{$_data['page']['dp']-1}" title="Prev"><i class="fa fa-angle-left"></i></a>
                        </li>
                    {else}
                        <li class="prev disabled">
                            <a href="#" title="First"><i class="fa fa-angle-double-left"></i></a>
                        </li>
                        <li class="prev disabled">
                            <a href="#" title="Prev"><i class="fa fa-angle-left"></i></a>
                        </li>
                    {/if}
                    {for $i=$_data['page']['dpl'] to $_data['page']['dpr']}
                        <li{if $i==$_data['page']['dp']} class="active"{/if}>
                            <a href="{$_data['page']['dup']}{$i}">{$i}</a>
                        </li>
                    {/for}
                    <li class="disabled">
                        <a> {$_data['page']['dtp']}
                            ( {$_data['page']['dp']*$_data['page']['dn']}
                            /{$_data['page']['dt']} )</a>
                    </li>

                    {if $_data['page']['dprr']}
                        <li class="next">
                            <a href="{$_data['page']['dup']}{$_data['page']['dp']+1}" title="Next"><i class="fa fa-angle-right"></i></a>
                        </li>
                        <li class="next">
                            <a href="{$_data['page']['dup']}{$_data['page']['dtp']}" title="Last"><i class="fa fa-angle-double-right"></i></a>
                        </li>
                    {else}
                        <li class="next disabled">
                            <a href="#" title="Next"><i class="fa fa-angle-right"></i></a>
                        </li>
                        <li class="next disabled">
                            <a href="#" title="Last"><i class="fa fa-angle-double-right"></i></a>
                        </li>
                    {/if}
                </ul>
            </div>
        </div>
    </div>
</div>


{*添加到已有百科弹出层*}
<div class="modal fade" id="space_item" tabindex="-1" role="basic" aria-hidden="true" style="display: none;">
    <div class="modal-dialog">
        <div class="modal-content">
                <div class="modal-body">
                    <table class="table">
                        <thead>
                        <th width="150px;">选择已有百科</th>
                        </thead>
                        <tr>
                            <td>
                                <label class="control-label">输入场地百科名称</label>
                            </td>
                            <td>
                                <input id="space_name" name="space_name" data-provide="typeahead" class="form-control input-lg" type="text">
                            </td>
                        </tr>
                        <tr>
                            <td colspan="2">
                                <label class="control-label">
                                    <span class="required" aria-required="true">*</span>
                                    如果后台没有您输入的场地百科名称，则为您新创建一个场地百科
                                </label>
                            </td>
                        </tr>
                    </table>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
                    <a href="javascript:;" class="btn btn-info convert_submit" data-pid="">确定</a>
                </div>
            </form>
        </div>
    </div>
</div>



<!-- BEGIN JAVASCRIPTS(Load javascripts at bottom, this will reduce page load time) -->
<!-- BEGIN CORE PLUGINS -->
<script src="{$_assets}plugins/jquery-1.11.0.min.js"
        type="text/javascript"></script>
<script src="{$_assets}scripts/_page.js"></script>
<script src="{$_assets}plugins/bootstrap/js/bootstrap.min.js"
        tab="text/javascript"></script>
<script type="text/javascript" src="{$_assets}plugins/select2/select2.min.js"></script>
<script type="text/javascript" src="js/moment.min.js"></script>
<script type="text/javascript" src="js/zh-cn.js"></script>
<script type="text/javascript" src="js/bootstrap-datetimepicker.min.js"></script>
<link rel="stylesheet" type="text/css" href="{$_assets}plugins/typeahead/typeahead.css">
<script src="{$_assets}plugins/typeahead/typeahead.bundle.min.js" type="text/javascript"></script>
<script>
    $(document).ready(function(){
        $('.date').datetimepicker({
            format: 'YYYY-MM-DD',
            locale: 'zh-cn'
        });

        var typeahead_event = new Bloodhound({
            datumTokenizer: function (d) {
                console.log(d);
                return Bloodhound.tokenizers.whitespace(d.name);
            },
            queryTokenizer: Bloodhound.tokenizers.whitespace,
            limit: 10,
            remote: 'http://{Core::$urls['host']}/static/api/spacepedia/auto/complete.jsonp?q=%QUERY'
        });
        typeahead_event.initialize();
        $('#space_name').typeahead(null, {
            name: 'name',
            displayKey: 'name',
            source: typeahead_event.ttAdapter()
        });

    });
    $(".convert_submit").click(function(){
        var space_name= $.trim($('#space_name').val());
        var product_id=$(this).data('pid');
        window.location.href="?action=convert&space_name="+space_name+"&id="+product_id;
    });

    $('.add_to_pedia').click(function(){
        $('.convert_submit').data("pid",$(this).data("pid"));
        $("#space_name").val($(this).data('pname'));
    });


</script>
</body>
<!-- END BODY -->
</html>