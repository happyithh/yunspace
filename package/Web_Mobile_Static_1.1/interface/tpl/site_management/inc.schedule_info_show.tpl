<header class="schedule_show_header clear_float ">
    <div class="left">
        <a href="javascript: window.history.back();"><span class=" icon-chevron-left"></span></a>
    </div>
    <div class="center">
        <span>订单详情</span>
    </div>
    <div class="right">
        <a href="javascript:;" data-panel="1" class="panel_change">修改</a>
    </div>
</header>
<section class="schedule_show_content">
    <table>
        <tbody>
        <!--此处为订单需求表的id，用来区分是修改数据，还是新增数据-->
        <input type="hidden" id="demand_product_id" value="{$_data['id']}">
            <tr>
                <td>订单时间</td>
                <td>{date('Y-m-d H:i:s',$_data['demand_time'])}</td>
            </tr>
            <tr>
                <td>订单状态</td>
                <td>{if $_data['status']==1}有意向{elseif $_data['status']==2}已预订{elseif $_data['status']==3}签约流程中{elseif $_data['status']==4}已签协议{elseif $_data['status']==4}已取消{elseif $_data['status']==5}已取消{elseif $_data['status']==6}已结束{/if}</td>
            </tr>
            <tr>
                <td>活动日期</td>
                {*<td>2015/11/17--2015-11-18 共两天</td>*}
                <td>{date('Y/m/d',$_data['activity_start_time'])}--{date('Y/m/d',$_data['activity_end_time'])} 共{$_data['total_day']}天</td>
            </tr>
            <tr>
                <td>空间场地</td>
                {*<td>云Space宝山秀场平日版</td>*}
                <td>{$_data['item_name']}</td>
            </tr>
            <tr>
                <td>场地租金</td>
                {*<td>60000元/天</td>*}
                <td>{if $_data['detail']['price']==0}{else}{$_data['detail']['price']}元/{$_data['detail']['per_price']}{/if}</td>
            </tr>
            <tr>
                <td>其他费用</td>
                {*<td>30000元/天</td>*}
                <td>{if $_data['detail']['other_price']==0}{else}{$_data['detail']['other_price']}元/{$_data['detail']['per_other_price']}{/if}</td>
            </tr>
            <tr>
                <td>活动名称</td>
                {*<td>婚礼</td>*}
                <td><span style="color: #AAAAAA;">No.{$_data['demand_id']}&nbsp;&nbsp;</span>{$_data['detail']['活动名称']}</td>
            </tr>
            <tr>
                <td>活动人数</td>
                {*<td>500人</td>*}
                <td>{if $_data['detail']['活动人数']==0}{else}{$_data['detail']['活动人数']}{/if}</td>
            </tr>
            <tr>
                <td>活动类型</td>
                {*<td>婚礼</td>*}
                <td>{$_data['detail']['活动类型']}</td>
            </tr>
            <tr>
                <td>备注</td>
                {*<td>餐饮自</td>*}
                <td>{$_data['detail']['活动备注']}</td>
            </tr>
        </tbody>
    </table>
    <table>
        <tbody>
        <tr>
            <td>订单来源</td>
            {*<td>云pace</td>*}
            <td>{if $_data['from_where']==1}云SPACE{elseif $_data['from_where']==2}朋友介绍{elseif $_data['from_where']==3}老客户{elseif $_data['from_where']==4}媒体广告{elseif $_data['from_where']==5}其他渠道{/if}</td>
        </tr>
        <tr>
            <td>联系人</td>
            {*<td>王先生</td>*}
            <td>{$_data['demand']['people']}</td>
        </tr>
        <tr>
            <td>手机号码</td>
            {*<td>15002114175</td>*}
            <td>
                <a href="tel:{$_data['demand']['phone']}"><span class="phone  icon-phone"></span></a>
                {$_data['demand']['phone']}</td>
        </tr>
        <tr>
            <td>电子邮箱</td>
            <td>
                {*<span>1037359589@qq.com</span>*}
                <span>{$_data['demand']['email']}</span>

            </td>
        </tr>
        <tr>
            <td>所属公司</td>
            {*<td>上海星期网络科技公司</td>*}
            <td>{$_data['demand']['company']}</td>
        </tr>
        <tr>
            <td>客户类型</td>
            {*<td>广告公司</td>*}
            <td>{$_data['demand']['company_type']}</td>
        </tr>
        </tbody>
    </table>
</section>