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
                    <div class="form-body clearfix">
                        <div class="form-group col-md-5">
                            <label class="col-md-3 control-label">产品名称</label>

                            <div class="col-md-9">
                                <input type="text" class="form-control input-sm" placeholder="产品ID / 名称" name="search[title]" value="{$_REQUEST['search']['title']}">
                            </div>
                        </div>
                        <div class="form-group col-md-5">
                            <label class="col-md-3 control-label">场地查看时间</label>
                            <div class="col-md-4">
                                <input type='text' class="form-control date" placeholder="请选择开始时间" name="search[start_time]" value="{$_REQUEST['search']['start_time']}"/>
                            </div>
                            <div class="col-md-4 col-md-offset-1">
                                <input type='text' class="form-control date" placeholder="请选择结束时间" name="search[end_time]" value="{$_REQUEST['search']['end_time']}"/>
                            </div>
                        </div>
                        <div class="form-group col-md-5">
                            <label class="col-md-3 control-label">操作人</label>

                            <div class="col-md-9">
                                <input type="text" class="form-control input-sm" placeholder="操作人名称" name="search[username]" value="{$_REQUEST['search']['username']}">
                            </div>
                        </div>
                        <div class="form-group col-md-5">
                            <label class="col-md-3 control-label">需求人</label>

                            <div class="col-md-9">
                                <input type="text" class="form-control input-sm" placeholder="需求人名称" name="search[demand_name]" value="{$_REQUEST['search']['demand_name']}">
                            </div>
                        </div>
                        <div class="form-group col-md-5">
                            <label class="col-md-3 control-label">城市</label>

                            <div class="col-md-9">
                                <select class="form-control input-sm" name="search[search_city]">
                                    <option value=''>全部</option>
                                    {foreach $_REQUEST['cities'] as $v}
                                        <option {if $_REQUEST['search']['search_city']==$v}selected{/if} value="{$v}">{$v}</option>
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
            带看场地列表
        </div>
    </div>
    <div class="portlet-body">
        <div class="table-responsive clearfix">
            <table class="table table-striped table-bordered table-hover" id="data_table" style="word-break: break-all">
                <thead>
                <tr>
                    <th>场地名称</th>
                    <th>场地查看时间</th>
                    <th class="list_none">备注</th>
                    <th>城市</th>
                    <th>需求人</th>
                    <th>操作人</th>
                    <th class="list_none">创建时间</th>
                    <th>操作</th>
                </tr>
                </thead>
                <tbody>
                {foreach $_data['rows'] as $k=>$v}
                    <tr>
                        <td><a href="?search[title]={$v['product_name']}">{$v['product_name']}</a></td>
                        <td>{date('Y-m-d',$v['look_time'])}</td>
                        <td class="list_none">{$v['demo']}</td>
                        <td>{$v['city']}</td>
                        <td><a href="?demand_name={$v['demand_name']}">{$v['demand_name']}</a></td>
                        <td><a href="?username={$v['username']}">{$v['username']}</a></td>
                        <td class="list_none">{date("Y-m-d H:i:s",$v['create_time'])}</td>
                        <td>
                            <a href="?action=demand_detail&id={$v['demand_id']}" class="btn btn-success btn-xs"><i class="fa fa-eye"></i>查看需求</a>
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