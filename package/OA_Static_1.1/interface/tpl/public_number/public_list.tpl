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

                    <div class="form-body clearfix">
                        <div class="form-group col-md-5">
                            <label class="col-md-3 control-label">微信名称/ID</label>

                            <div class="col-md-9">
                                <input type="text" class="form-control input-sm" placeholder="微信名称 / ID"
                                       name="search[title]" value="{$_REQUEST['search']['title']}">
                            </div>
                        </div>
                        <div class="form-group col-md-5">
                            <label class="col-md-3 control-label">微信号类型</label>

                            <div class="col-md-9">
                                <input type="text" class="form-control input-sm" placeholder="微信号类型"
                                       name="search[public_type]" value="{$_REQUEST['search']['public_type']}">
                            </div>
                        </div>
                        <div class="form-group col-md-5">
                            <label class="col-md-3 control-label">创建时间</label>

                            <div class="col-md-9">
                                <input type='text' class="form-control date" placeholder="请选择创建时间"
                                       name="search[create_time]" value="{$_REQUEST['search']['create_time']}"/>
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
<div class="portlet">
    <div class="portlet-title">
        <div class="caption">
            <i class="fa fa-comments"></i>
            公众号列表
        </div>
    </div>
    <div class="portlet-tabs" style="position:relative">
        <div style="margin-left:10px;margin-top:10px;color: #444444;font-size: 16px">
            <a href="#public_number" data-toggle="modal" class="btn btn-primary">添加微信号</a>
        </div>
    </div>
    <div class="portlet-body">
        <div class="table-responsive clearfix">
            <table class="table table-striped table-bordered table-hover" id="data_table" style="word-break: break-all">
                <thead>
                <tr>
                    <th>微信号ID</th>
                    <th>微信号</th>
                    <th>微信名称</th>
                    <th>微信号类型</th>
                    <th>搜狗微信文章</th>
                    <th>搜狗知乎文章</th>
                    <th>百度新闻</th>
                    <th>新榜文章</th>
                    <th>创建时间</th>
                    <th>操作</th
                </tr>
                </thead>
                <tbody>
                {foreach $_data['rows'] as $k=>$v}
                    <tr data-pid="{$v['id']}"  data-number="{$v['public_number']}" data-show="{$v['show_name']}" data-type="{$v['public_type_str']}">
                        <td class="list_none">{$v['id']}</td>
                        <td class="list_size">{$v['public_number']}</td>
                        <td class="list_size">{$v['show_name']}</td>
                        <td>{$v['public_type_str']}</td>
                        <td>
                            <a target="_blank" href="http://weixin.sogou.com/weixin?type=2&query={$v['show_name']}&ie=utf8">搜狗微信号文章</a>
                        </td>
                        <td>
                            <a target="_blank" href="http://zhihu.sogou.com/zhihu?query={$v['show_name']}&ie=utf8">搜狗知乎文章</a>
                        </td>
                        <td>
                            <a target="_blank" href="http://news.baidu.com/ns?word={$v['show_name']}&tn=news&from=news&cl=2&rn=20&ct=1">百度新闻</a>
                        </td>
                        <td>
                            <a target="_blank" href="http://www.newrank.cn/public/info/detail.html?account={$v['public_number']}">新榜文章</a>
                        </td>
                        <td class="list_none">{if $v['create_time']>1430713953}{date('Y-m-d H:i:s',$v['create_time'])}{else}--{/if}</td>
                        <td>
                            <a href="#public_number" data-toggle="modal" onclick="OperatePublic.editPublic(this)" class="btn btn-primary btn-xs list_size"><i
                                        class="fa fa-eye"></i>编辑</a>
                            <a href="javascript:;" onclick="OperatePublic.delPublic(this)"
                               class="btn btn-danger btn-xs list_size"><i class="fa fa-eye"></i>删除</a>
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


{*新建微信号弹出层*}
<div class="modal fade" id="public_number" tabindex="-1" role="basic" aria-hidden="true" style="display: none;">
    <div class="modal-dialog">
        <div class="modal-content">
            <form action="?" method="post">
                <input name="action" value="add_public_number" type="hidden">
                <input type="hidden" name="public_id">
                <div class="modal-body">
                    <table class="table">
                        <thead>
                        <th width="200px;">新建微信号</th>
                        </thead>
                        <tr>
                            <td>
                                <label class="control-label">微信号<span class="required" aria-required="true">*</span></label>
                            </td>
                            <td>
                                <input class="form-control" name="public_number" class="form-control">
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <label class="control-label">微信名称<span class="required" aria-required="true">*</span></label>
                            </td>
                            <td>
                                <input class="form-control" name="show_name" class="form-control">
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <label class="control-label">微信号类型</label>
                            </td>
                            <td>
                                <input type="hidden" class="form-control select2 select2_public_type" name="public_type" data-values="" value="">
                            </td>
                        </tr>
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
<script type="text/javascript" src="{$_assets}plugins/select2/select2.min.js"></script>
<script>
    $(document).ready(function () {
        $('.date').datetimepicker({
            format: 'YYYY-MM-DD',
            locale: 'zh-cn'
        });
        $('.select2_public_type').each(function(){
            $(this).select2({
                tags: $(this).data('values').split(',')
            })
        });
    });

    OperatePublic = {
        editPublic: function(e){
            var public_id = $(e).parents('tr').data('pid');
            var public_number = $(e).parents('tr').data('number');
            var show_name = $(e).parents('tr').data('show');
            var pubic_type_arr=$(e).parents('tr').data('type');
            var arr=[];
            arr=pubic_type_arr.split(" / ");
            $("#public_number input[name=public_id]").val(public_id);
            $("#public_number input[name=show_name]").val(show_name);
            $("#public_number input[name=public_number]").val(public_number);
            $("#public_number input[name=public_type]").select2("val",arr);
        },
        delPublic: function (e) {
            if (!confirm('您确定要删除该微信号吗？？此操作不可恢复！！')) {
                return false;
            }
            var public_id = $(e).parents('tr').data('pid');
            $.post('?', {
                public_id: public_id,
                action: 'delete_public'
            }, function (data) {
                if (data.status == 1) {
                    top.alert(" " + data.msg);
                    window.location.reload();
                } else {
                    top.alert(data.msg);
                }
            }, "json");
        }
    };

</script>
</body>
<!-- END BODY -->
</html>