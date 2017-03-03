<!DOCTYPE html>
<html>
<head lang="en">
    {include file="Web_Feature_Static::jicai/inc.jicai_head.tpl"}
    {static "jicai/jicai.js"}
</head>
<body>
<!--网站头部 -->
{include file="Web_Static::v2.0/html_header3.1.tpl"}
<!--专题-->
<div class="jicai">
   <img src="img/jicai/form_02.jpg" alt="云·SPACE集采会员试用报名">
</div>
<!--<form action="http://www.yunspace.com.cn/form" method="post">-->
    <input id="id" name="id" value="8" type="hidden">
<div class="form_content">
    <div class="form_title">请留下基本信息，内测开始时会与您联系</div>
    <div class="form_list">
        <div class="form_left"><span></span>&nbsp;&nbsp;公司名称</div>
        <div class="form_right"><input id="name" type="text" placeholder="请输入您的公司名称" name="data[公司名称]" value=""> </div>
        <div class="clear"></div>
    </div>
    <div class="form_list">
        <div class="form_left"><span>*</span>&nbsp;&nbsp;联系人</div>
        <div class="form_right"><input id="person" type="text" placeholder="请输入您的称呼" name="data[联系人]" value="" class="input"> </div>
        <div class="clear"></div>
    </div>
    <div class="form_list">
        <div class="form_left"><span>*</span>&nbsp;&nbsp;联系电话</div>
        <div class="form_right"><input id="tel" type="text" placeholder="请输入联系电话" name="data[联系电话]" value="" class="input"> </div>
        <div class="clear"></div>
    </div>
    <div class="form_list">
        <div class="form_left"><span>*</span>&nbsp;&nbsp;邮&nbsp;&nbsp;&nbsp;&nbsp;箱</div>
        <div class="form_right"><input id="email" type="text" placeholder="请输入您的有效邮箱" name="data[邮箱]" value="" class="input"> </div>
        <div class="clear"></div>
    </div>
    <div class="form_list">
        <div class="button">
            <button class="url_form" data-url="{$_root}feature/jicai/form" data-tijiao="{$_root}form">确定</button>
        </div>
        <div class="clear"></div>
    </div>
</div>
<!--</form>-->


<div>
    <div class="alert">
        <div class="p3"><img src="img/jicai/icon1.jpg"> </div>
        <div class="clear"></div>
       <div class="p1">
           <div class="p1_left"><img src="img/jicai/icon.jpg"> </div>
           <div class="p1_right">报名成功！</div>
           <div class="clear"></div>
       </div>
       <div class="p2">我们会尽快审核信息并与您联系，请耐心等待。</div>
    </div>
</div>
<div class="mark"></div>
<div style="display:none;visibility: hide">
    <script>
        var _hmt = _hmt || [];
        (function () {
            var hm = document.createElement("script");
            hm.src = "//hm.baidu.com/hm.js?db9aca0f09ae15c89745a79b5c8599bf";
            var s = document.getElementsByTagName("script")[0];
            s.parentNode.insertBefore(hm, s);
        })();
    </script>
    <script type="text/javascript">
        var _bdhmProtocol = (("https:" == document.location.protocol) ? " https://" : " http://");
        document.write(unescape("%3Cscript src='" + _bdhmProtocol + "hm.baidu.com/h.js%3Fc400699d328ada7f4739a7a5bb91acdd' type='text/javascript'%3E%3C/script%3E"));
    </script>
    <script type="text/javascript" src="http://tajs.qq.com/stats?sId=44414322" charset="UTF-8"></script>
</div>
<!--网站底部 -->
{include file="Web_Static::v2.0/form.tpl"}
{include file="Web_Static::v2.0/html_footer.tpl"}
<div class="mark"></div>
</body>
</html>
