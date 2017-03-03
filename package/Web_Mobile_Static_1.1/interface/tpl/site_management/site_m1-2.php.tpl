<!DOCTYPE html>
<html lang="en">
<head>
    {include "Web_Mobile_Static::site_management/inc.meta.tpl"}
    {static "v1.0/global.css"}
    {static "site_management/footer.css"}
    {static "site_management/site_m.css"}

    {*<script src="{$_assets}plugins/jquery-1.11.0.min.js" type="text/javascript"></script>*}
    {*<script src="{$_assets}plugins/jquery-ui/jquery-ui-1.10.3.custom.min.js" type="text/javascript"></script>*}
    {*<script src="{$_assets}plugins/bootstrap/js/bootstrap.min.js" type="text/javascript"></script>*}
    {*<script src="{$_assets}plugins/bootstrap-hover-dropdown/bootstrap-hover-dropdown.min.js" type="text/javascript"></script>*}
    {*<script src="{$_assets}plugins/jquery-slimscroll/jquery.slimscroll.min.js" type="text/javascript"></script>*}
    {*<script src="{$_assets}plugins/jquery.blockui.min.js" type="text/javascript"></script>*}
    {*<script src="{$_assets}plugins/uniform/jquery.uniform.min.js" type="text/javascript"></script>*}
    <!-- END CORE PLUGINS -->
    <!-- BEGIN PAGE LEVEL PLUGINS -->
    <script type="text/javascript" src="plugins/select2-new/select2.min.js"></script>
    <!-- END PAGE LEVEL PLUGINS -->
    <!-- BEGIN PAGE LEVEL SCRIPTS -->
    {*<script src="{$_assets}scripts/_page.js"></script>*}
    {*<link rel="stylesheet" type="text/css" href="{$_assets}plugins/bootstrap-wysihtml5/bootstrap-wysihtml5.css"/>*}
    {*<script type="text/javascript" src="{$_assets}plugins/bootstrap-wysihtml5/wysihtml5-0.3.0.js"></script>*}
    {*<script type="text/javascript" src="{$_assets}plugins/bootstrap-wysihtml5/bootstrap-wysihtml5.js"></script>*}
    {*<link rel="stylesheet" type="text/css" href="{$_assets}plugins/jquery-tags-input/jquery.tagsinput.css"/>*}
    {*<script type="text/javascript" src="{$_assets}plugins/jquery-tags-input/jquery.tagsinput.min.js"></script>*}
    {*<link rel="stylesheet" type="text/css" href="{$_assets}plugins/jquery-multi-select/css/multi-select.css"/>*}
    {*<script type="text/javascript" src="{$_assets}plugins/jquery-multi-select/js/jquery.multi-select.js"></script>*}

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
        <a href="/m/test_site/basic_info?space_pedia_id={$_REQUEST['space_pedia_id']}">{if $data['status']==0}<li class="site_tab_active" style="padding-left: 15px;">基本信息<img style="width: 16px;height: 16px;float: right;" src="img/site_management/check.png" /></li>{elseif $data['status']==2}<li class="site_tab_active" style="padding-left: 15px;">基本信息<img style="width: 16px;height: 16px;float: right;" src="img/site_management/refuse.png" /></li>{else}<li class="site_tab_active">基本信息</li>{/if}</a>
        <a href="/m/test_site/space_std?space_pedia_id={$_REQUEST['space_pedia_id']}"><li>空间标准</li></a>
        <a href="/m/test_site/mating_service?space_pedia_id={$_REQUEST['space_pedia_id']}"><li>配套设施</li></a>
        {*<a href="/m/test_site/use_std?space_pedia_id={$data['id']}"><li>使用规格</li></a>*}
        {*<a href="/m/test_site/mating_drink?space_pedia_id={$data['id']}"><li>配套饮品</li></a>*}
        {*<a href="/m/test_site/money_std?space_pedia_id={$data['id']}"><li>收费标准</li></a>*}
        <a href="/m/test_site/act_apply?space_pedia_id={$_REQUEST['space_pedia_id']}"><li>活动适用</li></a>
        <a href="/m/test_site/image_show?space_pedia_id={$_REQUEST['space_pedia_id']}"><li>图片管理</li></a>
        {*<a href="/m/test_site/space_item_list?space_pedia_id={$data['id']}"><li>子空间管理</li></a>*}
    </ul>
</div>

{*1基本信息表单*}



<form class="form-horizontal" role="form" action="?" method="post" enctype="multipart/form-data">

