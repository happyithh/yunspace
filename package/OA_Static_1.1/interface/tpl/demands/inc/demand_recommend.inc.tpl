<div class="portlet-title" xmlns="http://www.w3.org/1999/html" style="display:none" id="Demand_need">
    <div class="caption">
        <i class="fa fa-database"></i>需求推荐

    </div>
</div>
<div class="portlet-body" style="display:none" id="Demand">
    <div class="clearfix">
        <form class="form-horizontal" action="" method="post">
            <input type="hidden" name="data[demand_id]" id="demand_id" value="{$_REQUEST['demand_id']}">

            <div class="form-group">
                <label for="inputEmail12" class="col-md-2">推荐产品/套餐：</label>

                <div class="col-md-4">
                    <div class="input-icon">
                        <input name="data[product_id] " data-account_id="{$_demand['account_id']}"
                               placeholder="请输入场地ID/套餐ID或名称" class="form-control select2"
                               id="search_product_all" type="hidden">

                    </div>
                </div>
            </div>
            <div class="form-group">
                <label for="inputEmail11" class="col-md-2">推荐理由：</label>

                <div class="col-md-4">
                    <div class="input-icon">
                        <textarea name="data[demo]" class="form-control" rows="5" id="reason"></textarea>
                    </div>
                </div>
            </div>
            <div class="form-actions">
                <div class="form-group">
                    <div class="col-md-offset-2 col-md-10">
                        <button type="button" class="btn btn-success" onclick="demandOperation.recommendSubmit(this)">
                            确认推荐
                        </button>
                    </div>
                </div>
            </div>
        </form>
    </div>
</div>

<div class="portlet-title">
    <div class="caption">
        <i class="fa fa-database"></i>推荐列表
        <button class="btn  btn-primary btn-xs look" id="Recommend" onclick="Recommend(this)">添加推荐</button>
    </div>
</div>

<div class="tab-content clearfix">
    <div class="tab-pane active">
        <table class="table table-striped table-bordered table-hover" style="word-break: break-all">
            <thead>
            <tr>
                <th>#ID</th>
                <th>类型</th>
                <th>名称</th>
                <th class="list_none">推荐理由</th>
                <th class="list_none">推荐时间</th>
                <th class="list_none">带看场地时间</th>
                <th class="list_none">订单号</th>
                <th>操作</th>
            </tr>
            </thead>
            {if $demand_recommend}
                <tbody>
                {foreach $demand_recommend as $key => $value }
                    <tr>
                        <td style="font-size: 12px;">{$value['id']}</td>
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
                                    <button class="btn btn-danger btn-xs" style="font-size: 12px;;">已带看</button>
                                {else}
                                    <button class="btn btn-success btn-xs" style="font-size: 12px;">未带看</button>
                                {/if}</td>
                        {/if}
                        <td style="font-size: 12px;" class="list_none">{$value['demo']}</td>
                        <td style="font-size: 12px;" class="list_none">{date('Y-m-d H:i:s',$value['create_time'])}</td>
                        <td style="font-size: 12px;" class="list_none">{$value['look_time']}</td>
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
                                   onclick="TakeLook(this)" data-pid="{$value['id']}"
                                   data-name="{$value['product_name']}" style="font-size: 12px;">带看场地</a>
                                <a class="btn btn-success btn-xs look"
                                   href="#create_remark" data-toggle="modal"
                                   style="font-size: 12px;" data-pid="{$value['id']}"
                                   onclick="LookRemark(this)">查看备注</a>
                            {else}
                                <a target="_blank" href="http://{Core::$urls['host']}/set_info/{$value['set_id']}.html"
                                   class="btn btn-info btn-xs" style="font-size: 12px;">查看</a>
                                <a target="_blank" href="?action=set_pdf&set_id={$value['set_id']}"
                                   class="btn btn-primary btn-xs" style="font-size: 12px;">导出PDF</a>
                                {*<a href="{$_route}list?action=create_order&product_id={$value['set_id']}&demand_id={$_REQUEST['demand_id']}&id={$value['id']}"*}
                                {*class="btn btn-info btn-xs" style="font-size: 12px;">生成订单</a>*}
                                <a class="btn btn-success btn-xs look"
                                   href="#create_site_lokksite" data-toggle="modal"
                                   onclick="TakeLook(this)" data-pid="{$value['id']}" data-name="{$value['set_name']}"
                                   style="font-size: 12px;">带看场地</a>
                                <a class="btn btn-success btn-xs look"
                                   href="#create_remark" data-toggle="modal"
                                   style="font-size: 12px;" data-pid="{$value['id']}"
                                   onclick="LookRemark(this)">查看备注</a>
                            {/if}


                        </td>
                    </tr>
                {/foreach}
                </tbody>
            {/if}
        </table>
    </div>
