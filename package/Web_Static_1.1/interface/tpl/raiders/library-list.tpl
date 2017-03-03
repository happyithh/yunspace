<!DOCTYPE html>
<html>
<head>
    {include file="Web_Static::v2.0/html_head.tpl"}
    <link rel="stylesheet" type="text/css" href="css/v2.0/common.css">
    <link rel="stylesheet" type="text/css" href="css/raiders/raiders-list.css">
</head>
<body>
{include file="Web_Static::v2.0/html_header3.1.tpl"}
<div class="container">
    <div class="site_location">
        <a href="/">首页</a><span>&gt;</span>
        {*<a href="{$_root}raiders/{$page->category_id}">活动攻略</a>*}
        <a href="{$_root}raiders">活动攻略</a>
    </div>

    <div class="raiders-title">
        <div class="raiders-title-menu fl">
            <a href="{$_root}raiders/" {if $page->category_id==0} class='active'{/if}>全部</a>
            {foreach $page->allCategory as $key=>$val}
                {if $val['parent']==0}
                    <a href="{$_root}raiders/{$val['id']}" {if $page->topCategory_id['top_id'] == $val['id']} class='active'{/if}>{$val['name']}</a>
                {/if}
            {/foreach}
        </div>
        <div class="raiders-search fr">
            <form action="?" method="get">
                <input type="text" class="search-txt" name="keyword" placeholder="搜索关键词"
                       value="{htmlspecialchars($_REQUEST['keyword'])}">
                <input type="submit" class="search-btn">
            </form>
        </div>
    </div>
    <!--raiders-title-end-->
    <div class="raiders-wrap">
        <div class="raiders-main fl">
            {if $page->category_id}
                <div class="raiders-menu">
                    <a href="{$_root}raiders/{$page->topCategory_id['top_id']}"
                       {if $page->topCategory_id['sub_id']==0}class='active' {/if}>不限</a>
                    {foreach $page->allCategory as $key=>$val}
                        {if $val['parent']==$page->topCategory_id['top_id']}
                            <a href="{$_root}raiders/{$val['id']}" {if $page->topCategory_id['sub_id'] == $val['id']} class='active'{/if}>{$val['name']}</a>
                        {/if}
                    {/foreach}
                </div>
            {/if}

            <div class="library_list_container">
                <div class="library_list_title">
                    <div class="library_type">类型</div>
                    <div class="library_name">文档名称</div>
                    <div class="library_classify">文件分类</div>
                    <div class="library_download">下载量</div>
                    <div class="library_size">文件大小</div>
                    <div class="clear"></div>
                </div>

                <div class="library_list_content2">

                   {foreach $page->getaccessory['rows'] as $v}


                     <div class="library_type_c">

                       {if $v['match'][1][0] == 'rar'}

                           <img src="img/raiders_list/rar_icon.png">
                           {elseif $v['match'][1][0] == 'pdf'}
                           <img src="img/raiders_list/pdf_icon.png">
                       {elseif $v['match'][1][0] == 'png'}
                           <img src="img/raiders_list/png_icon.png">
                       {elseif $v['match'][1][0] == 'txt' || $v['match'][1][0] == 'TXT'}
                           <img src="img/raiders_list/txt_icon.png">
                       {elseif $v['match'][1][0] == 'docx' || $v['match'][1][0] == 'doc'}
                           <img src="img/raiders_list/word_icon.png">
                       {elseif $v['match'][1][0] == 'pptx' || $v['match'][1][0] == 'ppt'}
                           <img src="img/raiders_list/wps_icon.png">
                       {elseif $v['match'][1][0] == 'xlsx' || $v['match'][1][0] == 'xls'}
                           <img src="img/raiders_list/excel_icon.png">
                       {/if}
                    </div>

                    <div class="library_name_c">
                        {if mb_strlen($v['title'],'UTF-8')>27}
                            <a href="{$_root}raiders-info/{$v['id']}.html">{mb_substr($v['title'],0,26,'utf-8')}...</a>
                        {else}
                            <a href="{$_root}raiders-info/{$v['id']}.html">{$v['title']}</a>
                        {/if}
                    </div>
                    <div class="library_classify_c">{$v['category_name']}</div>
                    <div class="library_download_c">{$v['download']}次</div>
                    <div class="library_size_c">{round(($v['accessory']['size'])/1024)}KB</div>
                    <div class="clear"></div>
                {/foreach}
                </div>

            </div>

            <!--页码部分-->
            {if $page->getRaidersList['page']['dt'] !=0}
                <div class="pagers">
                    {if $page->getRaidersList['page']['dpll']}
                        <a href="{$page->getRaidersList['page']['dup']}1" title="First">第一页</a>
                        <a href="{$page->getRaidersList['page']['dup']}{$page->getRaidersList['page']['dp']-1}"
                           title="Prev">上一页</a>
                    {else}
                        <a href="" class="prev first gray"><span>&laquo;&nbsp;</span>第一页</a>
                        <a href="" class="prev gray">&lt;&nbsp;上一页</a>
                    {/if}
                    {for $i=$page->getRaidersList['page']['dpl'] to $page->getRaidersList['page']['dpr']}
                        <a href="{$page->getRaidersList['page']['dup']}{$i}"{if $i==$page->getRaidersList['page']['dp']} class="active"{/if}>{$i}</a>
                    {/for}

                    {if $page->getRaidersList['page']['dprr']}
                        <a href="{$page->getRaidersList['page']['dup']}{$page->getRaidersList['page']['dp']+1}"
                           title="Next">下一页&nbsp;&gt;</a>
                        <a href="{$page->getRaidersList['page']['dup']}{$page->getRaidersList['page']['dtp']}"
                           title="Last">最后页&nbsp;&raquo;</a>
                    {else}
                        <a href="" class="next gray">下一页&nbsp;&gt;</a>
                        <a href="" class="next last gray">最后页<span>&nbsp;&raquo;</span></a>
                    {/if}
                </div>
            {else}
                <div class=" fl clearfix no-r-raider">
                    {include file="Web::inc/service_list_fl_no_result.tpl"}
                </div>
            {/if}

        </div>
        <!--raiders-main-end-->

        <div class="raiders-sidebar fr">
            <div class="raiders-sidebar-title">
                <h3>猜你喜欢</h3>

                <p>推广</p>
            </div>

            <ul class="raiders-sidebar-cont">
                {foreach $page->guessYouLike as $val}
                    <li>
                        <a href="/service_info/{$val['id']}.html" class="raiders-sidebar-img">
                            {if $val['logo']}
                                <img src="{Page_Site_Global::displayMedia($val['logo'],275,195)}" style="width: 215px;height: 155px">
                            {else}
                                <img src="{Core::$urls['assets']}img/logo_a.png" style="width: 215px;height: 155px" title="{$val['product_name']}">
                            {/if}
                        </a>
                        <a href="/service_info/{$val['id']}.html" class="raiders-sidebar-tit">{$val['product_name']}</a>
                    </li>
                {/foreach}
            </ul>
        </div>
        <!--raiders-sidebar-end-->
    </div>
    <!--raiders-wrap-end-->
</div>
<!--container-end-->
{include file="Web_Static::v2.0/form.tpl"}
{include file="Web_Static::v2.0/html_footer.tpl"}
{static "core/yunspace.js"}
</body>
</html>