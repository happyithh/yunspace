<form action="{$_root}order_operate" method="post" enctype="multipart/form-data">
<input type="hidden" name="order_no" value="{$orderinfo['order_no']}">
<input type="hidden" name="action" value="order_conform">

<div class="allt border1 mt-1">
<h1>
    修改合同细节<span style="font-size: 12px;">(<span class="required" style="display: inline-block;" aria-required="true">*</span>代表必填项)</span><br/><br/>
    <span class="required" style="display: inline-block;" aria-required="true">*</span>
    <input style="display: inline-block;width: 98%" type="text" class="form-control text-center col-md-10 input-lg" placeholder="请输入协议名称" name="data[协议标题]" value="{$orderinfo['order_conform']['协议标题']|default:''}">
</h1>

<div class="table-responsive mytable">
    <table class="table table-bordered">
        <tbody>
        {if $__user['super_vendor']}
            <tr>
                <td width="30%">供应商名称</td>
                <td>
                    <input type="text" class="form-control" placeholder="供应商名称" name="data[供应商名称]" value="{$orderinfo['order_conform']['供应商名称']|default:''}">
                </td>
            </tr>
            <tr>
                <td width="30%">供应商地址</td>
                <td>
                    <input type="text" class="form-control" placeholder="供应商地址" name="data[供应商地址]" value="{$orderinfo['order_conform']['供应商地址']|default:''}">
                </td>
            </tr>
        {/if}
        <tr>
            <td width="30%">供应商电话</td>
            <td>
                <input type="text" class="form-control" placeholder="供应商电话" name="data[供应商电话]" value="{$orderinfo['order_conform']['供应商电话']|default:''}">
            </td>
        </tr>
        <tr>
            <td width="30%">供应商传真</td>
            <td>
                <input type="text" class="form-control" placeholder="供应商传真" name="data[供应商传真]" value="{$orderinfo['order_conform']['供应商传真']|default:''}">
            </td>
        </tr>
        <tr>
            <td width="30%">供应商签约代表<span class="required" aria-required="true">*</span></td>
            <td>
                {if $orderinfo['order_conform']['供应商签约代表']}
                    <input type="text" class="form-control" placeholder="供应商签约代表" name="data[供应商签约代表]" value="{$orderinfo['order_conform']['供应商签约代表']}">
                {elseif $smarty.session.user['attr']['identity']['data']['法人代表']}
                    <input type="text" class="form-control" placeholder="供应商签约代表" name="data[供应商签约代表]" value="{$smarty.session.user['attr']['identity']['data']['法人代表']}">
                {elseif $smarty.session.user['attr']['identity']['data']['真实姓名']}
                    <input type="text" class="form-control" placeholder="供应商签约代表" name="data[供应商签约代表]" value="{$smarty.session.user['attr']['identity']['data']['真实姓名']}">
                {else}
                    <input type="text" class="form-control" placeholder="供应商签约代表" name="data[供应商签约代表]" value="">
                {/if}
            </td>
        </tr>
        </tbody>
    </table>

</div>

<div class="table-responsive mytable">
    <table class="table table-bordered">
        <tbody>
        <tr>
            <td width="30%">服务名称<span class="required" aria-required="true">*</span>
            </td>
            <td>
                <input type="text" class="form-control" placeholder="服务名称" name="data[服务名称]" value="{$orderinfo['order_conform']['服务名称']|default:$orderinfo['order_title']}">
            </td>
        </tr>
        <tr>
            <td>服务内容<span class="required" aria-required="true">*</span>
            </td>
            <td>
                <textarea class="form-control" rows="8" name="data[服务内容]">{$orderinfo['order_conform']['服务内容']|default:$orderinfo['remark']}</textarea>
            </td>
        </tr>
        <tr>
            <td>备注</td>
            <td>
                <textarea class="form-control" rows="4" name="data[备注]">{$orderinfo['order_conform']['备注']|default:''}</textarea>
            </td>
        </tr>
        </tbody>
    </table>

