<!DOCTYPE html>
<html>
<head>
    {include file="Web_Static::v2.0/html_head.tpl"}
    <link rel="stylesheet" type="text/css" href="css/v2.0/common.css">
    {*<link rel="stylesheet" type="text/css" href="css/raiders/library-info.css">*}
    <link rel="stylesheet" href="{$_root}yun/plugins/comment/css/comment.css"/>

    <link rel="stylesheet" href="{$_root}yun/plugins/comment/css/bootstrap.min.css"/>

    <link rel="stylesheet" href="{$_root}yun/plugins/comment/css/ionicons.min.css"/>
    {static "/v1.0/global.css"}
    {static "raiders/library-info.css"}
    {*<link rel="stylesheet" href="css/v1.0/global.css"/>*}

    {*<script src="{$_root}yun/plugins/comment/js/comment.js"></script>*}
    {*<script src="{$_root}yun/plugins/comment/js/yunspace.js"></script>*}
</head>

<body  yun="find.v3.0/find-right.js::init">
{include file="Web_Static::v2.0/html_header3.1.tpl"}
<div class="containers">
    <p class="locate"><a href="{$root}">首页</a>&nbsp;>&nbsp;<a href="{$root}/raiders/">云发现</a>
        &nbsp;>&nbsp;<a
                href="{$root}/raiders/{$page->getRaidersDetail['category_id']}">{$page->getRaidersDetail['category_name']}</a>
        &nbsp;>&nbsp;
        <a href="#">{$page->getRaidersDetail['title']}</a></p>
<div class="raiders-info-title">
    <div class="document_icon"> {if $page->getRaidersDetail['match'][1][0] == 'rar'|| $page->getRaidersDetail['match'][1][0] == 'zip'}

            <img src="img/find.v3.0/rar_icon.png">
        {elseif $page->getRaidersDetail['match'][1][0] == 'pdf'}
            <img src="img/find.v3.0/pdf_icon.png">
        {elseif $page->getRaidersDetail['match'][1][0] == 'png'}
            <img src="img/find.v3.0/png_icon.png">
        {elseif $page->getRaidersDetail['match'][1][0] == 'txt' || $page->getRaidersDetail['match'][1][0] == 'TXT'}
            <img src="img/find.v3.0/txt_icon.png">
        {elseif $page->getRaidersDetail['match'][1][0] == 'docx' || $page->getRaidersDetail['match'][1][0] == 'doc'}
            <img src="img/find.v3.0/word_icon.png">
        {elseif $page->getRaidersDetail['match'][1][0] == 'pptx' || $page->getRaidersDetail['match'][1][0] == 'ppt'}
            <img src="img/find.v3.0/wps_icon.png">
        {elseif $page->getRaidersDetail['match'][1][0] == 'xlsx' || $page->getRaidersDetail['match'][1][0] == 'xls'}
            <img src="img/find.v3.0/excel_icon.png">
        {/if}</div>
    <div class="document_title">{$page->getRaidersDetail['title']}</div>
    <div class="clear"></div>
