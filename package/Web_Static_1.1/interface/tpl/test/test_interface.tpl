<!DOCTYPE html>
<html>
<head>
    {*{include file="Web_Static::v2.0/html_goto_mobile.tpl" url="m/user_center/"}*}
    {include 'Web::inc/html_head.tpl'}
    <link rel="stylesheet" type="text/css" href="css/register.v2.0/register-1.css">
    <style>
        .submit a {
            /*background: #cc3333;*/
            border: 0px;
            color: #fff !important;
            width: 100%;
            height: 40px;
            font-size: 17px;
            font-weight: bold;
        }

        .left {
            float: left !important;
        }

        .reg_body {
            width: 900px;
        }

        .register_person {
            width: 900px;
            margin: 40px auto;
        }
    </style>
</head>
<body>
<div class="content ">
    <div class="wrap con clearfix banner_wrap">
        <div class="register_person">
            <div class="clear"></div>
            <div class="reg_body">
                <div class="clear"></div>
                <div class="reg_form">
                    <div class="container-fluid">
                        <div class="login_header">
                            测试接口
                        </div>
                            <input type="hidden" name="action" value="test"/>

                            <div class="container-fluid">
                                <div class="row">
                                    <div class="col-md-4 p left">接口类型</div>
                                    <div class="col-md-8 right">

                                        <select name='category' onchange="getCategorys(this)">
                                            <option>请选择</option>
                                            {foreach $category as $k=>$v}
                                                <option>
                                                    {$v}
                                                </option>
                                            {/foreach}
                                        </select>
                                    </div>
                                </div>
                            </div>
                            <div class="container-fluid">
                                <div class="row">
                                    <div class="col-md-4 p left">接口名称</div>
                                    <div class="col-md-8 right interface_name">
                                        <select name='interface_name' id="select_id" onchange="getName(this)">
                                            <option>请选择</option>
                                        </select>
                                    </div>
                                </div>
                            </div>
                            <div class="container-fluid">
                                <div class="row">
                                    <div class="col-md-4 p left">URL</div>
                                    <div class="col-md-8 right"><input type="text" readonly name="urls" id="js-url-input" class="input " value=""></div>
                                </div>
                            </div>
                            <div class="container-fluid" >
                                <div class="row">
                                    <div class="col-md-4 p left">接口参数</div>
                                    <div class="col-md-8 right">
                                        <textarea class="form-control" placeholder="接口参数" rows="5"
                                                  name="data" id="field"></textarea>
                                        <span id="explain" style="color: #5a5b62;font-size:15px;"></span>
                                    </div>
                                </div>
                            </div>

                            <div class="submit">
                                <a class="btn btn-info" onclick="submitInterfaceReport(this)">
                                    开始测试
                                </a>
                            </div>
                            <div class="info-content js-info-name"><p></p></div>
                            <div class='reg_form' id='output'>
                            </div>

                    </div>
                </div>
            </div>
            <div class="clear"></div>
        </div>
    </div>
</div>
<!-- 尾部 -->
<script>
    function getCategorys(e) {
        var category = $(e).val();
        var getInterface = 'getInterface';
        if (category != '请选择') {
            YunSpace.api('test/interface.jsonp', {
                tab: getInterface,
                category: category
            }, function (data) {
                if (data.status == 1) {
                    var htmls = '';
                    for (i = 0; i < data.data.length; i++) {
                        htmls = htmls + "<option >" + data.data[i]['interface_name'] + "</option>";
                    }
                    $("#select_id").html("<option >请选择</option>" + htmls);
                } else {
                    top.alert(data.msg);
                }
            })
        }
    }
    function getName(e) {
        var interface_name = $(e).val();
        var getInterfaceField = 'getInterfaceField';
        var getUrls = $("#js-url-input").val();
        $("#js-url-input").val(interface_name+".json");
        if (interface_name != '请选择') {
            YunSpace.api('test/interface.jsonp', {
                        tab: getInterfaceField,
                        interface_name: interface_name
                    }, function (data) {
                        if (data.status == 1) {
                            var result = data.data[0]['data'].replace(/&#34;/ig,"\"");
                            $("#field").val(result);
                            $("#explain").text('接口说明：'+data.data[0]['des']);
                        } else {
                            top.alert(data.msg);
                        }
                    }
            )
        }
    }
    function submitInterfaceReport(e) {
        var getUrls = $("#js-url-input").val();
        var allContent = $("#field").val();
        YunSpace.api(getUrls,
                JSON.parse(allContent),
                function (data) {
                    if (data.status == 1) {
                        var resultString="";
                        for(var i = 0; i<data["data"].length; i++){
                            resultString+=JSON.stringify(data["data"][i])+"\n";
                        }
                        var html =
                        "<div class='container-fluid'> " +
                        "<div class='login_header'>" +
                        "</div>" +
                        "<div class='container-fluid'>" +
                        " <div class='row'> " +
                        "<div class='col-md-4 p left'>返回内容</div>" +
                        " <div class='col-md-8 right'>" +
                        "<textarea class='form-control' placeholder='接口参数' rows='10'name='data'>" +resultString+
                        "</textarea>" +
                        "</div> " +
                        "</div> " +
                        "</div> " +
                        "<div class='info-content js-info-name'>" +
                        "<p></p></div>" +
                        " </div> ";
                        $("#output").html(html)
                    } else {
                        var html =
                                "<div class='container-fluid'> " +
                                "<div class='login_header'>" +
                                "</div>" +
                                "<div class='container-fluid'>" +
                                " <div class='row'> " +
                                "<div class='col-md-4 p left'>返回内容</div>" +
                                " <div class='col-md-8 right'>" +
                                "<textarea class='form-control' placeholder='' rows='10'name='data'>" + data.msg+
                                "</textarea>" +
                                "</div> " +
                                "</div> " +
                                "</div> " +
                                "<div class='info-content js-info-name'>" +
                                "<p></p></div>" +
                                " </div> ";
                        $("#output").html(html);
                    }
                }
        )
    }
</script>
{static "core/yunspace.js"}
</body>
</html>