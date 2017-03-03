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
            <i class="fa fa-reorder"></i>产品详情
        </div>
    </div>
    <div class="portlet-body">
        <div class="tab-content clearfix">
            <div class="tab-pane fade active in" id="tab_1_1">
                <h3 >
                    产品信息
                    {if $data['status']==1}
                        <a href="http://{Core::$urls['host']}/service_info/{$data['id']}.html" class="btn btn-default" target="_blank"><i class="fa fa-link"></i>点此查看产品链接</a>
                    {/if}
                    {*{if $is_admin}*}
                        {*<a href="{$__route}../marketing/contact_urgent_list?action=detail&tab=product&id={$librarylist[0]['account_id']}&product_id={$data['id']}" class="btn btn-success"><i class="fa fa-pencil"></i>修改</a>*}
                        {*<a href="{$__route}../marketing/contact_urgent_list?&del=1&product_id={$data['id']}&tab=product&action=detail&id=415" class="btn btn-danger"><i class="fa fa-pencil"></i>删除</a>*}
                    {*{/if}*}
                </h3>
                <hr>
                <div class="table-responsive clearfix">
                    <div class="col-md-12">
                        <div class="form-group">
                            <label class="control-label col-md-1" style="font-size: 15px;">产品名称</label>

                            <div class="col-sm-2">
                                <p   style="font-size: 15px;">{$data['product_name']}</p>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-12">
                        <div class="form-group">
                            <label class="control-label col-sm-1" style="font-size: 15px;">价格</label>

                            <div class=" col-sm-2">
                                <p   style="font-size: 15px;">
                                    {abs($data['price'])}
                                    {if $data['attr_new']['起价']}
                                        <span style="font-size: 13px;">起</span>
                                    {/if}
                                </p>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-12">
                        <div class="form-group">
                            <label class="control-label col-sm-1"  style="font-size: 15px;">地址</label>

                            <div class=" col-sm-2">
                                <p    style="font-size: 15px;">{$data['addr']}</p>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-12" >
                        <div class="form-group">
                            <label class="control-label col-md-1" style="font-size: 15px;">面积</label>

                            <div class="col-sm-2">
                                <p   style="font-size: 15px;">
                                    {$data['product_size']}
                                    平方米</p>
                            </div>
                        </div>
                    </div>

                </div>
                <hr>
                {if $is_sales}
                <div class="portlet-body">
                    <h3>
                        联系人信息</h3>
                    <hr>
                    <div class="table-responsive clearfix">
                        <table class="table table-striped table-bordered table-hover" id="data_table" style="word-break: break-all">
                            <thead>
                            {if !empty($librarylist)}
                            <tr style="font-size: 15px;">
                                <th>用户名</th>
                                <th>手机号</th>
                                <th>邮箱</th>
                            </tr>
                            </thead>
                            <tbody>
                            {foreach $librarylist as $k=>$v}
                                <tr style="font-size: 15px;">
                                    <td>{$v['username']}</td>
                                    <td>{$v['phone']}</td>
                                    <td>{$v['email']}</td>
                                </tr>
                            {/foreach}
                            {else}
                                <tr>
                                    <td style="font-size: 15px;">没有联系人信息</td>
                                </tr>
                            {/if}
                            </tbody>
                        </table>
                    </div>
                </div>
                 {/if}

            <table class="table table-striped table-bordered table-advance">

                <tbody>
                <tr>

                    {foreach $tags as $tk=>$tv}
                <tr>

                    <td style="width: 20%"><h3>{$tk}</h3>
                    </td>
                    <td class="hidden-xs">
                        {foreach $tv as $ttk=>$ttv}
                        <p style="font-size: 15px;">{$ttv['tags_name']}：{str_replace(',','、',$data['attr_new'][$ttk])}</p>
                        {/foreach}
                    </td>


                </tr>
                {/foreach}
                <tr>
                    <td><h3>服务备注</h3>
                    </td>
                    <td class="hidden-xs" style="font-size: 15px;">
                        <p>合作底价：{$data['cooperate_price']}</p>
                        <p>佣金比例：{$data['charges_proportion']}</p>
                        <p>佣金规则：{$data['charges_rules']}</p>
                        <p>内部评分：{$data['admin_score']}</p>
                        <p>内部备注：{$data['admin_demo']}</p>
                    </td>
                </tr>
                    <tr>
                    <td><h3>成交数据</h3>
                    </td>
                    <td class="hidden-xs" style="font-size: 15px;">
                        <p>成交量：{$order['complete_order']}</p>
                        <p>取消量：{$order['total_order']-$order['complete_order']}</p>
                        <p>成交率：{sprintf("%.2f", ($order['complete_order']/$order['total_order'])*100)}</p>

                    </td>
                </tr>
                <tr>
                    <td><h3>服务描述</h3>
                    </td>
                    <td class="hidden-xs" style="word-break:break-all;font-size: 15px;">
                        {$data['des']}
                    </td>
                </tr>
                <tr>
                    <td><h3>产品图片</h3>
                    </td>
                    <td class="hidden-xs" >
                        <ul id="imageGallery" class="gallery list-unstyled">
                            {foreach $data['media'] as $k=>$v}
                                {foreach $v[1] as $vv}
                                    <li >
                                        {if $vv[2]}
                                            <img src="{Page_Site_Global::displayMedia($vv[1],400,0,0)}"/>

                                        {else}
                                            <img src="{Page_Site_Global::displayMedia($vv[1],400,0,0)}"/>

                                        {/if}
                                    </li>
                                    </br>
                                {/foreach}
                            {/foreach}

                        </ul>
                    </td>
                </tr>
                </tr>
                </tbody>
            </table>

        </div>
</body>
<script type="text/javascript" src="js/jquery.lightSlider.js"></script>
<script src='js/jquery.fancybox.pack.js'></script>
<script type="text/javascript" src='js/banner.js'></script>
<script type="text/javascript" src='js/collect.js'></script>
<!-- END BODY -->
</html>