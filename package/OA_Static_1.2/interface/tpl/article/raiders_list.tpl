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
    {include "OA_Static::public_css/public_css.tpl"}

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
                    <input type="hidden" name="handle_type" value="{$handle_type}">
                    <div class="form-body clearfix">
                        <div class="form-group col-md-5">
                            <label class="col-md-3 control-label">文章名称</label>

                            <div class="col-md-9">
                                <input type="text" class="form-control input-sm" placeholder="文章ID / 标题关键字" name="search[title]" value="{$_REQUEST['search']['title']}">
                            </div>
                        </div>
                        <div class="form-group col-md-5">
                            <label class="col-md-3 control-label">作者</label>

                            <div class="col-md-9">
                                <input type="text" class="form-control input-sm" placeholder="作者名称" name="search[author]" value="{$_REQUEST['search']['author']}">
                            </div>
                        </div>
                        <div class="form-group col-md-5">
                            <label class="col-md-3 control-label">所属栏目</label>

                            <div class="col-md-9">
                                <select class="form-control input-sm" name="search[category_id]">
                                    <option value=''>全部</option>
                                    {foreach $category_name as $key=>$value}
                                        <option {if {$_REQUEST['search']['category_id']==$value['id']}}selected {/if} value="{$value['id']}">{if $value['parent']==0}{$value['name']}{else}&nbsp;&nbsp;---{$value['name']}{/if}</option>
                                    {/foreach}
                                </select>
                            </div>
                        </div>

                        <div class="form-group col-md-5">
                            <label class="col-md-3 control-label">状态</label>
                            <div class="col-md-9">
                                {*<input type="text" class="form-control input-sm" placeholder="状态" name="search[status]" value="{$_REQUEST['search']['status']}">*}
                                <select class="form-control input-sm" name="search[status]">
                                    <option value=''>全部
                                    </option>
                                    {foreach $status as $key=>$value}
                                        <option {if {$_REQUEST['search']['status']==$key}}selected {/if} value="{$key}">{$value}</option>
                                    {/foreach}
                                </select>
                            </div>
                        </div>


                        <div class="form-group col-md-5">
                            <label class="col-md-3 control-label">创建时间</label>
                            <div class="col-md-4">
                                <input type='text' class="form-control date" placeholder="请选择开始时间" name="search[start_time]" value="{$_REQUEST['search']['start_time']}"/>
                            </div>
                            <div class="col-md-4 col-md-offset-1">
                                <input type='text' class="form-control date" placeholder="请选择结束时间" name="search[end_time]" value="{$_REQUEST['search']['end_time']}"/>
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
    </div>
    <div class="portlet-tabs" style="position:relative">
        <div style="position: absolute;left:10px;bottom:0px;color: #444444;font-size: 16px"><a href="?action=add" class="btn btn-success"><span class="glyphicon glyphicon-plus"></span>添加文章</a></div>
        <div style="position: absolute;right:20px;bottom:0px;color: #444444;font-size: 16px"><a href="?action=update_baike_cid" class="btn btn-primary"><span class="glyphicon glyphicon-plus"></span>更新关联百科分类</a></div>
        <ul class="nav nav-tabs" style="overflow: inherit; padding-left: 100px">
            <li class="{if $handle_type=='recommend'}active{/if}">
                <a href="?{if !empty($_REQUEST['search'])}handle_type=recommend&{$urls}{else}handle_type=recommend{/if}">推荐</a>
            </li>
            <li class="{if $handle_type=='banner'}active{/if}">
                <a href="?{if !empty($_REQUEST['search'])}handle_type=banner&{$urls}{else}handle_type=banner{/if}">Banner轮播图</a>
            </li>
            <li class="{if $handle_type=='deliver'}active{/if}">
                <a href="?{if !empty($_REQUEST['search'])}handle_type=deliver&{$urls}{else}handle_type=deliver{/if}">投稿</a>
            </li>
            <li class="{if $handle_type=='hand_insert'}active{/if}">
                <a href="?{if !empty($_REQUEST['search'])}handle_type=hand_insert&{$urls}{else}handle_type=hand_insert{/if}">手动录入</a>
            </li>
            <li class="{if $handle_type=='auto_insert'}active{/if}">
                <a href="?{if !empty($_REQUEST['search'])}handle_type=auto_insert&{$urls}{else}handle_type=auto_insert{/if}">自动采集</a>
            </li>
            <li class="{if $handle_type=='all'}active{/if}">
                <a href="?{if !empty($_REQUEST['search'])}handle_type=all&{$urls}{else}handle_type=all{/if}">全部</a>
            </li>
        </ul>
    </div>
    <div class="portlet-body">
        <div class="table-responsive clearfix">
            <table class="table table-striped table-bordered table-hover" id="data_table" style="word-break: break-all">
                <thead>
                <tr>
                    <th>#ID</th>
                    <th>文章标题</th>
                    <th>作者</th>
                    <th>所属栏目</th>
                    <th>状态</th>
                    <th>创建时间</th>
                    <th>操作</th>
                </tr>
                </thead>
                <tbody>
                {foreach $data['rows'] as $key=>$value}
                    <tr>
                        <td>#{$value['id']}
                            <a href="{$_root}article/{Func_NumEncode::e($value['id'])}.html?update_page_cache=1&preview_new={md5(date('Ymd')+$value['id'])}" target="_blank" >预览</a>
                        </td>
                        <td>
                            {if mb_strlen($value['title'],'UTF-8')>40}
                                <a href="{$_root}article/{Func_NumEncode::e($value['id'])}.html?update_page_cache=1" target="_blank" >{mb_substr($value['title'],0,39,'utf-8')}...</a
                            {else}
                                <a href="{$_root}article/{Func_NumEncode::e($value['id'])}.html?update_page_cache=1" target="_blank" >{$value['title']}</a>
                            {/if}
                            {*<a class="btn btn-success btn-xs" href="{$_root}raiders-info/{$value['id']}.html" target="_blank" >访问旧文章页</a*}

                        </td>
                        <td>{$value['author']}</td>
                        <td> <select class="form-control select2me input-sm" data-id="{$value['id']}" onchange="ListOperator.changeCategory(this)">
                                {foreach $category_name as $k=>$v}
                                    <option {if $value['category_id'] == $v['id']}selected{/if} value="{$v['id']}">{if $v['parent']==0}{$v['name']}{else}&nbsp;&nbsp;---{$v['name']}{/if}</option>
                                {/foreach}
                            </select>
                         </td>

                        <td> <select class="form-control select2me input-sm" data-id="{$value['id']}" onchange="ListOperator.online(this)">
                                {foreach $status as $key =>$val}
                                    <option {if $key == $value['status']}selected{/if} value="{$key}">{$val}</option>
                                {/foreach}
                            </select>
                        </td>

                        <td>{date('Y-m-d H:i:s',$value['create_time'])}</td>
                        <td><a href="?action=edit&id={$value['id']}" class="btn btn-primary btn-xs"><i
                                        class="fa fa-pencil"></i>修改</a>&nbsp;
                            <a href="?action=delete&id={$value['id']}" onclick="return confirm('您确定要删除吗？？')" class="btn btn-danger btn-xs"><i
                                        class="fa fa-trash-o"></i>删除</a>&nbsp;
                            <a href="javascript:;" id="update-pv-btn" class="btn btn-info btn-xs" onclick="ListOperator.updatePageView({$value['id']})">更新PV</a>
                        </td>
                    </tr>
                {/foreach}
                </tbody>
            </table>
            <div class="pull-left" style="width:30%; padding: 10px 0;">
            </div>

            <div class="pull-right">
                <ul class="pagination">
                    {if $data['page']['dpll']}
                        <li class="prev">
                            <a href="{$data['page']['dup']}1" title="First"><i class="fa fa-angle-double-left"></i></a>
                        </li>
                        <li class="prev">
                            <a href="{$data['page']['dup']}{$data['page']['dp']-1}" title="Prev"><i class="fa fa-angle-left"></i></a>
                        </li>
                    {else}
                        <li class="prev disabled">
                            <a href="#" title="First"><i class="fa fa-angle-double-left"></i></a>
                        </li>
                        <li class="prev disabled">
                            <a href="#" title="Prev"><i class="fa fa-angle-left"></i></a>
                        </li>
                    {/if}
                    {for $i=$data['page']['dpl'] to $data['page']['dpr']}
                        <li{if $i==$data['page']['dp']} class="active"{/if}>
                            <a href="{$data['page']['dup']}{$i}">{$i}</a>
                        </li>
                    {/for}
                    <li class="disabled">
                        <a> {$data['page']['dtp']}
                            ( {$data['page']['dp']*$data['page']['dn']}
                            /{$data['page']['dt']} )</a>
                    </li>

                    {if $data['page']['dprr']}
                        <li class="next">
                            <a href="{$data['page']['dup']}{$data['page']['dp']+1}" title="Next"><i class="fa fa-angle-right"></i></a>
                        </li>
                        <li class="next">
                            <a href="{$data['page']['dup']}{$data['page']['dtp']}" title="Last"><i class="fa fa-angle-double-right"></i></a>
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