</div>
<div class="jyyd jym">订单金额与结算</div>
<div class="table-responsive mytable" style="overflow: inherit;">
    <style>
        .table > tbody > td {
            text-align: center !important;
            vertical-align: middle !important;
        }

        .table .btns i {
            cursor: pointer;
        }
    </style>
    <table class="table table-bordered">
        <thead>
        <tr class="active">
            <th width="20%">交易单价<span class="required" aria-required="true">*</span>
            </th>
            <th width="15%">交易数量<span class="required" aria-required="true">*</span>
            </th>
            <th width="25%">交易总计</th>
            <th width="20%">交付时间<span class="required" aria-required="true">*</span>
            </th>
            <th width="20%">结算时间</th>
        </tr>
        </thead>
        <tbody>
        <tr>
            <td>
                <div class="input-group">
                    <input type="text" class="form-control js_plus" name="data[交易单价]" value="{$orderinfo['order_conform']['交易单价']|default:$orderinfo['order_detail']['price']}">

                    <div class="input-group-addon">元
                    </div>
                </div>
            </td>
            <td>
                <input type="text" class="form-control js_plus" name="data[交易数量]" value="{$orderinfo['order_conform']['交易数量']|default:$orderinfo['order_detail']['size']}">
            </td>
            <td>
                <div class="input-group">
                    <input type="text" class="form-control js_plus_result" name="data[交易总计]" value="{$orderinfo['order_conform']['交易总计']|default:$orderinfo['order_price']}">

                    <div class="input-group-addon">元
                    </div>
                </div>
            </td>
            <td>
                <div class="input-group ">
                    <input type='text' class="form-control date" placeholder="请选择" name="data[交付时间]" value="{$orderinfo['order_conform']['交付时间']|default:$orderinfo['start_date']}"/>
                    <span class="input-group-addon"><span class="glyphicon glyphicon-calendar"></span></span>
                </div>
            </td>
            <td>
                <div class="input-group ">
                    <input type='text' class="form-control date" placeholder="请选择" name="data[结算时间]" value="{$orderinfo['order_conform']['结算时间']|default:$orderinfo['start_date']}"/>
                    <span class="input-group-addon"><span class="glyphicon glyphicon-calendar"></span></span>
                </div>
            </td>
        </tr>
        </tbody>
    </table>
    <script>
        $('.js_plus').change(function () {
            $('.js_plus_result').val($('.js_plus').eq(0).val() * $('.js_plus').eq(1).val());
            $('.js_plus2').trigger('change');
        });
    </script>
</div>
<div class="jyyd jym">支付方式</div>
<div class="table-responsive mytable" style="overflow: inherit;">
    <table class="table table-bordered" id="form_pay">
        <thead>
        <tr class="active">
            <th width="30%">支付节点<span class="required" aria-required="true">*</span>
            </th>
            <th width="10%">支付比例</th>
            <th width="20%">支付总计</th>
            <th width="25%">支付期限</th>
            <th width="5%">结算</th>
            <th width="10%">操作</th>
        </tr>
        <tr class="hidden">
            <td>
                <input type="text" class="form-control" name="data[支付节点][$$][名称]">
            </td>
            <td>
                <div class="input-group">
                    <input type="text" class="form-control js_plus2" name="data[支付节点][$$][比例]">

                    <div class="input-group-addon">%
                    </div>
                </div>
            </td>
            <td>
                <div class="input-group">
                    <input type="text" class="form-control js_plus_result2" name="data[支付节点][$$][金额]">

                    <div class="input-group-addon">元
                    </div>
                </div>
            </td>
            <td>
                <div class='input-group'>
                    <input type='text' class="form-control date" placeholder="请选择" name="data[支付节点][$$][期限]"/>
                    <span class="input-group-addon"><span class="glyphicon glyphicon-calendar"></span></span>
                </div>
            </td>
            <td>
                <label class="checkbox-inline">
                    <input type="checkbox" name="data[支付节点][$$][结算]" value="1" disabled>
                </label>
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
                <a style="width: 100%; text-align: center; display: block; cursor: pointer" onclick="FormAttr.add('#form_pay')">
                    <i class="fa fa-plus"></i>
                    添加
                </a>
            </td>
        </tr>
    </table>
</div>

<div class="jyyd jym">订单外款项
    <small> (如押金等)</small>
