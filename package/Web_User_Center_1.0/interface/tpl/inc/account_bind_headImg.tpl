<style>
    .error {
        color: #ff0000;
    }
    .success {
        color: #008000;
    }
</style>
<link rel="stylesheet" type="text/css" href="plugins/bootstrap-fileinput/bootstrap-fileinput.css"/>
<script type="text/javascript" src="plugins/bootstrap-fileinput/bootstrap-fileinput.js"></script>
<form action="{$_route}account_bind?action=updateHeadImg" class="form-horizontal" method="post" enctype="multipart/form-data" id="form_p">
    <input type="hidden" name="url_back" value="{$_REQUEST['url_back']}">
    <div class="form-body" id="form_p">
        <h3 class="form-section">更换头像</h3>
        <div class="form-group">
            <label class="col-md-3 control-label">更换头像</label>
            <div class="col-md-4">
                <div class="fileinput fileinput-new" data-provides="fileinput">
                    <span class="btn btn-default btn-file">
                    <span class="fileinput-new">
                    选择头像 </span>
                    <span class="fileinput-exists">
                    修改头像 </span>
                    <input type="file" accept="image/jpeg,image/png,image/gif" name="avatar">
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
                <a href="javascript:window.history.go(-1)" class="btn btn-default">
                    返回
                </a>
            </div>
        </div>
    </div>
</form>
<script>

</script>