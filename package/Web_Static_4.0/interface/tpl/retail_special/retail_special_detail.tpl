<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    {include file="Web_Static::inc/head_meta.tpl"}
    {static "v4.0/common.css"}
    {static "adm_special/carousel.css"}
    {static "adm_special/retail_special.css"}
    <title>Title</title>

    <link href="css/adm_special/video-js.css" rel="stylesheet">
    <!-- If you'd like to support IE8 -->
    <script src="js/retail/videojs-ie8.min.js"></script>
</head>
<body>
{include file="Web_Static::inc/header_1.tpl"}
<div class="container-wrapper">
    <div class="container">
        <!--轮播图-->
        <div class="retail-show successlunbo clearfix">
            <div class="succesny">
                <div class="control">
                    <ul class="change">
                    </ul>
                    <div class="top-back">
                        <a class="btn-back" href="{$_home}adm_list">返回</a>
                        <div class="bg"></div>
                    </div>
                </div>
                <div class="thumbWrap">
                    <div class="thumbCont">
                        <ul>
                            <!-- img属性, url=url, text=描述, bigimg=大图, alt=标题  -->
                            {*<li>*}
                                {*<div><img class="videos" src="{Page_Site_Global::displayMedia($page->detail['brand_pic'][0]['path'],180,120)}" url="{$page->detail['brand_pic'][0]['url']}" bigImg="{$page->detail['brand_pic'][0]['url']}" alt=""></div>*}
                            {*</li>*}
                            {foreach $page->detail['brand_pic'] as $k=>$v}
                                <li>
                                    <div><img class="videos" src="{Page_Site_Global::displayMedia($v['path'],180,120)}" url="{$v['url']}" bigImg="{$v['url']}" alt="{$v['name']}"></div>
                                </li>
                            {/foreach}
                            {foreach $page->detail['brand_case'] as $k=>$v}
                            <li>
                                <div><img src="{Page_Site_Global::displayMedia($v['path'],180,120)}" url="javascript:;" bigImg="{Page_Site_Global::displayMedia($v['path'],1010,674)}" alt="{$v['case_name']}"></div>
                            </li>
                            {/foreach}

                        </ul>
                    </div>
                </div>
            </div>
        </div>
        <!--VINCI-->
        <div class="section section-vinci">
            <h2>{$page->detail['title']}<span class="line"></span></h2>
            <div class="cont">
                {$page->detail['des']}
               </div>
        </div>
    </div><!--container-end-->
</div><!--container-wrapper-end-->

{include file="Web_Static::inc/html_footer.tpl"}
<script src="js/retail/slides-1.1.1-min.js" type="text/javascript"></script>
{static "retail/video.js"}
{static "retail/retail_adm.js"}
</body>
</html>
