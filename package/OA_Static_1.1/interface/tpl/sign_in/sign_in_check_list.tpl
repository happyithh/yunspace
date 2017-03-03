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
                    <input type="hidden" name="handle_type" value="{$_data['other']['handle_type']}">

                    <div class="form-body clearfix">
                        <div class="form-group col-md-5">
                            <label class="col-md-3 control-label">申请人</label>

                            <div class="col-md-9">
                                <input type="text" class="form-control input-sm" placeholder="申请人名称"
                                       name="search[fullname]" value="{$_REQUEST['search']['fullname']}">
                            </div>
                        </div>
                        <div class="form-group col-md-5">
                            <label class="col-md-3 control-label">申请时间</label>

                            <div class="col-md-4">
                                <input type='text' class="form-control date" placeholder="请选择开始时间"
                                       name="search[start_time]" value="{$_REQUEST['search']['start_time']}"/>
                            </div>
                            <div class="col-md-4 col-md-offset-1">
                                <input type='text' class="form-control date" placeholder="请选择结束时间"
                                       name="search[end_time]" value="{$_REQUEST['search']['end_time']}"/>
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
            公出签到列表
        </div>
    </div>
    <div class="portlet-body">
        <div class="table-responsive clearfix">
            <table class="table table-striped table-bordered table-hover" id="data_table" style="word-break: break-all">
                <thead>
                <tr>
                    <th>申请人</th>
                    <th>公出时间</th>
                    <th>返回时间</th>
                    <th>公出地址</th>
                    <th>公出事由</th>
                    <th>申请时间</th>
                    <th>操作</th
                </tr>
                </thead>
                <tbody>
                {foreach $_data['rows'] as $k=>$v}
                <tr>
                    <td>{$v['admin_fullname']}</td>
                    <td>{date('Y-m-d h:i',$v['outside_time'])}</td>
                    <td>{date('Y-m-d h:i',$v['back_time'])}</td>
                    <td>{$v['address']}</td>
                    <td>{$v['outside_reason']}</td>
                    <td>{date('Y-m-d h:i',$v['create_time'])}</td>
                    <td>
                        <a href="javascript:;"
                           class="btn btn-success btn-xs" data-id="{$v['id']}" data-status="1" onclick="update_status(this)">通过</a>
                        <a href="#reject-sign"
                           class="btn btn-danger btn-xs" data-id="{$v['id']}" data-toggle="modal" onclick="rejectReason(this)">拒绝</a>
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
{*填写文章url*}
<div class="modal fade" id="reject-sign" tabindex="-1" role="basic" aria-hidden="true">
    <div class="modal-dialog" style="position: fixed;top:20%;left: 20%">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
                <input class="form-control reject-id" type="hidden"  value="" rows="5"  style="margin-bottom:10px;">
                <h4 class="modal-title">
                    请填写拒绝理由</h4>
            </div>
            <div class="modal-body base-info">
                <table width="80%">
                    <tr>
                        <td colspan="4">
                            <input class="form-control reject-reason"  value="" rows="5"  style="margin-bottom:10px;">
                        </td>
                    </tr>
                </table>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">
                    取消
                </button>
                <button type="button" data-id="" data-status="-1" class="btn btn-success update_status" onclick="update_status(this)">
                    确定
                </button>
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
<script type="text/javascript" src="js/moment.min.js"></script>
<script type="text/javascript" src="js/zh-cn.js"></script>
<script type="text/javascript" src="js/bootstrap-datetimepicker.min.js"></script>
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
    function rejectReason(o){
        $('.reject-id').val($(o).data('id'));
    }
    function update_status(e){

        var status = $(e).data('status');
        var reject_reason = $('.reject-reason').val();
        if(status==-1){
            var id = $('.reject-id').val();
        }else{
            var id = $(e).data('id');
        }
        YunSpace.api('sign/in/check.jsonp',{
            id:id,status:status,reject_reason:reject_reason
        },function(data){
            if(data.status ==1){
                alert(data.msg);
                window.location.reload()
            }else{
                alert(data.msg);
            }
        },'json')
    }
</script>
{static "core/yunspace.js"}
{*<iframe style="width: 1px; height:1px;" width="1" height="1" hidden="hidden" src="{$_home}space/pedia_space_update"></iframe>*}
</body>
<!-- END BODY -->
</html>