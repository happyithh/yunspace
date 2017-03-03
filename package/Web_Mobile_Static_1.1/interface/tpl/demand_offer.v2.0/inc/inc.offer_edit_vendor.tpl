<div class="filling-cont-wrap">
    <div class="filling-cont">
        <div class="filling-select clearfix">
            <p class="icon icon-edt1"></p>
            <select name="product" onchange="operation.switchTags(this)">
                {foreach $data as $val}
                    <option value="{$val['id']}" {if $val['selected']==1}selected{/if}>{$val['item_name']}</option>
                {/foreach}
            </select>
        </div>
        <div class="fill-ipt">
            <input type="hidden" name="demand_id" value="{$demand_offer['demand_id']}">
            <input type="hidden" name="offer_id" value="{$demand_offer['id']}">
            <input type="hidden" name="result_id" value="{$result_id}">

            <div class="ipt-wrp">
                <p class="icon icon-edt3"></p>
                <input type="text" name="contact" placeholder="请输入联系人名称"
                       value="{if $offer['offer_info']['联系人']}{$offer['offer_info']['联系人']}{else}{mb_substr($data[0]['contacts'],0,4,'utf-8')}{/if}">
            </div>
            <div class="ipt-wrp">
                <p class="icon icon-edt4"></p>
                <input type="number" name='contact_phone' placeholder="请输入联系手机"
                       value="{if $offer['offer_info']['联系电话']}{$offer['offer_info']['联系电话']}{else}{$data[0]['phone']}{/if}">
            </div>
            <div class="ipt-wrp">
                <p class="icon icon-edt5"></p>
                <input type="number" name="quote"
                       placeholder="请输入场地报价" value="{$offer['offer_price']}"/>

                <div class="total-selt">
                    <span class="jiao"></span>
                    <select name="quote-unit">
                        {foreach $unit as $val}
                            <option {if $offer['offer_unit']==$val}selected{/if}>{$val}</option>
                        {/foreach}
                    </select>
                </div>
            </div>
            <div class="filling-mkt clearfix">
                {*<a class="icon-in" href=""></a>*}

                <p class="icon icon-edt2"></p>

                {*<div class="mkt">*}
                {*<p>为场地打个特色标签吧</p>*}
                {*</div>*}

                {foreach $data as $val}
                    <a TARGET="_blank"
                       href="?action=tags_edit&item_id={$val['id']}&result_id={$result_id}" {if $val['selected']==''} style='display: none'{/if}>
                        <div class="mkt hide"
                             data-item-id="{$val['id']}" {if $val['selected']==1} style='display: block;overflow:hidden;height:24px;'{/if}>
                            {if !empty($val['tags'])}
                                {foreach $val['tags'] as $kk =>$vv}
                                    <span style="color: rgb(36, 37, 47)">{$vv}</span>
                                {/foreach}
                            {else}
                                <span style="background: #FFF;color: #999">为场地打个特色标签吧</span>
                            {/if}
                        </div>
                    </a>
                    <a TARGET="_blank" class="icon-in "
                       href="?action=tags_edit&item_id={$val['id']}&result_id={$result_id}" {if $val['selected']==''} style='display: none'{/if}></a>
                {/foreach}

            </div>

            <div class="ipt-wrp">
                <p class="icon icon-edt6"></p>
                <textarea placeholder="其他备注" name="remark">{$offer['offer_info']['其他备注']}</textarea>
            </div>
        </div>
    </div>