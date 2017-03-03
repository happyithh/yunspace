{static "comment/comment-li.css"}
{foreach $page->getCommentsReplyList['replyList'] as $k=>$v}
<div class="comment-li comment-simple">
    <div class="comment-person-img">
        {if !empty($v['user_info']['headimgurl'])}
      <img src="{$v['user_info']['headimgurl']}" alt="">
        {else}
        <img src="img/comment/mtx_03.png" alt="">
        {/if}
    </div>
    <div class="comment-message">
        <div class="message-header clearfix">
          <div class="message-name fl"><span>{$v['user_info']['nickname']}</span></div>
          <div class="message-right clearfix fr">
            {*<div class="message-back fr none1">*}
              {*<a href="">*}
                {*<span class="fa fa-commenting-o"></span>*}
                {*<span>487</span>*}
              {*</a>*}
            {*</div>*}
            <div class="message-zan fr">
              <a href="javascript:;"  data-id="{Func_NumEncode::e($v['id'])}">
                <span class="fa fa-thumbs-o-up"></span>
                <span>{$v['is_good']}</span>
              </a>
            </div>
          </div>
        </div>

        <div class="message-time">
          <span>{date('m-d H:i',$v['create_time'])}</span>
        </div>

        <div class="message-info">
          <span>{$v['content']}</span>
        </div>
    </div>
</div>
{/foreach}
