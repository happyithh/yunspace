<div class="portlet-title" xmlns="http://www.w3.org/1999/html">
    <div class="caption">
        <i class="fa fa-database"></i>需求推荐
    </div>
</div>
<div class="portlet-body">
    <div class="clearfix">
        <form class="form-horizontal" action="" method="post">
            <input type="hidden" name="data[demand_id]" id="demand_id" value="{$_REQUEST['demand_id']}">

            <div class="form-group">
                <label for="inputEmail12" class="col-md-2">推荐产品/套餐：</label>

                <div class="col-md-4">
                    <div class="input-icon">
                        {*<input type="text" class="form-control" id="inputEmail12" placeholder="请输入产品地址" name="data[product_url]">*}

                        <input name="data[product_id] " placeholder="请输入场地ID/套餐ID或名称" class="form-control select2"
                               id="product_id" type="hidden">

                    </div>
                </div>
            </div>
            <div class="form-group">
                <label for="inputEmail11" class="col-md-2">推荐理由：</label>

                <div class="col-md-4">
                    <div class="input-icon">
                        <textarea name="data[demo]" class="form-control" rows="5" id="demo"></textarea>
                    </div>
                </div>
            </div>
            <div class="form-actions">
                <div class="form-group">
                    <div class="col-md-offset-2 col-md-10">
                        <button type="button" class="btn btn-success submit_recommend">确认推荐</button>
                    </div>
                </div>
            </div>
        </form>
    </div>
