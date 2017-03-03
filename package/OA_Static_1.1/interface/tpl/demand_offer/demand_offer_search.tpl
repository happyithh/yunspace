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
    <script src="{$_assets}plugins/jquery-1.11.0.min.js" type="text/javascript"></script>
    <script type="text/javascript" src="{$_assets}plugins/select2/select2.min.js"></script>
</head>
<!-- END HEAD -->
<!-- BEGIN BODY -->

<body style="background:#FaFaFa !important">

<div class="portlet tabbable">
    <div class="portlet-title">
        <div class="caption">
            <i class="fa fa-database"></i>需求详情
        </div>
    </div>
    <div class="portlet-body">
        <div class="container-fluid">
            <div class="row">
                <table class="table table-hover" style="border:0px;">
                    <tbody>
                    <tr>
                        <td>更新时间：</td>
                        <td>{Date('Y-m-d H:i:s',$_demand['create_time'])}</td>
                    </tr>
                    <tr>
                        <td>姓名：</td>
                        <td>{if $_demand['username']}{$_demand['username']}{else}{$_demand['demand']['联系人']}{/if}</td>
                    </tr>
                    <tr>
                        <td>电话：</td>
                        <td>{$_demand['phone']}</td>
                    </tr>
                    <tr>
                        <td>活动城市：</td>
                        <td>{$_demand['city']}</td>
                    </tr>
                    <tr>
                        <td>预算范围：</td>
                        <td>{$_demand['price_up']}至{$_demand['price_down']}</td>
                    </tr>
                    <tr>
                        <td>活动名称：</td>
                        <td>{{$_demand['demand_name']}}</td>
                    </tr>
                    <tr>
                        <td>需求类型：</td>
                        <td>{{$_demand['demand_type']}}</td>
                    </tr>
                    <tr>
                        <td>业务类型：</td>
                        <td>{if $_demand['demand']['业务类型']}{$_demand['demand']['业务类型']}{else}{$_demand['demand']['活动类型']}{/if}</td>
                    </tr>

                    <tr>
                        <td>具体要求：</td>
                        <td>
                            {if $_demand['demand']['product_id']}
                                <p><a target="_blank"
                                      href="{$_root}service_info/{$_demand['demand']['product_id']}.html">点此查看产品链接</a>
                                </p>
                            {/if}
                            {if $_demand['demand']['set_id']}
                                <p><a target="_blank" href="{$_root}set_info/{$_demand['demand']['set_id']}.html">点此查看产品链接</a>
                                </p>
                            {/if}

                            {if $_demand['demand']['vendor_id']}
                                <p><a target="_blank" href="{$_root}vendor_info/{$_demand['demand']['vendor_id']}.html">点此查看详情</a>
                                </p>
                            {/if}
                            <p>{$_demand['demand']['具体要求']}</p>
                        </td>
                    </tr>
                    <tr>
                        <td>其他信息</td>
                        <td>
                            {foreach $_demand['demand'] as $key=>$val}
                                {if is_array($val)}
                                    <p>{$key}:</p>
                                    {foreach $val as $k=>$v}
                                        <p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; {$k}:&nbsp;&nbsp;&nbsp;{$v}</p>
                                    {/foreach}
                                {else}
                                    <p>{$key}：&nbsp;&nbsp;&nbsp;{$val}</p>
                                {/if}
                            {/foreach}

                        </td>
                    </tr>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
    <div class="portlet-title">
        <div class="caption">
            <i class="fa fa-search"></i>匹配条件
        </div>
    </div>
    <div class="portlet-body">
        <div class="portlet-tabs">
            <div class="clearfix"></div>
            <div>
                <form action="?" method="post" class="clearfix">
                    <input type="hidden" name="act" value="demand_offer" />
                    <input type="hidden" name="action" value="search_result" />
                    <input type="hidden" name="demand_id" value="{$_demand['id']}">
                    <div class="form-body clearfix">
                        {*<div class="form-group col-md-5">*}
                            {*<label class="col-md-3 control-label">负责人</label>*}

                            {*<div class="col-md-9">*}
                                {*<select class="form-control input-sm" name="search[admin_id]">*}
                                    {*<option value=0>全部</option>*}
                                    {*{foreach $admin as $key=>$value}*}
                                        {*<option {if {$_REQUEST['search']['admin_id']==$value['admin_id']}}selected {/if}*}
                                                {*value="{$value['admin_id']}">{$value['fullname']}</option>*}
                                    {*{/foreach}*}
                                {*</select>*}
                            {*</div>*}
                        {*</div>*}
                        <div class="form-group col-md-5">
                            <label class="col-md-3 control-label">价格区间</label>

                            <div class="col-md-4">
                                <input type='text' class="form-control" placeholder=""
                                       name="search[start_price]" value="{$_demand['price_up']}"/>
                            </div>
                            <div class="col-md-1" style="height: 30px;line-height: 30px;text-align: center;">——</div>
                            <div class="col-md-4 ">
                                <input type='text' class="form-control" placeholder=""
                                       name="search[end_price]" value="{$_demand['price_down']}"/>
                            </div>
                        </div>
                        <div class="form-group col-md-5">
                            <label class="col-md-3 control-label">人数区间</label>
                            <div class="col-md-4">
                                <input type='text' class="form-control" placeholder=""
                                       name="search[start_people]" value="{$_demand['start_people']}"/>
                            </div>
                            <div class="col-md-1" style="height: 30px;line-height: 30px;text-align: center;">——</div>
                            <div class="col-md-4 ">
                                <input type='text' class="form-control" placeholder=""
                                       name="search[end_people]" value="{$_demand['end_people']}"/>
                            </div>
                        </div>
                    </div>
                    <div class="form-body clearfix">
                        <div class="form-group col-md-4">
                            <label class="col-md-3 control-label">城市</label>

                            <div class="col-md-4">
                                <select class="form-control input-sm" name="search[city]">
                                    <option value=0>全部</option>
                                    {foreach $_REQUEST['cities'] as $value}
                                        <option {if $value==$_demand['city']}selected {/if}
                                                value="{$value}">{$value}</option>
                                    {/foreach}
                                </select>
                            </div>
                        </div>
                        <div class="form-group col-md-3">
                            <label class="col-md-2 control-label">行政区域</label>
                            <div class="col-md-4">
                                <input type='text' class="form-control" placeholder="例如徐汇区"
                                       name="search[admin_area]" value=""/>
                            </div>
                        </div>
                        <div class="form-group col-md-4">
                            <label class="col-md-3 control-label">子空间标签</label>
                            <div class="col-md-7">
                                {*<input name="data_i[space_id]" placeholder="输入标签名称或id"*}
                                       {*class="form-control select2"*}
                                       {*id="space_id" type="hidden">*}
                                <input type="text" class="form-control select2 tags_select2"  name="tags_list" data-values="{implode(',',$_tag_list)}">
                            </div>
                            <div class="col-md-2">
                                <button type="button"  class="btn btn-success add_tag">添加标签</button>
                            </div>
                        </div>
                    </div>
                    <div class="form-body clearfix tag_table hide">
                        <div class="form-group col-md-12">
                            <label class="col-md-2 control-label">确认子空间标签</label>
                            <div class="col-md-8">
                                <div class="table-responsive">
                                    <table class="table table-hover tag_margin">
                                        <thead>
                                        <tr >
                                            <th>
                                                标签名称
                                            </th>
                                            <th>
                                                标签选项
                                            </th>
                                            <th>
                                                操作
                                            </th>
                                        </tr>
                                        <tr class="hide h_clone">
                                            <td class="col-md-4">
                                                <input type="hidden" name="" value="" class="tags_id">
                                                <span class="tag_name"></span>
                                            </td>
                                            <td  class="col-md-6">
                                                <div class="radio-list">
                                                    <label class="radio-inline" style="margin-left: 15px;">
                                                        <input name="" value="1" type="radio">有
                                                    </label>
                                                    <label class="radio-inline" style="margin-left: 15px;">
                                                        <input name="" value="2" type="radio">无
                                                    </label>
                                                    <label class="radio-inline " style="margin-left: 15px;">
                                                        <input name="" value="3" type="radio">可有可无
                                                    </label>
                                                </div>
                                            </td>
                                            <td class="col-md-2">
                                                <span type="button" class="btn btn-danger" onclick="LvEdit.delete(this)">删除标签</span>
                                            </td>
                                        </tr>
                                        </thead>
                                        <tbody class="n_tbody">
                                        </tbody>
                                    </table>
                                </div>

                            </div>
                        </div>
                    </div>
                    <div class="form-actions">
                        <div class="" style="text-align: center">
                            <button type="submit" class="btn btn-primary" style="width: 150px">
                                保存需求匹配信息
                            </button>
                        </div>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>
{*{include 'OA_Static::demand_offer/inc/demand_offer_search.inc.tpl' index=1}*}
<style>
    table.tag_margin tr td,th{
        text-align: center;
        line-height: 25px;;
    }
