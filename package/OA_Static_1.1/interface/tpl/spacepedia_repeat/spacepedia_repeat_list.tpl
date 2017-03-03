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

<body style="background:#FaFaFa !important;height:800px;">
<div class="portlet">
    <div class="portlet-title">
        <div class="caption">
            <i class="fa fa-comments"></i>
            重复场地百科列表<strong style="color: #f3565d;">（*无数据时可刷新页面）</strong>
            <a href="?" class="btn btn-info" style="margin-top: -10px;">刷新</a>
        </div>
    </div>
    <div class="portlet-body">
        <div class="table-responsive clearfix">
            <table class="table table-striped table-bordered table-hover" id="data_table" style="word-break: break-all">
                <thead>
                <tr>
                    <th>百科ID</th>
                    <th>百科名称</th>
                    <th>百科别名</th>
                    <th>百科类型</th>
                    <th>状态</th>
                    <th>供应商名称</th>
                    <th>城市</th>
                    <th>地址</th>
                    <th>创建时间</th>
                    <th>更新时间</th>
                    <th>操作</th>
                </tr>
                </thead>
                <tbody>
                {foreach $_data as $k=>$v}
                    <tr data-sid="{$v['id']}">
                        <td class="list_none">{$v['id']}</td>
                        <td class="list_size">
                            <a target="_blank"
                               href="http://{Core::$urls['host']}/baike/{urlencode($v['space_name'])}">{$v['space_name']}</a>
                        </td>
                        <td>
                            {$v['nickname']}
                        </td>
                        <td class="list_size">
                            {$_categoryInfo[$v['category_id']][0]}
                        </td>
                        <td class="list_size">
                            {if $v['status']==2}
                                <span style="color: #ecbc29;">审核中</span>
                            {elseif $v['status']==0}
                                <span>下线</span>
                            {elseif $v['status']==1}
                                <span>上线</span>
                            {elseif $v['status']==3}
                                <span style="color: #f3565d;;">已拒绝</span>
                            {elseif $v['status']==-1}
                                <span style="color: #f3565d;">已删除</span>
                            {else}
                            {/if}
                        </td>
                        <td class="list_size">{$v['vendor_name']}</td>
                        <td class="list_none">{$v['city']}</td>
                        <td class="list_none">{$v['addr']}</td>
                        <td class="list_none">{if $v['update_time']>1430713953}{date('Y-m-d H:i:s',$v['create_time'])}{else}--{/if}</td>
                        <td class="list_none">{if $v['update_time']>1430713953}{date('Y-m-d H:i:s',$v['update_time'])}{else}--{/if}</td>
                        <td>
                            <a href="#repeat_list" data-toggle="modal" data-name="{$v['space_name']}" data-pid="{$v['id']}" class="btn btn-primary save_spacepedia" data-id="{$k}">保留</a>
                        </td>
                    </tr>
                {/foreach}
                </tbody>
            </table>
        </div>
    </div>
</div>

<style>
    .none{
        display: none;
    }
    .save_space_style{
        color: #ecbc29;
    }
</style>
{*重复的百科弹出层*}
<div class="modal fade" id="repeat_list" tabindex="-1" role="basic" aria-hidden="true" style="display: none;">
    <div class="modal-dialog">
        <div class="modal-content">
            <form action="?" method="post">
                <input name="action" value="save_submit" type="hidden">
                <input name="save_id" id="save_id" value="" type="hidden">
                <input name="old_space_name" id="old_space_name" value="" type="hidden">
                <div class="modal-body">
                    <table class="table">
                        <thead>
                            <th colspan="2">保留场地百科<span style="color: #f3565d;">（*标记为重复的百科会被放入回收站）</span></th>
                        </thead>
                        <tbody  class="save_space_tbody">
                        {foreach $_data as $k=>$v}
                            <tr class="save_space_tr"  data-id="{$k}">
                                <td>{$v['space_name']}</td>
                                <td>
                                    <span class="save_space btn btn-danger hide">要保留的场地百科</span>
                                    <label for="repeat{$v['id']}" class="note_repeat">
                                        <input id="repeat{$v['id']}" type="checkbox" value="{$v['id']}" class="save_space_checkbox none" name="repeat_ids[]"><span class="save_space_text">标记为重复</span>
                                    </label>
                                    <label for="repeat_item{$v['id']}" class="note_repeat">
                                        <input id="repeat_item{$v['id']}" type="checkbox" value="{$v['id']}" class="save_item_checkbox none" name="repeat_items[]"><span class="save_item_text">标记为子空间</span>
                                    </label>
                                </td>
                            </tr>
                        {/foreach}
                        <tr>
                            <td>
                                <label>更改要保留的词条名称</label>
                            </td>
                            <td>
                                <input type="text" class="form-control" id="space_name"  name="space_name">
                            </td>
                        </tr>
                        </tbody>
                    </table>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                    <button type="submit" class="btn btn-info">提交</button>
                </div>
            </form>
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
<script type="text/javascript" src="js/moment.min.js"></script>
<script type="text/javascript" src="js/zh-cn.js"></script>
<script type="text/javascript" src="js/bootstrap-datetimepicker.min.js"></script>
<script>
    $(document).ready(function () {
        $('.date').datetimepicker({
            format: 'YYYY-MM-DD',
            locale: 'zh-cn'
        });
    });
    var sid;
    $('.save_spacepedia').click(function(){
        $("#space_name").val($(this).data('name'));
        $("#old_space_name").val($(this).data('name'));
        $("#save_id").val($(this).data('pid'));
        sid=$(this).data("id");
        $(".save_space_tr").each(function(i,o){
            $(o).find(".save_space_checkbox").removeClass("none");
            $(o).find(".save_item_checkbox").removeClass("none");
            $(o).find(".save_space_text").text("标记为重复");
            $(o).find(".save_item_text").text("标记为子空间");
            $(o).find(".save_space_text").removeClass("save_space_style");
            var tid=$(o).data("id");
            if(sid==tid){
                var st=$(o).clone();
                $(o).remove();
                st.prependTo(".save_space_tbody");
                $(st).find(".save_space_checkbox").addClass("none");
                $(st).find(".save_item_checkbox").addClass("none");
                $(st).find(".save_space_text").text("要保留的百科");
                $(st).find(".save_item_text").text("");
                $(st).find(".save_space_text").addClass("save_space_style");
            }
        })
    });


</script>
</body>
<!-- END BODY -->
</html>