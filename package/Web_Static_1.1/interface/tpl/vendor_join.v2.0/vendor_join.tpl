<!DOCTYPE html>
<html>
<head>
    {include file="Web_Static::v2.0/html_goto_mobile.tpl" url="m/"}
    {include file="Web_Static::v2.0/html_head.tpl"}
    {*{static "home.v2.0/homepage.css"}*}
    {*{static "home.v2.0/homepage.js"}*}

    <link rel="stylesheet" href="plugins/ionicons-master/css/ionicons.min.css">
    {*<script src="plugins/plupload-2.1.2/plupload.full.min.js"></script>*}
    {static "vendor_join.v2.0/vendor_join.css"}
</head>
<body>
{include file="Web_Static::v2.0/html_header3.1.tpl"}
<div class="cover">
    <div class="tip">
        <span class="ion-close close-sub"></span>
        <p class="sub-title"><span class="ion-ios-lightbulb-outline"></span>&nbsp;提交成功</p>
        <p class="sub-p">我们的工作人员会尽快审核与您联系</p>
        <a href="javascript:;" class="sub-ok">知道了</a>
    </div>
</div>
<div class="j-banner">
    <img src="img/join.v2.0/banner_02.jpg" alt=" ">
    <div class="b-title">
        <p class="b-title1">我也有不错的活动资源</p>
        <p class="b-title2">如果你也有跟活动相关的空间场地、配套服务，快来加入我们吧</p>
    </div>