<!-- BEGIN JAVASCRIPTS(Load javascripts at bottom, this will reduce page load time) -->
<!-- BEGIN CORE PLUGINS -->
<script src="{$_assets}plugins/jquery-1.11.0.min.js"
        type="text/javascript"></script>
<script src="{$_assets}scripts/_page.js"></script>
<script type="text/javascript" src="js/moment.min.js"></script>
<script type="text/javascript" src="js/zh-cn.js"></script>
<script type="text/javascript" src="js/bootstrap-datetimepicker.min.js"></script>

<script tab="text/javascript"
        src="{$_assets}plugins/select2/select2.min.js"></script>

<script>
    ListOperator = {

        online: function (obj) {
            var status = $(obj).find('option:selected').val();
            var id =$(obj).attr('data-id');
            $.getJSON('?', {
                id: id,
                status: status,
                action:'update_status'
            }, function (data) {
                top.alert(data.msg);
            })
        },
        changeCategory: function (o) {

            var category_id = $(o).find('option:selected').val();
            var id =$(o).attr('data-id');
            if (!category_id) {
                category_id = $(o).find('td:first').val();
            }
            $.post("?", {
                id: id,
                category_id: category_id,
                action:'update_category'
            }, function (data) {
                top.alert(data.msg);
                window.location.reload();
            });
        },
        updatePageView: function(id){
            $.post("?", {
                id: id,
                action: 'update_pv'
            }, function(data) {
                top.alert(data.msg);
                window.location.reload();
            });
        }
    }
    $(document).ready(function(){
        $('.date').datetimepicker({
            format: 'YYYY-MM-DD',
            locale: 'zh-cn'
        });
    })
    $('.deleteProduct').click(function(){
        var product_id=$(this).attr('data-pid');
        $.post('{$__route}../marketing/contact_urgent_list?',{ del:1,product_id:product_id,tab:'product',action:'detail',id:415 },function(data){
            if(data=='success'){
                window.location.reload();
            }else{
                alert('操作错误，请重试！！');
            }
        })
    })
</script>
</body>
<!-- END BODY -->
</html>