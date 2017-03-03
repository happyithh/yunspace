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
    <title>{$title}</title>
    <meta content="" name="description"/>
    {include "Admin::inc/html_head.tpl"}
    <link href="style/css.css" rel="stylesheet"/>
    <style>
        .readdata p {
            padding: 0
        }
    </style>
</head>
<!-- END HEAD -->
<!-- BEGIN BODY -->

<body style="background:#FaFaFa !important">
<div class="portlet">
<div class="portlet-title">
    <div class="caption">
        <i class="fa fa-cogs"></i>
        {if $isAddMine}
            添加我的联系人
        {else}
            添加公共联系人
        {/if}
    </div>

</div>
<div class="portlet-body">

<form {if $isAddMine}action="doAddMyContact" {else}action="doAddContact"   {/if} method="post" class="clearfix">

<input type="hidden" value="{$_REQUEST['did']}" name="did">

<div class="clearfix" id="tab_1_1">
<div id="businessWrap">
    <div class="col-md-12">
        <div class="form-group col-md-7">
            <label class="col-md-3 control-label sub_business">选择联系人类型</label>
            <div class="col-md-9">
                <label class="radio-inline">
                    <input type="radio" name="type" value="1" {if $type==1}checked{/if}>
                    客户
                </label>
                <label class="radio-inline">
                    <input type="radio" name="type" value="21" {if $type==21}checked{/if}>
                    供应商
                </label>
            </div>
        </div>
    </div>
    <div class="col-md-12">
        <div class="form-group col-md-7">
            <label class="col-md-3 control-label">手机号<span class="required" aria-required="true">*</span></label>

            <div class="col-md-9">
                <input type="text" class="form-control input-sm" placeholder="手机号" name="data[手机号]">
            </div>
        </div>
        <div class="form-group col-md-7">
            <label class="col-md-3 control-label">公司名称<span class="required" aria-required="true">*</span></label>

            <div class="col-md-9">
                <input type="text" class="form-control input-sm" placeholder="公司名称" name="data[公司名称]">
            </div>
        </div>
        <div class="form-group col-md-7" style="margin-top: 20px">
            <label class="col-md-3 control-label">联系人优先级</label>

            <div class="col-md-9 ">

                    <label class="radio-inline">
                        <input type="radio" name="data[state]" value="1">
                        1
                    </label>
                    <label class="radio-inline">
                        <input type="radio" name="data[state]" value="2">
                        2
                    </label>
                    <label class="radio-inline">
                        <input type="radio" name="data[state]" value="3" checked>
                        3
                    </label>
                    <label class="radio-inline">
                        <input type="radio" name="data[state]" value="4">
                        4
                    </label>
                    <label class="radio-inline">
                        <input type="radio" name="data[state]" value="5">
                        5
                    </label>
    </div>
</div>

<h4 style="font-weight: bold!important; padding-left: 28px; margin-bottom: 18px" class="col-md-10">
    基本信息
</h4>

<div class="clearfix">
    <div class="form-group col-md-5">
        <label class="col-md-3 control-label">姓名<span class="required" aria-required="true">*</span></label>

        <div class="col-md-9">
            <input type="text" class="form-control input-sm" placeholder="姓名" name="data[姓名]">
        </div>
    </div>
    <div class="form-group col-md-5">
        <label class="col-md-3 control-label">性别</label>

        <div class="col-md-9">
            <select class="form-control input-sm" name="data[attr][基本信息][性别]">
                <option value="男">男
                </option>
                <option value="女">女
                </option>
            </select>
        </div>
    </div>
    <div class="form-group col-md-5">
        <label class="col-md-3 control-label">年龄</label>

        <div class="col-md-9">
            <input type="text" class="form-control input-sm" placeholder="年龄" name="data[attr][基本信息][年龄]">
        </div>
    </div>
    <div class="form-group col-md-5">
        <label class="col-md-3 control-label">城市</label>

        <div class="col-md-9">
            <input type="text" class="form-control input-sm" placeholder="城市" name="data[attr][基本信息][城市]">
        </div>
    </div>
    <div class="form-group col-md-5">
        <label class="col-md-3 control-label">籍贯</label>

        <div class="col-md-9">
            <input type="text" class="form-control input-sm" placeholder="籍贯" name="data[attr][基本信息][籍贯]">
        </div>
    </div>
    <div class="form-group col-md-5">
        <label class="col-md-3 control-label">学历</label>

        <div class="col-md-9">
            <input type="text" class="form-control input-sm" placeholder="学历" name="data[attr][基本信息][学历]">
        </div>
    </div>
    <div class="form-group col-md-5">
        <label class="col-md-3 control-label">兴趣</label>

        <div class="col-md-9">
            <input type="text" class="form-control input-sm" placeholder="兴趣" name="data[attr][基本信息][兴趣]">
        </div>
    </div>