<div class="content_m mt10">
    <div class="site_tab_title">基本信息</div>
    <table class="site_attr">
        <tr>
            <td class="site_attr_title">场地名称</td>
            <td class="site_attr_content" colspan="2">
                <input class="site_input" placeholder="请输入场地名称（必填）" value="{$data['data_backup']['space_name']}" name="data[space_name]">
            </td>
        </tr>
        <tr>
            <td class="site_attr_title">所属供应商</td>
            {*<td class="site_attr_content">{$data['vendor_name']}</td>*}
            <td class="site_attr_content" colspan="2" style="text-align: right;font-size: 15px;">{$data['vendor_name']}
               {*<input class="site_input" placeholder="星空华文国际传媒" value="{$data['vendor_name']}">*}
            </td>

            {*<div class="form-group" style="width:100px;height: 100px;">*}
                {*<label class="col-md-3 control-label">请选择供应商</label>*}
                {*<div class="col-md-7 vendor_div">*}
                    {*<div class="col-md-12 input-group select">*}
                        {*<input id="select2_sample6" type="hidden" class="form-control select2" name="data[vendor_id]" value="{$data['vendor_id']}">*}
                        {*<span class="vendor_msg"></span>*}
                    {*</div>*}
                {*</div>*}
            {*</div>*}
        </tr>
        <tr>
            <td class="site_attr_title">营销标题</td>
            <td class="site_attr_content" colspan="2">
               <input class="site_input" placeholder="请用一句话描述你的场地" value="{$data['data_backup']['attr']['营销标题']}" name="data[attr][营销标题]">
            </td>
        </tr>
        <tr>
            <td class="site_attr_title">特色标签</td>
            <td class="site_attr_content" colspan="2">
                {if !empty($data['data_backup']['attr']['特色标签'])}
                <a href="/m/test_site/tags_edit?space_pedia_id={$_REQUEST['space_pedia_id']}">
                    <ul class="site_pag">
                        {foreach $data['data_backup']['attr']['特色标签'] as $k=>$v}
                            <li>{$v}</li>
                        {/foreach}
                        <div class="clear"></div>
                        <div class="site_pag_edit">
                            <span class="icon-angle-right"></span>
                        </div>
                    </ul>
                </a>
                {else}
                 <a href="/m/test_site/tags_edit?space_pedia_id={$_REQUEST['space_pedia_id']}" class="site_pag">
                    快为您的场地添加标签吧
                    <div class="site_pag_edit">
                        <span class="icon-angle-right"></span>
                    </div>
                </a>
                {/if}
            </td>
        </tr>
        <tr>
            <td class="site_attr_title" rowspan="2">场地地址</td>
            <td class="site_attr_content" style="border-right: 1px solid #e1e1e1;text-align: right;font-size: 15px;">
                {*<select class="site_attr_select">*}
                    {*<option>上海市</option>*}
                {*</select>*}
                {$data['data_backup']['attr'][46]}
                {*<input class="site_input" placeholder="城市" value="{$data['attr'][46]}" name="data[attr][46]">*}
            </td>
            <td>
                {*<select class="site_attr_select">*}
                    {*<option>黄浦区</option>*}
                {*</select>*}
                <input class="site_input" placeholder="区域" value="{$data['data_backup']['attr'][4]}" name="data[attr][4]">
            </td>
        </tr>
        <tr>

            <td class="site_attr_content" colspan="2">
                <input class="site_input" placeholder="例如：淮海中路283号（必填）"  value="{$data['data_backup']['addr']}" name="data[addr]">
            </td>
        </tr>
        <tr>
            <td class="site_attr_title">所属商圈</td>
            <td class="site_attr_content" colspan="2">
                <a href="/m/test_site/business_edit?space_pedia_id={$_REQUEST['space_pedia_id']}">
                <ul class="site_pag">
                    {*<li>老西门</li>*}
                    {if !empty($data['data_backup']['attr'][2])}
                    {foreach $data['data_backup']['attr'][2] as $k=>$v}
                        <li>{$v}</li>
                    {/foreach}
                    {/if}
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
                <a href="/m/test_site/traffic_edit?space_pedia_id={$_REQUEST['space_pedia_id']}">
                <ul class="site_pag">
                    {*<li>4号线</li>*}
                    {*<li>10号线</li>*}
                    {if !empty($data['data_backup']['attr'][3])}
                    {foreach $data['data_backup']['attr'][3] as $k=>$v}
                        <li>{$v}</li>
                    {/foreach}
                    {/if}
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
                {*<textarea class="site_attr_area" name="data[des]" style="font-size: 15px;" placeholder="请输入15-500字内的场地描述信息（必填）">*}
                    {*{$data['data_backup']['des']}*}
                {*</textarea>*}
                <input type="hidden" name="data[des]" value="{$data['data_backup']['des']}" />
                <div class="site_attr_area" contenteditable="true" style="font-size: 15px;">{$data['data_backup']['des']}<br /></div>
            </td>
        </tr>
    </table>
    <input name="data[space_pedia_id]" value="{$space_pedia_id}" type="hidden">
    {*<input name="data[attr_new]" value='{$data_attr}' type="hidden">*}
    <input name="is_submit" value="1" type="hidden">

</div>
<button class="site_confirm_btn">保存</button>
</form>


<script>
    $(".site_attr_area").on("keyup blur",function(){
        var v=$(this).text();
        $("input[name='data[des]']").val(v);
//        console.log(v);
    });
    jQuery(document).ready(function () {
        $("#select2_sample6").select2({
            placeholder: "选择供应商",
            minimumInputLength: 1,
            ajax: {
                url: "?vendor_auto_complete=1",
                dataType: 'json',
                data: function (term, page) {
                    return {
                        q: term,
                        page_limit: 10
                    };
                },
                results: function (data, page) {
                    return {
                        results: data.items
                    };
                }
            },
            initSelection: function (element, callback) {
                var id = $(element).val();
                if (id !== "") {
                    $.ajax("?vendor_auto_complete=1", {
                        data: {
                            id: id
                        },
                        dataType: "json"
                    }).done(function (data) {
                        console.log(data);
                        callback(data.items[0]);
                    });
                }
            },
            formatResult: formatRepo,
            formatSelection: formatRepoSelection,
            escapeMarkup: function (m) {
                return m;
            }
        });
        function formatRepo(repo) {
            if (repo.loading) return repo.text;
            return repo.full_name;
        }

        function formatRepoSelection(repo) {
            return repo.full_name || repo.text;
        }
    });
</script>

{static "v1.0/jquery-1.11.1.min.js"}
{static "core/yunspace.js"}
{static "site_management/site_m.js"}
</body>
</html>