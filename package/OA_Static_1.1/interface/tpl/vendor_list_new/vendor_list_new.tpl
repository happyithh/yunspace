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
    <link href="style/media.css" rel="stylesheet" />
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
                    <div class="form-body clearfix">
                        <div class="form-group col-md-5">
                            <label class="col-md-3 control-label">供应商名称</label>

                            <div class="col-md-9">
                                <input type="text" class="form-control input-sm" placeholder="供应商ID / 名称"
                                       name="search[title]" value="{$_REQUEST['search']['title']}">
                            </div>
                        </div>
                        {if $type!=2}
                            <div class="form-group col-md-5">
                                <label class="col-md-3 control-label">城市</label>

                                <div class="col-md-9">
                                    {*<select class="form-control input-sm" name="search[city]">*}
                                        {*<option value=0>全部*}
                                        {*</option>*}
                                        {*{foreach $city as $key=>$value}*}
                                            {*<option {if {$_REQUEST['search']['city']==$value}}selected {/if}*}
                                                    {*value="{$value}">{$value}</option>*}
                                        {*{/foreach}*}
                                    {*</select>*}
                                    <input type="text" class="form-control input-sm" placeholder="请输入要搜索的城市"
                                           name="search[city]" value="{$_REQUEST['search']['city']}">
                                </div>
                            </div>
                        {/if}
                        {if !$type}
                            <div class="form-group col-md-5">
                                <label class="col-md-3 control-label">负责人</label>

                                <div class="col-md-9">
                                    <select class="form-control input-sm" name="search[admin_id]">
                                        <option value=0>全部
                                        </option>
                                        {foreach $_adminInfo as $key=>$value}
                                            <option {if {$_REQUEST['search']['admin_id']==$key}}selected {/if}
                                                    value="{$key}">{$value}</option>
                                        {/foreach}
                                    </select>
                                </div>
                            </div>
                        {/if}
                        <div class="form-group col-md-5">
                            <label class="col-md-3 control-label">服务分类</label>

                            <div class="col-md-9">
                                <select class="form-control input-sm" name="search[category_id]">
                                    <option value=0>不限
                                    </option>
                                    {function show_category level=0}
                                        {foreach $categoryList[$id] as $k=>$v}
                                            {if $v||$k==$_REQUEST['search']['category_id']}
                                                <option value="{$k}"
                                                        {if $k==$_REQUEST['search']['category_id']}selected="selected" {/if}>{str_repeat('&nbsp; ', $lv)}
                                                    {$v}
                                                </option>
                                                {if $categoryList[$k]}
                                                    {show_category data=$categoryList id=$k lv=$lv+1}
                                                {/if}
                                            {/if}
                                        {/foreach}
                                    {/function}
                                    {show_category data=$categoryList id=0 lv=1}
                                </select>
                            </div>
                        </div>
                        <div class="form-group col-md-5">
                            <label class="col-md-3 control-label">创建时间</label>

                            <div class="col-md-4">
                                <input type='text' class="form-control date" placeholder="请选择开始时间"
                                       name="search[start_time]" value="{$_REQUEST['search']['start_time']}"/>
                            </div>
                            <div class="col-md-4 col-md-offset-1">
                                <input type='text' class="form-control date" placeholder="请选择结束时间"
                                       name="search[end_time]" value="{$_REQUEST['search']['end_time']}"/>
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
            {if $type==1}
                我的供应商列表
            {else}
                所有供应商列表
            {/if}
        </div>
    </div>
    <div class="portlet-tabs">
        <ul class="nav nav-tabs" style="overflow: inherit; padding-left: 100px">
            <li class="{if $handle_type=='reject'}active{/if}">
                <a href="?handle_type=reject{if !empty($urls)}&{$urls}{/if}">审核拒绝</a>
            </li>
            <li class="{if $handle_type=='waiting'}active{/if}">
                <a href="?handle_type=waiting{if !empty($urls)}&{$urls}{/if}">审核中</a>
            </li>
            <li class="{if $handle_type=='offline'}active{/if}">
                <a href="?handle_type=offline{if !empty($urls)}&{$urls}{/if}">下线</a>
            </li>
            <li class="{if $handle_type=='online'}active{/if}">
                <a href="?handle_type=online{if !empty($urls)}&{$urls}{/if}">上线</a>
            </li>
            <li class="{if $handle_type=='all'}active{/if}">
                <a href="?handle_type=all{if !empty($urls)}&{$urls}{/if}">全部</a>
            </li>
        </ul>
    </div>
    <div class="portlet-body">
        <div class="table-responsive clearfix">
            <table class="table table-striped table-bordered table-hover" id="data_table" style="word-break: break-all">
                <thead>
                <tr>
                    <th class="list_none">供应商ID</th>
                    <th>供应商名称</th>
                    {if !$type}
                        <th>负责人</th>
                    {/if}
                    <th  class="list_none">产品总数</th>
                    <th  class="list_none">服务类型</th>
                    <th>城市</th>
                    <th class="list_none">创建时间</th>
                    <th>更新时间</th>
                    <th>状态</th>
                    <th>操作</th>
                </tr>
                </thead>
                <tbody>
                {foreach $_data['rows'] as $k=>$v}
                    <tr>
                        <td  class="list_none">{$v['id']}</td>
                        <td>
                            {$v['vendor_name']}
                            {if $v['create_by_quick'] ==1}
                                (后台快速创建)
                            {/if}

                            {if $v['create_by_quick'] ==2}
                                (供应商加盟)
                            {/if}
                            {if $v['create_by_quick'] == 3}
                            (数据采集)
                            {/if}
                        </td>
                        {if !$type}
                            <td>{$_adminInfo[$v['admin_id']]}</td>
                        {/if}
                        <td  class="list_none">{if $v['count_product']}{$v['count_product']}{else}-----{/if}</td>
                        <td  class="list_none">
                            {foreach $v['category_arr'] as $ck=>$cv}
                                {$categoryInfo[$cv][0]}&nbsp;
                            {/foreach}
                        </td>
                        <td>{$v['attr']['城市']}</td>
                        <td  class="list_none">{date('Y-m-d H:i:s',$v['create_time'])}</td>
                        <td>{date('Y-m-d H:i:s',$v['update_time'])}</td>
                        <td>{if $v['status'] == 1}上线
                            {elseif $v['status'] == 2}审核中
                            {elseif $v['status'] == 3}审核拒绝
                            {elseif $v['status'] == 4}上线（存在待审核商品）
                            {else}下线
                            {/if}
                        </td>
                        <td>
                            <a href="?action=detail&vendor_id={$v['id']}"
                               class="btn btn-success btn-xs"><i class="fa fa-pencil"></i>查看</a>
                            {if $is_admin}
                                <a href="javascript:;" data-vid="{$v['id']}" data-admin="{$v['admin_id']}" class="btn btn-primary btn-xs change_admin_button"><i class="fa fa-pencil"></i>分配</a>
                                {if $v['vendor_account_id']==0}
                                    <a href="javascript:;" data-vid="{$v['id']}"  class="btn btn-info btn-xs bind_account_button"><i class="fa fa-pencil"></i>设置联系人</a>
                                {/if}
                            {/if}
                        </td>
                    </tr>
                {/foreach}
                </tbody>
            </table>
            <div class="pull-left" style="width:30%; padding: 10px 0;">
            </div>
            <div class="pull-right">
                <ul class="pagination">
                    {if $_data['page']['dpll']}
                        <li class="prev">
                            <a href="{$_data['page']['dup']}1" title="First"><i class="fa fa-angle-double-left"></i></a>
                        </li>
                        <li class="prev">
                            <a href="{$_data['page']['dup']}{$_data['page']['dp']-1}" title="Prev"><i
                                        class="fa fa-angle-left"></i></a>
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
                            <a href="{$_data['page']['dup']}{$_data['page']['dp']+1}" title="Next"><i
                                        class="fa fa-angle-right"></i></a>
                        </li>
                        <li class="next">
                            <a href="{$_data['page']['dup']}{$_data['page']['dtp']}" title="Last"><i
                                        class="fa fa-angle-double-right"></i></a>
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


