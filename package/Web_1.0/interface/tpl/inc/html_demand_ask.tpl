<div class="modal fade" id="openDemanAsk" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">

    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-body">
                <table class="table" id="list_info">
                    <thead>
                    <th width="120px;">预约咨询</th>
                    <th></th>
                    </thead>
                    <tr>
                        <td>
                            您的称呼
                        </td>
                        <td>
                            <input type="text" class="col-md-12 form-control" name="data[联系人]" value=""
                                   placeholder="请输入您的姓名">
                        </td>
                    </tr>
                    <tr>
                        <td>
                            您的联系方式
                        </td>
                        <td>
                            <input type="text" class="col-md-12 form-control phone" name="data[联系电话]"
                                   value="" placeholder="请输入您的联系方式：手机号或者电话">
                        </td>
                    </tr>
                    <tr>
                        <td>
                            您想咨询的内容
                        </td>
                        <td>
                            <textarea name="data[咨询内容]" class=" col-md-12 form-control" rows="3"
                                      placeholder="您想咨询的内容"></textarea>
                        </td>
                    </tr>
                </table>
            </div>
            <div style="text-align: center;margin-top: -20px;margin-bottom: 10px;">
                <div>关注云·SPACE服务号，获取最新回复</div>
                <img src="{$_assets}public/space_fwh.jpg" width="120" title="云·SPACE 服务号"/>
            </div>
            <div class="modal-footer right">
                <a data-dismiss="modal" class="btn btn-default">
                    取消
                </a>
                <a data-toggle="modal" id="but" ask_type="5" onclick="demanAsk(this)" class="btn btn-info">提交</a>
                <input type="hidden" id="ask_id" name="data[ask_id]" value=""/>
                <input type="hidden" id="ask_type" name="data[ask_type]" value=""/>
            </div>
        </div>
    </div>
    <div class="demand-code" style="display: none">
        <div class="demand-code-content">
            <div class="demand-code-body">
                <div class="remind">
                    由于您未登录，请输入手机验证码！！
                </div>
                <table class="table" id="list_info">
                    <thead>
                    <th width="120px;">验证手机</th>
                    <th></th>
                    </thead>
                    <tr>
                        <td>
                            输入验证码
                        </td>
                        <td>
                            {*<input type="text" class="col-md-12 form-control input-code" name="data[验证码]" value=""*}
                            {*placeholder="请输入您的刚才填写手机的验证码">*}
                            <div class="col-lg-12 col-md-12">
                                <div class="input-group">
                                    <input type="text" class="form-control input-code" aria-label="...">

                                    <div class="input-group-btn">
                                        <a type="button" class="btn btn-default send-code"
                                           yun="identify-code.v1.0/identify-code.v1.0.js::sendCode@click" yun-modal="true"
                                           yun-phone=".phone" yun-second="30">
                                            重新发送
                                        </a>
                                    </div>
                                    <!-- /btn-group -->
                                </div>
                                <!-- /input-group -->
                            </div>
                            <!-- /.col-lg-6 -->
                        </td>
                    </tr>
                </table>
                <div style="text-align: center;margin-top: -20px;margin-bottom: 10px;">
                    <div>关注云·SPACE服务号，获取最新回复</div>
                    <img src="{$_assets}public/space_fwh.jpg" width="120" title="云·SPACE 服务号"/>
                </div>
                <div class="modal-footer right">
                    <a data-dismiss="modal" class="btn btn-default">
                        取消
                    </a>
                    <a data-toggle="modal" id="but" ask_type="5" onclick="validateCode(this)"
                       class="btn btn-info">提交</a>
                    <input type="hidden" id="ask_id" name="data[ask_id]" value=""/>
                    <input type="hidden" id="ask_type" name="data[ask_type]" value=""/>
                </div>
            </div>

        </div>
    </div>
</div>

<script>
    $(".demandAsk").on("click", function (e) {
        if (!$(".modal").hasClass("in")) {
            $(".demand-code").hide();
            $(".modal-dialog").css({
                display: "block"
            });
        }
        $('#openDemanAsk input').eq(0).val($('#user_stat').data('username'));
        $('#openDemanAsk input').eq(1).val($('#user_stat').data('phone'));
        var ask_id = $(this).attr('ask_id');
        var ask_type = $(this).attr('ask_type');
        $("#ask_id").val(ask_id);
        $("#ask_type").val(ask_type);
        $("#openDemanAsk").fadeIn();
    });

    function demanAsk(e) {
        var ask_id = $("#ask_id").val();
        var ask_type = $("#ask_type").val();
        var username = $("input[name='data[联系人]']").val();
        var phone = $("input[name='data[联系电话]']").val();
        var content = $("textarea[name='data[咨询内容]']").val();
        var login = false;
        var user = $('#user_stat').data('username');
        //如果登陆
        if (user != null) {
            YunSpace.api('demand/create.jsonp', {
                ask_id: ask_id,
                ask_type: ask_type,
                username: username,
                phone: phone,
                content: content,
                action: 'consult'
            }, function (data) {
                if (data.status == 1) {
                    top.alert(data.msg);
                    $(".modal-dialog .btn-default").trigger("click");
                } else {
                    top.alert(data.msg);
                }
            });
        } else {
            var second = 30;
            if (phone != "") {
                YunSpace.api('common/send/auth/code.json', {
                    phone: phone
                }, function (data) {

                    if (data.status == "0") {
                        $(".send-code").attr("disabled", false);
                        if (!$(".modal").hasClass("in")) {
                            clearInterval(setTime);
                            second = 30;
                            $(".send-code").text("重新发送");
                            $(".modal").find("input").val("");
                        }
                        alert(data.msg);
                    } else {
                        $(".send-code").attr("disabled", true);
                        var setTime = setInterval(function (e) {
                            second--;
                            var info = "重新发送(" + second + ")";
                            $(".send-code").text(info);
                            if (!$(".modal").hasClass("in")) {
                                clearInterval(setTime);
                                second = 30;
                                $(".send-code").text("重新发送");
                                $(".modal").find("input").val("");
                            }
                            if (second < 1) {
                                info = "重新发送";
                                clearInterval(setTime);
                                $(".send-code").text(info);
                                $(".send-code").attr("disabled", false);
                            }
                        }, 1000);
                    }
                    $(".modal-dialog").hide();
                    $(".demand-code").fadeIn(200);
                    $(".remind").show(100, function () {
                        $(".remind").css({
                            top: "100px",
                            opacity: 0
                        });
                    });
                });

            } else {
                alert("联系方式不能为空！！");
            }
        }
    }

    function validateCode(e) {
        var ask_id = $("#ask_id").val();
        var ask_type = $("#ask_type").val();
        var username = $("input[name='data[联系人]']").val();
        var phone = $("input[name='data[联系电话]']").val();
        var content = $("textarea[name='data[咨询内容]']").val();
        var code = $(".input-code").val();
        YunSpace.api('common/check/auth/code.json', {
            phone: phone,
            auth_code: code
        }, function (data) {
            console.log(data);
            if (data.status == 1) {
                $(".modal").removeClass("in");
                YunSpace.api('demand/create.jsonp', {
                    ask_id: ask_id,
                    ask_type: ask_type,
                    username: username,
                    phone: phone,
                    content: content,
                    action: 'consult'
                }, function (data) {
                    if (data.status == 1) {
                        top.alert(data.msg);
                        $(".modal-dialog .btn-default").trigger("click");
                    } else {
                        top.alert(data.msg);
                    }
                });
            } else {
                alert("验证码不正确！！")
            }
        });
    }
</script>