</div>
{if $demand_recommend['demand_demo']}
    <div class="portlet-title">
        <div class="caption">
            <i class="fa fa-database"></i>需求回复
        </div>
    </div>
    <div class="tab-pane active">
        <div>
            <table class="table table-striped table-bordered table-hover" style="word-break: break-all">
                <tr>
                    <th>回复时间</th>
                    <th>回复内容</th>
                </tr>
                {foreach $demand_recommend['demand_demo'] as $dk=>$dv}
                    <tr>
                        <td>{date('Y-m-d H:i:s',$dv['create_time'])}</td>
                        <td>{htmlspecialchars($dv['demo'])}</td>
                    </tr>
                {/foreach}
            </table>
        </div>
    </div>
{/if}
{if $demand_recommend['demand_product']['rows']}
    <div class="portlet-title">
        <div class="caption">
            <i class="fa fa-database"></i>推荐列表
        </div>
    </div>
    <div class="tab-content clearfix">
        <div class="tab-pane active">
            <table class="table table-striped table-bordered table-hover" style="word-break: break-all">
                <thead>
                <tr>
                    <th>类型</th>
                    <th>名称</th>
                    <th class="list_none">推荐理由</th>
                    <th class="list_none">推荐时间</th>
                    <th class="list_none">查看场地理由</th>
                    <th class="list_none">查看场地时间</th>
                    <th class="list_none">订单号</th>
                    <th>操作</th>
                </tr>
                </thead>
                <tbody>
                {foreach $demand_recommend['demand_product']['rows'] as $key => $value }
                    <tr>
                        {if $value['product_id'] }
                            <td style="font-size: 12px;">服务推荐</td>
                            <td style="font-size: 12px;">{$value['product_name']}  {if $value['look_time'] }
                                    <button class="btn btn-danger btn-xs" style="font-size: 12px; ">已带看</button>
                                    {else}
                                    <button class="btn btn-success btn-xs" style="font-size: 12px;">未带看</button>
                                {/if}</td>
                        {else}
                            <td style="font-size: 12px;">套餐推荐</td>
                            <td style="font-size: 12px;">{$value['set_name']}  {if $value['look_time'] }
                                    <button  class="btn btn-danger btn-xs"  style="font-size: 12px;;">已带看</button>
                                    {else}
                                    <button class="btn btn-success btn-xs" style="font-size: 12px;">未带看</button>
                                {/if}</td>
                        {/if}
                        <td style="font-size: 12px;" class="list_none">{$value['demo']}</td>
                        <td style="font-size: 12px;" class="list_none">{date('Y-m-d H:i:s',$value['create_time'])}</td>
                        <td style="font-size: 12px;" class="list_none">{$value['look_reason'][0]}</td>
                        <td style="font-size: 12px;" class="list_none">{$value['look_time'][0]}</td>
                        <td style="font-size: 12px;" class="list_none">{$value['order_no']}</td>
                        <td style="font-size: 12px;">
                            {if $value['product_id'] }
                                <a target="_blank"
                                   href="http://{Core::$urls['host']}/service_info/{$value['product_id']}.html"
                                   class="btn btn-info btn-xs" style="font-size: 12px;">查看</a>
                                <a target="_blank" href="?action=pdf&product_id={$value['product_id']}"
                                   class="btn btn-primary btn-xs" style="font-size: 12px;">导出PDF</a>
                                {*<a href="{$_route}list?action=create_order&product_id={$value['product_id']}&demand_id={$_REQUEST['demand_id']}&id={$value['id']}"*}
                                   {*class="btn btn-info btn-xs" style="font-size: 12px;">生成订单</a>*}
                                <a class="btn btn-success btn-xs"
                                   href="#create_site_lokksite" data-toggle="modal"
                                   onclick="LookSite(this)" data-pid="{$value['id']}"
                                   data-name="{$value['product_name']}" style="font-size: 12px;">带看场地</a>
                            {else}
                                <a target="_blank" href="http://{Core::$urls['host']}/set_info/{$value['set_id']}.html"
                                   class="btn btn-info btn-xs" style="font-size: 12px;">查看</a>
                                <a target="_blank" href="?action=set_pdf&set_id={$value['set_id']}"
                                   class="btn btn-primary btn-xs" style="font-size: 12px;">导出PDF</a>
                                {*<a href="{$_route}list?action=create_order&product_id={$value['set_id']}&demand_id={$_REQUEST['demand_id']}&id={$value['id']}"*}
                                   {*class="btn btn-info btn-xs" style="font-size: 12px;">生成订单</a>*}
                                <a class="btn btn-success btn-xs look"
                                   href="#create_site_lokksite" data-toggle="modal"
                                   onclick="LookSite(this)" data-pid="{$value['id']}" data-name="{$value['set_name']}"
                                   style="font-size: 12px;">带看场地</a>
                            {/if}


                        </td>
                    </tr>
                {/foreach}
                </tbody>
            </table>
        </div>
        <div class="pull-right">
            <ul class="pagination">
                {if $demand_recommend['demand_product']['page']['dpll']}
                    <li class="prev">
                        <a href="{$demand_recommend['demand_product']['page']['dup']}1" title="First"><i
                                    class="fa fa-angle-double-left"></i></a>
                    </li>
                    <li class="prev">
                        <a href="{$demand_recommend['demand_product']['page']['dup']}{$demand_recommend['demand_product']['page']['dp']-1}"
                           title="Prev"><i class="fa fa-angle-left"></i></a>
                    </li>
                {else}
                    <li class="prev disabled">
                        <a href="#" title="First"><i class="fa fa-angle-double-left"></i></a>
                    </li>
                    <li class="prev disabled">
                        <a href="#" title="Prev"><i class="fa fa-angle-left"></i></a>
                    </li>
                {/if}
                {for $i=$demand_recommend['demand_product']['page']['dpl'] to $demand_recommend['demand_product']['page']['dpr']}
                    <li{if $i==$demand_recommend['demand_product']['page']['dp']} class="active"{/if}>
                        <a href="{$demand_recommend['demand_product']['page']['dup']}{$i}">{$i}</a>
                    </li>
                {/for}
                <li class="disabled">
                    <a> {$demand_recommend['demand_product']['page']['dtp']}
                        ( {$demand_recommend['demand_product']['page']['dp']*$demand_recommend['demand_product']['page']['dn']}
                        /{$demand_recommend['demand_product']['page']['dt']} )</a></li>

                {if $demand_recommend['demand_product']['page']['dprr']}
                    <li class="next">
                        <a href="{$demand_recommend['demand_product']['page']['dup']}{$demand_recommend['demand_product']['page']['dp']+1}"
                           title="Next"><i class="fa fa-angle-right"></i></a>
                    </li>
                    <li class="next">
                        <a href="{$demand_recommend['demand_product']['page']['dup']}{$demand_recommend['demand_product']['page']['dtp']}"
                           title="Last"><i class="fa fa-angle-double-right"></i></a>
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
{/if}
<div class="modal fade" id="create_site_lokksite" tabindex="-1" role="basic" aria-hidden="true">
    <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                    <h4 class="modal-title">
                        带看场地</h4>
                </div>

                <div class="modal-body">

                    <table>
                        <tr>
                            <td>
                                场地名称：
                            </td>
                            <td>
                                <input name="data[id]" class="form-control recommend_id"
                                       value="" type="hidden">
                                <input name="data[name]" class="form-control recommend_charges"
                                       value="">

                            </td>
                        </tr>
                        <tr>
                            <td>
                                场地查看时间：
                            </td>
                            <td><input type="text" class="form-control date" name="data[look_time]"
                                       placeholder="请选择要查看的场地时间">


                            </td>
                        </tr>
                        <tr>
                            <td>
                                备注：
                            </td>
                            <td><textarea name="data[demo]" class="form-control look_reason" rows="5"></textarea>
                            </td>
                        </tr>
                    </table>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">
                        取消
                    </button>
                    <button type="button" class="btn btn-success create_site_submit">
                        确定
                    </button>
                </div>

    </div>
