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
    <p class="alert alert-info" style="margin-bottom: 0px;">目标每个报价给供应商发300条短信， 已发短信：<strong>{$_have_send_num}条</strong></p>
    <div class="progress">
        <div class="progress-bar progress-bar-success" role="progressbar" aria-valuenow="{round($_have_send_num/300,2)*100}" aria-valuemin="0" aria-valuemax="100" style="width: {round($_have_send_num/300,2)*100}%">
        </div>
    </div>

        <ul class="nav nav-tabs">
            <li {if $_REQUEST['type']==1 || !isset($_REQUEST['type'])}class="active" {/if}>
                <a href="?act=demand_offer&action=list_show&demand_id={$_demand['id']}&offer_id={$_offer_id}&type=1">精准匹配 {if $_result_list}({count($_result_list)}){elseif $_total['type_1']}({$_total['type_1']}){/if}</a>
            </li>
            <li class="{if $_REQUEST['type']==2}active{/if}">
                <a href="?act=demand_offer&action=list_show&demand_id={$_demand['id']}&offer_id={$_offer_id}&type=2">泛匹配 {($_total['type_2'])}</a>
            </li>
            {*<li class="{if $_REQUEST['type']==3}active{/if}">*}
                {*<a href="?act=demand_offer&action=list_show&demand_id={$_demand['id']}&offer_id={$_offer_id}&type=3">未激活子空间匹配 {($_total['type_3'])}</a>*}
            {*</li>*}
            <li class="{if $_REQUEST['type']==4}active{/if}">
                <a href="?act=demand_offer&action=list_show&demand_id={$_demand['id']}&offer_id={$_offer_id}&type=4">未激活{if $_REQUEST['type']==4 && isset($_data['page']['dt'])}{$_data['page']['dt']}{else}{{$_total['type_4']}}{/if} </a>
            </li>
            {*<li class="{if $type=='all'}active{/if}">*}
                {*<a href="?type=all{if !empty($_REQUEST['search'])}&{$urls}{/if}">全部（{($total['all'])}）</a>*}
            {*</li>*}
            {*<li class="{if $type=='done'}active{/if}">*}
                {*<a href="?type=done{if !empty($_REQUEST['search'])}&{$urls}{/if}">进行中（{($total['done'])}）</a>*}
            {*</li>*}
            {*<li class="{if $type=='end'}active{/if}">*}
                {*<a href="?type=end{if !empty($_REQUEST['search'])}&{$urls}{/if}">已完成（{($total['end'])}）</a>*}
            {*</li>*}
            {*<li class="{if $type=='abandon'}active{/if}">*}
                {*<a href="?type=abandon{if !empty($_REQUEST['search'])}&{$urls}{/if}">已关闭（{($total['abandon'])}*}
                    {*）</a>*}
            {*</li>*}
        </ul>
        {if $_REQUEST['type']==4}
            <div style="width: 85%;margin: 0 auto;" class="clearfix">
                <form action="?" method="get" style="margin-bottom:10px;padding: 0 20px 10px 0;border: 1px solid #ccc;">
                    <input type="hidden" name="act" value="demand_offer">
                    <input type="hidden" name="action" value="list_show">
                    <input type="hidden" name="demand_id" value="{$_demand['id']}">
                    <input type="hidden" name="offer_id" value="{$_offer_id}">
                    <input type="hidden" name="type" value="4">
                    <div  style="float: left;margin: 10px 10px 0 10px;">
                        <label style="width: 100px;float: left;margin-top: 5px;margin-left: 10px;">子空间名称：</label>
                        <input style="width:150px;float: left;"  type="text" class="form-control"  placeholder="" name="search_new[item_name]" value="{$_REQUEST['search_new']['item_name']}">
                    </div>
                    <div   style="float: left;margin: 10px 10px 0 10px;">
                        <span style="display: block;float: left;width: 80px;line-height: 30px;height: 30px;text-align: center;">价格区间：</span>
                        <div class="col-md-4 "  style="width: 130px;float: left;margin-left: 5px;padding: 0;">
                            <input type='text' class="form-control" placeholder="最低价" name="search_new[start_price]" value="{$_REQUEST['search_new']['start_price']}"/>
                        </div>
                        <div style="display: block;float: left;line-height: 30px;height: 30px;text-align: center;margin-left: 2px;">--</div>
                        <div class="col-md-4 " style="width: 130px;float: left;margin-left: 5px;padding: 0;">
                            <input type='text' class="form-control " placeholder="最高价" name="search_new[end_price]" value="{$_REQUEST['search_new']['end_price']}"/>
                        </div>
                    </div>
                    <div   style="float: left;margin: 10px 10px 0 10px;">
                        <span style="display: block;float: left;width: 80px;line-height: 30px;height: 30px;text-align: center;">场地类型：</span>
                        <div class="col-md-4 " style="width: 130px;float: left;margin-left: 5px;padding: 0;">
                            <select class="form-control" name="search_new[category_id]">
                                <option  value="">选择场地类型</option>
                                {foreach $_categories[112] as $ck=>$cv}
                                    <option {if $_REQUEST['search_new']['category_id'] == $ck}selected {/if} value="{$ck}">{$cv}</option>
                                {/foreach}
                            </select>
                        </div>
                    </div>
                    <div   style="float: left;margin: 10px 10px 0 10px;">
                        <span style="display: block;float: left;width: 80px;line-height: 30px;height: 30px;text-align: center;">面积大小：</span>
                        <div class="col-md-4 "  style="width: 130px;float: left;margin-left: 5px;padding: 0;">
                            <input type='text' class="form-control" placeholder="最小值" name="search_new[start_size]" value="{$_REQUEST['search_new']['start_size']}"/>
                        </div>
                        <div style="display: block;float: left;line-height: 30px;height: 30px;text-align: center;margin-left: 2px;">--</div>
                        <div class="col-md-4 " style="width: 130px;float: left;margin-left: 5px;padding: 0;">
                            <input type='text' class="form-control " placeholder="最大值" name="search_new[end_size]" value="{$_REQUEST['search_new']['end_size']}"/>
                        </div>
                    </div>
                    <input class="btn btn-info" type="submit"  name="submit" value="搜索" style="margin-top: 7px"/>
                </form>
            </div>
            <div class="clearfix"></div>
        {/if}
        <div class="portlet-body">
            <div class="tab-content clearfix">
                <div class="table-responsive">
                    <table class="table table-striped table-bordered">
                        <thead>
                        <tr>
                            <th>#ID</th>
                            <th class="list_none">子空间名称</th>
                            <th class="list_none">价格区间</th>
                            <th class="list_none">人数区间</th>
                            <th class="list_none">空间大小</th>
                            <th class="list_none">城市</th>
                            <th class="list_none">场地类型</th>
                            <th class="list_none">空间负责人</th>
                            <th class="list_none">联系电话</th>
                            {*<th>方案总数</th>*}
                           {if  isset($_REQUEST['type'])} <th width="8%">操作</th>{/if}
                        </tr>
                        </thead>
                        <tbody>
                        {include 'OA_Static::demand_offer/inc/demand_offer_search_result.inc.tpl' index=1}
                        {*{if $_result_list}*}
                            {*{foreach $_result_list as $k=>$v}*}
                                {*<tr>*}
                                    {*<td>{$v->id}</td>*}
                                    {*<td >{$v->item_name}</td>*}
                                    {*<td>{$v->price_down}--{$v->price_up}</td>*}
                                    {*<td>{$v->people_down}--{$v->people_up}</td>*}
                                    {*<td>{$v->city}</td>*}
                                    {*<td >{$v->contacts}</td>*}
                                    {*<td >{$v->phone}</td>*}
                                    {*<td class="red">{$v['scheme_sum']}</td>*}
                                    {*<td>*}
                                    {*<a href="?action=detail&id={$v['id']}"*}
                                    {*class="btn btn-info btn-xs">管理</a>*}
                                    {*</td>*}
                                {*</tr>*}
                            {*{/foreach}*}
                        {*{/if}*}
                        {*{if $_data['rows']}*}
                        {*{foreach $_data['rows'] as $k=>$v}*}
                            {*<tr>*}
                                {*<td>#{$v['id']}</td>*}
                                {*<td class="list_none">{$v['item_name']}</td>*}
                                {*<td>{$v['min_price']}--{$v['max_price']}</td>*}
                                {*<td>{$v['min_people']}--{$v['max_people']}</td>*}
                                {*<td>{$v['city']}</td>*}
                                {*<td>{$v['contacts']}</td>*}
                                {*<td class="list_none">{$v['phone']}</td>*}
                                {*<td class="red">{$v['scheme_sum']}</td>*}
                                {*<td>*}
                                    {*<a href="?action=detail&id={$v['id']}"*}
                                       {*class="btn btn-info btn-xs">管理</a>*}
                                {*</td>*}
                            {*</tr>*}
                        {*{/foreach}*}
                        {*{/if}*}
                        </tbody>
                    </table>
                </div>
                <div class="clearfix">
                    {if $_REQUEST['type']==1 }
                        <a class="btn btn-success  send_message_all" style="float: right;margin-right: 50px;" data-type="1" demand_id="{$_demand['id']}">全部发送</a>
                    {/if}
                    {if $_REQUEST['type']==2 }
                        <a class="btn btn-success  send_message_all" style="float: right;margin-right: 50px;" data-type="2" demand_id="{$_demand['id']}">全部发送</a>
                    {/if}
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
{*弹出层*}
<div class="modal fade" id="basic" tabindex="-1" role="basic" aria-hidden="true" style="display: none;width: 1200px;">
    <div class="modal-dialog">
        <div class="modal-content" style="width: 900px;margin-left: -200px;">
            <form action="?act=demand_offer&action=change_item_status" method="post" class="form_c" >
                <input type="hidden" class="form-control" name="demand_id" value="{$_demand['id']}" >
                <input type="hidden" class="form-control" name="offer_id" value="{$_offer_id}" >
                <input type="hidden" class="form-control" name="item_id" value="" >
                <input type="hidden" class="form-control" name="space_id" value="" >
                <input type="hidden" class="form-control submit_type" name="submit_type" value="" >
                <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true"></button>
                <h4 class="modal-title">子空间信息拓展</h4>
                </div>
                <div class="modal-body" >
                    <div class="tab-pane fade active in"style="width: 100%" >
                        <div class="table-responsive clearfix" style="width: 50%;float: left;">
                            <div class="col-md-12 form-group check_div">
                                    <a style="font-size: 16px;text-decoration: underline;" href=""  class="baidu_search" target="_blank">百度一下</a>&nbsp;
                                    <a style="font-size: 16px;text-decoration: underline;" href=""  class="baidu_map_search" target="_blank">百度地图搜索</a>&nbsp;
                                    <a style="font-size: 16px;text-decoration: underline;" href=""  class="gaode_map" target="_blank">高德地图搜索</a>
                            </div>
                            <div class="col-md-12 form-group check_div">
                                    <a style="font-size: 16px;text-decoration: underline;" href=""  class="addr_baidu_map_search" target="_blank">地址百度地图</a>&nbsp;
                                    <a style="font-size: 16px;text-decoration: underline;" href=""  class="addr_gaode_map" target="_blank">地址高德地图</a>
                            </div>
                            <div class="col-md-12 form-group">
                                <label class="control-label col-md-4" style="font-size: 15px;">百科名称
                                </label>

                                <div class="col-md-8">
                                    <input type="text" disabled class="form-control space_name" value="">
                                </div>
                                {*<label class="control-label col-md-3" style="font-size: 15px;">*}
                                    {*<a style="font-size: 16px;text-decoration: underline;" href=""  class="baidu_search" target="_blank">百度一下</a><br />*}
                                    {*<a style="font-size: 16px;text-decoration: underline;" href=""  class="baidu_map_search" target="_blank">百度地图搜索</a><br />*}
                                    {*<a style="font-size: 16px;text-decoration: underline;" href=""  class="gaode_map" target="_blank">高德地图搜索</a>*}
                                {*</label>*}
                            </div>
                            <div class="col-md-12 form-group check_div">
                                <label class="control-label col-md-4" style="font-size: 15px;">子空间名称</label>

                                <div class="col-md-8">
                                    <input type="text" class="form-control" value="" placeholder="子空间名称" name="item_name">
                                </div>
                                {*<label class="control-label col-md-3" style="font-size: 15px;">*}
                                    {*<a style="font-size: 16px;text-decoration: underline;" href=""  class="addr_baidu_map_search" target="_blank">地址百度地图</a><br />*}
                                    {*<a style="font-size: 16px;text-decoration: underline;" href=""  class="addr_gaode_map" target="_blank">地址高德地图</a>*}
                                {*</label>*}
                            </div>
                            <div class="col-md-12 form-group check_div">
                                <label class="control-label col-md-4" style="font-size: 15px;">手机号</label>

                                <div class="col-md-8">
                                    <input type="text" class="form-control" value="" placeholder="请输入有效手机号" name="phone">
                                    <span class="phone_msg"></span>
                                </div>
                            </div>
                            <div class="col-md-12 form-group">
                                <label class="control-label col-md-4" style="font-size: 15px;">邮箱</label>

                                <div class="col-md-8">
                                    <input type="text" class="form-control" value="" placeholder="请输入邮箱" name="email">
                                </div>
                            </div>
                            <div class="col-md-12 form-group">
                                <label class="control-label col-md-4" style="font-size: 15px;">联系人</label>

                                <div class="col-md-8">
                                    <input type="text" class="form-control" value="" placeholder="请输入联系人名称" name="contacts">
                                    <span class="help-block">(不填写默认为手机号)</span>
                                </div>
                            </div>
                            <div class="col-md-12 form-group check_div">
                                <label class="control-label col-md-4" style="font-size: 15px;">价格区间</label>

                                <div class="col-md-8">
                                    <div class="input-group input-range">
                                       <input type="text" class="form-control" name="min_price" placeholder="最低价" value="">
                                        <span class="input-group-addon"> ~</span>
                                        <input type="text" class="form-control" name="max_price" placeholder="最高价" value="">
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-12 form-group check_div">
                                <label class="control-label col-md-4" style="font-size: 15px;">人数范围</label>

                                <div class="col-md-8">
                                    <div class="input-group input-range">
                                        <input type="text" class="form-control" name="min_people" placeholder="最小人数" value="">
                                        <span class="input-group-addon"> ~</span>
                                        <input type="text" class="form-control" name="max_people" placeholder="最大人数" value="">
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-12 form-group">
                                <label class="control-label col-md-4" style="font-size: 15px;">场地面积</label>
                                <div class="col-md-6">
                                    <input type="text" class="form-control" value="" placeholder="请输入场地面积" name="size">
                                </div>
                                <label class="control-label col-md-2" style="font-size: 15px;">
                                    m<sup>2</sup>
                                </label>
                            </div>
                            <div class="col-md-12 form-group refuse_reason_text hidden" style="margin-bottom: 0;">
                                <label class="control-label col-md-4" style="font-size: 15px;">没有兴趣的理由</label>

                                <div class="col-md-8">
                                    <textarea class="form-control" rows="3" name="expand_refuse_reason"></textarea>
                                    <p class="control-label col-md-8" style="color: red;">
                                        请填写理由
                                    </p>
                                </div>

                            </div>
                        </div>
                        <div class="table-responsive save_more" style="width: 50%;float: left;">
                            <input name="space_id" id="save_id" value="" type="hidden">
                            <input name="old_space_name" id="old_space_name" value="" type="hidden">
                            <table class="table">
                                <thead>
                                <th colspan="2">保留场地百科<span style="color: #f3565d;">（*标记为重复的百科会被放入回收站）</span></th>
                                </thead>
                                <tr class="save_space_tr hide h_clone_a"  data-id="">
                                    <td class="save_space_td"></td>
                                    <td>
                                        <span class="save_space  hide">要保留的场地百科</span>
                                        <label for="repeat" class="note_repeat">
                                            <input id="repeat" type="checkbox" value="{$v['id']}" class="save_space_checkbox none" name="repeat_ids[]"><span class="save_space_text">标记为重复</span>
                                        </label>
                                        <label for="" class="note_repeat">
                                            <input id="repeat_item{$v['id']}" type="checkbox" value="{$v['id']}" class="save_item_checkbox none" name="repeat_items[]"><span class="save_item_text">标记为子空间</span>
                                        </label>
                                    </td>
                                </tr>
                                <tr class="hide h_clone_b">
                                    <td>
                                        <label>更改要保留的词条名称</label>
                                    </td>
                                    <td>
                                        <input type="text" class="form-control" id="space_name_new"  name="space_name">
                                    </td>
                                </tr>
                                <tbody  class="save_space_tbody">
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
                <div class="clearfix"></div>
                <div class="modal-footer" style="text-align: center;">
                    <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                    <button type="button" class="btn btn-danger refuse_reason_show " >没有兴趣</button>
                    <button type="button" class="btn btn-danger refuse_reason_button submit_form hidden" type_value="-3" >没有兴趣</button>
                    <button type="button" class="btn btn-success submit_form"  type_value="1">对平台和需求都有兴趣</button>
                    <button type="button" class="btn btn btn-info submit_form"  type_value="2">对平台有兴趣</button>
                </div>
            </form>
        </div>
    </div>
</div>