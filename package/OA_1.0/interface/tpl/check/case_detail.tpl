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
    <style>
        .hidden-xs {

            line-height: 28px;
            color: #666;
            float: left;
            font-size: 15px;
            display: block;
            width: 46%;
            margin: 0 2% 0 0;

        }
        .information_left{
            padding: 10px;
            line-height: 28px;
            font-size: 15px;
            float: left;
            width: 100%;
        }
        .hidden-xs span{
            display: block;
            width: 46%;
            float: left;
            margin: 0 2% 0 0;
            padding-left: 90px;
        }

    </style>
</head>
<!-- END HEAD -->
<!-- BEGIN BODY -->

<body style="background:#FaFaFa !important">
<!-- BEGIN PAGE HEADER-->
<h3 class="page-title" style="float: left;">
    案例信息审核页
</h3>
<a href="javascript:history.go(-1)" class="back"><
    <返回
</a>

<div class="clear"></div>
<div class="portlet">
    <div class="portlet-body">
            <table class="table table-striped table-bordered table-advance">
                <tbody>
                    <tr>
                        <td style="width: 20%;">
                            <div class="information_left">
                                活动名称
                            </div>
                        </td>
                        <td>
                            <div class="hidden-xs" style="padding-left: 90px;">
                                {$data['event_name']}
                            </div>
                        </td>
                    </tr>

                    <tr>
                        <td>
                            <div class="information_left">
                                活动类型
                            </div>
                        </td>
                        <td>
                            <div class="hidden-xs" style="padding-left: 90px;">
                                {$data['attr']['活动类型']}
                            </div>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <div class="information_left">
                                行业
                            </div>
                        </td>
                        <td>
                            <div class="hidden-xs" style="padding-left: 90px;">
                                {$data['attr']['服务行业']}
                            </div>
                        </td>
                    </tr>

                    <tr>
                        <td>
                            <div class="information_left">
                                相关服务
                            </div>
                        </td>
                        <td>
                            <div class="hidden-xs" style="padding-left: 90px;">
                                {$data['product_name']}
                            </div>
                        </td>
                    </tr>

                    <tr>
                        <td>
                            <div class="information_left">
                                案例名称
                            </div>
                        </td>
                        <td>
                            <div class="hidden-xs" style="padding-left: 90px;">
                                {$data['case_name']}
                            </div>
                        </td>
                    </tr>

                    <tr>
                        <td>
                            <div class="information_left">
                                案例介绍
                            </div>
                        </td>
                        <td>
                            <div class="hidden-xs" style="padding-left: 90px;">
                                {$data['des']}
                            </div>
                        </td>
                    </tr>

                    <tr>
                        <td>
                            <div class="information_left" >
                                相关图片/视频
                            </div>
                        </td>
                        <td>
                            <div class="hidden-xs" style="padding-left: 90px;">
                                {foreach $data['media'] as $k=>$v}
                                    <p><c>缩略图
                                            ：
                                        </c><img src="{$v['path']}" style="height: 120px; width: 120px; "></p>
                                    <p><c>名称
                                            ：
                                        </c>{$v['name']}</p>
                                    <p><c>标签：
                                        </c>{$v['tags']}</p>
                                    {if !empty({$data['media'][$k+1]})}
                                        <hr>
                                    {else}
                                    {/if}

                                {/foreach}
                            </div>
                        </td>
                    </tr>
                    <form action="?action=check_case&handle_type=refuse&id={$data['id']}&vendor_id={$_REQUEST['vendor_id']}&admin_name={$_REQUEST['admin_name']}" method="post">
                        <tr>
                            <td>
                                <div class="information_left" >
                                    请输入拒绝理由
                                </div>
                            </td>
                            <td>
                                <div class="hidden-xs" style="padding-left: 90px;">
                                    {*<textarea id="refuseReason" name="reason" class="form-control" rows="3"></textarea>*}
                                    <input type="text" placeholder="请输入或选择拒绝原因" class="form-control input-sm select2 tags_select2" value="" name="reason"   data-values="{implode(',',$rejectreason)}" id="refuseReason">
                            </td>
                        </tr>
                        <tr >
                            <td  colspan="2" style="border-left:0;">
                                <div  style="padding-left: 50%;">
                                    <a href="?action=check_case&handle_type=pass&id={$data['id']}&vendor_id={$_REQUEST['vendor_id']}&admin_name={$_REQUEST['admin_name']}" class="btn btn-primary">通过</a>
                                    <button type="submit" class="btn btn-danger">拒绝</button>
                                </div>
                            </td>

                        </tr>
                    </form>
                </tbody>
            </table>
        </div>
    </div>


<!-- BEGIN CORE PLUGINS -->
<script>
    $(document).ready(function(){
        $(".tags_select2").each(function () {
            $(this).select2({
                tags: $(this).data('values').split(',')
            })
        });
    });
</script>
<script src="{$_assets}plugins/jquery-1.11.0.min.js"
        type="text/javascript"></script>
<script src="{$_assets}plugins/jquery-migrate-1.2.1.min.js"
        type="text/javascript"></script>
<!-- IMPORTANT! Load jquery-ui-1.10.3.custom.min.js before bootstrap.min.js to fix bootstrap tooltip conflict with jquery ui tooltip -->
<script src="{$_assets}plugins/jquery-ui/jquery-ui-1.10.3.custom.min.js"
        type="text/javascript"></script>
<script src="{$_assets}plugins/bootstrap/js/bootstrap.min.js"
        type="text/javascript"></script>
<script src="{$_assets}plugins/bootstrap-hover-dropdown/bootstrap-hover-dropdown.min.js"
        type="text/javascript"></script>
<script src="{$_assets}plugins/jquery-slimscroll/jquery.slimscroll.min.js"
        type="text/javascript"></script>
<script src="{$_assets}plugins/jquery.blockui.min.js"
        type="text/javascript"></script>
<script src="{$_assets}plugins/uniform/jquery.uniform.min.js"
        type="text/javascript"></script>
<!-- END CORE PLUGINS -->
<!-- BEGIN PAGE LEVEL PLUGINS -->
<script type="text/javascript"
        src="{$_assets}plugins/select2/select2.min.js"></script>
<script type="text/javascript"
        src="{$_assets}plugins/datatables/media/js/jquery.dataTables.min.js"></script>
<script type="text/javascript"
        src="{$_assets}plugins/datatables/plugins/bootstrap/dataTables.bootstrap.js"></script>
<!-- END PAGE LEVEL PLUGINS -->
<!-- BEGIN PAGE LEVEL SCRIPTS -->
<script src="{$_assets}scripts/_page.js"></script>
</body>
<!-- END BODY -->
</html>