<style>
    .step_content{ height: auto; overflow: hidden; background-color:#eee; padding: 2%; width: 96%; margin-top: 5px;
        display: none; word-break: break-all;}
</style>

<div class="portlet">
    <div class="portlet-body">
        {*<div class="portlet-title">*}
        {*<div class="caption">*}
        {*<i class="fa fa-database"></i>*}
        {*(当前共<a href="#"> {$_data['page']['dt']} </a>个需求)*}
        {*</div>*}
        {*</div>*}
        <ul class="nav nav-tabs">
            <li class="{if $type=='all'}active{/if}">
                <a href="?type=all{if !empty($urls)}&{$urls}{/if}">全部（{($total['all'])}）</a>
            </li>
            <li class="{if $type=='waiting'}active{/if}">
                <a href="?type=waiting{if !empty($urls)}&{$urls}{/if}">未开始（{($total['waiting'])}
                    ）</a>
            </li>
            <li class="{if $type=='done'}active{/if}">
                <a href="?type=done{if !empty($urls)}&{$urls}{/if}">进行中（{($total['done'])}）</a>
            </li>
            <li class="{if $type=='end'}active{/if}">
                <a href="?type=end{if !empty($urls)}&{$urls}{/if}">已完成（{($total['end'])}）</a>
            </li>
            <li class="{if $type=='abandon'}active{/if}">
                <a href="?type=abandon{if !empty($urls)}&{$urls}{/if}">已放弃（{($total['abandon'])}
                    ）</a>
            </li>
        </ul>
        <div class="portlet-body">
                <div class="table-responsive">
                    <table class="table table-striped table-bordered table-hover" id="data_table" style="word-break: break-all">
                        <thead>
                        <tr>
                            <th class="id" width="5%">#ssID</th>
                            <th class="list_none" width="5%">创建时间</th>
                            <th class="list_none" width="5%">活动名称</th>
                            <th width="8%">需求类型</th>
                            <th class="list_none" width="5%">联系人</th>
                            <th width="5%">城市</th>
                            <th width="8%">预算范围</th>
                            <th class="list_none" width="10%">具体要求</th>
                            <th class="admin" width="20%">负责人</th>
                            <th  width="10%">进度</th>
                            <th width="8%">操作</th>
                        </tr>
                        </thead>
                        <tbody>
                        {foreach $_data['rows'] as $k=>$v}
                            <tr data-id="{$v['id']}">
                                <td>#{$v['id']}
                                  {*  {if $v['offer_id']}
                                    <span class="btn-sm btn-primary" style="width: 50px;padding: 2px;">报价系统</span>
                                    {/if}
                                    {if $v['offer_status']}
                                        <span class="btn-sm btn-danger" style="width: 50px;padding: 2px;">
                                            {Data_Mysql_Table_Demand_Offer::$_status[$v['offer_status']]}</span>
                                    {/if}*}
                                </td>
                                <td class="list_none">{date('Y-m-d H:i',$v['create_time'])}</td>
                                <td class="list_none">{$v['demand_name']}</td>
                                <td >{$v['demand_type']}</td>
                                <td class="list_none contact">{$v['demand']['联系人']}</td>
                                <td >{$v['city']}</td>
                                <td >{$v['price_up']}至{$v['price_down']}</td>
                                <td class="list_none demand" style="width: 20%">{mb_substr($v['demand']['具体要求'],0,500,'utf-8')}</br>
                                    {if !empty($v['reason'])}
                                    {*<span class="step_reason1" >联系记录:{$v['reason']}</span>*}
                                    <span class="steprecord btn btn-default btn-xs" style="background-color: #89c4f4" data-demand_id="{$v['id']}" onclick="demand.demandStepRecord(this)">展开联系记录↓</span>
                                    <div class="step_content">联系记录详情</div>
                                    {/if}
                                </td>
                                <td class="admin" account-id={$v['response_account_id']}  data-sale={$v['sale_phone']} data-admin="{$v['admin_id']}">
                                    {if $v['sale_phone']}
                                         <span class="js_sale_info_show">
                                           {if $sale_name[$v['sale_phone']]['fullname']}
                                                {$sale_name[$v['sale_phone']]['fullname']}
                                           {else}
                                                {$v['sale_phone']}
                                           {/if}
                                           </span>
                                        {$is_clear=0}
                                    {elseif $v['response_account_id']}
                                            {foreach $admin_account as $val}
                                                {if $val['response_account_id']==$v['response_account_id']}
                                                    <span>{if $val['fullname']}{$val['fullname']}{else}{$val['username']}{/if}</span>
                                                {/if}
                                            {/foreach}
                                     {/if}
                                    {if $smarty.session.administrator.role_cache['sales/department_demand_lists_all'] || $smarty.session.administrator.role_cache['sales/department_demand_list_new'] || $smarty.session.administrator.role_cache['sales/team_demand_list_new']}
                                        <div class="search_sale_list" style="width: 100%;"></div>
                                    {elseif  0==$is_clear && !$is_my}<br>
                                        <div class="search_sale_list" style="width: 100%;"></div>
                                    {/if}
                                </td>
                                <td>
                                    {if $_step_funnel[$v['grab_step']]}
                                    <p class="step" demand-step="{$v['grab_step']}"> {$_step_funnel[$v['grab_step']]}</p>
                                    {/if}
                                </td>
                                <td>
                                    <a href="?action=demand_info&demand_id={$v['id']}&id={$v['contact_id']}&recommend_type=product_set"
                                                                            class="btn btn-info btn-xs">管理</a>
                                   <a data-id="{$v['id']}" href="#close_reason"  data-toggle="modal"
                                      onclick="demand.customerStepUpdate(this)" data-value="{$_step_funnel[$v['grab_step']]}" class="btn btn-primary btn-xs" {if $v['grab_step']==100}disabled{/if}>记录</a>

                                    <a data-phone="{$v['sale_phone']}" data-ids="{$v['id']}" onclick="demand.noticeAdmin(this)" class="btn btn-danger btn-xs"{if empty($v['sale_phone'])}disabled{/if}>提醒</a>

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
<div class="modal fade" id="close_reason" tabindex="-1" role="basic" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
                <h4 class="modal-title">
                    理由</h4>
            </div>
            <div class="modal-body">

                <table width="80%">
                    <tr>
                        <td>进度记录：
                        </td>
                        <td>
                            <select class="form-control  demand_step ">
                                {foreach $_step_funnel as $key=>$val}

                                    <option value="{$key}">{$val}</option>

                                {/foreach}
                            </select>
                        </td>


                    </tr>
                    <tr style="display: none" class="js-cols-reason">
                        <td>
                            关闭理由：
                        </td>
                        <td>
                           <label><input type="radio" name="reason" value="客户预算不足">客户预算不足</label><br/>
                            <label><input type="radio" name="reason" value="没有合适的场地推荐">没有合适的场地推荐</label><br/>
                            <label><input type="radio" name="reason" value="客户跳单">客户跳单</label><br/>
                            <label><input type="radio" name="reason" value="客户已经自己找到场地">客户已经自己找到场地</label><br/>
                            <label><input type="radio" name="reason" value="活动取消">活动取消</label><br/>
                            <label><input type="radio" name="reason" value="客户不再接听电话">客户不再接听电话</label><br/>
                            <label><input type="radio" name="reason" value="公关公司比稿失败">公关公司比稿失败</label><br/>
                            <label><input type="radio" name="reason" class="reason-other" value="2000">其他</label><br/>

                        </td>

                    </tr>
                    <tr class="js-reason">
                        <td>
                            备注：
                        </td>
                        <td colspan="4">
                            <textarea class="form-control step_reason"
                                      rows="5" placeholder="至少输入15个字"></textarea>
                        </td>
                    </tr>
                </table>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">
                    取消
                </button>
                <button type="button" class="btn btn-success" onclick="demand.demandStepReasonSubmit(this)">
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
<script src="js/demands_change_select.js" type="text/javascript"></script>
<script type="text/javascript"
        src="{$_assets}plugins/select2/select2.min.js"></script>
