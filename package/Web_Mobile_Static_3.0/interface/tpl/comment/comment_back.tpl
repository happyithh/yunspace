<!DOCTYPE>
<html>
  <head>
      {include file="Web_Mobile_Static::inc/header_meta.tpl"}
      <meta name="full-screen" content="yes" />
      <meta name="x5-fullscreen" content="true" />
    <!-- {static "comment/comment.css"} -->
    {static "v4.0/font-awesome.min.css"}
    {static "comment/comment_back.css"}
    {static "comment/comment-li.css"}
  </head>
  <body>
    <div class="content">
      <div class="person-comment-page">
        <div class="comment-li">
            <div class="comment-person-img">
              <img src="{$replyData['info']['user_info']['headimgurl']}" alt="">
            </div>
            <div class="comment-message">
                <div class="message-header clearfix">
                  <div class="message-name fl"><span>{$replyData['info']['user_info']['nickname']}</span></div>
                </div>

                <div class="message-time">
                  <span>{date('Y-m-d H:i:s',$replyData['info']['create_time'])}</span>
                </div>

                <div class="message-info">
                  <span>{$replyData['info']['content']}</span>
                </div>

                <div class="comment-article">
                  <a href="">
                    <div class="article-img">
                      <img src="img/comment/t_03.png" alt="">
                    </div>
                    <div class="article-title">
                      <span>我是一只小胖子，咿呀咿呀呦！！我是一只小胖子，咿呀咿呀呦！！我是一只小胖子，咿呀咿呀呦！！</span>
                    </div>
                  </a>
                </div>

            </div>
        </div>
      </div>

      <div class="zan-persons">
          <img src="img/comment/tx_02.png" alt="" />
          <img src="img/comment/tx_02.png" alt="" />
          <img src="img/comment/tx_02.png" alt="" />
          <img src="img/comment/tx_02.png" alt="" />
          <img src="img/comment/tx_02.png" alt="" />
          <img src="img/comment/tx_02.png" alt="" />
          <img src="img/comment/tx_02.png" alt="" />
          <img src="img/comment/tx_02.png" alt="" />
          <img src="img/comment/tx_02.png" alt="" />
          <img src="img/comment/tx_02.png" alt="" />
          <img src="img/comment/tx_02.png" alt="" />
          <img src="img/comment/tx_02.png" alt="" />
          <div class="more-person">
            <span class="fa fa-angle-right"></span>
          </div>
      </div>

      <div class="back-list">
        <div class="back-list-header">
          <header>评论</header>
          <div class="line"></div>
        </div>
        <div class="comment-list">
            {include file="Web_Mobile_Static::comment/inc.comment_li.tpl"}
            {include file="Web_Mobile_Static::comment/inc.comment_li.tpl"}
            {include file="Web_Mobile_Static::comment/inc.comment_li.tpl"}
            {include file="Web_Mobile_Static::comment/inc.comment_li.tpl"}
        </div>
      </div>

    </div>

    <footer class="back-form">
      <div class="back-input">
        <input type="text">
        <button>回复</button>
      </div>
    </footer>
  </body>
</html>
