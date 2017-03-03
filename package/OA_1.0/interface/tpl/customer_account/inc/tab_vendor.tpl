<div class="portlet-body form">
    <style>
        .ms-container {
            width: 100% !important;
        }
    </style>
    <form action="?" class="form-horizontal" method="post" enctype="multipart/form-data">
        <input type="hidden" name="vendor_id" value="{$_REQUEST['vendor_id']}">
        <input type="hidden" name="data[vendor_account_id]"
               value="{$_data['vendor_account_id']|default:$_REQUEST['id']}">
        <input type="hidden" name="url_to" value="{$_REQUEST['url_to']}">
        <input type="hidden" name="tab" value="{$_REQUEST['tab']}">
        <input type="hidden" name="id" value="{$_REQUEST['id']}">
        <input type="hidden" name="action" value="{$_REQUEST['action']}">
        <input type="hidden" name="is_submit_vendor" value="1">

        <div class="form-body">
            {if $_data['status'] ==2}
                <span class="btn btn-warning btn-xs">供应商信息正在审核......</span>
            {/if}
            {if $_data['status'] ==3}
                <span class="btn btn-warning btn-xs"
                      style="background-color: #FF3333;margin-right: 30px;margin-bottom: 10px">审核已拒绝：信息不完全，需要对方重新填写</span>
                <a href="#"><span class="btn btn-warning btn-xs"
                                  style="margin-right: 30px;margin-bottom: 10px">发消息给供应商</span></a>
            {/if}
            {if $_data['status'] ==2 || $_data['status'] ==3}
                <a href="?action=detail&id={$accountInfo['id']}&vendor_id={$_data['id']}&tab=vendor&reset_vendor=1"
                   class="btn btn-info btn-xs" style="margin-bottom:10px"><i class="fa fa-eye"></i>重置</a>
            {/if}
            <div class="row">
                <div class="col-md-6">
                    <div class="form-group">
                        <label class=" col-md-2 control-label">名称<span class="required"
                                                                       aria-required="true">*</span></label>

                        <div class="col-md-10">
                            <input class="form-control" type="text" name="data[vendor_name]"
                                   value="{$_data['vendor_name']}">
                        </div>
                    </div>
                </div>
                <div class="col-md-6">
                    <div class="form-group">
                        <label class=" col-md-2 control-label">品牌名称</label>

                        <div class="col-md-10">
                            <input class="form-control" type="text" name="data[base_info][品牌名称]"
                                   value="{$_data['base_info']['品牌名称']}">
                        </div>
                    </div>
                </div>
                <div class="col-md-6">
                    <div class="form-group">
                        <label class=" col-md-2 control-label">服务类型</label>

                        <div class="col-md-10">
                            <select multiple="multiple" class="multi-select" name="data[categories_id][]"
                                    id="my_multi_select2" data-placeholder="Select...">
                                {function show_category level=0}
                                    {foreach $_categories[$id] as $k=>$v}
                                        {if $v}
                                            <option value="{$k}"
                                                    {if in_array($k,$_data['categories_id'])}selected="selected" {/if}>{str_repeat(' . . ', $lv)}
                                                {$v}
                                            </option>
                                        {/if}
                                        {if $_categories[$k]}
                                            {show_category data=$_categories id=$k lv=$lv+1}
                                        {/if}
                                    {/foreach}
                                {/function}
                                {show_category data=$_categories id=0 lv=1}
                            </select>
                        </div>
                    </div>
                </div>
                <div class="col-md-6">
                    <div class="form-group">
                        <label class=" col-md-2 control-label">地址</label>

                        <div class="col-md-10">
                            <input class="form-control" type="text" name="data[addr]"
                                   value="{$_data['addr']|default:$_data['base_info']['公司地址']}">
                        </div>
                    </div>
                </div>
                {foreach $_vendor_attr['attr'] as $k=>$v}
                    <div class="col-md-6">
                        <div class="form-group">
                            <label class="col-md-2 control-label">{if $k=='城市'}{$k}<span class="required" aria-required="true">*</span>{else}{$k}{/if}</label>

                            <div class="col-md-10">
                                {if $v}
                                    <input type="text" class="form-control tags_select2" name="data[attr][{$k}]"
                                           value="{$_data['attr'][$k]}" data-values="{implode(',',$v)}">
                                {else}
                                    <input type="text" class="form-control" name="data[attr][{$k}]"
                                           value="{$_data['attr'][$k]}">
                                {/if}
                            </div>
                        </div>
                    </div>
                {/foreach}
                <div class="col-md-6">
                    <div class="form-group">
                        <label class="col-md-2 control-label">业务范围</label>

                        <div class="col-md-10">
                            <input class="form-control" type="text" name="data[base_info][业务范围]"
                                   value="{$_data['base_info']['业务范围']}">
                        </div>
                    </div>
                </div>
                <div class="col-md-6">
                    <div class="form-group">
                        <label class="col-md-2 control-label">业务性质</label>

                        <div class="col-md-10">
                            <textarea class="form-control" rows="3"
                                      name="data[base_info][业务性质]">{$_data['base_info']['业务性质']}</textarea>
                        </div>
                    </div>
                </div>
                <div class="col-md-6">
                    <div class="form-group">
                        <label class="col-md-2 control-label">团队简介</label>

                        <div class="col-md-10">
                            <textarea class="form-control" rows="3"
                                      name="data[base_info][团队简介]">{$_data['base_info']['团队简介']}</textarea>
                        </div>
                    </div>
                </div>
                <div class="col-md-6">
                    <div class="form-group">
                        <label class="col-md-2 control-label">公司网站</label>

                        <div class="col-md-10">
                            <input class="form-control" type="text" name="data[base_info][公司网站]"
                                   value="{$_data['base_info']['公司网站']}">
                        </div>
                    </div>
                </div>
                <div class="col-md-12">
                    <div class="form-group">
                        <label class=" col-md-1 control-label">公司介绍</label>

                        <div class="col-md-11">
                            <textarea class="form-control" name="data[des]"
                                      rows="10">{$_data['des']}</textarea>
                        </div>
                    </div>
                </div>

            </div>
            <div class="row">
                <div class="col-md-6">
                    <div class="form-group">
                        <label class="col-md-2 control-label">公司LOGO</label>

                        <div class="col-md-10">
                            <div class="fileinput fileinput-new" data-provides="fileinput">
                                <div class="fileinput-new thumbnail" style="width: 200px; height: 150px;">
                                    {if $_data['logo']}
                                        <img src="{$_data['logo']}" alt=""/>
                                    {else}
                                        <img src="http://www.placehold.it/200x150/EFEFEF/AAAAAA&amp;text=no+image"
                                             alt=""/>
                                    {/if}
                                </div>
                                <div class="fileinput-preview fileinput-exists thumbnail"
                                     style="max-width: 200px; max-height: 150px;"></div>
                                <div>
                        <span class="btn btn-default btn-file">
                            <span class="fileinput-new">选择图片</span>
                            <span class="fileinput-exists">重新选择</span>
                            <input type="file" name="公司LOGO" accept="image/jpeg,image/png,image/gif">
                        </span>
                                    <a href="form_component.html#" class="btn btn-danger fileinput-exists"
                                       data-dismiss="fileinput">移除</a>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-md-6">
                    <div class="form-group">
                        <label class=" col-md-2 control-label">资质证书</label>

                        <div class="col-md-10">
                            <div class="fileinput fileinput-new" data-provides="fileinput">
                        <span class="btn btn-default btn-file">
                            <span class="fileinput-new">选择证书</span>
                            <span class="fileinput-exists">重新选择 </span>
                            <input type="file" accept="zip,rar,pdf" name="资质证书">
                        </span>
                                <span class="fileinput-filename"></span>&nbsp;
                                <a href="javascript:void(0)" class="close fileinput-exists"
                                   data-dismiss="fileinput"></a>
                                {if $_data['vendor_remarks']['资质证书']}
                                    <a href="{Core::$urls['hosts']}{$_data['vendor_remarks']['资质证书']}"
                                       target="_blank"><span class="fa fa-file"></span> 点此下载资质证书</a>
                                    <input type="hidden" name="data[vendor_remarks][资质证书]"
                                           value="{$_data['vendor_remarks']['资质证书']}">
                                {/if}
                                <br/><span style="font-size:12px; ">(请上传格式为.zip,.rar或.pdf的文件，大小不能超过2M)</span>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="col-md-12"><h5><strong>合作信息</strong></h5>
                    <hr/>
                </div>
                <div class="col-md-6">
                    <div class="form-group">
                        <label class=" col-md-2 control-label">签约状态</label>

                        <div class="col-md-10">
                            <label class="radio-inline">
                                <span><input type="radio" name="data[vendor_remarks][签约状态]" value="0"
                                             {if $_data['vendor_remarks']['签约状态']==0}checked{/if} ></span>
                                未签约</label>
                            <label class="radio-inline">
                                <span class="checked"><input type="radio" name="data[vendor_remarks][签约状态]" value="1"
                                                             {if $_data['vendor_remarks']['签约状态']==1}checked{/if}></span>
                                合作备忘录</label>
                            <label class="radio-inline">
                                <span><input type="radio" name="data[vendor_remarks][签约状态]" value="2"
                                             {if $_data['vendor_remarks']['签约状态']==2}checked{/if}></span>
                                已签约</label>
                        </div>
                    </div>
                </div>
                <div class="col-md-6">
                    <div class="form-group">
                        <label class=" col-md-2 control-label">签约附件</label>

                        <div class="col-md-10">
                            <div class="fileinput fileinput-new" data-provides="fileinput">
                        <span class="btn btn-default btn-file">
                            <span class="fileinput-new">选择附件</span>
                            <span class="fileinput-exists">重新选择</span>
                            <input type="file" accept="zip,rar,pdf" name="签约附件">
                        </span>
                                <span class="fileinput-filename"></span>&nbsp;
                                <a href="javascript:void(0)" class="close fileinput-exists"
                                   data-dismiss="fileinput"></a>
                                {if $_data['vendor_remarks']['签约附件']}
                                    <a href="{Core::$urls['hosts']}{$_data['vendor_remarks']['签约附件']}"
                                       target="_blank"><span class="fa fa-file"></span> 点此下载签约附件</a>
                                    <input type="hidden" name="data[vendor_remarks][签约附件]"
                                           value="{$_data['vendor_remarks']['签约附件']}">
                                {/if}
                                <br/><span style="font-size:12px; ">(请上传格式为.zip,.rar或.pdf的文件，大小不能超过2M)</span>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-md-6">
                    <div class="form-group">
                        <label class=" col-md-2 control-label">返佣规则</label>

                        <div class="col-md-10">
                            <textarea class="form-control" rows="3"
                                      name="data[vendor_remarks][返佣规则]">{$_data['vendor_remarks']['返佣规则']}</textarea>
                        </div>
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="col-md-12"><h5><strong>商户评级</strong></h5>
                </div>
                <div class="col-md-6">
                    <div class="form-group">
                        <label class=" col-md-2 control-label">综合评分</label>

                        <div class="col-md-10">
                            <div style="font-size: 14px; padding-top: 10px;">
                                5
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-md-6">
                    <div class="form-group">
                        <label class=" col-md-2 control-label">成交量</label>

                        <div class="col-md-10">
                            <div style="font-size: 14px; padding-top: 10px;">
                                {$complete_order|default:'0'}
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-md-6">
                    <div class="form-group">
                        <label class=" col-md-2 control-label">客户评分</label>

                        <div class="col-md-10">
                            <div style="font-size: 14px; padding-top: 10px;">
                                5
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-md-6">
                    <div class="form-group">
                        <label class=" col-md-2 control-label">取消量</label>

                        <div class="col-md-10">
                            <div style="font-size: 14px; padding-top: 10px;">
                                {$total_order-$complete_order}
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-md-6">
                    <div class="form-group">
                        <label class="col-md-2 control-label">执行评分</label>

                        <div class="col-md-10">
                            <label class="radio-inline">
                                <span><input type="radio" name="data[vendor_remarks][内部评分]" value="1"
                                             {if $_data['vendor_remarks']['内部评分']==1}checked{/if} ></span>
                                1分</label>
                            <label class="radio-inline">
                                <span class="checked"><input type="radio" name="data[vendor_remarks][内部评分]" value="2"
                                                             {if $_data['vendor_remarks']['内部评分']==2}checked{/if}></span>
                                2分</label>
                            <label class="radio-inline">
                                <span><input type="radio" name="data[vendor_remarks][内部评分]" value="3"
                                             {if $_data['vendor_remarks']['内部评分']==3}checked{/if}></span>
                                3分</label>
                            <label class="radio-inline">
                                <span><input type="radio" name="data[vendor_remarks][内部评分]" value="4"
                                             {if $_data['vendor_remarks']['内部评分']==4}checked{/if}></span>
                                4分</label>
                            <label class="radio-inline">
                                <span><input type="radio" name="data[vendor_remarks][内部评分]" value="5"
                                             {if $_data['vendor_remarks']['内部评分']==5}checked{/if}></span>
                                5分</label>
                        </div>
                    </div>
                </div>
                <div class="col-md-6">
                    <div class="form-group">
                        <label class=" col-md-2 control-label">成交率</label>

                        <div class="col-md-10">
                            <div style="font-size: 14px; padding-top: 10px;">
                                {sprintf("%.2f", ($complete_order/$total_order)*100)}
                                %
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="col-md-12"><h5><strong>商户备注</strong></h5>
                </div>
                <div class="col-md-6">
                    <div class="form-group">
                        <label class=" col-md-2 control-label">备注内容</label>

                        <div class="col-md-10">
                            <textarea class="form-control" rows="3"
                                      name="data[vendor_remarks][备注内容]">{$_data['vendor_remarks']['备注内容']}</textarea>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="form-actions text-center">
            <button type="reset" class="btn btn-default">
                重置
            </button>
            <button type="submit" class="btn btn-success">
                提交
            </button>
        </div>
    </form>
</div>
<link rel="stylesheet" type="text/css" href="{$_assets}plugins/jquery-multi-select/css/multi-select.css"/>
<script type="text/javascript" src="{$_assets}plugins/jquery-multi-select/js/jquery.multi-select.js"></script>
<link rel="stylesheet" type="text/css" href="{$_assets}plugins/bootstrap-fileinput/bootstrap-fileinput.css"/>
<script type="text/javascript" src="{$_assets}plugins/bootstrap-fileinput/bootstrap-fileinput.js"></script>
<link rel="stylesheet" type="text/css" href="{$_assets}plugins/bootstrap-wysihtml5/bootstrap-wysihtml5.css"/>
<script type="text/javascript" src="{$_assets}plugins/bootstrap-wysihtml5/wysihtml5-0.3.0.js"></script>
<script type="text/javascript" src="{$_assets}plugins/bootstrap-wysihtml5/bootstrap-wysihtml5.js"></script>
<script>
    jQuery(document).ready(function () {
        $(".tags_select2").each(function () {
            $(this).select2({
                tags: $(this).data('values').split(',')
            })
        });
        $('#my_multi_select2').multiSelect({
            selectableOptgroup: true
        });
        $('.wysihtml5').wysihtml5();
    })
</script>