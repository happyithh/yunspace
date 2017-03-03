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
                <form action="?" method="get" class="clearfix">
                    <input type="hidden" name="status" value="{$status}">
                    <div class="form-body clearfix">
                        <div class="form-group col-md-5">
                            <label class="col-md-3 control-label">文章标题</label>

                            <div class="col-md-9">
                                <input type="text" class="form-control input-sm" placeholder="文章标题"
                                       name="search[title]" value="{$_REQUEST['search']['title']}">
                            </div>
                        </div>
                        <div class="form-group col-md-5">
                            <label class="col-md-3 control-label">公众号</label>

                            <div class="col-md-9">
                                <input type="text" class="form-control input-sm" placeholder="公众号"
                                       name="search[author]" value="{$_REQUEST['search']['author']}">
                            </div>
                        </div>
                        <div class="form-group col-md-5">
                            <label class="col-md-3 control-label">发布时间</label>

                            <div class="col-md-4">
                                <input type='text' class="form-control date" placeholder="请选择开始时间"
                                       name="search[article_start_time]" value="{$_REQUEST['search']['article_start_time']}"/>
                            </div>
                            <div class="col-md-4">
                                <input type='text' class="form-control date" placeholder="请选择结束时间"
                                       name="search[article_end_time]" value="{$_REQUEST['search']['article_end_time']}"/>
                            </div>
                        </div>
                        <div class="form-group col-md-5">
                            <label class="col-md-3 control-label">创建时间</label>

                            <div class="col-md-4">
                                <input type='text' class="form-control date" placeholder="请选择开始时间"
                                       name="search[create_start_time]" value="{$_REQUEST['search']['create_start_time']}"/>
                            </div>
                            <div class="col-md-4">
                                <input type='text' class="form-control date" placeholder="请选择结束时间"
                                       name="search[create_end_time]" value="{$_REQUEST['search']['create_end_time']}"/>
                            </div>
                        </div>
                    </div>
                    <div class="form-actions">
                        <div class="" style="text-align: center">
                            <button type="submit" class="btn btn-primary" style="width: 150px">
                                <i class="fa fa-search"></i>
                                搜索
                            </button>
                        </div>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>