</div>

<h4 style="font-weight: bold!important; padding-left: 28px; margin-bottom: 18px">
    联系方式</h4>

<div class="clearfix">

    <div class="form-group col-md-5">
        <label class="col-md-3 control-label">电子邮箱</label>

        <div class="col-md-9">
            <input type="text" class="form-control input-sm" placeholder="电子邮箱" name="data[attr][联系方式][电子邮箱]">
        </div>
    </div>
    <div class="form-group col-md-5">
        <label class="col-md-3 control-label">家庭住址</label>

        <div class="col-md-9">
            <input type="text" class="form-control input-sm" placeholder="家庭住址" name="data[attr][联系方式][家庭住址]">
        </div>
    </div>
    <div class="form-group col-md-5">
        <label class="col-md-3 control-label">微信</label>

        <div class="col-md-9">
            <input type="text" class="form-control input-sm" placeholder="微信" name="data[attr][联系方式][微信]">
        </div>
    </div>
    <div class="form-group col-md-5">
        <label class="col-md-3 control-label">微博</label>

        <div class="col-md-9">
            <input type="text" class="form-control input-sm" placeholder="微博" name="data[attr][联系方式][微博]">
        </div>
    </div>
    <div class="form-group col-md-5">
        <label class="col-md-3 control-label">qq</label>

        <div class="col-md-9">
            <input type="text" class="form-control input-sm" placeholder="qq" name="data[attr][联系方式][qq]">
        </div>
    </div>
</div>

<h4 style="font-weight: bold!important; padding-left: 28px; margin-bottom: 18px">
    公司信息</h4>

<div class="clearfix">

    <div class="form-group col-md-5">
        <label class="col-md-3 control-label">所在行业</label>

        <div class="col-md-9">
            <input type="text" class="form-control input-sm" placeholder="所在行业" name="data[attr][公司信息][所在行业]">
        </div>
    </div>
    <div class="form-group col-md-5">
        <label class="col-md-3 control-label">公司职位</label>

        <div class="col-md-9">
            <input type="text" class="form-control input-sm" placeholder="公司职位" name="data[公司职位]">
        </div>
    </div>
    <div class="form-group col-md-5">
        <label class="col-md-3 control-label">从业年数</label>

        <div class="col-md-9">
            <input type="text" class="form-control input-sm" placeholder="从业年数" name="data[attr][公司信息][从业年数]">
        </div>
    </div>
    <div class="form-group col-md-5">
        <label class="col-md-3 control-label">公司地址</label>

        <div class="col-md-9">
            <input type="text" class="form-control input-sm" placeholder="公司地址" name="data[attr][公司信息][公司地址]">
        </div>
    </div>
    <div class="form-group col-md-5">
        <label class="col-md-3 control-label">人数规模</label>

        <div class="col-md-9">
            <input type="text" class="form-control input-sm" placeholder="人数规模" name="data[attr][公司信息][人数规模]">
        </div>
    </div>
    <div class="col-md-12" style="padding: 0">
        <div class="form-group col-md-5">
            <label class="col-md-3 control-label">业务类型</label>

            <div class="col-md-9">
                <select class="form-control input-sm" name="data[业务类型]" id="business">
                    <option value=" ">请选择</option>
                </select>
            </div>

        </div>
        <div class="form-group col-md-5">
            <label class="col-md-3 control-label sub_business">业务子类</label>

            <div class="col-md-9">
                <select class="form-control input-sm" disabled name="data[业务子类]" id="subBusiness">
                    <option value=" ">
                        请先选择业务类型
                    </option>
                </select>
            </div>
        </div>
    </div>
