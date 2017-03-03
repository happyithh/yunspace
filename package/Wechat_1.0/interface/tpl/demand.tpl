<!DOCTYPE html>
<html>
<head>
    {include file="Web::inc/html_head.tpl"}
    <meta name="viewport" content="width=divice-width,initial-scale=1"/>
    <link rel="stylesheet" type="text/css" href="css/css.css">
    <link rel="stylesheet" type="text/css" href="css/owl.carousel.css">
    <link rel="stylesheet" type="text/css" href="css/owl.theme.css">
    <script src="js/base.js"></script>
    <style>
        body{
            font-family:微软雅黑, microsoft yahei, Arial, sans-serif;
            background: #ededed;
        }
        ul{
            list-style: none;
            text-decoration: none;
        }
        ul li{
            list-style: none;
            text-decoration: none;
        }
        ul li a{
            text-decoration: none;
        }
        .main{

            width:100%;
            padding-left: 20px;
        }
        .header{
            width:100%;
            height:40px;
            background: #d5d5d5;
        }
        .near_market{
            line-height: 40px;
            text-align: center;
            font-weight: bold;
            font-size: 30px;
            color:#000000;
        }
        .near_market{
            line-height: 40px;
            text-align: center;
            font-weight: bold;
            font-size: 15px;
            color:#000000;
        }
        .left{
            float:left;
            width:20%;
            text-align: center;
            margin-top: 5px;
            font-size: 15px;
            line-height: 40px;
            border-right:1px solid #eaeaea;
        }
        .menu{
            float:right;
            width:20%;
            text-align: center;
            margin-top: 7px;
            font-size: 15px;
            line-height: 40px;
            border-left:1px solid #eaeaea;
        }
        .center{
            float:left;
            width:60%
        }
        .next{
            text-align: center;
        }
        .change{
            display: block;
            width:100%;
            line-height: 40px;
            text-align: center;
            font-size: 14px;
            color:#80a4d6;
        }
        .contents{
            width:100%;
            padding-right:30px ;
        }
        .activity-list{
            margin-top: 20px;
            margin-left:0px;
            padding-left:10px ;
        }
        .bar{
            margin-top:-7px;
            margin-right: 20px;
            margin-left: -12px;
        }
        .activity{
            display: block;
            width:100%;
            line-height:40px;
            margin-top: -15px;
            font-size: 25px;
            margin-bottom: 20px;
            color:#000000;
        }
        a:hover{
            text-decoration:none;
        }
        .activity-all{
            width:100%;
            padding-left:0px;
            border-radius: 3px;
            margin-right: 20px;
            margin-bottom: 20px;
            background: #ffffff;
            display: none;
        }
        .phone_input{
            width:100%;
            border:1px solid #dcdcdc;
            border-radius: 5px;
            padding:10px;
        }
        .activity-message{
            display: block;
            padding: 10px;
            padding-left: 30px;
            width:100%;
            font-size: 15px;;
            line-height: 20px;
            border-bottom: 1px solid #f4f4f4;
            color: #b3b3b3;
        }
        .activity-message:hover{
            text-decoration: none;
        }

        .select2-container--default .select2-selection--single{
            border: 1px solid #dcdcdc;
        }
        .footer{
            width:100%;
            height:50px;
            background: #f9f9f9;
            position:fixed;
            bottom:0px;
        }
    </style>
</head>
<body>
{include file="Web::inc/header_nav.tpl"}
<div class="header">

    <p class="near_market">我要办活动</p>

