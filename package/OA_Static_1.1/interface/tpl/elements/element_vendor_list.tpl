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
                    <input type="hidden" name="handle_type" value="{$handle_type}">
                    <div class="form-body clearfix">
                        <div class="form-group col-md-5">
                            <label class="col-md-3 control-label">供应商名称</label>

                            <div class="col-md-9">
                                <input type="text" class="form-control input-sm" placeholder="供应商ID / 名称" name="search[title]" value="{$_REQUEST['search']['title']}">
                            </div>
                        </div>
                        <div class="form-group col-md-5">
                            <label class="col-md-3 control-label">城市</label>

                            <div class="col-md-9">
                                {*<select class="form-control input-sm" name="search[search_city]">*}
                                    {*<option value=''>全部</option>*}
                                    {*{foreach $_REQUEST['cities'] as $v}*}
                                        {*<option {if $_REQUEST['search']['search_city']==$v}selected{/if} value="{$v}">{$v}</option>*}
                                    {*{/foreach}*}
                                {*</select>*}
                                <input type="text" class="form-control input-sm" placeholder="请输入要搜索的城市" name="search[search_city]" value="{$_REQUEST['search']['search_city']}">
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
                        <div class="form-group col-md-5">
                            <label class="col-md-3 control-label">签约状态</label>

                            <div class="col-md-9">
                                <select class="form-control input-sm" name="search[search_status]">
                                    <option value=''>全部</option>
                                    <option  {if $_REQUEST['search']['search_status']==3}selected{/if} value =3>未签约</option>
                                    <option {if $_REQUEST['search']['search_status']==2}selected{/if} value=2>已签约</option>
                                    <option {if $_REQUEST['search']['search_status']==1}selected{/if} value=1>合作备忘</option>

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
            供应商列表
        </div>
    </div>
    <div class="portlet-tabs" style="position:relative">
        <div style="position: absolute;left:10px;bottom:0px;color: #444444;font-size: 16px">{if $handle_type=='waiting'}<span class="required" aria-required="true" style="color: red">*</span>此列表不包含首次审核中的供应商
            {elseif $handle_type=='reject'}<span class="required" aria-required="true" style="color: red">*</span>此列表不包含首次审核拒绝的供应商{/if}</div>
        <ul class="nav nav-tabs" style="overflow: inherit; padding-left: 100px">
            <li class="{if $handle_type=='reject'}active{/if}">
                <a href="?{if !empty($_REQUEST['search'])}handle_type=reject{$urls}{else}handle_type=reject{/if}">审核拒绝</a>
            </li>
            <li class="{if $handle_type=='waiting'}active{/if}">
                <a href="?{if !empty($_REQUEST['search'])}handle_type=waiting{$urls}{else}handle_type=waiting{/if}">审核中</a>
            </li>
            <li class="{if $handle_type=='offline'}active{/if}">
                <a href="?{if !empty($_REQUEST['search'])}handle_type=offline{$urls}{else}handle_type=offline{/if}">下线</a>
            </li>
            <li class="{if $handle_type=='online'}active{/if}">
                <a href="?{if !empty($_REQUEST['search'])}handle_type=online{$urls}{else}handle_type=online{/if}">上线</a>
            </li>
            {*<li class="{if $handle_type=='recycle'}active{/if}">*}
                {*<a href="?{if !empty($_REQUEST['search'])}handle_type=recycle{$urls}{else}list_type=vendor&handle_type=recycle{/if}">回收站</a>*}
            {*</li>*}
            <li class="{if $handle_type=='all'}active{/if}">
                <a href="?{if !empty($_REQUEST['search'])}handle_type=all{$urls}{else}&handle_type=all{/if}">全部</a>
            </li>
        </ul>
    </div>
    <div class="portlet-body">
        <div class="table-responsive clearfix">
            <table class="table table-striped table-bordered table-hover" id="data_table" style="word-break: break-all">
                <thead>
                <tr>
                    <th >供应商ID</th>
                    <th>供应商名称</th>
                    <th>负责人</th>
                    <th >产品总数</th>
                    <th>城市</th>
                    <th class="list_none">地址</th>
                    <th class="list_none">创建时间</th>
                    <th class="list_none">更新时间</th>
                    <th>操作</th>
                </tr>
                </thead>
                <tbody>
                {foreach $_data['rows'] as $k=>$v}
                    <tr role="row">
                        <td>{$v['id']}</td>
                        <td>
                            {$v['vendor_name']}
                            {if $v['create_by_quick']==1}
                                (后台快速创建)
                            {/if}  {if $v['create_by_quick']==2}
                                (供应商加盟)
                            {/if}
                            {if $v['update_status']==2}
                                <span class="btn btn-warning btn-xs">审核中</span>
                            {elseif $v['update_status']==3}
                                <span class="btn btn-danger btn-xs">已拒绝</span>
                            {elseif $v['update_status']==-2}
                                <span class="btn btn-danger btn-xs">已删除</span>
                            {/if}
                        </td>
                        <td>{$_adminInfo[$v['admin_id']]['username']}</td>
                        <td>{if $v['count_product']}{$v['count_product']}{else}-----{/if}</td>
                        <td>{$v['attr']['城市']}</td>
                        <td class="list_none">{$v['addr']}</td>
                        <td class="list_none">{date('Y-m-d H:i:s',$v['create_time'])}</td>
                        <td class="list_none">{date('Y-m-d H:i:s',$v['update_time'])}</td>
                        <td>
                            <a href="?action=detail&id={$v['id']}" class="btn btn-success btn-xs list_size"><i class="fa fa-pencil"></i>查看</a>
                            &nbsp;
                            {if $v['status']==1}
                                <a href="http://{Core::$urls['host']}/vendor_info/{$v['id']}.html" class="btn btn-primary btn-xs list_size" target="_blank"><i class="fa fa-pencil"></i>供应商链接</a>
                            {/if}
                            &nbsp;
                            {if $is_admin}
                                {if $v['status']==-2}
                                    <a href="?action=recover_vendor&handle_type={$handle_type}&id={$v['id']}" class="btn btn-info btn-xs list_none"><i class="fa fa-pencil"></i>恢复</a>
                                {else}
                                    <a href="?action=del_vendor&handle_type={$handle_type}&id={$v['id']}" class="btn btn-danger btn-xs list_none"><i class="fa fa-pencil"></i>删除</a>
                                {/if}
                                {*<a href="javascript:;" data-vid="{$v['id']}" data-admin="{$v['admin_id']}" class="btn btn-success btn-xs change_admin_button"><i class="fa fa-pencil"></i>分配</a>*}
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
<script>
    $(document).ready(function(){
        $('.date').datetimepicker({
            format: 'YYYY-MM-DD',
            locale: 'zh-cn'
        });
    })

    $('.resetVendor').click(function(){
        var vendor_id=$(this).attr('data-vid');
        $.post('?',{ id:vendor_id,action:'reset'},function(data){
            if(data.status==1){
                window.location.reload();
            }else{
                alert(data.msg);
            }
        },'json')
    });

</script>
</body>
<!-- END BODY -->
</html>