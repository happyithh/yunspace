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
    <link href="style/css.css" rel="stylesheet"/>
    <style>
        @media (max-width: 768px) {
            .add {
                margin-top: 10px;
            }
        }
    </style>
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
                服务管理
            </h3>
            {if $vendor_status['is_first_check']}
                <div class="label label-warning">
                    <span style="font-size: 15px;">先完善下供应商、商品信息吧，先把亮点介绍下嘛~</span> <br>
                    &nbsp;ps：完善的信息提交审核通过后，信息才能出现在云space哦~
                </div>
            {/if}
            <div class="portlet">
                <div class="portlet-body">
                    <ul class="nav nav-pills">
                        <li>
                            <a href="space" class="btn {if $_REQUEST['mode']=='space'}btn-success{/if}">空间场地</a>
                        </li>
                        <li>
                            <a href="service" class="btn {if $_REQUEST['mode']=='service'}btn-success{/if}">配套服务</a>
                        </li>
                        <li>
                            <a href="recycle" class="btn {if $_REQUEST['mode']=='recycle'}btn-success{/if}">服务回收站</a>
                        </li>

                        <li>
                            <a href="set" class="btn {if $_REQUEST['mode']=='set'}btn-success{/if}">套餐列表</a>
                        </li>
                        <li>
                            <a href="set_recycle" class="btn {if $_REQUEST['mode']=='set_recycle'}btn-success{/if}">套餐回收站</a>
                        </li>

                    </ul>
                    <div>

                        {if $from_vendor_join !=1}
                            {if !$_REQUEST['mode'] || $_REQUEST['mode']=='space' || $_REQUEST['mode']=='service'}
                                {include file='inc/tab_service.tpl'}
                            {elseif $_REQUEST['mode']=='recycle'}
                                {include file='inc/tab_recycle.tpl'}
                            {elseif $_REQUEST['mode']=='set_recycle'}
                                {include file='inc/tab_set_recycle.tpl'}
                            {elseif $_REQUEST['mode']=='set'}
                                {include file="inc/tab_set.tpl"}
                            {/if}
                        {else}
                            {if !$_REQUEST['mode'] || $_REQUEST['mode']=='space' || $_REQUEST['mode']=='service'}
                                {include file='vendor_join_inc/tab_service.tpl'}
                            {elseif $_REQUEST['mode']=='recycle'}
                                {include file='inc/tab_recycle.tpl'}
                            {elseif $_REQUEST['mode']=='set_recycle'}
                                {include file='inc/tab_set_recycle.tpl'}
                            {elseif $_REQUEST['mode']=='set'}
                                {include file="vendor_join_inc/tab_set.tpl"}
                            {/if}
                        {/if}

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
    $(document).ready(function () {
        $('.service_content:gt(0)').hide();
        var hdw = $('.nav-pills li a');
        hdw.click(function () {
            var hdw_index = hdw.index(this);
            $('.service_content').eq(hdw_index).show()
                    .siblings().hide();
        });
    });
    ListOperator = {
        online: function (obj) {
            var online = $(obj).val();
            if ('{$_REQUEST['mode']}' == 'space') {
                var modes = "产品";
            }
            if ('{$_REQUEST['mode']}' == 'service') {
                var modes = "服务";
            }
            if (online == 0) {
                var msg = "下线";
            } else {
                var msg = "上线";
            }
            var rs = confirm("是否确定" + msg + "该" + modes + "？");
            if (rs == true) {
                var product_id = $(obj).parents('tr').data('pid');
                $.post('{$_route}product_edit/online', {
                    product_id: product_id,
                    product_online: online
                }, function (data) {
                    console.log(data);
                    if (data != 'success') {
                        alert('操作失败,可能是网络异常,请稍候再试!');
                    } else {
                        alert('更新' + modes + '状态成功');
                    }
                })
            } else {
                $(obj).find("option[value!='" + online + "']").attr("selected", true);
            }
        },
        refresh: function (obj) {
            var product_id = $(obj).parents('tr').data('pid');
            $.post('{$_route}product_edit/refresh', {
                product_id: product_id
            }, function (data) {
                if (data != 'success') {
                    alert('操作失败,4 小时内已刷新过!');
                } else {
                    $(obj).addClass('disabled');
                    $(obj).text('已刷新');
                    $(obj).unbind('click');
                }
            })
        },
        handle_product: function (obj) {
            var product_id = $(obj).parents('tr').data('pid');
            var product_status = $(obj).attr('data-status');
            if (product_status != 1) {
                if (product_status == -1) {
                    var msg = '确定要删除此产品吗？';
                } else if (product_status == -2) {
                    var msg = '确定要彻底删除此产品吗？此操作不可恢复！！';
                }
                if (confirm(msg)) {
                    ListOperator.post_product_status(product_id, product_status);
                } else {
                    return false;
                }
            } else {
                ListOperator.post_product_status(product_id, product_status);
            }
        },
        post_product_status: function (product_id, status) {
            $.post('{$_route}product_edit/delete_recover', {
                product_id: product_id,
                product_status: status
            }, function (data) {
                if (data != 'success') {
                    alert('操作失败,可能是网络异常,请重试!');
                } else {
                    window.location.reload();
                }
            })
        },
        setOnline: function (obj) {
            var online = $(obj).val();
            if (online == 0) {
                var msg = "下线";
            } else {
                var msg = "上线";
            }
            var rs = confirm("是否确定" + msg + "该套餐？");
            if (rs == true) {
                var set_id = $(obj).parents('tr').data('sid');
                $.post('{$_route}set_edit/online', {
                    set_id: set_id,
                    set_online: online
                }, function (data) {
                    console.log(data);
                    if (data.status != 1) {
                        alert(data.msg);
                    } else {
                        alert(data.msg);
                    }
                })
            } else {
                $(obj).find("option[value!='" + online + "']").attr("selected", true);
            }
        },
        post_set_status: function (set_id, status) {
            $.post('{$_route}set_edit/delete_recover', {
                set_id: set_id,
                set_status: status
            }, function (data) {
                if (data.status != 1) {
                    alert(data.msg);
                } else {
                    window.location.reload();
                }
            }, 'json')
        },
        setEdit: function (obj) {
            var set_id = $(obj).parents('tr').data('sid');
            var set_status = $(obj).attr('data-status');
            if (set_status != 1) {
                if (set_status == -1) {
                    var msg = '确定要删除此产品吗？';
                } else if (set_status == -2) {
                    var msg = '确定要彻底删除此产品吗？此操作不可恢复！！';
                }
                if (confirm(msg)) {
                    ListOperator.post_set_status(set_id, set_status);
                } else {
                    return false;
                }
            } else {
                ListOperator.post_set_status(set_id, set_status);
            }
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
</script>
{include 'Web_User_Center::inc/footer_inbox.tpl'}
{include 'Web_User_Center::inc/footer_script.tpl'}

</body>
</html>