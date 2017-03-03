<!DOCTYPE>
<html xmlns="http://www.w3.org/1999/html">
<head>
    {include file="Web_Static::v4.0/html_goto_pc.tpl" url="site/{Func_Url::str_urlencode($page->info['space_name'])}-{Func_Url::str_urlencode('讨论组')}"}
    {include file="Web_Mobile_Static::inc/header_meta.tpl"}
    <meta name="full-screen" content="yes" />
    <meta name="x5-fullscreen" content="true" />
    {static "comment/comment.css"}
    {static "v4.0/font-awesome.min.css"}
</head>
<body yun="comment.v4.0/comment.js::init">
{include "Web_Mobile_Static::v1.0/inc.nav.tpl"}
{*{var_dump($page->info)}*}

<div class="content">
    <header class="person-page-header">
        <div class="header-body">
            <div class="person-page-bg">
                <div class="img">
                    {if !empty($page->info['mobile_logo'])}
                    <img src="{Page_Site_Global::displayMedia($page->info['mobile_logo'],'1024','')}" alt="">
                    {elseif !empty($page->info['logo'])}
                    <img src="{Page_Site_Global::displayMedia($page->info['logo'],'1024','')}" alt="">
                    {else}
                    <img src="{Page_Site_Global::displayMedia($page->info['media'][0]['path'],'1024','')}" alt="">
                    {/if}
                </div>
            </div>
            {*****百科ID*******}
            <div class="none"><span data-space-id="{$baike->info['id']}"></span></div>

            <div class="header-cover">
                {include file="Web_Mobile_Static::site/inc/nav.tpl"}
                <div class="header-body-tx">
                    <div class="tx-img" id="tx-img">

                        {if !empty($page->getAccountInfo['user_info']['headimgurl'])}
                            <img class="new_tx-img" src="{$page->getAccountInfo['user_info']['headimgurl']}" alt="">
                        {else}
                            <img class="new_tx-img" src="img/comment/mtx_03.png" alt="">
                        {/if}
                    </div>
                </div>

                {*已登陆*}

                <div class="not-login">

                    <div class="header-body-name"  data-space-id="{$page->info['id']}" data-account-id="{$user_info['account_id']}" id="header-body-name">
                        <span>{$page->getAccountInfo['user_info']['nickname']}</span>
                    </div>
                    <div class="header-body-like">
                            <img src="img/comment/heart.png" alt="">

                    </div>
                    <div class="like-name">
                        <span>{$page->info['space_name']}</span>
                    </div>
                    {if $isLogin==1}
                    <div class="like-des-input j-input comment-input">
                        <div class="clear-input none" style="right:20px;"><span class="fa fa-times"></span></div>
                        <input type="text" class="new_content" placeholder="说点什么。。。" id="comment-content" data-error="评论内容不能为空">
                    </div>
                    <div class="like-des-button">
                        <button id="comment-submit">提交</button>
                    </div>
                </div>
                {else}
                {*未登录*}
                <form action="{$page->info['space_name']}-讨论组-login" method="post">
                    <input type="hidden" name="url_back" value="{Core::$urls['action']}">
                    <div class="is-login" data-validate="true">
                        <div class="like-des-input login-input j-input">
                            <div class="clear-input none"><span class="fa fa-times"></span></div>
                            <input type="text" placeholder="手机号码" class="login-phone"
                                   yun="form-validate/form-validate.js::typeValidate@keyup" data-error="请填写11位的手机号码" data-length="11"
                                   yun-type="phone"  yun-error="" data-validate="true" name="phone"
                                   yun-style="fontSize:18px,position:absolute,right:7px,top:0px,line-height:34px,color:#ff0000">
                        </div>
                        <div class="get-code clearfix">
                            <div class="like-des-input login-input login-code j-input">
                                <div class="clear-input none"><span class="fa fa-times"></span></div>
                                <input type="text" placeholder="验证码" data-error="请填写正确的验证码" id="code-input"
                                      name="auth_code" data-validate="true" yun-type="code" yun-phone=".login-phone"  yun="form-validate/form-validate.js::typeValidate@keyup" data-length="6">
                            </div>
                            <span  class="send-code"  yun-phone=".login-phone" yun="identify-code.v1.0/identify-code.v1.0.js::sendCode@click">
                                发送验证码
                            </span>
                        </div>

                        <div class="like-des-button">
                            <button yun="form-validate/form-validate.js::ajaxSubmit@click" id="comment-login"
                                    yun-url="" yun-ajax="is_login"
                                    yun-form=".is-login" data-id="0" data-year_id="0" data-ticket_number="" data-year_title="" yun-error=".show-error">提交</button>
                        </div>
                    </div>
                </form>
                {/if}
            </div>

        </div>
    </header>

    <div class="zan clearfix">
        <div class="zan-who fl">
            <ul class="zan-who-list clearfix">
                {foreach $like_list as $k=>$v}
                <li>
                    {if !empty($v['headimgurl'])}
                        <img src="{$v['headimgurl']}" alt="">
                    {else}
                        <img src="img/comment/mtx_03.png" alt="">
                    {/if}
                </li>
                {/foreach}
            </ul>
        </div>
        <div class="zan-num fl">
            {*{var_dump($page->getBaikeLove)}*}
            <span>{$count_num['is_love']}</span>
        </div>
        <!-- <div class="zan-icon fl">
            <span class="fa fa-thumbs-o-up"></span>
        </div> -->
        <div class="back-num">
            <span>{if $page->getBaikeCommentsList}{count($page->getBaikeCommentsList)}{else}0{/if}条评论</span>
        </div>
    </div>

    <div class="comment-list">
        {*<span class="new_comments hidden">*}
        {*{include file="Web_Mobile_Static::site/inc/inc.comment_li_new.tpl"}*}
        {*</span>*}

        {include file="Web_Mobile_Static::site/inc/inc.comment_li.tpl"}
    </div>
    <div class="comment-error"></div>
    <div class="load-more-comment" id="load-more-comment">
        {if count($page->getBaikeCommentsList)<10}
        没有更多数据
        {else}
        加载更多...
        {/if}
        {******         加载更多接口说明
                    参数：dp 加载第一次的时候dp=2 ,加载n次的时候为 dp=n+2
                    接口路径：{$_home}site/{Func_Url::str_urlencode($page->spaceName)}-{$page->baikeAction}?dp=2
            **********}
    </div>
    <div id="clone-comment" class="none">
        <div class="comment-li update" data-space="{Func_Url::str_urlencode($page->spaceName)}" data-href="{$_home}site/">
            <div class="comment-person-img">
                <img src="img/comment/mtx_03.png" alt="">
            </div>
            <div class="comment-message">
                <div class="message-header clearfix">
                    <div class="message-name fl"><span></span></div>
                    <div class="message-right clearfix fr">
                        <div class="message-back fr none1">
                            <a href="">
                                <span class="fa fa-commenting-o"></span>
                                <span></span>
                            </a>
                        </div>
                        <div class="message-zan fr">
                            <a href="javascript:;" data-id="">
                                <span class="fa fa-thumbs-o-up"></span>
                                <span></span>
                            </a>
                        </div>
                    </div>
                </div>

                <div class="message-time">
                    <span></span>
                </div>

                <div class="message-info">
                    <span></span>
                </div>
            </div>
        </div>
    </div>
</div>
{*{static 'submit_reply/submit_reply.js'}*}
{static "core/yunspace.js"}
</body>
</html>
