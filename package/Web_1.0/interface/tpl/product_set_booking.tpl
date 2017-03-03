<!DOCTYPE html>
<html>
<head>
    {include file="inc/html_head.tpl"}
    <link href="css/package_booking.css" rel="stylesheet">
</head>
<body>
{include file="inc/header_nav1.tpl"}
<div class="content">
    <div class="wrap clearfix">
        <h5 class="order">{if $page->info['attr_index']['城市']}{$page->info['attr_index']['城市']}{else}{$_COOKIE['city']} {/if}
            > 套餐预定 >
            套餐名称：<span>{$page->info['set_name']}</span></h5>

        <div class="order_name">
            <div class="order_pic">
                {if $page->info['logo']}
                    <img src="{Page_Site_Global::displayMedia($page->info['logo'],200,170)}"/>
                {else}
                    <img src="img/s_logo.jpg"/>
                {/if}
            </div>
            <div class="order_left">
                <p class="order_title">{$page->info['set_name']}</p>

                <p class="order_tag">
                    地址：{if $page->info['addr']}{$page->info['addr']}{else}{$_COOKIE['city']} {/if}</p>

                <p class="order_tag">
                    类别：{$page->info['category_name']}</p>

                <p class="order_tag">
                    人数：{$page->info['attr_index']['人数']}
                    人</p>

                <p class="order_tag">
                    天数：{$page->info['attr_index']['天数']} </p>

                <p class="order_tag">
                    有效期：{$page->info['attr_index']['开始时间']}
                    至 {$page->info['attr_index']['结束时间']}</p>

                <p class="order_price">
                    ¥{$page->info['detail']['套餐价']}
                    {if $page->info['detail']['计价单位']}
                        /{$page->info['detail']['计价单位']}
                    {/if}
                </p>
            </div>
            <div class="order_right">
                <p class="order_information">
                    预定信息({$page->info['version']})</p>
                {if $page->info['detail']['市场价']}
                    <p class="order_type">
                        <span>市场价</span>
                        <span>
                            ¥{$page->info['detail']['市场价']}
                            {if $page->info['detail']['计价单位']}
                                /{$page->info['detail']['计价单位']}
                            {/if}
                        </span>
                    </p>
                {/if}
                <p class="order_type">
                    <span>优惠价：¥ {$page->info['detail']['套餐价']}
                        {if $page->info['detail']['计价单位']}
                            /{$page->info['detail']['计价单位']}
                        {/if}
                    </span>
                    {if $page->info['detail']['市场价']}
                        <span>{intval($page->info['detail']['套餐价']/$page->info['detail']['市场价']*100)/10}
                        折</span>
                    {/if}
                </p>
            </div>
            <div class="clearfix"></div>

        </div>
        <div class="booking_step1  wrap">
            <ul class="clearfix">
                <li class="active_order">
                    <span class="active_span">1</span>

                    <p class="active_p">预定下单</p>
                </li>
                <li>
                    <span>2</span>

                    <p>订单审核</p>
                </li>
                <li>
                    <span>3</span>

                    <p>交易签约</p>
                </li>
                <li>
                    <span>4</span>

                    <p>活动进行</p>
                </li>
                <li>
                    <span>5</span>

                    <p>订单结算</p>
                </li>
            </ul>
        </div>
        <form action="product_set_booking_submit" method="post">
            <input type="hidden" name="id" value="{$_REQUEST['id']}">
            <div class="s_left   fl booking">
                <div class="s_left_c mt0">
                    {if $page->info['detail']['计价单位']}
                        <div class="order_t">
                            <i class="fa fa-pencil"></i>&nbsp;&nbsp;填写数量
                        </div>
                        <div class="form-inline" style="border-top: none; margin-top: 10px;">
                            <div class="form-group" style=" float:left; width: 300px;">
                                <span class="titp" style="text-align: left;font-size: 15px;">预订数量：</span>

                                <div class="input-group">
                                    <input class="form-control" name="data[order_number]" placeholder="请填写预订数量">
                                    <div class="input-group-addon">{$page->info['detail']['计价单位']}</div>

                                </div>
                            </div>
                            <div style="line-height: 36px; float: left;">
                                (可预订数量范围为：{$page->info['detail']['计价下限']}{$page->info['detail']['计价单位']} ~ {$page->info['detail']['计价上限']}{$page->info['detail']['计价单位']})
                            </div>
                        </div>
                        <div class="clearfix"></div>
                    {/if}
                    {if $page->info['schedule_product_id']}
                        <div class="order_t" style="margin-top: 20px;">
                            <i class="fa fa-calendar"></i>&nbsp;&nbsp;选择档期
                        </div>
                        {include file="inc/booking_schedule_set.tpl"}
                    {/if}
                    <div class="form-horizontal" style="border-top: none; margin-top: 10px;">
                        <div class="form-group">
                            <label for="inputEmail3" class="col-sm-2 control-label" style="text-align: left;">备注：</label>

                            <div class="col-sm-10">
                                <textarea class="form-control" rows="3" name="data[memo]"></textarea>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="s_right fr">
                <div class="order_t">
                    <i class="fa fa-file-text-o"></i>&nbsp;&nbsp;订单信息
                </div>
                <div class="border1 bpb order_content">
                    <div class="row">
                        <div class="col-sm-4 order_content_topic">
                            商品名称：
                        </div>
                        <div class="col-sm-8">
                            <a href="{$_root}set_info/{$page->id}.html" class="order_content_main">{$page->info['set_name']}</a>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-sm-4 order_content_topic">
                            供&nbsp;应&nbsp;商&nbsp;：
                        </div>
                        <div class="col-sm-8">
                            <a href="{$_root}vendor_info/{$page->vendorInfo['id']}.html" class="order_content_main">{$page->vendorInfo['vendor_name']}</a>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-sm-4 order_content_topic">
                            采&nbsp;购&nbsp;方&nbsp;：
                        </div>
                        <div class="col-sm-8">{$smarty.session.user.fullname}</div>
                    </div>
                    <div class="row">
                        <div class="col-sm-4 order_content_topic">
                            订单金额：
                        </div>
                        <div class="col-sm-8">
                            ¥{$page->info['detail']['套餐价']}</div>
                    </div>
                    <div class="row">
                        <div class="col-sm-4 order_content_topic">
                            合同详情：
                        </div>
                        <div class="col-sm-8">
                            <a href="#" class="order_content_main" data-toggle="modal" data-target=".bs-example-modal-lg">套餐签约合同</a>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-sm-4 order_content_topic">
                            咨询投诉：
                        </div>
                        <div class="col-sm-8">
                            <a href="tel:400-056-0599">400-056-0599</a>
                        </div>

                    </div>


                    <button type="submit" class="btn btn_order">
                        提交预定订单
                    </button>
                    <div class="checkbox clause">
                        <label style="line-height: normal;">
                            <input type="checkbox" name="data[agreement]" value="1">我已阅读<a href="#" data-toggle="modal" data-target=".bs-example-modal-lg">
                                《云空间超值套餐服务协议》</a>
                        </label>
                    </div>
                    <div class="modal fade bs-example-modal-lg" tabindex="-1" role="dialog" aria-labelledby="myLargeModalLabel" aria-hidden="true">
                        {include file="inc/product_set_agreement.tpl"}
                    </div>
                </div>
        </form>
    </div>
</div>
{include file="inc/html_footer.tpl"}
</body>
</html>