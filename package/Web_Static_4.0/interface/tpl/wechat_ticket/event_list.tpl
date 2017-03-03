<!DOCTYPE html>
<html lang="en">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" href="//cdn.bootcss.com/bootstrap/3.3.5/css/bootstrap.min.css">
    <!-- 可选的Bootstrap主题文件（一般不用引入） -->
    <link rel="stylesheet" href="//cdn.bootcss.com/bootstrap/3.3.5/css/bootstrap-theme.min.css">
    <!--[if lt IE 9]>
    <script src="//cdn.bootcss.com/html5shiv/3.7.2/html5shiv.min.js"></script>
    <script src="//cdn.bootcss.com/respond.js/1.4.2/respond.min.js"></script>
    <![endif]-->
    <title>云Space后台管理登陆</title>

</head>
<body>
<div class="container">
    <div class="panel panel-default">
        <div class="panel-body">
            <div class="alert alert-info" role="alert">
                <strong>微信售票活动列表</strong>
            </div>
            <ol class="breadcrumb">
                <li><a href="{$_root}">云SPACE首页</a></li>
                <li><a href="javascript:;">微信售票活动列表</a></li>
            </ol>
            <div class="table-responsive">
                <table class="table table-bordered table-striped">
                    <thead>
                    <tr class="info">
                        <th>活动名称</th>
                        <th>检票手机号</th>
                        <th>活动开始时间</th>
                        <th>创建时间</th>
                        <th>活动有效时间</th>
                        <th>活动地址</th>
                        <th>操作</th>
                    </tr>
                    </thead>
                    <tbody>
                    {if $event_list}
                        {foreach $event_list as $k=>$v}
                            <tr>
                                <td scope="row">{$v['title']}</td>
                                <td>{$v['checkticketphone']}</td>
                                <td> {date('Y-m-d',$v['activity_time'])}</td>
                                <td>{date('Y-m-d H:i',$v['create_time'])}</td>
                                <td>{date('Y-m-d',$v['start_time'])}--{date('Y-m-d',$v['end_time'])}</td>
                                <td>{$v['addr']}</td>
                                <td><a href="?action=order&event_id={$v['id']}">点击查看订单详情</a></td>
                            </tr>
                        {/foreach}
                    {else}
                        <tr>
                            <td rowspan="7">暂时没有活动，请联系管理员</td>
                        </tr>
                    {/if}
                    </tbody>
                </table>
            </div>
        </div>
    </div>

</div>


<!-- jQuery文件。务必在bootstrap.min.js 之前引入 -->
<script src="//cdn.bootcss.com/jquery/1.11.3/jquery.min.js"></script>
<!-- 最新的 Bootstrap 核心 JavaScript 文件 -->
<script src="//cdn.bootcss.com/bootstrap/3.3.5/js/bootstrap.min.js"></script>
</body>
</html>