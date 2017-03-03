<!DOCTYPE html>
<html>
<head>
    {include file="Web_Static::inc/head_meta.tpl"}
    {static "baike.v1.0/baike_common.css"}
    {static "baike.v1.0/news.css"}
    {static "baike.v1.0/banner.js"}
    {static "baike.v1.0/news.js"}
</head>
<body>
{include file="Web_Static::inc/header2.tpl"}
{include file="Web_Static::baike.v1.0/inc/baike_banner.tpl"}

<div class="container">
    <div class="news-content">
        {include file="Web_Static::baike.v1.0/inc/collection_title.tpl"}
         {*最新消息tab切换*}
        <ul class="news_tabs">
            <li><a href="#" class="news_tabs_active">[ 最热资讯 ]</a></li>
            <li><a href="#">[ 强推 ]</a></li>
            <li><a href="#">[ 新·发现 ]</a></li>
            <li><a href="#">[ 最热 ]</a></li>
            <div class="clear"></div>
        </ul>

        {*最新消息列表多个图片开始*}
        <div class="news_list" data-id="2">
            <div class="news_title_outside">
                    <span class="news_title_top"></span>
                    <span class="news_title_tag"><a href="#"> [推荐]</a></span>
                    <a href="#" class="news_title">专注80、90后买车、用车新场景”云Space助力2015中国汽车生态</a>
                <div class="clear"></div>
            </div>
            <div class="news_pic_outside">
                <ul class="news_pic">
                     <li><a href="#"><img src="css/baike.v1.0/img/news_pic1.png" /> </a></li>
                     <li><a href="#"><img src="css/baike.v1.0/img/news_pic1.png" /> </a></li>
                     <li><a href="#"><img src="css/baike.v1.0/img/news_pic1.png" /> </a></li>
                     <li><a href="#"><img src="css/baike.v1.0/img/news_pic1.png" /> </a></li>
                     <div class="clear"></div>
                </ul>
            </div>
            <div class="news_des">
                 <div class="news_gb">
                     <div class="news_good">26</div>
                     <div class="news_bad clearfix">5</div>
                 </div>

               <div class="user_time clearfix">
                <span>小懒猫</span> · <span>4小时前</span>
               </div>
            </div>
        </div>
        {*最新消息列表多个图片结束*}

        {*最新消息列表一个图片开始*}
        <div class="news_list" data-id="3">
            <div class="news_title_left">
                <div class="news_title_outside1">
                    <span class="news_title_top"></span>
                    <span class="news_title_tag"><a href="#"> [推荐]</a></span>
                    <a href="#" class="news_title"> 专注80、90后买车、用车新场景”云Space助力2015中国汽车生态</a>
                    <div class="clear"></div>
                </div>
                   <div class="news_des">
                      <div class="news_gb">
                          <div class="news_good">26</div>
                          <div class="news_bad clearfix">5</div>
                      </div>
                      <div class="user_time clearfix">
                          <span>小懒猫</span>·<span>4小时前</span>
                      </div>
                   </div>

                </div>
                <div class="news_pic_one"><a href="#"><img src="css/baike.v1.0/img/news_pic1.png" /></a> </div>
                <div class="clear"></div>
        </div>
        {*最新消息列表一个图片结束*}

        <div class="news_list" data-id="4">
            <div class="news_title_outside">
                <span class="news_title_top"></span>
                <span class="news_title_tag"><a href="#"> [推荐]</a></span>
                <a href="#" class="news_title"> 专注80、90后买车、用车新场景”云Space助力2015中国汽车生态</a>
                <div class="clear"></div>
            </div>
            <div class="news_des">
                <div class="news_gb">
                    <div class="news_good">26</div>
                    <div class="news_bad clearfix">5</div>
                </div>

                <div class="user_time clearfix">
                    <span>小懒猫</span> · <span>4小时前</span>
                </div>
            </div>
        </div>


        <div class="news_list" data-id="5">
            <div class="news_title_outside">
                <a href="#" class="news_title"> 专注80、90后买车、用车新场景”云Space助力2015中国汽车生态</a>
                <div class="clear"></div>
            </div>
            <div class="news_pic_outside">
                <ul class="news_pic">
                    <li><a href="#"> <img src="css/baike.v1.0/img/news_pic1.png" /> </a></li>
                    <li><a href="#"><img src="css/baike.v1.0/img/news_pic1.png" /> </a></li>
                    <li><a href="#"><img src="css/baike.v1.0/img/news_pic1.png" /> </a></li>
                    <li><a href="#"><img src="css/baike.v1.0/img/news_pic1.png" /> </a></li>
                    <div class="clear"></div>
                </ul>
            </div>
            <div class="news_des">
                <div class="news_gb">
                    <div class="news_good">26</div>
                    <div class="news_bad clearfix">5</div>
                </div>

                <div class="user_time clearfix">
                    <span>小懒猫</span> · <span>4小时前</span>
                </div>
            </div>
        </div>
        <div class="news_list" data-id="6">
            <div class="news_title_left">
                <div class="news_title_outside1">
                    <a href="#" class="news_title"> 专注80、90后买车、用车新场景”云Space助力2015中国汽车生态</a>
                    <div class="clear"></div>
                </div>
                <div class="news_des">
                    <div class="news_gb">
                        <div class="news_good">26</div>
                        <div class="news_bad clearfix">5</div>
                    </div>
                    <div class="user_time clearfix">
                        <span>小懒猫</span>·<span>4小时前</span>
                    </div>
                </div>

            </div>
            <div class="news_pic_one"><a href="#"><img src="css/baike.v1.0/img/news_pic1.png" /></a> </div>
            <div class="clear"></div>
        </div>
        <div class="news_list" data-id="7">
            <div class="news_title_outside">
                <a href="#" class="news_title"> 专注80、90后买车、用车新场景”云Space助力2015中国汽车生态</a>
                <div class="clear"></div>
            </div>
            <div class="news_des">
                <div class="news_gb">
                    <div class="news_good">26</div>
                    <div class="news_bad clearfix">5</div>
                </div>

                <div class="user_time clearfix">
                    <span>小懒猫</span> · <span>4小时前</span>
                </div>
            </div>
        </div>
        <div class="news_list">
            <div class="news_title_outside">
                <a href="#" class="news_title"> 专注80、90后买车、用车新场景”云Space助力2015中国汽车生态</a>
                <div class="clear"></div>
            </div>
            <div class="news_pic_outside">
                <ul class="news_pic">
                    <li><a href="#"> <img src="css/baike.v1.0/img/news_pic1.png" /> </a></li>
                    <li><a href="#"><img src="css/baike.v1.0/img/news_pic1.png" /> </a></li>
                    <li><a href="#"><img src="css/baike.v1.0/img/news_pic1.png" /> </a></li>
                    <li><a href="#"><img src="css/baike.v1.0/img/news_pic1.png" /> </a></li>
                    <div class="clear"></div>
                </ul>
            </div>
            <div class="news_des">
                <div class="news_gb">
                    <div class="news_good">26</div>
                    <div class="news_bad clearfix">5</div>
                </div>

                <div class="user_time clearfix">
                    <span>小懒猫</span> · <span>4小时前</span>
                </div>
            </div>
        </div>
        <div class="news_list">
            <div class="news_title_left">
                <div class="news_title_outside1">
                    <a href="#" class="news_title"> 专注80、90后买车、用车新场景”云Space助力2015中国汽车生态</a>
                    <div class="clear"></div>
                </div>
                <div class="news_des">
                    <div class="news_gb">
                        <div class="news_good">26</div>
                        <div class="news_bad clearfix">5</div>
                    </div>
                    <div class="user_time clearfix">
                        <span>小懒猫</span>·<span>4小时前</span>
                    </div>
                </div>

            </div>
            <div class="news_pic_one"><a href="#"><img src="css/baike.v1.0/img/news_pic1.png" /></a> </div>
            <div class="clear"></div>
        </div>
        <div class="news_list">
            <div class="news_title_outside">
                <a href="#" class="news_title"> 专注80、90后买车、用车新场景”云Space助力2015中国汽车生态</a>
                <div class="clear"></div>
            </div>
            <div class="news_des">
                <div class="news_gb">
                    <div class="news_good">26</div>
                    <div class="news_bad clearfix">5</div>
                </div>

                <div class="user_time clearfix">
                    <span>小懒猫</span> · <span>4小时前</span>
                </div>
            </div>
        </div>
        <div class="news_list">
            <div class="news_title_outside">
                <a href="#" class="news_title"> 专注80、90后买车、用车新场景”云Space助力2015中国汽车生态</a>
                <div class="clear"></div>
            </div>
            <div class="news_pic_outside">
                <ul class="news_pic">
                    <li><a href="#"> <img src="css/baike.v1.0/img/news_pic1.png" /> </a></li>
                    <li><a href="#"><img src="css/baike.v1.0/img/news_pic1.png" /> </a></li>
                    <li><a href="#"><img src="css/baike.v1.0/img/news_pic1.png" /> </a></li>
                    <li><a href="#"><img src="css/baike.v1.0/img/news_pic1.png" /> </a></li>
                    <div class="clear"></div>
                </ul>
            </div>
            <div class="news_des">
                <div class="news_gb">
                    <div class="news_good">26</div>
                    <div class="news_bad clearfix">5</div>
                </div>

                <div class="user_time clearfix">
                    <span>小懒猫</span> · <span>4小时前</span>
                </div>
            </div>
        </div>
        <div class="news_list">
            <div class="news_title_left">
                <div class="news_title_outside1">
                    <a href="#" class="news_title"> 专注80、90后买车、用车新场景”云Space助力2015中国汽车生态</a>
                    <div class="clear"></div>
                </div>
                <div class="news_des">
                    <div class="news_gb">
                        <div class="news_good">26</div>
                        <div class="news_bad clearfix">5</div>
                    </div>
                    <div class="user_time clearfix">
                        <span>小懒猫</span>·<span>4小时前</span>
                    </div>
                </div>

            </div>
            <div class="news_pic_one"><a href="#"><img src="css/baike.v1.0/img/news_pic1.png" /></a> </div>
            <div class="clear"></div>
        </div>
        <div class="news_list">
            <div class="news_title_outside">
                <a href="#" class="news_title"> 专注80、90后买车、用车新场景”云Space助力2015中国汽车生态</a>
                <div class="clear"></div>
            </div>
            <div class="news_des">
                <div class="news_gb">
                    <div class="news_good">26</div>
                    <div class="news_bad clearfix">5</div>
                </div>

                <div class="user_time clearfix">
                    <span>小懒猫</span> · <span>4小时前</span>
                </div>
            </div>
        </div>
        {include file="Web_Static::inc/paging.tpl"}
    </div>
    <div class="news_content_right">
        {include file="Web_Static::baike.v1.0/inc/person_side.tpl"}
    </div>
    <div class="clear"></div>

</div>
{include file="Web_Static::inc/public_space.tpl"}
{include file="Web_Static::inc/html_footer.tpl"}
{static "core/yunspace.js"}
</body>
</html>