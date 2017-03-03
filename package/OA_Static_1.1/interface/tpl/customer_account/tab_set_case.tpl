
<div class="portlet tabbable">
<div class="portlet-title">
    <div class="caption">
        <i class="fa fa-database"></i>案例详情

    </div>
    <div style="float:right">
    <a href="javascript:history.go(-1)" class="back"><
        <返回
    </a>
        </div>
</div>

<!--      ---------------------------案例活动  start-------------------------------      -->
    <div class="clear"></div>


                <form class="form-horizontal" role="form" action="{$_route}product_edit/submit" method="post">
                    <div class="form-group" >
                        <div class="col-md-10" >
                            <a class="btn btn-default btn-block"
                               href="#" onclick="addCaseUrl()"><i
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
                                {foreach $_case['rows'] as $ek=>$ev}
                                    {if $ev['id']}
                                        <tr>
                                            <td>{$ev['case_name']}</td>
                                            <td>{$ev['event_name']}</td>
                                            <td>{$ev['attr']['活动类型']}</td>
                                            <td>
                                                {$ev['attr']['服务行业']}
                                            </td>
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
                                                <a href="?action=detail&tab=set&id={$_REQUEST['id']}&handle_type=case&set_id={$_REQUEST['set_id']}&case_id={$ev['id']}"
                                                   class="btn btn-xs btn-info">编辑</a>
                                                {if $ev['status']==1}
                                                    <a href="javascript:;" class="btn btn-xs btn-danger delEvent" data-eid="{$ev['id']}"
                                                       data-status=0 onclick="EventCaseStatus.online(this)">删除</a>
                                                {elseif $ev['status']==0}
                                                    <a href="javascript:;" class="btn btn-xs btn-success delEvent"
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
                                    {if $_case['page']['dpll']}
                                        <li class="prev">
                                            <a href="{$_case['page']['dup']}1" title="First"><i
                                                        class="fa fa-angle-double-left"></i></a>
                                        </li>
                                        <li class="prev">
                                            <a href="{$_case['page']['dup']}{$_case['page']['dp']-1}"
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
                                    {for $i=$_case['page']['dpl'] to $_case['page']['dpr']}
                                        <li{if $i==$_case['page']['dp']} class="active"{/if}>
                                            <a href="{$_case['page']['dup']}{$i}">{$i}</a>
                                        </li>
                                    {/for}
                                    <li class="disabled">
                                        <a> {$_case['page']['dtp']}
                                            ( {$_case['page']['dp']*$_case['page']['dn']}
                                            /{$_case['page']['dt']}
                                            )</a></li>

                                    {if $_data['page']['dprr']}
                                        <li class="next">
                                            <a href="{$_case['page']['dup']}{$_case['page']['dp']+1}"
                                               title="Next"><i class="fa fa-angle-right"></i></a>
                                        </li>
                                        <li class="next">
                                            <a href="{$_case['page']['dup']}{$_case['page']['dtp']}"
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


<!--      ---------------------------案例活动  end  -------------------------------      -->
-->

</div>
<link rel="stylesheet" type="text/css" href="{$_assets}plugins/bootstrap-wysihtml5/bootstrap-wysihtml5.css"/>
<script type="text/javascript" src="{$_assets}plugins/bootstrap-wysihtml5/wysihtml5-0.3.0.js"></script>
<script type="text/javascript" src="{$_assets}plugins/bootstrap-wysihtml5/bootstrap-wysihtml5.js"></script>
<script>


    //案例
    EventCaseStatus = {
        online: function (obj) {
            var case_id = $(obj).attr('data-eid');
            var status = $(obj).attr('data-status');
            var set_id = {$_REQUEST['set_id']|default:0};

            if (status == 0) {
                var btn_message = '恢复';
                var online_message = '已删除';
                var online_message_class = 'btn btn-danger btn-xs';
                var online_status = 1;
                var online_class = 'btn btn-success btn-xs';
            } else if (status == 1) {
                var btn_message = '删除';
                var online_message = '已上线';
                var online_message_class = 'btn btn-success btn-xs';
                var online_status = 0;
                var online_class = 'btn btn-danger btn-xs';
            }
            $.post('?', {
                case_id: case_id,
                case_online: status,
                tab: 'set',
                id:{$accountInfo['id']},
                set_id: set_id,
                action: 'detail'
            }, function (data) {
                console.log(data);
                if (data != 'success') {
                    alert('操作失败,可能是网络异常,请稍候再试!');
                } else {
                    $(obj).text(btn_message);
                    $(obj).removeClass().addClass(online_class);
                    $(obj).parents('tr').find('td').eq(4).find('.online_message span').removeClass().addClass(online_message_class);
                    $(obj).parents('tr').find('td').eq(4).find('.online_message span').text(online_message);
                    $(obj).attr('data-status', online_status);
                }
            })
        }
    }
    function addCaseUrl() {

            location.href = "?action=detail&tab=set&id={$_REQUEST['id']}&handle_type=case&set_id={$_REQUEST['set_id']}";

    }

</script>
</script>