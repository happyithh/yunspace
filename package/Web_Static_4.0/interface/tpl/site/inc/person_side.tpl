{static "v4.0/common.css"}
{static "baike.v1.0/person_side.css"}
<div class="person-width" yun="inc.v4.0/persons-side.js::init">
  <div class="person-side">
    <div class="side-one">
      <header>
        <div class="side-one-p">
          <span>我喜欢</span>
        </div>
      </header>
        <div class="side-persons">

        {if !$info['is_space'] && $info['category_id']!=200}
            <a href="javascript:;">
                <div class="heart-num">
                    {*现场足迹url：{Core::$urls['host']}/m/site/{$page->info['space_name']}-讨论组-PC-Go *}
                    <div class="heart-img" data-code="{Core::$urls['host']}/m/site/{$info['space_name']}-讨论组-PC-Like"
                         data-code_id="3" data-text="我喜欢,"
                         data-title="微信扫描二维码，进入讨论组">
                        <img src="img/v4.0/heart.png" alt="">
                    </div>
                    <div class="heart-p">
                        <span>我喜欢（{$is_love_num}）</span>
                    </div>
                </div>
            </a>
        {/if}
        <ul class="side-persons-list clearfix" id="side-persons-list">
            {foreach $like_list as $k=>$v}
          <li>

              <div class="persons-img">
                  {if $v['headimgurl']}
                      <img src="{$v['headimgurl']}" alt="">
                  {else}
                      <img src="img/content/no_head.png" alt="">
                  {/if}
              </div>
              <div class="persons-name">
                <span>{$v['nickname']}</span>
              </div>

          </li>
            {/foreach}
        </ul>
        {if $info['is_space'] || $info['category_id']==200}
            <a href="javascript:;">
                <div class="heart-num">
                    {*现场足迹url：{Core::$urls['host']}/m/site/{$page->info['space_name']}-讨论组-PC-Go *}
                    <div class="heart-img" data-code="{Core::$urls['host']}/m/site/{$info['space_name']}-讨论组-PC-Like"
                         data-code_id="3" data-text="我喜欢,"
                         data-title="微信扫描二维码，进入讨论组">
                        <img src="img/v4.0/heart.png" alt="">
                    </div>
                    <div class="heart-p">
                        {*<span>我喜欢（{$count_num['is_love']}）</span>*}
                        <span>我喜欢（{$is_love_num}）</span>
                    </div>
                </div>
            </a>
        {/if}
      </div>

    </div>
    {if ($info['is_space'] || $info['category_id']==200) && $go_list}
    <div class="side-two">
      <header>
        <div class="side-one-p">
          <span>现场足迹</span>
          <span class="footer-img"></span>
        </div>
      </header>
      <div class="side-persons">
        <ul class="side-persons-list clearfix">
            {foreach $go_list as $k=>$v}
                <li>
                    <div class="persons-img">
                        {*<img src="img/v4.0/tx_03.png" alt="">*}
                        {if $v['headimgurl']}
                            <img src="{$v['headimgurl']}" alt="">
                        {else}
                            <img src="img/content/no_head.png" alt="">
                        {/if}
                    </div>
                    <div class="persons-name">
                        <span>{$v['nickname']}</span>
                    </div>
                </li>
            {/foreach}

        </ul>
      </div>
      <div></div>
    </div>
    {/if}

  </div>
</div>

{include file="Web_Static::inc/code.tpl"}
<script src="js/qrcode/jquery.qrcode.min.js"></script>
<script src="js/baike.v1.0/person_code.js"></script>

