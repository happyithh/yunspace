<!DOCTYPE html>
<!--[if IE 8]>
<html lang="en" class="ie8 no-js"> <![endif]-->
<!--[if IE 9]>
<html lang="en" class="ie9 no-js"> <![endif]-->
<!--[if !IE]><!-->
<html lang="en" class="no-js">
<!--<![endif]-->
<head>
    {include 'Web_User_Center::inc/html_head.tpl' theme='blue'}
    <link rel="stylesheet" href="css/fullcalendar.css"/>
</head>
<body>
{include 'Web_User_Center::inc/header_top.tpl' color='#0b679e'}
<div class="clearfix"></div>
<div class="page-container">
    {include 'inc/header_nav.tpl' index=0}

    <div class="page-content-wrapper">
        <div class="page-content">
            <!-- BEGIN PAGE HEADER-->
            <h3 class="page-title pull-left">
                空间场地/配套服务编辑
            </h3>
            <a href="{$_route}product/space" class="btn btn-default pull-right">返回</a>

            <div class="clearfix"></div>
            <div class="row">
                <div class="col-md-12">

                    <div class="portlet">
                        <div class="portlet-body form">
                            <div class="form-horizontal">
                                <div class="form-body">
                                    <div class="form-group ">
                                        <label class="col-md-1 control-label">所属供应商</label>

                                        <div class="col-md-11">
                                            <input type="text" class="form-control"  value="{$Info['vendor_name']}" readonly>
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

                                        <form action="{$_route}product_edit/add_schedule" id="add">
                                            <div class="col-md-2">
                                                <div class="input-group date form_date col-md-12" data-date=""
                                                     data-date-format="dd MM yyyy" data-link-field="dtp_input2"
                                                     data-link-format="yyyy-mm-dd">
                                                    <input class="form-control time1" size="16" type="text" value=""
                                                           readonly style="width:100%;background:#ffffff"
                                                           name="start_time" placeholder="请填开始束时间">
                                                    <span class="input-group-addon" style="background:#ffffff"><span
                                                                class="glyphicon glyphicon-calendar"></span></span>
                                                </div>
                                                <input type="hidden" id="dtp_input2" value=""/><br/>
                                            </div>

                                            <div class="col-md-2">
                                                <div class="input-group date form_date col-md-12" data-date=""
                                                     data-date-format="dd MM yyyy" data-link-field="dtp_input2"
                                                     data-link-format="yyyy-mm-dd" >
                                                    <input class="form-control time2"  size="16" type="text" value=""
                                                           readonly style="width:100%;background:#ffffff" placeholder="请填写结束时间"
                                                           name="end_time">
                                                    <span class="input-group-addon" style="background:#ffffff"><span
                                                                class="glyphicon glyphicon-calendar"></span></span>
                                                </div>
                                                <input type="hidden" name="product_id" value="{$Info['id']}"/><br/>
                                            </div>
                                            <div class="col-md-3">
                                                <input type="text" class="form-control schedule" placeholder="文案名称"
                                                       name="des"><span class="pull-left"></span>
                                            </div>
                                            <style>
                                                .colorBlock{
                                                    height:30px;float:left;margin-right: 10px;box-sizing: border-box;margin-top:2px;
                                                }
                                                .colorActive{
                                                    border:1px solid #7eed72;
                                                }
                                            </style>
                                            <div class="col-md-2">
                                                <div class="row" style="margin:0 auto">
                                                    <div class="col-md-1 col-sm-1 colorBlock"  style="background: #f51650" data-color="#f51650"></div>
                                                    <div class="col-md-1 col-sm-1 colorBlock"  style="background:#f51650" data-color="#f51650"></div>
                                                    <div class=" col-md-1 col-sm-1 colorBlock"  style="background:#00c3c3" data-color="#00c3c3"></div>
                                                    <div class=" col-md-1 col-sm-1 colorBlock"  style="background: #20b730" data-color=" #20b730"></div>
                                                    <div class="col-md-1 col-sm-1 colorBlock"  style="background:#ff4e00" data-color="#ff4e00"></div>
                                                </div>
                                            </div>
                                            <input type="text" style="display: none" name="color" class="color_select"/>
                                            <div class="col-md-1" style="margin-left:-2.5%">
                                                <button class="btn btn-danger" type="submit">添加档期文案</button>
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
                                                            颜色
                                                        </th>
                                                        <th>
                                                            开始时间
                                                        </th>
                                                        <th>
                                                            结束时间
                                                        </th>
                                                        <th>
                                                            档期文案
                                                        </th>
                                                        <th>操作</th>
                                                    </tr>
                                                    </thead>
                                                    <tbody>
                                                    {foreach $_data as $v}
                                                        <tr data-id="{$v['id']}">
                                                            <td>
                                                                {$v['id']}
                                                            </td>
                                                            <td>
                                                                <div style="background: {$v['color']};width:100%;;height:30px;,margin:0 auto"></div>
                                                            </td>

                                                            <td>
                                                                {Date("Y-m-d H:i",$v['start_time'])}
                                                            </td>
                                                            <td>
                                                                {Date("Y-m-d H:i",$v['end_time'])}
                                                            </td>
                                                            <td>
                                                                {$v['des']}
                                                            </td>
                                                            <td>

                                                                <a href="javascript:;" class="btn btn-xs btn-danger delEvent"  data-status="-1" onclick="ListOperator.handle_product(this)">删除</a>
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


    </div>
