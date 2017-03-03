<!DOCTYPE html>
<!--[if IE 8]>
<html lang="en" class="ie8 no-js"> <![endif]-->
<!--[if IE 9]>
<html lang="en" class="ie9 no-js"> <![endif]-->
<!--[if !IE]><!-->
<html lang="en" class="no-js">
<!--<![endif]-->
<!-- BEGIN HEAD -->
<head>
    <title>{$title}</title>
    <meta content="" name="description"/>
    {include "Admin::inc/html_head.tpl"}
    <link href="style/css.css" rel="stylesheet"/>
</head>
<!-- END HEAD -->
<!-- BEGIN BODY -->

<body style="background:#FaFaFa !important">
<div class="portlet-body">
    <form action="?" class="form-horizontal" method="post" enctype="multipart/form-data">
        <input type="hidden" name="id" value="{$_REQUEST['id']}">
        <input type="hidden" name="action" value="edit_submit">
        <input type="hidden" name="url_back" value="{$_REQUEST['url_back']}">

        <div class="form-body">
            {if $_data['id']}
                <h3 class="form-section">修改部门成员</h3>
            {else}
                <h3 class="form-section">添加部门成员</h3>
            {/if}
            <div class="form-group">
                <label class="col-md-3 control-label">部门名称</label>

                <div class="col-md-4">
                    <input type="text" class="form-control" value="{$_data['department_name']}" readonly>
                </div>
            </div>
            <div class="form-group">
                <label class="col-md-3 control-label">城市</label>

                <div class="col-md-4">
                    <input type="text" class="form-control"name="city"  value="{$_data['city']|default:$_REQUEST['city']}">
                </div>
            </div>
            <div class="form-group">
                <label class="col-md-3 control-label">管理员</label>

                <div class="col-md-4 col-sm-12 select">
                    <input type="hidden" id="select2_sample6" class="form-control select2" name="admin_id" value="{$_data['admin_id']}">
                </div>
            </div>
            <div class="form-group">
                <label class="col-md-3 control-label">级别</label>
                <div class="col-md-4 col-sm-12">
                    <label class="radio-inline"><input type="radio" name="level"   {if $_data['level']==1}checked {/if} value="1">总监</label>
                    <label class="radio-inline"><input type="radio" name="level"   {if $_data['level']==2}checked {/if} value="2">经理</label>
                    <label class="radio-inline"><input type="radio" name="level"   {if $_data['level']==3}checked {/if} value="3">组长</label>
                    <label class="radio-inline"><input type="radio" name="level"   {if $_data['level']==0}checked {/if} value="0">普通</label>
                </div>
            </div>
            <div class="form-group">
                <label class="col-md-3 control-label">组别</label>

                <div class="col-md-4 col-sm-12" id="changera">
                    {foreach $teams[$_data['department_name']] as $v}
                        <label class="radio-inline" ><input   type="radio" name="is_ka" {if $_data['is_ka']==$v}checked {/if} value="{$v}">{$v}</label>
                    {/foreach}
                    {foreach $teams[''] as $v}
                        <label class="radio-inline" ><input   type="radio" name="is_ka" {if $_data['is_ka']==$v}checked {/if} value="{$v}">{$v}</label>
                    {/foreach}
                </div>
            </div>
            <div class="form-group">
                <label class="col-md-3 control-label">所属组</label>

                <div class="col-md-4 col-sm-12">
                    <input type="text" id="team_name"  class="form-control" name="team_name" value="{$_data['team_name']}">
                </div>
            </div>
            <div class="form-group">
                <label class="col-md-3 control-label"></label>
                <div class="col-md-4 col-sm-12">
                    <span>示例分组：</span>
                    <span onclick="fillTeam(this)" class="btn btn-default btn-sm" style="margin-right: 10px;">A组</span>
                    <span onclick="fillTeam(this)" class="btn btn-default btn-sm" style="margin-right: 10px;">B组</span>
                    <span onclick="fillTeam(this)" class="btn btn-default btn-sm" style="margin-right: 10px;">C组</span>
                    <span onclick="fillTeam(this)" class="btn btn-default btn-sm" style="margin-right: 10px;">D组</span>
                </div>

            </div>
            <div class="form-group">
                <label class="col-md-3 control-label">每日配额</label>

                <div class="col-md-4">
                    <input type="number" class="form-control" placeholder="请填写每日配额" name="quota_today" value="{$_data['quota_today']}">
                </div>
            </div>
            {*<hr>*}
            {*<h4 class="form-section">设置部门指标</h4>*}

            {*<div class="form-group">*}
                {*<label class="col-md-3 control-label">新增联系人数量</label>*}

                {*<div class="col-md-4">*}
                    {*<input type="number" class="form-control" placeholder="请填写新增的联系人数量" name="data[indicator][新增的联系人数量]" value="{$_data['data']['indicator']['新增的联系人数量']}">*}
                {*</div>*}
            {*</div>*}
            {*<div class="form-group">*}
                {*<label class="col-md-3 control-label">获取联系人库数量</label>*}

                {*<div class="col-md-4">*}
                    {*<input type="number" class="form-control" placeholder="请填写获取的联系人数量" name="data[indicator][获取联系人库数量]" value="{$_data['data']['indicator']['获取联系人库数量']}">*}
                {*</div>*}
            {*</div>*}
            {*<div class="form-group">*}
                {*<label class="col-md-3 control-label">新增供应商数量</label>*}

                {*<div class="col-md-4">*}
                    {*<input type="number" class="form-control" placeholder="请填写新增供应商数量" name="data[indicator][新增供应商数量]" value="{$_data['data']['indicator']['新增供应商数量']}">*}
                {*</div>*}
            {*</div>*}
            {*<div class="form-group">*}
                {*<label class="col-md-3 control-label">签约供应商数量</label>*}

                {*<div class="col-md-4">*}
                    {*<input type="number" class="form-control" placeholder="请填写签约供应商数量" name="data[indicator][签约供应商数量]" value="{$_data['data']['indicator']['签约供应商数量']}">*}
                {*</div>*}
            {*</div>*}
            {*<div class="form-group">*}
                {*<label class="col-md-3 control-label">上线供应商数量</label>*}

                {*<div class="col-md-4">*}
                    {*<input type="number" class="form-control" placeholder="请填写上线供应商数量" name="data[indicator][上线供应商数量]" value="{$_data['data']['indicator']['上线供应商数量']}">*}
                {*</div>*}
            {*</div>*}
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
</div>
</body>
<!-- BEGIN JAVASCRIPTS(Load javascripts at bottom, this will reduce page load time) -->
<!-- BEGIN CORE PLUGINS -->
<script src="{$_assets}plugins/jquery-1.11.0.min.js"
        type="text/javascript"></script>
