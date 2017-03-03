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
            <a href="javascript:history.go(-1);"> <span class="icon-angle-left"></span></a>
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
        <a href="test1-1"> <li class="site_tab_active">基本信息</li></a>
        <a href="test2-1"><li>空间标准</li></a>
        <a href="test3-1"><li>配套设施</li></a>
        <a href="test4-1"><li>使用规格</li></a>
        <a href="test5-1"><li>配套饮品</li></a>
        <a href="test6-1"><li>收费标准</li></a>
        <a href="test7-1"><li>活动适用</li></a>
        <a href="test8-1"><li>图片管理</li></a>
        <a href="test9-1"><li>子空间管理</li></a>
    </ul>
</div>

{*1基本信息表单*}
<div class="content_m mt10">
    <div class="site_tab_title">基本信息</div>
    <table class="site_attr">
        <tr>
            <td class="site_attr_title">场地名称</td>
            <td class="site_attr_content" colspan="2">
                <input class="site_input" placeholder="云Space">
            </td>
        </tr>
        <tr>
            <td class="site_attr_title">所属供应商</td>
            <td class="site_attr_content" colspan="2">
               <input class="site_input" placeholder="星空华文国际传媒">
            </td>
        </tr>
        <tr>
            <td class="site_attr_title">营销标题</td>
            <td class="site_attr_content" colspan="2">
               <input class="site_input" placeholder="时尚创意商业文化的“海派”新天地">
            </td>
        </tr>
        <tr>
            <td class="site_attr_title">特色标签</td>
            <td class="site_attr_content" colspan="2">
                 <a href="test1-3" class="site_pag">
                    快为您的场地添加标签吧
                    <div class="site_pag_edit">
                        <span class="icon-angle-right"></span>
                    </div>
                </a>

            </td>
        </tr>
        <tr>
            <td class="site_attr_title" rowspan="2">场地地址</td>
            <td class="site_attr_content" style="border-right: 1px solid #e1e1e1;">
                <select class="site_attr_select">
                    <option>上海市</option>
                </select>
            </td>
            <td>
                <select class="site_attr_select">
                    <option>黄浦区</option>
                </select>
            </td>
        </tr>
        <tr>

            <td class="site_attr_content" colspan="2">
                <input class="site_input" placeholder="外马路579号">
            </td>
        </tr>
        <tr>
            <td class="site_attr_title">所属商圈</td>
            <td class="site_attr_content" colspan="2">
                <a href="test1-5">
                <ul class="site_pag">
                    <li>外滩</li>
                    <li>老西门</li>
                    <div class="clear"></div>
                    <div class="site_pag_edit">
                        <span class="icon-angle-right"></span>
                    </div>
                </ul>
                    </a>
            </td>
        </tr>
        <tr>
            <td class="site_attr_title">轨道交通</td>
            <td class="site_attr_content" colspan="2">
                <a href="test1-4">
                <ul class="site_pag">
                    <li>4号线</li>
                    <li>10号线</li>
                    <div class="clear"></div>
                    <div class="site_pag_edit">
                        <span class="icon-angle-right"></span>
                    </div>
                </ul>
                    </a>
            </td>
        </tr>
        <tr>
            <td class="site_attr_title">场地描述</td>
            <td class="site_attr_content" colspan="2">
                <textarea class="site_attr_area">

                </textarea>
            </td>
        </tr>
    </table>
</div>
<button class="site_confirm_btn">保存</button>

{static "v1.0/jquery-1.11.1.min.js"}
{static "core/yunspace.js"}
{static "site_management/site_m.js"}
</body>
</html>