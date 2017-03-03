<div class="portlet tabbable">
    <div class="portlet-title">
        <div class="caption">
            <i class="fa fa-database"></i>套餐信息
        </div>
    </div>
    <form class="form-horizontal" role="form" action="?" method="post">
        <div class="portlet-body form">
            <input type="hidden" name="set_id" value="{$_REQUEST['set_id']}">
            <input type="hidden" name="action" value="{$_REQUEST['action']}">
            <input type="hidden" name="is_submit" value="1">
            <input type="hidden" name="tab" value="{$_REQUEST['tab']}">
            <input type="hidden" name="vendor_id" value="{$_REQUEST['vendor_id']}">
            <style>
                .control-label.col-md-2 {
                    font-size: 12px;
                    padding: 0;
                }
            </style>
            <div class="form-body">
                <div class="row">
                    <div class="col-md-6">
                        <div class="form-group">
                            <label class="control-label col-md-2">套餐名称<span class="required"
                                                                          aria-required="true">*</span></label>

                            <div class="col-md-10">
                                <input type="text" class="form-control" placeholder="套餐名称" name="data[set_name]"
                                       value="{$_data['set_name']}">
                            </div>
                        </div>
                    </div>
                    <div class="col-md-6">
                        <div class="form-group">
                            <label class="control-label col-md-2">场地ID</label>

                            <div class="col-md-10">
                                <div class="col-md-12 input-group select">
                                    <input name="schedule_product_id" placeholder="请输入产品档期的ID或名称"
                                           class="form-control select2"
                                           id="schedule_product_id" type="hidden"
                                           value="{$_data['schedule_product_id']}">
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-6">
                        <div class="form-group">
                            <label class="control-label col-md-2">营销标题<span class="required"
                                                                            aria-required="true">*</span></label>

                            <div class="col-md-10">
                                <input type="text" class="form-control" placeholder="请填写营销标题，来吸引更多客户"
                                       name="data[marketing_title]"
                                       value="{$_data['marketing_title']}">
                            </div>
                        </div>
                    </div>
                    <div class="col-md-6">
                        <div class="form-group">
                            <label class="control-label col-md-2">地址</label>

                            <div class="col-md-10">
                                <input type="text" class="form-control" name="data[addr]"
                                       placeholder="地址"
                                       value="{$_data['addr']}">
                            </div>
                        </div>
                    </div>
                    <div class="col-md-6">
                        <div class="form-group">
                            <label class="control-label col-md-2">类别<span class="required" aria-required="true">*</span></label>

                            <div class="col-md-10">
                                <select name="data[category_id]" class="form-control input-sm">
                                    {foreach $category_name as $key=>$val}
                                        <option {if {$_data['category_id']}==$key}selected{/if}
                                                value="{$key}">{$val}</option>
                                    {/foreach}
                                </select>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-6">
                        <div class="form-group">
                            <label class="control-label col-md-2">版本</label>

                            <div class="col-md-10">
                                <input type="text" class="form-control" name="data[version]" placeholder="版本信息"
                                       value="{$_data['version']}">
                            </div>
                        </div>
                    </div>
                    <div class="col-md-6">
                        <div class="form-group">
                            <label class="control-label col-md-2">城市<span class="required"
                                                                          aria-required="true">*</span></label>

                            <div class="col-md-10">
                                <input type="text" class="form-control select2 tags_select2"
                                       placeholder="请填写城市"
                                       name="data[attr_index][城市]"
                                       value="{$_data['attr_index']['城市']|default:$accountInfo['vendors'][0]['attr']['城市']}"
                                       data-values="{implode(',' ,$_attrs['城市'])}">
                            </div>
                        </div>
                    </div>
                    <div class="col-md-6">
                        <div class="form-group">
                            <label class="control-label col-md-2">适合人数<br>（筛选）</label>

                            <div class="col-md-10">
                                <input type="text" class="form-control" name="data[people]"
                                       placeholder="用于搜索时的筛选，请填写整数"
                                       value="{$_data['people']}">
                            </div>
                        </div>
                    </div>
                    <div class="col-md-6">
                        <div class="form-group">
                            <label class="control-label col-md-2">套餐特色<span class="required"
                                                                            aria-required="true">*</span></label>

                            <div class="col-md-10">
                                <input type="text" class="form-control select2 tags_select2"
                                       placeholder="请填写您的套餐特色，单个填写完后回车键确定"
                                       name="data[attr_index][套餐特色]" value="{$_data['attr_index']['套餐特色']}"
                                       data-values="{implode(',' ,$_attrs['服务行业'])}">
                            </div>
                        </div>
                    </div>
                    <div class="col-md-6">
                        <div class="form-group">
                            <label class="control-label col-md-2">适合人数<br>（展示）</label>

                            <div class="col-md-10">
                                <input type="text" class="form-control" name="data[attr_index][人数]"
                                       placeholder="例: 100人（250㎡）" value="{$_data['attr_index']['人数']}">
                            </div>

                        </div>
                    </div>
                    <div class="col-md-6">
                        <div class="form-group">
                            <label class="control-label col-md-2">服务时长<span class="required"
                                                                            aria-required="true">*</span></label>

                            <div class="col-md-10">
                                <div class="input-group input-large input-range"
                                     style="float: left">
                                    <input type="text" class="form-control" name="data[hours]"
                                           placeholder="用于搜索时的筛选，请填写整数" value="{$_data['hours']}">
                                    <span class="input-group-addon">小时</span>

                                </div>
                            </div>

                        </div>
                    </div>
                    <div class="col-md-6">
                        <div class="form-group">
                            <label class="control-label col-md-2">服务时长<br>（展示）</label>

                            <div class="col-md-10">
                                <input type="text" class="form-control" name="data[attr_index][天数]"
                                       placeholder="例: 1天(4小时搭建，12小时使用)" value="{$_data['attr_index']['天数']}">
                            </div>

                        </div>
                    </div>
                    <div class="col-md-6">
                        <div class="form-group">
                            <label class="control-label col-md-2">
                                工作日<br>（复选）</label>

                            <div class="col-md-10">
                                <label class="checkbox-inline">
                                    <input type="checkbox" name="data[attr_index][工作日可选]"
                                           {if !$_data['attr_index']||$_data['attr_index']['工作日可选']}checked{/if}/>工作日可选
                                </label>
                                <label class="checkbox-inline">
                                    <input type="checkbox" name="data[attr_index][节假日可选]"
                                           {if $_data['attr_index']['节假日可选']}checked{/if}/>节假日可选
                                </label>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-6">
                        <div class="form-group">
                            <label class="control-label col-md-2">有效期</label>

                            <div class="col-md-10">
                                <div class="input-group input-large date-picker input-daterange"
                                     data-date="10/11/2012"
                                     data-date-format="mm/dd/yyyy" style="float: left">
                                    <input type="text" class="form-control date"
                                           name="data[attr_index][开始时间]" placeholder="开始时间"
                                           value="{$_data['attr_index']['开始时间']}"> <span class="input-group-addon"> 至</span>
                                    <input type="text" class="form-control date"
                                           name="data[attr_index][结束时间]" placeholder="结束时间"
                                           value="{$_data['attr_index']['结束时间']}">
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="row">
                    <div class="col-md-6">
                        <div class="form-group">
                            <label class="control-label col-md-2">套餐价<span class="required"
                                                                           aria-required="true">*</span>
                            </label>

                            <div class="col-md-10">
                                <div class="input-group input-large input-range"
                                     style="float: left">
                                    <input type="text" class="form-control" name="data[detail][套餐价]"
                                           placeholder="请填写套餐价"
                                           value="{$_data['detail']['套餐价']}">
                                    <span class="input-group-addon">元/</span>
                                    <input type="text" class="form-control" name="data[detail][计价单位]"
                                           placeholder='例：天、桌、人、3小时，不填写表示无单位'
                                           value="{$_data['detail']['计价单位']}">

                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-6">
                        <div class="form-group">
                            <label class="control-label col-md-2">市场价 </label>

                            <div class="col-md-10">
                                <div class="input-group input-large input-range"
                                     style="float: left">
                                    <input type="text" class="form-control" name="data[detail][市场价]"
                                           placeholder="市场价"
                                           value="{$_data['detail']['市场价']}">
                                    <span class="input-group-addon">元</span>

                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-6">
                        <div class="form-group">
                            <label class="control-label col-md-2">订购数量<br>下限</label>

                            <div class="col-md-10">
                                <input type="text" class="form-control" name="data[detail][计价下限]"
                                       placeholder="每笔订单的订购数量下限,默认为:1"
                                       value="{$_data['detail']['计价下限']}">
                            </div>

                        </div>
                    </div>
                    <div class="col-md-6">
                        <div class="form-group">
                            <label class="control-label col-md-2">订购数量<br>上限</label>

                            <div class="col-md-10">
                                <input type="text" class="form-control" name="data[detail][计价上限]"
                                       placeholder="每笔订单的订购数量上限,默认为:1"
                                       value="{$_data['detail']['计价上限']}">
                            </div>
                        </div>
                    </div>
                </div>
                <div class="row">
                    <div class="col-md-12">
                        <div class="form-group">
                            <label class="control-label col-md-1">套餐简介<span class="required"
                                                                            aria-required="true">*</span></label>

                            <div class="col-md-11">
                                {include "Admin::inc/html_umeditor.tpl" name="data[des]" value=$_data['des'] height=200}
                            </div>
                        </div>
                    </div>
                    <div class="col-md-12">
                        <div class="form-group">
                            <label class="control-label col-md-1">服务详情</label>

                            <div class="col-md-11">
                                {include "Admin::inc/html_umeditor.tpl"  name="data[detail_des]" value=$_data['detail_des'] height=300}
                                <div style="margin-top: 10px;">
                                    <button type="button" onclick="changeTemplete.templete1(this)"
                                            class="btn btn-info templete1">基本模板
                                    </button>
                                    <button type="button" onclick="changeTemplete.templete2(this)"
                                            class="btn btn-info templete2">发布会模板
                                    </button>
                                    <button type="button" onclick="changeTemplete.templete3(this)"
                                            class="btn btn-info templete3">年会模板
                                    </button>
                                </div>
                            </div>
                        </div>
                        <div class="row hide">
                            <div id="templete1">
                                {include file="customer_account_new/inc/templete/templete1.tpl"}
                            </div>
                            <div id="templete2">
                                {include file="customer_account_new/inc/templete/templete2.tpl"}
                            </div>
                            <div id="templete3">
                                {include file="customer_account_new/inc/templete/templete3.tpl"}
                            </div>
                        </div>
                    </div>
                </div>
                <div class="row hide">
                    <div class="col-md-12">
                        <div class="form-group">
                            <label class="control-label col-md-1">套餐版本</label>

                            <div class="col-md-11">

                                <table class="table table-bordered" id="form_pay">
                                    <thead>
                                    <tr class="active">
                                        <th width="15%">名称</th>
                                        <th width="10%">
                                            空间场地（id/url）
                                        </th>
                                        <th width="10%">
                                            硬体搭建（id/url）
                                        </th>
                                        <th width="20%">
                                            备注（用|分隔）
                                        </th>
                                        <th width="15%">总价</th>
                                        <th width="5%">操作</th>
                                    </tr>
                                    <tr class="hidden">
                                        <td>
                                            <input type="text" class="form-control" name="data[detail_data][$$][名称]"
                                                   placeholder="名称">
                                        </td>
                                        <td>
                                            <input type="text" class="form-control js_plus2"
                                                   placeholder="空间场地（可输入url或id）"
                                                   name="data[detail_data][$$][产品][0]">
                                        </td>
                                        <td>
                                            <input type="text" class="form-control js_plus_result2"
                                                   placeholder="硬体搭建（可输入url或id）" name="data[detail_data][$$][产品][1]">
                                        </td>
                                        <td>
                                            <input type="text" class="form-control js_plus_result2"
                                                   placeholder="备注（使用|分隔）" name="data[detail_data][$$][备注]">
                                        </td>
                                        <td>
                                            <input type="text" class="form-control" name="data[detail_data][$$][价格]"
                                                   value="" placeholder="请输入优惠后的总价">
                                        </td>
                                        <td class="btns">
                                            <i class="fa fa-long-arrow-up" onclick="FormAttr.up(this)"></i>
                                            <i class="fa fa-long-arrow-down" onclick="FormAttr.down(this)"></i>
                                            <i class="fa fa-trash-o" onclick="FormAttr.remove(this)"></i>
                                        </td>
                                    </tr>
                                    </thead>
                                    <tbody>
                                    </tbody>
                                    <tr>
                                        <td colspan="6">
                                            <a style="width: 100%; text-align: center; display: block; cursor: pointer"
                                               onclick="FormAttr.add('#form_pay')">
                                                <i class="fa fa-plus"></i>
                                                添加
                                            </a>
                                        </td>
                                    </tr>
                                </table>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <script>
            FormAttr = {
                index: 0,
                add: function (o, values) {
                    var table = '';
                    if (o) {
                        table = $(o);
                    } else {
                        table = $('#form_pay');
                    }
                    if (!FormAttr.index) {
                        FormAttr.index = table.find('tr').size() + 10;
                    }
                    FormAttr.index++;
                    var newTr = table.find('thead>tr.hidden').eq(0).clone().removeClass('hidden');
                    newTr.appendTo(table.find('tbody').eq(0));
                    newTr.find('input').each(function () {
                        $(this).attr('name', $(this).attr('name').replace('$$', FormAttr.index));
                    });
                    if (values) {
                        newTr.find('input:eq(0)').val(values[0]);
                        newTr.find('input:eq(1)').val(values[1]);
                        newTr.find('input:eq(2)').val(values[2]);
                        newTr.find('input:eq(3)').val(values[3]);
                        newTr.find('input:eq(4)').val(values[4]);
                    }
                },
                remove: function (o) {
                    $(o).parents('tr').remove();
                },
                up: function (o) {
                    var tr = $(o).parents('tr');
                    tr.after(tr.prev());
                },
                down: function (o) {
                    var tr = $(o).parents('tr');
                    tr.before(tr.next());
                }
            };
            {if $_data['detail_data']}
            {foreach $_data['detail_data'] as $key=>$val}
            FormAttr.add('#form_pay', ['{$val['名称']}', '{$val['产品'][0]}', '{$val['产品'][1]}', '{$val['备注']}', '{$val['价格']}']);
            {/foreach}
            {else}
            FormAttr.add('#form_pay', ['品质版', '', '', '']);
            FormAttr.add('#form_pay', ['奢华版', '', '', '']);
            {/if}
        </script>


        <div class="col-md-12">
            <div class="form-group">
                <label class="control-label col-md-1">图片</label>

                <div class="col-md-11">

                    <!--      ---------------------------图片/视频  start-------------------------------      -->
                    <div class="tab-pane active" id="tab_2">
                        {include file="Admin::inc/plupload.tpl"}
                        <script>
                            uploader.onFileUploaded = function (file, path) {
                                UploadFiles.add(file, path);
                            }
                            var UploadFiles = {
                                media_id: 0,
                                add: function (file, path) {
                                    if (UploadFiles.media_id < 1) {
                                        UploadFiles.media_id = $('#upload_files tr').size() + 10;
                                    }
                                    UploadFiles.media_id++;
                                    var newFile = $('#upload_files').parents('table').find('.hidden').clone().removeClass('hidden');
                                    newFile.find('img').attr('src', path);
                                    newFile.appendTo('#upload_files');
                                    newFile.find('input').each(function () {
                                        $(this).attr('name', $(this).attr('name').replace('$$', UploadFiles.media_id));
                                    });
                                    newFile.find('input:eq(0)').val(path);
                                    newFile.find('input:eq(1)').val(file.name);
                                    newFile.find('input:eq(2)').select2({
                                        tags: UploadFiles.tags.split(',')
                                    });
                                },
                                remove: function (o) {
                                    $(o).parents('tr').remove();
                                },
                                up: function (o) {
                                    var tr = $(o).parents('tr');
                                    tr.after(tr.prev());
                                },
                                down: function (o) {
                                    var tr = $(o).parents('tr');
                                    tr.before(tr.next());
                                },
                                tags: '@主图,外景图片,内景图片,平面图,视频'
                            };
                        </script>
                        <style>
                            .table td {
                                vertical-align: middle !important;
                            }

                            .table .thumbnail {
                                margin-bottom: 0;
                            }

                            .table td img {
                                border-radius: 4px;
                            }

                            .table .btns i {
                                cursor: pointer;
                            }

                            .table1 td {
                                padding: 5px;
                            }

                            }
                        </style>
                        <table class="table table-hover">
                            <thead>
                            <tr>
                                <th width="80">缩略图</th>
                                <th>名称</th>
                                <th width="50%">标签</th>
                                <th width="60">操作</th>
                            </tr>
                            <tr class="hidden">
                                <td>
                                    <img src="" style="height: 80px; width: 80px; display: block;">
                                </td>
                                <td>
                                    <input type="hidden" name="data[media][$$][path]">
                                    <input class="form-control" type="text" name="data[media][$$][name]">
                                </td>
                                <td>
                                    <input class="form-control select2" type="text" name="data[media][$$][tags]">
                                    <input class="form-control" type="text" name="data[media][$$][video]">
                                </td>
                                <td class="btns">
                                    <i class="fa fa-long-arrow-up" onclick="UploadFiles.up(this)"></i>
                                    <i class="fa fa-long-arrow-down" onclick="UploadFiles.down(this)"></i>
                                    <i class="fa fa-trash-o" onclick="UploadFiles.remove(this)"></i>
                                </td>
                            </tr>
                            </thead>
                            <tbody id="upload_files">
                            {foreach $_data['media'] as $k=>$v}
                                <tr>
                                    <td>
                                        <img src="{$v['path']}" style="height: 80px; width: 80px; ">
                                    </td>
                                    <td>
                                        <input type="hidden" name="data[media][{$k}][path]" value="{$v['path']}">
                                        <input class="form-control" type="text" name="data[media][{$k}][name]"
                                               value="{$v['name']}">
                                    </td>
                                    <td>
                                        <input class="form-control select2 tags_select3_set" type="text"
                                               name="data[media][{$k}][tags]"
                                               value="{$v['tags']}">
                                        <input class="form-control tags_select3_set" type="text"
                                               name="data[media][{$k}][video]"
                                               value="{$v['video']}">
                                    </td>
                                    <td class="btns">
                                        <i class="fa fa-long-arrow-up" onclick="UploadFiles.up(this)"></i>
                                        <i class="fa fa-long-arrow-down" onclick="UploadFiles.down(this)"></i>
                                        <i class="fa fa-trash-o" onclick="UploadFiles.remove(this)"></i>
                                    </td>
                                </tr>
                            {/foreach}
                            </tbody>
                        </table>
                    </div>
                    <!--      ---------------------------图片视频  end-------------------------------      -->
                </div>
            </div>
        </div>


