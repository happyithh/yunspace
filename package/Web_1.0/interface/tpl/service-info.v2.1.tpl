<!DOCTYPE html>
<!DOCTYPE html>
<html>
<head>
    {include file="Web_Static::v2.0/html_goto_mobile.tpl" url="m/service_info/{$page->id}.html"}
    {include file="inc/html_head.tpl"}
    <link type="text/css" href="css/lrtk.css" rel="stylesheet"/>
    <link href="css/product.css?t=3" rel="stylesheet">
    <link href="css/fullcalendar.min.css" rel="stylesheet">
    <link href="css/jquery.fancybox.css" rel="stylesheet">
    <script type="text/javascript" src="js/jquery.jcarousel.min.js"></script>
    <script type="text/javascript" src="js/jquery.pikachoose.js"></script>
    <script type="text/javascript" src="js/jquery.touchwipe.min.js"></script>
    <script src='js/service_info.v2.js'></script>
    <style>
        .fc-basic-view .fc-body .fc-row {
            min-height: 2em !important;
            height: 35px !important;
        }

        .fc-toolbar .fc-center h2 {
            font-size: 18px;
            padding-top: 5px;
        }

        .fc-view-container {
            margin-top: 15px;
        }

        .map_button {
            cursor: pointer;
            padding: 5px;
        }
    </style>
</head>
<body data-city="{$page->productInfo['city']|default:$smarty.cookies.city}">
{include file="Web_Static::v2.0/html_header3.1.tpl"}

<div class="pto">
    <div class="product_top">
        <span class="back"><a href="javascript:history.go(-1)">
                &lt;返回</a></span>

        <p>
            {*<a href="{$_root}">{$smarty.cookies.city}*}
                {*></a>*}
            <a href="{$_root}">{$page->productInfo['city']|default:$smarty.cookies.city}
                ></a>
            {foreach $page->productInfo['parents'] as $k=>$v}
                {if $page->productInfo['is_space']}
                    <a href="{$_root}space/{$v}">
                        {$page->categoryInfo[$v][0]}
                        > </a>
                {else}
                    <a href="{$_root}service/{$v}">
                        {$page->categoryInfo[$v][0]}
                        > </a>
                {/if}
            {/foreach}
            <a href="javascript:;" class="product_name">{$page->productInfo['product_name']}</a>
        </p>

        <div class="product_top_left">
            <h2 style="float: left;">{$page->productInfo['product_name']}</h2>

            <div class="product_icon" style="margin-top: 25px;">
                <h5 class="icon">
                    <a data-url="{$_root}ajax_collect" class='collect' data-uid="{$smarty.session.user.id}" data-status
                       data-id="{$page->id}" data-type="space" href="javascript:;"><i
                                class="glyphicon glyphicon-heart-empty"></i>&nbsp;<span>加入收藏</span></a>
                </h5>
                {*<h5 class="icon" id="share">*}
                    {*<a onclick="showBox('{$_assets}')" href="javascript:;"><span class="fa fa-share-alt"></span>&nbsp;分享</a>*}
                {*</h5>*}
            </div>
            <div class="clearfix"></div>
            <div class="service_tab">
                <span>服务标签：</span>
                {foreach explode(',',$page->productInfo['attr_new'][Page_Site_Global::tagsName('适合活动类型')]) as $ak=>$av}
                    <a href="{$_root}space/{$page->productInfo['category_id']}?filter[{Page_Site_Global::tagsName('适合活动类型')}]={$av}">{$av}</a>
                {/foreach}
            </div>
            {if $page->productInfo['addr']}
                <div class="service_tab">
                    <span>地址：{$page->productInfo['addr']}</span>
                    <span class="btn btn-default btn-sm" data-toggle="modal" data-target="#openMap">查看地图</span>
                </div>
            {/if}
            <div class="clearfix"></div>
        </div>
        <div class="product_top_right">
            <h2 style="margin-top: 28px;height: 28px;">
                {if $page->productInfo['price'] >0}
                    <strong>
                        {if $_COOKIE['look_price_phone']}
                            <span>参考价格:</span>
                            ¥ {$page->productInfo['price']}
                            {if $page->productInfo['attr_new']['起价']}
                                <span style="font-size: 13px;color:#666 ">起</span>
                            {/if}
                            {if $page->productInfo['attr_new']['计价单位']}
                                /{$page->productInfo['attr_new']['计价单位']}
                            {/if}
                        {else}
                            <a class="look-price js-look-price" href="javascript:;">查看参考价</a>
                            <div class="hide ref-price">
                                 <span>参考价格:</span>
                                 ¥ {$page->productInfo['price']}
                                {if $page->productInfo['attr_new']['起价']}
                                    <span style="font-size: 13px;color:#666 ">起</span>
                                {/if}
                                {if $page->productInfo['attr_new']['计价单位']}
                                    /{$page->productInfo['attr_new']['计价单位']}
                                {/if}
                            </div>
                        {/if}
                    </strong>
                {else}
                    <span>参考价格:</span>面议
                {/if}
            </h2>


            <div class="button">
                {*<a href="{$_root}booking?id={$page->id}" class="btn-order">预定下单</a>*}
                {*<a href="{$_root}order_booking?id={$page->id}&booking_type=1" class="btn-order">预定下单</a>*}
                <a href="javascript:;" class="btn-order pre-booking" data-href="{$_root}booking?id={$page->id}">预定下单</a>
                <a data-toggle="modal" href="#openDemanAsk" ask_id="{$page->id}" ask_type="1"
                   class="btn btn-consult demandAsk">预约咨询</a>

                <div class="clear"></div>
            </div>
        </div>
        <div class="clearfix"></div>
        <div id="s_content_p">

        </div>
    </div>
