<style>
    @media (max-width: 520px) {
        .list_none {
            display: none;
        }

        .table-responsive table tbody tr td {
            white-space: inherit !important;
        }
    }
</style>
<div class="portlet">
    <div class="portlet-body">

        <ul class="nav nav-tabs">
            <li class="{if $type=='all'}active{/if}">
                <a href="?type=all{if !empty($_REQUEST['search'])}&{$urls}{/if}">全部（{($total['3'])}）</a>
            </li>
            <li class="{if $type=='waiting'}active{/if}">
                <a href="?type=waiting{if !empty($_REQUEST['search'])}&{$urls}{/if}">未开始（{($total['0'])}
                    ）</a>
            </li>
            <li class="{if $type=='pass'}active{/if}">
                <a href="?type=pass{if !empty($_REQUEST['search'])}&{$urls}{/if}">已通过（{($total['1'])}）</a>
            </li>
            <li class="{if $type=='abandon'}active{/if}">
                <a href="?type=abandon{if !empty($_REQUEST['search'])}&{$urls}{/if}">已放弃（{($total['2'])}
                    ）</a>
            </li>
        </ul>
        <div class="portlet-body">
            <div class="tab-content clearfix">
                <div class="table-responsive">
                    <table class="table table-striped table-bordered">
                        <thead>
                        <tr>
                            <th class="list_none">创建时间</th>
                            <th class="list_none">场地编号</th>
                            <th class="list_none">场地名称</th>
                            <th class="list_none">场地类型</th>
                            <th class="list_none">城市</th>
                            <th class="list_none">联系人</th>
                            <th class="list_none">手机号</th>
                            <th class="list_none">邮箱</th>
                            <th width="10%">操作</th>
                        </tr>
                        </thead>
                        <tbody>
                        {foreach $_data['rows'] as $k=>$v}
                            <tr>
                                <td>{date('Y-m-d H:i:s',$v['create_time'])}</td>
                                <td class="list_none">{$v['id']}</td>
                                <td>{$v['space_name']}</td>
                                <td>{$categoryTree[112][$v['category_id']]}</td>
                                <td>{$v['city']}</td>
                                <td>{$v['contacts']}</td>
                                <td>{$v['phone']}</td>
                                <td>{$v['email']}</td>
                                <td>
                                    {if $v['status'] ==0}
                                    <a href="?action=details&space_id={$v['id']}"
                                       class="btn btn-danger btn-xs">审核</a>
                                    {elseif $v['status']==2}
                                        <a href="?action=details&space_id={$v['id']}"  class="btn btn-xs btn-default">已拒绝</a>
                                    {elseif $v['status'] ==1}
                                        <a href="?action=details&space_id={$v['id']}" class="btn btn-xs btn-info">已通过</a>
                                    {/if}
                                </td>
                            </tr>
                        {/foreach}
                        </tbody>
                    </table>
                </div>
                <div class="container-fluid">
                    <div class="row">
                        <div class="col-md-12" style="padding: 0px;">
                            <ul class="pagination">
                                {if $_data['page']['dpll']}
                                    <li class="prev">
                                        <a href="{$_data['page']['dup']}1" title="First"><i
                                                    class="fa fa-angle-double-left"></i></a>
                                    </li>
                                    <li class="prev">
                                        <a href="{$_data['page']['dup']}{$_waiting['page']['dp']-1}" title="Prev"><i
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
                                {for $i=$_data['page']['dpl'] to $_data['page']['dpr']}
                                    <li{if $i==$_data['page']['dp']} class="active"{/if}>
                                        <a href="{$_data['page']['dup']}{$i}">{$i}</a>
                                    </li>
                                {/for}
                                <li class="disabled">
                                    <a> {$_data['page']['dtp']}
                                        ( {$_data['page']['dp']*$_data['page']['dn']}
                                        /{$_data['page']['dt']}
                                        )</a></li>

                                {if $_data['page']['dprr']}
                                    <li class="next">
                                        <a href="{$_data['page']['dup']}{$_data['page']['dp']+1}" title="Next"><i
                                                    class="fa fa-angle-right"></i></a>
                                    </li>
                                    <li class="next">
                                        <a href="{$_data['page']['dup']}{$_data['page']['dtp']}" title="Last"><i
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
                </div>
            </div>
        </div>
    </div>
