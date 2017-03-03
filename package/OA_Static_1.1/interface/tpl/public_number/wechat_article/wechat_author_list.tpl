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
    <div class="portlet-body">
        <ul class="nav nav-tabs">
            <li class="{if $type=='all'}active{/if}">
                <a href="?status=all">全部</a>
            </li>
            <li class="{if $type=='user_sum'}active{/if}">
                <a href="?type=user_sum">已采用 ↓</a>
            </li>
            <li class="{if $type=='suggest_sum'}active{/if}">
                <a href="?type=suggest_sum">建议采用 ↓</a>
            </li>
            <li class="{if $type=='hide_sum'}active{/if}">
                <a href="?action=update_hide&type=hide_sum">已隐藏 ↓</a>
            </li>
            <li class="{if $type=='click_sum'}active{/if}">
                <a href="?type=click_sum">浏览量 ↓</a>
            </li>
        </ul>
        <div class="table-responsive clearfix">
            <table class="table table-striped table-bordered table-hover" id="data_table" style="word-break: break-all">
                <thead>
                <tr>
                    <th style="width: 15%">微信公众号</th>
                    <th>采用量</th>
                    <th>建议采用量</th>
                    <th>隐藏量</th>
                    <th>浏览量</th>
                    <th>置顶</th>
                    {*<th style="width: 20%;">操作</th>*}
                </tr>
                </thead>
                <tbody>
                {foreach $data['rows'] as $k=>$v}
                    <tr>
                        <td>  <a data-author="{$v['author']}" data-url="" data-title="{Func_Url::str_urlencode($v['author'])}" onclick="getClick(this)">{$v['author']}
                            </a>
                            {if !empty($v['url'])}
                                <a class="btn btn-info btn-xs article-used" data-url="{$v['url']}" data-author="{$v['author']}" data-title="{Func_Url::str_urlencode($v['author'])}" onclick="getClick(this)" >查看公众号</a>
                            {/if}
                        </td>
                        <td>{$v['user_sum']}</td>
                        <td>{$v['suggest_sum']}</td>
                        <td>{$v['hide_sum']}</td>
                        <td>{$v['click_sum']}</td>
                        <td>{if $v['status']==0}
                            <input type="checkbox" data-status="1" data-id="{$v['id']}" onclick="updateStatus(this)"> 置顶
                            {else}
                            <input type="checkbox" data-status="0" data-id="{$v['id']}" onclick="updateStatus(this)"> 取消置顶
                            {/if}
                        </td>
                        {*<td>*}
                            {*<a href="#article-url" class="btn btn-{if !empty($v['url'])}warning{else}info{/if} btn-xs" data-toggle="modal"  data-id="{$v['id']}" onclick="getAuthorId(this)">{if !empty($v['url'])}修改URL{else}保存URL{/if}</a>*}
                            {*{if $v['collect_status']==0 || $v['collect_status']==2}*}
                            {*<a href="javascript:;" {if empty($v['url'])}disabled {/if} class="btn btn-success btn-xs" data-status="1" data-id="{$v['id']}" onclick="is_collect(this)">采集文章</a>*}
                            {*{elseif $v['collect_status']==1}*}
                            {*<a href="javascript:;" class="btn btn-danger btn-xs" data-status="2" data-id="{$v['id']}" onclick="is_collect(this)">停止采集</a>*}
                            {*{/if}*}
                            {*<a href="?action=article_info&author={$v['author']}" {if $v['collect_status']==0}disabled {/if} class="btn btn-primary btn-xs" >采集详情</a>*}
                        {*</td>*}
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
                        请复制公众号完整的URL,粘贴在输入框中</h4>
                </div>
                <input type="hidden" class="author-id" value="">

                <div class="modal-body base-info">

                    <table width="80%">
                        <tr>
                            <td colspan="4">
                                <input class="form-control author-url" value="" rows="5" style="margin-bottom:10px;">
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
    <script src="{$_assets}plugins/bootstrap/js/bootstrap.min.js"
            tab="text/javascript"></script>
    <script>
        // 是否置顶
        function updateStatus(e)
        {
            var id = $(e).data('id');
            var status = $(e).data('status');
            $.get('?action=updateStatus', {
                        id:id,status:status}, function(data){
                            top.alert(data.msg);
                        window.location.reload();
                    }
            );
        };
        // 写入文章url
        function getAuthorId(o){
         $('.author-id').val($(o).data('id'));
        }
        function articleInfo(e){
            var author_id = $('.author-id').val();
            var url = $('.author-url').val();
            YunSpace.api('wechat/author/insert/url.jsonp',{
                id:author_id,url:url
            },function(data){
                if(data.status==1){
                    top.alert('  '+data.msg);
                    window.location.reload();
                }else{
                    top.alert(data.msg);
                }
            },"json")
        };
        // 更新浏览量
        function getClick(a){
            var author = $(a).data('author');
            var title = $(a).data('title');
            var url = $(a).data('url');
            YunSpace.api('wechat/author/click.jsonp',{
                author:author},function(data){
                if(data.status ==1){
                    if(url==''){
                        top.window.open("http://weixin.sogou.com/weixin?type=1&query="+title+"&ie=utf8");
                    }else{
                        top.window.open(url);
                    }
                    return false
                }else{
                    alert('跳转失败');
                }
            },'json')
        };
        // 是否采集公众号文章
        function is_collect(o)
        {
            var id=$(o).data('id');
            var status=$(o).data('status');
            YunSpace.api('wechat/author/is/collect.jsonp',{
                id:id,collect_status:status},function(data){
                if(data.status ==1){
                    if(status==1){
                        top.alert('  系统已开始采集！');
                    }else{
                        top.alert('  系统已停止采集！');
                    }
                    window.location.reload();
                    return false
                }else{
                    alert('更改失败！');
                }
            },'json')
        }
    </script>
    {static "core/yunspace.js"}
</body>
<!-- END BODY -->
</html>