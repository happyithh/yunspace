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
    <script src="{$_assets}plugins/jquery-1.11.0.min.js" type="text/javascript"></script>
    <style>

        .form-actions{ margin-top: -15px;}

    </style>
</head>
<!-- END HEAD -->
<!-- BEGIN BODY -->
<body style="background:#FaFaFa !important">


<div class="portlet tabbable">
<div class="portlet-title">
    <div class="caption">
        <i class="fa fa-database"></i>服务详情
    </div>

</div>
<div>
    <div class="portlet-body form">

        <form action="form_layouts.html#" class="form-horizontal">
            <div class="form-body">
                <div class="row">
                    <div class="col-md-6">
                        <div class="col-md-12">
                            <div class="form-group">
                                <label class="control-label col-md-4">供货商ID</label>

                                <div class="col-md-8">
                                    <p class="form-control-static">
                                        13782173902193
                                    </p>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-12">
                            <div class="form-group">
                                <label class="control-label col-md-4">供应商名称</label>
                                <div class="col-md-8">
                                    <p class="form-control-static">
                                        上海同立科技有限公司
                                    </p>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-12">
                            <div class="form-group">
                                <label class="control-label col-md-4">服务类型</label>
                                <div class="col-md-8">
                                    <p class="form-control-static">
                                        空间场地
                                    </p>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-12">
                            <div class="form-group">
                                <label class="control-label col-md-4">供应商状态</label>
                                <div class="col-md-8">
                                    <p class="form-control-static">
                                        已上线
                                    </p>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-12">
                            <div class="form-group">
                                <label class="control-label col-md-4">签约状态</label>
                                <div class="col-md-8">
                                    <p class="form-control-static">
                                        合作备忘录
                                    </p>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-12">
                            <div class="form-group">
                                <label class="control-label col-md-4">负责人</label>
                                <div class="col-md-8">
                                    <p class="form-control-static">
                                        Gary
                                    </p>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-12">
                            <div class="form-group">
                                <label class="control-label col-md-4">更新时间</label>
                                <div class="col-md-8">
                                    <p class="form-control-static">
                                        2015-03-08 15:20:03
                                    </p>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-6">
                        <div class="col-md-12" style="margin-bottom: 30px; text-align: right;">
                            <button type="button" class="btn btn-primary">转移负责人</button>
                        </div>
                        <div class="col-md-12" style="margin-bottom: 30px; text-align: right;">
                            <button type="button" class="btn btn-info">提交审核</button>
                        </div>
                        <div class="col-md-12" style="margin-bottom: 30px; text-align: right;">
                            <button type="button" class="btn btn-success">审核通过</button>
                        </div>
                        <div class="col-md-12" style="margin-bottom: 30px; text-align: right;">
                            <button type="button" class="btn btn-danger">供应商下线</button>
                        </div>
                    </div>
                </div>
            </div>

        </form>

    </div>

</div>
<div class="portlet-body form">
<form class="form-horizontal" role="form" action="?" method="post">
<input type="hidden" name="action" value="{if $_REQUEST['ids']}update{else}insert{/if}">
<input type="hidden" name="url_to" value="{$_REQUEST['url_to']}">
<input type="hidden" name="ids[0]" value="{$_REQUEST['ids'][0]}">

<div class="tabbable tabbable-custom boxless" style="padding: 20px ;">
<ul class="nav nav-tabs">
    <li class="active">
        <a href="form_image_crop.html#tab_1" data-toggle="tab">账户信息</a>
    </li>
    <li>
        <a href="form_image_crop.html#tab_2" data-toggle="tab">供货商信息</a>
    </li>
    <li>
        <a href="form_image_crop.html#tab_3" data-toggle="tab">产品服务</a>
    </li>
    <li>
        <a href="form_image_crop.html#tab_4" data-toggle="tab">订单交易</a>
    </li>
    <li>
        <a href="form_image_crop.html#tab_5" data-toggle="tab">联系人</a>
    </li>
    <li>
        <a href="form_image_crop.html#tab_6" data-toggle="tab">操作日志</a>
    </li>
