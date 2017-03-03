<!DOCTYPE html>
<html lang="en">
<head>
    {include "Web_Mobile_Static::site_management/inc.meta.tpl"}
    <link rel="stylesheet" href="plugins/font-awesome/css/font-awesome.min.css">
    {static "v1.0/global.css"}
    {static "site_management/schedule_info_show.css"}
    {static "site_management/footer.css"}
    {static "v1.0/data-picker.css"}
</head>
<body>
<div class="schedule_info"  yun="site_management/schedule_show.js::init">
    {*<section class="schedule_info_panel">{include "Web_Mobile_Static::site_management/inc.schedule_info_show.tpl"}</section>*}
    <section class="schedule_info_panel">
        <header class="schedule_show_header clear_float">
            <div class="left">
                <a href="javascript:window.history.back();" data-panel="1" class="panel_change"><span class="icon-chevron-left"></span></a>
            </div>
            <div class="center">
                <span>新建订单</span>
            </div>
            {*<div class="right">*}
            {*<a href="javascript:;">修改</a>*}
            {*</div>*}
        </header>

        <section class="schedule_show_content">
            <form action="">
                <div  data-validate="true" class="site_info_change">
                    <table>
                        <tbody>
                        <!--此处为订单需求表的id，用来区分是修改数据，还是新增数据-->
                        <input type="hidden" id="demand_product_id" value="{$_data['id']}">
                        {*<tr>*}
                            {*<td>订单时间</td>*}
                            {*<td>2015-10-20 16：20：11</td>*}
                            {*<td>{date('Y-m-d H:i:s',$_data['demand_time'])}</td>*}
                        {*</tr>*}
                        <tr>
                            <td>订单状态</td>
                            <td>
                                <select name="status" id="" class="state_select">
                                    {*<option value="">已预订</option>*}
                                    {*<option value="">未预定</option>*}
                                    {*<option value="">有意向</option>*}
                                    {foreach $status as $k=>$v}
                                        <option {if {$_data['status']}==$k}selected{/if} value="{$k}">{$v}</option>
                                    {/foreach}
                                </select>
                            </td>
                        </tr>
                        <tr>
                            <td>活动日期</td>
                            <td>
                                <div class="act_time">
                                    <input type="text" class="datePicker" placeholder="开始时间(必填)" name="activity_start_time" value="{$_data['activity_start_time']}" required readonly
                                           data-validate="true" data-error="请填写完整的活动时间">
                                    {*<input type="date" name="user_date" class="datePicker"/>*}
                                </div>
                                <span class="icon-chevron-right to"></span>
                                <div class="act_time">
                                    <input type="text" class="datePicker" placeholder="结束时间(必填)" name="activity_end_time" value="{$_data['activity_end_time']}" required readonly
                                           data-validate="true" data-error="请填写完整的活动时间">
                                </div>

                            </td>
                        </tr>
                        <tr>
                            <td>空间场地</td>
                            <td>
                                <!--item_info包括item_id,值为$k; item_name,值为$v-->
                                <select name="item_info" id="" class="state_select">
                                    {*<option value="" checked>云Space宝山秀场平日版</option>*}
                                    {foreach $item_info as $k=>$v}
                                        <option {if $_data['item_id']==$k}selected{/if} value="{$k}">{$v}</option>
                                    {/foreach}
                                </select>
                            </td>
                        </tr>
                        <tr>
                            <td>场地租金</td>
                            <td  class="clearfix">
                                <div style="width:95%">
                                    ￥<input type="number" class="normal_input" placeholder="请填写租金价格" name="detail['price']" value="{$_data['detail']['price']}" id="detail_price">
                                    {*<input type="number" class="normal_input" placeholder="天数" name="detail['per_price']" value="{$_data['detail']['per_price']}" style="width:40px;" id="day">*}
                                    <select name="detail['per_price']" id="day" class="state_select normal_input fr"  style="width:80px;height:40px">
                                        {foreach $per_price as $k=>$v}
                                            <option value="{$v}">{$v}</option>
                                        {/foreach}
                                    </select>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td>其他费用</td>
                            <td  class="clearfix">
                                <div style="width:95%">
                                ￥<input type="number" class="normal_input" placeholder="请填写其他费用" name="detail['other_price']" value="{$_data['detail']['other_price']}" id="detail_other_price">
                                {*<input type="number" class="normal_input" placeholder="天数" name="detail['per_other_price']" value="{$_data['detail']['per_other_price']}" style="width:40px;" id="other_day"></td>*}
                            <select name="detail['per_other_price']" id="other_day" class="state_select normal_input fr"  style="width:80px;height:40px">
                                {foreach $per_other_price as $k=>$v}
                                    <option value="{$v}">{$v}</option>
                                {/foreach}
                            </select>
                                 </div>

                            </td>
                        </tr>
                        <tr>
                            <td>活动名称</td>
                            <td><input type="text" class="normal_input long" placeholder="请填写活动名称（必填）" name="detail['活动名称']" value="{$_data['detail']['活动人数']}" required
                                       data-validate="true" data-error="请填写活动名称" id="act_name"></td>
                        </tr>
                        <tr>
                            <td>活动人数</td>
                            <td><input type="number" class="normal_input" id="act_person_num" placeholder="请填写人数" name="detail['活动人数']" value="{$_data['detail']['活动人数']}">人</td>
                        </tr>
                        <tr>
                            <td>活动类型</td>
                            <td>
                                <select name="detail['活动类型']" id="act_type" class="state_select">
                                    {*<option value="" checked>婚礼</option>*}
                                    {*<option value="">未预定</option>*}
                                    {*<option value="">有意向</option>*}
                                    {foreach $activity_type as $k=>$v}
                                        <option value="{$v}">{$v}</option>
                                    {/foreach}
                                </select>
                            </td>
                        </tr>
                        <tr>
                            <td>备注</td>
                            <td>
                                <textarea name="detail['活动备注']" id="act_other" cols="30" rows="10" class="normal_textarea" placeholder="请输入100字以内的文字描述" value="{$_data['detail']['活动备注']}"></textarea>
                            </td>
                        </tr>
                        </tbody>
                    </table>
                    <table>
                        <tbody>
                        <tr>
                            <td>订单来源</td>
                            <td>
                                <select name="from_where" id="" class="state_select">
                                    {*<option value="" checked>云Space</option>*}
                                    {*<option value="">未预定</option>*}
                                    {*<option value="">有意向</option>*}
                                    {foreach $from_where as $k=>$v}
                                        {*<option {if {$_data['from_where']}==$key}selected{/if} value="{$k}">{$v}</option>*}
                                        <option value="{$k}">{$v}</option>
                                    {/foreach}
                                </select>
                            </td>
                        </tr>
                        <tr>
                            <td>联系人</td>
                            <td><input type="text" class="normal_input" placeholder="姓名（必填）" id="act_user" name="demand['people']" value="{$_data['demand']['people']}" required
                                       data-validate="true" data-error="请填写真实姓名"></td>
                        </tr>
                        <tr>
                            <td>手机号码</td>

                            <td><input type="text" class="normal_input long" placeholder="请填写手机号码（必填）" id="act_phone" name="demand['phone']" {literal}pattern="(0|86|17951)?(13[0-9]|15[012356789]|17[678]|18[0-9]|14[57])[0-9]{8}"{/literal}
                                       value="{$_data['demand']['phone']}" required
                                       yun="form-validate/form-validate.js::typeValidate@keyup" data-error="请填写11位的手机号码" data-length="11"
                                       yun-type="phone"  yun-error="" data-validate="true"
                                       yun-style="fontSize:18px,position:absolute,right:35px,line-height:45px,color:#ff0000"></td>
                        </tr>
                        <tr>
                            <td>电子邮箱</td>
                            <td>
                                <input type="email" class="normal_input long" name="demand['email']" id="act_email" value="{$_data['demand']['email']}" placeholder="请填写邮箱">
                            </td>
                        </tr>
                        <tr>
                            <td>所属公司</td>
                            <td><input type="text" class="normal_input long" placeholder="请填写公司名称" name="demand['company']" id="act_company" value="{$_data['demand']['company']}"></td>
                        </tr>
                        <tr>
                            <td>客户类型</td>
                            <td>
                            {*<input type="text" class="normal_input long" name="demand['company_type']" id="act_type" placeholder="请填写公司类型" value="{$_data['demand']['company_type']}">*}
                            <select name="demand['company_type']" id="company_type" class="normal_input long" style="border: 0px;width:95%;background: none">
                                <option value="">请选择客户类型</option>
                                {foreach $company_type as $k=>$v}
                                    <option value="{$v}">{$v}</option>
                                {/foreach}
                            </select>
                            </td>
                        </tr>
                        </tbody>
                    </table>
                    <button class="change_btn"
                            data-save="1"  data-url="{$_root}m/site_management/">提交</button>
            </form>

        </section>
        <div class="date none" style="">
            <div yun="data-picker/js/date-picker.js::initPlugin" class="date-picker" yun-input=".datePicker"
                 yun-with-input="false" style="border:1px solid #888888;" yun-enabled="true"></div>
        </div>
        <div class="site_change_cover none"></div>
    </section>
</div>
{*{include "Web_Mobile_Static::site_management/inc.footer.tpl"}*}
{static "v1.0/jquery-1.11.1.min.js"}
{static "v1.0/velocity.js"}
{static "core/yunspace.js"}


</body>
</html>