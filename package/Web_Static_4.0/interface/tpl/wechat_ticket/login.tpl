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
    {static "wechat_ticket/login.css"}
    <![endif]-->
    <title>云Space后台管理登陆</title>

</head>
<body>
<div class="container">
    <div class="login-header">
        <h4>登陆</h4>
    </div>
    <div class="login-form">
    <div class="panel panel-default">
        <div class="panel-body">
            <form>
                <div class="form-group">
                    <label for="exampleInputEmail1">用户名</label>
                    <input type="email" class="form-control" id="exampleInputEmail1" placeholder="Username">
                </div>
                <div class="form-group">
                    <label for="exampleInputPassword1">密码</label>
                    <input type="password" class="form-control" id="exampleInputPassword1" placeholder="Password">
                </div>
                <div class="checkbox">
                    <label>
                            <input type="checkbox">记住我
                    </label>
                </div>
                <input class="btn btn-primary btn-block login-submit" name="commit" tabindex="3" type="submit" value="登陆"/>
            </form>
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