</div>
<div class="library_classify">文档分类：<span>{$page->getRaidersDetail['category_name']}</span></div>
<div class="raiders-info-left">

    <div class="document">

        <div class="document_abstract2">
            {$page->getRaidersDetail['cont']}
        </div>
        <div class="document_download">
            {if $page->getRaidersDetail['accessory']}
            <div class="document_download_btn accessory" style="cursor:pointer" id="accessory" data-id="{$page->getRaidersDetail['id']}">

              <span class="fa fa-file"></span> 下载/预览
                    {*<a href="{Core::$urls['hosts']}{$page->getRaidersDetail['accessory']['name']}"
                       target="_blank" id="accessory" data-id="{$page->getRaidersDetail['id']}"><span class="fa fa-file" ></span> 下载/预览</a>*}
                  {*  <input type="hidden" name="accessory"
                           value="{$page->getRaidersDetail['accessory']['name']}">*}
            </div>
            <p class="document_info">文件大小：{round(($page->getRaidersDetail['accessory']['size'])/1024)}KB</p>
            <p class="document_info" >下载次数：{$page->getRaidersDetail['download']}</p>
            {/if}

            <div class="zan-click" yun="find.v3.0/find-right.js::zanAdd@click" data-title_id="{$page->getRaidersDetail['id']}">
                <div class="zan-img">
                    <img src="img/find.v3.0/hand1.png" alt="">
                    <img src="img/find.v3.0/hand2.png" alt=""  class="none">
                </div>
                <div class="zan-num">{$page->getRaidersDetail['counter_praise']}</div>
            </div>
        </div>
        <div class="clear"></div>
    </div>
    {*<div class="raiders-info-share">*}
        {*<div class="raiders-info-share-left">*}

            {*<div class="raider-info-share-text">*}
                {*分享：*}
            {*</div>*}
            {*<div class="raider-info-share-icon">*}
                {*{literal}*}
                    {*<div class="bdsharebuttonbox"><a href="#" class="bds_more" data-cmd="more"></a><a href="#" class="bds_qzone" data-cmd="qzone" title="分享到QQ空间"></a><a href="#" class="bds_tsina" data-cmd="tsina" title="分享到新浪微博"></a><a href="#" class="bds_tqq" data-cmd="tqq" title="分享到腾讯微博"></a><a href="#" class="bds_renren" data-cmd="renren" title="分享到人人网"></a><a href="#" class="bds_weixin" data-cmd="weixin" title="分享到微信"></a></div>*}
                    {*<script>window._bd_share_config={"common":{"bdSnsKey":{},"bdText":"","bdMini":"2","bdMiniList":false,"bdPic":"","bdStyle":"0","bdSize":"32"},"share":{},"image":{"viewList":["qzone","tsina","tqq","renren","weixin"],"viewText":"分享到：","viewSize":"16"},"selectShare":{"bdContainerClass":null,"bdSelectMiniList":["qzone","tsina","tqq","renren","weixin"]}};with(document)0[(getElementsByTagName('head')[0]||body).appendChild(createElement('script')).src='http://bdimg.share.baidu.com/static/api/js/share.js?v=89860593.js?cdnversion='+~(-new Date()/36e5)];</script>  {/literal}*}
            {*</div>*}
            <div class="info-share">
                <div class="share-add" yun="find.v3.0/find-right.js::shareAdd@click">
                    <span class="ion-android-add"></span>
                </div>
                <div class="code-weixin">
                    <div class="code-weixin-img">
                        {*<img src="" alt="">*}
                    </div>
                    <div class="code-weixin-p">
                        扫一扫二维码即可分享本文章
                    </div>
                </div>
                <ul class="share-img bdsharebuttonbox" data-tag="share_1">
                    <li>
                        <a  href="javascript:;"  class="share-weixin">
                            <img src="img/find.v3.0/iconfont-weixin.png" alt="">
                        </a>

                    </li>
                    <li>
                        <a href="http://connect.qq.com/widget/shareqq/index.html?url=" class="share-link">
                            <img src="img/find.v3.0/iconfont-qq.png" alt="">
                        </a>

                    </li>
                    <li>
                        <a href="http://share.baidu.com/s?type=text&searchPic=1&sign=on&to=tsina&url=" class="share-link">
                            <img src="img/find.v3.0/iconfont-xinlang.png" alt="">
                        </a>
                    </li>
                    <li>
                        <a href="http://share.baidu.com/s?type=text&searchPic=0&sign=on&to=renren&url=" class="share-link">
                            <img src="img/find.v3.0/iconfont-renren.png" alt="">
                        </a>
                    </li>
                    <li>
                        <a href="http://share.baidu.com/s?type=text&searchPic=0&sign=on&to=twi&url=" class="share-link">
                            <img src="img/find.v3.0/iconfont-twitter.png" alt="">
                        </a>
                    </li>
                    <li>
                        <a href="http://share.baidu.com/s?type=text&searchPic=0&sign=on&to=douban&url=" class="share-link">
                            <img src="img/find.v3.0/iconfont-doubanc.png" alt="">
                        </a>
                    </li>
                </ul>
                <span>分享到</span>
            </div>




        {*</div>*}
        {*<div class="raiders-info-share-right">*}
            {*<div class="comment-chat">*}
                {*<a href="javascript:;" yun="comment/js/comment.js::wow@click" class="js-wow">*}
                    {*<span {if $page->getRaidersDetail['counter_praise']>0}class="glyphicon glyphicon-thumbs-up wow-1 wow-active"{else}class="glyphicon glyphicon-thumbs-up wow-1"{/if}}"></span>*}
                {*</a>*}
                {*<p class="wow-num-1" style="margin-top: 3px;" title_id="{$page->getRaidersDetail['id']}" {if empty($page->getPraise['praise']) || $page->getPraise['praise']==0}praise="0"{else}praise="1"{/if}}">{$page->getRaidersDetail['counter_praise']}</p>*}
            {*</div>*}
        {*</div>*}
        <div class="clear"></div>
    {*</div>*}

    {*<div class="comment">*}
        {*<div class="comment-title">*}
            {*精彩评论*}
        {*</div>*}
        {*<div class="comment-content">*}
            {*<div class="comment-pic">*}
                {*{if $page->getPhoto['avatar']}*}
                    {*<img id="photo" src="{$page->getPhoto['avatar']}">*}
                {*{else}*}
                    {*<img id="photo" src="img/raiders-info/tx1.jpg">*}
                {*{/if}*}
            {*</div>*}
            {*<div class="comment-back-input">*}
                {*<input type="text" class="comment-back-input-content">*}
            {*</div>*}
            {*<a href="javascript:;" yun="comment/js/comment.js::comment@click" class="call-back-submit" user_id="{$__user['id']}" from_type="1" parent_id="" from_id={$page->id}>评论</a>*}

            {*<div class="clear"></div>*}
        {*</div>*}
        {*<ul class="comment-list">*}
            {*{foreach $page->getCommentList['rows'] as $c}*}
                {*<li>*}
                    {*<div class="comment-slide">*}
                        {*<div class="comment-img">*}
                            {*{if $c['avatar']}*}
                                {*<img title="头像" src="{Page_Site_Global::displayMedia($c['avatar'],'50','50')}">*}
                            {*{else}*}
                                {*<img src="img/chat.v1.0/lufei.jpg" alt=""/>*}
                            {*{/if}*}
                        {*</div>*}
                    {*</div>*}
                    {*<div class="comment-body">*}
                        {*<div class="comment-head clearfix" >*}
                            {*<div class="comment-person">*}
                                {*{$c['fullname']}*}
                            {*</div>*}
                            {*<div class="comment-time">*}
                                {*{Date('Y-m-d H:i:s',$c['create_time'])}*}
                            {*</div>*}
                        {*</div>*}

                        {*<div class="comment-content">*}
                            {*<p>{$c['cont']}</p>*}
                        {*</div>*}
                        {*<div class="comment-chat">*}
                            {*<a href="javascript:;"  yun="comment/js/comment.js::wowComment@click">*}
                                {*<span {if in_array({$c['id']},$page->getCommentpraise)}class="glyphicon glyphicon-thumbs-up wow-2 wow-active"{else}class="glyphicon glyphicon-thumbs-up wow-2"{/if}></span>*}
                                {*<p class="wow-num-2" comment_id="{$c['id']}" {if in_array({$c['id']},$page->getCommentpraise)}comment-praise="1"{else}comment-praise="0"{/if}>{$c['count_praise']}</p>*}
                            {*</a>*}
                        {*</div>*}
                        {*<div class="comment-back">*}
                            {*<div class="comment-back-input">*}
                                {*<input type="text" class="comment-back-input-content"/>*}
                            {*</div>*}
                            {*<div class="call-submit clearfix">*}
                                {*<a href="javascript:;"  yun="comment/js/comment.js::callBackWithComment@click"  class="call-back-submit js-call1" data-username="{$c['fullname']}" user_id="{$__user['id']}" from_type="1" parent_id="{$c['id']}" from_id={$page->id}>回复</a>*}
                            {*</div>*}
                        {*</div>*}
                    {*</div>*}
                {*</li>*}
            {*{/foreach}*}
        {*</ul>*}
        {*{if $page->getCommentList['page']['dt'] !=0}*}
            {*<div class="pagers">*}
                {*{if $page->getCommentList['page']['dpll']}*}
                    {*<a href="{$page->getCommentList['page']['dup']}1" title="First">第一页</a>*}
                    {*<a href="{$page->getCommentList['page']['dup']}{$page->getCommentList['page']['dp']-1}"*}
                       {*title="Prev">上一页</a>*}
                {*{else}*}
                    {*<a href="" class="prev first gray"><span>&laquo;&nbsp;</span>第一页</a>*}
                    {*<a href="" class="prev gray">&lt;&nbsp;上一页</a>*}
                {*{/if}*}
                {*{for $i=$page->getCommentList['page']['dpl'] to $page->getCommentList['page']['dpr']}*}
                    {*<a href="{$page->getCommentList['page']['dup']}{$i}"{if $i==$page->getCommentList['page']['dp']} class="active"{/if}>{$i}</a>*}
                {*{/for}*}

                {*{if $page->getCommentList['page']['dprr']}*}
                    {*<a href="{$page->getCommentList['page']['dup']}{$page->getCommentList['page']['dp']+1}"*}
                       {*title="Next">下一页</a>*}
                    {*<a href="{$page->getCommentList['page']['dup']}{$page->getCommentList['page']['dtp']}"*}
                       {*title="Last">最后页</a>*}
                {*{else}*}
                    {*<a href="" class="next gray">下一页&nbsp;&gt;</a>*}
                    {*<a href="" class="next last gray">最后页<span>&nbsp;&raquo;</span></a>*}
                {*{/if}*}
            {*</div>*}
        {*{else}*}
            {*<div class=" fl clearfix " style="width:930px;text-align: center;">*}
                {*来抢沙发哦~~*}
            {*</div>*}
        {*{/if}*}
    {*</div>*}
    <div class="clear"></div>
