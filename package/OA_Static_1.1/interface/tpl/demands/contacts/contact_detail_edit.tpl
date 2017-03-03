<!DOCTYPE html>
<!--[if IE 8]>
<html lang="en" class="ie8 no-js"> <![endif]-->
<!--[if IE 9]>
<html lang="en" class="ie9 no-js"> <![endif]-->
<!--[if !IE]><!-->
<html lang="en" class="no-js">
<!--<![endif]-->
<!-- BEGIN HEAD -->
<head>
    <script src="{$_assets}plugins/jquery-1.11.0.min.js" type="text/javascript"></script>
    <script src="{$_assets}plugins/bootstrap/js/bootstrap.min.js" type="text/javascript"></script>
    <script type="text/javascript" src="{$_assets}plugins/select2/select2.min.js"></script>
    <title>{$title}</title>
    {include "Admin::inc/html_head.tpl"}

</head>

<body style="background:#FaFaFa !important">
<div class="tab-content clearfix">
<form action="?action=contact_detail_from_submit" method="post" class="clearfix form-horizontal">
<input type="hidden" name="id" value="{$data['id']}"/>
<input type="hidden" name="demand_id" value="{$data['demand_id']}">
<input type="hidden" name="account_id" value="{$data['account_id']}">

<div class="form-body">
<div class="clearfix">

    <div class="form-group col-md-6">
        <label class="col-md-3 control-label">联系人分级</label>

        <div class="col-md-9">
            <label class="radio-inline">
                <input type="radio" name="data[state]" value="5" {if $data['state']==5}checked{/if}>
                A
            </label>
            <label class="radio-inline">
                <input type="radio" name="data[state]" value="4" {if $data['state']==4}checked{/if}>
                B
            </label>
            {if $data['state']}
                <label class="radio-inline">
                    <input type="radio" name="data[state]" value="3" {if $data['state']==3}checked{/if}>
                    C
                </label>
            {else}
                <label class="radio-inline">
                    <input type="radio" name="data[state]" value="3" checked>
                    C
                </label>
            {/if}
            <label class="radio-inline">
                <input type="radio" name="data[state]" value="2" {if $data['state']==2}checked{/if}>
                D
            </label>
            {*<label class="radio-inline">*}
            {*<input type="radio" name="data[state]" value="5" {if $data['state']==5}checked{/if}>*}
            {*5*}
            {*</label>*}
        </div>
    </div>
    {*客户类型 KV 或 标准*}
    <div class="{if $data['type']==21}display-none{/if} " style="width: 100%;" id="customerType">
        <div class="form-group col-md-6">
            <label class="col-md-3 control-label sub_business">客户类型：</label>

            <div class="col-md-9">
                <label class="radio-inline">
                    <input type="radio" name="data[customer_type]" value="2"
                           {if $data['customer_type']!=1}checked{/if} >
                    标准产品客户
                </label>
                <label class="radio-inline">
                    <input type="radio" name="data[customer_type]" value="1" {if $data['customer_type']==1}checked{/if}>
                    KA客户
                </label>
            </div>
        </div>
    </div>
    <div class="form-group col-md-6">
        <label class="col-md-3 control-label">手机号<span class="required" aria-required="true">*</span></label>

        <div class="col-md-9">
            <input type="text" class="form-control input-sm" placeholder="手机或电话-例：13888888888/0218888888"
                   name="data[手机号]" value="{$data['phone']|default:$_REQUEST['phone']}">
        </div>
    </div>
    <div class="form-group col-md-6">
        <label class="col-md-3 control-label">姓名<span class="required" aria-required="true">*</span></label>

        <div class="col-md-9">
            <input type="text" class="form-control input-sm" placeholder="姓名" name="data[姓名]"
                   value="{$data['username']}">
        </div>
    </div>
</div>
<div class="clearfix">
    <div class="form-group col-md-6">
        <label class="col-md-3 control-label">业务类型<span class="required" aria-required="true">*</span></label>

        {*<div class="col-md-9">*}
        {*<select class="form-control input-sm" name="data[业务类型]" id="business" value="{$data['business']}">*}
        {*<option value="{$data['business']}">{$data['business']}</option>*}
        {*</select>*}
        {*</div>*}
        <div class="col-md-9">
            <select class="form-control input-sm" name="data[业务类型]" id="business" value="{$data['business']}">
                {foreach $categoryList[0] as $key=>$value}
                    {if $value}
                        <option value="{$key}{$value}"
                                {if $key== intval($data['business'])}selected {/if}>{$key}{$value}</option>
                    {/if}
                {/foreach}
            </select>
        </div>
    </div>
    <div class="form-group col-md-6">
        <label class="col-md-3 control-label sub_business">业务子类</label>

        <div class="col-md-9">
            {if $data['business']}
                <select class="form-control input-sm" name="data[业务子类]" id="subBusiness" value="">
                    {foreach $categoryList as $ck=>$cv}
                        {if intval($data['business'])==$ck}
                            {foreach $cv as $cvk=>$cvv}
                                <option value="{$cvk}{$cvv}"
                                        {if $cvk==intval($data['sub_business'])}selected {/if}>{$cvk}{$cvv}</option>
                            {/foreach}
                        {/if}
                    {/foreach}
                </select>
            {else}
                <select class="form-control input-sm" name="data[业务子类]" id="subBusiness" value="">
                    <option value="{$data['sub_business']}">{$data['sub_business']}</option>
                </select>
            {/if}

        </div>
    </div>
