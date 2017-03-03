<!doctype html>
<html>
<head lang="en">
    {include "Web_Mobile_Static::v1.0/head_meta.tpl"}
    {include "Web_Mobile_Static::search.v2.0/inc/inc.head_search.tpl"}
    {static "comment/comment.css"}
    {static "search.v.2.0/search.css"}
</head>
<body>
    {*<div class="mask"></div>*}
    {*顶部搜索框*}
    <div class="search_top">
         <div class="back_icon">
             <a href="#" class="ion-ios-arrow-back" data-pack="ios" data-tags="chevron, left"></a>
         </div>
         <input class="search_input" value="红坊创意园">
        <div class="clear"></div>
    </div>



    <div class="all-filter">
        <div class="cover none"></div>
        <div class="filter-fixed">
            {*顶部地址定位*}
            <div class="location">
                <span class="ion-ios-location-outline" data-pack="ios" data-tags="navigation, map, gps, pin"></span>
         <span class="location_addr">
             上海长宁区红坊创意园
         </span>
                <a class="location_btn">更换</a>
            </div>
            <div class="filter-ab">
                {*顶部筛选标题*}
                <div class="filter-title">
                    <ul class="clearfix">
                        <li class="filter-title-price" id="filter-title-price">价格&nbsp;&nbsp;<span class="ion-android-arrow-dropdown" data-pack="android" data-tags="chevron, navigation"></span></li>
                        <li class="filter-title_filter" id="filter-title_filter">筛选&nbsp;&nbsp;<span class="ion-android-arrow-dropdown" data-pack="android" data-tags="chevron, navigation"></span></li>
                        <li class="filter-title-sort" id="filter-title-sort">排序&nbsp;&nbsp;<span class="ion-android-arrow-dropdown" data-pack="android" data-tags="chevron, navigation"></span></li>
                        <div class="clear"></div>
                    </ul>
                </div>

                {*顶部筛选内容-价格tab*}
                <div class="filter-con" id="filter-price">
                    {include "Web_Mobile_Static::search.v2.0/inc/search_price.tpl"}
                </div>

                {*顶部筛选内容-排序tab*}
                <div class="filter-con" id="filter-filter">
                    {include "Web_Mobile_Static::search.v2.0/inc/search_filter.tpl"}
                </div>
                {*顶部筛选内容-筛选tab*}
                <div class="filter-con" id="filter-sort">
                    {include "Web_Mobile_Static::search.v2.0/inc/search_sort.tpl"}
                </div>

            </div>
        </div>

        {*筛选内容-排序tab*}
        <div class="filter-content">
            <ul class="filter-list">
                <li>
                    <a href="#">
                        <div class="filter-list-img">
                            <img src="img/search.v2.0/list_img.jpg" alt="徐家汇红坊创意园-红厅"/>
                            <div class="space-img-sum">32张</div>
                        </div>
                    </a>
                    <div class="filter-list-right">
                        <div class="space-title">
                            <a href="#">
                                <div class="space-name">徐家汇红坊创意园-红厅</div>
                            </a>
                            <div class="space-icon-active space-icon"></div>
                            <div class="clear"></div>
                        </div>
                        <a href="#">
                            <div class="space-label">
                                <div class="space-squer fl"><span></span>&nbsp;600㎡</div>
                                <div class="space-addr fl"><span></span>&nbsp;徐汇-万体馆</div>
                                <div class="space-distance fr">1.4km&nbsp;</div>
                                <div class="clear"></div>
                            </div>
                        </a>
                        <a href="#">
                            <div class="space-price">
                                <div class="space-price-symbol ion-social-yen fl" data-pack="social" data-tags="currency, trade, money, japanese"></div>
                                <div class="space-price-number fl">7800</div>
                                <div class="space-price-unit fl">/天起</div>
                                <div class="space-price-icon ion-ios-arrow-right fl" data-pack="ios" data-tags="chevron"></div>
                                <div class="clear"></div>
                            </div>
                        </a>
                    </div>
                    <div class="clear"></div>
                </li>
                <li>
                    <a href="#">
                        <div class="filter-list-img">
                            <img src="img/search.v2.0/list_img.jpg" alt="徐家汇红坊创意园-红厅"/>
                            <div class="space-img-sum">32张</div>
                        </div>
                    </a>
                    <div class="filter-list-right">
                        <div class="space-title">
                            <a href="#">
                                <div class="space-name">徐家汇红坊创意园-红厅</div>
                            </a>
                            <div class="space-icon-default space-icon"></div>
                            <div class="clear"></div>
                        </div>
                        <a href="#">
                            <div class="space-label">
                                <div class="space-squer fl"><span></span>&nbsp;600㎡</div>
                                <div class="space-addr fl"><span></span>&nbsp;徐汇-万体馆</div>
                                <div class="space-distance fr">1.4km&nbsp;</div>
                                <div class="clear"></div>
                            </div>
                        </a>
                        <a href="#">
                            <div class="space-price">
                                <div class="space-price-symbol ion-social-yen fl" data-pack="social" data-tags="currency, trade, money, japanese"></div>
                                <div class="space-price-number fl">7800</div>
                                <div class="space-price-unit fl">/天起</div>
                                <div class="space-price-icon ion-ios-arrow-right fl" data-pack="ios" data-tags="chevron"></div>
                                <div class="clear"></div>
                            </div>
                        </a>
                    </div>
                    <div class="clear"></div>
                </li>
                <li>
                    <a href="#">
                        <div class="filter-list-img">
                            <img src="img/search.v2.0/list_img.jpg" alt="徐家汇红坊创意园-红厅"/>
                            <div class="space-img-sum">32张</div>
                        </div>
                    </a>
                    <div class="filter-list-right">
                        <div class="space-title">
                            <a href="#">
                                <div class="space-name">徐家汇红坊创意园-红厅</div>
                            </a>
                            <div class="space-icon-default space-icon"></div>
                            <div class="clear"></div>
                        </div>
                        <a href="#">
                            <div class="space-label">
                                <div class="space-squer fl"><span></span>&nbsp;600㎡</div>
                                <div class="space-addr fl"><span></span>&nbsp;徐汇-万体馆</div>
                                <div class="space-distance fr">1.4km&nbsp;</div>
                                <div class="clear"></div>
                            </div>
                        </a>
                        <a href="#">
                            <div class="space-price">
                                <div class="space-price-symbol ion-social-yen fl" data-pack="social" data-tags="currency, trade, money, japanese"></div>
                                <div class="space-price-number fl">7800</div>
                                <div class="space-price-unit fl">/天起</div>
                                <div class="space-price-icon ion-ios-arrow-right fl" data-pack="ios" data-tags="chevron"></div>
                                <div class="clear"></div>
                            </div>
                        </a>
                    </div>
                    <div class="clear"></div>
                </li>
                <li>
                    <a href="#">
                        <div class="filter-list-img">
                            <img src="img/search.v2.0/list_img.jpg" alt="徐家汇红坊创意园-红厅"/>
                            <div class="space-img-sum">32张</div>
                        </div>
                    </a>
                    <div class="filter-list-right">
                        <div class="space-title">
                            <a href="#">
                                <div class="space-name">徐家汇红坊创意园-红厅</div>
                            </a>
                            <div class="space-icon-default space-icon"></div>
                            <div class="clear"></div>
                        </div>
                        <a href="#">
                            <div class="space-label">
                                <div class="space-squer fl"><span></span>&nbsp;600㎡</div>
                                <div class="space-addr fl"><span></span>&nbsp;徐汇-万体馆</div>
                                <div class="space-distance fr">1.4km&nbsp;</div>
                                <div class="clear"></div>
                            </div>
                        </a>
                        <a href="#">
                            <div class="space-price">
                                <div class="space-price-symbol ion-social-yen fl" data-pack="social" data-tags="currency, trade, money, japanese"></div>
                                <div class="space-price-number fl">7800</div>
                                <div class="space-price-unit fl">/天起</div>
                                <div class="space-price-icon ion-ios-arrow-right fl" data-pack="ios" data-tags="chevron"></div>
                                <div class="clear"></div>
                            </div>
                        </a>
                    </div>
                    <div class="clear"></div>
                </li>
                <li>
                    <a href="#">
                        <div class="filter-list-img">
                            <img src="img/search.v2.0/list_img.jpg" alt="徐家汇红坊创意园-红厅"/>
                            <div class="space-img-sum">32张</div>
                        </div>
                    </a>
                    <div class="filter-list-right">
                        <div class="space-title">
                            <a href="#">
                                <div class="space-name">徐家汇红坊创意园-红厅</div>
                            </a>
                            <div class="space-icon-default space-icon"></div>
                            <div class="clear"></div>
                        </div>
                        <a href="#">
                            <div class="space-label">
                                <div class="space-squer fl"><span></span>&nbsp;600㎡</div>
                                <div class="space-addr fl"><span></span>&nbsp;徐汇-万体馆</div>
                                <div class="space-distance fr">1.4km&nbsp;</div>
                                <div class="clear"></div>
                            </div>
                        </a>
                        <a href="#">
                            <div class="space-price">
                                <div class="space-price-symbol ion-social-yen fl" data-pack="social" data-tags="currency, trade, money, japanese"></div>
                                <div class="space-price-number fl">7800</div>
                                <div class="space-price-unit fl">/天起</div>
                                <div class="space-price-icon ion-ios-arrow-right fl" data-pack="ios" data-tags="chevron"></div>
                                <div class="clear"></div>
                            </div>
                        </a>
                    </div>
                    <div class="clear"></div>
                </li>
                <li>
                    <a href="#">
                        <div class="filter-list-img">
                            <img src="img/search.v2.0/list_img.jpg" alt="徐家汇红坊创意园-红厅"/>
                            <div class="space-img-sum">32张</div>
                        </div>
                    </a>
                    <div class="filter-list-right">
                        <div class="space-title">
                            <a href="#">
                                <div class="space-name">徐家汇红坊创意园-红厅</div>
                            </a>
                            <div class="space-icon-default space-icon"></div>
                            <div class="clear"></div>
                        </div>
                        <a href="#">
                            <div class="space-label">
                                <div class="space-squer fl"><span></span>&nbsp;600㎡</div>
                                <div class="space-addr fl"><span></span>&nbsp;徐汇-万体馆</div>
                                <div class="space-distance fr">1.4km&nbsp;</div>
                                <div class="clear"></div>
                            </div>
                        </a>
                        <a href="#">
                            <div class="space-price">
                                <div class="space-price-symbol ion-social-yen fl" data-pack="social" data-tags="currency, trade, money, japanese"></div>
                                <div class="space-price-number fl">7800</div>
                                <div class="space-price-unit fl">/天起</div>
                                <div class="space-price-icon ion-ios-arrow-right fl" data-pack="ios" data-tags="chevron"></div>
                                <div class="clear"></div>
                            </div>
                        </a>
                    </div>
                    <div class="clear"></div>
                </li>
                <li>
                    <a href="#">
                        <div class="filter-list-img">
                            <img src="img/search.v2.0/list_img.jpg" alt="徐家汇红坊创意园-红厅"/>
                            <div class="space-img-sum">32张</div>
                        </div>
                    </a>
                    <div class="filter-list-right">
                        <div class="space-title">
                            <a href="#">
                                <div class="space-name">徐家汇红坊创意园-红厅</div>
                            </a>
                            <div class="space-icon-default space-icon"></div>
                            <div class="clear"></div>
                        </div>
                        <a href="#">
                            <div class="space-label">
                                <div class="space-squer fl"><span></span>&nbsp;600㎡</div>
                                <div class="space-addr fl"><span></span>&nbsp;徐汇-万体馆</div>
                                <div class="space-distance fr">1.4km&nbsp;</div>
                                <div class="clear"></div>
                            </div>
                        </a>
                        <a href="#">
                            <div class="space-price">
                                <div class="space-price-symbol ion-social-yen fl" data-pack="social" data-tags="currency, trade, money, japanese"></div>
                                <div class="space-price-number fl">7800</div>
                                <div class="space-price-unit fl">/天起</div>
                                <div class="space-price-icon ion-ios-arrow-right fl" data-pack="ios" data-tags="chevron"></div>
                                <div class="clear"></div>
                            </div>
                        </a>
                    </div>
                    <div class="clear"></div>
                </li>
                <li>
                    <a href="#">
                        <div class="filter-list-img">
                            <img src="img/search.v2.0/list_img.jpg" alt="徐家汇红坊创意园-红厅"/>
                            <div class="space-img-sum">32张</div>
                        </div>
                    </a>
                    <div class="filter-list-right">
                        <div class="space-title">
                            <a href="#">
                                <div class="space-name">徐家汇红坊创意园-红厅</div>
                            </a>
                            <div class="space-icon-default space-icon"></div>
                            <div class="clear"></div>
                        </div>
                        <a href="#">
                            <div class="space-label">
                                <div class="space-squer fl"><span></span>&nbsp;600㎡</div>
                                <div class="space-addr fl"><span></span>&nbsp;徐汇-万体馆</div>
                                <div class="space-distance fr">1.4km&nbsp;</div>
                                <div class="clear"></div>
                            </div>
                        </a>
                        <a href="#">
                            <div class="space-price">
                                <div class="space-price-symbol ion-social-yen fl" data-pack="social" data-tags="currency, trade, money, japanese"></div>
                                <div class="space-price-number fl">7800</div>
                                <div class="space-price-unit fl">/天起</div>
                                <div class="space-price-icon ion-ios-arrow-right fl" data-pack="ios" data-tags="chevron"></div>
                                <div class="clear"></div>
                            </div>
                        </a>
                    </div>
                    <div class="clear"></div>
                </li>
                <li>
                    <a href="#">
                        <div class="filter-list-img">
                            <img src="img/search.v2.0/list_img.jpg" alt="徐家汇红坊创意园-红厅"/>
                            <div class="space-img-sum">32张</div>
                        </div>
                    </a>
                    <div class="filter-list-right">
                        <div class="space-title">
                            <a href="#">
                                <div class="space-name">徐家汇红坊创意园-红厅</div>
                            </a>
                            <div class="space-icon-default space-icon"></div>
                            <div class="clear"></div>
                        </div>
                        <a href="#">
                            <div class="space-label">
                                <div class="space-squer fl"><span></span>&nbsp;600㎡</div>
                                <div class="space-addr fl"><span></span>&nbsp;徐汇-万体馆</div>
                                <div class="space-distance fr">1.4km&nbsp;</div>
                                <div class="clear"></div>
                            </div>
                        </a>
                        <a href="#">
                            <div class="space-price">
                                <div class="space-price-symbol ion-social-yen fl" data-pack="social" data-tags="currency, trade, money, japanese"></div>
                                <div class="space-price-number fl">7800</div>
                                <div class="space-price-unit fl">/天起</div>
                                <div class="space-price-icon ion-ios-arrow-right fl" data-pack="ios" data-tags="chevron"></div>
                                <div class="clear"></div>
                            </div>
                        </a>
                    </div>
                    <div class="clear"></div>
                </li>
            </ul>
        </div>
        {*筛选内容-排序tab*}
        <a href="#" class="inquiry">
        <span>批量询价查档期
            <div class="inquiry-sum">11</div>
        </span>
        </a>
    </div>

    {static "search.v2.0/search.js"}
</body>
</html>