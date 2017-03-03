<!DOCTYPE html>
<!--[if IE 8]>
<html lang="en" class="ie8 no-js"> <![endif]-->
<!--[if IE 9]>
<html lang="en" class="ie9 no-js"> <![endif]-->
<!--[if !IE]><!-->
<html lang="en" class="no-js">
<!--<![endif]-->
<head>
    <title>{$title}</title>
    <meta content="" name="description"/>
    {include "Admin::inc/html_head.tpl"}
    <link href="style/css.css" rel="stylesheet"/>

    <link rel="stylesheet" href="css/fullcalendar.css"/>
</head>
<body style="background:#FaFaFa !important">
<div class="row">
    <div class="col-md-12">
        <div class="portlet">
            <div class="portlet-title">
                <div class="caption">
                    档期管理
                </div>
                <a href="?action={$_REQUEST['action']}&tab=product&vendor_id={$_REQUEST['vendor_id']}"
                   class="btn btn-default pull-right btn-sm">返回</a>
            </div>
            <div class="portlet-body form">
                <div class="form-horizontal">
                    <div class="form-body">
                        <div class="form-group ">
                            <label class="col-md-1 control-label">所属供应商</label>

                            <div class="col-md-11">
                                <input type="text" class="form-control" value="{$Info['vendor_name']}" readonly>
                            </div>
                        </div>

                        <div class="form-group row">
                            <label class="col-md-1 control-label">产品名称</label>

                            <div class="col-md-11">
                                <input type="text" class="form-control" value="{$Info['product_name']}" readonly>
                            </div>
                        </div>


                        <div class="form-group row">
                            <label class="col-md-1 control-label">日程</label>

                            <div class="col-md-11 col-sm-11">
                                <div style="border:1px solid #d7d7d7;margin-top: 12px; padding: 20px;">
                                    <div id="showDate">
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-md-1 control-label">添加档期</label>

                            <form action="?" id="add">
                                <input type="hidden" name="action" value="{$_REQUEST['action']}"/>
                                <input type="hidden" name="point" value="submit"/>
                                <input type="hidden" name="tab" value="{$_REQUEST['tab']}"/>
                                <input type="hidden" name="vendor_id" value="{$_REQUEST['vendor_id']}"/>
                                <input type="hidden" name="id" value="{$Info['vendor_account_id']}"/>

                                <div class="col-md-2">
                                    <div class="input-group  col-md-12">
                                        <input class="form-control time1 date" type="text" value=""
                                               name="start_time" placeholder="请填开始束时间">
                                                    <span class="input-group-addon"><span
                                                                class="glyphicon glyphicon-calendar"></span></span>
                                    </div>
                                    <input type="hidden" id="" value=""/><br/>
                                </div>

                                <div class="col-md-2">
                                    <div class="input-group  ">
                                        <input class="form-control time2 date" type="text" value=""
                                               placeholder="请填写结束时间"
                                               name="end_time">
                                                    <span class="input-group-addon"><span
                                                                class="glyphicon glyphicon-calendar"></span></span>
                                    </div>
                                    <input type="hidden" name="product_id" value="{$Info['id']}"/><br/>
                                </div>
                                <div class="col-md-1">
                                    <select class="form-control" name="status">
                                        {foreach $status as $key=>$val}
                                            <option value="{$key}" {if $key==1}selected{/if}>{$val}</option>
                                        {/foreach}
                                    </select>
                                </div>
                                <div class="col-md-3">
                                    <input type="text" class="form-control schedule" placeholder="文案名称"
                                           name="des"><span class="pull-left"></span>
                                </div>
                                <div class="col-md-2">
                                    <button class="btn btn-success" type="submit">添加档期</button>
                                </div>
                            </form>
                        </div>


                        <div class="row">
                            <label class="col-md-1 control-label"></label>

                            <div class="col-md-11">
                                <div class="table-responsive">
                                    <table class="table table-striped table-bordered table-advance table-hover">
                                        <thead>
                                        <tr>
                                            <th>
                                                #ID
                                            </th>
                                            <th>
                                                开始时间
                                            </th>
                                            <th>
                                                结束时间
                                            </th>
                                            <th>
                                               类型
                                            </th>
                                            <th>
                                                档期文案
                                            </th>
                                          
                                            <th>
                                                操作
                                            </th>
                                        </tr>
                                        </thead>
                                        <tbody>
                                        {foreach $_data as $v}
                                            <tr>
                                                <td>
                                                    #{$v['id']}
                                                </td>
                                                <td>
                                                    {Date('Y-m-d H:i',$v['start_time'])}
                                                </td>
                                                <td>
                                                    {Date('Y-m-d H:i',$v['end_time'])}
                                                </td>
                                                <td>{$status[$v['status']]}</td>
                                                <td>
                                                    {$v['des']}
                                                </td>
                                                <td>
                                                    <a href="?action=detail&tab=schedule&point=del&vendor_id={$_REQUEST['vendor_id']}&s_id={$v['id']}&product_id={$_REQUEST['product_id']}"
                                                       class="btn btn-danger btn-sm">删除</a>
                                                </td>
                                            </tr>
                                        {/foreach}
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

            </div>
        </div>
    </div>


    <!-- END BUTTONS PORTLET-->
</div>
</div>


<script src="js/jquery-1.9.1.min.js" type="text/javascript"></script>

<script src="js/moment.min.js" type="text/javascript"></script>
<script src="js/zh-cn.js" type="text/javascript"></script>
<script src="js/bootstrap-datetimepicker.min.js" type="text/javascript"></script>


<script src="js/fullcalendar.js" type="text/javascript"></script>
<script>
    $(document).ready(function () {

        $('#showDate').fullCalendar({
            header: {
                left: 'prev',
                center: 'title',
                right: 'next'
            },
            aspectRatio: 1.35,
            height: 100,
            handleWindowResize: true,
            contentHeight: 400,
            editable: true,
            timezone: true,
            eventLimit: true, // allow "more" link when too many events
            events: [
                {foreach $_data as $v}
                {
                    title: '{$v["des"]}',
                    start: '{Date('Y-M-d H:i',$v['start_time'])}',
                    end: '{Date('Y-M-d H:i',strtotime("+1 day",$v["end_time"]))}',
                    allDay: true
                },
                {/foreach}
            ],
            dayNamesShort: [
                '日', '一', '二', '三', '四', '五', '六'
            ],
            monthNamesShort: [
                '一月', '二月', '三月', '四月', '五月', '六月', '七月', '八月', '九月', '十月', '十一月', '十二月'
            ],
            monthNames: [
                '一月', '二月', '三月', '四月', '五月', '六月', '七月', '八月', '九月', '十月', '十一月', '十二月'
            ]
        });

        $('.date').datetimepicker({
            format: 'YYYY-MM-DD',
            locale: 'zh-cn'
        });


        $('#add').submit(function (e) {
            if (false == confirm('您确定您填写的内容准确无误了吗？')) {
                return false;
            }
            var start_time = $('.time1').val();
            var end_time = $('.time2').val();
            if (start_time == '') {
                alert('开始时间必须填写！！');
                return false;
            }
            if (end_time == '') {
                alert('结束时间必须填写！！');
                return false
            }
        })
    })
</script>
</body>