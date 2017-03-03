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
    <link href="style/media.css" rel="stylesheet"/>
    <link href="style/css.css" rel="stylesheet"/>
    <link href="css/bootstrap-datetimepicker.min.css" rel="stylesheet"/>
</head>
<!-- END HEAD -->
<!-- BEGIN BODY -->

<body style="background:#FaFaFa !important">
<a style="margin-bottom: 10px;" href="?action=case&case_action=case_edit&space_id={$spacepedia['id']}" class="btn btn-success">添加文章</a>
<div class="portlet">
    <div class="portlet-title">
        <div class="caption">
            <i class="fa fa-search"></i>搜索匹配的文章
        </div>
    </div>
    <div class="portlet-body">

        <div class="portlet-tabs">
            <form action="?" method="get" class="clearfix">
                <input type="hidden" name="action"  value="case">
                <input type="hidden" name="case_action"  value="{$_REQUEST['case_action']}">
                <input type="hidden" name="space_id"  value="{$spacepedia['id']}">
                <div class="form-body clearfix">
                    <div class="form-group col-md-12">
                        <label class="col-md-3 control-label">输入文章标题</label>

                        <div class="col-md-6">
                            <input type="text" class="form-control input-sm" placeholder="文章标题"
                                   name="case_name" value="{$_REQUEST["case_name"]}">
                        </div>
                        <div class="col-md-3">
                            <button type="submit" class="btn btn-primary" style="width: 150px">
                                <i class="fa fa-search"></i>
                                搜索
                            </button>
                        </div>
                    </div>
                </div>
            </form>
        </div>
        {if $search_list}
        <div class="table-responsive clearfix">
            <table class="table table-striped table-bordered table-hover" id="data_table" style="word-break: break-all">
                <thead>
                <tr>
                    <th>#ID</th>
                    <th>文章标题</th>
                    <th>作者</th>
                    <th>所属栏目</th>
                    <th>状态</th>
                    <th>创建时间</th>
                    <th>操作</th>
                </tr>
                </thead>
                <tbody>
                {foreach $search_list as $k=>$v}
                    <tr>
                        <td>#{$v['id']}</td>
                        <td>
                            {if mb_strlen($v['title'],'UTF-8')>40}
                                <a href="{$_root}article/{Func_NumEncode::e($v['id'])}.html?update_page_cache=1" target="_blank" >{mb_substr($v['title'],0,39,'utf-8')}...</a
                            {else}
                                <a href="{$_root}article/{Func_NumEncode::e($v['id'])}.html?update_page_cache=1" target="_blank" >{$v['title']}</a>
                            {/if}
                        </td>
                        <td>{$v['author']}</td>
                        <td>{$_category[$v['category_id']]['name']}</td>
                        <td>{$status[$v['status']]}</td>
                        <td>{date('Y-m-d H:i:s',$v['create_time'])}</td>
                        <td>
                            <a href="javascript:;" data-rid="{$v['id']}" class="btn btn-info btn-xs match_spacepedia">
                                匹配到百科
                            </a>
                        </td>
                    </tr>
                {/foreach}
                </tbody>
            </table>
        </div>
            {if count($search_list)==12}
                <a class="btn btn-warning btn-xs" href="?action=case&case_action=case_list&space_id={$spacepedia['id']}&case_name={$_REQUEST['case_name']}&create_time={$search_list[count($search_list)-1]['create_time']}">换一批</a>
            {/if}
        {/if}
    </div>
</div>