</div>
<div class="j-content">
    <p class="j-c-title">基本信息</p>
    <form action="" class="j-form" data-validate="true"  yun="form-validate/form-validate.js::formSubmit">
        <div class="j-input">
            <label>
                <span><i>*</i>&nbsp;城市</span>
                <div class="j-i-content">
                    <div class="select">
                        <div class="city">
                            <input type="text" placeholder="请填写城市" data-validate="true" style="display: none" class="input-city">
                            <a href="javascript:;" class="city-select">
                                <p>省份</p>
                                <span class="ion-arrow-down-b"></span>
                            </a>
                            <ul class="province-city">
                                <li>江苏</li>
                                <li>浙江</li>
                                <li>广东</li>
                                <li>河南</li>
                            </ul>
                        </div>
                        <div class="city">
                            <input type="text" placeholder="请填写城市" data-validate="true" style="display: none">
                            <a href="javascript:;" class="city-select">
                                <p>城市</p>
                                <span class="ion-arrow-down-b"></span>
                            </a>
                            <ul class="province-city">
                                <li>苏州</li>
                                <li>杭州</li>
                                <li>广州</li>
                                <li>郑州</li>
                            </ul>
                        </div>
                    </div>

                 </div>
            </label>
        </div>
        <div class="j-input">
            <label><span><i>*</i>&nbsp;主营商品</span>
                <div class="j-i-content">
                    <div class="input-select">
                        {*<select type="text" placeholder="请选择类型">*}
                            {*<option value="">酒球</option>*}
                        {*</select>*}
                        <div class="cate">
                            <input type="text" class="select-val" data-validate="true" style="display: none">
                            <a href="javascript:;" class="c-select">
                                <p>请选择商品类型</p>
                                <span class="ion-arrow-down-b"></span>
                            </a>
                            <ul class="c-list-parent">
                                <li>
                                    <a href="javascript:;">超值套餐<span class="ion-arrow-right-b c-l-p-icon"></span></a>
                                    <ul class="c-list-son">
                                        <li class="c-info">
                                            <a href="javascript:;">硬件搭设1</a>
                                        </li>
                                        <li class="c-info">
                                            <a href="javascript:;">多媒体制作1</a>
                                        </li>
                                        <li class="c-info">
                                            <a href="javascript:;">设备租聘1</a>
                                        </li>
                                        <li class="c-info">
                                            <a href="javascript:;">演出人力1</a>
                                        </li>
                                        <li class="c-info">
                                            <a href="javascript:;">灯光摄影1</a>
                                        </li>
                                    </ul>
                                </li>
                                <li>
                                    <a href="javascript:;">配套服务<span class="ion-arrow-right-b c-l-p-icon"></span></a>
                                    <ul  class="c-list-son">
                                        <li class="c-info">
                                            <a href="javascript:;">硬件搭设2</a>
                                        </li>
                                        <li  class="c-info">
                                            <a href="javascript:;">多媒体制作2</a>
                                        </li>
                                        <li class="c-info">
                                            <a href="javascript:;">设备租聘2</a>
                                        </li>
                                        <li class="c-info">
                                            <a href="javascript:;">演出人力2</a>
                                        </li>
                                        <li class="c-info">
                                            <a href="javascript:;">灯光摄影2</a>
                                        </li>
                                    </ul>
                                </li>
                                <li>
                                    <a href="javascript:;">空间场地<span class="ion-arrow-right-b c-l-p-icon"></span></a>
                                    <ul  class="c-list-son">
                                        <li class="c-info">
                                            <a href="javascript:;">硬件搭设3</a>
                                        </li>
                                        <li class="c-info">
                                            <a href="javascript:;">多媒体制作3</a>
                                        </li>
                                        <li class="c-info">
                                            <a href="javascript:;">设备租聘3</a>
                                        </li>
                                        <li class="c-info">
                                            <a href="javascript:;">演出人力3</a>
                                        </li>
                                        <li class="c-info"><a href="javascript:;">灯光摄影3</a></li>
                                    </ul>
                                </li>
                                <li>
                                    <a href="javascript:;">空间场地<span class="ion-arrow-right-b c-l-p-icon"></span></a>
                                    <ul  class="c-list-son">
                                        <li class="c-info">
                                            <a href="javascript:;">硬件搭设4</a>
                                        </li>
                                        <li class="c-info">
                                            <a href="javascript:;">多媒体制作4</a>
                                        </li>
                                        <li class="c-info">
                                            <a href="javascript:;">设备租聘4</a>
                                        </li>
                                        <li class="c-info">
                                            <a href="javascript:;">演出人力4</a>
                                        </li>
                                        <li class="c-info"><a href="javascript:;">灯光摄影4</a></li>
                                    </ul>
                                </li>
                            </ul>
                        </div>
                    </div>
                 </div>
            </label>
        </div>
        <div class="j-input">
            <label>
                <span><i>*</i>&nbsp;场地名称</span>
                <div class="j-i-content">
                    <input type="text" placeholder="请填写场地名称" data-validate="true">
                </div>
            </label>
        </div>
        <div class="j-input">
            <label><span><i>*</i>&nbsp;供应商名称</span>
                <div class="j-i-content">
                    <input type="text" placeholder="请填写供应商名称"  data-validate="true">
                </div>

            </label>
        </div>
        <div class="j-input">
            <label><span><i>*</i>&nbsp;联系人</span>
                <div class="j-i-content">
                <input type="text" placeholder="请填写联系人"  data-validate="true">
                    </div>
            </label>
        </div>
        <div class="j-input">
            <label><span><i>*</i>&nbsp;联系手机</span>
                <div class="j-i-content">
                <input type="text" placeholder="请填写联系方式" yun="form-validate/form-validate.js::typeValidate@keyup"
                       yun-type="phone" yun-error="&nbsp;&nbsp;手机格式不正确"
                       yun-style="padding:5px,border-radius:5px,background:#fdffe5,color:#666666,font-size:13px,display:block,width:100%,line-heigh:20px,margin-top:3px"
                       data-validate="true">
                    </div>
            </label>
        </div>
        <div class="clear"></div>
        <div class="j-file" id="j-file1">
            <span> &nbsp;&nbsp;名片</span>
            <a href="javascript:;" class="file-select" yun="upload/upload.js::init" yun-input="person"
               yun-btn="browse1" yun-list="file-list1" yun-parent="j-file1" yun-url="{$_root}order_info/upload">选择文件</a>
            <div class="pic-tip">
                <span>*上传您所填业务中含有职位信息的名片，审核会更快哦!</span><br/>
                <span>【请上传格式jpg,png,jpeg的图片，大小不能超过2M】</span>
            </div>
            <div class="wraper">
                <ul id="file-list1" class="file-list">
                    <input type="text" name="person"  style="display: none">
                    {*<li>*}
                    {*<span class="ion-close remove-img" style="display: none"></span>*}
                    {*<p></p>*}
                    {*<img src="img/home.v2.0/aoo1.jpg" alt="">*}
                    {*</li>*}
                </ul>
            </div>
            <div class="clear"></div>
            {*<a href="javascript:;" class="file-select">选择文件</a>*}
            {*<a href="javascript:;" class="upload-file">开始上传</a>*}
        </div>
        <div class="clear"></div>
        <div class="j-file" id="j-file2">
            <span><i>*</i>&nbsp;图片</span>
            <a href="javascript:;" class="file-select2" yun="upload/upload.js::init" yun-input="pic"
               yun-btn="browse2" yun-list="file-list2" yun-parent="j-file2"  yun-url="{$_root}order_info/upload">选择文件</a>
            <div class="pic-tip">
                <span></span>
                <span style="line-height: 30px;">【请上传格式jpg,png,jpeg的图片，大小不能超过2M】</span>
            </div>
            <div class="wraper">
                <ul id="file-list2" class="file-list">
                    <input type="text" name="pic" data-validate="true" style="display: none">
                    {*<li>*}
                        {*<span class="ion-close remove-img" style="display: none"></span>*}
                        {*<p></p>*}
                        {*<img src="img/home.v2.0/aoo1.jpg" alt="">*}
                    {*</li>*}
                </ul>
            </div>
            <div class="clear"></div>
            {*<a href="javascript:;" class="upload-file">开始上传</a>*}
        </div>
        <div class="clear"></div>
        <div class="j-about">
            <span><i>*</i>&nbsp;相关介绍</span>
            <textarea name="" id="" cols="30" rows="10" data-validate="true" style="border: 1px solid #ccc">
            </textarea>
            <div class="clear"></div>
        </div>
        <div class="j-register">
                <p class="j-r-title">您还未登陆，可以快速登陆下啦</p>
            <div class="j-l-input">
                <p><i>*</i>&nbsp;手机号</p>
                <div class="j-r-i-input">
                    <input type="text" yun="form-validate/form-validate.js::typeValidate@keyup" class="phone-validate"
                           yun-type="phone" yun-error="&nbsp;&nbsp;手机格式不正确"
                           yun-style="padding:5px,border-radius:5px,background:#fdffe5,color:#666666,font-size:13px,display:block,width:50%,line-height:20px,margin-top:3px"
                           data-validate="true">
                </div>
            </div>
            <div class="j-l-input">
                <p><i>*</i>&nbsp;验证码</p>
                <div class="j-r-i-input">
                    <div class="j-r-i-code">
                        <input type="text" data-validate="true" >
                        <button class="send-code" type="button" yun-phone=".phone-validate" yun-second="30"
                           yun="identify-code.v1.0/identify-code.v1.0.js::sendCode@click" >发送验证码</button>
                        <div class="clear"></div>
                    </div>
                    <span></span>
                </div>
            </div>

        </div>
        <p class="error-info"></p>
        <div class="j-check">
            <div class="input-check"><span  style="color:#666"></span></div>&nbsp;&nbsp;<a href="">我已阅读《云SPACE平台入驻协议》</a>
            <input type="checkbox" style="display: none">
            <div class="clear"></div>
        </div>
        <div class="j-submit">
            <button type="submit">提交申请</button>
        </div>

    </form>
</div>
{include file="Web_Static::v2.0/form.tpl"}
{include file="Web_Static::v2.0/html_footer.tpl"}
{static "core/yunspace.js"}

{static "vendor_join.v2.0/vendor_join.js"}
{*{static "join.v2.0/upload1.js"}*}
{*{static "join.v2.0/upload2.js"}*}
{*{static "id_validate/jquery.form.js"}*}
{*{static "id_validate/id_validate.js"}*}
</body>
</html>