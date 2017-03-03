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
                   class="btn btn-success"><span class="glyphicon glyphicon-plus"></span>创建套餐</a>
            </div>
            {else}
            <div style=" margin-bottom: 10px;">
                <a href="?action=detail&tab=set&set_add=1&vendor_id={$accountInfo['vendors'][0]['id']}&id={$accountInfo['id']}"
                   class="btn btn-success"><span class="glyphicon glyphicon-plus"></span>创建套餐</a>
            </div>
            {/if}

        {/if}
        <div style="margin-bottom: 30px;">
            <form action="?action=detail&tab=set&id={$accountInfo['id']}" method="post" class="clearfix">
                <div class="form-body clearfix" style="padding-left: 0px">
                    <div class="form-group col-md-5" style="width:30%;padding-left: 0px">
                        <label class="col-md-3 control-label" style="width: 20%;padding-left: 0px;padding-right: 0px">套餐名称</label>

                        <div class="col-md-9" style="width: 70%;padding-left: 0px;margin-right: 0px">
                            <input type="text" class="form-control input-sm" placeholder="套餐ID / 名称" name="search[title]" value="">
                        </div>
                    </div>
                    <div class="form-group col-md-5" style="width:30%;padding-left: 0px;padding-right: 0px">
                        <label class="col-md-3 control-label" style="padding-right: 0px;margin-right: 0px;width: 20%;">套餐类型</label>

                        <div class="col-md-9" style="width: 70%;padding-left: 5px">

                            <select class="form-control input-sm" name="search[category_id]">*}
                                <option value="0">
                                不限
                                </option>
                                {foreach $category_name as $key=>$val}
                                <option value="{$key}">&nbsp;&nbsp;&nbsp;--{$val}</option>
                                {/foreach}
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
                {*<div class="form-actions">*}
                    {*<div class="" style="text-align: center">*}
                        {*<button type="submit" class="btn btn-primary" style="width: 150px">*}
                            {*<i class="fa fa-search"></i>*}
                            {*搜索*}
                        {*</button>*}
                    {*</div>*}
                {*</div>*}
            </form>
            {*{if $accountInfo['vendors'][0]['id']}*}
                {*<div style=" margin-bottom: 10px;">*}
                    {*<a href="?action=detail&tab=set&set_add=1&vendor_id={$accountInfo['vendors'][0]['id']}&id={$accountInfo['id']}"*}
                       {*class="btn btn-success"><span class="glyphicon glyphicon-plus"></span>创建套餐</a>*}
                {*</div>*}
            {*{/if}*}
        </div>
        <table class="table table-striped table-bordered table-hover" id="data_table" style="word-break: break-all">
            <thead>
            <tr>
                <th>套餐ID</th>
                <th>套餐名称</th>
                <th>套餐类型</th>
                <th>更新时间</th>
                <th>当前状态</th>
                {*<th style="width: 130px;">状态备注</th>*}
                <th>操作</th>
            </tr>
            {*<tr>*}
                {*<th>套餐ID</th>*}
                {*<th><form action="?action=detail&tab=set&id={$accountInfo['id']}" method="post" class="clearfix">*}
                        {*<div class="col-md-9">*}
                            {*<input type="text" class="form-control input-sm" placeholder="套餐ID/套餐名称" name="search[title]" value="">*}
                        {*</div>*}
                {*</th>*}
                {*<th><select class="form-control input-sm" name="search[category_id]">*}
                        {*<option value="0">*}
                            {*套餐类型*}
                        {*</option>*}
                        {*{foreach $category_name as $key=>$val}*}
                            {*<option value="{$key}">&nbsp;&nbsp;&nbsp;--{$val}</option>*}
                        {*{/foreach}*}
                    {*</select>*}
                {*</th>*}
                {*<th>更新时间</th>*}
                {*<th>当前状态</th>*}
                {*<th style="width: 130px;">状态备注</th>*}
                {*<th>操作<button type="submit" class="btn btn-primary" style="width: 115px;margin-left: 20px;">*}
                        {*<i class="fa fa-search"></i>搜索*}
                    {*</button>*}
                    {*</form></th>*}
            {*</tr>*}
            </thead>
            <tbody>
            {foreach $productInfo['rows'] as $key=>$value}
                <tr role="row" data-pid="{$value['id']}">
                    <td>#{$value['id']}</td>
                    <td><a href="{$_root}set_info/{md5($value['id'])}/{$value['id']}.html" style="text-decoration: none" target="_blank">
                            {*{if $value['update_status'] == 2}*}
                                {*{$value['set_name']}*}
                                {*<span class="label label-warning">审核中</span>*}
                            {*{elseif $value['status'] == 1}*}
                                {*{$value['set_name']}*}
                            {*{else}*}
                                {*{$value['set_name']}*}
                            {*{/if}*}
                            {$value['set_name']}
                        </a>
                    </td>
                    <td>
                        {$_categories[$value['category_id']]}
                    </td>
                    <td>{Func_Time::format($value['update_time'])}</td>
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
                            <a class="btn btn-danger btn-xs alertreason" style="width:60px;margin-left: 20px" onclick="ListOperator.alertReason(this)" reason="{$value['refuse_reason']}" style="margin-left: 0px;"><span class="look-reason">查看理由</span>
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
                        {if  $value['update_status']!=3}
                            <a class="btn btn-success btn-xs"
                               href="?action=detail&tab=set&id={$accountInfo['id']}&handle_type=caseshow&set_id={$value['id']}">案例</a>
                        {/if}
                        <a href="?action=detail&tab=set&id={$accountInfo['id']}&set_id={$value['id']}"
                           class="btn btn-primary btn-xs"><i class="fa fa-pencil"></i>修改</a>
                        {if  $value['update_status']!=3 && $value['update_status']==2}
                        <a class="btn btn-success btn-xs"
                           href="#commission_update"  data-toggle="modal" onclick="setProductSetCommission({$value['id']})">设置佣金</a>
                        <span onclick="ListOperator.delProductSet(this)" class="btn btn-danger btn-xs"><i
                                    class="fa fa-trash-o"></i>删除</span>
{/if}
                    </td>
                </tr>
            {/foreach}
            </tbody>
        </table>
    </div>
