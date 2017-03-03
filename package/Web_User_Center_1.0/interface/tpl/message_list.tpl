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
        .chats li.out .message{ width: 40%; float: right; margin-right: 10px;}
        .chats li.in .message{ width: 40%;}
        .scroller{ padding-right: 0px;}
        .chats{ margin-right: 0px;}
        @media (max-width: 1024px) {
            .chats li.out .message{ width: auto; float: none; margin-right: 65px;}
            .chats li.in .message{ width: auto;}
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
                <div class="portlet-body">
                    <div class="portlet-body" id="chats" style="margin-bottom: 50px;">
                        <div class="chat-form" style="margin-bottom: 50px;">
                            <div class="input-cont" style="margin-right: 0px;">
                                <textarea rows="4" class="form-control message" placeholder="输入回复内容" type="text"></textarea>
                            </div>
                            <button type="submit" class="btn btn-primary send" style="margin-top: 10px;">
                                发送
                            </button>
                        </div>

                        <div class="scroller">
                            <ul class="chats">
                                {foreach $data as $v}
                                    {if $v['from_account_id'] == $_REQUEST['from_id']}
                                        <li class="out">
                                            <img class="avatar img-responsive" alt="" src="{$_root}user_center/avatar/{$v['from_account_id']}.jpg">
                                            <div class="message">
                                                        <span class="arrow">
                                                        </span>
                                                <a href="index.html#" class="name">{$v['username']}</a>
                                                        <span class="body" style="word-break: break-all; font-family: '微软雅黑', 'microsoft yahei', Arial, sans-serif; font-weight: bold; font-size: 20px; line-height: 26px;">
                                                        {$v['message']}</span>
                                                            <span class="datetime">
                                                        {$v['send_time']}</span>
                                            </div>
                                        </li>
                                        <div class="clearfix"></div>
                                    {else}
                                        <li class="in">
                                            <img class="avatar img-responsive" alt="" src="{$_root}user_center/avatar/{$v['from_account_id']}.jpg">
                                            <div class="message">
                                                        <span class="arrow">
                                                        </span>
                                                <a href="index.html#" class="name">{$session['username']}</a>
                                                        <span class="body " style=" word-break: break-all;font-family: '微软雅黑', 'microsoft yahei', Arial, sans-serif;font-weight:bold;font-size: 20px;">
                                                        {$v['message']}</span>
                                                            <span class="datetime">
                                                        {$v['send_time']}</span>
                                            </div>
                                        </li>
                                        <div class="clearfix"></div>
                                    {/if}
                                {/foreach}
                            </ul>
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
{include 'inc/html_footer.tpl'}
{include 'inc/footer_script.tpl'}

<script>
    $(document).ready(function(){
        $('.send').click(function(){
            var message=$('.message').val();
            if(message!=''){
                $.ajax({
                    type:'post',
                    url:'{$_route}send_message?to_id={$from_id}',
                    data:{
                        message:message
                    },
                    dataType:'json',
                    success:function(data){
                        if(data['code']=='success'){
                            $('.message').val('');
                            $('.chats').prepend(data['content']);
                        }else{
                            alert('发送失败！！');
                        }
                    }
                })
            }else{
                alert('发送的信息不能为空！！');
            }
        })

    })
</script>
</body>
</html>