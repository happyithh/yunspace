<div class="">
<div class="tab-pane active">
<div class="pull-right">
    <ul class="pagination">
        {if $productInfo['page']['dpll']}
            <li class="prev">
                <a href="{$productInfo['page']['dup']}1" title="First"><i
                            class="fa fa-angle-double-left"></i></a>
            </li>
            <li class="prev">
                <a href="{$productInfo['page']['dup']}{$productInfo['page']['dp']-1}" title="Prev"><i
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
        {for $i=$productInfo['page']['dpl'] to $productInfo['page']['dpr']}
            <li{if $i==$productInfo['page']['dp']} class="active"{/if}>
                <a href="{$productInfo['page']['dup']}{$i}">{$i}</a>
            </li>
        {/for}
        <li class="disabled">
            <a> {$productInfo['page']['dtp']} ( {$productInfo['page']['dp']*$productInfo['page']['dn']}
                /{$productInfo['page']['dt']} )</a></li>

        {if $productInfo['page']['dprr']}
            <li class="next">
                <a href="{$productInfo['page']['dup']}{$productInfo['page']['dp']+1}" title="Next"><i
                            class="fa fa-angle-right"></i></a>
            </li>
            <li class="next">
                <a href="{$productInfo['page']['dup']}{$productInfo['page']['dtp']}" title="Last"><i
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
{if $vendorInfo['status']==2}
    <div style=" margin-bottom: 10px;">
        <a href="javascript::void (0)" onclick="alert('供应商还没有通过审核，不能添加产品~')"
           class="btn btn-success"><span class="glyphicon glyphicon-plus"></span>创建服务</a>
    </div>
{else}
    <div style=" margin-bottom: 10px;">
        <a href="?action=detail&tab=product&handle_type=add_product&vendor_id={$vendorInfo['id']}"
           class="btn btn-success"><span class="glyphicon glyphicon-plus"></span>创建服务</a>
    </div>
{/if}
<div style="margin-bottom: 30px;">
    <form action="?action=detail&tab=product&vendor_id={$vendorInfo['id']}" method="post" class="clearfix">
        <div class="form-body clearfix" style="padding-left: 0px">
            <div class="form-group col-md-5" style="width:30%;padding-left: 0px">
                <label class="col-md-3 control-label"
                       style="width: 20%;padding-left: 0px;padding-right: 0px">套餐/产品名称</label>

                <div class="col-md-9" style="width: 70%;padding-left: 0px;margin-right: 0px">
                    <input type="text" class="form-control input-sm" placeholder="套餐ID / 名称"
                           name="search[title]" value="">
                </div>
            </div>
            <div class="form-group col-md-5" style="width:30%;padding-left: 0px;padding-right: 0px">
                <label class="col-md-3 control-label"
                       style="padding-right: 0px;margin-right: 0px;width: 20%;">产品类型</label>

                <div class="col-md-9" style="width: 70%;padding-left: 5px">

                    <select class="form-control input-sm" name="search[category_id]">
                        <option value=0>不限
                        </option>
                        {function show_category_list level=0}
                            {foreach $categoryList[$id] as $k=>$v}
                                {if $v||$k==$_REQUEST['search']['category_id']}
                                    <option value="{$k}"
                                            {if $k==$_REQUEST['search']['category_id']}selected="selected" {/if}>{str_repeat('&nbsp; ', $lv)}
                                        {$v}
                                    </option>
                                    {if $categoryList[$k]}
                                        {show_category_list data=$categoryList id=$k lv=$lv+1}
                                    {/if}
                                {/if}
                            {/foreach}
                        {/function}
                        {show_category_list data=$categoryList id=0 lv=1}
                    </select>


                </div>
            </div>
            <div class="form-group col-md-5" style="width:15%;padding-left: 0px;padding-right: 200px">
                <div class="" style="text-align: center">
                    <button type="submit" class="btn btn-primary" style="width: 150px">
                        <i class="fa fa-search"></i>
                        搜索
                    </button>
                </div>
            </div>
        </div>
    </form>
