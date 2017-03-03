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


</head>
<!-- END HEAD -->
<!-- BEGIN BODY -->

<body style="background:#FaFaFa !important">
<!-- BEGIN PAGE HEADER-->
<h3 class="page-title" style="float: left;">
    投稿数据处理
</h3>
<a href="javascript:history.go(-1)" class="back"><
    <返回
</a>

<div class="clear"></div>
<div class="portlet">
<div class="portlet-body">
<div class="portlet">
    <div class="portlet-title">
        <div class="caption">
            <i class="fa fa-comments"></i>
            投稿数据详情
        </div>
    </div>
    <div class="portlet-body">
        <div class="table-responsive clearfix">
            <table class="table table-striped table-bordered table-hover" id="data_table"
                   style="word-break: break-all">
                <tbody >
                <tr>
                    <th style="width:7%">文章ID</th>
                    <td>#{$_data['id']}</td>
                </tr>
                <tr>
                    <th>文章名称</th>
                    <td>{$_data['title']}</td>
                </tr>
                <tr>
                    <th>文章栏目</th>
                    <td>{$category_name[$_data['category_id']]['name']}</td>
                </tr>
                <tr>
                    <th>文章简介</th>
                    <td>{$_data['des']}</td>
                </tr>
                <tr>
                    <th>文章内容</th>
                    <td>{$_data['cont']}</td>
                </tr>
                <tr>
                    <th>logo</th>
                    <td><img width="100" height="100" src="{$_data['logo']}"></td>
                </tr>
                <tr>
                    <th>城市</th>
                    <td>{$_data['city']}</td>
                </tr>
                <tr>
                    <th>状态</th>
                    <td>
                        {if $_data['status']==-1}
                            已丢弃
                        {else}
                            待处理
                        {/if}
                    </td>
                </tr>
                </tbody>
            </table>
        </div>
    </div>
</div>

<div class="form-actions text-center">
    <a class="btn btn-success" href="?action=pass&id={$_data['id']}">审核通过</a>
    <a class="btn btn-primary" href="?action=detail&handle_action=edit&id={$_data['id']}">修改</a>
    <a href="?action=abandon&id={$_data['id']}"  class="btn btn-danger">丢弃</a>
</div>


</div>

</div>
</body>

<!-- END BODY -->
</html>