</ul>
<div class="tab-content">
<div class="tab-pane active" id="tab_1">
<div class="container-fluid">
<div class="panel panel-info">
    <div class="panel-heading">
        <h3 class="panel-title" id="panel-title">企业认证信息<a class="anchorjs-link" href="#panel-title"><span class="anchorjs-icon"></span></a></h3>
    </div>
    <div class="panel-body">
    <div class="row">
        <div class="col-md-12"> <h5><strong>认证信息</strong></h5></div>
        <div class="col-md-6">
            <div class="form-group">
                <label class=" col-md-4 control-label">公司名称</label>
                <div class="col-md-8">
                    <input class="form-control" type="text">
                </div>
            </div>
        </div>
        <div class="col-md-6">
            <div class="form-group">
                <label class=" col-md-4 control-label">公司电话</label>
                <div class="col-md-8">
                    <input class="form-control" type="text">
                </div>
            </div>
        </div>
        <div class="col-md-6">
            <div class="form-group">
                <label class=" col-md-4 control-label">公司地址</label>
                <div class="col-md-8">
                    <input class="form-control" type="text">
                </div>
            </div>
        </div>
        <div class="col-md-6">
            <div class="form-group">
                <label class=" col-md-4 control-label">公司网址</label>
                <div class="col-md-8">
                    <input class="form-control" type="text">
                </div>
            </div>
        </div>
        <div class="col-md-6">
            <div class="form-group">
                <label class=" col-md-4 control-label">注册地址</label>
                <div class="col-md-8">
                    <input class="form-control" type="text">
                </div>
            </div>
        </div>
        <div class="col-md-6">
            <div class="form-group">
                <label class=" col-md-4 control-label">注册资本</label>
                <div class="col-md-8">
                    <input class="form-control" type="text">
                </div>
            </div>
        </div>
        <div class="col-md-6">
            <div class="form-group">
                <label class=" col-md-4 control-label">营业执照</label>
                <div class="col-md-8">
                    <input class="form-control" type="text">
                </div>
            </div>
        </div>
        <div class="col-md-6">
            <div class="form-group">
                <label class=" col-md-4 control-label">税务登记号</label>
                <div class="col-md-8">
                    <input class="form-control" type="text">
                </div>
            </div>
        </div>
        <div class="col-md-6">
            <div class="form-group">
                <label class=" col-md-4 control-label">固定电话</label>
                <div class="col-md-8">
                    <input class="form-control" type="text">
                </div>
            </div>
        </div>
        <div class="col-md-6">
            <div class="form-group">
                <label class=" col-md-4 control-label">传真号码</label>
                <div class="col-md-8">
                    <input class="form-control" type="text">
                </div>
            </div>
        </div>
        <div class="col-md-6">
            <div class="form-group">
                <label class=" col-md-4 control-label">法人代表</label>
                <div class="col-md-8">
                    <input class="form-control" type="text">
                </div>
            </div>
        </div>
        <div class="col-md-6">
            <div class="form-group">
                <label class=" col-md-4 control-label">法人证件</label>
                <div class="col-md-8">
                    <input class="form-control" type="text">
                </div>
            </div>
        </div>
        <div class="col-md-6">
            <div class="form-group">
                <label class=" col-md-4 control-label">员工规模</label>
                <div class="col-md-8">
                    <input class="form-control" type="text">
                </div>
            </div>
        </div>
        <div class="col-md-6">
            <div class="form-group">
                <label class=" col-md-4 control-label">法人证件号</label>
                <div class="col-md-8">
                    <input class="form-control" type="text">
                </div>
            </div>
        </div>
        <div class="col-md-6">
            <div class="form-group">
                <label class=" col-md-4 control-label">主要联系人</label>
                <div class="col-md-8">
                    <input class="form-control" type="text">
                </div>
            </div>
        </div>
        <div class="col-md-6">
            <div class="form-group">
                <label class=" col-md-4 control-label">联系人身份证号</label>
                <div class="col-md-8">
                    <input class="form-control" type="text">
                </div>
            </div>
        </div>
        <div class="col-md-6">
            <div class="form-group">
                <label class=" col-md-4 control-label">联系人电话</label>
                <div class="col-md-8">
                    <input class="form-control" type="text">
                </div>
            </div>
        </div>
        <div class="col-md-6">
            <div class="form-group">
                <label class=" col-md-4 control-label">联系人电子邮箱</label>
                <div class="col-md-8">
                    <input class="form-control" type="text">
                </div>
            </div>
        </div>
    </div>
    <div class="row">
        <div class="col-md-12"> <h5><strong>相关资料</strong></h5></div>
        <div class="col-md-6">
            <div class="form-group">
                <label class=" col-md-4 control-label">合作方信息询问表</label>
                <div class="col-md-8">
                    <input type="file" id="exampleInputFile1" style="margin-top: 10px;">
                </div>
            </div>
        </div>
        <div class="col-md-6">
            <div class="form-group">
                <label class=" col-md-4 control-label">营业执照</label>
                <div class="col-md-8">
                    <input type="file" id="exampleInputFile1" style="margin-top: 10px;">
                </div>
            </div>
        </div>
        <div class="col-md-6">
            <div class="form-group">
                <label class=" col-md-4 control-label">税务登记证</label>
                <div class="col-md-8">
                    <input type="file" id="exampleInputFile1" style="margin-top: 10px;">
                </div>
            </div>
        </div>
        <div class="col-md-6">
            <div class="form-group">
                <label class=" col-md-4 control-label">合作银行信息函</label>
                <div class="col-md-8">
                    <input type="file" id="exampleInputFile1" style="margin-top: 10px;">
                </div>
            </div>
        </div>
    </div>
    <div class="row">
        <div class="col-md-12"> <h5><strong>收款账号</strong></h5></div>
        <div class="col-md-6">
            <div class="form-group">
                <label class=" col-md-4 control-label">账号名称</label>
                <div class="col-md-8">
                    <input class="form-control" type="text">
                </div>
            </div>
        </div>
        <div class="col-md-6">
            <div class="form-group">
                <label class=" col-md-4 control-label">账号</label>
                <div class="col-md-8">
                    <input class="form-control" type="text">
                </div>
            </div>
        </div>
        <div class="col-md-6">
            <div class="form-group">
                <label class=" col-md-4 control-label">开户行</label>
                <div class="col-md-8">
                    <input class="form-control" type="text">
                </div>
            </div>
        </div>
    </div>
    <div class="row">
        <div class="col-md-12"> <h5><strong>安全信息</strong></h5></div>
        <div class="col-md-6">
            <div class="form-group">
                <label class=" col-md-4 control-label">登录密码</label>
                <div class="col-md-8">
                    <input class="form-control" type="text">
                </div>
            </div>
        </div>
        <div class="col-md-6">
            <div class="form-group">
                <label class=" col-md-4 control-label">交易密码</label>
                <div class="col-md-8">
                    <input class="form-control" type="text">
                </div>
            </div>
        </div>
        <div class="col-md-6">
            <div class="form-group">
                <label class=" col-md-4 control-label">绑定手机</label>
                <div class="col-md-8">
                    <input class="form-control" type="text">
                </div>
            </div>
        </div>
        <div class="col-md-6">
            <div class="form-group">
                <label class=" col-md-4 control-label">绑定邮箱</label>
                <div class="col-md-8">
                    <input class="form-control" type="text">
                </div>
            </div>
        </div>
        <div class="col-md-6">
            <div class="form-group">
                <label class=" col-md-4 control-label">绑定微信</label>
                <div class="col-md-8">
                    <input class="form-control" type="text">
                </div>
            </div>
        </div>
        <div class="col-md-6">
            <div class="form-group">
                <label class=" col-md-4 control-label">绑定QQ</label>
                <div class="col-md-8">
                    <input class="form-control" type="text">
                </div>
            </div>
        </div>
    </div>
    </div>
