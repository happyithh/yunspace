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
            <i class="fa fa-reorder"></i>供应商详情
            {if $data['status']==1}
                <a href="http://{Core::$urls['host']}/vendor_info/{$data['id']}.html" class="btn btn-success"
                   target="_blank"><i class="fa fa-pencil"></i>供应商链接</a>
            {/if}
        </div>
    </div>
    <div class="portlet-body" >
        <div class="tab-content clearfix">
            <div class="tab-pane fade active in" id="tab_1_1">
                <h3>
                    基本信息
                </h3>
                <hr>
                <div class="table-responsive clearfix">
                    <div class="col-md-12">
                        <div class="form-group">
                            <label class="control-label col-md-1" style="font-size: 15px;">供应商名称</label>

                            <div class="col-sm-11">
                                <p style="font-size: 15px;">{$data['vendor_name']}</p>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-12">
                        <div class="form-group">
                            <label class="control-label col-md-1" style="font-size: 15px;">地址</label>

                            <div class="col-sm-11">
                                <p   style="font-size: 15px;">{$data['addr']}</p>
                            </div>
                        </div>
                    </div>

                    <div class="col-md-12">
                        <div class="form-group">
                            <label class="control-label col-md-1" style="font-size: 15px;">服务类型</label>

                            <div class="col-sm-11">
                                <p  
                                   style="font-size: 15px;">{foreach $data['categories_id'] as $k=>$v}
                                        {$_category[$v][0]}
                                        {if !empty($_category[$v][0])}
                                            &nbsp;&nbsp;&nbsp;
                                        {/if}
                                    {/foreach}</p>
                            </div>
                        </div>
                    </div>
                    {foreach $data['base_info'] as $k=>$v}
                        <div class="col-md-12">
                            <div class="form-group">
                                <label class="control-label col-md-1" style="font-size: 15px;">{$k}</label>

                                <div class="col-sm-11">
                                    <p   style="font-size: 15px;">{$v}</p>
                                </div>
                            </div>
                        </div>
                    {/foreach}
                </div>
                {if !empty($data['attr'])}
                <div class="tab-pane fade active in" id="tab_1_1">
                    <h3>
                        属性信息
                    </h3>
                    <hr>
                    <div class="table-responsive clearfix">
                        {foreach $data['attr'] as $k=>$v}
                            <div class="col-md-12">
                                <div class="form-group">
                                    <label class="control-label col-md-1" style="font-size: 15px;">{$k}</label>

                                    <div class="col-sm-11">
                                        <p   style="font-size: 15px;">{$v}</p>
                                    </div>
                                </div>
                            </div>
                        {/foreach}
                    </div>
                    {/if}
                    {if !empty($data['base_info']) }
                    <div class="tab-pane fade active in" id="tab_1_1">
                        <h3>
                            商户备注
                        </h3>
                        <hr>
                        <div class="table-responsive clearfix">
                            {foreach $data['base_info'] as $k=>$v}
                                <div class="col-md-12">
                                    <div class="form-group">
                                        <label class="control-label col-md-1" style="font-size: 15px;">{$k}</label>

                                        <div class="col-sm-11">
                                            <p   style="font-size: 15px;">{$v}</p>
                                        </div>
                                    </div>
                                </div>
                            {/foreach}
                        </div>
                        {/if}
                        <div class="tab-pane fade active in" id="tab_1_1">
                            <h3>
                                成交信息
                            </h3>
                            <hr>
                            <div class="table-responsive clearfix">
                                <div class="col-md-12">
                                    <div class="form-group">
                                        <label class="control-label col-md-1" style="font-size: 15px;">成交量</label>

                                        <div class="col-sm-11">
                                            <p  
                                               style="font-size: 15px;">{$order['complete_order']}</p>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-md-12">
                                    <div class="form-group">
                                        <label class="control-label col-md-1" style="font-size: 15px;">取消量</label>

                                        <div class="col-sm-11">
                                            <p  
                                               style="font-size: 15px;">{$order['total_order']-$order['complete_order']}</p>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-md-12">
                                    <div class="form-group">
                                        <label class="control-label col-md-1" style="font-size: 15px;">成交率</label>

                                        <div class="col-sm-11">
                                            <p  
                                               style="font-size: 15px;">{sprintf("%.2f", ($order['complete_order']/$order['total_order'])*100)}</p>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="tab-pane fade active in" id="tab_1_1">
                                <h3>
                                    公司描述
                                </h3>
                                <hr>
                                <div class="table-responsive clearfix">
                                    <div class="col-md-12">
                                        <div class="form-group">
                                            <div class="col-sm-11">
                                                <p  
                                                   style="font-size: 15px;">{$data['des']}</p>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

</body>
<!-- END BODY -->
</html>