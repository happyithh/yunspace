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
                    <input type="hidden" name="type" value="{$type}">
                    <div class="form-body clearfix">
                        <div class="form-group col-md-5">
                            <label class="col-md-3 control-label">子空间名称</label>
                            <div class="col-md-9">
                                <input type="text" class="form-control input-sm" placeholder="子空间ID / 名称"
                                       name="search[item_name]" value="{$_REQUEST['search']['item_name']}">
                            </div>
                        </div>
                        <div class="form-group col-md-5">
                            <label class="col-md-3 control-label">百科名称</label>
                            <div class="col-md-9">
                                <input type="text" class="form-control input-sm" placeholder="百科ID / 名称"
                                       name="search[space_name]" value="{$_REQUEST['search']['space_name']}">
                            </div>
                        </div>
                        <div class="form-group col-md-5">
                            <label class="col-md-3 control-label">城市</label>

                            <div class="col-md-8">
                                <select class="form-control input-sm" name="search[city]">
                                    <option value=0>全部</option>
                                    {foreach $_REQUEST['cities'] as $value}
                                        <option {if $value==$_REQUEST['search']['city']}selected {/if}
                                                value="{$value}">{$value}</option>
                                    {/foreach}
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
                        <div class="form-group col-md-5">
                            <label class="col-md-3 control-label">状态</label>

                            <div class="col-md-8">
                                <select class="form-control input-sm" name="search[status]">
                                    <option {if !isset($_REQUEST['search']['status'])} selected {/if}value='0'>全部</option>
                                        <option {if $_REQUEST['search']['status']==1} selected {/if} value="1">上线</option>
                                        <option {if $_REQUEST['search']['status']==-2} selected {/if} value="-2">下线</option>
                                        <option {if $_REQUEST['search']['status']==2} selected {/if} value="2">审核中</option>
                                        <option {if $_REQUEST['search']['status']==3} selected {/if} value="3">审核拒绝</option>
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
            子空间列表
        </div>
        <a href="?action=updateSearchItem" class="btn btn-danger btn-xs" style="float: right;font-size: 15px;">
            更新子空间搜索信息
        </a>
    </div>

    <div class="portlet-body">
        <ul class="nav nav-tabs">
            <li {if $type=='all'}class="active"{/if}>
                <a href="?type=all{if isset($url)}{$url}{/if}">全部</a>
            </li>
            <li {if $type=='no_phone'}class="active"{/if}>
                <a href="?type=no_phone&{if isset($url)}{$url}{/if}">暂无联系电话</a>
            </li>
            <li {if $type=='no_email'}class="active"{/if}>
                <a href="?type=no_email&{if isset($url)}{$url}{/if}">暂无邮箱</a>
            </li>
            <li {if $type=='no_price'}class="active"{/if}>
                <a href="?type=no_price&{if isset($url)}{$url}{/if}">价格缺失</a>
            </li>
        </ul>
        <div class="table-responsive clearfix">
            <table class="table table-striped table-bordered table-hover" id="data_table" style="word-break: break-all">
                <thead>
                <tr>
                    <th>百科ID</th>
                    <th>子空间名称</th>
                    <th>百科名称</th>
                    <th>负责人名称</th>
                    <th>负责人电话</th>
                    <th>负责人邮箱</th>
                    <th>价格</th>
                    <th>状态</th>
                    <th>城市</th>
                    <th>拓展状态</th>
                    <th>创建时间</th>
                    <th>操作</th>
                </tr>
                </thead>
                <tbody>
                {foreach $_data['rows'] as $k=>$v}
                    <tr>
                        <td class="list_none">{$v['id']}</td>
                        <td class="list_size">{$v['item_name']}</td>
                        <td>{$v['space_name']}</td>
                        <td class="list_size">{$v['contacts']}</td>
                        <td>{$v['phone']}</td>
                        <td>{$v['email']}</td>
                        <td>{if $v['min_price']/100!=1}
                            {$v['min_price']/100}
                            {/if}
                            {if $v['min_price']/100 !=1 && $v['max_price']/100 !=1}--{/if}
                            {if $v['max_price']/100!=1}
                            {$v['max_price']/100}
                            {/if}
                            {if !empty($v['price_unit'])}
                                /{$v['price_unit']}
                                {/if}
                        </td>
                        <td>{if $v['status']==0}下线{elseif $v['status']==1}上线{elseif $v['status']==2}
                                审核中{else}审核拒绝{/if}
                        </td>
                        <td>{$v['city']}</td>
                        <td>{if $v['expand_status']==-3}无意向{elseif $v['expand_status']==0}未拓展
                            {elseif $v['expand_status']==1}需求、报价有意向{elseif $v['expand_status']}报价系统有意向
                            {else}联系不到{/if}</td>
                        <td class="list_none">{date('Y-m-d H:i:s',$v['create_time'])}</td>
                        <td>
                            <a {if !empty($v['phone']) && !empty($v['email']) && !empty($v['contacts'])}disabled {/if} class="btn btn-primary btn-xs" data-toggle="modal"  data-space-id="{$v['id']}" data-item-contacts="{$v['contacts']}"
                               data-item-phone="{$v['phone']}" data-item-email="{$v['email']}" data-id="{$v['id']}" onclick="space_item.getSpaceItem(this)" href="#update_info">完善联系信息</a>
                            <a href="#update_price" data-max-price="{if $v['max_price']/100!=1}{$v['max_price']/100}{/if}" data-price-unit="{$v['price_unit']}" data-id="{$v['id']}" data-mix-price="{if $v['min_price']/100!=1}{$v['min_price']/100}{/if}" {if $v['min_price']/100 !=1 && $v['max_price']/100 !=1}disabled {/if} class="btn btn-success btn-xs list_size" data-toggle="modal" onclick="space_item.getItemPrice(this)">完善价格</a>
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


