<form class="form-horizontal" role="form" action="{$_route}account_bind" method="post" enctype="multipart/form-data">
    <input type="hidden" name="tab" value="info">
    <input type="hidden" name="action" value="change_vendor_submit">
    <input type="hidden" name="vendor_id" value="{$_REQUEST['vendor_id']}">

    <div class="">
        <h3 class="form-section">
            {if $_REQUEST['vendor_id']}
                变更供应商信息
            {else}
                添加供应商信息
            {/if}
        </h3>
        <div class="row">
        <div class="col-md-6">
            <div class="form-group">
                <label class=" col-md-3 control-label">供应商名称</label>

                <div class="col-md-9">
                    <input name="data[vendor_name]" class="form-control" placeholder="请输入供应商名称" type="text" value="{$change['vendor_name']}">
                </div>
            </div>
        </div>
        <div class="col-md-6">
            <div class="form-group">
                <label class=" col-md-3 control-label">品牌名称</label>

                <div class="col-md-9">
                    <input name="data[base_info][品牌名称]" class="form-control" placeholder="请输入品牌名称" type="text" value="{$change['base_info']['品牌名称']}">
                </div>
            </div>
        </div>
        {foreach $_vendor_attr as $k=>$v}
            {if $k=='资质认证'}
                <input type="hidden" class="form-control" name="data[attr][{$k}]" value="{$change['attr'][$k]}">
            {else}
                <div class="col-md-6">
                    <div class="form-group">
                        <label class="col-md-3 control-label">{$k}</label>

                        <div class="col-md-9">
                            {if $v}
                                <input type="text" class="form-control tags_select2" name="data[attr][{$k}]" value="{$change['attr'][$k]}" data-values="{implode(',',$v)}">
                            {else}
                                <input type="text" class="form-control" name="data[attr][{$k}]" value="{$change['attr'][$k]}">
                            {/if}
                        </div>
                    </div>
                </div>
            {/if}
        {/foreach}
        <div class="col-md-6">
            <div class="form-group">
                <label class="col-md-3 control-label">业务性质</label>

                <div class="col-md-9">
                    <textarea class="form-control" rows="3" name="data[base_info][业务性质]">{$change['base_info']['业务性质']}</textarea>
                </div>
            </div>
        </div>
        <div class="col-md-6">
            <div class="form-group">
                <label class="col-md-3 control-label">业务范围</label>

                <div class="col-md-9">
                    <textarea class="form-control" rows="3" name="data[base_info][业务范围]">{$change['base_info']['业务范围']}</textarea>
                </div>
            </div>
        </div>
        <div class="col-md-6">
            <div class="form-group">
                <label class="col-md-3 control-label">团队简介</label>

                <div class="col-md-9">
                    <textarea class="form-control" rows="3" name="data[base_info][团队简介]">{$change['base_info']['团队简介']}</textarea>
                </div>
            </div>
        </div>
        </div>
        <div class="row">
        <div class="col-md-6">
            <div class="form-group">
                <label class="col-md-3 control-label">公司LOGO</label>

                <div class="col-md-9">
                    <div class="fileinput fileinput-new" data-provides="fileinput">
                        <div class="fileinput-new thumbnail" style="width: 200px; height: 150px;">
                            {if $_data['logo']}
                                <img src="{$change['logo']}" alt=""/>
                            {else}
                                <img src="http://www.placehold.it/200x150/EFEFEF/AAAAAA&amp;text=no+image" alt=""/>
                            {/if}
                        </div>
                        <div class="fileinput-preview fileinput-exists thumbnail" style="max-width: 200px; max-height: 150px;"></div>
                        <div>
                            <span class="btn btn-default btn-file">
                                <span class="fileinput-new">选择图片</span>
                                <span class="fileinput-exists">重新选择</span>
                                <input type="file" name="公司LOGO" accept="image/jpeg,image/png,image/gif">
                            </span>
                            <a href="form_component.html#" class="btn btn-danger fileinput-exists" data-dismiss="fileinput">移除</a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="col-md-6">
            <div class="form-group">
                <label class="col-md-3 control-label">供应商介绍</label>

                <div class="col-md-9">
                    <textarea name="data[des]" class="form-control" rows="5">{$change['des']}</textarea>
                </div>
            </div>
        </div>
        </div>
        <div class="clearfix"></div>
    </div>
    <div class="form-actions text-center ">
        <button type="reset" class="btn btn-default">
            重置
        </button>
        <button type="submit" class="btn btn-success">
            提交
        </button>
    </div>
</form>

<script>
    jQuery(document).ready(function () {
        $('.tags').tagsInput({
            width: 'auto'
        });
        $(".tags_select2").each(function () {
            $(this).select2({
                tags: $(this).data('values').split(',')
            })
        });
        $('.wysihtml5').wysihtml5();
    });
</script>