<div data-pid class="modal" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel"
     aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
                <h4 class="modal-title" id="myModalLabel">
                    更换负责人</h4>
            </div>
            <div class="modal-body">
                <div class="col-sm-12 input-group">
                    <div class="col-sm-12 select">
                        <input type="hidden" id="select2_change" class="form-control select2" name="admin_id">
                        <input type="hidden" name="vendor_id" value="{$data['id']}">
                    </div>
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">
                    取消
                </button>
                <button type="button" class="btn btn-success allocate_admin_submit">
                    确定
                </button>
            </div>
        </div>
    </div>
</div>



<div data-pid class="modal" id="bind_account" tabindex="-1" role="dialog" aria-labelledby="myModalLabel"
     aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-body">
                    <table class="table" id="list_info">
                        <thead>
                            <th width="150px;">添加联系人</th>
                            <th></th>
                        </thead>
                        <tr>
                            <td>
                                <label>请输入手机号</label>
                            </td>
                            <td>
                                <input type="text" class="col-md-12 form-control" name="phone">
                                <input type="hidden" name="vendor_id" value="{$data['id']}">
                            </td>
                        </tr>
                    </table>


                {*</div>*}
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">
                    取消
                </button>
                <button type="button" class="btn btn-success change_account_submit">
                    确定
                </button>
            </div>
        </div>
    </div>