</div>
<div class="product_head">
    <div class="product_head_content">
        <div class="phcl">
            <div class="tab_product">
                {foreach $page->productInfo['media'] as $mk=>$mv}
                    <div class="tab_product_item">
                        {$mk}（{count($mv)}）
                    </div>
                {/foreach}
            </div>
            {foreach $page->productInfo['media'] as $mk=>$mv}
                <div class="pikachoose">
                    <ul class="jcarousel-skin-pika">
                        {foreach $mv as $vv}
                            <li class="unactive">
                                {if $vv[2]}
                                    <a href="{$vv[2]}" class="imageBox videoBox" data-fancybox-group="gallery">
                                        <img src="{if $page->productInfo['create_by_quick']==3}{Page_Site_Global::displayMedia($vv[1],768,0,2,'thc')}{else}{Page_Site_Global::displayMedia($vv[1],768,0,2)}{/if}"
                                             title="{$info['attr']['城市']}{$info['product_name']}-{$info['attr']['基本信息>适合活动类型']}-{$vv[0]}"/>
                                    </a>
                                {else}
                                    <a href="{Page_Site_Global::displayMedia($vv[1],768,0,1)}" class="imageBox"
                                       data-fancybox-group="gallery">
                                        <img src="{if $page->productInfo['create_by_quick']==3}{Page_Site_Global::displayMedia($vv[1],768,0,1,'thc')}{else}{Page_Site_Global::displayMedia($vv[1],768,0,1)}{/if}"
                                             title="{$info['attr']['城市']}{$info['product_name']}-{$info['attr']['基本信息>适合活动类型']}-{$vv[0]}"/>
                                    </a>
                                {/if}
                            </li>
                        {/foreach}
                    </ul>
                </div>
            {/foreach}
        </div>
        <div class="phcr">
            <div class="s_logo">
                <a href="{$_root}vendor_info/{$page->vendorInfo['id']}.html">
                    {if $page->vendorInfo['logo']}
                        <input type="hidden" class="vendorCodeLogo"
                               src="{Page_Site_Global::displayLogo($page->vendorInfo['logo'],135,135)}">
                    {else}
                        <input type="hidden" class="vendorCodeLogo" src="{$_assets}img/logo_a.png">
                    {/if}

                    <img class="vendorlogo" src="{Page_Site_Global::displayLogo($page->vendorInfo['logo'],135,135)}">
                </a>
            </div>
            <div class="s_title">
                <a href="{$_root}vendor_info/{$page->vendorInfo['id']}.html">{$page->vendorInfo['vendor_name']}</a>
            </div>
            <div class="s_content">
                <p>
                    <span>服务评分：</span>{$page->vendorInfo['vendor_remarks']['内部评分']|default:'待定'}
                </p>
                {if $page->vendorInfo['attr']['城市']}
                    <p>
                        <span>服务区域：</span>{$page->vendorInfo['attr']['城市']}
                    </p>
                {/if}
                {if $page->vendorInfo['category_name']}
                    <p>
                        <span>服务类型：</span>{$page->vendorInfo['category_name']}
                    </p>
                {/if}
                {if $page->vendorInfo['attr']['公司规模']}
                    <p>
                        <span>公司规模：</span>{$page->vendorInfo['attr']['公司规模']}
                    </p>
                {/if}
                {if $page->vendorInfo['attr']['活动类型']}
                    <p>
                        <span>活动标签：</span>{$page->vendorInfo['attr']['活动类型']}
                    </p>
                {/if}
                {if $page->vendorInfo['attr']['服务行业']}
                    <p>
                        <span>行业标签：</span>{$page->vendorInfo['attr']['服务行业']}
                    </p>
                {/if}
            </div>
            <div class="c_button">
                <a href="{$_root}vendor_info/{$page->vendorInfo['id']}.html" class="btn c_b">查看供应商</a>
                {*<a href="{$_root}demand_submit/ask?id={$page->id}" class="btn c_b">预约咨询</a>*}
            </div>
        </div>
        <div class="clearfix"></div>
    </div>
