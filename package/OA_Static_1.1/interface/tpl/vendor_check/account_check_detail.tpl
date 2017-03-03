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
            <i class="fa fa-reorder"></i>账户审核信息
        </div>
    </div>
    <div class="portlet-body">
        <div class="tab-content clearfix">
            <div class="tab-pane fade active in" id="tab_1_1">
                <h3 >原账户信息</h3>
                <div class="table-responsive clearfix">
                    <div class="col-md-12">
                        <div class="form-group">
                            <label class="control-label col-md-3" style="font-size: 15px;">账户名称</label>

                            <div class="col-sm-9">
                                <p class="form-control-static" style="font-size: 15px;">{$old_data['username']}</p>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-12">
                        <div class="form-group">
                            <label class="control-label col-sm-3" style="font-size: 15px;">手机号</label>

                            <div class=" col-sm-9">
                                <p class="form-control-static" style="font-size: 15px;">{$old_data['phone']}</p>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-12">
                        <div class="form-group">
                            <label class="control-label col-sm-3"  style="font-size: 15px;">邮箱</label>

                            <div class="col-sm-9">
                                <p class="form-control-static"  style="font-size: 15px;">{$old_data['email']}</p>
                            </div>
                        </div>
                    </div>
                </div>
                <hr>
                <h3 >更新的账户信息</h3>
                <div class="table-responsive clearfix">
                    <div class="col-md-12">
                        <div class="form-group">
                            <label class="control-label col-md-3" style="font-size: 15px;">账户名称</label>

                            <div class="col-sm-9">
                                <p class="form-control-static" style="font-size: 15px;">{$new_data['username']}</p>
                                {if $new_data['username'] != $old_data['username']}
                                    <span class="btn btn-xs btn-warning">有更改</span>
                                {/if}
                            </div>
                        </div>
                    </div>
                    <div class="col-md-12">
                        <div class="form-group">
                            <label class="control-label col-sm-3" style="font-size: 15px;">手机号</label>

                            <div class=" col-sm-9">
                                <p class="form-control-static" style="font-size: 15px;">{$new_data['phone']}</p>
                                {if $new_data['phone'] != $old_data['phone']}
                                    <span class="btn btn-xs btn-warning">有更改</span>
                                {/if}
                            </div>
                        </div>
                    </div>
                    <div class="col-md-12">
                        <div class="form-group">
                            <label class="control-label col-sm-3"  style="font-size: 15px;">邮箱</label>

                            <div class="col-sm-9">
                                <p class="form-control-static"  style="font-size: 15px;">{$new_data['email']}</p>
                                {if $new_data['email'] != $old_data['email']}
                                    <span class="btn btn-xs btn-warning">有更改</span>
                                {/if}
                            </div>
                        </div>
                    </div>
                    <div class="col-md-12">
                        <div class="form-group">
                            <label class="control-label col-sm-3"  style="font-size: 15px;">密码</label>

                            <div class="col-sm-9">
                                <p class="form-control-static"  style="font-size: 15px;">
                                    {if !$new_data['password']}
                                        密码未更改
                                    {else}
                                        <span class="btn btn-xs btn-warning">密码已更改</span>
                                    {/if}
                                </p>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-12">
                        <div class="form-group">
                            <label class="control-label col-sm-3"  style="font-size: 15px;">交易密码</label>

                            <div class="col-sm-9">
                                <p class="form-control-static"  style="font-size: 15px;">
                                    {if !$new_data['password2']}
                                        交易密码未更改
                                    {else}
                                        <span class="btn btn-xs btn-warning">交易密码已更改</span>
                                    {/if}
                                </p>
                            </div>
                        </div>
                    </div>
                </div>
                <hr/>
                <div class="table-responsive clearfix">
                <form class="form-horizontal" action="?action=refuse&id={$new_data['id']}" method="post">
                    <div class="col-md-12">
                        <div class="form-group">
                            <label class="control-label col-sm-3" style="text-align: left">请输入拒绝理由</label>

                            <div class="col-sm-9">
                                {*<textarea id="refuseReason" name="refuse_reason" class="form-control" rows="3"></textarea>*}
                                <input type="text" placeholder="请输入或选择拒绝原因" class="form-control input-sm select2 tags_select2" value="" name="refuse_reason"   data-values="{implode(',',$rejectreason)}" id="refuseReason">
                            </div>
                        </div>
                    </div>
                    <div class="col-md-12">
                        <div class="form-group">
                            <div  style="padding-left: 50%;">
                                <a href="?action=pass&id={$new_data['id']}" class="btn btn-primary">通过</a>
                                <button type="submit" class="btn btn-danger" style="margin-left: 30px;">拒绝</button>
                            </div>
                        </div>
                    </div>
                </form>
                </div>
            </div>

        </div>
    </div>
</div>
</body>
<script>
    $(document).ready(function(){
        $(".tags_select2").each(function () {
            $(this).select2({
                tags: $(this).data('values').split(',')
            })
        });
    });
</script>
<script type="text/javascript" src="js/jquery.lightSlider.js"></script>
<script src='js/jquery.fancybox.pack.js'></script>
<script type="text/javascript" src='js/banner.js'></script>
<script type="text/javascript" src='js/collect.js'></script>
<script type="text/javascript" src="{$_assets}plugins/select2/select2.min.js"></script>
<!-- END BODY -->
</html>