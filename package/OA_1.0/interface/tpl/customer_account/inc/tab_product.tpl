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
{if $accountInfo['vendors'][0]['id']}
    {if $accountInfo['vendors'][0]['status']==2}
        <div style=" margin-bottom: 10px;">
            <a href="javascript::void (0)" onclick="alert('供应商还没有通过审核，不能添加产品~')"
               class="btn btn-success"><span class="glyphicon glyphicon-plus"></span>创建服务</a>
        </div>
    {else}
        <div style=" margin-bottom: 10px;">
            <a href="?action=detail&tab=product&vendor_id={$accountInfo['vendors'][0]['id']}&id={$accountInfo['id']}"
               class="btn btn-success"><span class="glyphicon glyphicon-plus"></span>创建服务</a>
        </div>
    {/if}
{/if}
<div style="margin-bottom: 30px;">
    <form action="?action=detail&tab=product&id={$accountInfo['id']}" method="post" class="clearfix">
        <div class="form-body clearfix" style="padding-left: 0px">
            <div class="form-group col-md-5" style="width:30%;padding-left: 0px">
                <label class="col-md-3 control-label"
                       style="width: 20%;padding-left: 0px;padding-right: 0px">套餐名称</label>

                <div class="col-md-9" style="width: 70%;padding-left: 0px;margin-right: 0px">
                    <input type="text" class="form-control input-sm" placeholder="套餐ID / 名称"
                           name="search[title]" value="">
                </div>
            </div>
            <div class="form-group col-md-5" style="width:30%;padding-left: 0px;padding-right: 0px">
                <label class="col-md-3 control-label"
                       style="padding-right: 0px;margin-right: 0px;width: 20%;">产品类型</label>

                <div class="col-md-9" style="width: 70%;padding-left: 5px">

                    {*<select class="form-control input-sm" name="search[category_id]">*}
                    {*<option value="0">*}
                    {*产品类型*}
                    {*</option>*}
                    {*{foreach $category_name as $key=>$val}*}
                    {*<option value="{$key}">&nbsp;&nbsp;&nbsp;--{$val}</option>*}
                    {*{/foreach}*}
                    {*</select>*}


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
                    {*{if $value['update_status'] == 2}*}
                    {*{$value['product_name']}*}
                    {*<span class="label label-warning">审核中</span>*}
                    {*{elseif $value['status'] == 1}*}
                    {*{$value['product_name']}*}
                    {*{else}*}
                    {*{$value['product_name']}*}
                    {*{/if}*}
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
                    {*{elseif $value['update_status']==-1}*}
                    {*<span class="label label-danger">已删除</span>*}
                    {*{elseif $value['update_status']==-2}*}
                    {*<span class="label label-danger">已彻底删除</span>*}
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
                    {*<div  class="reason-text" style="display: inline">拒绝理由：</div>*}
                    <a class="btn btn-danger btn-xs alertreason" style="width:60px;margin-left: 20px"
                       onclick="ListOperator.alertReason(this)" reason="{$value['refuse_reason']}"
                       style="margin-left: 0px;"><span class="look-reason">查看理由</span>
                    </a>
                {/if}
            </td>
            {*{if !empty($value['refuse_reason'])}*}
            {*<td style="position:relative!important;">*}
            {*<div  class="show-reason"></div>*}
            {*<div  class="reason-text" style="display: inline">拒绝理由：</div>*}
            {*<a class="btn btn-primary btn-xs alertreason" onclick="ListOperator.alertReason(this)" reason="{$value['refuse_reason']}" style="margin-left: 0px;"><span>查看</span>*}
            {*<i class="btn btn-primary btn-xs" style="width: 4px"></i><span>查看</span>*}
            {*</a>*}
            {*</td>*}
            {*{else}*}
            {*<td>无</td>*}
            {*{/if}*}
            <td>
                {*{if $value['update_status']<0}*}
                {*<a href="?action=detail&tab=product&id={$accountInfo['id']}&product_id={$value['id']}&handle_type=recover_product" class="btn btn-success btn-xs"><i class="fa fa-pencil"></i>恢复</a>*}
                {*{else}*}
                <a href="?action=detail&tab=product&id={$accountInfo['id']}&product_id={$value['id']}"
                   class="btn btn-primary btn-xs"><i class="fa fa-pencil"></i>修改</a>
                {if $value['status'] == 1}
                    <a class="btn btn-success btn-xs"
                       href="?action=detail&tab=schedule&id={$_REQUEST['id']}&product_id={$value['id']}">档期管理</a>
                {/if}
                {if  $value['update_status']!=3}
                    <a class="btn btn-success btn-xs"
                       href="?action=detail&tab=product&id={$_REQUEST['id']}&handle_type=caseshow&product_id={$value['id']}">案例</a>
                {/if}
                {*<a class="btn btn-primary btn-xs"*}
                {*href="?action=detail&tab=product&id={$_REQUEST['id']}&handle_type=remark&product_id={$value['id']}">修改备注</a>*}
                <a class="btn btn-success btn-xs"
                   href="#commission_update" data-toggle="modal" onclick="setProductCommission({$value['id']})">设置佣金</a>
                {*{$_REQUEST['id']}&product_id={$value['id']}*}
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
                $.post('?', {
                    product_id: product_id,
                    product_online: online,
                    tab: 'product',
                    action: 'detail',
                    id:{$accountInfo['id']}
                }, function (data) {
                    top.alert(data.msg);
                })
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
            $.post("?", {
                product_id: product_id,
                category_id: category_id,
                tab: 'product',
                action: 'detail',
                id:{$accountInfo['id']}
            }, function (data) {
                top.alert(data.msg);
                window.location.reload();
            });
        },
        delProduct: function (e) {

            if (!confirm('您确定要删除吗？？')) {
                return false;
            }
            var product_id = $(e).parents('tr').data('pid');
            $.get("?", {
                del: 1,
                product_id: product_id,
                tab: 'product',
                action: 'detail',
                id:{$accountInfo['id']}
            }, function (data) {
                top.alert(data.msg);
                if (data.status == 1) {
                    $(e).parents('tr').hide();
                }
            });
        },
        resetProduct: function (r) {
            if (!confirm('确定要重置此产品的所有信息吗？')) {
                return false;
            }
            var product_id = $(r).parents('tr').data('pid');
            $.post('?', {
                id:{$accountInfo['id']},
                product_id: product_id,
                action: 'detail',
                tab: 'product',
                handle_type: 'reset_product'
            }, function (data) {
                top.alert(data.msg);
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
            url: "?action=detail&tab=product&id={$_REQUEST['id']}&handle_type=commission_update",
            data: {
                product_id: pId
            },
            success: function (data) {
                $('.recommend_charges').val(data.data);
            }
        });
    }
    $('.commission_update_submit').on('click', function () {

        $.ajax({
            url: "?action=detail&tab=product&id={$_REQUEST['id']}&handle_type=commission_update",
            data: {
                product_id: $(".commission_update_id").val(),
                recommend_charges: $(".recommend_charges").val()
            },
            success: function (data) {
                top.alert(data.msg);
                $('#commission_update').modal('hide');

            }
        });
    })

</script>