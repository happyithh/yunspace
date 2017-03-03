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
            <form class="form-horizontal">
                <h3>基本信息</h3>
                <div class="form-group">
                    <label for="act_name" class="col-sm-2 control-label">活动名称</label>
                    <div class="col-sm-10">
                        <input type="email" class="form-control" id="act_name" placeholder="">
                    </div>
                </div>
                <div class="form-group">
                    <label for="inputPassword3" class="col-sm-2 control-label">购票人姓名</label>
                    <div class="col-sm-10">
                        <input type="password" class="form-control" id="inputPassword3" placeholder="">
                    </div>
                </div>
                <div class="form-group">
                    <label for="inputPassword3" class="col-sm-2 control-label">联系方式</label>
                    <div class="col-sm-10">
                        <input type="password" class="form-control" id="inputPassword3" placeholder="">
                    </div>
                </div>
                <div class="form-group">
                    <label for="inputPassword3" class="col-sm-2 control-label">订单号</label>
                    <div class="col-sm-10">
                        <input type="password" class="form-control" id="inputPassword3" placeholder="">
                    </div>
                </div>
                <div class="form-group">
                    <label for="inputPassword3" class="col-sm-2 control-label">购票票数</label>
                    <div class="col-sm-10">
                        <input type="password" class="form-control" id="inputPassword3" placeholder="">
                    </div>
                </div>
                <div class="form-group">
                    <label for="inputPassword3" class="col-sm-2 control-label">支付金额</label>
                    <div class="col-sm-10">
                        <input type="password" class="form-control" id="inputPassword3" placeholder="">
                    </div>
                </div>
                <div class="form-group">
                    <label for="inputPassword3" class="col-sm-2 control-label">支付时间</label>
                    <div class="col-sm-10">
                        <table class="table table-striped table-bordered table-hover">
                            <thead>
                            <tr>
                                <th width="35%"> 票 号</th>
                                <th width="20%">门 票 类 型</th>
                                <th width="10%">状 态</th>
                                <th width="20%">门 票 时 间</th>
                                <th width="15%">票 价</th>
                                <th width="15%">操作</th>
                            </tr>
                            </thead>
                            <tbody class="sortable">
                            <tr>
                                <td><input type="text" class="form-control" name="eventstock[0]" value="W10491314926401" readonly=""></td>
                                <td><input type="text" class="form-control" name="eventname[0]" value="19：30 180元" readonly=""></td>
                                <td><input type="text" class="form-control" name="eventprice[0]" value="未使用" readonly=""></td>
                                <td><input type="text" class="form-control" name="eventprice[0]" value="2016-04-24" readonly=""></td>
                                <td><input type="text" class="form-control" name="eventstock[0]" value="180 元" readonly=""></td>
                                <td><button type="submit" class="btn btn-success">检票</button></td>
                            </tr>
                            <tr>
                                <td><input type="text" class="form-control" name="eventstock[0]" value="W10491314926401" readonly=""></td>
                                <td><input type="text" class="form-control" name="eventname[0]" value="19：30 180元" readonly=""></td>
                                <td><input type="text" class="form-control" name="eventprice[0]" value="未使用" readonly=""></td>
                                <td><input type="text" class="form-control" name="eventprice[0]" value="2016-04-24" readonly=""></td>
                                <td><input type="text" class="form-control" name="eventstock[0]" value="180 元" readonly=""></td>
                                <td><button type="submit" class="btn btn-success">检票</button></td>
                            </tr>
                            <tr>
                                <td><input type="text" class="form-control" name="eventstock[0]" value="W10491314926401" readonly=""></td>
                                <td><input type="text" class="form-control" name="eventname[0]" value="19：30 180元" readonly=""></td>
                                <td><input type="text" class="form-control" name="eventprice[0]" value="未使用" readonly=""></td>
                                <td><input type="text" class="form-control" name="eventprice[0]" value="2016-04-24" readonly=""></td>
                                <td><input type="text" class="form-control" name="eventstock[0]" value="180 元" readonly=""></td>
                                <td><button type="submit" class="btn btn-success">检票</button></td>
                            </tr>

                            </tbody></table>
                    </div>
                </div>
                <h3>收货地址信息</h3>
                <div class="form-group">
                    <label for="inputPassword3" class="col-sm-2 control-label">姓名</label>
                    <div class="col-sm-10">
                        <input type="password" class="form-control" id="inputPassword3" placeholder="">
                    </div>
                </div>
                <div class="form-group">
                    <label for="inputPassword3" class="col-sm-2 control-label">电话</label>
                    <div class="col-sm-10">
                        <input type="password" class="form-control" id="inputPassword3" placeholder="">
                    </div>
                </div>
                <div class="form-group">
                    <label for="inputPassword3" class="col-sm-2 control-label">地址</label>
                    <div class="col-sm-10">
                        <input type="password" class="form-control" id="inputPassword3" placeholder="">
                    </div>
                </div>
                <h3>物流信息</h3>
                <div class="form-group">
                    <label for="inputPassword3" class="col-sm-2 control-label">物流来源</label>
                    <div class="col-sm-10">
                        <input type="password" class="form-control" id="inputPassword3" placeholder="">
                    </div>
                </div>
                <div class="form-group">
                    <label for="inputPassword3" class="col-sm-2 control-label">物流单号</label>
                    <div class="col-sm-10">
                        <input type="password" class="form-control" id="inputPassword3" placeholder="">
                    </div>
                </div>
                <div class="form-group">
                    <label for="inputPassword3" class="col-sm-2 control-label">物流状态</label>
                    <div class="col-md-10">
                        <label class="radio-inline">
                            <input type="radio" name="logisticsInfo[status]" value="0" checked="">
                            未寄出
                        </label>
                        <label class="radio-inline">
                            <input type="radio" name="logisticsInfo[status]" value="1" checked="">
                            已寄出
                        </label>
                    </div>
                </div>
                {*<div class="form-group">*}
                    {*<div class="col-sm-offset-2 col-sm-10">*}
                        {*<button type="submit" class="btn btn-default">重置</button>*}
                        {*<button type="submit" class="btn btn-success">提交</button>*}
                    {*</div>*}
                {*</div>*}
            </form>
        </div>
    </div>

</div>


<!-- jQuery文件。务必在bootstrap.min.js 之前引入 -->
<script src="//cdn.bootcss.com/jquery/1.11.3/jquery.min.js"></script>
<!-- 最新的 Bootstrap 核心 JavaScript 文件 -->
<script src="//cdn.bootcss.com/bootstrap/3.3.5/js/bootstrap.min.js"></script>
</body>
</html>