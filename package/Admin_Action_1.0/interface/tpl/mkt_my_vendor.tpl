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
        <i class="fa fa-database"></i>当前共负责<span style="color: #ff0000">62</span>个供应商
    </div>
</div>
<div class="portlet-body">
<div class="portlet-tabs">
    <ul class="nav nav-tabs"
        style="overflow: inherit; padding-left: 100px">
        <li style="padding: 5px 4px 0 0">
            <div>
                <a class="btn btn-success" href="addContact"><i class="fa fa-plus"></i>创建供货商</a>
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

                <div class="form-group col-md-5">
                    <label class="col-md-3 control-label">供应商ID</label>
                    <div class="col-md-9">
                        <input type="text" class="form-control input-sm">
                    </div>
                </div>
                <div class="form-group col-md-5">
                    <label class="col-md-3 control-label">供应商名称</label>
                    <div class="col-md-9">
                        <input type="text" class="form-control input-sm">
                    </div>
                </div>
                <div class="form-group col-md-5">
                    <div class="form-group col-md-12" style="padding:0">
                        <label class="col-md-3 control-label">业务类型</label>
                        <div class="col-md-9">
                            <select class="form-control input-sm">
                                <option>请选择</option>
                                <option>空间场地</option>
                                <option>场地搭建</option>
                                <option>AV设备</option>
                                <option>视频制作</option>
                            </select>
                        </div>
                    </div>
                </div>
                <div class="form-group col-md-5">
                    <div class="form-group col-md-12" style="padding:0">
                        <label class="col-md-3 control-label">业务子类</label>
                        <div class="col-md-9">
                            <select class="form-control input-sm">
                                <option>请选择</option>
                                <option>酒吧</option>
                                <option>餐厅</option>
                                <option>商场</option>
                            </select>
                        </div>
                    </div>
                </div>
            <div class="form-group col-md-5">
                <div class="form-group col-md-12" style="padding:0">
                    <label class="col-md-3 control-label">供应商状态</label>
                    <div class="col-md-9">
                        <select class="form-control input-sm">
                            <option>待拓展</option>
                            <option>已拓展</option>
                            <option>待审核</option>
                            <option>已上线</option>
                            <option>已下线</option>
                        </select>
                    </div>
                </div>
            </div>
            <div class="form-group col-md-5">
                <div class="form-group col-md-12" style="padding:0">
                    <label class="col-md-3 control-label">签约状态</label>
                    <div class="col-md-9">
                        <select class="form-control input-sm">
                            <option>未签约</option>
                            <option>合作备忘录</option>
                            <option>已签约</option>

                        </select>
                    </div>
                </div>
            </div>
            <div class="form-group col-md-5">
                <label class="col-md-3 control-label">负责人</label>
                <div class="col-md-9">
                    <input type="text" class="form-control input-sm" placeholder="姓名" name="data[username]" value="{$_request['data']['username']}">
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
            <i class="fa fa-comments"></i>我的供应商列表
        </div>
    </div>
    <div class="portlet-body">
        <div class="tab-pane active clearfix">

            <label>
                <div class="checker"><span><input type="checkbox"></span></div>全选</label>
            <a href="#" class="btn btn-info btn-xs" style="margin-left: 20px;">全部转移</a>

            <table class="table table-striped table-bordered table-hover" id="data_table" style="word-break: break-all; margin-top: 10px;">
                <thead>
                <tr>
                    <th class="table-checkbox" style="width:16px">

                    </th>
                    <th>更新时间</th>
                    <th>供应商ID</th>
                    <th>供应商名称</th>
                    <th>业务类型</th>
                    <th>供应商状态</th>
                    <th>签约状态</th>
                    <th>负责人</th>
                    <th>操作</th>
                </tr>
                </thead>
                <tbody>

                    <tr role="row">
                        <td>
                            <input type="checkbox" class="checkboxes" value="1" name="ids[]"></span>
                        </td>
                        <td>2015-03-08 15:30:20</td>
                        <td>231321321</td>
                        <td>上海科技</td>
                        <td>空间场地</td>
                        <td>待审核</td>
                        <td>合作备忘录</td>
                        <td>
                            GAry
                        </td>
                        <td>
                            <a href="my_vendor_edit" class="btn btn-info btn-xs">详情</a>
                        </td>
                    </tr>

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