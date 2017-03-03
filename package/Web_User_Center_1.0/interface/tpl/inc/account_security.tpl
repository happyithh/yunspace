<form action="" class="form-horizontal" method="post" enctype="multipart/form-data">
    <input type="hidden" name="security_submit" value="1">
    <input type="hidden" name="url_back" value="{$_REQUEST['url_back']}">

    <div class="form-body">

        <h3 class="form-section">修改密码</h3>

        <div class="form-group">
            <label class="col-md-3 control-label">旧密码</label>

            <div class="col-md-4">
                <input type="password" class="form-control" placeholder="旧密码" name="data[旧密码]">
            </div>
        </div>
        <div class="form-group">
            <label class="col-md-3 control-label">新密码</label>

            <div class="col-md-4">
                <input type="password" class="form-control" placeholder="新密码" name="data[新密码]">
            </div>
        </div>
        <div class="form-group">
            <label class="col-md-3 control-label">确认新密码</label>

            <div class="col-md-4">
                <input type="password" class="form-control" placeholder="确认新密码" name="data[确认新密码]">
            </div>
        </div>
        <h3 class="form-section">
            {if $__user['password2']}
                修改交易密码
            {else}
                设置交易密码
            {/if}
        </h3>
        {if $__user['password2']}
            <div class="form-group">
                <label class="col-md-3 control-label">旧交易密码</label>

                <div class="col-md-4">
                    <input type="password" class="form-control" placeholder="旧交易密码" name="data[旧交易密码]">
                </div>
            </div>
        {/if}

        <div class="form-group">
            <label class="col-md-3 control-label">交易密码</label>

            <div class="col-md-4">
                <input type="password" class="form-control" placeholder="交易密码" name="data[交易密码]">
            </div>
        </div>
        <div class="form-group">
            <label class="col-md-3 control-label">确认交易密码</label>

            <div class="col-md-4">
                <input type="password" class="form-control" placeholder="确认交易密码" name="data[确认交易密码]">
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