</div>

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
                <table style="width:80%;">
                    <tr>
                        <td>
                            场地查看时间：
                        </td>
                        <td><input type="text" class="form-control dateTakeLook" name="data[look_time]"
                                   placeholder="请选择要查看的场地时间">
                            <input type="hidden" class="recommend_id" value="">
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
                <button type="button" class="btn btn-success takeLookSubmit">
                    确定
                </button>
            </div>

        </div>
    </div>

</div>


<div class="modal fade" id="create_remark" tabindex="-1" role="basic" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
                <h4 class="modal-title">
                    备注</h4>
            </div>
            <div class="modal-body">
                <input type="hidden" name="id" class="remark_id">

                <div class="caption">
                    <label for="inputEmail12" class="col-md-2">备注列表</label>
                </div>

                <table class="table table-striped table-bordered table-hover" style="word-break: break-all"
                       id="tableBeiZhu">
                    <thead>
                    <tr>
                        <th>姓名</th>
                        <th>备注</th>
                        <th>时间</th>

                    </tr>
                    </thead>
                    <tbody>

                    {*<tr>*}
                    {*<td > </td>*}
                    {*<td > </td>*}
                    {*<td ></td>*}
                    {*</tr>*}

                    </tbody>


                </table>
                <table class="table table-striped table-bordered table-hover" style="word-break: break-all">
                    <tr>
                        <th colspan="3">添加备注：</th>
                    </tr>
                    <tr>
                        <td colspan="3"><textarea name="demo" class="form-control look_demo" rows="5"></textarea>
                        </td>
                    </tr>
                </table>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">
                    取消
                </button>
                <button type="button" class="btn btn-success create_remark">
                    确定
                </button>
            </div>

        </div>
    </div>

</div>
<script type="text/javascript" src="js/moment.min.js"></script>
<script type="text/javascript" src="js/bootstrap-datetimepicker.min.js"></script>
<script type="text/javascript" src="js/zh-cn.js"></script>
<script type="text/javascript" src="js/date.js"></script>
<script type="text/javascript">
    $(document).ready(function () {
        $('.dateTakeLook').datetimepicker({
            format: 'YYYY-MM-DD',
            locale: 'zh-cn'
        });
    });
    function TakeLook(o) {

        var id = $(o).data('pid');
        var name = $(o).data('name');
        $(".recommend_id").val(id);
        $(".recommend_charges").val(name);

    }
    ;
    $('.takeLookSubmit').click(function () {
        $.ajax({
            url: "?",
            type: 'get',
            dataType: "json",
            data: {
                action: 'takeLook',
                recommend_id: $(".recommend_id").val(),
                look_time: $(".dateTakeLook").val(),
                look_remark: $(".look_reason").val(),
                demand_id: "{$_REQUEST['demand_id']}"
            },
            success: function (data) {
                if (data.status == 1) {
                    top.alert(data.msg);
                    window.location.reload();
                } else {
                    top.alert(data.msg);
                }
            }
        });

    });
    //填写备注
    function LookRemark(o) {
        var id = $(o).data('pid');
        $('.remark_id').val(id);
        var _tableBody = $("#tableBeiZhu tbody")
        _tableBody.html("");
        $.ajax({
            url: "?action=selectremark",
            data: {
                id: id
            },
            dataType: "json"
        }).done(function (data) {
            var list = data.data;
            var mainStr;
            var i;
            for (i = 0; i < list.length; i++) {
                var str = " <tr>" +
                        " <td >" + list[i]['销售'] + " </td>" +
                        "<td >" + list[i]['备注'] + " </td>" +
                        " <td >" + list[i]['时间'] + " </td>" +
                        "</tr>"
                mainStr += str
            }
            _tableBody.append(mainStr)
        })
    }
    $('.create_remark').on('click', function () {
        var demo = $(".look_demo").val();
        var id = $(".remark_id").val();
        $.ajax({
            url: "?action=remark",
            data: {
                remark: demo,
                id: id
            },

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
    //显示需求推荐
    function Recommend() {
        $("#Recommend").css('display', 'none');
        $("#Demand_need,#Demand").fadeIn(400);
    }
</script>