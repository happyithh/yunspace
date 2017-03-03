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
            <i class="fa fa-database"></i>场地详情
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
                        <td style="width: 20%;">场地ID：</td>
                        <td style="width: 79%;">{$_data['id']}</td>
                    </tr>
                    <tr>
                        <td>场地名称：</td>
                        <td>{$_data['space_name']}</td>
                    </tr>

                    <tr>
                        <td>城市：</td>
                        <td>{$_data['city']}</td>
                    </tr>
                    <tr>
                        <td>场地地址：</td>
                        <td>{$_data['addr']}</td>
                    </tr>
                    <tr>
                        <td>场地类型：</td>
                        <td> {foreach $categoryTree[112] as $key =>$val}
                                {if  $_data['category_id']==$key}
                                    {$key}-->{$val}
                                {/if}
                            {/foreach}</td>
                    </tr>
                    <tr>
                        <td>联系人：</td>
                        <td>{$_data['contacts']}</td>
                    </tr>
                    <tr>
                        <td>联系电话：</td>
                        <td>{$_data['phone']}</td>
                    </tr>
                    <tr>
                        <td>邮箱：</td>
                        <td>{$_data['email']}</td>
                    </tr>
                    <tr>
                        <td>名片/营业执照:</td>
                        <td>
                            {foreach $_data['card'] as $key => $val}
                                <div style="display: inline-block;width: 20%;">
                                    <img src="{$val['path']}" width="100%">
                                </div>
                            {/foreach}
                        </td>
                    </tr>
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
                                <form action="?action=newspace" method="post" style="display: inline-block;">
                                <input type="hidden" name="space_id" value="{$_data['id']}">
                               {* <button onclick="spaceInfo.passSubmit(this)" class="btn btn-success">接受</button>*}
                                <button class="btn btn-success" type="submit">接受</button>
                                </form>
                                <button class="btn btn-danger" onclick="spaceInfo.refuseClick(this)">放弃
                                </button>
                            </td>

                        </tr>

                    {/if}
                    <tr>
                        <td style="height:150px;"></td>
                    </tr>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
    {*********************弹框**************}
    <div class="modal fade" id="space_refuse" tabindex="-1" role="basic" aria-hidden="true">
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
                                &bkarow; <input type="checkbox" name="reason" value="已存在供应商"> 已存在场地
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
                            onclick="spaceInfo.refuseSubmit('input[name=refuse_reason]','textarea[name=refuse_reason]')"
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
<script src="js/space_info_list/space_info_list.js"></script>
<!-- BEGIN CORE PLUGINS -->
</body>
<!-- END BODY -->
</html>