</div>
<form action="{$_route}add_demand">
    <div class="container" style="margin-top: 0px;margin-bottom: 10px;">

        <div style="margin-bottom: 20px;margin-top: 20px; " class="row">
            <div class="pull-left col-md-6 col-xs-12" style="margin-bottom: 10px;">
                <input type="text" class=" form-control" placeholder="请输入姓名" name="demand_name"/>
            </div>
            <div class="pull-left col-md-6 col-xs-12">
                <input type="text" class=" form-control" placeholder="请输入联系电话" name="phone"/>
            </div>
        </div>


        <div class="main">

            <div class="contents">
                <ul class="activity-list" style="background: url('{$_assets}images/line_03.jpg')repeat-y;">
                    <li>
                        <div class="bar pull-left"><img src="" alt=""/></div>
                        <div class="pull-left" style="width:90%">
                            <a href="javascript:;" class="activity">活动规模 &nbsp;<span></span></a>
                            <ul class="activity-all">
                                <li  class="activity-message "><label style="width:100%"><input type="radio" name="scope" class="pull-left scope" value="50以下"/>50以下</label></li>
                                <li class="activity-message "><label style="width:100%"><input type="radio"  name="scope"  class="pull-left scope" value="100-200"/>100-200</label></li>
                                <li class="activity-message "><label style="width:100%"><input type="radio"  name="scope" class="pull-left scope" value="200-300"/>200-300</label></li>
                                <li class="activity-message "><label style="width:100%"><input type="radio"  name="scope" class="pull-left scope" value="300-500"/>300-500</label></li>
                                <li class="activity-message "><label style="width:100%"><input type="radio"  name="scope" class="pull-left scope" value="1000以上"/>1000以上</label></li>
                            </ul>
                        </div>
                        <div class="clearfix"></div>
                    </li>
                    <li>
                        <div class="bar pull-left"><img src="" alt=""/></div>
                        <div class="pull-left" style="width:90%">
                            <a href="javascript:;" class="activity">活动日期 &nbsp;<span></span></a>
                            <div class="activity-all" style="background:none">
                                <input type="hidden" name="data[is_schedule]" value="1">
                                <div class="form-group che">
                                    <div class='input-group date' id='datetimepicker1'>
                                        <input type='text'  id='datetimepicker_input1' class="form-control" placeholder="请选择" name="date"/>
                                                    <span class="input-group-addon"><span class="glyphicon glyphicon-calendar"></span>
                                                        </span>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="clearfix"></div>
                    </li>
                    <li>
                        <div class="bar pull-left"><img src="" alt=""/></div>
                        <div class="pull-left" style="width:90%">
                            <a href="javascript:;" class="activity">活动类型 &nbsp;<span></span></a>
                            <ul class="activity-all">
                                {foreach $_data1 as $k=>$v}
                                    <li class="activity-message "><label style="width:100%"><input type="radio" name='demand_type' class="pull-lef type" value="{$v}"/>{$v}</label></li>
                                {/foreach}
                            </ul>
                        </div>
                        <div class="clearfix"></div>
                    </li>

                    <li>
                        <div class="bar pull-left"><img src="" alt=""/></div>
                        <div class="pull-left" style="width:90%">
                            <a href="javascript:;" class="activity">所属行业 &nbsp;<span></span></a>
                            <ul class="activity-all">
                                {foreach $_data2 as $k=>$v}
                                    <li class="activity-message "><label style="width:100%"><input type="radio" name='trade' class="pull-left trade" value="{$v}"/>{$v}</label></li>
                                {/foreach}
                            </ul>
                        </div>
                        <div class="clearfix"></div>
                    </li>
                    <li>
                        <div class="bar pull-left"><img src="" alt=""/></div>
                        <div class="pull-left" style="width:90%">
                            <a href="javascript:;" class="activity">配套服务 &nbsp;<span></span></a>
                            <ul class="activity-all">
                                {foreach $_data3 as $k=>$v}
                                    <li class="activity-message "><label style="width:100%"><input type="checkbox" name='services[]' class="pull-left services" value="{$v['id']}"/>{$v['category_name']}</label></li>
                                {/foreach}
                            </ul>
                        </div>
                        <div class="clearfix"></div>
                    </li>
                    <li>
                        <div class="bar pull-left"><img src="" alt=""/></div>
                        <div class="pull-left" style="width:90%">
                            <a href="javascript:;" class="activity">活动预算 &nbsp;<span></span></a>
                            <ul class="activity-all">
                                <li class="activity-message "><label style="width:100%"><input type="radio"  name="budget" class="pull-left budget" value="50以下"/>50以下</label></li>
                                <li class="activity-message "><label style="width:100%"><input type="radio"  name="budget" class="pull-left budget" value="100-200"/>100-200</label></li>
                                <li class="activity-message "><label style="width:100%"><input type="radio"  name="budget" class="pull-left budget" value="300-500"/>300-500</label></li>
                                <li class="activity-message "><label style="width:100%"><input type="radio"  name="budget" class="pull-left budget" value="500-1000"/>500-1000</label></li>
                                <li class="activity-message "><label style="width:100%"><input type="radio"  name="budget" class="pull-left budget" value="1000以上"/>1000以上</label></li>
                            </ul>
                        </div>
                        <div class="clearfix"></div>
                    </li>

                    <li>
                        <div class="bar pull-left"><img src="" alt=""/></div>
                        <div class="pull-left" style="width:90%">
                            <a href="javascript:;" class="activity">具体要求 &nbsp;<span></span></a>
                            <div class="activity-all" style="background:none">
                                <textarea name='demand' class="phone_input demand" placeholder="请填写具体要求"></textarea>
                            </div>
                        </div>
                        <div class="clearfix"></div>
                    </li>
                    <li style="display: none">
                        <div class="bar pull-left"><img src="" alt=""/></div>
                        <div class="pull-left" style="width:90%">
                            <a href="javascript:;" class="activity">城市 &nbsp;<span></span></a>
                            <div class="activity-all" style="background:none">
                                <input name='city' class="phone_input city" value=""></input>
                            </div>
                        </div>
                        <div class="clearfix"></div>
                    </li>
                </ul>
            </div>
            <div class="clearfix"></div>

        </div>

    </div>
    <div class="footer">
        <div class="left" style="border-right:1px solid #d6d6d6">
            <a href="" style="display: block;color:#80a4d6"><span class="glyphicon glyphicon-menu-left"></span></a>
        </div>
        <div class="center">
            <div class="next ">
                <span class=""></span>
                <button type="submit" style="border:0px;background: #f9f9f9;height: 50px;width:100%">提交需求</button>
            </div>
        </div>
        <div class="menu" style="border-left:1px solid #d6d6d6">
            <a href="" style="display: block;color:#80a4d6"><span class="glyphicon glyphicon-option-horizontal"></span></a>
        </div>
    </div>
