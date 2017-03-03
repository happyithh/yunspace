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
    <link href="style/media.css" rel="stylesheet"/>
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
                    <input type="hidden" name="action" value="list">
                    <input type="hidden" name="handle_type" value="{$_REQUEST['handle_type']}">
                    <div class="form-body clearfix">
                        <div class="form-group col-md-6">
                            <label class="col-md-3 control-label">产品名称/ID</label>

                            <div class="col-md-9">
                                <input type="text" class="form-control input-sm" placeholder="产品名称/ID" name="title" value="{$_REQUEST['title']}">
                            </div>
                        </div>
                        <div class="form-group col-md-6">
                            <label class="col-md-3 control-label">手机号</label>

                            <div class="col-md-9">
                                <input type="text" class="form-control input-sm" placeholder="手机号" name="phone" value="{$_REQUEST['phone']}">
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


<div class="portlet" >
    <div class="portlet-title" style="padding: 6px;">
        <div class="caption">
            <i class="fa fa-comments"></i>
            数据列表
        </div>
    </div>
    <div class="portlet-tabs" style="position:relative">
        <ul class="nav nav-tabs" style="overflow: inherit; padding-left: 100px">
            <li class="{if $handle_type=='done'}active{/if}">
                <a href="?handle_type=done">已更新</a>
            </li>
            <li class="{if $handle_type=='not'}active{/if}">
                <a href="?handle_type=not">未更新</a>
            </li>
            <li class="{if $handle_type=='all'}active{/if}">
                <a href="?handle_type=all">全部</a>
            </li>
        </ul>
    </div>
    <div class="portlet-body">
        {if $handle_type=='not'}
            <a href="javascript:;" class="update_all btn btn-success">批量更新数据</a>
        {/if}

        <div class="table-responsive clearfix">
            <table class="table table-striped table-bordered table-hover" id="data_table" style="word-break: break-all">
                <thead>
                <tr>
                    <th>ID</th>
                    <th>产品名称</th>
                    <th>分类</th>
                    <th>面积</th>
                    <th>价格</th>
                    <th>起价</th>
                    <th>价格单位</th>
                    <th>价格下限</th>
                    <th>价格上限</th>
                    <th>联系人</th>
                    <th>旧联系方式</th>
                    <th>新联系方式</th>
                    <th>状态</th>
                    <th>更新时间</th>
                    {if $handle_type=="not"}
                        <th>操作</th>
                    {/if}
                </tr>
                </thead>
                {foreach $data['rows'] as $k=>$v}
                    <tr>
                        <td class="pid">{$v['product_id']}</td>
                        <td>{$v['product_name']}</td>
                        <td>{$v['category_id']}</td>
                        <td>{$v['size']}</td>
                        <td>{$v['price']}</td>
                        <td>{if $v['is_lowest']==1}起价{/if}</td>
                        <td>{$v['unit']}</td>
                        <td>{$v['min']}</td>
                        <td>{$v['max']}</td>
                        <td>{$v['username']}</td>
                        <td>{$v['phone_old']}</td>
                        <td>{$v['phone_new']}</td>
                        <td>{if $v['status']==1}已更新{else}未更新{/if}</td>
                        <td>{date("Y-m-d H:i:s",$v['update_time'])}</td>
                        {if $handle_type=="not"}
                            <td>
                                <a href="?action=update_data&product_id={$v['product_id']}" class="btn btn-info btn-xs"><i class="fa fa-pencil"></i>更新数据</a>&nbsp;&nbsp;
                            </td>
                        {/if}
                    </tr>
                {/foreach}
                <tbody>

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
<link rel="stylesheet" type="text/css" href="{$_assets}plugins/bootstrap-fileinput/bootstrap-fileinput.css"/>
<script type="text/javascript" src="{$_assets}plugins/bootstrap-fileinput/bootstrap-fileinput.js"></script>
<script>
    $(document).ready(function(){
        $('.date').datetimepicker({
            format: 'YYYY-MM-DD',
            locale: 'zh-cn'
        });
    });
    $('.update_all').click(function(){
        var obj=[];
        var pid_arr=$('table tr').find('.pid');
        console.log(pid_arr);
        for(var i = 0; i<pid_arr.length;i++){
            obj.push({
                product_id:$('table tr').find('.pid').eq(i).text()
            });
        }
        console.log(obj);
        if(obj){
            $.post('?action=update_all_data',{ data_arr:obj },function(data){
                if(data.status != 0){
                    window.location.href="http://{Core::$urls['host']}{Core::$urls['path']}";
                }
            });
        }
    })
</script>
</body>
<!-- END BODY -->
</html>