</div>
</div>
<div class="form-group">
</div>

<div class="form-actions text-center">
    <button type="reset" class="btn btn-default">
        重置
    </button>
    <button type="submit" class="btn btn-success">
        提交
    </button>
    <a href="{$_root}set_info/{md5($_data['id'])}/{$_data['id']}.html" target="_blank">
        <button type="button" class="btn btn-success">
            预览
        </button>
    </a>
</div>
</form>
</div>
<link rel="stylesheet" type="text/css" href="{$_assets}plugins/bootstrap-wysihtml5/bootstrap-wysihtml5.css"/>
<script type="text/javascript" src="{$_assets}plugins/bootstrap-wysihtml5/wysihtml5-0.3.0.js"></script>
<script type="text/javascript" src="{$_assets}plugins/bootstrap-wysihtml5/bootstrap-wysihtml5.js"></script>
<script type="text/javascript" src="js/moment.min.js"></script>
<script type="text/javascript" src="js/zh-cn.js"></script>
<script type="text/javascript" src="js/bootstrap-datetimepicker.min.js"></script>
<script>
    $(document).ready(function () {
        $('.wysihtml5').wysihtml5();
        $(".tags_select2").each(function () {
            $(this).select2({
                tags: $(this).data('values').split(',')
            })
        });
        $('.date').datetimepicker({
            format: 'YYYY-MM-DD',
            locale: 'zh-cn'
        });
        $(".tags_select3_set").each(function () {
            $(this).select2({
                tags: UploadFiles.tags.split(',')
            })
        });

        var c1=$("#ceil_price_s").attr("checked");
        var c2=$("#ceil_price_m").attr("checked");
        if(c1==="checked"){
            $("#show_price_s").show();
        }else{
            $("#show_price_s").hide();
        }
        if(c2==="checked"){
            $("#show_price_m").show();
        }else{
            $("#show_price_m").hide();
        }

        var c3=$("#yikoujia").attr("checked");
        var c4=$("#danweijia").attr("checked");
        if(c3==="checked"){
            $("#a").css('display','none');
            $("#b").css('display','none');
            $("#c").css('display','none');
            $("#d").css('display','none');
            $("#e").css('display','');
            $("#f").css('display','');
        }
        if(c4==="checked"){
            $("#a").css('display','');
            $("#b").css('display','');
            $("#c").css('display','');
            $("#d").css('display','');
            $("#e").css('display','none');
            $("#f").css('display','none');
        }

        $("#ceil_price_s").click(function(){
            $("#show_price_s").toggle();
        });
        $("#ceil_price_m").click(function(){
            $("#show_price_m").toggle();
        });
        var yikoujia=$("#yikoujia").attr("checked");
        if(yikoujia=="checked"){
            $("#a").find("input").eq(0).attr('name','');
            $("#b").find("input").eq(0).attr('name','');
        }
        $("#yikoujia").click(function(){
            $("#a").css('display','none');
            $("#b").css('display','none');
            $("#c").css('display','none');
            $("#d").css('display','none');
            $("#e").css('display','');
            $("#f").css('display','');
            $("#a").find("input").eq(0).attr('name','');
            $("#b").find("input").eq(0).attr('name','');

            var e_attr = $("#e").find("input").eq(0).attr('name');
            var f_attr = $("#f").find("input").eq(0).attr('name');
            if(e_attr=="") {
                $("#e").find("input").eq(0).attr('name','data[detail][套餐价]');
            }
            if(f_attr=="") {
                $("#f").find("input").eq(0).attr('name','data[detail][市场价]');
            }
        });
        $("#danweijia").click(function(){
            $("#a").css('display','');
            $("#b").css('display','');
            $("#c").css('display','');
            $("#d").css('display','');
            $("#e").css('display','none');
            $("#f").css('display','none');
            $("#a").find("input").eq(0).attr('name','data[detail][套餐价]');
            $("#b").find("input").eq(0).attr('name','data[detail][市场价]');
            $("#e").find("input").eq(0).attr('name','');
            $("#f").find("input").eq(0).attr('name','');
        });

    });

    $("#schedule_product_id").select2({
        placeholder: "选择产品",
        minimumInputLength: 1,
        ajax: {
            url:"http://{Core::$urls['host']}/static/api/product/search/all.jsonp?action=product",
            dataType: 'json',
            data: function (term, page) {
                return {
                    q: term, // search term
                    query_product: 1
                };
            },
            results: function (data, page) { // parse the results into the format expected by Select2.
                console.log(data.data);
                // since we are using custom formatting functions we do not need to alter remote JSON data
                return {
                    results: data.data
                };
            }
        },
        initSelection: function (element, callback) {
            var id = $(element).val();
            if (id !== "") {
                $.ajax("http://{Core::$urls['host']}/static/api/product/search/all.jsonp?action=product", {
                    data: {
                        id: id
                    },
                    dataType: "json"
                }).done(function (data) {
                    console.log(data);
                    callback(data.data[0]);
                });
            }
        },
        formatResult: formatRepo, // omitted for brevity, see the source of this page
        formatSelection: formatRepoSelection, // omitted for brevity, see the source of this page
        escapeMarkup: function (m) {
            return m;
        } // we do not want to escape markup since we are displaying html in results
    });
    function formatRepo(repo) {
        if (repo.loading) return repo.text;
        return repo.name;
    }

    function formatRepoSelection(repo) {
        return repo.name || repo.text;
    }


    //服务详情编辑器模板
    changeTemplete = {
        templete1: function (o) {
            var uname = ue{md5('data[detail_des]')};
            //清空编辑器内容
            uname.setContent('');
            //获取模板1的内容
            var templete1 = $('#templete1').html();
            uname.setContent(templete1);
        },
        templete2: function (o) {
            var uname = ue{md5('data[detail_des]')};
            //清空编辑器内容
            uname.setContent('');
            //获取模板2的内容
            var templete2 = $('#templete2').html();
            uname.setContent(templete2);
        },
        templete3: function (o) {
            var uname = ue{md5('data[detail_des]')};
            //清空编辑器内容
            uname.setContent('');
            //获取模板1的内容
            var templete3 = $('#templete3').html();
            uname.setContent(templete3);
        }

    }

</script>