</div>

</div>
<script type="text/javascript" src="js/moment.min.js"></script>
<script type="text/javascript" src="js/zh-cn.js"></script>
<script type="text/javascript" src="js/bootstrap-datetimepicker.min.js"></script>
<script type="text/javascript" src="js/date.js"></script>
<script>
    function LookSite(o) {
     //   alert();

        var id = $(o).data('pid');
        var name = $(o).data('name');
      //  alert(name);
        $(".recommend_id").val(id);
        $(".recommend_charges").val(name);
        $.ajax({
            url: "?",
            data: {
                id: id
            },
            success: function (data) {

            }
        });
    }
    $('.create_site_submit').on('click', function () {
     //   console.log($(".look_time").val());
      //  alert(1);
//        $.ajax({
//            url: "?action=create_site_submit",
//            data: {
//                id: $(".commission_update_id").val(),
//                date_time: $(".look_time").val(),
//                look_reason: $(".look_reason").val()
//
//            },
//
//            success: function (data) {
//                top.alert(data.msg);
//                $('#create_site_lokksite').modal('hide');
//            }
//        });

        $.ajax("http://{Core::$urls['host']}/static/Api/Demand/Recommend/Look/Space.json?", {
            data: {
                recommend_id: $(".recommend_id").val(),
                look_time:$(".date").val(),
                look_reason: $(".look_reason").val()

            },
         //   console.log($(".look_time").val());
            dataType: "json"
        }).done(function (data) {
            if (data.status == 1) {
                top.alert(data.msg);
                window.location.reload();
            } else {
                top.alert(data.msg);
            }
        });

    });
    $(document).ready(function () {
        $(".date").datetimepicker({
//           autoclose: true,
            //format: "dd MM YYYY - hh"
            format: "YYYY-MM-DD HH:mm"
            //pickerPosition: (App.isRTL() ? "bottom-right" : "bottom-left")
//            format: "YYYY-MM-DD HH:ii",
//            language: 'zh-CN'
//            show: true,
//            format: "yyyy-MM-DD HH:ii"
//            language: 'zh-CN',
//            weekStart: 1,
//            autoclose: true,
//            orientation:'right',
//            todayBtn:'linked'

        });
    });
</script>