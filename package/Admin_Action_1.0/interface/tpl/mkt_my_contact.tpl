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
        .alert{ padding: 0; margin: 0; font-size: 12px}
    </style>
</head>
<!-- END HEAD -->
<!-- BEGIN BODY -->

<body style="background:#FaFaFa !important">


<div class="portlet tabbable">
<div class="portlet-title">
    <div class="caption">
        <i class="fa fa-database"></i>搜索条件
    </div>
</div>
<div class="portlet-body">
<div class="portlet-tabs">
    <ul class="nav nav-tabs"
        style="overflow: inherit; padding-left: 100px">
        <li style="padding: 5px 4px 0 0">
            <div>
                <a class="btn btn-success" href="addContact"><i class="fa fa-plus"></i>添加我的联系人</a>
            </div>
        </li>
    </ul>
        </div>

    {*<li style="padding: 5px 4px 0 0">*}
        {*<div>*}
            {*<a class="btn btn-success" href="?action=addContact"><i class="fa fa-plus"></i>添加联系人</a>*}
        {*</div>*}
    {*</li>*}
<div class="clearfix"></div>
<div>
    <form action="searchContact" method="post">
        <div class="clearfix">
            <div id="businessWrap">
                <div class="col-md-5">
                    <div class="form-group col-md-12" style="padding:0">
                        <label class="col-md-3 control-label">业务类型</label>
                        <div class="col-md-9">
                            <select class="form-control input-sm" name="data[business]" id="business">
                                <option value="0">请选择</option>
                            </select>
                        </div>
                    </div>
                </div>
                <div class="col-md-5">
                    <div class="form-group col-md-12" style="padding:0">
                        <label class="col-md-3 control-label sub_business">业务子类</label>
                        <div class="col-md-9">
                            <select class="form-control input-sm" disabled name="data[sub_business]" id="subBusiness">
                                <option value="">请先选择业务类型</option>
                            </select>
                        </div>
                    </div>
                </div>
            </div>
            <div class="form-group col-md-5">
                <label class="col-md-3 control-label">姓名</label>
                <div class="col-md-9">
                    <input type="text" class="form-control input-sm" placeholder="姓名" name="data[username]" value="{$_request['data']['username']}">
                </div>
            </div>
            <div class="form-group col-md-5">
                <label class="col-md-3 control-label">手机号码</label>
                <div class="col-md-9">
                    <input type="text" class="form-control input-sm" placeholder="手机号码" name="data[phone]" value="{$_request['data']['phone']}">
                </div>
            </div>
            <div class="form-group col-md-5">
                <label class="col-md-3 control-label">公司</label>
                <div class="col-md-9">
                    <input type="text" class="form-control input-sm" placeholder="公司" name="data[company]" value="{$_request['data']['company']}">
                </div>
            </div>
            <div class="form-group col-md-5">
                <label class="col-md-3 control-label">职位</label>
                <div class="col-md-9">
                    <input type="text" class="form-control input-sm" placeholder="职位" name="data[position]" value="{$_request['data']['position']}">
                </div>
            </div>
        </div>
        <div class="form-actions">
            <div class="" style="text-align: center"><button type="submit" class="btn btn-primary" style="width: 150px"><i class="fa fa-search"></i>搜索</button></div>
        </div>
    </form>
</div>

</div>
</div>

