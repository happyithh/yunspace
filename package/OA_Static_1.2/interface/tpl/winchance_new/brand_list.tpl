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
    <link href="plugins/font-awesome/css/font-awesome.min.css" rel="stylesheet" type="text/css"/>
    <link href="style/media.css" rel="stylesheet"/>
    <link rel="stylesheet" type="text/css" href="{$_assets}plugins/select2/select2.css"/>
    <link href="{$_assets}css/plugins.css" rel="stylesheet" type="text/css"/>
</head>
<!-- END HEAD -->
<!-- BEGIN BODY -->

<body style="background:#FaFaFa !important;min-height:800px;">

<div class="portlet tabbable">
    <div class="portlet-title">
        <div class="caption">
            <i class="fa fa-search"></i>IP品牌管理
        </div>
    </div>
    <div class=" portlet-tabs">
        <ul class="nav nav-tabs">
            <li class="{if $tab=='company'}active{/if}">
                <a href="?action=list&tab=company">公司/品牌列表</a>
            </li>
            <li class="{if $tab=='figure'}active{/if}">
                <a href="?action=list&tab=figure" >形象列表</a>
            </li>

        </ul>

        <div class="portlet-body" style="margin-top:-40px;">

            <div class="tab-content">
                    <div style="margin:0 10px;">
                        <div class="">
                            <div class="row clearfix" style="margin:10px -15px;">
                                <!-- /.col-md-6 -->
                                <div class="col-md-4 col-xs-6" style="min-width: 350px;">
                                    <form action="?action=list&tab={$tab}" method="post" >
                                        <div class="input-group">
                                            <input type="text"
                                                   name="{if $tab=='company'}search[company_name]{else}search[figure_name]{/if}"
                                                   class="form-control"
                                                   placeholder="{if $tab=='company'}请输入品牌公司名称{else}请输入人物形象名称{/if}" value="{if $tab=='company'}{$_REQUEST['search']['company_name']}{else}{$_REQUEST['search']['figure_name']}{/if}">
											<span class="input-group-btn">
											<button class="btn btn-info" type="submit"><i class="fa fa-search" aria-hidden="true">&nbsp;查找</i>
                                            </button>
											</span>

                                        </div>
                                    </form>
                                    <!-- /input-group -->
                                </div>
                                <div class="col-md-4 pull-right col-xs-4" style="text-align: right">
                                    {if $tab=='figure'}
                                    <a class="btn btn-info figure_edit" data-toggle="modal" href="#modal-one" data-type="1">新增人物形象</a>
                                    {/if}
                                    <a class="btn btn-primary company_edit" data-toggle="modal" href="#modal-two" data-type="1">新增品牌公司</a>
                                    {*<button type="button" class="btn btn-success">导出</button>*}
                                </div>
                            </div>
                            <div class="portlet-body">
                                <div class="tab-content clearfix">
                                    {if $tab=='company'}
                                        {include "OA_Static::winchance_new/inc/company_list.tpl"}
                                    {else}
                                        {include "OA_Static::winchance_new/inc/figure_list.tpl"}
                                    {/if}
                                    <div class="container-fluid">
                                        <div class="row">
                                            <div class="col-md-12" style="padding: 0px;">
                                                <ul class="pagination">
                                                    {if $_data['page']['dpll']}
                                                        <li class="prev">
                                                            <a href="{$_data['page']['dup']}1" title="First"><i
                                                                        class="fa fa-angle-double-left"></i></a>
                                                        </li>
                                                        <li class="prev">
                                                            <a href="{$_data['page']['dup']}{$_waiting['page']['dp']-1}"
                                                               title="Prev"><i
                                                                        class="fa fa-angle-left"></i></a>
                                                        </li>
                                                    {else}
                                                        <li class="prev disabled">
                                                            <a href="#" title="First"><i
                                                                        class="fa fa-angle-double-left"></i></a>
                                                        </li>
                                                        <li class="prev disabled">
                                                            <a href="#" title="Prev"><i
                                                                        class="fa fa-angle-left"></i></a>
                                                        </li>
                                                    {/if}
                                                    {for $i=$_data['page']['dpl'] to $_data['page']['dpr']}
                                                        <li{if $i==$_data['page']['dp']} class="active"{/if}>
                                                            <a href="{$_data['page']['dup']}{$i}">{$i}</a>
                                                        </li>
                                                    {/for}
                                                    <li class="disabled">
                                                        <a> {$_data['page']['dtp']}
                                                            ( {$_data['page']['dp']*$_data['page']['dn']}
                                                            /{$_data['page']['dt']}
                                                            )</a></li>

                                                    {if $_data['page']['dprr']}
                                                        <li class="next">
                                                            <a href="{$_data['page']['dup']}{$_data['page']['dp']+1}"
                                                               title="Next"><i
                                                                        class="fa fa-angle-right"></i></a>
                                                        </li>
                                                        <li class="next">
                                                            <a href="{$_data['page']['dup']}{$_data['page']['dtp']}"
                                                               title="Last"><i
                                                                        class="fa fa-angle-double-right"></i></a>
                                                        </li>
                                                    {else}
                                                        <li class="next disabled">
                                                            <a href="#" title="Next"><i
                                                                        class="fa fa-angle-right"></i></a>
                                                        </li>
                                                        <li class="next disabled">
                                                            <a href="#" title="Last"><i
                                                                        class="fa fa-angle-double-right"></i></a>
                                                        </li>
                                                    {/if}
                                                </ul>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

        </div>


    </div>
</div>
<!--------------------------新增人物形象  开始---------------------------------->