</style>
<script type="text/javascript" src="js/moment.min.js"></script>
<script type="text/javascript" src="js/zh-cn.js"></script>
<script>
    $(document).ready(function () {
        $(".tags_select2").each(function () {
            $(this).select2({
                tags:   $(this).attr('data-values').split(',')
            })
        });
        $(".add_tag").click(function(){
            var tags = $(".tags_select2").select2('val');
            if(tags==''){
                top.alert('请填写或选择标签！');
                return false;
            }
            $.ajax({
                    type: "GET",
                    url: "http://{Core::$urls['host']}/static/api/demand/offer/check/demand/tag.json",
                    data: 'tags='+tags,
                    dataType: "json",
                    success: function(data){
                        if(data.status==1){
                            $('.tag_table').removeClass("hide");
                            var  n_obj = $('.n_tbody');
                            $.each(data.data, function(i,val){
                                var obj1 = $('.h_clone').clone();
                                obj1.removeClass("hide h_clone");
                                obj1.appendTo(n_obj);
                                var obj2 = obj1.find('input');
                                var j = n_obj.children('tr').size()-1;
                                obj2.eq(0).attr('name', 'search[tags]['+j+'][id]');
                                obj2.eq(0).attr('value', val.id);
                                obj1.find('.tag_name').html(val.tag_value);
                                var obj3 = obj1.find(':radio');
                                obj3.eq(0).attr('name', 'search[tags]['+j+'][value]');
                                obj3.eq(1).attr('name', 'search[tags]['+j+'][value]');
                                obj3.eq(2).attr('name', 'search[tags]['+j+'][value]');
                            });
                        }else{
                            top.alert(data.msg);
                        }
                    }
                });
        });
        function formatRepo(repo) {
            if (repo.loading) return repo.text;
            return repo.full_name;
        }

        function formatRepoSelection(repo) {
            return repo.full_name || repo.text;
        }
    });
    var LvEdit = function() {
        return {
            init: function() {
            },
            delete: function(obj) {
                $(obj).parent().parent().remove();
            }
        };
    }();
</script>
</body>
<!-- END BODY -->
</html>