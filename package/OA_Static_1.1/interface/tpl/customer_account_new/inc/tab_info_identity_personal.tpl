<form class="form-horizontal" role="form" action="?" method="post" enctype="multipart/form-data">
    <input type="hidden" name="identity_submit" value="1">
    <input type="hidden" name="identity_type" value="{$_REQUEST['identity_type']}">
    <input type="hidden" name="tab" value="info">
    <input type="hidden" name="vendor_id" value="{$vendorInfo['id']}">
    <input type="hidden" name="action" value="{$_REQUEST['action']}">

    <div class="">
        <h3 class="form-section">个人信息
            {if $_identity}
                <small>(变更认证)</small>
            {/if}
            <a href="?action=detail&tab=info&vendor_id={$vendorInfo['id']}&identity_type=2" class="btn btn-info btn-sm">
                切换到企业认证
            </a>
        </h3>
        <div class="col-md-6">
            <div class="form-group">
                <label class=" col-md-4 control-label">姓名</label>

                <div class="col-md-8">
                    <input class="form-control" type="text" name="data[真实姓名]" value="{$_identity['data']['真实姓名']}">
                </div>
            </div>
        </div>
        <div class="col-md-6">
            <div class="form-group">
                <label class=" col-md-4 control-label">性别</label>

                <div class="col-md-8">
                    <input class="form-control" type="text" name="data[性别]" value="{$_identity['data']['性别']}">
                </div>
            </div>
        </div>
        <div class="col-md-6">
            <div class="form-group">
                <label class=" col-md-4 control-label">年龄</label>

                <div class="col-md-8">
                    <input class="form-control" type="text" name="data[年龄]" value="{$_identity['data']['年龄']}">
                </div>
            </div>
        </div>
        <div class="col-md-6">
            <div class="form-group">
                <label class=" col-md-4 control-label">城市</label>

                <div class="col-md-8">
                    <input class="form-control" type="text" name="data[城市]" value="{$_identity['data']['城市']}">
                </div>
            </div>
        </div>
        <div class="col-md-6">
            <div class="form-group">
                <label class=" col-md-4 control-label">身份证号码</label>

                <div class="col-md-8">
                    <input class="form-control" type="text" name="data[身份证号码]" value="{$_identity['data']['身份证号码']}">
                </div>
            </div>
        </div>
        <div class="col-md-6">
            <div class="form-group">
                <label class=" col-md-4 control-label">护照号码</label>

                <div class="col-md-8">
                    <input class="form-control" type="text" name="data[护照号码]" value="{$_identity['data']['护照号码']}">
                </div>
            </div>
        </div>
        <div class="col-md-6">
            <div class="form-group">
                <label class=" col-md-4 control-label">籍贯</label>

                <div class="col-md-8">
                    <input class="form-control" type="text" name="data[籍贯]" value="{$_identity['data']['籍贯']}">
                </div>
            </div>
        </div>
        <div class="col-md-6">
            <div class="form-group">
                <label class=" col-md-4 control-label">学历</label>

                <div class="col-md-8">
                    <input class="form-control" type="text" name="data[学历]" value="{$_identity['data']['学历']}">
                </div>
            </div>
        </div>
        <div class="col-md-6">
            <div class="form-group">
                <label class=" col-md-4 control-label">住址</label>

                <div class="col-md-8">
                    <input class="form-control" type="text" name="data[住址]" value="{$_identity['data']['住址']}">
                </div>
            </div>
        </div>
    </div>
    <div class="">
        <div class="col-md-12"><h5>
                <strong>相关资料</strong></h5></div>
        <div class="col-md-6">
            <div class="form-group">
                <label class=" col-md-4 control-label">手持身份证照</label>

                <div class="col-md-8">
                    <div class="fileinput fileinput-new" data-provides="fileinput">
                        <div class="fileinput-new thumbnail" style="width: 200px; height: 150px;">
                            {if $_identity['files']['手持身份证照']}
                                <img src="{$_identity['files']['手持身份证照']}" alt=""/>
                            {else}
                                <img src="http://www.placehold.it/200x150/EFEFEF/AAAAAA&amp;text=no+image" alt=""/>
                            {/if}
                        </div>
                        <div class="fileinput-preview fileinput-exists thumbnail" style="max-width: 200px; max-height: 150px;"></div>
                        <div>
                            <span class="btn btn-default btn-file">
                                <span class="fileinput-new">选择图片</span>
                                <span class="fileinput-exists">重新选择</span>
                                <input type="file" name="手持身份证照" accept="image/jpeg,image/png,image/gif">
                                <input type="hidden" name="files[手持身份证照]" value="{$_identity['files']['手持身份证照']}">
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
                <label class=" col-md-4 control-label">手持其他有效证件<br/><font size="2">(如护照，驾驶证等)</font></label>

                <div class="col-md-8">
                    <div class="fileinput fileinput-new" data-provides="fileinput">
                        <div class="fileinput-new thumbnail" style="width: 200px; height: 150px;">
                            {if $_identity['files']['其他有效证件']}
                                <img src="{$_identity['files']['其他有效证件']}" alt=""/>
                            {else}
                                <img src="http://www.placehold.it/200x150/EFEFEF/AAAAAA&amp;text=no+image" alt=""/>
                            {/if}
                        </div>
                        <div class="fileinput-preview fileinput-exists thumbnail" style="max-width: 200px; max-height: 150px;"></div>
                        <div>
                            <span class="btn btn-default btn-file">
                                <span class="fileinput-new">选择图片</span>
                                <span class="fileinput-exists">重新选择</span>
                                <input type="file" name="其他有效证件" accept="image/jpeg,image/png,image/gif">
                                <input type="hidden" name="files[其他有效证件]" value="{$_identity['files']['其他有效证件']}">
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
    <div class="form-actions text-center ">
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