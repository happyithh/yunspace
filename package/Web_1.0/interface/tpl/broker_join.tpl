<!DOCTYPE html>
<html>
<head>
    {include file="Web::inc/html_head.tpl"}
    <link rel="stylesheet" type="text/css" href="css/alliance.css">
</head>
<body>
{include file="Web::inc/header_nav.tpl"}
<div class="content eh_con">




    <div class="jmb">

        <div class="title1" style="padding-bottom: 0px;"><h1><strong>下一个就是你？</strong></h1></div>
        <div class="clearfix"></div>
    </div>

    <a href="javascript:;"  class="join1"><div class="text2"><h1>成为经纪人！</h1></div></a>

    <div class="ha">
        <div class="container-fluid">

            <div class="row">
                <div class="hb">
                    <form action="?">
                        <input type="hidden" name="submit" value="1"/>
                        <div class="form_title"><h3>填写资料申请</h3></div>
                        <div class=" f_a">
                            <div class="f_a_1  col-md-4"><span>*</span>姓名</div>
                            <div class=" col-md-7"><input class="form-control screening" style="width: 100%;" name="data[username]" value="{$__user['username']}"></div>
                            <div class="clearfix"></div>
                        </div>

                        <div class=" f_a">
                            <div class="f_a_1  col-md-4"><span>*</span>手机号码</div>
                            <div class=" col-md-7"><input class="form-control screening" style="width: 100%;" name="data[phone]" value="{$__user['phone']}"></div>
                            <div class="clearfix"></div>
                        </div>
                        <div class=" f_a">
                            <div class="f_a_1  col-md-4"><span>*</span>公司</div>
                            <div class=" col-md-7"><input class="form-control screening" style="width: 100%;" name="data[company]" value="{$__user['fullname']}"></div>
                            <div class="clearfix"></div>
                        </div>
                        <div class=" f_a">
                            <div class="f_a_1 col-md-4 "><span></span>所在地</div>
                            <div class="col-md-7">
                                <select class="form-control screening" style="width: 100%; margin-left: 0px;background: #000;" name="data[city]">
                                    {foreach $_REQUEST['cities'] as $v}
                                        <option {if $v==$_COOKIE['city']}selected="selected" {/if}>{$v}</option>
                                    {/foreach}
                                    <option>其他</option>
                                </select>
                            </div>
                            <div class="clearfix"></div>
                        </div>





                        <div class="button1 col-md-7 col-md-offset-3"><button type="submit" class="btn btn-info" style="padding: 15px;">成为经纪人</button></div>
                    </form>
                </div>
            </div>
        </div>
        <button  class='remove ' style="border:0px;background: #000000;position: absolute;right:10px;top:10px;font-size: 30px;color: #fff"><span class="glyphicon  glyphicon-remove" aria-hidden="true" ></span></button>
    </div>
</div>
<div style="margin-top:50px;" class="mt50"></div>
{include file="Web_Static::v2.0/html_footer.tpl"}
<script>
    $(function(){
        $('.remove').css('display','none');
        $('.join1').click(function() {
            $(this).css('display','none');
            $('.remove').css('display','inline');
            $('.ha').animate({
                bottom:"0px"
            },100);
        })
        $('.remove').click(function() {
            $('.join1').css('display','inline');
            $('.remove').css('display','none');
            var height = $('.ha').height();
            $('.ha').animate({
                bottom:-height
            },100);

        })
    })
</script>
</body>
</html>