<div class="portlet">
    <div class="portlet-title">
        <div class="caption">
            <i class="fa fa-comments"></i>我的联系人列表
        </div>
    </div>
    <div class="portlet-body">
        <div class="tab-pane active clearfix">
            <div class="pull-left" style="width:30%; padding: 10px 0;">
            </div>

            <table class="table table-striped table-bordered table-hover" id="data_table" style="word-break: break-all">
                <thead>
                <tr>
                    <th class="table-checkbox" style="width:16px">
                        <input type="checkbox" class="group-checkable" data-set="#data_table .checkboxes">
                    </th>
                    <th>姓名</th>
                    <th>手机号</th>
                    <th>联系业务</th>
                    <th>业务子类</th>
                    <th>公司</th>
                    <th>职位</th>
                    <th>账户状态</th>
                    <th>操作</th>
                </tr>
                </thead>
                <tbody>
                {foreach $_data['rows'] as $k=>$v}
                    <tr role="row">
                        <td>
                            <input type="checkbox" class="checkboxes" value="1" name="ids[]"></span>
                        </td>
                        <td>{$v['username']}</td>
                        <td>{$v['phone']}</td>
                        <td>{$v['business']}</td>
                        <td>{$v['sub_business']}</td>
                        <td>{$v['company']}</td>
                        <td>{$v['position']}</td>
                        <td>
                            {*{if $v['state']==-9998}*}
                            {*正在审核*}
                            {*{elseif $v['state']==-9999}*}
                            {*账户ID:{$v['account']}*}
                            {*{else}*}
                            {*未绑定任何供应商*}
                            {*{/if}*}
                            {if $v['accountStatus']==4}
                                <span class="alert alert-warning">
                                    <strong>{$v['accountState']}!</strong>
                                </span>
                            {/if}
                            {if $v['accountStatus']==3}
                                <span class="alert alert-success">
                                    <strong>{$v['accountState']}!</strong>
                                </span>
                            {/if}
                            {if $v['accountStatus']==2}
                                <span class="alert alert-danger">
                                    <strong>{$v['accountState']}!</strong>
                                </span>
                            {/if}
                            {if $v['accountStatus']==1}
                                <span class="alert alert-warning">
                                    <strong>{$v['accountState']}!</strong>
                                </span>
                            {/if}
                            {if $v['accountStatus']==0}
                                <strong>{$v['accountState']}!</strong>
                            {/if}

                        </td>
                        <td>
                            {*<a href="{$_root}{Core::$urls['package']}mkt_management/contactDetails?id={$v['id']}" class="btn btn-success btn-xs"><i class="fa fa-pencil"></i> 查看</a>*}
                            <a href="contactDetails?id={$v['id']}&accountId={$v['accountId']}" class="btn btn-success btn-xs"><i class="fa fa-pencil"></i> 查看</a>
                           {if $v['accountStatus']==0}
                               <a href="handleChangeContactInfo?id={$v['id']}" class="btn btn-warning btn-xs"><i class="fa fa-edit"></i>修改</a>
                                {else}
                               <a href="{$_home}mkt_management/handleChangeContactInfo?id={$v['id']}&type=already" class="btn btn-warning btn-xs"><i class="fa fa-edit"></i>修改</a>
                           {/if}

                            {if $v['accountStatus']}
                                {if $v['accountStatus']==3}
                                    <a href="seeMySupplier?id={$v['id']}&accountId={$v['accountId']}" class="btn btn-primary btn-xs"><i class="fa fa-pencil"></i>查看供应商</a>
                                {/if}
                                {*{if $v['accountStatus']==2||$v['accountStatus']==1}*}
                                {*<a href="check?contactId={$v['id']}&accountId={$v['accountId']}" class="btn btn-primary btn-xs"><i class="fa fa-pencil"></i>重新审核</a>*}
                                {*{/if}*}
                            {else}
                                <a href="deleteMyContact?id={$v['id']}" class="btn btn-danger btn-xs"><i class="fa fa-times"></i>释放</a>
                            {/if}
                        </td>
                    </tr>
                {/foreach}
                </tbody>
            </table>
            <div class="pull-right">
                <ul class="pagination">
                    {if $_data['page']['dpll']}
                        <li class="prev">
                            <a href="{$_data['page']['dup']}1" title="First"><i class="fa fa-angle-double-left"></i></a>
                        </li>
                        <li class="prev">
                            <a href="{$_data['page']['dup']}{$_data['page']['dp']-1}" title="Prev"><i class="fa fa-angle-left"></i></a>
                        </li>
                    {else}
                        <li class="prev disabled">
                            <a href="#" title="First"><i class="fa fa-angle-double-left"></i></a>
                        </li>
                        <li class="prev disabled">
                            <a href="#" title="Prev"><i class="fa fa-angle-left"></i></a>
                        </li>
                    {/if}
                    {for $i=$_data['page']['dpl'] to $_data['page']['dpr']}
                        <li{if $i==$_data['page']['dp']} class="active"{/if}>
                            <a href="{$_data['page']['dup']}{$i}">{$i}</a>
                        </li>
                    {/for}
                    <li class="disabled">
                        <a> {$_data['page']['dtp']} ( {$_data['page']['dp']*$_data['page']['dn']}/{$_data['page']['dt']} )</a></li>

                    {if $_data['page']['dprr']}
                        <li class="next">
                            <a href="{$_data['page']['dup']}{$_data['page']['dp']+1}" title="Next"><i class="fa fa-angle-right"></i></a>
                        </li>
                        <li class="next">
                            <a href="{$_data['page']['dup']}{$_data['page']['dtp']}" title="Last"><i class="fa fa-angle-double-right"></i></a>
                        </li>
                    {else}
                        <li class="next disabled">
                            <a href="#" title="Next"><i class="fa fa-angle-right"></i></a>
                        </li>
                        <li class="next disabled">
                            <a href="#" title="Last"><i class="fa fa-angle-double-right"></i></a>
                        </li>
                    {/if}
                </ul>
            </div>
        </div>
    </div>
</div>


<!-- BEGIN JAVASCRIPTS(Load javascripts at bottom, this will reduce page load time) -->
<!-- BEGIN CORE PLUGINS -->
<script src="{$_assets}plugins/jquery-1.11.0.min.js"
        type="text/javascript"></script>
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
    var category = [
        {foreach $categoryList[0] as $k=>$v}
        {if $v}
        {
            'b':'{$k}{$v}',
            's':[
                {foreach $categoryList[$k] as $kk=>$vv}
                '{$kk}{$vv}',
                {/foreach}
            ]
        },
        {/if}
        {/foreach}
    ];

    var bHtml = '<option value="">请选择</option>';
    $('#business').change(function(){
        var index = $('#business').get(0).selectedIndex-1;
        if(index>=0){
            oSubBusiness(index);
        }else{
            $('#subBusiness').attr("disabled",true);
            $('#subBusiness').html('<option value="">请先选择业务类型</option>');
        }

    })
    for(var i=0; i<category.length;i++){
        bHtml+= "<option value='"+category[i]['b']+"'>"+category[i]['b']+"</option>";
    }

    var oSubBusiness = function(i){
        var oSubBusinessList = category[i]['s'],sHtml;
        for(var j=0; j<category[i]['s'].length;j++){
            sHtml += "<option value='"+category[i]['s'][j]+"'>"+category[i]['s'][j]+"</option>";
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