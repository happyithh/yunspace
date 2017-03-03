<form class="form-horizontal" role="form" action="?" method="post" enctype="multipart/form-data">
<input type="hidden" name="identity_submit" value="1">
<input type="hidden" name="identity_type" value="{$_REQUEST['identity_type']}">
<input type="hidden" name="tab" value="info">
<input type="hidden" name="vendor_id" value="{$vendorInfo['id']}">
<input type="hidden" name="action" value="{$_REQUEST['action']}">

<div class="">
<h3 class="form-section">公司信息
    {if $_identity}
        <small>(变更认证)</small>
    {/if}
    <a href="?action=detail&tab=info&vendor_id={$vendorInfo['id']}&identity_type=1" class="btn btn-info btn-sm">
        切换到个人认证
    </a>
</h3>
<div class="col-md-6">
    <div class="form-group">
        <label class=" col-md-4 control-label">公司名称</label>

        <div class="col-md-8">
            <input class="form-control" type="text" name="data[公司名称]" value="{$_identity['data']['公司名称']}">
        </div>
    </div>
</div>
<div class="col-md-6">
    <div class="form-group">
        <label class=" col-md-4 control-label">公司电话</label>

        <div class="col-md-8">
            <input class="form-control" type="text" name="data[公司电话]" value="{$_identity['data']['公司电话']}">
        </div>
    </div>
</div>
<div class="col-md-6">
    <div class="form-group">
        <label class=" col-md-4 control-label">公司地址</label>

        <div class="col-md-8">
            <input class="form-control" type="text" name="data[公司地址]" value="{$_identity['data']['公司地址']}">
        </div>
    </div>
</div>
<div class="col-md-6">
    <div class="form-group">
        <label class=" col-md-4 control-label">公司网址</label>

        <div class="col-md-8">
            <input class="form-control" type="text" name="data[公司网址]" value="{$_identity['data']['公司网址']}">
        </div>
    </div>
</div>
<div class="col-md-6">
    <div class="form-group">
        <label class=" col-md-4 control-label">注册地址</label>

        <div class="col-md-8">
            <input class="form-control" type="text" name="data[注册地址]" value="{$_identity['data']['注册地址']}">
        </div>
    </div>
</div>
<div class="col-md-6">
    <div class="form-group">
        <label class=" col-md-4 control-label">注册资本</label>

        <div class="col-md-8">
            <input class="form-control" type="text" name="data[注册资本]" value="{$_identity['data']['注册资本']}">
        </div>
    </div>
</div>
<div class="col-md-6">
    <div class="form-group">
        <label class=" col-md-4 control-label">营业执照号</label>

        <div class="col-md-8">
            <input class="form-control" type="text" name="data[营业执照号]" value="{$_identity['data']['营业执照号']}">
        </div>
    </div>
</div>
<div class="col-md-6">
    <div class="form-group">
        <label class=" col-md-4 control-label">税务登记号</label>

        <div class="col-md-8">
            <input class="form-control" type="text" name="data[税务登记号]" value="{$_identity['data']['税务登记号']}">
        </div>
    </div>
</div>
<div class="col-md-6">
    <div class="form-group">
        <label class=" col-md-4 control-label">固定电话</label>

        <div class="col-md-8">
            <input class="form-control" type="text" name="data[固定电话]" value="{$_identity['data']['固定电话']}">
        </div>
    </div>
</div>
<div class="col-md-6">
    <div class="form-group">
        <label class=" col-md-4 control-label">传真号码</label>

        <div class="col-md-8">
            <input class="form-control" type="text" name="data[传真号码]" value="{$_identity['data']['传真号码']}">
        </div>
    </div>
</div>
<div class="col-md-6">
    <div class="form-group">
        <label class=" col-md-4 control-label">法人代表</label>

        <div class="col-md-8">
            <input class="form-control" type="text" name="data[法人代表]" value="{$_identity['data']['法人代表']}">
        </div>
    </div>
