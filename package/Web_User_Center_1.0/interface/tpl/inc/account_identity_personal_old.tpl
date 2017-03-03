<form action="?" class="form-horizontal" method="post" enctype="multipart/form-data">
    <input type="hidden" name="identity_submit" value="1">
    <input type="hidden" name="identity_type" value="1">
    <input type="hidden" name="url_back" value="{$_REQUEST['url_back']}">

    <div class="form-body">
        <h3 class="form-section">个人信息
            {if $__user['attr']['identity']}
                <small>(变更认证)</small>
            {/if}
        </h3>

        <div class="form-group">
            <label class="col-md-3 control-label">真实姓名</label>

            <div class="col-md-4">
                <input type="text" class="form-control" placeholder="真实姓名" name="data[真实姓名]" value="{$_data['data']['真实姓名']}">
                {*<span class="help-block">*}
                {*A block of help text. </span>*}
            </div>
        </div>
        <div class="form-group">
            <label class="col-md-3 control-label">身份证号码</label>

            <div class="col-md-4">
                <input type="text" class="form-control" placeholder="身份证号码" name="data[身份证号码]" value="{$_data['data']['身份证号码']}">
            </div>
        </div>
        <h3 class="form-section">相关证件
            <small>(上传单个文件的大小不能超过2MB)</small>
        </h3>

        <link rel="stylesheet" type="text/css" href="plugins/bootstrap-fileinput/bootstrap-fileinput.css"/>
        <script type="text/javascript" src="plugins/bootstrap-fileinput/bootstrap-fileinput.js"></script>
        <div class="form-group">
            <label class="col-md-3 control-label">手持身份证照</label>

            <div class="col-md-4">
                <div class="fileinput fileinput-new" data-provides="fileinput">
                    <span class="btn btn-default btn-file">
                    <span class="fileinput-new">
                    Select file </span>
                    <span class="fileinput-exists">
                    Change </span>
                    <input type="file" accept="image/jpeg,image/png,image/gif" name="手持身份证照">
                    </span>
                    <span class="fileinput-filename">
                    </span>
                    &nbsp;
                    <a href="form_component.html#" class="close fileinput-exists" data-dismiss="fileinput">
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