</div>
</div>




{include 'Web_User_Center::inc/footer_inbox.tpl'}
{include 'Web_User_Center::inc/footer_script.tpl'}


<script src="js/moment.min.js" type="text/javascript"></script>
<script src="js/fullcalendar.js" type="text/javascript"></script>
<script src="js/bootstrap-datetimepicker.min.js" type="text/javascript"></script>

<script>
    $(document).ready(function () {
        var color;
        $(".colorBlock").on("click",function() {
            color=$(this).data("color");
            $(".colorBlock").removeClass('colorActive');
            $(this).addClass('colorActive');
        });
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
            editable: false,
            timezone: true,
            eventLimit: true, // allow "more" link when too many events
            events: [
                {foreach $_data as $v}
                {
                    title: '{$v["des"]}',
                    start: '{date('Y-m-d H:i',$v["start_time"])}',
                    end: '{date('Y-m-d H:i',strtotime("+1 day",$v["end_time"]))}',
                    allDay: true,
                    color:'{$v["color"]}'
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
        $('.form_date').datetimepicker({
            format: 'yyyy-mm-dd',
            language: 'zh-cn',
            weekStart: 1,
            todayBtn: 1,
            autoclose: 1,
            todayHighlight: 1,
            startView: 2,
            minView: 2,
            forceParse: 0
        });
        $('#add').submit(function (e) {
            if(color==undefined){
                alert('请选择颜色提醒自己吧！！');
                return false;
            }
            if(false == confirm('您确认您填写的内容准确无误了？？')){
                return false;
            }
            $(".color_select").val(color);
            var start_time = $('.time1').val();
            var end_time = $('.time2').val();
            if (start_time == '') {
                alert('开始时间必须填写！！');
                $('.time1').focus();
                return false;
            }
            if (end_time == '') {
                alert('结束时间必须填写！！');
                $('.time2').focus();
                return false
            }
        });
    });
    ListOperator = {
            handle_product:function(obj){
                var id = $(obj).parents('tr').data('id');
                var product_status =$(obj).attr('data-status');
                if(product_status!=1){
                    if(product_status==-1){
                        var msg='确定要删除此产品吗？';
                    }else if(product_status==-2){
                        var msg='确定要彻底删除此产品吗？此操作不可恢复！！';
                    }
                    if(confirm(msg)){
                        ListOperator.post_product_status(id);
                    }else{
                        return false;
                    }
                }else{
                    ListOperator.post_product_status(id);
                }
            },
            post_product_status:function(id){
                $.post('{$_route}product_edit/delete_auction', {
                    id: id
                }, function (data) {
                    if (data != 'success') {
                        alert('操作失败,可能是网络异常,请重试!');
                    } else {
                        window.location.reload();
                    }
                })
            }
    };

</script>
</body>
</html>