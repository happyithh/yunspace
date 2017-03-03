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
</head>
<!-- END HEAD -->
<!-- BEGIN BODY -->

<body style="background:#FaFaFa !important">


<div class="portlet">
<div class="portlet-title">
    <div class="caption">
        <i class="fa fa-database"></i>供应商所有信息列表
    </div>
</div>

<div class="portlet-body">
<div class="table-responsive clearfix">
    <blockquote class="hero">
        <div class="form-body">
            <div class="col-md-12">
                <div class="form-group">
                    <label class="control-label col-md-4">供应商ID</label>

                    <div class="col-md-8">
                        <p class="form-control-static">{$vendorInfo['id']}</p>
                    </div>
                </div>
            </div>
            <div class="col-md-12">
                <div class="form-group">
                    <label class="control-label col-md-4">供应商名称</label>

                    <div class="col-md-8">
                        <p class="form-control-static">
                            {$vendorInfo['vendor_name']}
                            {if $vendorInfo['source']==1}
                                (后台快速创建)
                            {/if}
                            {if $vendorInfo['source']==2}
                                (供应商加盟)
                            {/if}
                        </p>
                    </div>
                </div>
            </div>
            <div class="col-md-12">
                <div class="form-group">
                    <label class="control-label col-md-4">负责人</label>

                    <div class="col-md-8">
                        <p class="form-control-static">{$vendorInfo['admin_name']}</p>
                    </div>
                </div>
            </div>
            {if $vendorInfo['status']==2}
                <div class="col-md-12">
                    <div class="form-group">
                        <label class="control-label col-md-4">操作</label>

                        <div class="col-md-8">
                            <p class="form-control-static">
                                <a class="btn btn-xs btn-primary" href="?action=check_vendor&id={$vendorInfo['id']}&admin_name={$vendorInfo['admin_name']}">审核</a>
                            </p>
                        </div>
                    </div>
                </div>
            {/if}
        </div>
    </blockquote>
    <div class="portlet">
        <div class="portlet-title">
            <div class="caption">
                <i class="fa fa-comments"></i>供应商产品列表
            </div>
        </div>
        <div class="portlet-body">
            <div class="table-responsive clearfix">
                <table class="table table-striped table-bordered table-hover" id="data_table" style="word-break: break-all">
                    <thead>
                    <tr>
                        <th>#ID</th>
                        <th>服务名称</th>
                        <th>操作</th>
                    </tr>
                    </thead>
                    <tbody>
                    {foreach $product as $k=>$v}
                        <tr>
                            <td>{$v['id']}</td>
                            <td>
                                {$v['product_name']}
                                {if $v['create_by_quick']==1}
                                    (后台快速创建)
                                {/if}
                                {if $v['create_by_quick']==2}
                                    (供应商加盟)
                                {/if}
                            </td>
                            <td>
                                {if $v['status']==2}
                                    <a class="btn btn-xs btn-primary" href="?action=check_product&id={$v['id']}&vendor_id={$vendorInfo['id']}&admin_name={$vendorInfo['admin_name']}">审核</a>
                                {/if}
                            </td>
                        </tr>
                    {/foreach}
                    </tbody>
                </table>
            </div>
        </div>
    </div>
    {****************************************************}
    <div class="portlet">
        <div class="portlet-title">
            <div class="caption">
                <i class="fa fa-comments"></i>供应商套餐列表
            </div>
        </div>
        <div class="portlet-body">
            <div class="table-responsive clearfix">
                <table class="table table-striped table-bordered table-hover" id="data_table" style="word-break: break-all">
                    <thead>
                    <tr>
                        <th>#ID</th>
                        <th>套餐名称</th>
                        <th>操作</th>
                    </tr>
                    </thead>
                    <tbody>
                    {foreach $productSet as $k=>$v}
                        <tr>
                            <td>{$v['id']}</td>
                            <td>{$v['set_name']}</td>
                            <td>
                                {if $v['status']==2}
                                    <a class="btn btn-xs btn-primary" href="?action=check_set&id={$v['id']}&vendor_id={$vendorInfo['id']}&admin_name={$vendorInfo['admin_name']}">审核</a>
                                {/if}
                            </td>
                        </tr>
                    {/foreach}
                    </tbody>
                </table>
            </div>
        </div>
    </div>
    {***************************************************************************}
    <div class="portlet">
        <div class="portlet-title">
            <div class="caption">
                <i class="fa fa-comments"></i>供应商案例列表
            </div>
        </div>
        <div class="portlet-body">
            <div class="table-responsive clearfix">
                <table class="table table-striped table-bordered table-hover" id="data_table" style="word-break: break-all">
                    <thead>
                    <tr>
                        <th>#ID</th>
                        <th>案例名称</th>
                        <th>操作</th>
                    </tr>
                    </thead>
                    <tbody>
                    {foreach $case as $k=>$v}
                        <tr>
                            <td>{$v['id']}</td>
                            <td>{$v['case_name']}</td>
                            <td>
                                {if $v['status']==2}
                                    <a class="btn btn-xs btn-primary" href="?action=check_case&id={$v['id']}&vendor_id={$vendorInfo['id']}&admin_name={$vendorInfo['admin_name']}">审核</a>
                                {/if}
                            </td>
                        </tr>
                    {/foreach}
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>
</div><iframe style="width: 1px; height:1px;" width="1" height="1" hidden="hidden" src="{$_home}product_search/update_product_info_list"></iframe>
</body>
<!-- END BODY -->
</html>