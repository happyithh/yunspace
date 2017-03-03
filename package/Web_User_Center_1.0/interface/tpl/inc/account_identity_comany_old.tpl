<form action="?" class="form-horizontal" method="post" enctype="multipart/form-data">
    <input type="hidden" name="identity_submit" value="1">
    <input type="hidden" name="identity_type" value="2">
    <input type="hidden" name="url_back" value="{$_REQUEST['url_back']}">

    <div class="form-body">
        <h3 class="form-section">公司信息
            {if $__user['attr']['identity']}
                <small>(变更认证)</small>
            {/if}
        </h3>
        <div class="form-group">
            <label class="col-md-3 control-label">公司名称</label>

            <div class="col-md-4">
                <input type="text" class="form-control" placeholder="公司名称" name="data[公司名称]" value="{$_data['data']['公司名称']}">
            </div>
        </div>
        <div class="form-group">
            <label class="col-md-3 control-label">地址</label>

            <div class="col-md-4">
                <input type="text" class="form-control" placeholder="地址" name="data[地址]" value="{$_data['data']['地址']}">
            </div>
        </div>
        <div class="form-group">
            <label class="col-md-3 control-label">电话</label>

            <div class="col-md-4">
                <input type="text" class="form-control" placeholder="电话" name="data[电话]" value="{$_data['data']['电话']}">
            </div>
        </div>
        <div class="form-group">
            <label class="col-md-3 control-label">传真</label>

            <div class="col-md-4">
                <input type="text" class="form-control" placeholder="传真" name="data[传真]" value="{$_data['data']['传真']}">
            </div>
        </div>
        <div class="form-group">
            <label class="col-md-3 control-label">法人代表</label>

            <div class="col-md-4">
                <input type="text" class="form-control" placeholder="法人代表" name="data[法人代表]" value="{$_data['data']['法人代表']}">
            </div>
        </div>
        <div class="form-group">
            <label class="col-md-3 control-label">法人代表身份证号码</label>

            <div class="col-md-4">
                <input type="text" class="form-control" placeholder="法人代表身份证号码" name="data[法人代表身份证号码]" value="{$_data['data']['法人代表身份证号码']}">
            </div>
        </div>
        <div class="form-group">
            <label class="col-md-3 control-label">主要联系人</label>

            <div class="col-md-4">
                <input type="text" class="form-control" placeholder="主要联系人" name="data[主要联系人]" value="{$_data['data']['主要联系人']}">
            </div>
        </div>
        <div class="form-group">
            <label class="col-md-3 control-label">主要联系人手机号码</label>

            <div class="col-md-4">
                <input type="text" class="form-control" placeholder="主要联系人手机号码" name="data[主要联系人手机号码]" value="{$_data['data']['主要联系人手机号码']}">
            </div>
        </div>
        <div class="form-group">
            <label class="col-md-3 control-label">主要联系人邮箱</label>

            <div class="col-md-4">
                <input type="text" class="form-control" placeholder="主要联系人邮箱" name="data[主要联系人邮箱]" value="{$_data['data']['主要联系人邮箱']}">
            </div>
        </div>
        <h3 class="form-section">相关证件
            <small>(上传单个文件的大小不能超过2MB)</small>
        </h3>

        <link rel="stylesheet" type="text/css" href="plugins/bootstrap-fileinput/bootstrap-fileinput.css"/>
        <script type="text/javascript" src="plugins/bootstrap-fileinput/bootstrap-fileinput.js"></script>
        <div class="form-group">
            <label class="col-md-3 control-label">经营许可证</label>

            <div class="col-md-4">
                <div class="fileinput fileinput-new" data-provides="fileinput">
                    <span class="btn btn-default btn-file">
                    <span class="fileinput-new">
                    Select file </span>
                    <span class="fileinput-exists">
                    Change </span>
                    <input type="file" accept="image/jpeg,image/png,image/gif" name="经营许可证">
                    </span>
                    <span class="fileinput-filename">
                    </span>
                    &nbsp;
                    <a href="javascript:void(0)" class="close fileinput-exists" data-dismiss="fileinput">
                    </a>
                </div>
            </div>
        </div>
        <div class="form-group">
            <label class="col-md-3 control-label">营业执照</label>

            <div class="col-md-4">
                <div class="fileinput fileinput-new" data-provides="fileinput">
                    <span class="btn btn-default btn-file">
                    <span class="fileinput-new">
                    Select file </span>
                    <span class="fileinput-exists">
                    Change </span>
                    <input type="file" accept="image/jpeg,image/png,image/gif" name="营业执照">
                    </span>
                    <span class="fileinput-filename">
                    </span>
                    &nbsp;
                    <a href="javascript:void(0)" class="close fileinput-exists" data-dismiss="fileinput">
                    </a>
                </div>
            </div>
        </div>
        <div class="form-group">
            <label class="col-md-3 control-label">组织机构代码</label>

            <div class="col-md-4">
                <div class="fileinput fileinput-new" data-provides="fileinput">
                    <span class="btn btn-default btn-file">
                    <span class="fileinput-new">
                    Select file </span>
                    <span class="fileinput-exists">
                    Change </span>
                    <input type="file" accept="image/jpeg,image/png,image/gif" name="组织机构代码">
                    </span>
                    <span class="fileinput-filename">
                    </span>
                    &nbsp;
                    <a href="javascript:void(0)" class="close fileinput-exists" data-dismiss="fileinput">
                    </a>
                </div>
            </div>
        </div>
        <div class="form-group">
            <label class="col-md-3 control-label">税务登记证</label>

            <div class="col-md-4">
                <div class="fileinput fileinput-new" data-provides="fileinput">
                    <span class="btn btn-default btn-file">
                    <span class="fileinput-new">
                    Select file </span>
                    <span class="fileinput-exists">
                    Change </span>
                    <input type="file" accept="image/jpeg,image/png,image/gif" name="税务登记证">
                    </span>
                    <span class="fileinput-filename">
                    </span>
                    &nbsp;
                    <a href="javascript:void(0)" class="close fileinput-exists" data-dismiss="fileinput">
                    </a>
                </div>
            </div>
        </div>
        <div class="form-group last">
            <label class="col-md-3 control-label">生产安全许可证</label>

            <div class="col-md-4">
                <div class="fileinput fileinput-new" data-provides="fileinput">
                    <span class="btn btn-default btn-file">
                    <span class="fileinput-new">
                    Select file </span>
                    <span class="fileinput-exists">
                    Change </span>
                    <input type="file" accept="image/jpeg,image/png,image/gif" name="生产安全许可证">
                    </span>
                    <span class="fileinput-filename">
                    </span>
                    &nbsp;
                    <a href="javascript:void(0)" class="close fileinput-exists" data-dismiss="fileinput">
                    </a>
                </div>
            </div>
        </div>
    </div>
    <div class="form-actions">
        <div class="row">
            <div class="col-md-offset-3 col-md-9">
                <button type="submit" class="btn btn-info">
                    提交
                </button>
                <button type="reset" class="btn btn-default">
                    重置
                </button>
            </div>
        </div>
    </div>
</form>