<div class="portlet">
    <div class="portlet-title">
        <div class="caption">
            <i class="fa fa-comments"></i>
           已有匹配百科【{$spacepedia['space_name']}】的文章列表
        </div>
    </div>
    <div class="portlet-body">
        <div class="table-responsive clearfix">
            <table class="table table-striped table-bordered table-hover" id="data_table" style="word-break: break-all">
                <thead>
                <tr>
                    <th>#ID
                        {if $_REQUEST['sort']=="asc"}
                            <a class="btn btn-primary btn-xs" href="?action=case&case_list=case_edit&space_id={$spacepedia['id']}&order=id&sort=desc"><span  class="glyphicon glyphicon-sort"></span>排序</a>
                        {else}
                            <a class="btn btn-primary btn-xs" href="?action=case&case_list=case_edit&space_id={$spacepedia['id']}&order=id&sort=asc"><span  class="glyphicon glyphicon-sort"></span>排序</a>
                        {/if}
                    </th>
                    <th>文章标题</th>
                    {*<th>文章副标题</th>*}
                    <th>作者</th>
                    <th>所属栏目</th>
                    <th>状态</th>
                    <th>创建时间
                        {if $_REQUEST['sort']=="asc"}
                            <a class="btn btn-primary btn-xs" href="?action=case&case_list=case_edit&space_id={$spacepedia['id']}&order=create_time&sort=desc"><span  class="glyphicon glyphicon-sort"></span>排序</a>
                        {else}
                            <a class="btn btn-primary btn-xs" href="?action=case&case_list=case_edit&space_id={$spacepedia['id']}&order=create_time&sort=asc"><span  class="glyphicon glyphicon-sort"></span>排序</a>
                        {/if}
                    </th>
                    <th>更新时间
                        {if $_REQUEST['sort']=="asc"}
                            <a class="btn btn-primary btn-xs" href="?action=case&case_list=case_edit&space_id={$spacepedia['id']}&order=update_time&sort=desc"><span  class="glyphicon glyphicon-sort"></span>排序</a>
                        {else}
                            <a class="btn btn-primary btn-xs" href="?action=case&case_list=case_edit&space_id={$spacepedia['id']}&order=update_time&sort=asc"><span  class="glyphicon glyphicon-sort"></span>排序</a>
                        {/if}
                    </th>
                    <th>操作1</th>
                    <th>操作2</th>
                </tr>
                </thead>
                <tbody>
                {foreach $_data['rows'] as $key=>$value}
                    <tr>
                        <td>#{$value['id']}</td>
                        <td>
                            {if mb_strlen($value['title'],'UTF-8')>40}
                                <a href="{$_root}article/{Func_NumEncode::e($value['id'])}.html?update_page_cache=1" target="_blank" >{mb_substr($value['title'],0,39,'utf-8')}...</a
                            {else}
                                <a href="{$_root}article/{Func_NumEncode::e($value['id'])}.html?update_page_cache=1" target="_blank" >{$value['title']}</a>
                            {/if}
                        </td>
                        {*<td>*}
                            {*{$spacepedia['subhead'][$value['id']]}*}
                        {*</td>*}
                        <td>{$value['author']}</td>
                        <td>{$_category[$value['category_id']]['name']}</td>
                        <td>{$status[$value['status']]}</td>
                        <td>{date('Y-m-d H:i:s',$value['create_time'])}</td>
                        <td>{date('Y-m-d H:i:s',$value['update_time'])}</td>
                        <td>
                            <input data-rid="{$value['id']}" class="recommend" type="checkbox" name="is_good" {if $value['is_good']==1}checked {/if}><strong style="color: #d9534f">推荐/精华</strong>
                        </td>
                        <td>
                            <a href="?action=case&case_action=case_edit&space_id={$spacepedia['id']}&raiders_id={$value['id']}" class="btn btn-success btn-xs">
                                修改
                            </a>
                            {*<a href="#subhead" data-subhead="{$spacepedia['subhead'][$value['id']]}" data-rid="{$value['id']}" data-toggle="modal" class="btn btn-info btn-xs add_subhead">*}
                                {*{if $spacepedia['subhead'][$value['id']]}*}
                                    {*修改副标题*}
                                {*{else}*}
                                    {*新建副标题*}
                                {*{/if}*}
                            {*</a>*}
                            <a href="javascript:;" data-rid="{$value['id']}" class="btn btn-danger btn-xs remove_raiders">
                                移除
                            </a>
                        </td>
                    </tr>
                {/foreach}
                </tbody>
            </table>
            <div class="pull-left" style="width:30%; padding: 10px 0;">

            </div>
            <div class="pull-right">
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
                            /{$_data['page']['dt']} )</a>
                    </li>

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