</div>
<div class="form-group col-md-6">
    <label class="col-md-3 control-label">城市<span class="required" aria-required="true">*</span></label>

    <div class="col-md-9">
        <select class="form-control" name="data[城市]" onchange="changeCity(this)">
            {foreach $_REQUEST['cities'] as $v}
                <option value="{$v}" {if $v==$data['city']}selected="selected" {/if}>
                    {$v}
                </option>
            {/foreach}
            <option>其他</option>
        </select>
    </div>
</div>
<div class="form-group col-md-6">
    <label class="col-md-3 control-label">公司电话</label>

    <div class="col-md-9">
        <input type="text" class="form-control input-sm" placeholder="公司电话" name="data[公司电话]" value="{$data['tel']}">
    </div>
</div>
<h4 style="font-weight: bold!important; padding-left: 15px; margin:25px 0 15px" class="col-md-10">
    基本信息
</h4>

<div class="clearfix">
    <div class="form-group col-md-6">
        <label class="col-md-3 control-label">性别</label>

        <div class="col-md-9">
            <select class="form-control input-sm" name="data[attr][基本信息][性别]" value="{$data['attr']['基本信息']['性别']}">
                <option value="男" {if $data['attr']['基本信息']['性别']=='男'}selected="selected" {/if}>
                    男
                </option>
                <option value="女">女</option>
            </select>
        </div>
    </div>
    <div class="form-group col-md-6">
        <label class="col-md-3 control-label">年龄</label>

        <div class="col-md-9">
            <input type="text" class="form-control input-sm" placeholder="年龄" name="data[attr][基本信息][年龄]"
                   value="{$data['attr']['基本信息']['年龄']}">
        </div>
    </div>

    <div class="form-group col-md-6">
        <label class="col-md-3 control-label">籍贯</label>

        <div class="col-md-9">
            <input type="text" class="form-control input-sm" placeholder="籍贯" name="data[attr][基本信息][籍贯]"
                   value="{$data['attr']['基本信息']['籍贯']}">
        </div>
    </div>
    <div class="form-group col-md-6">
        <label class="col-md-3 control-label">学历</label>

        <div class="col-md-9">
            <input type="text" class="form-control input-sm" placeholder="学历" name="data[attr][基本信息][学历]"
                   value="{$data['attr']['基本信息']['学历']}">
        </div>
    </div>
    <div class="form-group col-md-6">
        <label class="col-md-3 control-label">兴趣</label>

        <div class="col-md-9">
            <input type="text" class="form-control input-sm" placeholder="兴趣" name="data[attr][基本信息][兴趣]"
                   value="{$data['attr']['基本信息']['兴趣']}">
        </div>
    </div>
</div>

<h4 style="font-weight: bold!important; padding-left: 15px; margin:25px 0 15px">
    联系方式</h4>

<div class="clearfix">
    <div class="form-group col-md-6">
        <label class="col-md-3 control-label">电子邮箱</label>

        <div class="col-md-9">
            <input type="text" class="form-control input-sm" placeholder="电子邮箱" name="data[attr][联系方式][电子邮箱]"
                   value="{$data['attr']['联系方式']['电子邮箱']}">
        </div>
    </div>
    <div class="form-group col-md-6">
        <label class="col-md-3 control-label">家庭住址</label>

        <div class="col-md-9">
            <input type="text" class="form-control input-sm" placeholder="家庭住址" name="data[attr][联系方式][家庭住址]"
                   value="{$data['attr']['联系方式']['家庭住址']}">
        </div>
    </div>
    <div class="form-group col-md-6">
        <label class="col-md-3 control-label">微信</label>

        <div class="col-md-9">
            <input type="text" class="form-control input-sm" placeholder="微信" name="data[attr][联系方式][微信]"
                   value="{$data['attr']['联系方式']['微信']}">
        </div>
    </div>
    <div class="form-group col-md-6">
        <label class="col-md-3 control-label">微博</label>

        <div class="col-md-9">
            <input type="text" class="form-control input-sm" placeholder="微博" name="data[attr][联系方式][微博]"
                   value="{$data['attr']['联系方式']['微博']}">
        </div>
    </div>
    <div class="form-group col-md-6">
        <label class="col-md-3 control-label">qq</label>

        <div class="col-md-9">
            <input type="text" class="form-control input-sm" placeholder="qq" name="data[attr][联系方式][qq]"
                   value="{$data['attr']['联系方式']['qq']}">
        </div>
    </div>
