<div class="top_user" style="border-bottom: 4px solid {$color|default:'#353535'}">

    <div class="logo_fl">
        <a href="{$_root}">
            <img src="images/u7.png" alt="logo" class="logo">
        </a>
    </div>
    <div class="search_l">
        <form action="" class="pull-left">
            <select class="form-control input-xsmall select2me pull-left" data-placeholder="Select..." style="margin-right:20px;" id="header-city">
                {foreach $_REQUEST['cities'] as $v}
                    <option {if $v==$_COOKIE['city']}selected="selected" {/if}>{$v}</option>
                {/foreach}
            </select>
        </form>
    </div>
    <div class="search_r" id="search_input">
        <form class="clearfix search_input form-inline" id="myform" action="{$_root}space?{$filter_string}" method="post">
            <div class="down_box">
            <select class="form-control" name="mode" id="header-select">
                <option value="space"
                        {if $_REQUEST['mode']=='space' || Core::$urls['route']== 'space/'}selected {/if}>
                    空间场地
                </option>
                <option value="service"
                        {if $_REQUEST['mode']=='service' ||  Core::$urls['route']== 'service/'}selected {/if}>
                    配套服务
                </option>
                <option value="set_list"
                        {if $_REQUEST['mode']=='set_list' ||  Core::$urls['route']== 'set_list/'}selected {/if}>
                    超值套餐
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

    <div class="phone" style="height: 70px; overflow: hidden;">
        <div style="float: right;">
            {*<a href="user_admin.html" >*}
                <img class="pull-left" style="padding-top: 20px;" src="images/u42.png" alt="logo" style="width:30px;height:30px;margin-right:10px;"/>
            {*</a>*}

            <p class="pull-left" style="line-height:70px;font-size:16px;margin-right:10px;">
                服务热线</p>

            <p class="pull-left" style="line-height:70px;font-size:16px">
                400-056-0599</p>
        </div>
    </div>


</div>

<!-- 手机部分 -->
<div class="wap_ic">
    <span id="toSearchForm" style="cursor: pointer;"><i class="fa fa-search"></i></span>
    <span id="showNav" style="cursor: pointer;"><i class="fa fa-navicon"></i></span>
</div>

<div class="top_nav clearfix" id="top_nav2">
    <div class="wrap">
        <ul class="fl">
        </ul>
    </div>
</div>

<div class="layer" id="layer"></div>
<script>
    $(document).ready(function () {
        $('#top_nav2 ul').html($('.page-sidebar-menu').html());
        $('#toSearchForm').bind('click', function (event) {
            $('#search_input').slideToggle('fast');
            isShowMask()
        });
        $('#showNav').bind('click', function (event) {
            $('#top_nav2').slideToggle('fast');
            isShowMask()
        });
        $('#layer').bind('click', function (event) {
            $('#search_input').hide();
            $('#top_nav2').hide();
            $(this).fadeOut();
        });
        function isShowMask() {
            var layer = $('#layer');
            if (layer.is(":visible")) {
                layer.hide()
            } else {
                $('#layer').fadeIn('fast');
                // $('#layer').show();
            }
        }

        $('#header-city').change(function () {
            var o = $('#header-city');
            window.location = '/?df_city=' + $(o).val() + '&t=' + (new Date()).valueOf() + '&url_back=' + window.location.href;
        })
        $('#header-select').change(function () {
            var mode = $('#header-select').val();
            var url = "{$_root}" + mode + "?{$filter_string}";
            $('#top_search').attr('action', url);
        })


    });

</script>