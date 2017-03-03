<!DOCTYPE>
<html>
  <head>
      {include file="Web_Mobile_Static::inc/header_meta.tpl"}
      <meta name="full-screen" content="yes" />
      <meta name="x5-fullscreen" content="true" />
    {*<!-- {static "comment/comment.css"} -->*}
    {static "v4.0/font-awesome.min.css"}
    {static "comment/comment_back.css"}
    {static "comment/comment-li.css"}
  </head>
  <body yun="comment.v4.0/comment.js::init">
  {*{var_dump($page->getCommentsReplyList)}*}
    <div class="content">
      <div class="person-comment-page">
          <div class="comment-li">
              <div class="comment-person-img"  id="tx-img">
                  {if !empty($page->getCommentsReplyList['info']['user_info']['headimgurl'])}
                  <img src="{$page->getCommentsReplyList['info']['user_info']['headimgurl']}" alt="">
                  {else}
                      <img src="img/comment/mtx_03.png" alt="">
                  {/if}
              </div>
              <div class="comment-message">
                  <div class="message-header clearfix">
                      <div class="message-name fl"  id="header-body-name"  data-space-id="{$page->info['id']}"><span>{$page->getCommentsReplyList['info']['user_info']['nickname']}</span></div>
                  </div>

                  <div class="message-time">
                      <span>{date('Y-m-d H:i:s',$page->getCommentsReplyList['info']['create_time'])}</span>
                  </div>

                  <div class="message-info">
                      <span>{$page->getCommentsReplyList['info']['content']}</span>
                  </div>
                  <div class="comment-article">
                  <a href="{$_home}site/{Func_Url::str_urlencode($page->info['space_name'])}-百科">
                    <div class="article-img">
                        {if !empty($page->info['mobile_logo'])}
                            <img src="{Page_Site_Global::displayMedia($page->info['mobile_logo'],80,65)}" alt="">
                        {elseif !empty($page->info['logo'])}

                            <img src="{Page_Site_Global::displayMedia($page->info['logo'],80,65)}" alt="">
                        {else}
                            <img src="{Page_Site_Global::displayMedia($page->info['media'][0]['path'],80,65)}" alt="">
                        {/if}
                      {*<img src="{Page_Site_Global::displayMedia($page->info['logo'],80,65)}" alt="">*}
                    </div>
                    <div class="article-title">
                      <span>{$page->info['space_name']}</span>
                    </div>
                  </a>
                </div>

            </div>
        </div>
      </div>
    {if $page->getBaikeLikeList}
      <div class="zan-persons">
          {foreach $page->getBaikeLikeList as $k=>$v}
              {*{var_dump($v)}*}
              {if !empty($v['headimgurl'])}
                  <img src="{$v['headimgurl']}" alt="">
              {else}
                  <img src="img/comment/mtx_03.png" alt="">
              {/if}
         {/foreach}
          <div class="more-person">
            <span class="fa fa-angle-right"></span>
          </div>
      </div>
        {/if}
      <div class="back-list">
        <div class="back-list-header">
          <header>评论</header>
          <div class="line"></div>
        </div>
        <div class="comment-list">
            {include file="Web_Mobile_Static::comment/inc.comment_li.tpl"}
        </div>
      </div>

    </div>
    {*{var_dump($page->getCommentsReplyList)}*}
{*{var_dump($page->getCommentsReplyList['info'])}*}
    <footer class="back-form">
      <div class="back-input" data-comments-id="{$page->getCommentsReplyList['info']['id']}" data-parent-id="{$page->getCommentsReplyList['info']['account_id']}">
        <input class="" type="text" value="" id="comment-content">
        <button id="comment-submit" data-id="{$page->getCommentsReplyList["info"]['id']}">回复</button>
      </div>
    </footer>
    <div id="clone-comment" class="none">
        <div class="comment-li" data-space="" data-href="{$_home}site/">
            <div class="comment-person-img">
                <img src="" alt="">
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
  {static "core/yunspace.js"}
  </body>
</html>
