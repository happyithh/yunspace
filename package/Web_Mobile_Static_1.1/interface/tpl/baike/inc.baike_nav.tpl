<div class="cover1 none"></div>
<div class="product-part2-nav">

    <div class="relative" style="width:100%;height:100%;">

        <div class="product-part2-nav-dropdown show-nav-click">
            <span class="ion-ios-arrow-down"></span>
        </div>
        <div class="product-part2-nav-dropdown" style="left:0px;border: 0px;">
            <span style="font-size: 15px;">目录</span>
        </div>
        <div class="show-floor-p none">
            楼层
        </div>
        <div class="show-floors none">
            <ul class="show-floors-li">
                <li>
                    <span class="ion-ios-location pos-color none"></span>
                    <span class="">场地图片</span>
                </li>
                <li>
                    <span class="ion-ios-location pos-color none"></span>
                    <span>基础信息</span>
                </li>
                <li style="display:none">
                    <span class="ion-ios-location pos-color none"></span>
                    <span>场地规格</span>
                </li>
                <li {if !$page->caseList}style="display:none;"{/if}>
                    <span class="ion-ios-location pos-color none"></span>
                    <span>活动案例</span>
                </li>
                <li>
                    <span class="ion-ios-location pos-color none"></span>
                    <span>场地位置</span>
                </li>
                <li>
                    <span class="ion-ios-location pos-color none"></span>
                    <span>场地简介</span>
                </li>
                <li>
                    <span class="ion-ios-location pos-color none" {if !$itemList}style="display: none;" {/if}></span>
                    <span>子空间</span>
                </li>
            </ul>
        </div>

        <div class="swiper-container" style="padding-left:44px;">
            <div class="swiper-wrapper">
                <div class="swiper-slide  nav-li">
                    <a href="javascript:;">
                        <span class="ion-ios-location pos-color none"></span>
                        <span class="">场地图片</span>
                    </a>
                </div>
                <div class="swiper-slide nav-li">
                    <a href="javascript:;">
                        <span class="ion-ios-location pos-color none"></span>
                        <span class="">基础信息</span>
                    </a>
                </div>
                <div class="swiper-slide nav-li "style="display:none">
                    <a href="javascript:;">
                        <span class="ion-ios-location pos-color none"></span>
                        <span class="">场地规格</span>
                    </a>
                </div>
                <div class="swiper-slide nav-li" {if !$page->caseList}style="display:none;"{/if}>
                    <a href="javascript:;">
                        <span class="ion-ios-location pos-color none"></span>
                        <span class="">活动案例</span>
                    </a>
                </div>
                <div class="swiper-slide nav-li">
                    <a href="javascript:;">
                        <span class="ion-ios-location pos-color none"></span>
                        <span class="">场地位置</span>
                    </a>
                </div>
                <div class="swiper-slide nav-li">
                    <a href="javascript:;">
                        <span class="ion-ios-location pos-color none"></span>
                        <span class="">场地简介</span>
                    </a>
                </div>
                <div class="swiper-slide nav-li" {if !$itemList}style="display: none;" {/if}>
                    <a href="javascript:;">
                        <span class="ion-ios-location pos-color none"></span>
                        <span class="">子空间</span>
                    </a>
                </div>
                <div class="swiper-slide nav-li">

                </div>
            </div>
        </div>

    </div>
</div>