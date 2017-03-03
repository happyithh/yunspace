<!DOCTYPE html>
<html lang="en">
<head>
    {include "Web_Mobile_Static::site_management/inc.meta.tpl"}
    {static "v1.0/global.css"}
    {static "site_management/footer.css"}
    {static "site_management/site_m.css"}
</head>
<body>
{*头部*}
<header class="site_header">
    <div class="clear_float">
        <div class="header_left">
            <a href="test0"> <span class="icon-angle-left"></span></a>
        </div>
        <div class="header_middle">
            场地管理
        </div>
    </div>
</header>
<div class="clear"></div>

{*tab切换*}
<div class="site_tab_outside mt50">
    <ul class="site_tab">
        <a href="test1-1"> <li>基本信息</li></a>
        <a href="test2-1"><li>空间标准</li></a>
        <a href="test3-1"><li>配套设施</li></a>
        <a href="test4-1"><li>使用规格</li></a>
        <a href="test5-1"><li>配套饮品</li></a>
        <a href="test6-1"><li>收费标准</li></a>
        <a href="test7-1"><li>活动适用</li></a>
        <a href="test8-1"><li class="site_tab_active">图片管理</li></a>
        <a href="test9-1"><li>子空间管理</li></a>
    </ul>
</div>


{*8图片管理*}
<div class="content_m mt10">
    <div class="site_pic_b_t">场地首页banner图</div>
    <div class="site_pic_b">
        <img src="img/site_management/site_pic_b.jpg">
    </div>
    <button class="change_pic">更改图片</button>
    <div class="change_pic_des">请上传尺寸为1920*520的图片，<br/>
        由于图片较大，建议在电脑端操作
    </div>

    <div class="site_pic_t">
        <a name="quxiao"></a>
        <div class="site_pic_word">场地图片</div>
        <a href="test8-2#bianji" class="site_pic_btn">编辑</a>
        <div class="clear"></div>
    </div>
    <div class="site_list_outside">
    <div class="site_list">
    <div class="site_pic">
        <div class="site_pic_s"><img src="img/site_management/site_pic.jpg"></div>
        <div class="site_pic_c">
            <div class="site_pic_name">名称</div>
            <div class="site_pic_name_c0">星空广场</div>
            <div class="clear"></div>
        </div>
        <div class="site_pic_c">
            <div class="site_pic_name">所属空间</div>
            <div class="site_pic_name_c">露天广场</div>
            <select class="site_pic_name_c1 none">
               <option>露天广场</option>
               <option>露天露天</option>
            </select>
            <div class="clear"></div>

        </div>
        <div class="clear"></div>
    </div>
    <a href="javascript:" class="son_modify">修改</a>
    </div>

    <div class="site_list">
    <div class="site_pic">
        <div class="site_pic_s"><img src="img/site_management/site_pic.jpg"></div>
        <div class="site_pic_c">
            <div class="site_pic_name">名称</div>
            <div class="site_pic_name_c0">星空广场</div>
            <div class="clear"></div>
        </div>
        <div class="site_pic_c">
            <div class="site_pic_name"></div>
            <div class="site_pic_name_c">露天广场</div>
            <select class="site_pic_name_c1 none">
                <option>露天广场</option>
                <option>露天露天</option>
            </select>
            <div class="clear"></div>
        </div>
        <div class="clear"></div>
    </div>
    <a href="javascript:" class="son_modify">修改</a>
    </div>
    </div>
    <button class="site_add_pic">
        <span class="icon-plus"></span>添加更多图片
    </button>
</div>


{include "Web_Mobile_Static::site_management/inc.footer.tpl"}
{static "v1.0/jquery-1.11.1.min.js"}
{static "core/yunspace.js"}
{static "site_management/site_m.js"}
</body>
</html>