</div>
<div class="raiders-info-right">
    <div class="groom_document">
        相关文档推荐
    </div>
    <div class="groom_content">
        {foreach $page->guessaccessory  as $val}
        <div class="groom_list1">
            <div class="groom_icon">
                {if $val['match'][1][0] == 'rar'}

                    <img src="img/raiders_list/rar_icon.png">
                {elseif $val['match'][1][0] == 'pdf'}
                    <img src="img/raiders_list/pdf_icon.png">
                {elseif $val['match'][1][0] == 'png'}
                    <img src="img/raiders_list/png_icon.png">
                {elseif $val['match'][1][0] == 'txt' || $val['match'][1][0] == 'TXT'}
                    <img src="img/raiders_list/txt_icon.png">
                {elseif $val['match'][1][0] == 'docx' || $val['match'][1][0] == 'doc'}
                    <img src="img/raiders_list/word_icon.png">
                {elseif $val['match'][1][0] == 'pptx' || $val['match'][1][0] == 'ppt'}
                    <img src="img/raiders_list/wps_icon.png">
                {elseif $val['match'][1][0] == 'xlsx' || $val['match'][1][0] == 'xls'}
                    <img src="img/raiders_list/excel_icon.png">
                {/if}
            </div>
            <div class="groom_title">
                <a href="{$_root}raiders-info/{$val['id']}.html">{$val['title']}</a>
            </div>
            <div class="clear"></div>
        </div>
        {/foreach}

    </div>

</div>
<div class="clear"></div>
</div>
{*{static "js/comment.js"}*}
{include file="Web_Static::v2.0/form.tpl"}
{include file="Web_Static::v2.0/html_footer.tpl"}
{static "core/yunspace.js"}
{include "Web_Static::v2.0/html_tj.tpl"}
</body>
<script>
    $(document).ready(function () {
        $(".accessory").click(function(){

            var id = $(this).data('id');
            YunSpace.api('raiders/download.jsonp', {
                id:id
            },function (data) {
               if(data.status == 1){
                   window.location.href="{Core::$urls['hosts']}{$page->getRaidersDetail['accessory']['name']}";
               }else{
                   top.alert(data.msg);
               }
            });

        });
    });
</script>
</html>