</div>
<div class="panel panel-success">
    <div class="panel-heading">
        <h3 class="panel-title" id="panel-title">个人认证信息<a class="anchorjs-link" href="#panel-title"><span class="anchorjs-icon"></span></a></h3>
    </div>
    <div class="panel-body">
        <div class="row">
            <div class="col-md-12"> <h5><strong>认证信息</strong></h5></div>
            <div class="col-md-6">
                <div class="form-group">
                    <label class=" col-md-4 control-label">姓名</label>
                    <div class="col-md-8">
                        <input class="form-control" type="text">
                    </div>
                </div>
            </div>
            <div class="col-md-6">
                <div class="form-group">
                    <label class=" col-md-4 control-label">性别</label>
                    <div class="col-md-8">
                        <input class="form-control" type="text">
                    </div>
                </div>
            </div>
            <div class="col-md-6">
                <div class="form-group">
                    <label class=" col-md-4 control-label">年龄</label>
                    <div class="col-md-8">
                        <input class="form-control" type="text">
                    </div>
                </div>
            </div>
            <div class="col-md-6">
                <div class="form-group">
                    <label class=" col-md-4 control-label">城市</label>
                    <div class="col-md-8">
                        <input class="form-control" type="text">
                    </div>
                </div>
            </div>
            <div class="col-md-6">
                <div class="form-group">
                    <label class=" col-md-4 control-label">证件类型</label>
                    <div class="col-md-8">
                        <input class="form-control" type="text">
                    </div>
                </div>
            </div>
            <div class="col-md-6">
                <div class="form-group">
                    <label class=" col-md-4 control-label">证件号码</label>
                    <div class="col-md-8">
                        <input class="form-control" type="text">
                    </div>
                </div>
            </div>
            <div class="col-md-6">
                <div class="form-group">
                    <label class=" col-md-4 control-label">籍贯</label>
                    <div class="col-md-8">
                        <input class="form-control" type="text">
                    </div>
                </div>
            </div>
            <div class="col-md-6">
                <div class="form-group">
                    <label class=" col-md-4 control-label">学历</label>
                    <div class="col-md-8">
                        <input class="form-control" type="text">
                    </div>
                </div>
            </div>
            <div class="col-md-6">
                <div class="form-group">
                    <label class=" col-md-4 control-label">住址</label>
                    <div class="col-md-8">
                        <input class="form-control" type="text">
                    </div>
                </div>
            </div>
            <div class="col-md-6">
                <div class="form-group">
                    <label class=" col-md-4 control-label">邮编</label>
                    <div class="col-md-8">
                        <input class="form-control" type="text">
                    </div>
                </div>
            </div>
        </div>
        <div class="row">
            <div class="col-md-12"> <h5><strong>相关资料</strong></h5></div>
            <div class="col-md-6">
                <div class="form-group">
                    <label class=" col-md-4 control-label">身份证复印件</label>
                    <div class="col-md-8">
                        <input type="file" id="exampleInputFile1" style="margin-top: 10px;">
                    </div>
                </div>
            </div>
            <div class="col-md-6">
                <div class="form-group">
                    <label class=" col-md-4 control-label">免冠正面照</label>
                    <div class="col-md-8">
                        <input type="file" id="exampleInputFile1" style="margin-top: 10px;">
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>