</div>
<div class="col-md-6">
    <div class="form-group">
        <label class=" col-md-4 control-label">法人证件</label>

        <div class="col-md-8">
            <input class="form-control" type="text" name="data[法人证件]" value="{$_identity['data']['法人证件']}">
        </div>
    </div>
</div>
<div class="col-md-6">
    <div class="form-group">
        <label class=" col-md-4 control-label">员工规模</label>

        <div class="col-md-8">
            <input class="form-control" type="text" name="data[员工规模]" value="{$_identity['data']['员工规模']}">
        </div>
    </div>
</div>
<div class="col-md-6">
    <div class="form-group">
        <label class=" col-md-4 control-label">法人证件号</label>

        <div class="col-md-8">
            <input class="form-control" type="text" name="data[法人证件号]" value="{$_identity['data']['法人证件号']}">
        </div>
    </div>
</div>
<div class="col-md-6">
    <div class="form-group">
        <label class=" col-md-4 control-label">主要联系人</label>

        <div class="col-md-8">
            <input class="form-control" type="text" name="data[主要联系人]" value="{$_identity['data']['主要联系人']}">
        </div>
    </div>
</div>
<div class="col-md-6">
    <div class="form-group">
        <label class=" col-md-4 control-label">联系人身份证号</label>

        <div class="col-md-8">
            <input class="form-control" type="text" name="data[联系人身份证号]" value="{$_identity['data']['联系人身份证号']}">
        </div>
    </div>
</div>
<div class="col-md-6">
    <div class="form-group">
        <label class=" col-md-4 control-label">联系人电话</label>

        <div class="col-md-8">
            <input class="form-control" type="text" name="data[联系人电话]" value="{$_identity['data']['联系人电话']}">
        </div>
    </div>
</div>
<div class="col-md-6">
    <div class="form-group">
        <label class=" col-md-4 control-label">联系人电子邮箱</label>

        <div class="col-md-8">
            <input class="form-control" type="text" name="data[联系人电子邮箱]" value="{$_identity['data']['联系人电子邮箱']}">
        </div>
    </div>
</div>
<div class="col-md-6">
    <div class="form-group">
        <label class=" col-md-4 control-label">合作方信息询问表</label>

        <div class="col-md-8">
            <div class="fileinput fileinput-new" data-provides="fileinput">
                <div class="fileinput-new thumbnail" style="width: 200px; height: 150px;">
                    {if $_identity['files']['合作方信息询问表']}
                        <img src="{$_identity['files']['合作方信息询问表']}" alt=""/>
                    {else}
                        <img src="http://www.placehold.it/200x150/EFEFEF/AAAAAA&amp;text=no+image" alt=""/>
                    {/if}
                </div>
                <div class="fileinput-preview fileinput-exists thumbnail" style="max-width: 200px; max-height: 150px;"></div>
                <div>
                            <span class="btn btn-default btn-file">
                                <span class="fileinput-new">选择图片</span>
                                <span class="fileinput-exists">重新选择</span>
                                <input type="file" name="合作方信息询问表" accept="image/jpeg,image/png,image/gif">
                                <input type="hidden" name="files[合作方信息询问表]" value="{$_identity['files']['合作方信息询问表']}">
                            </span>
                    <a href="form_component.html#" class="btn btn-danger fileinput-exists" data-dismiss="fileinput">移除</a>
                    <span style="font-size: 12px;">(*单个文件的大小不超过2M)</span>
                </div>
            </div>
        </div>
    </div>