</div>



<div class="modal fade" id="basic" tabindex="-1" role="basic" aria-hidden="true" style="display: none;">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
                <h4 class="modal-title">
                    结束报价</h4>
            </div>
            <div class="modal-body">
            <input type="hidden" name="offer_id" id="offer_id" value="">
            <input type="hidden" name="demand_id" id="demand_id" value="">
                <table width="80%">
                    <tr>
                        <td>记录：
                        </td>
                        <td>
                            <select class="form-control input-sm demand_step " id="offer_status">
                                    <option value="4">完成</option>
                                    <option value="-1">关闭</option>
                            </select>
                        </td>


                    </tr>
                    <tr>
                        <td>
                            备注：
                        </td>
                        <td colspan="4">
                            <textarea class="form-control step_reason"
                                      rows="5"></textarea>
                        </td>
                    </tr>
                </table>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">
                    取消
                </button>
                <button type="button" class="btn btn-success end_offer" >
                    确定
                </button>
            </div>

        </div>
    </div>

</div>
<script src="{$_assets}plugins/jquery-1.11.0.min.js" type="text/javascript"></script>
<script src="{$_assets}plugins/bootstrap/js/bootstrap.min.js"
        type="text/javascript"></script>
{static "core/yunspace.js"}
{*<script src="js/demands/demands_change_select.js" type="text/javascript"></script>
*}{**}
<script>
    $(".receive_offer").click(function(){
        //添加到
        var o=$(this);
        var offer_id = o.attr('offer_id');
        var demand_id = o.attr('demand_id');
        console.log(offer_id,demand_id);
        $.ajax({
            type: "GET",
            url: "http://{Core::$urls['host']}/static/api/demand/offer/check/offer/admin.json",
            data: 'offer_id='+offer_id+'&demand_id='+demand_id,
            dataType: "json",
            success: function(data){
                if(data.status==1){
                    o.addClass('hide');
//                    o.siblings().addClass('hide');
                    top.alert('  领取成功');
                }else{
                    top.alert(data.msg);
                }
            }
        });
    });
    $(".released").click(function(){
        //添加到
        var o=$(this);
        var offer_id = o.attr('offer_id');
        var demand_id = o.attr('demand_id');
//        console.log(offer_id,demand_id);
        $.ajax({
            type: "GET",
            url: "http://{Core::$urls['host']}/static/api/demand/offer/check/offer/admin.json",
            data: 'offer_id='+offer_id+'&demand_id='+demand_id+'&type=1',
            dataType: "json",
            success: function(data){
                if(data.status==1){
                    o.parent().parent().remove();
//                    o.siblings().addClass('hide');
                    top.alert('  释放成功');
                }else{
                    top.alert(data.msg);
                }
            }
        });
    });
    $(".complete").click(function(){
        var o=$(this);
        var offer_id = o.attr('offer_id');
        var demand_id = o.attr('demand_id');
        if(offer_id==''){
            top.alert('参数错误');
            return false;
        }
        $("#offer_id").val(offer_id);
        $("#demand_id").val(demand_id);
    });
    $(".end_offer").click(function(){
        //添加到
        var offer_id =  $("input[name=offer_id]").val();
        var demand_id = $("input[name=demand_id]").val();
        var offer_status = $("#offer_status").val();
        var reason = $(".step_reason").val();
        $.ajax({
            type: "GET",
            url: "http://{Core::$urls['host']}/static/api/demand/offer/check/offer/admin.json",
            data: 'offer_id='+offer_id+'&demand_id='+demand_id+'&offer_status='+offer_status+'&reason='+reason+'&type=2',
            dataType: "json",
            success: function(data){
                if(data.status==1){
                   $("#basic").css('display','none');
                    $("#basic").removeClass('in');
                    $(".modal-backdrop").removeClass('in');
//                    o.siblings().addClass('hide');
                    top.alert('  结束成功');
                    location.reload();
                }else{
                    top.alert(data.msg);
                }
            }
        });
    });
</script>