</div>
<div class="form-group col-md-10">
    <h5 style="font-weight: bolder!important; margin-bottom: 18px">
        其他备注</h5>
    <textarea class="form-control" rows="5" name="data[attr][其他备注]"></textarea>
</div>

</div>
<div style="text-align: right" class="form-group col-md-10">
    <button type="submit" class="btn btn-primary" style="width: 150px;">
        确认提交
    </button>
</div>
</form>
</div>
</div>


<!-- BEGIN JAVASCRIPTS(Load javascripts at bottom, this will reduce page load time) -->
<!-- BEGIN CORE PLUGINS -->
<script src="{$_assets}plugins/jquery-1.11.0.min.js"
        type="text/javascript"></script>
<script src="js/jquery.cxselect.min.js" type="text/javascript"></script>
<script src="{$_assets}plugins/jquery-migrate-1.2.1.min.js"
        type="text/javascript"></script>
<!-- IMPORTANT! Load jquery-ui-1.10.3.custom.min.js before bootstrap.min.js to fix bootstrap tooltip conflict with jquery ui tooltip -->
<script src="{$_assets}plugins/jquery-ui/jquery-ui-1.10.3.custom.min.js"
        type="text/javascript"></script>
<script src="{$_assets}plugins/bootstrap/js/bootstrap.min.js"
        type="text/javascript"></script>
<script src="{$_assets}plugins/bootstrap-hover-dropdown/bootstrap-hover-dropdown.min.js"
        type="text/javascript"></script>
<script src="{$_assets}plugins/jquery-slimscroll/jquery.slimscroll.min.js"
        type="text/javascript"></script>
<script src="{$_assets}plugins/jquery.blockui.min.js"
        type="text/javascript"></script>
<script src="{$_assets}plugins/uniform/jquery.uniform.min.js"
        type="text/javascript"></script>
<!-- END CORE PLUGINS -->
<!-- BEGIN PAGE LEVEL PLUGINS -->
<script type="text/javascript"
        src="{$_assets}plugins/select2/select2.min.js"></script>
<script type="text/javascript"
        src="{$_assets}plugins/datatables/media/js/jquery.dataTables.min.js"></script>
<script type="text/javascript"
        src="{$_assets}plugins/datatables/plugins/bootstrap/dataTables.bootstrap.js"></script>
<!-- END PAGE LEVEL PLUGINS -->
<!-- BEGIN PAGE LEVEL SCRIPTS -->
<script src="{$_assets}scripts/app.js"></script>
<script src="{$_assets}scripts/_page.js"></script>
<script>
    jQuery(document).ready(function () {
        App.init();
        TableManaged.init();
    });
    //        var category = [
    //            {
    //                'b':'北京',
    //                's':[ '北京1','北京2' ]
    //            },
    //            {
    //                'b':'北京',
    //                's':[ '北京3','北京4' ]
    //            },
    //        ];
    var category = [
        {foreach $categoryList[0] as $k=>$v}
        {if $v}
        {
            'b': '{$k}{$v}',
            's': [
                {foreach $categoryList[$k] as $kk=>$vv}
                '{$kk}{$vv}',
                {/foreach}
            ]
        },
        {/if}
        {/foreach}
    ];

    var bHtml = '<option value=" ">请选择</option>';
    $('#business').change(function () {
        var index = $('#business').get(0).selectedIndex - 1;
        if (index >= 0) {
            oSubBusiness(index);
        } else {
            $('#subBusiness').attr("disabled", true);
            $('#subBusiness').html('<option value=" ">请先选择业务类型</option>');
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

    $('#business').html(bHtml);

    {*$('#business').cxSelect({*}
    {*url:'{$_route}productCategoryListJson',*}
    {*url:'{$_assets}json/test.json',*}
    {*required:true,*}
    {*selects: ['business', 'sub_business'],*}
    {*nodata: 'none'*}
    {*});*}
</script>
</body>
<!-- END BODY -->
</html>