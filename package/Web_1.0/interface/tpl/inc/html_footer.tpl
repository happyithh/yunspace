<div style="margin-top:50px;" class="mt50"></div>
{if $brand}
    <div class="wbs content">
        <div class="booking_step  wrap" style="padding: 10px 0 30px 0">
            <h3>合作品牌</h3>
            <hr class="hr">
            <div class="panter">
                <img src="img/panter.png" class="img-responsive">
            </div>
        </div>
    </div>
{/if}
<div class="footer">
    <div class="f_al">
        <a href="{$_root}yunspace/about_us">关于云·SPACE</a>|
        <a href="{$_root}user_center/vendor_register">供应商加盟</a>|
        <a href="{$_root}yunspace/business">业务合作</a>|
        <a href="{$_root}yunspace/recruitment">职位招聘</a>|
        <a href="{$_root}yunspace/contact_us">联系我们</a>|
        <a href="{$_root}yunspace/drawback">退款说明</a>
        {*|<a href="{$_root}help">帮助中心</a>*}
    </div>
    <div class="copyright">
        Copyright©2015 云·SPACE
        <a href="http://www.miibeian.gov.cn/" target="_blank">沪ICP备12039278号-2</a>
    </div>
    <div class="elsel">
        <img src="images/elselink.png">
    </div>
</div>
<!-- 返回顶部按钮 -->
<div id="topcontrol" class="hide">
    <img src="images/up.png" style="width:40px; height:40px"/>
</div>
<div id="layer"></div>
<script type="text/javascript" src="js/base.js"></script>
{include "Web::inc/html_static.tpl"}