</div>
</div>
<div class="tab-pane" id="tab_2">
    <div class="row">
        <div class="col-md-12"> <h5><strong>商户信息</strong></h5></div>
        <div class="col-md-6">
            <div class="form-group">
                <label class=" col-md-4 control-label">商户名称</label>
                <div class="col-md-8">
                    <input class="form-control" type="text">
                </div>
            </div>
        </div>
        <div class="col-md-6">
            <div class="form-group">
                <label class=" col-md-4 control-label">品牌名称</label>
                <div class="col-md-8">
                    <input class="form-control" type="text">
                </div>
            </div>
        </div>
        <div class="col-md-6">
            <div class="form-group">
                <label class=" col-md-4 control-label">服务类型</label>
                <div class="col-md-8">
                    <select class="form-control">
                        <option>空间场地</option>
                        <option>配套服务</option>
                    </select>
                </div>
            </div>
        </div>
        <div class="col-md-6">
            <div class="form-group">
                <label class=" col-md-4 control-label">服务区域</label>
                <div class="col-md-8">
                    <input class="form-control" type="text">
                </div>
            </div>
        </div>
        <div class="col-md-6">
            <div class="form-group">
                <label class=" col-md-4 control-label">行业领域</label>
                <div class="col-md-8">
                    <input class="form-control" type="text">
                </div>
            </div>
        </div>
        <div class="col-md-6">
            <div class="form-group">
                <label class=" col-md-4 control-label">公司规模</label>
                <div class="col-md-8">
                    <input class="form-control" type="text">
                </div>
            </div>
        </div>
        <div class="col-md-6">
            <div class="form-group">
                <label class=" col-md-4 control-label">资质证书</label>
                <div class="col-md-8">
                    <input type="file" id="exampleInputFile1" style="margin-top: 10px;">
                </div>
            </div>
        </div>
        <div class="col-md-6">
            <div class="form-group">
                <label class=" col-md-4 control-label">公司LOGO</label>
                <div class="col-md-8">
                    <input type="file" id="exampleInputFile1" style="margin-top: 10px;">
                </div>
            </div>
        </div>
        <div class="col-md-6">
            <div class="form-group">
                <label class=" col-md-4 control-label">介绍描述</label>
                <div class="col-md-8">
                    <textarea class="form-control" rows="3"></textarea>
                </div>
            </div>
        </div>

    </div>
    <div class="row">
        <div class="col-md-12"> <h5><strong>合作信息</strong></h5></div>
        <div class="col-md-6">
            <div class="form-group">
                <label class=" col-md-4 control-label">签约状态</label>
                <div class="col-md-8">

                     <div style="font-size: 14px; padding-top: 10px;">合作备忘录</div>


                </div>
            </div>
        </div>
        <div class="col-md-6">
            <div class="form-group">
                <label class=" col-md-4 control-label">返佣规则</label>
                <div class="col-md-8">
                    <div class="input-group">
                        <input type="text" class="form-control">
															<span class="input-group-addon">
															%
															</span>
                    </div>
                </div>
            </div>
        </div>
        <div class="col-md-6">
            <div class="form-group">
                <label class=" col-md-4 control-label">签约附件</label>
                <div class="col-md-8">
                    <input type="file" id="exampleInputFile" style="margin-top: 10px;">
                </div>
            </div>
        </div>
    </div>
    <div class="row">
        <div class="col-md-12"> <h5><strong>商户评级</strong></h5></div>
        <div class="col-md-6">
            <div class="form-group">
                <label class=" col-md-4 control-label">综合评分</label>
                <div class="col-md-8">
                    <div style="font-size: 14px; padding-top: 10px;">5</div>
                </div>
            </div>
        </div>
        <div class="col-md-6">
            <div class="form-group">
                <label class=" col-md-4 control-label">成交量</label>
                <div class="col-md-8">
                    <div style="font-size: 14px; padding-top: 10px;">5</div>
                </div>
            </div>
        </div>
        <div class="col-md-6">
            <div class="form-group">
                <label class=" col-md-4 control-label">客户评分</label>
                <div class="col-md-8">
                    <div style="font-size: 14px; padding-top: 10px;">5</div>
                </div>
            </div>
        </div>
        <div class="col-md-6">
            <div class="form-group">
                <label class=" col-md-4 control-label">取消量</label>
                <div class="col-md-8">
                    <div style="font-size: 14px; padding-top: 10px;">5</div>
                </div>
            </div>
        </div>
        <div class="col-md-6">
            <div class="form-group">
                <label class=" col-md-4 control-label">执行评分</label>
                <div class="col-md-8">
                    <div style="font-size: 14px; padding-top: 10px;">5</div>
                </div>
            </div>
        </div>
        <div class="col-md-6">
            <div class="form-group">
                <label class=" col-md-4 control-label">成交率</label>
                <div class="col-md-8">
                    <div style="font-size: 14px; padding-top: 10px;">5</div>
                </div>
            </div>
        </div>
    </div>
    <div class="row">
        <div class="col-md-12"> <h5><strong>商户备注</strong></h5></div>
        <div class="col-md-6">
            <div class="form-group">
                <label class=" col-md-4 control-label">备注内容</label>
                <div class="col-md-8">
                    <textarea class="form-control" rows="3"></textarea>
                </div>
            </div>
        </div>
    </div>
