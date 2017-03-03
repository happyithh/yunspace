<!DOCTYPE html>
<head>
    <title>{$title}</title>
    <meta content="" name="description"/>
    {include "Admin::inc/html_head.tpl"}
</head>
<!-- END HEAD -->
<!-- BEGIN BODY -->
<link href="css/bootstrap-datetimepicker.min.css" rel="stylesheet"/>
<script src="js/jquery-1.9.1.min.js"></script>
<body style="background:#FaFaFa !important">
<div class="portlet tabbable">
    <div class="portlet-title">
        <div class="caption">
            <i class="fa fa-database"></i>表单设置
        </div>
    </div>
    <div class="portlet-body form">
        <form class="form-horizontal" role="form" action="?" method="post">
            <input type="hidden" name="submit" value="1">
            <input type="hidden" name="action" {if !empty($data['id'])} value='add'{else} value="edit_submit" {/if}>
            {if !empty($data['id'])}
                <input type="hidden" name="id" value="{$data['id']}">
            {/if}
            <div class=" tabbable tabbable-custom boxless" style="padding: 10px;">
                <label class="col-md-3 control-label">表单名称</label>

                <div class="col-md-4">
                    <input class="form-control" rows="1" type="text" placeholder="例如：供应商加盟" name="form" value="{$data['form']}">
                </div>
            </div>
            <div class=" tabbable tabbable-custom boxless" style="padding: 10px;">
                <label class="col-md-3 control-label">必填字段</label>
                <div class="col-md-4">
                    <input class="form-control" rows="1" type="text" placeholder="例如：姓名、电话  (字段之间必须以“、”分割)"
                           name="field" value="{$data['field'][0]}">
                </div>
            </div>
            <div class=" tabbable tabbable-custom boxless" style="padding: 10px;">
                <label class="col-md-3 control-label">反馈邮箱</label>

                <div class="col-md-4">
                    <input class="form-control" rows="1" type="text" placeholder="填写多个邮箱时必须以“ ; ”分割 (英文状态下的分号)"
                           name="backemail" value="{$data['backemail']}">
                </div>
            </div>
            <div class=" tabbable tabbable-custom boxless" style="padding: 10px;">
                <label class="col-md-3 control-label">邮箱字段</label>

                <div class="col-md-4">
                    <input class="form-control" rows="1" type="text" placeholder="例如：个人邮箱、公司邮箱 (字段之间必须以“、”分割)"
                           name="email" value="{$data['email']}">
                </div>
            </div>
            <div class=" tabbable tabbable-custom boxless" style="padding: 10px;">
                <label class="col-md-3 control-label">请选择起止时间</label>
                <div class="col-md-4">
                    <div class="col-md-4" style="width: 130px;height:300px;float: left;margin-left: 5px;padding: 0;">
                        <input type='text' class="form-control date" placeholder="请选择开始时间" name="start_time"
                               value="{if !empty($data['start_time'])}{date('Y-m-d',$data['start_time'])}{/if}"/>
                    </div>
                    <div style="display: block;float: left;line-height: 30px;height: 30px;text-align: center;margin-left: 2px;">
                        ----
                    </div>
                    <div class="col-md-4" style="width: 130px;float: left;margin-left: 5px;padding: 0;">
                        <input type='text' class="form-control date" placeholder="请选择结束时间" name="end_time"
                               value="{if !empty($data['end_time'])}{date('Y-m-d',$data['end_time'])}{/if}"/>
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
</body>
<script type="text/javascript" src="js/moment.min.js"></script>
<script type="text/javascript" src="js/zh-cn.js"></script>
<script type="text/javascript" src="js/bootstrap-datetimepicker.min.js"></script>
<script>
    $(document).ready(function () {
        $('.date').datetimepicker({
            format: 'YYYY-MM-DD',
            locale: 'zh-cn'
        });
    });


</script>
<!-- END BODY -->
</html>