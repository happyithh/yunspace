<!DOCTYPE html>
<!--[if IE 8]>
<html lang="en" class="ie8 no-js"><![endif]-->
<!--[if IE 9]>
<html lang="en" class="ie9 no-js"><![endif]-->
<!--[if !IE]><!-->
<html lang="en" class="no-js">
<!--<![endif]-->
<head>
    {if Core::$package['name']=='Web_Vendor_Center'}
        {include 'Web_User_Center::inc/html_head.tpl' theme='blue'}
    {else}
        {include 'Web_User_Center::inc/html_head.tpl'}
    {/if}
    <style>
        .message_left{ float: left; width: 7%; margin-top: 5px;}
        .message_right{ float: left; width: 88%;}
        .clear{ clear: both;}
        .message_id{ color:#31708F; float:left;}
        .message_date{ color: #999; float:left; margin-left: 10px;}
        .message_button{ float:right}
        .message_content{ color:#333; margin-top: 10px;}
        .message_left img{ height: 50px; width:50px; border:1px solid #666;}
        .m1{ background-color: #ecf6fb; border: solid 1px #d0eff5;}
        .m1:hover{ background-color: #D9EDF7; border: solid 1px #BCE8F1;}
        .mail_button{ font-size: 13px; padding: 3px 6px;}
        .padge{ padding: 3px 6px 3px 5px}
        @media (max-width: 1024px){
            .message_left img{ height: 20px; width:20px; border:1px solid #666;}
        }

    </style>

</head>
<body>
{if Core::$package['name']=='Web_Vendor_Center'}
    {include 'Web_User_Center::inc/header_top.tpl' color='#0b679e'}
{else}
    {include 'Web_User_Center::inc/header_top.tpl'}
{/if}

<div class="clearfix"></div>
<div class="page-container">
    {if Core::$package['name']=='Web_Vendor_Center'}
        {include 'Web_Vendor_Center::inc/header_nav.tpl'}
    {else}
        {include 'inc/header_nav.tpl'}
    {/if}
    <div class="page-content-wrapper">
        <div class="page-content" style="min-height:973px">
            <h3 class="page-title pull-left">
                消息中心
            </h3>

            <div class="portlet">
                <div class="portlet-title util-btn-margin-bottom-5" style="height:50px;border-bottom:1px solid #e4e4e4">
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

                <div class="portlet-body">
                    <div class="row">
                        <div class="col-md-12">

                            {foreach $_data['rows'] as $v}
                                <a href="message_list?from_id={$v['id']}">
                                    <div class="alert alert-block alert-info fade in m1">
                                        <div class="message_left">
                                            <img src="{$_root}user_center/avatar/{$v['id']}.jpg">
                                        </div>
                                        <div class="message_right">
                                            <div class="message_button">
                                                <button type="button" class="close" data-dismiss="alert"></button>
                                            </div>
                                            <a href="message_list?from_id={$v['id']}">
                                                <div class="message_id">{$v['username']}</div>
                                                <div class="message_date">{Func_Time::format($v['send_time'])}</div>
                                                <div class="clear"></div>
                                                <p class="message_content">
                                                    {if $v['c'] neq '0'}
                                                        <span class="badge padge">
                                                        未读消息 {$v['c']}</span>
                                                    {else}
                                                        所有消息已读
                                                    {/if}
                                                </p>
                                            </a>
                                        </div>
                                        <div class="clear"></div>
                                    </div>
                                </a>
                            {/foreach}

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
                                        {if $_data['page']['dt'] == 0}
                                            ( 0/{$_data['page']['dt']} )
                                        {else}
                                            ({( $_data['page']['dp']-1)*$_data['page']['dn']+1}/{$_data['page']['dt']} )
                                        {/if}
                                    </a>
                                </li>

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
                <div class="clearfix">
                </div>
            </div>
        </div>
    </div>
</div>
{*<div style="margin-top:50px;" class="mt50"></div>*}
{include file="Web_Static::v2.0/html_footer.tpl"}
{include 'inc/footer_script.tpl'}


</body>
</html>