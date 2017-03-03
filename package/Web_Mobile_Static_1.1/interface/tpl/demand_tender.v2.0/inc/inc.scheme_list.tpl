{if $schemeList}
    {foreach $schemeList as $k=>$val}
        <li data-id="{$val['id']}" data-tender-id="{$val['tender_id']}">
            <div class="quote-needs-tit">
                <p>报价时间：<span>{$val['create_time']}</span></p>
            </div>
            <div class="quote-needs-cont clearfix">
                <a target="_blank" style="color: #24252f"
                   href="{$_root}{if $val['set_id']}set_info/{$val['set_id']}{else}service_info/{$val['product_id']}{/if}.html">
                    <div class="img">
                        <img src="{Page_Site_Global::displayMedia($val['product_logo'],200,200)}">

                        <p><span>￥{$val['quote']}</span></p>
                    </div>
                    <div class="cont">
                        <h2>{$val['product_name']}</h2>

                        <p><img src="img/demand_tender.v1.0/icon_01.png">城市：{$val['attr_index'][46]}</p>

                        <p><img src="img/demand_tender.v1.0/icon_02.png">地址：{$val['product_addr']}</p>
                        {if $val['product_size']}
                            <p><img src="img/demand_tender.v1.0/icon_03.png">面积：{$val['product_size']}m²</p>
                        {/if}
                    </div>
                    {if $val['其他备注']}
                        <p class="remarks quote-p">
                            <span class="tit">其他备注：</span><span class="ct">
                            {$val['其他备注']}
                        </span></p>
                    {/if}
                </a>
            </div>

            {if $val['status']==0}
                <div class="contact-sj-btn">
                    <input class="js-getnumb" data-tender-id="{$val['tender_id']}" data-scheme-id="{$val['id']}"
                           type="button" value="点击获得商家联系方式">
                </div>
            {else}
                <div class="contact-sj">
                    <p class="numb">联系商家：<span>{$val['scheme']['联系人']}-{$val['scheme']['联系电话']}</span></p>
                    <a class="icon-phone js-call-phone" href="javascript:void(0)" data-scheme-id="{$val['id']}"
                       data-tel="{$val['scheme']['联系电话']}">
                        <img src="img/demand_tender.v1.0/icon-phone-org.png"></a>
                </div>
            {/if}
        </li>
    {/foreach}
{/if}