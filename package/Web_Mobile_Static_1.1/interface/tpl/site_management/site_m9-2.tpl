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
        <a href="test1-1"> <li>基本信息</li></a>
        <a href="test2-1"><li>空间标准</li></a>
        <a href="test3-1"><li>配套设施</li></a>
        <a href="test4-1"><li>使用规格</li></a>
        <a href="test5-1"><li>配套饮品</li></a>
        <a href="test6-1"><li>收费标准</li></a>
        <a href="test7-1"><li>活动适用</li></a>
        <a href="test8-1"><li>图片管理</li></a>
        <a href="test9-1"><li class="site_tab_active">子空间管理</li></a>
    </ul>
</div>


{*9子空间管理表单*}
<div class="content_m mt10">
    <div class="site_tab_title">子空间管理</div>
    <table class="site_attr">
        <tr>
            <td class="site_attr_title">所属场地</td>
            <td class="site_attr_content" style="text-align: right;">星空广场</td>
        </tr>
        <tr>
            <td class="site_attr_title">子空间名称</td>
            <td class="site_attr_content">
                <input class="site_input" placeholder="星空广场1F露天广场">
            </td>
        </tr>
        <tr>
            <td class="site_attr_title">面积</td>
            <td class="site_attr_content">
                <table>
                    <tr>
                        <td class="site_attr_content1 born"><input class="site_input" placeholder="2000"></td>
                        <td class="site_attr_content2 born">㎡</td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr>
            <td class="site_attr_title">子空间标签</td>
            <td class="site_attr_content">
                <a href="#">
                <ul class="site_pag">
                    <li>露天场地</li>
                    <li>人流大</li>
                    <div class="clear"></div>
                    <div class="site_pag_edit">
                        <span class="icon-angle-right"></span>
                    </div>
                </ul>
                </a>
            </td>
        </tr>
        <tr>
            <td class="site_attr_title">场地租金</td>
            <td class="site_attr_content">
                <table>
                    <tr>
                        <td class="site_attr_content1 born">¥</td>
                        <td class="site_attr_content2 born wid20"><input class="site_input" placeholder="60000"></td>
                    </tr>
                </table>

            </td>

        </tr>
        <tr>
            <td class="site_attr_title">容纳人数</td>
            <td class="site_attr_content">
                <table>
                    <tr>
                        <td class="site_attr_content1 born"><input class="site_input" placeholder="800"></td>
                        <td class="site_attr_content2 born">人</td>
                    </tr>
                </table>

            </td>
        </tr>
        <tr>
            <td class="site_attr_title" rowspan="2">空间描述</td>
            <td class="site_attr_content" id="son_space_des">
                <div class="same_site_des">同场地描述</div>
                <div class="site_attr_selected site_fr">
                    <span class="icon-ok"></span>
                </div>
                <div class="clear"></div>
            </td>
        </tr>
        <tr>
            <td class="site_attr_content">
                <textarea class="son_space_input"></textarea>
            </td>
        </tr>
        <tr>
            <td class="site_attr_title">子空间联系人</td>
            <td class="site_attr_content">
                <input class="site_input" placeholder="王先生">
            </td>
        </tr>
        <tr>
            <td class="site_attr_title">联系人手机号</td>
            <td class="site_attr_content">
                <input class="site_input" placeholder="1388888888">
            </td>
        </tr>
        <tr>
            <td class="site_attr_title">联系人邮箱</td>
            <td class="site_attr_content">
                <input class="site_input" placeholder="2558623@qq.com">
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