</div>
<div class="table-responsive mytable" style="overflow: inherit;">
    <table class="table table-bordered" id="form_pay2">
        <thead>
        <tr class="active">
            <th width="40%">款项名目</th>
            <th width="25%">支付金额</th>
            <th width="25%">支付期限</th>
            <th width="10%">操作</th>
        </tr>
        <tr class="hidden">
            <td>
                <span class="required" aria-required="true">*</span>
                <input style="display: inline-block;width: 95%;" type="text" class="form-control" name="data[订单外款项][$$][名称]">
            </td>
            <td>
                <div class="input-group" style="width: 95%;float: right;">
                    <input  type="text" class="form-control" name="data[订单外款项][$$][金额]">

                    <span class="input-group-addon">元
                    </span>
                </div>
                <span class="required" aria-required="true">*</span>

            </td>
            <td>
                <div class='input-group date' style="width: 95%;float: right;">
                    <input type='text' class="form-control" placeholder="请选择" name="data[订单外款项][$$][期限]"/>
                    <span class="input-group-addon"><span class="glyphicon glyphicon-calendar"></span></span>
                </div>
                <span class="required" aria-required="true">*</span>
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
            <td colspan="5">
                <a style="width: 100%; text-align: center; display: block; cursor: pointer" onclick="FormAttr.add('#form_pay2')">
                    <i class="fa fa-plus"></i>
                    添加
                </a>
            </td>
        </tr>
    </table>
    <script type="text/javascript" src="js/moment.min.js"></script>
    <script type="text/javascript" src="js/zh-cn.js"></script>
    <script type="text/javascript" src="js/bootstrap-datetimepicker.min.js"></script>
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
                    if(values[4])
                        newTr.find('input:eq(4)').attr('checked','checked');
                }
                newTr.find('.js_plus2').change(function () {
                    $(this).parent().parent().parent().find('.js_plus_result2')
                            .val($('.js_plus_result').val() * $(this).val() / 100);
                });
                newTr.find('.date').datetimepicker({
                    format: 'YYYY-MM-DD',
                    locale: 'zh-cn'
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
            }
        };
        $('.js_plus_result').change(function () {
            $('.js_plus2').trigger('change');
        });
        $('.date').datetimepicker({
            format: 'YYYY-MM-DD',
            locale: 'zh-cn'
        });

        {if $orderinfo['order_conform']['支付节点']}

        {foreach $orderinfo['order_conform']['支付节点'] as $v}
        FormAttr.add('', ['{$v['名称']}', '{$v['比例']}', '{$v['金额']}', '{$v['期限']}', '{$v['结算']}']);
        {/foreach}
        {else}
        FormAttr.add('', ['首付款', 30, 0, '{$orderinfo['start_date']}']);
        FormAttr.add('', ['尾款', 70, 0, '{$orderinfo['start_date']}']);

        {/if}
        {if $orderinfo['order_conform']['订单外款项']}

        {foreach $orderinfo['order_conform']['订单外款项'] as $v}
        FormAttr.add('#form_pay2', ['{$v['名称']}', '{$v['金额']}', '{$v['期限']}', 0]);
        {/foreach}
        {/if}
    </script>
</div>

<div class="jyyd jym">附件文件</div>
<div class="hidden jyyd_files">
    <div class="fujian">
        <i class="fa fa-paperclip"></i>
        <span></span>
        <input type="hidden" name="data[附件][$$][path]">
        <input type="hidden" name="data[附件][$$][name]">
    </div>
</div>
<div id="jyyd_files">
</div>
<hr>
<i class="fa fa-bell"></i> 不能上传超过20MB的文件!
{include file="Admin::inc/plupload.tpl" upload_url="{$_root}order_info/upload"}
<script>
    var fileIndex = $('#jyyd_files>div').size() + 10;
    uploader.onFileUploaded = function (file, path) {
        if (!path) {
            return alert(file.name + ' 上传失败!');
        }
        addFile(file.name, path);
    }
    function addFile(name, path) {
        fileIndex++;
        var newFile = $('.jyyd_files .fujian').clone();
        newFile.find('input').each(function () {
            $(this).attr('name', $(this).attr('name').replace('$$', fileIndex));
        });
        newFile.find('input:eq(0)').val(path);
        newFile.find('input:eq(1)').val(name);
        newFile.find('span').html(name+'<a href="javascript:;" style="font-size: 25px; color: #ff0000; padding-top: 10px" onclick="removeFile(this)">&nbsp;&nbsp;×&nbsp;&nbsp;</a>');
        newFile.appendTo('#jyyd_files');
    }
    function removeFile(o) {
        $(o).parent().parent().remove();
    }
    {if $orderinfo['order_conform']['附件']}
    {foreach $orderinfo['order_conform']['附件'] as $v}
    addFile('{$v['name']}', '{$v['path']}');
    {/foreach}
    {/if}
</script>
<div style="text-align: center; margin: 30px 0 0 0">
    <button type="submit" class="btn btn-primary btn-lg">
        提交
    </button>
    {*<button type="reset" class="btn btn-danger btn-lg">*}
        {*放弃修改*}
    {*</button>*}
</div>
</div>
</form>