<!DOCTYPE html>
<html>
<head>
    {include file="inc/html_head.tpl"}
    <link rel="stylesheet" type="text/css" href="css/alliance.css">
</head>
<body>
{include file="inc/header_nav.tpl"}
<div class="content eh_con">
    <div class="jm">
        <div class="banner"><img src="images/banner_a.jpg" class="img-responsive"></div>
    </div>

    <div class="jma">
        <div class="title1"><h1><strong>最强大的客户资源和合作伙伴</strong></h1></div>
        <div class="banner1"></div>
    </div>

    <div class="jm">
        <div class="banner"><img src="images/s2.jpg" class="img-responsive"></div>
    </div>

    <div class="jmb">
        <div class="title1"><h1><strong>2015-互联网活动组织服务在线交易平台</strong></h1></div>
        <div class="box">
            <div class="banner2"></div>
        </div>
        <div class="title1" style="padding-bottom: 0px;"><h1><strong>下一个就是你？</strong></h1></div>
        <div class="clearfix"></div>
    </div>

    <a href="javascript:;"  class="join1"><div class="text2"><h1>快速加盟，立刻成为供应商</h1></div></a>

    <div class="ha">
        <div class="container-fluid">

            <div class="row">
                <div class="hb">
                    <form action="{$_root}demand_submit/vendor_join" method="post">
                        <div class="form_title"><h3>填写资料申请</h3></div>
                        <div class=" f_a">
                            <div class="f_a_1 col-md-4"><span>*</span>公司名称</div>
                            <div class="col-md-7"><input class="form-control screening" style="width: 100%;" name="data[公司名称]"></div>
                            <div class="clearfix"></div>
                        </div>

                        <div class=" f_a">
                            <div class="f_a_1 col-md-4 "><span></span>所在地</div>
                            <div class="col-md-7">
                                <select class="form-control screening" style="width: 100%; margin-left: 0px;background: #000;" name="data[活动城市]">
                                    {foreach $_REQUEST['cities'] as $v}
                                        <option {if $v==$_COOKIE['city']}selected="selected" {/if}>{$v}</option>
                                    {/foreach}
                                    <option>其他</option>
                                </select>
                            </div>
                            <div class="clearfix"></div>
                        </div>

                        <div class=" f_a">
                            <div class="f_a_1  col-md-4"><span>*</span>联系人</div>
                            <div class=" col-md-7"><input class="form-control screening" style="width: 100%;" name="data[联系人]"></div>
                            <div class="clearfix"></div>
                        </div>

                        <div class=" f_a">
                            <div class="f_a_1  col-md-4"><span>*</span>手机号码</div>
                            <div class=" col-md-7"><input class="form-control screening" style="width: 100%;" name="data[联系电话]"></div>
                            <div class="clearfix"></div>
                        </div>

                        <div class="f_a">
                            <div class="f_a_1  col-md-4"><span>*</span>业务类型</div>
                            <div class="col-md-7">
                            <select class="form-control screening" style="width: 100%; margin-left: 0px;background: #000;" name="data[业务类型]">
                                {foreach $categoryList[0] as $key=>$val}
                                    {if $val !=''}
                                <option value="{$key}{$val}">{$val}</option>
                                    {/if}
                                {/foreach}
                            </select>
                            </div>
                            <div class="clearfix"></div>
                        </div>

                        <div class="button1 col-md-7 col-md-offset-3"><button type="submit" class="btn btn-info" style="padding: 15px;">提交需求</button></div>
                    </form>
                </div>
            </div>
        </div>
        <button  class='remove ' style="border:0px;background: #000000;position: absolute;right:10px;top:10px;font-size: 30px;color: #fff"><span class="glyphicon  glyphicon-remove" aria-hidden="true" ></span></button>
    </div>
</div>
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