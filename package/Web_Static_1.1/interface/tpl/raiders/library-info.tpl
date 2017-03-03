<!DOCTYPE html>
<html>
<head>
    {include file="Web_Static::v2.0/html_head.tpl"}
    <link rel="stylesheet" type="text/css" href="css/v2.0/common.css">
    <link rel="stylesheet" type="text/css" href="css/raiders/raiders-info.css">
    <link rel="stylesheet" type="text/css" href="css/raiders/library-info.css">
    <link rel="stylesheet" href="{$_root}yun/plugins/comment/css/comment.css"/>

    <link rel="stylesheet" href="{$_root}yun/plugins/comment/css/bootstrap.min.css"/>

    <link rel="stylesheet" href="{$_root}yun/plugins/comment/css/ionicons.min.css"/>
    <link rel="stylesheet" href="css/v1.0/global.css"/>
    {*<script src="{$_root}yun/plugins/comment/js/comment.js"></script>*}
    {*<script src="{$_root}yun/plugins/comment/js/yunspace.js"></script>*}
</head>

<body>
{include file="Web_Static::v2.0/html_header3.1.tpl"}
<div class="containers">
    <p class="locate"><a href="#">首页</a>&nbsp;>&nbsp;<a href="#">活动文库</a>
        &nbsp;>&nbsp;<a href="#">活动拍摄需要注意的事项</a>
    </p>
    <div class="raiders-info-title">
        <div class="document_icon"> <img src="img/raiders-info/txt_icon.jpg"> </div>
        <div class="document_title"> 活动拍摄需要注意的事项</div>
        <div class="clear"></div>
    </div>
    <div class="library_classify">文档分类：<span>活动专题</span></div>
    <div class="raiders-info-left">

          <div class="document">
              <div class="document_thumbnail">
                  <img src="img/raiders-info/thumbnail.jpg">
                  <p class="thumbnail-title">TXT截图</p>
              </div>
              <div class="document_abstract">
                  <span>摘要：</span>在颐方园工作多年，有很多次为客人提供会议、活动的拍照服务的经历。这些年也经常利用节假日给朋友帮忙拍摄过多场大型活动。会议、大型活动的拍摄类似拍摄中的纪实摄影，所以对拍摄者的要求相对较高，需要能熟练运用相机的各种功能、掌握会议活动的流程、短时间熟记会议主要参与者的活动范围等等。这里把一些会议拍摄的经验和注意事项和同事们分享一下。

              </div>
              <div class="document_download">
                  <div class="document_download_btn">
                      下载完整TXT文档
                  </div>
                  <p class="document_info">文件大小：0.1MB</p>
                  <p class="document_info">下载次数：0</p>
              </div>
              <div class="clear"></div>
          </div>
        <div class="raiders-info-share">
            <div class="raiders-info-share-left">

                <div class="raider-info-share-text">
                    分享到：
                </div>
                <div class="raider-info-share-icon">
                    {literal}
                        <div class="bdsharebuttonbox"><a href="#" class="bds_more" data-cmd="more"></a><a href="#" class="bds_qzone" data-cmd="qzone" title="分享到QQ空间"></a><a href="#" class="bds_tsina" data-cmd="tsina" title="分享到新浪微博"></a><a href="#" class="bds_tqq" data-cmd="tqq" title="分享到腾讯微博"></a><a href="#" class="bds_renren" data-cmd="renren" title="分享到人人网"></a><a href="#" class="bds_weixin" data-cmd="weixin" title="分享到微信"></a></div>
                        <script>window._bd_share_config={"common":{"bdSnsKey":{},"bdText":"","bdMini":"2","bdMiniList":false,"bdPic":"","bdStyle":"0","bdSize":"32"},"share":{},"image":{"viewList":["qzone","tsina","tqq","renren","weixin"],"viewText":"分享到：","viewSize":"16"},"selectShare":{"bdContainerClass":null,"bdSelectMiniList":["qzone","tsina","tqq","renren","weixin"]}};with(document)0[(getElementsByTagName('head')[0]||body).appendChild(createElement('script')).src='http://bdimg.share.baidu.com/static/api/js/share.js?v=89860593.js?cdnversion='+~(-new Date()/36e5)];</script>  {/literal}
                </div>
            </div>
            <div class="raiders-info-share-right">
                <div class="comment-chat">
                    <a href="javascript:;" yun="comment/js/comment.js::wow@click" class="js-wow">
                        <span {if empty($page->getPraise['praise']) || $page->getPraise['praise']==0}class="glyphicon glyphicon-thumbs-up wow-1"{else}class="glyphicon glyphicon-thumbs-up wow-1 wow-active"{/if}}"></span>
                    </a>
                    <p class="wow-num-1" style="margin-top: 3px;" title_id="{$page->getRaidersDetail['id']}" {if empty($page->getPraise['praise']) || $page->getPraise['praise']==0}praise="0"{else}praise="1"{/if}}">{$page->getRaidersDetail['counter_praise']}</p>
                </div>
            </div>
            <div class="clear"></div>
        </div>

        <div class="comment">
            <div class="comment-title">
                精彩评论
            </div>
            <div class="comment-content">
                <div class="comment-pic">
                    {if $page->getPhoto['avatar']}
                        <img id="photo" src="{$page->getPhoto['avatar']}">
                    {else}
                        <img id="photo" src="img/raiders-info/tx1.jpg">
                    {/if}
                </div>
                <div class="comment-back-input">
                    <input type="text" class="comment-back-input-content">
                </div>
                <a href="javascript:;" yun="comment/js/comment.js::comment@click" class="call-back-submit" user_id="{$__user['id']}" from_type="1" parent_id="" from_id={$page->id}>评论</a>

                <div class="clear"></div>
            </div>
            <ul class="comment-list">
                {foreach $page->getCommentList['rows'] as $c}
                    <li>
                        <div class="comment-slide">
                            <div class="comment-img">
                                {if $c['avatar']}
                                    <img title="头像" src="{Page_Site_Global::displayMedia($c['avatar'],'50','50')}">
                                {else}
                                    <img src="img/chat.v1.0/lufei.jpg" alt=""/>
                                {/if}
                            </div>
                        </div>
                        <div class="comment-body">
                            <div class="comment-head clearfix" >
                                <div class="comment-person">
                                    {$c['fullname']}
                                </div>
                                <div class="comment-time">
                                    {Date('Y-m-d H:i:s',$c['create_time'])}
                                </div>
                            </div>

                            <div class="comment-content">
                                <p>{$c['cont']}</p>
                            </div>
                            <div class="comment-chat">
                                <a href="javascript:;"  yun="comment/js/comment.js::wowComment@click">
                                    <span {if in_array({$c['id']},$page->getCommentpraise)}class="glyphicon glyphicon-thumbs-up wow-2 wow-active"{else}class="glyphicon glyphicon-thumbs-up wow-2"{/if}></span>
                                    <p class="wow-num-2" comment_id="{$c['id']}" {if in_array({$c['id']},$page->getCommentpraise)}comment-praise="1"{else}comment-praise="0"{/if}>{$c['count_praise']}</p>
                                </a>
                            </div>
                            <div class="comment-back">
                                <div class="comment-back-input">
                                    <input type="text" class="comment-back-input-content"/>
                                </div>
                                <div class="call-submit clearfix">
                                    <a href="javascript:;"  yun="comment/js/comment.js::callBackWithComment@click"  class="call-back-submit js-call1" data-username="{$c['fullname']}" user_id="{$__user['id']}" from_type="1" parent_id="{$c['id']}" from_id={$page->id}>回复</a>
                                </div>
                            </div>
                        </div>
                    </li>
                {/foreach}
            </ul>
            {if $page->getCommentList['page']['dt'] !=0}
                <div class="pagers">
                    {if $page->getCommentList['page']['dpll']}
                        <a href="{$page->getCommentList['page']['dup']}1" title="First">第一页</a>
                        <a href="{$page->getCommentList['page']['dup']}{$page->getCommentList['page']['dp']-1}"
                           title="Prev">上一页</a>
                    {else}
                        <a href="" class="prev first gray"><span>&laquo;&nbsp;</span>第一页</a>
                        <a href="" class="prev gray">&lt;&nbsp;上一页</a>
                    {/if}
                    {for $i=$page->getCommentList['page']['dpl'] to $page->getCommentList['page']['dpr']}
                        <a href="{$page->getCommentList['page']['dup']}{$i}"{if $i==$page->getCommentList['page']['dp']} class="active"{/if}>{$i}</a>
                    {/for}

                    {if $page->getCommentList['page']['dprr']}
                        <a href="{$page->getCommentList['page']['dup']}{$page->getCommentList['page']['dp']+1}"
                           title="Next">下一页</a>
                        <a href="{$page->getCommentList['page']['dup']}{$page->getCommentList['page']['dtp']}"
                           title="Last">最后页</a>
                    {else}
                        <a href="" class="next gray">下一页&nbsp;&gt;</a>
                        <a href="" class="next last gray">最后页<span>&nbsp;&raquo;</span></a>
                    {/if}
                </div>
            {else}
                <div class=" fl clearfix " style="width:930px;text-align: center;">
                    来抢沙发哦~~
                </div>
            {/if}
        </div>
        <div class="clear"></div>
    </div>
    <div class="raiders-info-right">
        <div class="groom_document">
            相关文档推荐
        </div>
         <div class="groom_content">
             <div class="groom_list1">
                 <div class="groom_icon">
                    <img src="img/raiders_list/excel_icon.png">
                 </div>
                 <div class="groom_title">
                     活动拍摄需要注意的事项
                 </div>
                 <div class="groom_amount">共5页</div>
                 <div class="clear"></div>
             </div>
             <div class="groom_list2">
                 <div class="groom_icon">
                     <img src="img/raiders_list/excel_icon.png">
                 </div>
                 <div class="groom_title">
                     活动拍摄需要注意的事项
                 </div>
                 <div class="groom_amount">共5页</div>
                 <div class="clear"></div>
             </div>
             <div class="groom_list1">
                 <div class="groom_icon">
                     <img src="img/raiders_list/excel_icon.png">
                 </div>
                 <div class="groom_title">
                     活动拍摄需要注意的事项
                 </div>
                 <div class="groom_amount">共5页</div>
                 <div class="clear"></div>
             </div>
             <div class="groom_list2">
                 <div class="groom_icon">
                     <img src="img/raiders_list/excel_icon.png">
                 </div>
                 <div class="groom_title">
                     活动拍摄需要注意的事项
                 </div>
                 <div class="groom_amount">共5页</div>
                 <div class="clear"></div>
             </div>
             <div class="groom_list1">
                 <div class="groom_icon">
                     <img src="img/raiders_list/excel_icon.png">
                 </div>
                 <div class="groom_title">
                     活动拍摄需要注意的事项
                 </div>
                 <div class="groom_amount">共5页</div>
                 <div class="clear"></div>
             </div>
         </div>

    </div>
    <div class="clear"></div>
</div>
{*{static "js/comment.js"}*}
{include file="Web_Static::v2.0/form.tpl"}
{include file="Web_Static::v2.0/html_footer.tpl"}
{static "core/yunspace.js"}
</body>
</html>