</form>


<script type="text/javascript" src="js/jquery-1.9.1.min.js"></script>
<script type="text/javascript" src="js/moment.min.js"></script>

<script type="text/javascript" src="js/zh-cn.js"></script>
<script type="text/javascript" src="js/bootstrap-datetimepicker.min.js"></script>
<script type="text/javascript" src=' http://int.dpool.sina.com.cn/iplookup/iplookup.php?format=js'></script>

<script>
    $(document).ready(function(){
        $("input[name='city']").val(remote_ip_info['city']);
        $('.activity-list > li').click(function(){
            var index=$(this).index();
            $(this).find('a').next().slideDown();
            $('.activity-list > li').eq(index).siblings().find('a').next().slideUp();
            $('.activity').css('font-size','15px');
            $('.activity').css('color','#989898');
            if(index==0){
                var info=$("input[name='scope']:checked").val();
                $('.activity-list > li').first().find('.activity').find('span').text(info);
            }
            if(index==1){
                $("#datetimepicker_input1").blur(function() {
                    var date1=$('#datetimepicker_input1').val();
                    $('.activity-list > li').eq(1).find('.activity').find('span').text(date1);
                })
            }
            if(index==2){
                var info=$("input[name='demand_type']:checked").val();
                $('.activity-list > li').eq(2).find('.activity').find('span').text(info);
            }

            if(index==3){
                var info=$("input[name='trade']:checked").val();
                $('.activity-list > li').eq(3).find('.activity').find('span').text(info);
            }
            if(index==4){
                var info =[];
                $("input[name='services[]']:checked").each(function() {
                    info.push($(this).val());
                });
                $('.activity-list > li').eq(4).find('.activity').find('span').text(info);
            }
            if(index==5) {
                var info = $("input[name='budget']:checked").val();
                $('.activity-list > li').eq(5).find('.activity').find('span').text(info);
            }
            if(index==6){
                $('.demand').keyup(function() {
                    var demand=$(this).val();
                    $('.activity-list > li').eq(6).find('.activity').find('span').text(demand);
                })
            }
            $('.activity-list > li').eq(index).find('.activity').css('font-size','18px');
            $('.activity-list > li').eq(index).find('.activity').css('color','#000000');
            $('.activity-list > li').eq(index).siblings().find('.bar').css('margin-left','-12px');
            $('.activity-list > li').eq(index).find('.bar').css('margin-left','-14px');
            $('.activity-list > li').eq(index).siblings().find('.bar').find('img').attr('src','{$_assets}images/m1.png');
            $('.activity-list > li').eq(index).find('.bar').find('img').attr('src','{$_assets}images/m2.png');
        })
        $('.activity-all > li').hover(function(){
            $('.activity').css('text-decoration','none');
        },function(){

        });
        $('.activity-list').find('li').eq(0).trigger('click');
    })
</script>
<script type="text/javascript">
    $(document).ready(function () {
        $('#datetimepicker1').datetimepicker({
            format: 'YYYY-MM-DD',
            locale: 'zh-cn'
        });
        $('#datetimepicker_input1').datetimepicker({
            format: 'YYYY-MM-DD',
            locale: 'zh-cn'
        });

    });

</script>
</body>
</html>