</div>
<table class="table table-striped table-bordered table-hover" id="data_table" style="word-break: break-all">
    <thead>
    <tr>
        <th>更新时间</th>
        <th>服务ID</th>
        <th>服务名称</th>
        <th>服务类型</th>
        <th>当前状态</th>
        {*<th style="width: 130px;">状态备注</th>*}
        <th>操作</th>
    </tr>
    </thead>
    <tbody>
    {foreach $productInfo['rows'] as $key=>$value}
        <tr role="row" data-pid="{$value['id']}">
            <td>{Func_Time::format($value['update_time'])}</td>
            <td>{$value['id']}</td>
            <td><a href="{$_root}service_info/{md5($value['id'])}/{$value['id']}.html"
                   style="text-decoration: none" target="_blank">
                    {$value['product_name']}
                </a>
            </td>
            <td>
                <select class="form-control select2me input-sm" name="category_id" data-placeholder="Select..."
                        onchange="ListOperator.changeCategory(this)">
                    {function show_category level=0}
                        {foreach $_categories[$id] as $k=>$v}
                            {if $v}
                                <option value="{$k}"
                                        {if $k==$value['category_id']}selected="selected" {/if}>{str_repeat(' . . ', $lv)}
                                    {$v}
                                </option>
                                {if $_categories[$k]}
                                    {show_category data=$_categories id=$k lv=$lv+1}
                                {/if}
                            {/if}
                        {/foreach}
                    {/function}
                    {show_category data=$_categories id=0 lv=1}
                </select>
            </td>
            <td style="position: relative!important;">
                {if $value['update_status']== 2 || $value['update_status']== 3}
                    {if $value['update_status']==3}
                        <span class="label" style="color: #f3565d;;">审核拒绝</span>
                    {else}
                        <span class="label" style="color: #ecbc29;">审核中</span>
                    {/if}
                {else}
                    <select class="form-control input-sm" onchange="ListOperator.online(this)">
                        <option value="1" {if $value['status']== '1'} selected {/if}>
                            上线
                        </option>
                        <option value="0" {if $value['status']== '0'} selected {/if}>
                            下线
                        </option>
                    </select>
                {/if}
                {if $value['update_status']== 3}
                    <div class="show-reason"></div>
                    <a class="btn btn-danger btn-xs alertreason" style="width:60px;"
                       onclick="ListOperator.alertReason(this)" reason="{$value['refuse_reason']}"
                       style="margin-left: 0px;"><span class="look-reason">查看理由</span>
                    </a>
                {/if}
            </td>
            <td>
                <a href="?action=detail&tab=product&vendor_id={$vendorInfo['id']}&product_id={$value['id']}"
                   class="btn btn-primary btn-xs"><i class="fa fa-pencil"></i>修改</a>
                {if $value['status'] == 1}
                    <a class="btn btn-success btn-xs"
                       href="?action=detail&tab=schedule&vendor_id={$vendorInfo['id']}&product_id={$value['id']}">档期管理</a>
                {/if}
                {*{if  $value['update_status']!=3}*}
                    {*<a class="btn btn-success btn-xs"*}
                       {*href="?action=detail&tab=product&vendor_id={$vendorInfo['id']}&handle_type=caseshow&product_id={$value['id']}">案例</a>*}
                {*{/if}*}
                <a class="btn btn-success btn-xs"
                   href="?action=detail&tab=product&vendor_id={$vendorInfo['id']}&handle_type=deliver&product_id={$value['id']}">投稿</a>
                <a class="btn btn-success btn-xs"
                   href="#commission_update" data-toggle="modal" onclick="setProductCommission({$value['id']})">设置佣金</a>
                <span onclick="ListOperator.delProduct(this)" class="btn btn-danger btn-xs"><i
                            class="fa fa-trash-o"></i>删除</span>
                {if $value['update_status']==2 || $value['update_status']==3}
                    <span class="btn btn-info btn-xs"
                          onclick="ListOperator.resetProduct(this)">重置</span>
                {/if}
                {*{/if}*}
            </td>
        </tr>
    {/foreach}
    </tbody>
</table>
</div>
</div>
<div class="modal fade" id="commission_update" tabindex="-1" role="basic" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
                <h4 class="modal-title">
                    设置推广成交佣金</h4>
            </div>
            <div class="modal-body">
                <div class="input-group">
                    <input type="text" class="form-control recommend_charges" value="">
                    <input type="hidden" class="form-control commission_update_id" value="">
                    <span class="input-group-addon">%</span>
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">
                    取消
                </button>
                <button type="button" class="btn btn-success commission_update_submit">
                    确定
                </button>
            </div>
        </div>
    </div>