{*联系信息弹出层*}
<div class="modal fade" id="update_info" tabindex="-1" role="basic" aria-hidden="true">
    <div class="modal-dialog" style="position: fixed;top:20%;left: 20%">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
                <h4 class="modal-title">
                    联系信息</h4>
            </div>
            <div class="modal-body base-info">

                <table width="80%">
                    <input class="form-control id" type="hidden"  name="id" value="" rows="5">
                    <tr>
                        <td>负责人名称</td>
                        <td colspan="4">
                            <input class="form-control contacts" placeholder="例:云space" value="" rows="5"  style="margin-bottom:10px;">
                        </td>
                    </tr>
                    <tr>
                        <td>负责人电话</td>
                        <td colspan="4">
                            <input class="form-control phone" value="" rows="5" placeholder="例:151********" style="margin-bottom:10px;">
                        </td>
                    </tr>
                    <tr>
                        <td>负责人邮箱</td>
                        <td colspan="4">
                            <input class="form-control email" value="" rows="5" placeholder="例:123@qq.com" style="margin-bottom:10px;">
                        </td>
                    </tr>
                </table>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">
                    取消
                </button>
                <button type="button" class="btn btn-success" onclick="space_item.update_info(this)">
                    确定
                </button>
            </div>

        </div>
    </div>

</div>

{*价格信息弹出层*}
<div class="modal fade" id="update_price" tabindex="-1" role="basic" aria-hidden="true">
    <div class="modal-dialog" style="position: fixed;top:20%;left: 20%">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
                <h4 class="modal-title">
                    价格区间</h4>
            </div>
            <div class="modal-body base-info">

                <table width="80%">
                    <input class="form-control id" type="hidden"  name="id" value="" rows="5">
                    <tr>
                        <td>最小值</td>
                        <td colspan="4">
                            <input class="form-control min_price" value="" placeholder="例:10000" rows="5"  style="margin-bottom: 10px" >
                        </td>
                    </tr>
                    <tr>
                        <td>最大值</td>
                        <td colspan="4">
                            <input class="form-control max_price" value="" placeholder="例:200000" rows="5"  style="margin-bottom: 10px" >
                        </td>
                    </tr>
                    <tr>
                        <td>单位</td>
                        <td colspan="4">
                            <input class="form-control price_unit" value="" placeholder="例:天" rows="5"  style="margin-bottom: 10px" >
                        </td>
                    </tr>
                </table>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">
                    取消
                </button>
                <button type="button" class="btn btn-success" onclick="space_item.update_price(this)">
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
<script src="{$_assets}plugins/bootstrap/js/bootstrap.min.js"
        tab="text/javascript"></script>
<script src="{$_assets}scripts/_page.js"></script>
<script type="text/javascript" src="js/moment.min.js"></script>
<script type="text/javascript" src="js/zh-cn.js"></script>
<script type="text/javascript" src="js/bootstrap-datetimepicker.min.js"></script>
<script>
    $(document).ready(function () {
        $('.date').datetimepicker({
            format: 'YYYY-MM-DD',
            locale: 'zh-cn'
        });
    });
</script>
<script src="js/space_item.js" type="text/javascript"></script>
</body>
<!-- END BODY -->
</html>