<script src="{$_assets}plugins/jquery-migrate-1.2.1.min.js"
        type="text/javascript"></script>
<!-- IMPORTANT! Load jquery-ui-1.10.3.custom.min.js before bootstrap.min.js to fix bootstrap tooltip conflict with jquery ui tooltip -->
<script src="{$_assets}plugins/jquery-ui/jquery-ui-1.10.3.custom.min.js"
        type="text/javascript"></script>
<script src="{$_assets}plugins/bootstrap/js/bootstrap.min.js"
        type="text/javascript"></script>
<script src="{$_assets}plugins/bootstrap-hover-dropdown/bootstrap-hover-dropdown.min.js"
        type="text/javascript"></script>
<script src="{$_assets}plugins/jquery-slimscroll/jquery.slimscroll.min.js"
        type="text/javascript"></script>
<script src="{$_assets}plugins/jquery.blockui.min.js"
        type="text/javascript"></script>
<script src="{$_assets}plugins/uniform/jquery.uniform.min.js"
        type="text/javascript"></script>
<!-- END CORE PLUGINS -->
<!-- BEGIN PAGE LEVEL PLUGINS -->
<script type="text/javascript"
        src="{$_assets}plugins/select2/select2.min.js"></script>
<script type="text/javascript"
        src="{$_assets}plugins/datatables/media/js/jquery.dataTables.min.js"></script>
<script type="text/javascript"
        src="{$_assets}plugins/datatables/plugins/bootstrap/dataTables.bootstrap.js"></script>
<!-- END PAGE LEVEL PLUGINS -->
<!-- BEGIN PAGE LEVEL SCRIPTS -->
<script src="{$_assets}scripts/_page.js"></script>
<script>
    $(document).ready(function () {
        $("#select2_sample6").select2({
            placeholder: "选择管理员",
            minimumInputLength: 1,
            ajax: { // instead of writing the function to execute the request we use Select2's convenient helper
                url: "?action=ajax_user_json",
                dataType: 'json',
                data: function (term, page) {
                    return {
                        q: term, // search term
                        page_limit: 10
                    };
                },
                results: function (data, page) { // parse the results into the format expected by Select2.
                    // since we are using custom formatting functions we do not need to alter remote JSON data
                    return {
                        results: data.items
                    };
                }
            },
            initSelection: function (element, callback) {
                var id = $(element).val();
                if (id !== "") {
                    $.ajax("?action=ajax_user_json", {
                        data: {
                            id: id
                        },
                        dataType: "json"
                    }).done(function (data) {
                        console.log(data);
                        callback(data.items[0]);
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
    function fillTeam(o){
        var team_name=$(o).text();
//        var is_kas= $('input:radio[name="is_ka"]:checked').attr("data_value");
//        if(is_kas==null){
//            $("#abc").html("请选中一个组别!");
//            return false;
//        }else{
//            $("#abc").remove();
//        }
//        $('#team_name').val(is_kas+'-'+team_name);
        $('#team_name').val(team_name);
    }
//    function changera(o){
//        $('#team_name').val('');
//    }

</script>
</body>
<!-- END BODY -->
</html>