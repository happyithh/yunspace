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
    {include 'Web_User_Center::inc/html_head.tpl' theme='blue'}
</head>
<!-- END HEAD -->
<!-- BEGIN BODY -->
<body>
{include 'Web_User_Center::inc/header_top.tpl' color='#0b679e'}
<div class="clearfix"></div>
<!-- BEGIN CONTAINER -->
<div class="page-container">
    {include 'inc/header_nav.tpl' index=1}
    <!-- BEGIN CONTENT -->
    <div class="page-content-wrapper">
        <div class="page-content" style="min-height: 973px">
            <h3 class="page-title">我的投稿记录</h3>
            <div class="portlet">
                <div class="portlet-body">
                    <ul class="nav nav-pills">
                        <li>
                            <a href="?status=0"
                               class="btn {if !$_REQUEST['status']}btn-primary{/if}">全部</a>
                        </li>
                        <li>
                            <a href="?status=2"
                               class="btn {if $_REQUEST['status']==2}btn-primary{/if}">待审核</a>
                        </li>
                        <li>
                            <a href="?status=1"
                               class="btn {if $_REQUEST['status']==1}btn-primary{/if}">已通过</a>
                        </li>
                        <li>
                            <a href="?status=-1"
                               class="btn {if $_REQUEST['status']==-1}btn-primary{/if}">未通过</a>
                        </li>
                    </ul>
                    <div>
                        <form action="?" method="get" style="float: left;">

                            <div class="input-group">
                                <div style="display: inline-block">
                                    <input type="text" class="form-control" style="width: 250px;"
                                           placeholder="文章关键词" name="text" value="{$_REQUEST['text']}">
                                    <span class="input-group-btn">
                                          <button class="btn btn-info" type="submit">
                                              <i class="fa fa-search"></i>
                                          </button>
                                    </span>
                                </div>
                            </div>

                        </form>
                        <div style="float:right"><a href="?action=edit" class="btn btn-success"><span class="glyphicon glyphicon-plus"></span>我要投稿</a></div>

                    </div>

                    <div class="table-responsive" style="border: 0px;">
                        <table class="table table-striped table-bordered table-advance table-hover">
                            <thead>
                            <tr>
                                <th>#ID</th>
                                <th>文章标题</th>
                                <th>作者</th>
                                <th>所属栏目</th>
                                <th>更新时间</th>
                                <th>状态</th>
                                <th>操作</th>
                            </tr>
                            </thead>
                            <tbody>
                            {foreach $_data['rows'] as $value}
                                <tr>
                                    <td>#{$value['id']}</td>
                                    <td>
                                        {if mb_strlen($value['title'],'UTF-8')>40}
                                            {mb_substr($value['title'],0,39,'utf-8')}...
                                        {else}
                                            {$value['title']}
                                        {/if}
                                    </td>
                                    <td>{$value['author']}</td>
                                    <td>
                                        {$category_name[$value['category_id']]['name']}
                                    </td>

                                    <td>{date('Y-m-d H:i:s',$value['update_time'])}</td>
                                    <td>
                                        {if $value['status']==1}
                                            <span style="background: #fff;color:#008855;border:1px solid #008855">已通过</span>
                                        {elseif $value['status']==2}
                                            <span style="background: #fff;color:#ecbc29;border:1px solid #ecbc29">待审核</span>
                                        {elseif $value['status']==-1}
                                            <span style="background: #fff;color:#f3565d;border:1px solid #f3565d">未通过</span><br/><span>原因可能是文章有重复或者不完整</span>
                                        {/if}
                                    </td>
                                    <td>
                                        {if $value['status']==1}
                                            <a target="_blank" href="http://{Core::$urls['host']}/raiders-info/{$value['online_id']}.html" class="btn btn-info btn-xs">查看</a>
                                        {else}
                                            <a href="?action=edit&id={$value['id']}" class="btn btn-info btn-xs">编辑</a>
                                        {/if}
                                        {*<a href="?action=delete&id={$value['id']}" class="btn btn-danger btn-xs">删除</a>*}
                                        <a href="javascript:;" data-id="{$value['id']}" class="btn btn-danger btn-xs delete_deliver">删除</a>
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
                                    <a href="{$_data['page']['dup']}1" title="First"><i
                                                class="fa fa-angle-double-left"></i></a>
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

                <!-- END BUTTONS PORTLET-->
            </div>
        </div>
    </div>
    <!-- END CONTENT -->
</div>
<!-- END CONTAINER -->
{include 'Web_User_Center::inc/footer_inbox.tpl'}
{include 'Web_User_Center::inc/footer_script.tpl'}
<script>
    $('.delete_deliver').click(function(){
        if(confirm("确认删除此文章吗？此操作将不可恢复！！")){
            window.location.href="?action=delete&id="+$(this).attr('data-id');
        }
    })
</script>
</body>

<!-- END BODY -->
</html>