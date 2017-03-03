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
            <h3 class="page-title" style="float: left;">
                活动案例

            </h3>
            <a href="javascript:history.go(-1)" class="back"><
                <返回
            </a>

            <div class="clear"></div>
            <div class="portlet">
                <div class="portlet-body">
                    <div class="service_content">
                        <form class="form-horizontal" role="form" action="{$_route}product_edit/submit" method="post">
                            <div class="form-group">
                                <div class="col-md-10">
                                    <a class="btn btn-default btn-block"
                                       href="{$_route}case_add?product_id={$_data['id']}&vendor_id={$_data['vendor_id']}"><i
                                                class=" fa fa-plus pr5"></i>添加案例</a>
                                    <table class="table table-striped table-bordered table-advance table-hover table-service">
                                        <thead>
                                        <tr>
                                            <th>案例名称</th>
                                            <th>活动名称</th>
                                            <th>活动类型</th>
                                            <th>行业标签</th>
                                            <th>当前状态</th>
                                            <th>操作</th>

                                        </tr>
                                        </thead>
                                        <tbody>
                                        {foreach $_event['rows'] as $ek=>$ev}
                                            {if $ev['id']}
                                                <tr>
                                                    <td>{$ev['case_name']}</td>
                                                    <td>{$ev['event_name']}</td>
                                                    <td>{$ev['attr']['活动类型']}</td>
                                                    <td>{$ev['attr']['服务行业']}</td>
                                                    <td>
                                <span class="online_message">
                                {if $ev['status']==2}
                                    <span class="label label-warning">审核中</span>

                                                                            {elseif $ev['status']==1}

                                    <span class="label label-success">已上线</span>

                                                                            {elseif $ev['status']==0}

                                    <span class="label label-danger">已删除</span>

                                                                            {elseif $ev['status']==3}

                                    <span class="label label-danger">审核未通过</span>
                                {/if}
                                </span>
                                                    </td>
                                                    <td>
                                                        <a href="{$_route}case_edit?product_id={$_data['id']}&case_id={$ev['id']}"
                                                           class="btn btn-xs btn-info">编辑</a>
                                                        {*<a href="javascript:;" target="_blank" class="btn btn-xs btn-danger delEvent" data-eid="{$ev['id']}">删除</a>*}
                                                        {if $ev['status']==1}
                                                            <a href="javascript:;"
                                                               class="btn btn-xs btn-danger delEvent"
                                                               data-eid="{$ev['id']}" data-status=0
                                                               onclick="EventCaseStatus.online(this)">删除</a>
                                                        {elseif $ev['status']==0}
                                                            <a href="javascript:;"
                                                               class="btn btn-xs btn-success delEvent"
                                                               data-eid="{$ev['id']}" data-status=1
                                                               onclick="EventCaseStatus.online(this)">恢复</a>
                                                        {/if}
                                                    </td>
                                                </tr>
                                            {/if}
                                        {/foreach}
                                        </tbody>
                                    </table>
                                    <div>
                                        <ul class="pagination">
                                            {if $_event['page']['dpll']}
                                                <li class="prev">
                                                    <a href="{$_event['page']['dup']}1" title="First"><i
                                                                class="fa fa-angle-double-left"></i></a>
                                                </li>
                                                <li class="prev">
                                                    <a href="{$_event['page']['dup']}{$_event['page']['dp']-1}"
                                                       title="Prev"><i class="fa fa-angle-left"></i></a>
                                                </li>
                                            {else}
                                                <li class="prev disabled">
                                                    <a href="#" title="First"><i
                                                                class="fa fa-angle-double-left"></i></a>
                                                </li>
                                                <li class="prev disabled">
                                                    <a href="#" title="Prev"><i class="fa fa-angle-left"></i></a>
                                                </li>
                                            {/if}
                                            {for $i=$_event['page']['dpl'] to $_event['page']['dpr']}
                                                <li{if $i==$_event['page']['dp']} class="active"{/if}>
                                                    <a href="{$_event['page']['dup']}{$i}">{$i}</a>
                                                </li>
                                            {/for}
                                            <li class="disabled">
                                                <a> {$_event['page']['dtp']}
                                                    ( {$_event['page']['dp']*$_event['page']['dn']}
                                                    /{$_event['page']['dt']}
                                                    )</a></li>

                                            {if $_data['page']['dprr']}
                                                <li class="next">
                                                    <a href="{$_event['page']['dup']}{$_event['page']['dp']+1}"
                                                       title="Next"><i class="fa fa-angle-right"></i></a>
                                                </li>
                                                <li class="next">
                                                    <a href="{$_event['page']['dup']}{$_event['page']['dtp']}"
                                                       title="Last"><i class="fa fa-angle-double-right"></i></a>
                                                </li>
                                            {else}
                                                <li class="next disabled">
                                                    <a href="#" title="Next"><i class="fa fa-angle-right"></i></a>
                                                </li>
                                                <li class="next disabled">
                                                    <a href="#" title="Last"><i
                                                                class="fa fa-angle-double-right"></i></a>
                                                </li>
                                            {/if}
                                        </ul>

                                    </div>
                                </div>
                            </div>
                        </form>
                    </div>
                </div>

                <!-- END BUTTONS PORTLET-->
            </div>
        </div>


    </div>
</div>
</div>
{include 'Web_User_Center::inc/html_form.tpl'}
{include 'Web_User_Center::inc/footer_inbox.tpl'}
{include 'Web_User_Center::inc/footer_script.tpl'}
<script>
    //删除活动
    EventCaseStatus =  {
        online : function(obj){
            var case_id=$(obj).attr('data-eid');
            var status=$(obj).attr('data-status');
            var product_id={$_REQUEST['product_id']|default:0};
           // alert(product_id);
            if(status==0){
                var btn_message='恢复';
                var online_message='已删除';
                var online_message_class='label label-danger';
                var online_status=1;
                var online_class='label label-success';
            }else if(status==1){
                var btn_message='删除';
                var online_message='已上线';
                var online_message_class='label label-success';
                var online_status=0;
                var online_class='label label-danger';
            }
            $.post('{$_route}product_edit/case_online',{
                case_id:case_id,
                case_online:status,
                product_id:product_id
            },function(data){
                if (data != 'success') {
                    alert('操作失败,可能是网络异常,请稍候再试!');
                }else{
                    $(obj).text(btn_message);
                    $(obj).removeClass().addClass(online_class);
                    $(obj).parents('tr').find('td').eq(4).find('.online_message span').removeClass().addClass(online_message_class);
                    $(obj).parents('tr').find('td').eq(4).find('.online_message span').text(online_message);
                    $(obj).attr('data-status',online_status);
                }
            })
        }
    }
</script>
</body>
</html>