<!DOCTYPE html>
<!--[if IE 8]>
<html lang="en" class="ie8 no-js"> <![endif]-->
<!--[if IE 9]>
<html lang="en" class="ie9 no-js"> <![endif]-->
<!--[if !IE]><!-->
<html lang="en" class="no-js" xmlns="http://www.w3.org/1999/html" xmlns="http://www.w3.org/1999/html">
<!--<![endif]-->
<!-- BEGIN HEAD -->
<head>
    <title>{$title}</title>
    <meta content="" name="description"/>
    {include "Admin::inc/html_head.tpl"}
    <link href="style/css.css" rel="stylesheet"/>
    <script src="js/jquery-1.9.1.min.js"></script>
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
                <form action="?" method="get" class="clearfix form_search">
                    <input type="hidden" name="action" class="action_input" value="">
                    <div class="form-body clearfix">
                        <div class="form-group col-md-5">
                            <label class="col-md-3 control-label">文章名称</label>

                            <div class="col-md-9">
                                <input type="text" class="form-control input-sm" placeholder="文章名称/ID" name="search[title]" value="{$_REQUEST['search']['title']}">
                            </div>
                        </div>
                        <div class="form-group col-md-5">
                            <label class="col-md-3 control-label">分类名称</label>
                            <div class="col-md-9">
                                <select class="form-control input-sm" name="search[category]">
                                    <option value=''>全部</option>
                                    {foreach $category as $k=>$v}
                                        <option value="{$v['id']}" {if $_REQUEST['search']['category']==$v['category']}selected {/if}>{$v['category']}</option>
                                    {/foreach}
                                </select>
                            </div>
                        </div>
                        <div class="form-group col-md-5">
                            <label class="col-md-3 control-label">有无链接</label>
                            <div class="col-md-9">
                                <select class="form-control input-sm" name="search[is_lnk]">
                                    <option value=''>全部</option>
                                    {foreach $is_lnk as $key=>$value}
                                        <option {if $_REQUEST['search']['is_lnk']=={$key}}selected {/if} value="{$key}">{$value}</option>
                                    {/foreach}
                                </select>
                            </div>
                        </div>
                        <div class="form-group col-md-5">
                            <label class="col-md-3 control-label">是否推荐</label>
                            <div class="col-md-9">
                                <select class="form-control input-sm" name="search[is_recommend]">
                                    <option value=''>全部</option>
                                    {foreach $is_recommend as $key=>$value}
                                        <option {if $_REQUEST['search']['is_recommend']=={$key}}selected {/if} value="{$key}">{$value}</option>
                                    {/foreach}
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
                            <button type="button" class="btn btn-success export" style="width: 150px;margin-left: 20px;">
                                <i class="fa fa-sign-out"></i>
                                导出
                            </button>
                        </div>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>
<div class="portlet">
    <div class="portlet-title" style="height: 50px;">
        <div class="caption " style="height: 40px;line-height: 35px;">
            <i class="fa fa-reorder"></i>文章列表
        </div>
        <div class="btn-group pull-right">
            <a href="?action=add" class="btn btn-success">添加新文章</a>
        </div>
    </div>
    <div class="portlet-body" style="height: auto;">
        <ul class="nav nav-pills">
            <li {if $status==1}class="active"{/if}>
                <a href="?status=1" data-toggle="tab">上线</a>
            </li>
            <li {if $status==0}class="active"{/if}>
                <a href="?status=0" data-toggle="tab">下线</a>
            </li>
            <li {if $status==-1}class="active"{/if}>
                <a href="?status=-1" data-toggle="tab">已删除</a>
            </li>
        </ul>
        <div class="table-responsive" style="border: 0px;">
            <table class="table table-striped table-bordered table-advance table-hover">
                <thead>
                <tr>
                    <th style="width:25%;">文章名称</th>
                    <th style="width:13%;">分类</th>
                    <th style="width:25%;"> 简介</th>
                    {*<th style="width:10%;">链接</th>*}
                    {*<th style="width:20%;">内容</th>*}
                    <th style="width:8%;">创建时间</th>
                    <th style="width:8%;">更新时间</th>
                    <th>操作</th>
                </tr>
                </thead>
                <tbody>
                {foreach $_data['rows'] as $v}
                    <tr>
                        <td>
                           <a href="http://www.yunspace.com.cn/m/wechat_web_article_info?id={$v['url_id']}"> {$v['title']}</a>
                        </td>
                        <td>
                            {$v['category_id']}
                        </td>
                        <td>
                            {$v['introduction']}
                        </td>
                        {*<td>{$v['link']}</td>*}
                        {*<td>{$v['content']}</td>*}
                        <td>{date('Y-m-d H:i',$v['create_time'])}</td>
                        <td>{date('Y-m-d H:i',$v['update_time'])}</td>
                        <td>
                            {if $status ==1}
                                <a href="?action=edit&id={$v['id']}" class="btn btn-info btn-xs"><i class="fa fa-edit"></i>修改</a>
                                <a href="?action=eventStatus&handle=down&id={$v['id']}" class="btn btn-warning btn-xs"><i class="fa fa-level-down"></i> 下线</a>
                                <a href="?action=eventStatus&handle=del&id={$v['id']}" class="btn btn-danger btn-xs"><i class="fa fa-trash-o"></i>删除</a>
                            {/if}
                            {if $status ==0}
                                <a href="?action=edit&id={$v['id']}" class="btn btn-info btn-xs"><i class="fa fa-edit"></i>修改</a>
                                <a href="?action=eventStatus&handle=up&id={$v['id']}" class="btn btn-success btn-xs"><i class="fa fa-check"></i> 上线</a>
                                <a href="?action=eventStatus&handle=del&id={$v['id']}" class="btn btn-danger btn-xs"><i class="fa fa-trash-o"></i>删除</a>
                            {/if}
                            {if $status ==-1}
                                <a href="?action=eventStatus&handle=recover&id={$v['id']}" class="btn btn-primary btn-xs"><i class="fa fa-recycle"></i>恢复</a>
                                <a href="?action=eventRealDel&id={$v['id']}" class="btn btn-danger btn-xs"><i class="fa fa-trash-o"></i>彻底删除</a>
                            {/if}
                        </td>
                    </tr>
                {/foreach}
                </tbody>
            </table>
        </div>
        <div>
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
                            /{$_data['page']['dt']}
                            )</a></li>

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
<script type="text/javascript" src="js/moment.min.js"></script>
<script type="text/javascript" src="js/zh-cn.js"></script>

</body>
<!-- END BODY -->
</html>