<div class="portlet-body form">
    <form class="form-horizontal col-md-6" action="?" method="post" role="form">
        <input type="hidden" name="id" value="{$data['id']}"/>
        <input type="hidden" name="action" value="bind_account_submit"/>
        <input type="hidden" name="contact_id" value="{$data['id']}"/>
        <input type="hidden" name="vendor_id" value="{$data['vendor_id']}"/>
        <input type="hidden" name="is_manager" value="{$_REQUEST['is_manager']}"/>
        <div class="alert alert-success" style="margin:20px 0">
            <strong>创建新的{if $data['type']==21}供应商{else}用户{/if}账号</strong>
        </div>
        <div class="form-body">
            <div class="form-group">
                <label class="col-md-3 control-label">账户名</label>

                <div class="col-md-7">
                    <div class="input-icon">
                        <i class="fa fa-user"></i>
                        <input type="text" class="form-control" placeholder="新建账户名" value="{$data['company']|default:$data['username']}" name="username">
                    </div>
                </div>
            </div>
            <div class="form-group">
                <label class="col-md-3 control-label">手机号</label>

                <div class="col-md-7">
                    <div class="input-icon">
                        <i class="fa fa-mobile"></i>
                        <input type="text" class="form-control" placeholder="手机号" value="{$data['phone']}" name="phone">
                    </div>
                </div>
            </div>
            <div class="form-group">
                <label class="col-md-3 control-label">密码</label>

                <div class="col-md-7">
                    <div class="input-icon">
                        <i class="fa fa-keyboard-o"></i>
                        <input type="password" class="form-control" placeholder="请输入密码" name="password">
                    </div>
                </div>
            </div>
            <div class="form-group">
                <label class="col-md-3 control-label">确认密码</label>

                <div class="col-md-7">
                    <div class="input-icon">
                        <i class="fa fa-keyboard-o"></i>
                        <input type="password" class="form-control" placeholder="请输入密码" name="rpassword">
                    </div>
                </div>
            </div>
        </div>

        <div class="form-actions">
            <div class="form-group">
                <div class="col-md-offset-3 col-md-10">
                    <button type="submit" class="btn btn-success">
                        确认提交
                    </button>
                </div>
            </div>
        </div>
    </form>
    <form class="form-horizontal col-md-6" action="?" method="post" role="form">
        <input type="hidden" name="action" value="bind_account_submit"/>
        <input type="hidden" name="contact_id" value="{$data['id']}"/>
        <input type="hidden" name="phone" value="{$data['phone']}"/>
        <input type="hidden" name="vendor_id" value="{$data['vendor_id']}"/>
        <div class="alert alert-info" style="margin:20px 0">
            <strong>绑定到现有{if $data['type']==21}供应商{else}用户{/if}账号</strong>
        </div>
        <div class="form-body">
            <div class="form-group">
                <label class="col-md-3 control-label">账户名</label>

                <div class="col-md-7">
                    <div class="input-icon">
                        <i class="fa fa-user"></i>
                        <input type="hidden" id="select2_sample6" class="form-control" name="account_id">
                    </div>
                </div>
            </div>
        </div>

        <div class="form-actions">
            <div class="form-group">
                <div class="col-md-offset-3 col-md-10">
                    <button type="submit" class="btn btn-info">
                        确认提交
                    </button>
                </div>
            </div>
        </div>
    </form>
    <script>
        $(document).ready(function () {
            $("#select2_sample6").select2({
                placeholder: "选择已有账号",
                minimumInputLength: 1,
                ajax: { // instead of writing the function to execute the request we use Select2's convenient helper
                    url: "http://{Core::$urls['host']}/static/api/administrator/auto/complete.jsonp",
                    dataType: 'json',
                    data: function (term, page) {
                        return {
                            q: term, // search term
                            type: '{$data['type']}',
                            page_limit: 10,
                            contact_id:{$data['id']}
                        };
                    },
                    results: function (data, page) { // parse the results into the format expected by Select2.
                        // since we are using custom formatting functions we do not need to alter remote JSON data
                        return {
                            results: data.data.items
                        };
                    }
                },
                initSelection: function (element, callback) {
                    var id = $(element).val();
                    if (id !== "") {
                        $.ajax("http://{Core::$urls['host']}/static/api/administrator/auto/complete.jsonp", {
                            data: {
                                id: id
                            },
                            dataType: "json"
                        }).done(function (data) {
                            console.log(data);
                            callback(data.data.items[0]);
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
                return repo.full_name;
            }

            function formatRepoSelection(repo) {
                return repo.full_name || repo.text;
            }

        })

    </script>
</div>