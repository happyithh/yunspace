<!DOCTYPE html>
<head>
    <title>{$title}</title>
    <meta content="" name="description"/>
    {include "Admin::inc/html_head.tpl"}

    <style>
        .type > a {
            margin: 5px;
            font-size: 14px;
            float: left;
        }
    </style>
</head>
<link href="css/bootstrap-datetimepicker.min.css" rel="stylesheet"/>
<script src="js/jquery-1.9.1.min.js"></script>
<body style="background:#FaFaFa !important">
<div class="portlet tabbable">
    <div class="portlet-title">
        <div class="caption">
            <i class="fa fa-database"></i>广告位设置
        </div>
    </div>
    <div class="portlet-body form">
        <form class="form-horizontal" role="form" action="?action=siteAddSubmit" method="post">
            <input type="hidden" name="submit" value="1">
            <input type="hidden" name="id" value="{$data[0]['id']}">

            <div class=" tabbable tabbable-custom boxless" style="padding: 10px;">
                <label class="col-md-3 control-label"><span style="color: red;">*</span> 广告位置</label>

                <div class="col-md-4">
                    <input class="form-control" rows="1" type="text" placeholder="例如：首页" name="site"
                           value="{$data[0]['site']}"/>
                </div>
            </div>
            <div class=" tabbable tabbable-custom boxless" style="padding: 10px;">
                <label class="col-md-3 control-label">位置描述</label>

                <div class="col-md-4">
                    <textarea class="form-control" rows="3" placeholder="例如：首页1F精彩推荐上方banner"
                              name="description">{$data[0]['description']}</textarea>
                </div>
            </div>
            <div class=" tabbable tabbable-custom boxless size" style="padding: 10px;">
                <label class="col-md-3 control-label"><span style="color: red;">*</span> 版位尺寸</label>

                <div class="col-md-2" style="float: left; ">

                    <input class="form-control" rows="1" type="text" placeholder="宽度 例:1180"
                           name="size[width]" value="{$data[0]['size']['width']}">
                </div>
                <div class="col-md-2">
                    <input class="form-control" rows="1" type="text" placeholder="高度 例:90"
                           name="size[height]" value="{$data[0]['size']['height']}">
                </div>

            </div>
              <div class=" tabbable tabbable-custom boxless" style="padding: 10px;">
                <label class="col-md-3 control-label">投放城市</label>

                <div class="col-md-2">
                    <label class="radio-inline">
                        <input type="radio" name="adver_city"
                               value="0" {if $data[0]['adver_city']==0 } checked=""{/if}>
                        无
                    </label>
                    <label class="radio-inline">
                        <input type="radio" name="adver_city" value="1" {if $data[0]['adver_city']==1 || !isset($data)} checked=""{/if}>
                        有

                    </label>

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