</div>
<div class="wrap con">
    {*{var_dump($page->productInfo,$page->tags)}*}
    <div class="product_left">
        <div class="information">
            <ul>
                {foreach $page->tags as $tk=>$tv}
                    <li>
                        <div class="information_left">
                            {$tk}
                        </div>
                        <div class="information_right1">
                            {foreach $tv as $ttk=>$ttv}
                                {if $page->productInfo['attr_new'][$ttk]}
                                    <span><c>{$ttv['tags_name']}
                                            ：
                                        </c>{str_replace(',','、',$page->productInfo['attr_new'][$ttk])}</span>
                                {/if}
                            {/foreach}
                        </div>
                        <div class="clearfix"></div>
                    </li>
                {/foreach}
                <li>
                    <div class="information_left">
                        服务描述
                    </div>
                    <div class="information_right2">
                        {$page->productInfo['des']}
                    </div>
                    <div class="clearfix"></div>
                </li>
            </ul>
        </div>
        {if !$page->productInfo['is_video']&&$page->eventInfo['page']['dtp']>0}
            <div class="case">
                <div class="case_title">
                    <span class="glyphicon glyphicon-fire"></span>
                    活动案例
                </div>
                <ul>
                    {foreach $page->eventInfo['rows'] as $ek=>$ev}
                        <li>
                            <div class="case_left">
                                <a href="{$_root}event_info/{$ev['event_id']}.html">
                                    {if $ev['case_logo']}
                                        <img src="{$ev['case_logo']}">
                                    {elseif $ev['logo']}
                                        <img src="{$ev['logo']}">
                                    {else}
                                        <img src="img/s_logo.jpg">
                                    {/if}
                                </a>
                            </div>
                            <div class="case_right">
                                <p>
                                    <a href="{$_root}event_info/{$ev['event_id']}.html"> {$ev['case_name']|default:$ev['event_name']}</a>
                                </p>

                                <div class="case_des">{mb_substr(strip_tags($ev['des']),0,150,'utf-8')}
                                    ...
                                </div>
                            </div>
                            <div class="clearfix"></div>
                        </li>
                    {/foreach}
                </ul>
                {if $page->eventInfo['page']['dtp']>1}
                    <div class="page_product">
                        <ul class="pagination paging">
                            {if $page->eventInfo['page']['dpll']}
                                <a href="{$page->eventInfo['page']['dup']}1" title="First"><i
                                            class="fa fa-angle-double-left"></i></a>
                                <a href="{$page->eventInfo['page']['dup']}{$page->eventInfo['page']['dp']-1}"
                                   title="Prev"><i class="fa fa-angle-left"></i></a>
                            {else}
                                <a href="#" title="First"><i class="fa fa-angle-double-left"></i></a>
                                <a href="#" title="Prev"><i class="fa fa-angle-left"></i></a>
                            {/if}
                            {for $i=$page->eventInfo['page']['dpl'] to $page->eventInfo['page']['dpr']}
                                <a href="{$page->eventInfo['page']['dup']}{$i}"{if $i==$page->eventInfo['page']['dp']} class="active"{/if}>{$i}</a>
                            {/for}

                            {if $page->eventInfo['page']['dprr']}
                                <a href="{$page->eventInfo['page']['dup']}{$page->eventInfo['page']['dp']+1}"
                                   title="Next"><i class="fa fa-angle-right"></i></a>
                                <a href="{$page->eventInfo['page']['dup']}{$page->eventInfo['page']['dtp']}"
                                   title="Last"><i class="fa fa-angle-double-right"></i></a>
                            {else}
                                <a href="#" title="Next"><i class="fa fa-angle-right"></i></a>
                                <a href="#" title="Last"><i class="fa fa-angle-double-right"></i></a>
                            {/if}
                        </ul>
                    </div>
                {/if}
            </div>
        {/if}
    </div>
    <div class="product_right">
        {if $page->productInfo['is_space']}
            <div class="showDate border1">
                <div id="showDate">

                </div>
                <div class="datp clearfix">
                    <div class="c1">
                        <span></span>

                        <p>已预定</p>
                    </div>
                    <div class="c2">
                        <span></span>

                        <p>意向预定</p>
                    </div>
                    <div class="c3">
                        <span></span>

                        <p>未预定</p>
                    </div>
                </div>
            </div>
        {/if}
        {*<div class="case_title group_title">*}
        {*最佳组合*}
        {*</div>*}
        {*<div class="product_right_body">*}
        {*<div class="t_content2">*}
        {*<a href="#">*}
        {*<img src="/pros/yunspace/package/Web_1.0/interface/assets/img/hot.jpg">*}
        {*</a>*}
        {*<a href="#"><span>云SPACE宝山秀场</span></a>*}
        {*</div>*}
        {*<div class="t_content2">*}
        {*<a href="#">*}
        {*<img src="/pros/yunspace/package/Web_1.0/interface/assets/img/hot.jpg">*}
        {*</a>*}
        {*<a href="#"><span>云SPACE宝山秀场</span></a>*}
        {*</div>*}

        {*</div>*}
    </div>
    <div class="clearfix"></div>


    {*<script type="text/javascript" src="js/jquery.js"></script>*}


    {*<script type="text/javascript" src="js/fullcalendar.min.js"></script>*}
    <script type="text/javascript" src="js/bootstrap-datetimepicker.js"></script>
    <script type="text/javascript" src="js/jquery.lightSlider.js"></script>
    <script type="text/javascript" src="js/moment.min.js"></script>
    <script type="text/javascript" src='js/fullcalendar.js'></script>
    <script src='js/jquery.fancybox.js'></script>
    {*<script src='js/jquery.fancybox.pack.js'></script>*}
    <script src='js/collect.js'></script>
    {*<script src='js/look_price.js'></script>*}
    {static "js/look_price.js"}


    <script type="text/javascript">
        $(document).ready(function () {
            var showDate = $('#showDate').fullCalendar({
                header: {
                    left: 'prev',
                    center: 'title',
                    right: 'next'
                },
                // start: '2015-02-01',
                // defaultDate: '2015-02-12',
                aspectRatio: 1,
                height: 500,
                contentHeight: 300,
                editable: true,
                timezone: true,
                eventLimit: true, // allow "more" link when too many events
                dayNamesShort: [
                    '日', '一', '二', '三', '四', '五', '六'
                ],
                events: '{$_root}json_product_schedule/?product_id={$page->id}',
                monthNamesShort: [
                    '一月', '二月', '三月', '四月', '五月', '六月', '七月', '八月', '九月', '十月', '十一月', '十二月'

                ],
                monthNames: [
                    '一月', '二月', '三月', '四月', '五月', '六月', '七月', '八月', '九月', '十月', '十一月', '十二月'
                ]
            });

        });
        $(document).ready(function () {
            $('.one').show();
        });
    </script>


</div>
<script>
    var title =  $(".product_top_left h2").html();
    {*var url = encodeURI("{$_home}site/"+title+"-百科");*}
//    eval("wi"+"ndow.loca"+"tion.hr"+"ef='"+url+"';");

    $(".select-hover").hover(function () {
        $(".dropDown").hide();
        $(".select-click").removeClass("act");
        $(this).addClass("act");
        $(this).parent().find(".dropDown").show();
        $(".select-click").find("span").removeClass("s-s-active");
        $(this).find("span").addClass("s-s-active");
    }, function () {
        $(this).parent().find(".dropDown").hide();
        $(this).find("span").removeClass("s-s-active");
    });
</script>
{include "inc/pop_consult.tpl"}
{include file="inc/html_share.tpl"}
{include "inc/login-register.tpl"}
{include file="inc/baidu_map_in_info.tpl"}
{include file="inc/html_demand_ask.tpl"}
<div style="margin-top:50px;" class="mt50"></div>
{include file="Web_Static::v2.0/html_footer.tpl"}
</body>
</html>