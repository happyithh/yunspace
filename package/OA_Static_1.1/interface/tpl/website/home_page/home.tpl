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
    <style>
        .table td {
            text-align: center !important;
            vertical-align: middle !important;
        }

        .table .thumbnail {
            margin-bottom: 0;
        }

        .table td img {
            border-radius: 4px;
        }

        .table .btns i {
            cursor: pointer;
        }

        .captions {
            background-color: #eee;
            border-radius: 4px 4px 0 0;
            padding: 10px 10px 2px 10px;
            height: 38px;
            font-size: 16px;
        }

        .topTitle {
            font-size: 15px;
        }
    </style>
    <script src="{$_assets}plugins/jquery-1.11.0.min.js" type="text/javascript"></script>
</head>
<!-- END HEAD -->
<!-- BEGIN BODY -->
<body style="background:#FaFaFa !important">
<div style="text-align: center;">
    <button class="btn btn-danger btn-default clear_all">
        清除首页所有缓存
    </button>
</div>
<div class=" tabbable tabbable-custom boxless" style="padding: 20px ;">

    <div class="portlet tabbable">
        <div class="portlet-title">
            <div class="caption">
                <i class="fa fa-database"></i>每日更新
            </div>
        </div>
        {*<div style="text-align: center;">*}
        {*<button class="btn btn-danger btn-default clear_all">*}
        {*清除页面所有缓存*}
        {*</button>*}
        {*</div>*}
        <div class="portlet-body">
            <form class="form-horizontal" role="form" action="?" method="post" enctype="multipart/form-data">
                <div class=" tabbable tabbable-custom boxless" style="padding: 20px ;">

                    <table class="table table-hover">

                        <tbody>
                        <tr>
                            <td class="topTitle">
                                每日推荐
                            </td>
                            <td>
                                <textarea class="form-control" rows="6" placeholder="请填写百科标题( 以逗号分隔 )"
                                          name="recommend[content]">{$recommend['content']}</textarea>
                            </td>
                        </tr>
                        </tbody>
                    </table>
                    <div class="form-actions text-center">
                        <button type=" reset" class="btn btn-default">
                            重置
                        </button>
                        <button type="submit" class="btn btn-success submit_button">
                            提交
                        </button>
                    </div>
                </div>
            </form>
            <form class="form-horizontal" role="form" action="?" method="post" enctype="multipart/form-data">
                <div class="portlet tabbable">
                    <div class="portlet-title">
                        <div class="caption">
                            <i class="fa fa-database"></i>楼层内容
                        </div>
                    </div>

                    <div class=" tabbable tabbable-custom boxless" style="padding: 20px ;">

                        <table class="table table-hover">
                            <tr>
                                <th style="font-size: 20px;">空间</th>
                                <th></th>
                            </tr>
                            <tr>
                                <td class="topTitle">
                                    热门空间
                                </td>
                                <td>
                                    <input class="form-control" rows="6" placeholder="例：外滩，南京东路，人民广场（以逗号分隔）"
                                           name="data[space][热门项目]" value="{$data['space']['热门项目']}">
                                </td>
                            </tr>
                            <tr>
                                <td class="topTitle">
                                    空间【中间区域】
                                    </br>
                                <span style="color: red">
                                (*填写9条数据)
                                </span>
                                </td>
                                <td>
                                    <textarea class="form-control" rows="6" placeholder="例：外滩，南京东路，人民广场（以逗号分隔）"
                                              name="data[space][标题]">{$data['space']['标题']}</textarea>
                                </td>

                            </tr>
                            {*************************文创********************}
                            <tr>
                                <th style="font-size: 20px;">文创</th>
                                <th></th>
                            </tr>
                            <tr>
                                <td class="topTitle">
                                    热门项目
                                </td>
                                <td>
                                    <input class="form-control" rows="6" placeholder="例：外滩，南京东路，人民广场（以逗号分隔）"
                                           name="data[wenChuang][热门项目]" value="{$data['wenChuang']['热门项目']}">
                                </td>
                            </tr>
                            <tr>
                                <td class="topTitle">
                                    文创【中间区域】
                                    </br>
                                <span style="color: red">
                                (*填写6条数据)
                                </span>
                                </td>
                                <td>
                                    <textarea class="form-control" rows="6" placeholder="例：外滩，南京东路，人民广场（以逗号分隔）"
                                              name="data[wenChuang][标题]">{$data['wenChuang']['标题']}</textarea>
                                </td>
                            </tr>
                            {*************************咨询********************}
                            <tr>
                                <th style="font-size: 20px;">零售</th>
                                <th></th>
                            </tr>
                            <tr>
                                <td class="topTitle">
                                    热门项目
                                </td>
                                <td>
                                    <input class="form-control" rows="6" placeholder="例：外滩，南京东路，人民广场（以逗号分隔）"
                                           name="data[consult][热门项目]" value="{$data['consult']['热门项目']}">
                                </td>
                            </tr>
                            <tr>
                                <td class="topTitle">
                                    零售【中间区域】
                                    </br>
                                    <span style="color: red">
                                    (*填写6条数据)
                                    </span>
                                </td>
                                <td>
                                    <textarea class="form-control" rows="6"
                                              placeholder="例：快闪店，（以逗号分隔）"
                                              name="data[consult][标题]">{$data['consult']['标题']}</textarea>
                                </td>
                            </tr>
                            {*************************发现********************}
                            <tr>
                                <th style="font-size: 20px;">发现</th>
                                <th></th>
                            </tr>

                            <tr>
                                <td class="topTitle">
                                    发现【中间区域】
                                    </br>
                                <span style="color: red">
                                (*填写4条数据)
                                </span>
                                </td>
                                <td>
                                    <textarea class="form-control" rows="6"
                                              placeholder="例：外滩，南京东路，人民广场（以逗号分隔）"
                                              name="data[find][标题]">{$data['find']['标题']}</textarea>
                                </td>
                            </tr>

                        </table>

                        <div class="form-actions text-center">
                            <button type=" reset" class="btn btn-default">
                                重置
                            </button>
                            <button type="submit" class="btn btn-success submit_button">
                                提交
                            </button>
                        </div>
                        </table>
                    </div>
            </form>
        </div>
        <script>
            $(".go_switch_window").on('click', function (e) {
                $(".switch_window").hide().eq($(this).index()).show();
                $(this).addClass('active btn-primary').siblings().removeClass('active btn-primary');
            });
            function changeCity(o) {
                var href = window.location.href + '?';
                window.location = href.substr(0, href.indexOf('?')) + '?city=' + $(o).val() + '&t=' + (new Date()).valueOf();
            }
            $('.clear_all').on('click', function () {
                $.ajax({
                    type: "GET",
                    url: "http://{Core::$urls['host']}/static/api/common/cache.json",
                    data: 'subTable=html_cache&token=e702784057ca97c9b08cc948b8d4e979',
                    dataType: "json",
                    success: function (data) {
                        if (data.status == 1) {
                            top.alert('  已清除所有缓存');
                        } else {
                            top.alert(data.msg);
                        }
                    }
                });
            });
        </script>
</body>

<!-- END BODY -->
</html>