</div>



<!-- BEGIN JAVASCRIPTS(Load javascripts at bottom, this will reduce page load time) -->
<!-- BEGIN CORE PLUGINS -->
<script src="{$_assets}plugins/jquery-1.11.0.min.js"
        type="text/javascript"></script>
<script src="{$_assets}plugins/bootstrap/js/bootstrap.min.js" type="text/javascript"></script>
<script type="text/javascript" src="{$_assets}plugins/select2/select2.min.js"></script>
<script src="{$_assets}scripts/_page.js"></script>
<script type="text/javascript" src="js/moment.min.js"></script>
<script type="text/javascript" src="js/zh-cn.js"></script>
<script type="text/javascript" src="js/bootstrap-datetimepicker.min.js"></script>
<script type="text/javascript">
    $(document).ready(function () {
        $('.date').datetimepicker({
            format: 'YYYY-MM-DD',
            locale: 'zh-cn'
        });
    });
    $('.change_admin_button').click(function () {
        console.log($(this).attr('data-admin'));
        $('#myModal').modal('show');
        $('#myModal input[name=vendor_id]').val($(this).attr('data-vid'));
        $("#select2_change").val($(this).attr('data-admin'));
    });

    //更换管理员列表
    $("#select2_change").select2({
        placeholder: "选择管理员",
        minimumInputLength: 1,
        ajax: { // instead of writing the function to execute the request we use Select2's convenient helper
            url: "http://{Core::$urls['host']}/static/api/administrator/auto/complete.jsonp",
            dataType: 'json',
            data: function (term, page) {
                return {
                    q: term, // search term
                    type:1 , //没有绑定任何供应商
                    page_limit: 10
                };
            },
            results: function (data, page) { // parse the results into the format expected by Select2.
                // since we are using custom formatting functions we do not need to alter remote JSON data
                return {
                    results: data.data.items
                };
            }
        },
        initSelection: function (element, callback) {
            var id = $(element).val();
            if (id !== "") {
                $.ajax("http://{Core::$urls['host']}/static/api/administrator/auto/complete.jsonp", {
                    data: {
                        id: id,
                        type:1  //没有绑定任何供应商
                    },
                    dataType: "json"
                }).done(function (data) {
                            callback(data.data.items[0]);
                        });
            }
        },
        formatResult: formatRepo, // omitted for brevity, see the source of this page
        formatSelection: formatRepoSelection, // omitted for brevity, see the source of this page
        escapeMarkup: function (m) {
            return m;
        } // we do not want to escape markup since we are displaying html in results
    });

    function formatRepo(repo) {
        if (repo.loading) return repo.text;
        return repo.full_name;
    }

    function formatRepoSelection(repo) {
        return repo.full_name || repo.text;
    }

    //更换负责人提交
    $('.allocate_admin_submit').click(function(){
        $.post("http://{Core::$urls['host']}/static/api/vendor/handle.jsonp", {
            admin_id: $("#select2_change").val(),
            vendor_id: $('#myModal input[name=vendor_id]').val(),
            action: "change_admin"
        }, function (data) {
            console.log(data);
            if (data.status == 1) {
                $('#myModal').modal('hide');
                window.location.reload();
            } else {
                alert(data.msg);
            }
        }, 'json')
    });

    //绑定账户
    $('.bind_account_button').click(function () {
        $('#bind_account').modal('show');
        $('#bind_account input[name=vendor_id]').val($(this).attr('data-vid'));
    });

    //联系人信息提交(供应商账户)
    $('.change_account_submit').click(function(){
        $.post("http://{Core::$urls['host']}/static/api/vendor/handle.jsonp", {
            phone: $('#bind_account input[name=phone]').val(),
            vendor_id: $('#bind_account input[name=vendor_id]').val(),
            action: "change_account"
        }, function (data) {
            console.log(data);
            if (data.status == 1) {
                $('#bind_account').modal('hide');
                top.alert(" "+data.msg);
                window.location.reload();
            } else {
                top.alert(data.msg);
            }
        }, 'json')
    });

</script>
</body>
<!-- END BODY -->
</html>