<div class="portlet tabbable">
    <div class="portlet-body">
        <ul class="nav nav-tabs">
            <li class="{if $status=='all'}active{/if}">
                <a href="?status=all{$search}">全部</a>
            </li>
            <li class="{if $status=='waiting'}active{/if}">
                <a href="?status=waiting{$search}">待处理</a>
            </li>
            <li class="{if $status=='suggest'}active{/if}">
                <a href="?status=suggest{$search}">建议采用</a>
            </li>
            <li class="{if $status=='done'}active{/if}">
                <a href="?status=done{$search}">已采用</a>
            </li>
            <li class="{if $status=='hide'}active{/if}">
                <a href="?status=hide{$search}">不建议采用</a>
            </li>
        </ul>
        <div class="table-responsive clearfix">
            <table class="table table-striped table-bordered table-hover" id="data_table" style="word-break: break-all">
                <thead>
                <tr>
                    <th style="width: 15%">文章标题</th>
                    <th>摘要</th>
                    <th>公众号</th>
                    <th>LOGO</th>
                    <th>状态</th>
                    <th>发布时间</th>
                    <th>创建时间</th>
                    <th>操作人</th>
                    {if $status!='done'}
                        <th>操作</th>
                        {if $status !='hide'}
                            <th>是否采用</th>
                        {/if}
                    {/if}
                </tr>
                </thead>
                <tbody>
                {foreach $data['rows'] as $k=>$v}
                    <tr>
                        <td class="list_none">
                            <a data-author="{$v['author']}"  data-url=""  data-title="{$v['title']}" onclick="getClick(this)" target="_blank">{$v['title']}
                            </a>
                            {if !empty($v['article_url'])}
                            <a
                               class="btn btn-info btn-xs article-used" data-url="{$v['article_url']}"  data-author="{$v['author']}" data-title="{$v['title']}" onclick="getClick(this)" target="_blank">查看文章</a>
                            {/if}
                        </td>
                        <td class="list_size" style="word-wrap:break-word;width: 30%">{$v['digest']}</td>
                        <td class="list_size">{$v['author']}</td>
                        <td>{if !empty($v['img'])}<img src="{$v['img']}" style="width:100px;height: 100px;">{/if}</td>
                        <td>{if $v['status']==2}
                            <span >已采用</span>
                            {elseif $v['status']==1}
                            <span>建议采用</span>
                            {elseif $v['status']==-1}
                            <span>不建议采用</span>
                            {/if}
                        </td>
                        <td>{date('Y-m-d',$v['article_time'])}</td>
                        <td>{date('Y-m-d H:i:s',$v['create_time'])}</td>
                        <td>{if !empty($v['administrator'])}{$v['administrator']}{/if}</td>
                        {if $status!='done'}
                        <td>
                            {if $v['status']!=2}
                                {if $v['status']==0}
                                    <a href="#article-url" class="btn btn-danger btn-xs article-suggest"
                                       data-article-id="{$v['id']}" data-author="{$v['author']}" data-toggle="modal" data-status="1"
                                       onclick="getArticleId(this)">建议采用</a>
                                    <a href="?action=update_article&article_id={$v['id']}&status=-1&author={$v['author']}"
                                       class="btn btn-primary btn-xs article-hide" data-status="-1">不建议采用</a>
                                    {elseif $v['status']==1}

                                    {*<a href="#article-url"*}
                                       {*class="btn btn-success btn-xs article-used" onclick="getArticleId(this)" data-author="{$v['author']}" data-article-id="{$v['id']}" data-toggle="modal" data-status="2">采用</a>*}
                                    <a href="?action=update_article&article_id={$v['id']}&status=-1&author={$v['author']}"
                                       class="btn btn-primary btn-xs article-hide" data-status="-1">不建议采用</a>
                                {elseif $v['status']==-1}
                                    <a href="?action=update_article&article_id={$v['id']}&status=0"
                                       class="btn btn-danger btn-xs article-suggest" data-status="1">恢复</a>
                                {/if}

                            {/if}
                        </td>
                            {if $v['status']!=-1}
                            <td>
                                {if $v['status']!=2}
                                <a href="#article-url"
                                   class="btn btn-success btn-xs article-used" onclick="getArticleId(this)" data-author="{$v['author']}" data-article-id="{$v['id']}" data-toggle="modal" data-status="2">采用</a>
                            {/if}
                            </td>
                                {/if}
                        {/if}
                    </tr>
                {/foreach}
                </tbody>
            </table>
            <div class="pull-left" style="width:30%; padding: 10px 0;">

            </div>
            <div class="pull-right">
                <ul class="pagination">
                    {if $data['page']['dpll']}
                        <li class="prev">
                            <a href="{$data['page']['dup']}1" title="First"><i class="fa fa-angle-double-left"></i></a>
                        </li>
                        <li class="prev">
                            <a href="{$data['page']['dup']}{$data['page']['dp']-1}" title="Prev"><i
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
                    {for $i=$data['page']['dpl'] to $data['page']['dpr']}
                        <li{if $i==$data['page']['dp']} class="active"{/if}>
                            <a href="{$data['page']['dup']}{$i}">{$i}</a>
                        </li>
                    {/for}
                    <li class="disabled">
                        <a> {$data['page']['dtp']}
                            ( {$data['page']['dp']*$data['page']['dn']}
                            /{$data['page']['dt']} )</a>
                    </li>

                    {if $data['page']['dprr']}
                        <li class="next">
                            <a href="{$data['page']['dup']}{$data['page']['dp']+1}" title="Next"><i
                                        class="fa fa-angle-right"></i></a>
                        </li>
                        <li class="next">
                            <a href="{$data['page']['dup']}{$data['page']['dtp']}" title="Last"><i
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
    {*填写文章url*}
    <div class="modal fade" id="article-url" tabindex="-1" role="basic" aria-hidden="true">
        <div class="modal-dialog" style="position: fixed;top:20%;left: 20%">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                    <h4 class="modal-title">
                        请复制文章完整的URL,粘贴在输入框中</h4>
                </div>
                <input type="hidden" class="article-id" value="">
                <input type="hidden" class="article-status" value="">
                <input type="hidden" class="author" value="">
                <div class="modal-body base-info">

                    <table width="80%">
                        <tr>
                            <td colspan="4">
                                <input class="form-control article-url"  value="" rows="5"  style="margin-bottom:10px;">
                            </td>
                        </tr>
                    </table>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">
                        取消
                    </button>
                    <button type="button" class="btn btn-success" onclick="articleInfo(this)">
                        确定
                    </button>
                </div>

            </div>
        </div>

    </div>
    <script src="{$_assets}plugins/jquery-1.11.0.min.js"
            type="text/javascript"></script>
    <script type="text/javascript" src="js/moment.min.js"></script>
    <script type="text/javascript" src="js/zh-cn.js"></script>
    <script type="text/javascript" src="js/bootstrap-datetimepicker.min.js"></script>
    <script src="{$_assets}plugins/bootstrap/js/bootstrap.min.js"
            tab="text/javascript"></script>
    <script>
        $(document).ready(function () {
            $('.date').datetimepicker({
                format: 'YYYY-MM-DD',
                locale: 'zh-cn'
            });

        });
        function getArticleId(o){
            if(confirm("是否需要写入文章URL")) {
                $('.article-id').val($(o).data('article-id'));
                $('.article-status').val($(o).data('status'));
                $('.author').val($(o).data('author'));
            }else{
                $(o).attr('href','');
                var article_id = $(o).data('article-id');
                var status = $(o).data('status');
                var author = $(o).data('author');
                $.get('?action=article_info',{
                    article_id:article_id,status:status,author:author
                },function(data){
                    if(data.status==1){
                        top.alert(data.msg);
                        window.location.reload();
                    }else{
                        top.alert(data.msg);
                    }
                },"json")
            }
        }
        function articleInfo(e){
            var article_id = $('.article-id').val();
            var url = $('.article-url').val();
            var status = $('.article-status').val();
            var author = $('.author').val();
            $.get('?action=article_info',{
                article_id:article_id,article_url:url,status:status,author:author
            },function(data){
                if(data.status==1){
                    top.alert(data.msg);
                    window.location.reload();
                }else{
                    top.alert(data.msg);
                }
            },"json")
        };
        function getClick(a){
            var author = $(a).data('author');
            var title = $(a).data('title');
            var url = $(a).data('url');
//            alert(url);
            YunSpace.api('wechat/author/click.jsonp',{
                author:author},function(data){
            },'json');
            if(url==''){
                $(a).attr('href',"http://weixin.sogou.com/weixin?type=2&query="+title+"&ie=utf8/");
            }else{
                $(a).attr('href',url);
            }
            return false
        }
    </script>
{static "core/yunspace.js"}
</body>
<!-- END BODY -->
</html>