{*新建百科弹出层*}
<div class="modal fade" id="subhead" tabindex="-1" role="basic" aria-hidden="true" style="display: none;">
    <div class="modal-dialog">
        <div class="modal-content">
            <input name="raiders_id" type="hidden" id="raiders_id">
            <div class="modal-body">
                <table class="table">
                    <thead>
                    <th width="200px;">
                         新建/修改副标题
                    </th>
                    </thead>
                    <tr>
                        <td>
                            <label class="control-label">输入副标题</label>
                        </td>
                        <td>
                            <input class="form-control" name="subhead" class="form-control">
                        </td>
                    </tr>
                </table>

            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                <button type="button" class="btn btn-info submit_subhead">提交</button>
            </div>
        </div>
    </div>
</div>


<!-- BEGIN JAVASCRIPTS(Load javascripts at bottom, this will reduce page load time) -->
<!-- BEGIN CORE PLUGINS -->
<script src="{$_assets}plugins/jquery-1.11.0.min.js"
        type="text/javascript"></script>
<script src="{$_assets}plugins/bootstrap/js/bootstrap.min.js"
        tab="text/javascript"></script>
<script src="{$_assets}scripts/_page.js"></script>
<script type="text/javascript" src="{$_assets}plugins/select2/select2.min.js"></script>

<script>
//    匹配到百科
    $('.match_spacepedia').click(function(){
        var space_id="{$spacepedia['id']}";
        var raiders_id=$(this).data('rid');
        $.post('http://{Core::$urls['host']}/static/api/raiders/handle.jsonp',{
            space_id:space_id,
            raiders_id:raiders_id,
            action:"change_tags"
        },function(data){
            if (data.status == 1) {
                top.alert(" " + data.msg);
                window.location.reload();
            } else {
                top.alert(data.msg);
            }
        },"json")
    });
    //将活动案例从百科中移除
    $(".remove_raiders").click(function(){
        var space_id="{$spacepedia['id']}";
        var raiders_id=$(this).data('rid');
        $.post('http://{Core::$urls['host']}/static/api/raiders/handle.jsonp',{
            space_id:space_id,
            raiders_id:raiders_id,
            action:"remove_tags"
        },function(data){
            if (data.status == 1) {
                top.alert(" " + data.msg);
                window.location.reload();
            } else {
                top.alert(data.msg);
            }
        },"json")
    })

    $('.add_subhead').click(function(){
        $("#raiders_id").val($(this).data('rid'));
        $("input[name=subhead]").val($(this).data('subhead'));
    });

  $(".submit_subhead").click(function(){
     var subhead=$('input[name=subhead]').val();
      var space_id="{$spacepedia['id']}";
      var raiders_id=$("#raiders_id").val();
      $.post('http://{Core::$urls['host']}/static/api/spacepedia/handle.jsonp',{
          subhead:subhead,
          space_id:space_id,
          raiders_id:raiders_id,
          action:"add_subhead"
      },function(data){
          if (data.status == 1) {
              top.alert(" " + data.msg);
              window.location.reload();
          } else {
              top.alert(data.msg);
          }
      },"json")
  });

    //推荐/加精
    $(".recommend").click(function(){
        console.log($(this).is(":checked"));
        var good_bool=$(this).is(":checked");
        var raiders_id=$(this).data('rid');
        var is_good;
        if(good_bool){
            is_good=1;
        }else{
            is_good=2;
        }
        $.post('http://{Core::$urls['host']}/static/api/raiders/handle.jsonp',{
            raiders_id:raiders_id,
            is_good:is_good,
            action:"is_good"
        },function(data){
            if (data.status == 1) {
                top.alert(" " + data.msg);
                window.location.reload();
            } else {
                top.alert(data.msg);
            }
        },"json")
    })
</script>
</body>
<!-- END BODY -->
</html>