</div>
<div class="tab-pane" id="tab_3" style="height: auto; overflow:hidden;">
    <div style="float: right; margin-bottom: 10px;">
    <button type="button" class="btn btn-success"><span class="glyphicon glyphicon-plus">
</span>创建服务</button></div>
    <table class="table table-striped table-bordered table-hover" id="data_table" style="word-break: break-all">
        <thead>

        <tr>
            <th>
                更新时间
            </th>

            <th>
                服务ID
            </th>
            <th>
                服务名称
            </th>
            <th>
                服务类型
            </th>
            <th>
                当前状态
            </th>
            <th>
                供应商名称
            </th>
            <th>
                负责人
            </th>
            <th>
                操作
            </th>

        </tr>
        </thead>
        <tbody>


        <tr>
            <td>
                2015-03-08 15：00
            </td>
            <td>
                156451
            </td>
            <td>
                上海ROSE
            </td>

            <td>
                空间场地
            </td>
            <td>
                <select class="form-control">
                    <option>上线</option>
                    <option>下线</option>
                </select>
            </td>
            <td>
                上海ROSEHi公司
            </td>
            <td>
                Gary
            </td>

            <td>
                <a href="service_edit" class="btn btn-info btn-xs">详情</a>


                <a href="#" target="_blank" class="btn btn-success btn-xs">预览</a>
            </td>

        </tr>

        </tbody>
    </table>
    <div class="pull-right">
        <ul class="pagination">
            <li class="prev disabled">
                <a href="#" title="First"><i class="fa fa-angle-double-left"></i></a>
            </li>
            <li class="prev disabled">
                <a href="#" title="Prev"><i class="fa fa-angle-left"></i></a>
            </li>
            <li class="active">
                <a href="?dn=10&amp;dt=34&amp;dp=1">1</a>
            </li>
            <li>
                <a href="?dn=10&amp;dt=34&amp;dp=2">2</a>
            </li>
            <li>
                <a href="?dn=10&amp;dt=34&amp;dp=3">3</a>
            </li>
            <li>
                <a href="?dn=10&amp;dt=34&amp;dp=4">4</a>
            </li>
            <li class="disabled">
                <a> 4 ( 10/34 )</a></li>

            <li class="next">
                <a href="?dn=10&amp;dt=34&amp;dp=2" title="Next"><i class="fa fa-angle-right"></i></a>
            </li>
            <li class="next">
                <a href="?dn=10&amp;dt=34&amp;dp=4" title="Last"><i class="fa fa-angle-double-right"></i></a>
            </li>
        </ul>
    </div>
