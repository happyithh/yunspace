<!DOCTYPE html>
<html>
<head>
    {include file="inc/html_head.tpl"}
    <script type="text/javascript" src="js/highlight.js"></script>
</head>
<body>
{include file="Web_Static::v2.0/html_header3.1.tpl"}
<div class="content">
<div class="con wrap clearfix s_lt">
    {if !$category_id}
        <h1>全部供应商
            {if   $request['filter']}
                <small> >
                    {foreach   $request['filter'] as $k=>$v}
                        {tplDisplayShortAttrName($k)}:{$v}
                    {/foreach}
                </small>
            {/if}
        </h1>
    {else}
        <h1>{$_category_info[$category_id][0]}供应商
            {if   $request['filter']}
                <small> >
                    {foreach   $request['filter'] as $k=>$v}
                        {tplDisplayShortAttrName($k)}:{$v}
                    {/foreach}
                </small>
            {/if}</h1>
    {/if}
    <div id="nav_scr" class="nav_scr">
        <ul id="wapNexNav" class="wapNexNav clearfix">
            <!--手机导航 js添加 -->
        </ul>
        {if $nav_index!=1}
            <ul class="nav_sl clearfix" id="nav_sl">
                <li{if !$category_id} class="active"{/if}>
                    <a href="{$_root}vendor/">全部</a>
                </li>
                {foreach $_category_tree[0] as $k=>$v}
                    {if $v}
                        <li{if $top_category_id==$k} class="active"{/if}>
                            <a href="{$_root}vendor/{$k}">{$v}</a>
                        </li>
                    {/if}
                {/foreach}
            </ul>
        {/if}
        <span class="nar"><i class="fa fa-angle-right"></i></span>
    </div>
    <div class="se_ke">
        <div class="se_wrap" id="se_wrap">
            <table>
                <tr>
                    <td style="min-width: 120px"></td>
                    <td></td>
                </tr>
                {foreach $parents as $cid}
                    {if $cid&&$_category_tree[$cid]}
                        <tr class="se_ke_b">
                            <td>
                            <span>
                                {$_category_info[$cid][0]}类型
                            </span>
                            </td>
                            <td>
                                <ul class="clearfix">
                                    <li{if $cid==$category_id} class="active"{/if}>
                                        <a href="{$_root}vendor/{$cid}">全部</a>
                                    </li>
                                    {foreach $_category_tree[$cid] as $k=>$v}
                                        {if $v}
                                            <li{if in_array($k,$parents)} class="active"{/if}>
                                                {if !empty($filter_string) && $filter_string !=='&'}
                                                <a href="{$_root}vendor/{$k}?{$filter_string}">{$v}</a>
                                                {elseif $filter_string=='&'}
                                                <a href="{$_root}vendor/{$k}">{$v}</a>
                                                {/if}
                                            </li>
                                        {/if}
                                    {/foreach}
                                </ul>
                            </td>
                        </tr>
                    {/if}
                {/foreach}
                {foreach $_vendor_attr['attr'] as $k=>$v}
                    <tr class="se_ke_b">
                        <td>
                            <span>
                                {tplDisplayShortAttrName($k)}
                            </span>
                        </td>
                        <td>
                            <ul class="clearfix">
                                <li{if !  $request['filter'][$k]} class="active"{/if}>
                                    <a href="{$_root}vendor/{$cid}?{$filter_string}filter[{urlencode($k)}]=all">全部</a>
                                </li>
                                {foreach $v as $vk}
                                    {if $v}
                                        <li{if   $request['filter'][$k]==$vk} class="active"{/if}>
                                            <a href="{$_root}vendor/{$cid}?{$filter_string}filter[{urlencode($k)}]={urlencode($vk)}">{$vk}</a>
                                        </li>
                                    {/if}
                                {/foreach}
                            </ul>
                        </td>
                    </tr>
                {/foreach}
                <tbody class="hide_sek" id="hide_sek">
                </tbody>
                <tr class="se_ke_b">
                    <td>
                        <span>关键词</span>
                    </td>
                    <td>
                        <ul class="clearfix">
                            <form class="fl clearfix" action="{$_root}{$___urls['route']}?{$filter_string}"
                                  method="post">
                                <div class="input-group input-medium">
                                    <input type="text" class="form-control" placeholder="搜索供应商名称，地址，类型等" name="keyword"
                                           value="{$request['keyword']}">

                                    <div class="input-group-btn">
                                        <button type="submit" class="btn btn-default search_btn">
                                            <i class="fa fa-search"></i>
                                        </button>
                                    </div>
                                </div>
                            </form>
                        </ul>
                    </td>
                </tr>
            </table>
        </div>
        <div class="mose_ke" id="mose_ke">
            展开更多筛选条件
        </div>

    </div>
</div>