<div class="modal fade" id="modal-one" tabindex="-1" role="basic" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true"></button>
                <h4 class="modal-title">编辑人物形象</h4>
            </div>
            <div class="modal-body">
                <div class="form-body">
                    <div class="form-group clearfix">
                        <label class="col-md-3 control-label col-xs-3">人物形象名称</label>

                        <div class="col-md-8 col-xs-8">
                            <input type="text" class=" form-control figure_name" placeholder="请人物形象名称" value="">
                        </div>
                    </div>
                    <div class="form-group clearfix">
                        <label class="col-md-3 control-label col-xs-3">所属品牌公司</label>
                        <input type="hidden" name="company" class="figure_company"/>
                        <div class="col-md-8 col-xs-8">
                            <div class="form-control" id="select_brand" >
                                <option value="" selected>请选择IP品牌</option>
                            </div>
                        </div>
                    </div>
                    <div class="form-group clearfix">
                        <label class="col-md-3 control-label col-xs-3 ">备注</label>

                        <div class="col-md-8 col-xs-8">
                            <textarea class="form-control figure_note" rows="10" style="max-width:333px;max-height:224px;"
                                      placeholder="此处可以输入关于此IP人物形象的备注信息，1000字以内"></textarea>
                        </div>
                    </div>
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-info figure_create" data-figure-to-url="{$_home}winchance_new/brand_manage?action=list&tab={$tab}">保存</button>
                <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
            </div>
        </div>
        <!-- /.modal-content -->
    </div>
    <!-- /.modal-dialog -->
</div>
<!--------------------------新增人物形象  结束---------------------------------->

<!--------------------------新增品牌公司  开始---------------------------------->
<div class="modal fade" id="modal-two" tabindex="-1" role="basic" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true"></button>
                <h4 class="modal-title">编辑品牌公司</h4>
            </div>
            <div class="modal-body">
                <div class="form-body">
                    <div class="form-group clearfix">
                        <label class="col-md-3 control-label col-xs-3">品牌公司名称</label>

                        <div class="col-md-8 col-xs-8">
                                <input type="text" name="company" class="form-control company_name" placeholder="请输入品牌公司名称" required value="">
                        </div>
                    </div>

                    <div class="form-group clearfix">
                        <label class="col-md-3 control-label col-xs-3">备注</label>

                        <div class="col-md-8  col-xs-8">
                            <textarea  class="form-control company_note" rows="10" style="max-width:333px;max-height:224px;"
                                      placeholder="此处可以输入关于此IP品牌公司的备注信息，1000字以内"></textarea>
                        </div>
                    </div>
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-info company_create" data-company-to-url="{$_home}winchance_new/brand_manage?action=list&tab={$tab}" company-id>保存</button>
                <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
            </div>
        </div>
        <!-- /.modal-content -->
    </div>
    <!-- /.modal-dialog -->
</div>
<!--------------------------新增品牌公司  结束---------------------------------->
{*<style>*}
{*.step_content {*}
{*height: auto;*}
{*overflow: hidden;*}
{*background-color: #eee;*}
{*padding: 2%;*}
{*width: 96%;*}
{*margin-top: 5px;*}
{*display: none;*}
{*word-break: break-all;*}
{*}*}
{*</style>*}

<script src="{$_assets}plugins/jquery-1.11.0.min.js" type="text/javascript"></script>
<script src="{$_assets}plugins/bootstrap/js/bootstrap.min.js"
        type="text/javascript"></script>
{static "core/yunspace.js"}
{*<script src="js/demands/demands_change_select.js" type="text/javascript"></script>*}

<script type="text/javascript" src="js/moment.min.js"></script>
<script type="text/javascript" src="js/bootstrap-datetimepicker.min.js"></script>
<script type="text/javascript" src="{$_assets}plugins/select2/select2.min.js"></script>
{*<script type="text/javascript" src="js/winchance_ip/company_create.js"></script>*}
<script type="text/javascript" src="js/winchance_ip/modal_create.js"></script>
<script>
    $("#select_brand").select2({
        ajax: {
            url: "http://{Core::$urls['host']}/static/api/winchance/new/company/auto/complete.jsonp",
            dataType: 'json',
            delay: 250,
            data: function (term) {
                return {
                    q: term // search term
                };
            },
            createSearchChoice   : function(term, data) {           // 创建搜索结果（使用户可以输入匹配值以外的其它值）
                return { id: term, name: term };
            },
            results: function (data, params) {
                params.page = params.page || 1;
                return {
                    results: data.results,
                    pagination: {
                        more: (params.page * 10) < data.total_count
                    }
                };
            },
            cache: true
        },
        escapeMarkup: function (markup) { return markup; }, // let our custom formatter work
        minimumInputLength: 1,
        formatSelection : function (item) { return item.name; },  // 选择结果中的显示
        formatResult    : function (item) { return item.name; },  // 搜索列表中的显示
        templateResult: formatRepo, // omitted for brevity, see the source of this page
        templateSelection: formatRepoSelection // omitted for brevity, see the source of this page
    }).on('change',function(r){
        $(".figure_company").val(r.val);

        if($("#modal-one").find(".figure_company").val() != "请选择IP品牌"){

            $("#modal-one").find(".select2-chosen").css("color","#222");
        }else{
            $("#modal-one").find(".select2-chosen").css("color","#909090");
        }
    });
    function formatRepo (repo) {
        if (repo.loading) return repo.text;
        var markup = "<div>"+repo.name+"</div>";
        return markup;
    }
    function formatRepoSelection (repo) {
        console.log(repo,12312);
        return repo.full_name || repo.name;
    }

    $("#modal-one").on('show.bs.modal',function() {
        if($(this).find(".figure_company").val()==""){
            $(this).find(".select2-chosen").text("请选择IP品牌").css("color","#909090");
        }
    });
</script>
<script type="text/javascript" src="js/winchance_ip/delete_operate.js"></script>

</body>
<!-- END BODY -->
</html>