</div>
<div class="tab-pane" id="tab_4" style="height: auto; overflow:hidden;">
    <div style="float: right; margin-bottom: 10px;">
        <button type="button" class="btn btn-success"><span class="glyphicon glyphicon-plus">
</span>创建订单</button></div>
    <table class="table table-striped table-bordered table-hover" id="data_table" style="word-break: break-all">
        <thead>

        <tr>
            <th>
                更新时间
            </th>

            <th>
                订单号
            </th>
            <th>
                订单状态
            </th>
            <th>
                服务名称
            </th>
            <th>
                用户名称
            </th>
            <th>
                供应商名称
            </th>
            <th>
                负责人
            </th>
            <th>
                操作
            </th>

        </tr>
        </thead>
        <tbody>


        <tr>
            <td>
                2015-03-08 15：00
            </td>
            <td>
                156451
            </td>
            <td>
                待审核
            </td>

            <td>
                上海ROSE
            </td>
            <td>
                上海通力科技
            </td>
            <td>
                上海ROSEHi公司
            </td>
            <td>
                Gary
            </td>

            <td>
                <a href="service_edit" class="btn btn-info btn-xs">详情</a>


                <a href="#" target="_blank" class="btn btn-success btn-xs">预览</a>
            </td>

        </tr>

        </tbody>
    </table>
    <div class="pull-right">
        <ul class="pagination">
            <li class="prev disabled">
                <a href="#" title="First"><i class="fa fa-angle-double-left"></i></a>
            </li>
            <li class="prev disabled">
                <a href="#" title="Prev"><i class="fa fa-angle-left"></i></a>
            </li>
            <li class="active">
                <a href="?dn=10&amp;dt=34&amp;dp=1">1</a>
            </li>
            <li>
                <a href="?dn=10&amp;dt=34&amp;dp=2">2</a>
            </li>
            <li>
                <a href="?dn=10&amp;dt=34&amp;dp=3">3</a>
            </li>
            <li>
                <a href="?dn=10&amp;dt=34&amp;dp=4">4</a>
            </li>
            <li class="disabled">
                <a> 4 ( 10/34 )</a></li>

            <li class="next">
                <a href="?dn=10&amp;dt=34&amp;dp=2" title="Next"><i class="fa fa-angle-right"></i></a>
            </li>
            <li class="next">
                <a href="?dn=10&amp;dt=34&amp;dp=4" title="Last"><i class="fa fa-angle-double-right"></i></a>
            </li>
        </ul>
    </div>
</div>
<div class="tab-pane" id="tab_5" style="height: auto; overflow:hidden;">
    <div style="float: right; margin-bottom: 10px;">
        <button type="button" class="btn btn-success"><span class="glyphicon glyphicon-plus">
