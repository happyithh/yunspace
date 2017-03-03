<div class="body">
    <div class="some">
        <div class="header clearfix">
            <p class="alt">秀场展馆</p>
            <ul class="list clearfix font-color1 change-city">
                <li class="no-circle"><a href="javascript:;" class="active-one" onclick="this.yun('page/search.js::request',{ submit:1,page_body:'#getShowSpace'})" name="city" value="上海">上海</a></li>
                <li><a href="javascript:;" onclick="this.yun('page/search.js::request',{ submit:1,page_body:'#getShowSpace'})" name="city" value="北京" >北京</a></li>
                <li><a href="javascript:;" onclick="this.yun('page/search.js::request',{ submit:1,page_body:'#getShowSpace'})" name="city" value="广州" >广州</a></li>
                <li><a href="javascript:;" onclick="this.yun('page/search.js::request',{ submit:1,page_body:'#getShowSpace'})" name="city" value="深圳">深圳</a></li>
                <li><a href="javascript:;" onclick="this.yun('page/search.js::request',{ submit:1,page_body:'#getShowSpace'})" name="city" value="成都">成都</a></li>
                {if $page->BeyondDefaultCity}
                    <li><a href="javascript:;" onclick="this.yun('page/search.js::request',{ submit:1,page_body:'#getShowSpace'})" name="city" value="{$_COOKIE['city']}">{$_COOKIE['city']}</a></li>
                {/if}
            </ul>
        </div>
        <div class="img-body">
            <div class="img-des">
                <div class="des">
                    <p class="des-title">简介</p>

                    <p class="des-p">空间使用面积大，非常适合品牌客户定制化活动，例如：媒体发布会、时尚走秀、新车试乘试驾、电音派对、明星演唱会、品鉴会、订货会、艺术展和艺术装置展览。</p>
                </div>
            </div>
            <div class="img"   yun-load="{$_home}space_library/getShowSpace" id="getShowSpace">
                {include "Web_Static::space_library/inc/getShowSpace.tpl"}

            </div>

        </div>

        <div class="footer">
            <a target="_blank" href="http://www.yunspace.com.cn/spaces-category-tags/{Func_Url::str_urlencode('秀场展馆')}">
                查看更多
            </a>
        </div>
    </div>
    <div class="some">
        <div class="header clearfix">
            <p class="alt">商业广场</p>
            <ul class="list clearfix font-color2 change-city">
                <li class="no-circle"><a href="javascript:;" class="active-two"  onclick="this.yun('page/search.js::request',{ submit:1,page_body:'#getBusinessSpace'})" name="city" value="上海"  >上海</a></li>
                <li><a href="javascript:;" onclick="this.yun('page/search.js::request',{ submit:1,page_body:'#getBusinessSpace'})"  name="city" value="北京" >北京</a></li>
                <li><a href="javascript:;"  onclick="this.yun('page/search.js::request',{ submit:1,page_body:'#getBusinessSpace'})" name="city" value="广州" >广州</a></li>
                <li><a href="javascript:;"  onclick="this.yun('page/search.js::request',{ submit:1,page_body:'#getBusinessSpace'})" name="city" value="深圳"  >深圳</a></li>
                <li><a href="javascript:;"  onclick="this.yun('page/search.js::request',{ submit:1,page_body:'#getBusinessSpace'})" name="city" value="成都" >成都</a></li>
                {if $page->BeyondDefaultCity}
                    <li><a href="javascript:;" onclick="this.yun('page/search.js::request',{ submit:1,page_body:'#getBusinessSpace'})" name="city" value="{$_COOKIE['city']}" >{$_COOKIE['city']}</a></li>
                {/if}
            </ul>
        </div>
        <div class="img-body">
            <div class="img-des">
                <div class="des">
                    <p class="des-title">简介</p>

                    <p class="des-p">商业广场拥有固定消费人群和稳定的自然人流，非常适合品牌推广活动，例如：路演活动、IP文创项目展览和特卖展销。</p>
                </div>
            </div>
            <div class="img"  yun-load="{$_home}space_library/getBusinessSpace" id="getBusinessSpace">
                {include "Web_Static::space_library/inc/getBusinessSpace.tpl"}

            </div>

        </div>

        <div class="footer">
            <a target="_blank" href="http://www.yunspace.com.cn/spaces-category-tags/{Func_Url::str_urlencode('商业广场')}">
                查看更多
            </a>
        </div>
    </div>
    <div class="some">
        <div class="header clearfix">
            <p class="alt">高端会所</p>
            <ul class="list clearfix font-color3 change-city">
                <li class="no-circle"><a href="javascript:;" class="active-three"  onclick="this.yun('page/search.js::request',{ submit:1,page_body:'#getClubSpace'})" name="city" value="上海" >上海</a></li>
                <li><a href="javascript:;" onclick="this.yun('page/search.js::request',{ submit:1,page_body:'#getClubSpace'})" name="city" value="北京" >北京</a></li>
                <li><a href="javascript:;"  onclick="this.yun('page/search.js::request',{ submit:1,page_body:'#getClubSpace'})"  name="city" value="广州" >广州</a></li>
                <li><a href="javascript:;"  onclick="this.yun('page/search.js::request',{ submit:1,page_body:'#getClubSpace'})"  name="city" value="深圳" >深圳</a></li>
                <li><a href="javascript:;"  onclick="this.yun('page/search.js::request',{ submit:1,page_body:'#getClubSpace'})"  name="city" value="成都" >成都</a></li>
                {if $page->BeyondDefaultCity}
                    <li><a href="javascript:;"  onclick="this.yun('page/search.js::request',{ submit:1,page_body:'#getClubSpace'})"  name="city" value="{$_COOKIE['city']}" >{$_COOKIE['city']}</a></li>
                {/if}
            </ul>
        </div>
        <div class="img-body">
            <div class="img-des">
                <div class="des">
                    <p class="des-title">简介</p>

                    <p class="des-p">高端会所有着很好的私享空间和尊贵的专享体验，适合高端体验的活动，例如：高端品鉴会、服装高定会、客户答谢会。</p>
                </div>
            </div>
            <div class="img" yun-load="{$_home}space_library/getClubSpace" id="getClubSpace">
                {include "Web_Static::space_library/inc/getClubSpace.tpl"}
            </div>

        </div>
        <div class="footer">
            <a target="_blank" href="http://www.yunspace.com.cn/spaces-category-tags/{Func_Url::str_urlencode('高端会所')}">
                查看更多
            </a>
        </div>
    </div>
    <div class="some">
        <div class="header clearfix">
            <p class="alt">会务中心</p>
            <ul class="list clearfix font-color4 change-city">
                <li class="no-circle"><a href="javascript:;" class="active-four"  onclick="this.yun('page/search.js::request',{ submit:1,page_body:'#getMeetingSpace'})"  name="city" value="上海" >上海</a></li>
                <li><a href="javascript:;"  onclick="this.yun('page/search.js::request',{ submit:1,page_body:'#getMeetingSpace'})"  name="city" value="北京" >北京</a></li>
                <li><a href="javascript:;"  onclick="this.yun('page/search.js::request',{ submit:1,page_body:'#getMeetingSpace'})"  name="city" value="广州" >广州</a></li>
                <li><a href="javascript:;"  onclick="this.yun('page/search.js::request',{ submit:1,page_body:'#getMeetingSpace'})"  name="city" value="深圳" >深圳</a></li>
                <li><a href="javascript:;"  onclick="this.yun('page/search.js::request',{ submit:1,page_body:'#getMeetingSpace'})"  name="city" value="成都" >成都</a></li>
                {if $page->BeyondDefaultCity}
                    <li><a href="javascript:;"  onclick="this.yun('page/search.js::request',{ submit:1,page_body:'#getMeetingSpace'})"  name="city" value="{$_COOKIE['city']}" >{$_COOKIE['city']}</a></li>
                {/if}

            </ul>
        </div>
        <div class="img-body">
            <div class="img-des">
                <div class="des">
                    <p class="des-title">简介</p>

                    <p class="des-p">完善的会议配套设备和标准的会务流程，会议中心适合：会务沙龙、学术研讨、论坛演讲、培训会和发布会。</p>
                </div>
            </div>
            <div class="img" yun-load="{$_home}space_library/getMeetingSpace" id="getMeetingSpace">
                {include "Web_Static::space_library/inc/getMeetingSpace.tpl"}

            </div>

        </div>
        <div class="footer">
            <a target="_blank" href="http://www.yunspace.com.cn/spaces-category-tags/{Func_Url::str_urlencode('会务中心')}">
                查看更多
            </a>
        </div>
    </div>
    <div class="some">
        <div class="header clearfix">
            <p class="alt">餐厅酒吧</p>
            <ul class="list clearfix font-color5 change-city">
                <li class="no-circle"><a href="javascript:;" class="active-five"  onclick="this.yun('page/search.js::request',{ submit:1,page_body:'#getBarSpace'})"  name="city" value="上海" >上海</a></li>
                <li><a href="javascript:;"  onclick="this.yun('page/search.js::request',{ submit:1,page_body:'#getBarSpace'})"  name="city" value="北京" >北京</a></li>
                <li><a href="javascript:;"  onclick="this.yun('page/search.js::request',{ submit:1,page_body:'#getBarSpace'})"  name="city" value="广州" >广州</a></li>
                <li><a href="javascript:;"  onclick="this.yun('page/search.js::request',{ submit:1,page_body:'#getBarSpace'})"  name="city" value="深圳" >深圳</a></li>
                <li><a href="javascript:;"  onclick="this.yun('page/search.js::request',{ submit:1,page_body:'#getBarSpace'})"  name="city" value="成都" >成都</a></li>
                {if $page->BeyondDefaultCity}
                <li><a href="javascript:;"  onclick="this.yun('page/search.js::request',{ submit:1,page_body:'#getBarSpace'})"  name="city" value="{$_COOKIE['city']}" >{$_COOKIE['city']}</a></li>
                {/if}
            </ul>
        </div>
        <div class="img-body">
            <div class="img-des">
                <div class="des">
                    <p class="des-title">简介</p>

                    <p class="des-p">包含多元文化特色的餐厅酒吧，能给客户带来新奇的独特体验，适合举办公司团建、公司分享会和公司年会、以及个人求婚、纪念日、生日聚会。</p>
                </div>
            </div>
            <div class="img"  yun-load="{$_home}space_library/getBarSpace" id="getBarSpace">
                {include "Web_Static::space_library/inc/getBarSpace.tpl"}
            </div>

        </div>
        <div class="footer">
            <a target="_blank" href="http://www.yunspace.com.cn/spaces-category-tags/{Func_Url::str_urlencode('餐厅酒吧')}">
                查看更多
            </a>
        </div>
    </div>
</div>
