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
<script src="{$_assets}plugins/jquery-1.11.0.min.js"
        type="text/javascript"></script>
<!-- END HEAD -->
<!-- BEGIN BODY -->
<body style="background:#FaFaFa !important">
<div class="portlet">
    <div class="portlet-title">
        <div class="caption">
            <i class="fa fa-database"></i>供应商加盟详情
        </div>
    </div>
    <div class="portlet-body">
        <div class="container-fluid">
            <div class="row">
                <table class="table table-hover" style="border:0px;">
                    <tbody>
                    <tr>
                        <td style="width: 20%;">创建时间：</td>
                        <td style="width: 79%;">{Date('Y-m-d H:i:s',$_data['create_time'])}</td>
                    </tr>
                    <tr>
                        <td>联系人：</td>
                        <td>{$_data['contact_people']}</td>
                    </tr>
                    <tr>
                        <td>联系电话：</td>
                        <td>{$_data['phone']}</td>
                    </tr>
                    <tr>
                        <td>名片:</td>
                        <td>
                            {foreach $_data['card'] as $val}
                                <div style="display: inline-block;width: 40%;">
                                    <img src="{$val['path']}" width="100%">
                                </div>
                            {/foreach}
                        </td>
                    </tr>
                    <tr>
                        <td>所在城市：</td>
                        <td>{$_data['city']}</td>
                    </tr>
                    <tr>
                        <td>供应商名称：</td>
                        <td>{$_data['vendor_name']}</td>
                    </tr>
                    <tr>
                        <td>商品类型：</td>
                        <td> {foreach $category as $key =>$val}
                                {foreach $val as $kk=>$vv}
                                    {if  $_data['category_id']==$kk}
                                        {$key}-->{$vv}
                                    {/if}
                                {/foreach}
                            {/foreach}</td>
                    </tr>
                    <tr>
                        <td>商品名称：</td>
                        <td>{$_data['product_name']}</td>
                    </tr>
                    <tr>
                        <td>商品图片：</td>
                        <td>
                            {foreach $_data['media'] as $val}
                                <div style="display: inline-block;width: 40%;">
                                    <img src="{$val['path']}" width="100%">
                                </div>
                            {/foreach}
                        </td>
                    </tr>
                    <tr>
                        <td>产品简介</td>
                        <td>
                            {$_data['product_des']}
                        </td>
                    </tr>
                    {if $_data['other']}
                    <tr>
                        <td>其他信息</td>
                        <td>
                            {foreach $_data['other'] as $key=>$val}
                                <p>{$key}：&nbsp;&nbsp;&nbsp;{$val}</p>
                            {/foreach}
                        </td>
                    </tr>
                    {/if}
                    {if $_data['refuse_reason']}
                        <tr>
                            <td>拒绝理由</td>
                            <td>
                                {$_data['refuse_reason']}
                            </td>
                        </tr>
                    {/if}
                    {if $_data['status'] == 0}
                        <tr>
                            <td colspan="2" style="background: #EEEEEE;text-align: center" data-id="{$_data['id']}">
                                <button onclick="vendorJoin.passSubmit(this)" class="btn btn-success">接受</button>
                                <button class="btn btn-danger" onclick="vendorJoin.refuseClick(this)">放弃
                                </button>
                            </td>
                        </tr>
                    {/if}
                    </tbody>
                </table>
            </div>
        </div>
    </div>
    {*********************弹框**************}
    <div class="modal fade" id="vendor_join_refuse" tabindex="-1" role="basic" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                    <h4 class="modal-title">
                        放弃理由</h4>
                </div>
                <div class="modal-body">

                    <table>
                        <tr>
                            <td>
                                放弃理由：
                            </td>
                            <td>
                                &bkarow;<input type="checkbox" name="reason" value="联系不到"> 联系不到
                            </td>
                            <td>
                                &bkarow; <input type="checkbox" value="恶意提交" name="reason"> 恶意提交
                            </td>
                            <td>
                                &bkarow; <input type="checkbox" name="reason" value="已存在供应商"> 已存在供应商
                        </tr>
                        <tr>
                            <td>
                                备注：
                            </td>
                            <td colspan="4"><textarea name="refuse_reason" class="form-control"
                                                      rows="5"></textarea>
                            </td>
                        </tr>
                    </table>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">
                        取消
                    </button>
                    <button type="button"
                            onclick="vendorJoin.refuseSubmit('input[name=refuse_reason]','textarea[name=refuse_reason]')"
                            class="btn btn-success create_site_submit">
                        确定
                    </button>
                </div>

            </div>
        </div>

    </div>
</body>
<script src="{$_assets}plugins/bootstrap/js/bootstrap.min.js"
        type="text/javascript"></script>
<script src="js/vendor_join/vendor_join.js"></script>
<!-- BEGIN CORE PLUGINS -->
</body>
<!-- END BODY -->
</html>