</span>添加联系人</button></div>
    <table class="table table-striped table-bordered table-hover" id="data_table" style="word-break: break-all">
        <thead>

        <tr>
            <th>
                联系人姓名
            </th>

            <th>
                手机号码
            </th>
            <th>
                公司职位
            </th>
            <th>
                服务名称
            </th>

        </tr>
        </thead>
        <tbody>


        <tr>
            <td>
                Gery
            </td>
            <td>
                156451
            </td>
            <td>
                市场总监
            </td>
            <td>
                <a href="service_edit" class="btn btn-info btn-xs">查看详情</a>

            </td>

        </tr>

        </tbody>
    </table>
    <div class="pull-right">
        <ul class="pagination">
            <li class="prev disabled">
                <a href="#" title="First"><i class="fa fa-angle-double-left"></i></a>
            </li>
            <li class="prev disabled">
                <a href="#" title="Prev"><i class="fa fa-angle-left"></i></a>
            </li>
            <li class="active">
                <a href="?dn=10&amp;dt=34&amp;dp=1">1</a>
            </li>
            <li>
                <a href="?dn=10&amp;dt=34&amp;dp=2">2</a>
            </li>
            <li>
                <a href="?dn=10&amp;dt=34&amp;dp=3">3</a>
            </li>
            <li>
                <a href="?dn=10&amp;dt=34&amp;dp=4">4</a>
            </li>
            <li class="disabled">
                <a> 4 ( 10/34 )</a></li>

            <li class="next">
                <a href="?dn=10&amp;dt=34&amp;dp=2" title="Next"><i class="fa fa-angle-right"></i></a>
            </li>
            <li class="next">
                <a href="?dn=10&amp;dt=34&amp;dp=4" title="Last"><i class="fa fa-angle-double-right"></i></a>
            </li>
        </ul>
    </div>
</div>
<div class="tab-pane" id="tab_6" style="height: auto; overflow:hidden;">

    <table class="table table-striped table-bordered table-hover" id="data_table" style="word-break: break-all">
        <thead>

        <tr>
            <th>
                更新时间
            </th>

            <th>
                操作内容
            </th>
            <th>
                操作人
            </th>


        </tr>
        </thead>
        <tbody>


        <tr>

            <td>
                156451
            </td>
            <td>
                审核通过
            </td>
            <td>
                SUE

            </td>

        </tr>

        </tbody>
    </table>
    <div class="pull-right">
        <ul class="pagination">
            <li class="prev disabled">
                <a href="#" title="First"><i class="fa fa-angle-double-left"></i></a>
            </li>
            <li class="prev disabled">
                <a href="#" title="Prev"><i class="fa fa-angle-left"></i></a>
            </li>
            <li class="active">
                <a href="?dn=10&amp;dt=34&amp;dp=1">1</a>
            </li>
            <li>
                <a href="?dn=10&amp;dt=34&amp;dp=2">2</a>
            </li>
            <li>
                <a href="?dn=10&amp;dt=34&amp;dp=3">3</a>
            </li>
            <li>
                <a href="?dn=10&amp;dt=34&amp;dp=4">4</a>
            </li>
            <li class="disabled">
                <a> 4 ( 10/34 )</a></li>

            <li class="next">
                <a href="?dn=10&amp;dt=34&amp;dp=2" title="Next"><i class="fa fa-angle-right"></i></a>
            </li>
            <li class="next">
                <a href="?dn=10&amp;dt=34&amp;dp=4" title="Last"><i class="fa fa-angle-double-right"></i></a>
            </li>
        </ul>
    </div>
</div>
</div>
</div>
</div>

<div class="form-actions text-center">
    <button type=" reset" class="btn btn-default">
        重置
    </button>
    <button type="submit" class="btn btn-success">
        提交
    </button>
</div>
</form>
</div>

<!-- BEGIN JAVASCRIPTS(Load javascripts at bottom, this will reduce page load time) -->
<!-- BEGIN CORE PLUGINS -->
<script src="{$_assets}plugins/jquery-migrate-1.2.1.min.js" type="text/javascript"></script>
<!-- IMPORTANT! Load jquery-ui-1.10.3.custom.min.js before bootstrap.min.js to fix bootstrap tooltip conflict with jquery ui tooltip -->
<script src="{$_assets}plugins/jquery-ui/jquery-ui-1.10.3.custom.min.js" type="text/javascript"></script>
<script src="{$_assets}plugins/bootstrap/js/bootstrap.min.js" type="text/javascript"></script>
<script src="{$_assets}plugins/bootstrap-hover-dropdown/bootstrap-hover-dropdown.min.js"
        type="text/javascript"></script>
