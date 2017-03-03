<!DOCTYPE>
<html>
  <head>
    {include file="Web_Mobile_Static::inc/header_meta.tpl"}
    <meta name="full-screen" content="yes" />
    <meta name="x5-fullscreen" content="true" />
    {static "v4.0/common.css"}
    {static "comment/comment.css"}
    {static "v4.0/font-awesome.min.css"}
  </head>
  <body yun="comment.v4.0/comment.js::init">

    <div class="content">
    <header class="person-page-header">
      <div class="header-body">
        <div class="person-page-bg">
          <img src="img/comment/bg_01.jpg" alt="">
        </div>
        <div class="header-cover">
          <div class="header-body-keys">
            <ul class="header-body-keys-list clearfix">
              <li>
                <a href="#" class="header-body-key-active">最新</a>
              </li>
              <li class="keys-line"><div></div></li>
              <li>
                <a href="">精华</a>
              </li>
              <li class="keys-line"><div></div></li>
              <li>
                <a href="">百科词条</a>
              <li>
              <li class="keys-line"><div></div></li>
              <li>
                <a href="">讨论组</a>
              </li>
            </ul>
          </div>


          <div class="header-body-tx">
            <div class="tx-img">
              <img src="img/comment/mtx_03.png" alt="">
            </div>
          </div>
          {*已登陆*}
          <div class="not-login">
            <div class="header-body-name">
              <span>大胖子在此</span>
            </div>
            <div class="header-body-like">
              <img src="img/comment/heart.png" alt="">
            </div>
            <div class="like-name">
              <span>ART+SPACE艺术空间</span>
            </div>
            <div class="like-des-input j-input comment-input">
              <div class="clear-input none" style="right:20px;"><span class="fa fa-times"></span></div>
              <input type="text" placeholder="说点什么。。。" id="comment-content" data-error="评论内容不能为空">
            </div>
            <div class="like-des-button">
              <button id="comment-submit">提交</button>
            </div>
          </div>
          {*未登录*}
          <div class="is-login none" data-validate="true">
            <div class="like-des-input login-input j-input">
              <div class="clear-input none"><span class="fa fa-times"></span></div>
              <input type="text" placeholder="手机号码" class="login-phone"
                     yun="form-validate/form-validate.js::typeValidate@keyup" data-error="请填写11位的手机号码" data-length="11"
                     yun-type="phone"  yun-error="" data-validate="true"
                     yun-style="fontSize:18px,position:absolute,right:7px,top:0px,line-height:34px,color:#ff0000">
            </div>
            <div class="get-code clearfix">
              <div class="like-des-input login-input login-code j-input">
                <div class="clear-input none"><span class="fa fa-times"></span></div>
                <input type="text" placeholder="验证码" data-error="请填写正确的验证码" id="code-input"
                       data-validate="true" yun-type="code" yun-phone=".login-phone"  yun="form-validate/form-validate.js::typeValidate@keyup" data-length="6">
              </div>
              <button class="send-code"  yun-phone=".login-phone" yun="identify-code.v1.0/identify-code.v1.0.js::sendCode@click">
                发送验证码
              </button>
            </div>

            <div class="like-des-button">
              <button yun="form-validate/form-validate.js::ajaxSubmit@click" id="comment-login"
                      yun-url="" yun-ajax="is_login"
                      yun-form=".is-login" data-id="0" data-year_id="0" data-ticket_number="" data-year_title="" yun-error=".show-error">提交</button>
            </div>
          </div>


        </div>

      </div>
    </header>

    <div class="zan clearfix">
      <div class="zan-who fl">
        <ul class="zan-who-list clearfix">
          <li>
              <img src="img/comment/tx_02.png" alt="">
          </li>
          <li>
              <img src="img/comment/tx_02.png" alt="">
          </li>
          <li>
              <img src="img/comment/tx_02.png" alt="">
          </li>
          <li>
              <img src="img/comment/tx_02.png" alt="">
          </li>
          <li>
              <img src="img/comment/tx_02.png" alt="">
          </li>
          <li>
              <img src="img/comment/tx_02.png" alt="">
          </li>
          <li>
              <img src="img/comment/tx_02.png" alt="">
          </li>
          <li>
              <img src="img/comment/tx_02.png" alt="">
          </li>
        </ul>
      </div>
      <div class="zan-num fl">
          <span>68</span>
      </div>
      <!-- <div class="zan-icon fl">
          <span class="fa fa-thumbs-o-up"></span>
      </div> -->
      <div class="back-num">
        <span>38条回复</span>
      </div>
    </div>

    <div class="comment-list">
      {include file="Web_Mobile_Static::comment/inc.comment_li.tpl"}
      {include file="Web_Mobile_Static::comment/inc.comment_li.tpl"}
      {include file="Web_Mobile_Static::comment/inc.comment_li.tpl"}
      {include file="Web_Mobile_Static::comment/inc.comment_li.tpl"}
    </div>

    <div class="comment-error"></div>
    <div class="load-more-comment">
          加载更多...
    </div>
  </div>
  <div id="clone-comment" class="none">
    {include file="Web_Mobile_Static::comment/inc.comment_li.tpl"}
  </div>
  {static "core/yunspace.js"}
  </body>
</html>