</div>

<div class="modal fade" id="commission_update" tabindex="-1" role="basic" aria-hidden="true" >
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
                <h4 class="modal-title" >
                    设置套餐推广成交佣金</h4>
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
            if(online==0){
                var msg = "下线";
            }else{
                var msg = "上线";
            }
            var rs = confirm("是否确定"+msg+"该套餐？");
            if(rs==true){
                var set_id = $(obj).parents('tr').data('pid');

                $.get('?', {
                    set_id: set_id,
                    product_online: online,
                    tab: 'set',
                    action: 'detail',
                    id:{$accountInfo['id']}
                }, function (data) {
                    top.alert(data.msg);
                })
            }else{
                $(obj).find("option[value!='"+online+"']").attr("selected",true);
            }
        },
        changeCategory: function (o) {
            var category_id = $(o).find('option:selected').val();
            var set_id = $(o).parents('tr').data('pid');
            if (!category_id) {
                category_id = $(o).find('option:first').val();
            }
            $.get("?", {
                set_id: set_id,
                category_id: category_id,
                tab: 'set',
                action: 'detail',
                id:{$accountInfo['id']}
            }, function (data) {
                if (data != 'success') {
                    alert('操作失败,可能是网络异常,请稍候再试!');
                } else {
                    window.location.reload();
                }
            });
        }, delProductSet: function (e) {
            if (!confirm('您确定要删除吗？？')) {
                return false;
            }
            var set_id = $(e).parents('tr').data('pid');
            $.get("?", {
                del: 1,
                set_id: set_id,
                tab: 'set',
                action: 'detail',
                id:{$accountInfo['id']}
            }, function (data) {
                top.alert(data.msg);
                if (data.status == 1) {
                    $(e).parents('tr').hide();
                }
            });
        },alertReason: function (o) {
//            var info=$(o).parent().find(".reason-text").text();
            var info=$(o).attr('reason');
            $(o).parent().find(".show-reason").text(info);
//            var height=$(o).parent().find(".show-reason").outerHeight();
            var height=$(o).parent().outerHeight();
            console.log(height);
            $(o).parent().find(".show-reason").css({
                top:height+"px"
            })
            if($(o).parent().find(".show-reason").hasClass("block")){
                $(o).parent().find(".show-reason").removeClass("block");
                $(".alertreason").find("span").text("查看理由");
            }else{
                $(o).parent().find(".look-reason").text("关闭");
                $(".show-reason").removeClass("block");
                $(o).parent().find(".show-reason").addClass("block");
            }
        }
    };
    function setProductSetCommission(setId){

        $(".commission_update_id").val(setId);

        $.ajax({
            url:"?action=detail&tab=set&id={$_REQUEST['id']}&is_commission=1",
            data:{
                set_id: setId
            },
            success:function (data){
                $('.recommend_charges').val(data.data);
            }
        });
    }
    $('.commission_update_submit').on('click',function (){

        $.ajax({
            url:"?action=detail&tab=set&id={$_REQUEST['id']}&is_commission=1",
            data:{
                set_id: $(".commission_update_id").val(),
                recommend_charges: $(".recommend_charges").val()
            },
            success:function (data){
                top.alert(data.msg);
                $('#commission_update').modal('hide');

            }
        });
    })
</script>