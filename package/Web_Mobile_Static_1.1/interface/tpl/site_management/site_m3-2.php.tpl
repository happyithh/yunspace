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
        <a href="/m/test_site/basic_info?space_pedia_id={$_REQUEST['space_pedia_id']}"> <li >基本信息</li></a>
        <a href="/m/test_site/space_std?space_pedia_id={$_REQUEST['space_pedia_id']}"><li>空间标准</li></a>
        <a href="/m/test_site/mating_service?space_pedia_id={$_REQUEST['space_pedia_id']}">{if $data['status']==0}<li class="site_tab_active" style="padding-left: 15px;">配套设施<img style="width: 16px;height: 16px;float: right;" src="img/site_management/check.png" /></li>{elseif $data['status']==2}<li class="site_tab_active" style="padding-left: 15px;">配套设施<img style="width: 16px;height: 16px;float: right;" src="img/site_management/refuse.png" /></li>{else}<li class="site_tab_active">配套设施</li>{/if}</a>
        {*<a href="/m/test_site/use_std?space_pedia_id={$data['id']}"><li>使用规格</li></a>*}
        {*<a href="/m/test_site/mating_drink?space_pedia_id={$data['id']}"><li>配套饮品</li></a>*}
        {*<a href="/m/test_site/money_std?space_pedia_id={$data['id']}"><li>收费标准</li></a>*}
        <a href="/m/test_site/act_apply?space_pedia_id={$_REQUEST['space_pedia_id']}"><li>活动适用</li></a>
        <a href="/m/test_site/image_show?space_pedia_id={$_REQUEST['space_pedia_id']}"><li>图片管理</li></a>
        {*<a href="/m/test_site/space_item_list?space_pedia_id={$data['id']}"><li>子空间管理</li></a>*}
    </ul>
</div>