</div>

<script>
    ListOperator = {
        online: function (obj) {
            var online = $(obj).val();
            if (online == 0) {
                var msg = "下线";
            } else {
                var msg = "上线";
            }
            var rs = confirm("是否确定" + msg + "该产品？");
            if (rs == true) {
                var product_id = $(obj).parents('tr').data('pid');
                $.post('http://{Core::$urls['host']}/static/api/product/handle.jsonp', {
                    product_id: product_id,
                    status: online,
                    action:'change_status'
                }, function (data) {
                    if(data.status==1){
                        top.alert(" "+data.msg);
                    }else{
                        top.alert(data.msg);
                    }
                },"json")
            } else {
                $(obj).find("option[value!='" + online + "']").attr("selected", true);
            }
        },
        changeCategory: function (o) {
            var category_id = $(o).find('option:selected').val();
            var product_id = $(o).parents('tr').data('pid');
            if (!category_id) {
                category_id = $(o).find('option:first').val();
            }
            $.post('http://{Core::$urls['host']}/static/api/product/handle.jsonp', {
                product_id: product_id,
                category_id: category_id,
                vendor_id:"{$_REQUEST['vendor_id']}",
                action: 'change_category'
            }, function (data) {
                if(data.status==1){
                    top.alert(" "+data.msg);
                    window.location.reload();
                }else{
                    top.alert(data.msg);
                }
            },"json");
        },
        delProduct: function (e) {

            if (!confirm('您确定要删除吗？？')) {
                return false;
            }
            var product_id = $(e).parents('tr').data('pid');
            $.get('http://{Core::$urls['host']}/static/api/product/handle.jsonp', {
                status: -2,
                product_id: product_id,
                action: 'change_status'
            }, function (data) {
                if(data.status==1){
                    top.alert(" "+data.msg);
                    $(e).parents('tr').hide();
                }else{
                    top.alert(data.msg);
                }
            },"json");
        },
        resetProduct: function (r) {
            if (!confirm('确定要重置此产品的所有信息吗？')) {
                return false;
            }
            var product_id = $(r).parents('tr').data('pid');
            $.post('http://{Core::$urls['host']}/static/api/product/handle.jsonp', {
                product_id: product_id,
                action: 'reset_product'
            }, function (data) {
                if(data.status==1){
                    top.alert(" "+data.msg);
                }else{
                    top.alert(data.msg);
                }
            }, 'json')
        },
        alertReason: function (o) {
            var info = $(o).attr('reason');
            $(o).parent().find(".show-reason").text(info);
            var height = $(o).parent().outerHeight();
            console.log(height);
            $(o).parent().find(".show-reason").css({
                top: height + "px"
            })
            if ($(o).parent().find(".show-reason").hasClass("block")) {
                $(o).parent().find(".show-reason").removeClass("block");
                $(o).parent().find(".show-reason").html("");
                $(".alertreason").find(".look-reason").text("查看理由");
            } else {
                $(o).parent().find(".look-reason").text("关闭");
                $(".show-reason").removeClass("block");
                $(o).parent().find(".show-reason").addClass("block");
            }
        }
    };
    function setProductCommission(pId) {
        $(".commission_update_id").val(pId);
        $.ajax({
            url: "http://{Core::$urls['host']}/static/api/product/handle.jsonp",
            data: {
                product_id: pId,
                action:"get_commission"
            },
            dataType:"json",
            success: function (data) {
                $('.recommend_charges').val(data.data);
            }
        });
    }
    $('.commission_update_submit').on('click', function () {

        $.ajax({
            url: "http://{Core::$urls['host']}/static/api/product/handle.jsonp",
            data: {
                product_id: $(".commission_update_id").val(),
                recommend_charges: $(".recommend_charges").val(),
                action:"change_commission"
            },
            dataType:"json",
            success: function (data) {
                if(data.status==1){
                    top.alert(" "+data.msg);
                    $('#commission_update').modal('hide');
                }else{
                    top.alert(data.msg);
                }
            }
        });
    })

</script>