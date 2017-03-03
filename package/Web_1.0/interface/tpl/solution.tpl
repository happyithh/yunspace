<!DOCTYPE html>
<html>
<head>
    {include file="inc/html_head.tpl"}
    <link rel="stylesheet" type="text/css" href="css/css.css">
    <link rel="stylesheet" type="text/css" href="css/owl.carousel.css">
    <link rel="stylesheet" type="text/css" href="css/owl.theme.css">
    <style>
        #banner{ width: 730px}
        .owl-theme .owl-controls{ bottom: 16px}
        .mb15{
            padding-top: 4px;;
        }
        @media (max-width: 1000px){
            .solution_left{ display: none}
        }
    </style>
</head>
<body>
{include file="inc/header_nav.tpl"}
<div class="content">
    <div class="solution_head_back">
        <div class="solution_head_outside container ">
            <div class="row">
                <div class="solution_left col-md-8" style="margin-left: -15px;">

                    <div id="banner" class="owl-carousel owl-theme fl">
                        <div class="item">
                            <a href="javascript:void(0)"><img class="lazyOwl" data-src="img/nh1.jpg" alt="年会1"></a>
                        </div>
                        <div class="item">
                            <a href="javascript:void(0)"><img class="lazyOwl" data-src="img/nh2.jpg" alt="年会2"></a>
                        </div>
                        <div class="item">
                            <a href="javascript:void(0)"><img class="lazyOwl" data-src="img/xc1.jpg" alt="秀场1"></a>
                        </div>
                        <div class="item">
                            <a href="javascript:void(0)"><img class="lazyOwl" data-src="img/xc2.jpg" alt="秀场2"></a>
                        </div>
                        <div class="item">
                            <a href="javascript:void(0)"><img class="lazyOwl" data-src="img/fbh3.jpg" alt="发布会3"></a>
                        </div>

                    </div>
                </div>
                <form action="{$_root}demand_submit/solution" method="post">

                        <div class="solution_right col-md-4" style="margin-right:15px;">
                            <div class="rf_t clearfix" style="height: 50px; font-size:24px;font-weight: bold; border-bottom: 1px solid #b3b3b3; text-align: center; ">
                                <span style="width: 100%; ">提交活动线索</span>
                            </div>
                            <div class="s_title mb15">
                                <div style="float: left; width: 33%;"> 提交人手机号码</div>
                                <div style="float:left; width: 67%;"> <input class="form-control screening" style="width: 100%; margin-left: 0px;" name="data[提交人手机号码]"></div>
                                <div class="clear"></div>
                            </div>
                            <div class="s_title mb15">
                                <div style="float: left; width: 33%;"> 活动类型</div>
                                <div style="float:left; width: 67%;"> <input class="form-control screening" style="width: 100%; margin-left: 0px;" name="data[活动类型]"></div>
                                <div class="clear"></div>
                            </div>

                            <div class="s_title">
                                <div style="float: left; width: 33%;">具体要求</div>
                                <div style="float:left; width: 67%;">
                                    <textarea class="form-control screening1" rows="5" style="width: 100%; margin-left: 0px;" name="data[具体要求]"></textarea>
                                </div>
                                <div class="clear"></div>
                            </div>
                            <div class="s_title mb15">
                                <div style="float: left; width: 33%;"> 联系人</div>
                                <div style="float:left; width: 67%;"> <input class="form-control screening" style="width: 100%; margin-left: 0px;" name="data[联系人]"></div>
                                <div class="clear"></div>
                            </div>

                            <div class="s_title mb15">
                                <div style="float: left; width: 33%;"> 联系人电话</div>
                                <div style="float:left; width: 67%;"> <input class="form-control screening" style="width: 100%; margin-left: 0px;" name="data[联系人电话]"></div>
                                <div class="clear"></div>
                            </div>

                            {*<div class="checkbox checkbox_solution">*}
                            {*<label><input type="checkbox" value="寻求场地" name="data[需求][]" checked="checked">寻求场地</label>*}
                            {*<label><input type="checkbox" value="配套服务" name="data[需求][]">配套服务</label>*}
                            {*</div>*}
                            <button type="submit" class="btn btn-solution">
                                提交需求
                            </button>
                        </div>
                    </form>
                    <div class="clear"></div>
                    <div class="clear"></div>
            </div>
        </div>
    </div>
    <div class="solution_process_p wrap">
        <img src="img/solution_pic.jpg" class="img-responsive">
    </div>
    <div class="wrap">
        <img src="img/e1.jpg" class="img-responsive" >
    </div>
</div>
<script type="text/javascript" src="js/owl.carousel.min.js"></script>
<script>
    $("#banner").owlCarousel({

        navigation: true, // Show next and prev buttons
        slideSpeed: 300,
        paginationSpeed: 400,
        singleItem: true,
        lazyLoad: true,
        autoPlay: 3000,
        navigationText:['上一个','下一个']

    });
</script>
<div style="margin-top:50px;" class="mt50"></div>
{include file="Web_Static::v2.0/html_footer.tpl"}
</body>
</html>