{*3配套设施表单*}
<form class="form-horizontal" role="form" action="?" method="post" enctype="multipart/form-data">
<div class="content_m mt10">
    <div class="site_tab_title">配套设施</div>
    <table class="site_attr">
        <tr>
            <td class="site_attr_title">洗手间</td>
            <td class="site_attr_content1"><input class="site_input" type="hidden" placeholder="" name="data[attr][14]" value="{$data['data_backup']['attr'][14]}"></td>
            <td class="site_attr_content2">
                {if !empty($data['data_backup']['attr'][14])}
                    <div class="site_attr_selected">
                        <span class="icon-ok"></span>
                    </div>
                {else}
                    <div class="site_attr_unselected">
                        <span></span>
                    </div>
                {/if}
                {*<input type="hidden" name="data[attr][21]" value="{$data['attr'][21]}" />*}
            </td>
        </tr>
        <tr>
            <td class="site_attr_title">化妆间</td>
            <td class="site_attr_content1"><input class="site_input" type="hidden" placeholder="" name="data[attr][13]" value="{$data['data_backup']['attr'][13]}"></td>
            <td class="site_attr_content2">
                {if !empty($data['data_backup']['attr'][13])}
                    <div class="site_attr_selected">
                        <span class="icon-ok"></span>
                    </div>
                {else}
                    <div class="site_attr_unselected">
                        <span></span>
                    </div>
                {/if}
                {*<input type="hidden" name="data[attr][21]" value="{$data['attr'][21]}" />*}
            </td>
        </tr>
        <tr>
            <td class="site_attr_title">休息室</td>
            <td class="site_attr_content1"><input class="site_input" type="hidden" placeholder="" name="data[attr][12]" value="{$data['data_backup']['attr'][12]}"></td>
            <td class="site_attr_content2">
                {if !empty($data['data_backup']['attr'][12])}
                    <div class="site_attr_selected">
                        <span class="icon-ok"></span>
                    </div>
                {else}
                    <div class="site_attr_unselected">
                        <span></span>
                    </div>
                {/if}
                {*<input type="hidden" name="data[attr][21]" value="{$data['attr'][21]}" />*}
            </td>
        </tr>
        <tr>
            <td class="site_attr_title">空间吊点</td>
            <td class="site_attr_content1"><input class="site_input" type="hidden" placeholder="" name="data[attr][15]" value="{$data['data_backup']['attr'][15]}"></td>
            <td class="site_attr_content2">
                {if !empty($data['data_backup']['attr'][15])}
                    <div class="site_attr_selected">
                        <span class="icon-ok"></span>
                    </div>
                {else}
                    <div class="site_attr_unselected">
                        <span></span>
                    </div>
                {/if}
                {*<input type="hidden" name="data[attr][21]" value="{$data['attr'][21]}" />*}
            </td>
        </tr>
        <tr>
            <td class="site_attr_title">空调暖气</td>
            <td class="site_attr_content1"><input class="site_input" type="hidden" placeholder="" name="data[attr][17]" value="{$data['data_backup']['attr'][17]}"></td>
            <td class="site_attr_content2">
                {if !empty($data['data_backup']['attr'][17])}
                    <div class="site_attr_selected">
                        <span class="icon-ok"></span>
                    </div>
                {else}
                    <div class="site_attr_unselected">
                        <span></span>
                    </div>
                {/if}
                {*<input type="hidden" name="data[attr][21]" value="{$data['attr'][21]}" />*}
            </td>
        </tr>
        <tr>
            <td class="site_attr_title">网络WIFI</td>
            <td class="site_attr_content1"><input class="site_input" type="hidden" placeholder="" name="data[attr][18]" value="{$data['data_backup']['attr'][18]}"></td>
            <td class="site_attr_content2">
                {if !empty($data['data_backup']['attr'][18])}
                    <div class="site_attr_selected">
                        <span class="icon-ok"></span>
                    </div>
                {else}
                    <div class="site_attr_unselected">
                        <span></span>
                    </div>
                {/if}
                {*<input type="hidden" name="data[attr][21]" value="{$data['attr'][21]}" />*}
            </td>
        </tr>
        <tr>
            <td class="site_attr_title">停车泊位</td>
            <td class="site_attr_content1">
                <table>
                    <tr>
                        <td class="wid95"><input class="site_input" type="hidden" placeholder="" name="data[attr][5]" value="{$data['data_backup']['attr'][5]}"></td>
                        <td></td>
                    </tr>
                </table>
            </td>
            <td class="site_attr_content2">
                {if !empty($data['data_backup']['attr'][5])}
                    <div class="site_attr_selected">
                        <span class="icon-ok"></span>
                    </div>
                {else}
                    <div class="site_attr_unselected">
                        <span></span>
                    </div>
                {/if}
            </td>
            {*<td class="site_attr_content2">*}
            {*<div class="site_attr_selected">*}
            {*<span class="icon-ok"></span>*}
            {*</div>*}
            {*</td>*}
        </tr>
        <tr>
            <td class="site_attr_title">货运电梯</td>
            <td class="site_attr_content1">
                <input class="site_input" placeholder="可输入描述" type="hidden" name="data[attr][19]" value="{$data['data_backup']['attr'][19]}">
            </td>
            <td class="site_attr_content2">
                {if !empty($data['data_backup']['attr'][19])}
                    <div class="site_attr_selected">
                        <span class="icon-ok"></span>
                    </div>
                {else}
                    <div class="site_attr_unselected">
                        <span></span>
                    </div>
                {/if}
            </td>
        </tr>
        <tr>
            <td class="site_attr_title">投影LED</td>
            <td class="site_attr_content1">
                <input class="site_input" placeholder="可输入描述" type="hidden" name="data[attr][20]" value="{$data['data_backup']['attr'][20]}">
            </td>
            <td class="site_attr_content2">
                {if !empty($data['data_backup']['attr'][20])}
                    <div class="site_attr_selected">
                        <span class="icon-ok"></span>
                    </div>
                {else}
                    <div class="site_attr_unselected">
                        <span></span>
                    </div>
                {/if}
            </td>
        </tr>
        <tr>
            <td class="site_attr_title">灯光音响</td>
            <td class="site_attr_content1"><input class="site_input" type="hidden" placeholder="" name="data[attr][21]" value="{$data['data_backup']['attr'][21]}"></td>
            <td class="site_attr_content2">
                {if !empty($data['data_backup']['attr'][21])}
                    <div class="site_attr_selected">
                        <span class="icon-ok"></span>
                    </div>
                {else}
                    <div class="site_attr_unselected">
                        <span></span>
                    </div>
                {/if}
                {*<input type="hidden" name="data[attr][21]" value="{$data['attr'][21]}" />*}
            </td>
        </tr>
        <tr>
            <td class="site_attr_title">餐饮</td>
            <td class="site_attr_content1"><input class="site_input" type="hidden" placeholder="" name="data[attr][24]" value="{$data['data_backup']['attr'][24]}"></td>
            <td class="site_attr_content2">
                {if !empty($data['data_backup']['attr'][24])}
                    <div class="site_attr_selected">
                        <span class="icon-ok"></span>
                    </div>
                {else}
                    <div class="site_attr_unselected">
                        <span></span>
                    </div>
                {/if}
                {*<input type="hidden" name="data[attr][21]" value="{$data['attr'][21]}" />*}
            </td>
        </tr>


    </table>
    <input name="data[space_pedia_id]" value="{$space_pedia_id}" type="hidden">
    {*<input name="data[attr_new]" value='{$data_attr}' type="hidden">*}
    <input name="is_submit" value="1" type="hidden">
</div>

<button class="site_confirm_btn">保存</button>
</form>
{static "v1.0/jquery-1.11.1.min.js"}
{static "core/yunspace.js"}
{static "site_management/site_m.js"}
</body>
</html>