<div class="con clearfix wrap server_list vendor_list_w">
    <div class="list_l fl clearfix" style="width: 920px;">
        {*<div class="list_l_t clearfix">*}
        {*<select class="form-control">*}
        {*<option>上海</option>*}
        {*<option>南京</option>*}
        {*<option>北京</option>*}
        {*<option>天津</option>*}
        {*<option>苏州</option>*}
        {*</select>*}

        {*<div class="fr map_icon">*}
        {*<img src="images/u208.png" data-toggle="modal" data-target="#myModal">*}
        {*</div>*}
        {*</div>*}
        {foreach $list['rows'] as $k=>$v}
            <div class="vendor_list_w">
                <div class="se_li_list vendor_list">
                    <div class="fl img_list">
                        <a href="{$_root}vendor_info/{$v['id']}.html">
                            {*{var_dump($v['logo'])}*}
                                {if $v['logo']}
                                    <img src="{Page_Site_Global::displayLogo($v['logo'],142,104)}">
                                {else}
                                    <img src="{Page_Site_Global::displayLogo('/package/Web_1.0/interface/assets/public/nopic2.jpg',142,104)}">

                                {/if}
                                {*<img src="images/vendor.jpg">*}
                        </a>
                    </div>
                    <div class="tw clearfix">
                        <div class="fl wz" style="width: 60%;">
                            <h3>
                                <a href="{$_root}vendor_info/{$v['id']}.html">{$v['vendor_name']}</a>
                                {if $v['vendor_remarks']['签约状态']==2}
                                    <span style="float: right; display: inline-block; line-height: 18px;">
                                     <img src="img/sign_seller.jpg">
                                    </span>
                                {/if}
                            </h3>
                            {if $v['base_info']['公司地址']}
                                <span><font>地址 : </font>{$v['base_info']['公司地址']}</span>
                            {/if}
                            <div class="line"></div>
							<span class="ser_con" style="overflow: auto">
								<font>服务行业 : </font>
								<font class="bl">
                                    {if $v['attr_index']['服务行业']}
                                        {$v['attr_index']['服务行业']}
                                    {else}
                                        {if $v['attr_index']['活动类型']}
                                            {$v['attr_index']['活动类型']}
                                        {/if}
                                    {/if}</font>
							</span>
                            <font>简介 : </font>
                            <font class="bl">{if $v['des']}
                                    {mb_substr($v['des'],0,30,'utf8')}...
                                {else}
                                    暂无
                                {/if}
                            </font>
                        </div>
                        {*{if $v['vendor_remarks']['签约状态']==2}*}
                            {*<div class="fr mene">*}
                                {*<div class="dbl">*}
                                    {*<span class="s_btn inline-block bgc2"><a href="#">签约商家</a></span>*}
                                    {*<span class="s_btn inline-block bgc2"><a href="#">五星推荐</a></span>*}
                                {*</div>*}
                            {*</div>*}
                        {*{/if}*}

                    </div>

                </div>
            </div>
        {/foreach}
        <div class="pageing_wrap  clearfix">
            <div class="paging">
                {if $list['page']['dpll']}
                    <a href="{$list['page']['dup']}1" title="First"><i class="fa fa-angle-double-left"></i></a>
                    <a href="{$list['page']['dup']}{$list['page']['dp']-1}" title="Prev"><i
                                class="fa fa-angle-left"></i></a>
                {else}
                    <a href="#" title="First"><i class="fa fa-angle-double-left"></i></a>
                    <a href="#" title="Prev"><i class="fa fa-angle-left"></i></a>
                {/if}
                {for $i=$list['page']['dpl'] to $list['page']['dpr']}
                    <a href="{$list['page']['dup']}{$i}"{if $i==$list['page']['dp']} class="active"{/if}>{$i}</a>
                {/for}

                {if $list['page']['dprr']}
                    <a href="{$list['page']['dup']}{$list['page']['dp']+1}" title="Next"><i
                                class="fa fa-angle-right"></i></a>
                    <a href="{$list['page']['dup']}{$list['page']['dtp']}" title="Last"><i
                                class="fa fa-angle-double-right"></i></a>
                {else}
                    <a href="#" title="Next"><i class="fa fa-angle-right"></i></a>
                    <a href="#" title="Last"><i class="fa fa-angle-double-right"></i></a>
                {/if}
            </div>
        </div>
    </div>


    <div class="list_r fr">
        <span class="if_yl">猜你喜欢</span>

        <div class="wrap_lr clearfix">
            {foreach $guessList as $k=>$v}
                <div class="t_content">
                    <a href="{$_root}service_info/{$v['id']}.html">
                        {if $v['logo']}
                            <img src="{Page_Site_Global::displayMedia($v['logo'],275,195)}">
                        {else}
                            <img src="images/vendor.jpg">
                        {/if}
                    </a>
                    <a href="{$_root}service_info/{$v['id']}.html"><span>{$v['product_name']}</span></a>
                </div>
                {*<div class="t_content">*}
                {*<a href="{$_root}service_info/{$v['id']}.html"><img data-original="{Page_Site_Global::displayMedia($v['logo'],'264')}"></a>*}
                {*</div>*}
            {/foreach}
        </div>
    </div>
</div>

</div>
<!-- 地图弹窗 -->
<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
                <h4 class="modal-title" id="myModalLabel">
                    地图</h4>
            </div>
            <div class="modal-body map_con">
                <img src="images/home_06.gif">
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">
                    关闭
                </button>
                <button type="button" class="btn btn-primary">
                    选择
                </button>
            </div>
        </div>
    </div>
</div>
<!-- 遮罩层 -->
<div class="layer" id="layer"></div>
{include file="Web_Static::v2.0/form.tpl"}
{include file="Web_Static::v2.0/html_footer.tpl"}
<script type="text/javascript" src="js/moment.min.js"></script>
<script type="text/javascript" src="js/jquery.lazyload.js"></script>
<script type="text/javascript" src="js/bootstrap.min.js"></script>
<script type="text/javascript" src="js/bootstrap-datetimepicker.min.js"></script>
<script type="text/javascript" src="js/iscroll.js"></script>

</body>
</html>