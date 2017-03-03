<!--[if lt IE 8]>
<div class="ie7_error">还在用<strong>漏洞百出的IE7浏览器</strong>么？
    为了您的浏览体验，请升级<a href="http://windows.microsoft.com/zh-CN/internet-explorer/downloads/ie">Internet
        Explorer</a>浏览器，
    或使用其他的浏览器。
</div>
<![endif]-->
<div class="top wrap clearfix">
    <span class="logo fl"><a href="{$_root}"><img src="images/logo.png" title="云·Space－商业空间短租平台"></a></span>
    <select class="form-control fl top_select_city" onchange="changeCity(this)">
        {foreach $_REQUEST['cities'] as $v}
            <option {if $v==$_COOKIE['city']}selected="selected" {/if}>{$v}</option>
        {/foreach}
    </select>

    <div class="top_search fl" id="top_search">

        <form class=" fr clearfix search_input form-inline" id="myform" action="{$_root}space?{$filter_string}" method="get">
            <div class="down_box">
                <select class="form-control" name="mode" id="header-select" onchange="changeType(this)">
                    <option value="space" {if Core::$urls['route']== 'space/' || $info&&$info['is_space']}selected {/if}>
                        空间
                    </option>
                    <option value="service" {if Core::$urls['route']== 'service/' || $info&&!$info['is_space']}selected {/if}>
                        配套服务
                    </option>
                    <option value="vendor" {if Core::$urls['route']== 'vendor/' || Core::$urls['route']== 'vendor_info/'}selected {/if}>
                        供应商
                    </option>
                </select>
            </div>
            <div class="input-group">
                <input type="text" class="form-control" id="header-input" placeholder="搜索供应商名称，地址，类型等" name="keyword" value="{htmlspecialchars($_REQUEST['keyword'])}">
                  <span class="input-group-btn">
                            <button type="submit" class="btn btn-default search_btn">
                                <i class="fa fa-search"></i>
                            </button>
                 </span>
            </div>
        </form>
    </div>

    <div class="fr hotline">
        <span class="glyphicon glyphicon-bullhorn hotline_icon"></span><span>服务热线 400-056-0599</span>
    </div>
    <!-- 手机部分 -->
    <div class="wap_ic">
        <span id="toSearchForm"><i class="fa fa-search"></i></span>
        <span id="showNav"><i class="fa fa-navicon"></i></span>
    </div>
</div>
<div class="top_nav clearfix" id="top_nav">
    <div class="wrap">
        <ul class="fl">
            <li{if !$nav_index} class="active"{/if}>
                <a href="{$_root}">首页</a>
            </li>
            <li{if $nav_index==1} class="active"{/if}>
                <a href="{$_root}space">空间场地</a></li>
            <li{if $nav_index==2} class="active"{/if}>
                <a href="{$_root}service">配套服务</a></li>
            <li{if $nav_index==5} class="active"{/if}>
                <img src="images/hot_03.png" class="hot_img" style="position:absolute;margin-left: 82px;"/>
                <a href="{$_root}set_list">超值套餐</a>
            </li>
            <li{if $nav_index==8} class="active"{/if}>
                <a href="{$_root}raiders">活动攻略</a></li>
            {*<li{if $nav_index==4} class="active"{/if}>
                <a href="{$_root}event">活动案例</a></li>*}
            <li{if $nav_index==6} class="active"{/if}>
                <a href="{$_root}vendor_join">供应商加盟</a></li>
            <li{if $nav_index==7} class="active"{/if}>
                {*<a href="{$_root}help-center/help-center">帮助中心</a></li>*}
        </ul>
    </div>
</div>
<script>
    $(document).ready(function () {
        $.get('{$_root}ajax_ustat', function (data) {
            if (data) {
                $('<div>').html(data).appendTo('#top_nav>div');
            }
        });
        changeType($('#header-select'));
    });
    function changeCity(o) {
        window.location = '{$_root}?df_city=' + $(o).val() + '&t=' + (new Date()).valueOf() + '&url_back=' + window.location.href;
    }

    function searchSubmit(mode) {
        $('#top_search input[name=mode]').val(mode);
        $('#top_search').submit();
    }
    function changeType(t) {
        var mode = $(t).val();
        var url = "{$_root}" + mode + "?{$filter_string}";
        $('#myform').attr('action', url);
    }

</script>
{static 'core/yunspace.js'}