<script>
    $(".search_sale_list").select2({
            ajax: {
            url: 'http://' + window.location.host + "/static/api/administrator/getSaleDepartmentMember.json",
            dataType: 'json',
            data: function (term, page) {
                return {
                    q: term
                };
            },
            results: function (data, page) { // parse the results into the format expected by Select2.
                // since we are using custom formatting functions we do not need to alter remote JSON data
                return {
                    results: data.data
                };
            }
        },
        formatResult: formatRepo, // omitted for brevity, see the source of this page
        formatSelection: formatRepoSelection, // omitted for brevity, see the source of this page
        escapeMarkup: function (m) {
            return m;
        } // we do not want to escape markup since we are displaying html in results
    });
    function formatRepo(repo) {
        if (repo.loading) return repo.text;
        return repo.text;
    }
    function formatRepoSelection(repo) {
        return repo.name || repo.text;
    }
    $(".search_sale_list").on('change',function(){
        var _this =$(this);

        var phone  =  $(this).val();
        var _demand_id =$(this).parents('tr').data('id');
        var query = confirm('您确认您要将这个需求分配到这个销售吗？');
        if (!query) {
            return false;
        }
        YunSpace.api('grab/order/allot.jsonp', {
            action: 'allot_admin',
            demand_id: _demand_id,
            sale_phone: phone
        }, function (data) {
            if (data.status == 1) {
                top.alert(data.msg);
                var _selected_data = _this.select2("data");
                if (_selected_data.text != '分配负责人') {
                    console.log(_this.parents('td').siblings('span'));
                    _this.parents('td').children('.js_sale_info_show').html('<a href="?search[admin_id]=' + _selected_data.admin_id + '">' + _selected_data.text + '</a>');
                }
            } else {
                top.alert(data.msg);
            }
        })

    });
    $(".demand_step").on('change',function(){
       var step =$(this).val();
        if(step==-1 || step == -2){
                $(".js-cols-reason").show();
                $(".js-reason").hide();
        }else{
            $(".js-cols-reason").hide();
            $(".js-reason").show();
        }
    });

    $("input[name=reason]").on('change',function(){

       var reason_val =  $(this).val();
        if(reason_val==2000){
            $(".js-reason").show();
        }else{
            $(".js-reason").hide();
        }
    });
</script>
