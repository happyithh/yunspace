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
    <title>{$title['form']}表单</title>
    <meta content="" name="description"/>
    {include "Admin::inc/html_head.tpl"}
    <link href="style/css.css" rel="stylesheet"/>
    <link href="style/media.css" rel="stylesheet"/>
    <link href="css/bootstrap-datetimepicker.min.css" rel="stylesheet"/>
</head>
<!-- END HEAD -->
<!-- BEGIN BODY -->

<body style="background:#FaFaFa !important">
</div>
<div class="portlet" >
    <div class="portlet-title" style="padding: 6px;">
        <div class="caption">
            <i class="fa fa-comments"></i>
            {$title['form']}表单
        </div>
    </div>
        <div class="portlet-tabs" style="position:relative">
            <ul class="nav nav-tabs" style="overflow: inherit; padding-left: 100px">
                <li class="{if $type=='del'}active{/if}">
                    <a href="?action=detail&type=del&id={$form_id}">已删除</a>
                </li>
                <li class="{if $type=='reject'}active{/if}">
                    <a href="?action=detail&type=reject&id={$form_id}">已拒绝</a>
                </li>
                <li class="{if $type=='done'}active{/if}">
                    <a href="?action=detail&type=done&id={$form_id}">已通过</a>
                </li>
                <li class="{if $type=='waiting'}active{/if}">
                    <a href="?action=detail&type=waiting&id={$form_id}">待审核</a>
                </li>
            </ul>
        </div>

    <input type="hidden" name="form_id" value="{$form_id}" >
    <div class="portlet-body">
        <div class="table-responsive clearfix">
            <table class="table table-striped table-bordered table-hover" id="data_table" style="word-break: break-all">
                <thead>
                <tr>
                    {*<th>账户名</th>*}
                    {foreach $data['fields'] as $k=>$v}
                    <th>{$v}</th>
                    {/foreach}
                    <th style="width: 30%">其他信息</th>
                    <th style="width: 9%">创建时间</th>
                    <th>操作</th>
                </tr>
                </thead>
                {foreach $data['rows'] as $k=>$v}

                <tr>
                    {*<td>{if !empty($v['username'])}{$v['username']}{else}-----{/if}</td>*}
                    {if !empty($data['fields'])}
                        {*{var_dump($v['data'])}*}
                        {foreach $data['fields'] as $kd=>$vd}
                                    <td>{$v['data'][$vd]}</td>
                        {/foreach}
                    {/if}
                    <td>


                        {foreach $v['data'] as $kk=>$vv}
                            {if !in_array($kk,$data['fields'])}
                                {*{var_dump($kk)}*}
                                {$kk}：{$vv};
                            {/if}
                        {/foreach}
                    </td>
                    <td>{$v['create_time']}</td>
                    <td>
                        {if $v['status']==0}
                            <a href="?action=check&status=1&id={$v['id']}&form_id={$data['form_id']}" class="btn btn-success btn-xs"><i class="fa fa-pencil"></i>通过</a>&nbsp;&nbsp;
                        <a href="?action=check&status=-1&id={$v['id']}&form_id={$data['form_id']}" class="btn btn-danger btn-xs"><i class="fa fa-pencil"></i>拒绝</a>&nbsp;&nbsp;
                        {elseif $v['status']==1 || $v['status']==-1}
                            <select name="status" class="form-control topic_status" data-id="{$v['id']}">
                                {foreach $status as $key=>$value}
                                    <option value="{$key}" {if $v['status']==$key}selected{/if}>{$value}</option>
                                {/foreach}
                            </select>
                        {else}
                            <a href="javascript:;" class="btn btn-danger btn-xs">已删除</a>&nbsp;&nbsp;
                        {/if}
                    </td>
                </tr>
                {/foreach}
                </thead>
                <tbody>

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
                            <a href="{$data['page']['dup']}{$data['page']['dp']-1}" title="Prev"><i class="fa fa-angle-left"></i></a>
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
                            <a href="{$data['page']['dup']}{$data['page']['dp']+1}" title="Next"><i class="fa fa-angle-right"></i></a>
                        </li>
                        <li class="next">
                            <a href="{$data['page']['dup']}{$data['page']['dtp']}" title="Last"><i class="fa fa-angle-double-right"></i></a>
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

<!-- BEGIN JAVASCRIPTS(Load javascripts at bottom, this will reduce page load time) -->
<!-- BEGIN CORE PLUGINS -->
<script src="{$_assets}plugins/jquery-1.11.0.min.js"
        type="text/javascript"></script>
<script src="{$_assets}scripts/_page.js"></script>
<script type="text/javascript" src="js/moment.min.js"></script>
<script type="text/javascript" src="js/zh-cn.js"></script>
<script type="text/javascript" src="js/bootstrap-datetimepicker.min.js"></script>
<script>
    $(document).ready(function(){
        $('.date').datetimepicker({
            format: 'YYYY-MM-DD',
            locale: 'zh-cn'
        });
    });
    $(".topic_status").change(function(){
        var online = $(this).val();
        if (online == 0) {
            var msg = "待审核";
        }else if(online == 1) {
            var msg = "通过";
        }else if (online == -1){
            var msg = "拒绝";
        }else if(online == -2){
            var msg = "删除";
        }
        var rs = confirm("确定将状态更改为【" + msg + "】？");
        if (rs == true) {
            var id = $(this).data('id');
            $.post('http://{Core::$urls['host']}/static/api/general/form/user/check.jsonp', {
                id: id,
                status: online,
            }, function (data) {
                if (data.status == 1) {
                    top.alert(" " + data.msg);
                    window.location.reload();
                } else {
                    top.alert(data.msg);
                }
            }, "json")
        } else {
            $(obj).find("option[value!='" + online + "']").attr("selected", true);
        }
    })


</script>
</body>
<!-- END BODY -->
</html>