</div>
<div class="col-md-6">
    <div class="form-group">
        <label class=" col-md-4 control-label">营业执照</label>

        <div class="col-md-8">
            <div class="fileinput fileinput-new" data-provides="fileinput">
                <div class="fileinput-new thumbnail" style="width: 200px; height: 150px;">
                    {if $_identity['files']['营业执照']}
                        <img src="{$_identity['files']['营业执照']}" alt=""/>
                    {else}
                        <img src="http://www.placehold.it/200x150/EFEFEF/AAAAAA&amp;text=no+image" alt=""/>
                    {/if}
                </div>
                <div class="fileinput-preview fileinput-exists thumbnail" style="max-width: 200px; max-height: 150px;"></div>
                <div>
                        <span class="btn btn-default btn-file">
                            <span class="fileinput-new">选择图片</span>
                            <span class="fileinput-exists">重新选择</span>
                            <input type="file" name="营业执照" accept="image/jpeg,image/png,image/gif">
                            <input type="hidden" name="files[营业执照]" value="{$_identity['files']['营业执照']}">
                        </span>
                    <a href="form_component.html#" class="btn btn-danger fileinput-exists" data-dismiss="fileinput">移除</a>
                    <span style="font-size: 12px;">(*单个文件的大小不超过2M)</span>
                </div>
            </div>
        </div>
    </div>
</div>
<div class="col-md-6">
    <div class="form-group">
        <label class=" col-md-4 control-label">税务登记证</label>

        <div class="col-md-8">
            <div class="fileinput fileinput-new" data-provides="fileinput">
                <div class="fileinput-new thumbnail" style="width: 200px; height: 150px;">
                    {if $_identity['files']['税务登记证']}
                        <img src="{$_identity['files']['税务登记证']}" alt=""/>
                    {else}
                        <img src="http://www.placehold.it/200x150/EFEFEF/AAAAAA&amp;text=no+image" alt=""/>
                    {/if}
                </div>
                <div class="fileinput-preview fileinput-exists thumbnail" style="max-width: 200px; max-height: 150px;"></div>
                <div>
                        <span class="btn btn-default btn-file">
                            <span class="fileinput-new">选择图片</span>
                            <span class="fileinput-exists">重新选择</span>
                            <input type="file" name="税务登记证" accept="image/jpeg,image/png,image/gif">
                            <input type="hidden" name="files[税务登记证]" value="{$_identity['files']['税务登记证']}">
                        </span>
                    <a href="form_component.html#" class="btn btn-danger fileinput-exists" data-dismiss="fileinput">移除</a>
                    <span style="font-size: 12px;">(*单个文件的大小不超过2M)</span>
                </div>
            </div>
        </div>
    </div>
</div>
<div class="col-md-6">
    <div class="form-group">
        <label class=" col-md-4 control-label">银行开户许可证</label>

        <div class="col-md-8">
            <div class="fileinput fileinput-new" data-provides="fileinput">
                <div class="fileinput-new thumbnail" style="width: 200px; height: 150px;">
                    {if $_identity['files']['银行开户许可证']}
                        <img src="{$_identity['files']['银行开户许可证']}" alt=""/>
                    {else}
                        <img src="http://www.placehold.it/200x150/EFEFEF/AAAAAA&amp;text=no+image" alt=""/>
                    {/if}
                </div>
                <div class="fileinput-preview fileinput-exists thumbnail" style="max-width: 200px; max-height: 150px;"></div>
                <div>
                        <span class="btn btn-default btn-file">
                            <span class="fileinput-new">选择图片</span>
                            <span class="fileinput-exists">重新选择</span>
                            <input type="file" name="银行开户许可证" accept="image/jpeg,image/png,image/gif">
                            <input type="hidden" name="files[银行开户许可证]" value="{$_identity['files']['银行开户许可证']}">
                        </span>
                    <a href="form_component.html#" class="btn btn-danger fileinput-exists" data-dismiss="fileinput">移除</a>
                    <span style="font-size: 12px;">(*单个文件的大小不超过2M)</span>
                </div>
            </div>
        </div>
    </div>
</div>
<div class="clearfix"></div>
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
<link rel="stylesheet" type="text/css" href="{$_assets}plugins/bootstrap-fileinput/bootstrap-fileinput.css"/>
<script type="text/javascript" src="{$_assets}plugins/bootstrap-fileinput/bootstrap-fileinput.js"></script>