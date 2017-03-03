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
</head>
<body>
{include 'Web_User_Center::inc/header_top.tpl' color='#0b679e'}
<div class="clearfix"></div>
<div class="page-container">
    {include 'inc/header_nav.tpl' index=0}

    <div class="page-content-wrapper">
        <div class="page-content">
            <!-- BEGIN PAGE HEADER-->
            <h3 class="page-title">
                营销管理
            </h3>

            {if $is_first}
                <div class="label label-warning">
                    <span style="font-size: 15px;">先完善下供应商、商品信息吧，先把亮点介绍下嘛~</span> <br>
                    &nbsp;ps：完善的信息提交审核通过后，信息才能出现在云space哦~
                </div>
            {/if}
            <div class="portlet">

                <div class="portlet-body">
                    <ul class="nav nav-pills">
                        <li>
                            <a href="?mode=space"
                               class="btn {if !$_REQUEST['mode'] || $_REQUEST['mode']=='space'}btn-success{/if}">空间场地</a>
                        </li>
                        <li>
                            <a href="?mode=set" class="btn {if $_REQUEST['mode']=='set'}btn-success{/if}">套餐服务</a>
                        </li>
                        <li>
                            <a href="?mode=service"
                               class="btn {if $_REQUEST['mode']=='service'}btn-success{/if}">配套服务</a>
                        </li>
                    </ul>
                    <div>
                        <div class="service_content">
                            <div class="table_service_top container-fluid">
                                <div class="row" style="padding: 10px 0;">
                                    <div class="col-sm-4" style="padding: 0;">
                                        <form action="?">
                                            <div class="input-group">
                                                <input type="text" class="form-control" placeholder="ID / 名称"
                                                       name="search[title]" value="{$_REQUEST['search']['title']}">
                                                <span class="input-group-btn">
                                                <button class="btn btn-info" type="submit">
                                                    <i class="fa fa-search"></i>
                                                </button>
                                                </span>
                                            </div>
                                            {foreach $_REQUEST as $k=>$v}
                                                {if $k!=='search'}
                                                    <input type="hidden" name="{$k}" value="{$v}">
                                                {/if}
                                            {/foreach}
                                        </form>
                                    </div>
                                </div>
                            </div>
                            <div class="clear"></div>
                            <div class="table-responsive" style="border: 0px;">
                                <table class="table table-striped table-bordered table-advance table-hover table-service">
                                    <thead>
                                    <tr>
                                        <th>#ID</th>
                                        <th>服务名称</th>
                                        <th>服务类型</th>
                                        <th>点击次数</th>
                                        <th>推荐次数</th>
                                        {*<th>平台成交佣金</th>*}
                                        <th>推广成交佣金</th>
                                        {*<th>当前状态</th>*}

                                    </tr>
                                    </thead>
                                    <tbody>
                                    {foreach $data['rows'] as $k=>$v}
                                        <tr data-pid="{$v['pid']}">
                                            <td>
                                                {$v['pid']}
                                            </td>
                                            {if $_REQUEST['mode']=='set'}
                                                <td>{$v['set_name']}</td>
                                            {else}
                                                <td>{$v['product_name']}</td>
                                            {/if}
                                            <td>{$v['category_name']}</td>

                                            <td>{intval($v['counter_view'])}</td>
                                            <td>{intval($v['counter_marketing'])}</td>
                                            {*<td>{$v['platform_charges']|default:'10%'}</td>*}
                                            <td>
                                                <span>{intval($v['recommend_charges'])/100}</span>
                                                %
                                                <a href="javascript:;" class="market_edit btn btn-info btn-xs"
                                                   onclick="ListOperator.update_charges(this)">
                                                    设置
                                                </a>
                                            </td>
                                            {*<td>
                                                <select class="form-control" onchange="ListOperator.online(this)">
                                                    <option value="1" {if $v['status']} selected {/if}>
                                                        上线
                                                    </option>
                                                    <option value="0" {if !$v['status']} selected {/if}>
                                                        下线
                                                    </option>
                                                </select>
                                            </td>*}
                                        </tr>
                                    {/foreach}
                                    </tbody>
                                </table>
                            </div>
                            <div data-pid class="modal" id="myModal" tabindex="-1" role="dialog"
                                 aria-labelledby="myModalLabel" aria-hidden="true">
                                <div class="modal-dialog">
                                    <div class="modal-content">
                                        <div class="modal-header">
                                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                                <span aria-hidden="true">&times;</span>
                                            </button>
                                            <h4 class="modal-title" id="myModalLabel">
                                                设置推广成交佣金</h4>
                                        </div>
                                        <div class="modal-body">
                                            <div class="input-group">
                                                <input type="text" class="form-control" id="update_charges_input">
                                                <span class="input-group-addon">%</span>
                                            </div>
                                        </div>
                                        <div class="modal-footer">
                                            <button type="button" class="btn btn-default" data-dismiss="modal">
                                                取消
                                            </button>
                                            <button type="button" class="btn btn-success" {if $_REQUEST['mode']=='set'} onclick="productSetEditCommission()" {else}  onclick="productEditCommission()"{/if}>
                                                确定
                                            </button>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div>
                            <ul class="pagination">
                                {if $data['page']['dpll']}
                                    <li class="prev">
                                        <a href="{$data['page']['dup']}1" title="First"><i
                                                    class="fa fa-angle-double-left"></i></a>
                                    </li>
                                    <li class="prev">
                                        <a href="{$data['page']['dup']}{$data['page']['dp']-1}" title="Prev"><i
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
                                {for $i=$data['page']['dpl'] to $data['page']['dpr']}
                                    <li{if $i==$data['page']['dp']} class="active"{/if}>
                                        <a href="{$data['page']['dup']}{$i}">{$i}</a>
                                    </li>
                                {/for}
                                <li class="disabled">
                                    <a> {$data['page']['dtp']}
                                        ( {$data['page']['dp']*$data['page']['dn']}
                                        /{$data['page']['dt']}
                                        )</a></li>

                                {if $_data['page']['dprr']}
                                    <li class="next">
                                        <a href="{$data['page']['dup']}{$data['page']['dp']+1}" title="Next"><i
                                                    class="fa fa-angle-right"></i></a>
                                    </li>
                                    <li class="next">
                                        <a href="{$data['page']['dup']}{$data['page']['dtp']}" title="Last"><i
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

                    <!-- END BUTTONS PORTLET-->
                </div>
            </div>


        </div>
    </div>