<script src="{$_assets}plugins/jquery-slimscroll/jquery.slimscroll.min.js" type="text/javascript"></script>
<script src="{$_assets}plugins/jquery.blockui.min.js" type="text/javascript"></script>
<script src="{$_assets}plugins/uniform/jquery.uniform.min.js" type="text/javascript"></script>
<!-- END CORE PLUGINS -->
<!-- BEGIN PAGE LEVEL PLUGINS -->
<link rel="stylesheet" type="text/css" href="{$_assets}plugins/jquery-tags-input/jquery.tagsinput.css"/>
<link rel="stylesheet" type="text/css" href="{$_assets}plugins/typeahead/typeahead.css">
<link rel="stylesheet" type="text/css" href="{$_assets}plugins/bootstrap-wysihtml5/bootstrap-wysihtml5.css"/>
{*<link rel="stylesheet" type="text/css" href="{$_assets}plugins/select2/select2.css"/>*}
<script type="text/javascript" src="{$_assets}plugins/select2/select2.min.js"></script>
<script type="text/javascript" src="{$_assets}plugins/jquery-tags-input/jquery.tagsinput.min.js"></script>
<script src="{$_assets}plugins/typeahead/handlebars.min.js" type="text/javascript"></script>
<script src="{$_assets}plugins/typeahead/typeahead.bundle.min.js" type="text/javascript"></script>
<script type="text/javascript" src="{$_assets}plugins/datatables/media/js/jquery.dataTables.min.js"></script>
<script type="text/javascript" src="{$_assets}plugins/datatables/plugins/bootstrap/dataTables.bootstrap.js"></script>
<script type="text/javascript" src="{$_assets}plugins/bootstrap-wysihtml5/wysihtml5-0.3.0.js"></script>
<script type="text/javascript" src="{$_assets}plugins/bootstrap-wysihtml5/bootstrap-wysihtml5.js"></script>
<!-- END PAGE LEVEL PLUGINS -->
<!-- BEGIN PAGE LEVEL SCRIPTS -->
<script src="{$_assets}scripts/app.js"></script>
<script src="{$_assets}scripts/_page.js"></script>
<script>
    jQuery(document).ready(function () {
        App.init();
        $('.tags').tagsInput({
            width: 'auto'
        });
        $("#select2_sample6").select2({
            placeholder: "选择供应商",
            minimumInputLength: 1,
            ajax: { // instead of writing the function to execute the request we use Select2's convenient helper
                url: "{$_route}list?vendor_auto_complete=1",
                dataType: 'json',
                data: function (term, page) {
                    return {
                        q: term, // search term
                        page_limit: 10
                    };
                },
                results: function (data, page) { // parse the results into the format expected by Select2.
                    // since we are using custom formatting functions we do not need to alter remote JSON data
                    return {
                        results: data.items
                    };
                }
            },
            initSelection: function (element, callback) {
                var id = $(element).val();
                if (id !== "") {
                    $.ajax("{$_route}list?vendor_auto_complete=1", {
                        data: {
                            id: id
                        },
                        dataType: "json"
                    }).done(function (data) {
                        console.log(data);
                        callback(data.items[0]);
                    });
                }
            },
            formatResult: formatRepo, // omitted for brevity, see the source of this page
            formatSelection: formatRepoSelection, // omitted for brevity, see the source of this page
            escapeMarkup: function (m) {
                return m;
            } // we do not want to escape markup since we are displaying html in results
        });
        $(".tags_select3").each(function () {
            $(this).select2({
                tags: UploadFiles.tags.split(',')
            })
        });
        {foreach $_data['attr'] as $k=>$v}
        $('#product_attr').data('{$k}', '{$v}');
        {/foreach}
        Form_Attr.update('.select2me');
        $('.wysihtml5').wysihtml5();
    });
    var Form_Attr = {
        update: function (o) {
            var category_id = $(o).find('option:selected').val();
            if (!category_id) {
                category_id = $(o).find('option:first').val();
            }
            $.getJSON("?category_attr=1&category_id=" + category_id + "&format=json&jsoncallback=?", function (data) {
                $('#product_attr').empty();
                $.each(data, function (i, item) {
                    var val = $('#product_attr').data(item.name);
                    if (!val) {
                        val = '';
                    }
                    if ($.trim(item.name)) {
                        $('<div class="input-group"> <span class="input-group-addon">' + item.name + ':  </span>  <input type="text" class="form-control select2 tags_select2" name="data[attr][' + item.name + ']" value="' + val + '" data-name="' + item.name + '" data-values="' + item.values + '"> </div>')
                                .appendTo('#product_attr');
                    }
                });
                $(".tags_select2").each(function () {
                    $('#product_attr').data($(this).data('name'), $(this).val());
                    $(this).change(function () {
                        $('#product_attr').data($(this).data('name'), $(this).val());
                    }).select2({
                        tags: $(this).data('values').split(',')
                    })
                });
            });
        }
    }


    function formatRepo(repo) {
        if (repo.loading) return repo.text;
        return repo.full_name;
    }

    function formatRepoSelection(repo) {
        return repo.full_name || repo.text;
    }

</script>
</body>

<!-- END BODY -->
</html>