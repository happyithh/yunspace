<!DOCTYPE html>
<!--[if IE 8]>
<html lang="en" class="ie8 no-js"><![endif]-->
<!--[if IE 9]>
<html lang="en" class="ie9 no-js"><![endif]-->
<!--[if !IE]><!-->
<html lang="en" class="no-js">
<!--<![endif]-->
<head>
    {include 'Web_User_Center::inc/html_head.tpl'}


</head>
<body>
{include 'Web_User_Center::inc/header_top.tpl'}

<div class="clearfix"></div>
<div class="page-container">
    {include 'inc/header_nav.tpl' index=2}
    <div class="page-content-wrapper">
        <div class="page-content" style="min-height:973px">
            <h3 class="page-title pull-left">
                消息中心
            </h3>
            {*<button class="btn btn-default pull-right" type="button" style="margin-left:10px;">*}
            {*消息设置*}
            {*</button>*}
            {*<button class="btn btn-default pull-right" type="button">*}
            {*通讯录*}
            {*</button>*}
            <div class="portlet">
                <div class="portlet-body util-btn-margin-bottom-5" style="height:50px;border-bottom:1px solid #e4e4e4">
                    <form action="" class="pull-left">
                        <div class="input-group input-medium">
                            <input type="text" class="form-control" placeholder="">
                                <span class="input-group-btn">
                                <button class="btn btn-info" type="button">
                                    <span class="glyphicon glyphicon-search"></span>
                                </button>
                                </span>
                        </div>
                    </form>
                </div>

                <div class="row">
                    <div class="col-md-12">

                        <div class="portlet" style="border:0px">
                            <div class="portlet-title">
                                <div class="caption">
                                    <i class="fa fa-comments"></i>系统消息
                                </div>
                            </div>
                            <div class="portlet-body">
                                <style>
                                    ul li {
                                        list-style: none;
                                    }

                                    .email_list {
                                        height: auto;
                                        overflow: hidden;
                                        margin-bottom: 30px;
                                    }

                                    .email_portrait {
                                    }

                                    .email_portrait img {
                                        width: 50px;
                                        height: 50px;
                                    }

                                    .email_body {
                                        background: #fcfcfc;
                                        margin-right: 0px;
                                    }

                                    .email_title {
                                        height: 40px;
                                        line-height: 40px;
                                        border-bottom: 1px solid #e7eff4;
                                        border-top: 1px solid #e7eff4;
                                        padding: 0 15px;
                                    }

                                    .email_content {
                                        font-size: 15px;
                                        padding: 0 15px;
                                        border-bottom: 1px solid #e7eff4;
                                    }

                                    @media (max-width: 560px) {
                                        .email_portrait img {
                                            width: 20px;
                                            height: 20px;
                                        }

                                </style>


                                <ul class="email row" style="padding-left: 0px;">

                                    {foreach $_data['rows'] as $v}
                                        <li class="email_list col-md-12">
                                            <div class="email_portrait pull-left" style="width: 10%;">
                                                <img src="images/avatar.jpg" alt="tuopian" class="email_portrait_img"/>
                                            </div>
                                            <div class="email_body pull-right" style="width: 90%;">
                                                <div class="email_title">
                                                    <p class="pull-left">{$v['vendor_name']}</p>

                                                    <p class="pull-right">
                                                        {date('Y-m-d H:i:s',$v['send_time'])}</p>
                                                </div>
                                                <div class="clearfix"></div>
                                                <div class="email_content">
                                                    <button class="btn btn-xs pull-right">
                                                        <i class="fa fa-times"></i>
                                                    </button>
                                                    <div class="clearfix"></div>
                                                    <p>
                                                        {$v['message']}</p>
                                                </div>
                                            </div>
                                        </li>
                                    {/foreach}
                                </ul>
                                <ul class="pagination">
                                    {if $_data['page']['dpll']}
                                        <li class="prev">
                                            <a href="{$_data['page']['dup']}1" title="First"><i class="fa fa-angle-double-left"></i></a>
                                        </li>
                                        <li class="prev">
                                            <a href="{$_data['page']['dup']}{$_data['page']['dp']-1}" title="Prev"><i class="fa fa-angle-left"></i></a>
                                        </li>
                                    {else}
                                        <li class="prev disabled">
                                            <a href="#" title="First"><i class="fa fa-angle-double-left"></i></a>
                                        </li>
                                        <li class="prev disabled">
                                            <a href="#" title="Prev"><i class="fa fa-angle-left"></i></a>
                                        </li>
                                    {/if}
                                    {for $i=$_data['page']['dpl'] to $_data['page']['dpr']}
                                        <li{if $i==$_data['page']['dp']} class="active"{/if}>
                                            <a href="{$_data['page']['dup']}{$i}">{$i}</a>
                                        </li>
                                    {/for}
                                    <li class="disabled">
                                        <a> {$_data['page']['dtp']}
                                            ( {$_data['page']['dp']*$_data['page']['dn']}
                                            /{$_data['page']['dt']}
                                            )</a></li>

                                    {if $_data['page']['dprr']}
                                        <li class="next">
                                            <a href="{$_data['page']['dup']}{$_data['page']['dp']+1}" title="Next"><i class="fa fa-angle-right"></i></a>
                                        </li>
                                        <li class="next">
                                            <a href="{$_data['page']['dup']}{$_data['page']['dtp']}" title="Last"><i class="fa fa-angle-double-right"></i></a>
                                        </li>
                                    {else}
                                        <li class="next disabled">
                                            <a href="#" title="Next"><i class="fa fa-angle-right"></i></a>
                                        </li>
                                        <li class="next disabled">
                                            <a href="#" title="Last"><i class="fa fa-angle-double-right"></i></a>
                                        </li>
                                    {/if}
                                </ul>
                            </div>
                        </div>
                    </div>

                </div>

            </div>

            <div class="clearfix">
            </div>
        </div>
    </div>

</div>
</div>
<div style="margin-top:50px;" class="mt50"></div>
{include file="Web_Static::v2.0/html_footer.tpl"}
{include 'inc/footer_script.tpl'}


</body>
</html>