</div>

<h4 style="font-weight: bold!important; padding-left: 15px; margin:25px 0 15px">
    公司信息</h4>

<div class="clearfix">
    <div class="form-group col-md-6">
        <label class="col-md-3 control-label">公司名称</label>

        <div class="col-md-9">
            <input type="text" class="form-control input-sm" placeholder="公司名称" name="data[公司名称]"
                   value="{$data['company']}">
        </div>
    </div>
    <div class="form-group col-md-6">
        <label class="col-md-3 control-label">公司职位</label>

        <div class="col-md-9">
            <input type="text" class="form-control input-sm" placeholder="公司职位" name="data[公司职位]"
                   value="{$data['position']}">
        </div>
    </div>
    <div class="form-group col-md-6">
        <label class="col-md-3 control-label">所在行业</label>

        <div class="col-md-9">
            <input type="text" class="form-control input-sm" placeholder="所在行业" name="data[attr][公司信息][所在行业]"
                   value="{$data['attr']['公司信息']['所在行业']}">
        </div>
    </div>
    <div class="form-group col-md-6">
        <label class="col-md-3 control-label">从业年数</label>

        <div class="col-md-9">
            <input type="text" class="form-control input-sm" placeholder="从业年数" name="data[attr][公司信息][从业年数]"
                   value="{$data['attr']['公司信息']['从业年数']}">
        </div>
    </div>
    <div class="form-group col-md-6">
        <label class="col-md-3 control-label">公司地址</label>

        <div class="col-md-9">
            <input type="text" class="form-control input-sm" placeholder="公司地址" name="data[attr][公司信息][公司地址]"
                   value="{$data['attr']['公司信息']['公司地址']}">
        </div>
    </div>
    <div class="form-group col-md-6">
        <label class="col-md-3 control-label">公司网站</label>

        <div class="col-md-9">
            <input type="text" class="form-control input-sm" placeholder="公司网站" name="data[attr][公司信息][公司网站]"
                   value="{$data['attr']['公司信息']['公司网站']}">
        </div>
    </div>
    <div class="form-group col-md-6">
        <label class="col-md-3 control-label">人数规模</label>

        <div class="col-md-9">
            <input type="text" class="form-control input-sm" placeholder="人数规模" name="data[attr][公司信息][人数规模]"
                   value="{$data['attr']['公司信息']['人数规模']}">
        </div>
    </div>
</div>


<h4 style="font-weight: bold!important; padding-left: 15px; margin:25px 0 15px">
    其他备注</h4>

<div class="clearfix">
    <div class="form-group col-md-12">
        <div class="col-md-11">
            <textarea class="form-control" rows="5" name="data[attr][其他备注]">{$data['attr']['其他备注']}</textarea>
        </div>
    </div>
</div>

</div>
<div class="text-center" style="padding-bottom: 15px">
    <button type="reset" class="btn btn-default">
        重置
    </button>
    <button type="submit" class="btn btn-success">
        提交
    </button>
</div>
</form>
</div>
<script>
    $("#type_but input").on("click", function (e) {
        var type = $(this).val();
        if (type == 21) {
            $("#customerType").hide();
        }
        if (type == 1) {
            $("#customerType").show();
        }
    })
    var category = [
        {foreach $categoryList[0] as $k=>$v}
        {if $v}
        {
            'b': '{$k}{$v}',
            's': [
                {foreach $categoryList[$k] as $kk=>$vv}{if $vv}
                '{$kk}{$vv}',
                {/if}{/foreach}
            ]
        },
        {/if}
        {/foreach}
    ];
    $(document).ready(function () {
        var business_val = $('#business').attr('value');
        if (!business_val) {
            oSubBusiness(0);
        }
    })
    var bHtml = '<option value="{$data['business']}">{$data['business']}</option>';
    $('#business').change(function () {
        var index = $('#business').get(0).selectedIndex;
        if (index >= 0) {
            oSubBusiness(index);
        } else {
            $('#subBusiness').attr("disabled", true);
            $('#subBusiness').html('<option value="{$data['sub_business']}">{$data['sub_business']}</option>');
        }

    })
    for (var i = 0; i < category.length; i++) {
        bHtml += "<option value='" + category[i]['b'] + "'>" + category[i]['b'] + "</option>";
    }

    var oSubBusiness = function (i) {
        var oSubBusinessList = category[i]['s'], sHtml;
        for (var j = 0; j < category[i]['s'].length; j++) {
            sHtml += "<option value='" + category[i]['s'][j] + "'>" + category[i]['s'][j] + "</option>";
        }
        $('#subBusiness').html(sHtml);
        $('#subBusiness').removeAttr('disabled')
    }

    {*$('#business').html(bHtml);*}
</script>
</body>
<!-- END BODY -->
</html>