</div>

<script type="text/javascript">
    ListOperator = {
        online: function (obj) {
            var online = $(obj).val();
            var product_id = $(obj).parents('tr').data('pid');
            $.post('{$_route}product_marketing/online', {
                product_id: product_id,
                product_online: online
            }, function (data) {
                if (data != 'success') {
                    alert('操作失败,可能是网络异常,请稍候再试!');
                }
            })
        },
        update_charges: function (obj) {
            $("#update_charges_input").data('obj', obj);
            $("#update_charges_input").data('pid', $(obj).parents('tr').data('pid'));
            $("#update_charges_input").val($(obj).prev().text());
            $('#myModal').modal('show');
        }
    };
    function productSetEditCommission() {
        $.post('{$_route}product_marketing/update_set_commission', {
            set_id: $("#update_charges_input").data('pid'),
            recommend_charges: $("#update_charges_input").val()
        }, function (data) {
            if (data.status == 1) {
                $('#myModal').modal('hide');
                var obj = $("#update_charges_input").data('obj');
                $(obj).prev().text($("#update_charges_input").val());
            }
            alert(data.msg);
        })
    }
    function productEditCommission() {
        $.post('{$_route}product_marketing/update_charges', {
            product_id: $("#update_charges_input").data('pid'),
            recommend_charges: $("#update_charges_input").val()
        }, function (data) {
            if (data == 'success') {
                $('#myModal').modal('hide');
                var obj = $("#update_charges_input").data('obj');
                $(obj).prev().text($("#update_charges_input").val());
            } else {
                alert('操作失败,可能是网络异常,请稍候再试!');
            }
        })
    }

</script>
{include 'Web_User_Center::inc/footer_inbox.tpl'}
{include 'Web_User_Center::inc/footer_script.tpl'}

</body>
</html>