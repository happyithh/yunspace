<!DOCTYPE html>
<html>
<head lang="en">
    <meta charset="UTF-8">
    <meta name="viewport"
          content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no,minimal-ui">
    <link rel="stylesheet" href="css/v1.0/global.css">
    <link rel="stylesheet" href="css/broke_the_news.v1.0/broke_the_news.css">
    <link rel="stylesheet" href="plugins/ionicons-master/css/ionicons.css"/>
    <title>爆料信息填写[云·Space 活动线索爆料]</title>
</head>
<body>
<img class="broke-news-form-banner" src="img/broke_the_news.v1.0/banner.png"/>
<div class="broke-news-form">
    <input type="hidden" id="userId" value="{$userId}">
    <table class="broke-news-form">
        <tr class="broke-news-form-header">
            <td colspan="3">活动地点</td>
        </tr>
        <tr>
            <td colspan="3"><select id="city">
                    <option>上海</option>
                    <option>北京</option>
                    <option>广州</option>
                    <option>深圳</option>
                    <option>成都</option>
                    <option>杭州</option>
                </select></td>
        </tr>
        <tr>
            <td class="broke-news-form-space-rows"></td>
        </tr>
        <tr class="broke-news-form-header">
            <td colspan="3">活动类型</td>
        </tr>
        <tr>
            <td colspan="3">
        <tr>
            <td colspan="3"><select id="type">
                    <option>派对/聚会/沙龙</option>
                    <option>年会/典礼/演出</option>
                    <option>路演/展览/发布会</option>
                    <option>会议/讲座</option>
                    <option>团建/拓展</option>
                </select></td>
        </tr>
        </td></tr>
        <tr>
            <td class="broke-news-form-space-rows"></td>
        </tr>
        <tr class="broke-news-form-header">
            <td colspan="3">活动方联系方式</td>
        </tr>
        <tr>
            <td colspan="1"><input type="text" class="js-contact" placeholder="联系人"></td>
            <td colspan="2"><input class="phone-num js-contact-num" type="text" placeholder="13xxxxxxxxx"></td>
        </tr>
        <tr class="broke-news-form-warning">
            <td colspan="3">为了确保您能拿到奖金，请如实填写</td>
        </tr>
        <tr>
            <td class="broke-news-form-space-rows"></td>
        </tr>
        <tr class="broke-news-form-header">
            <td colspan="3">活动备注（选填）</td>
        </tr>
        <tr>
            <td colspan="3"><textarea class="otherData phone-num js-contact" style="height: 90px; border: 1px solid #bfbfbf; border-radius: 0px;font-size: 3px; " placeholder="活动预算、人数、时长、详细地址等。                 提示:信息填写越完整，越容易通过审核哦。"></textarea></td>
        </tr>
        <tr class="broke-news-form-header">
            <td colspan="3">爆料人联系方式</td>
        </tr>
        <tr>
            <td colspan="3"><input type="text" name="submit_person" class="js-broke-contact-num" placeholder="13xxxxxxxxx" value="{$user_phone}"></td>
        </tr>
        <tr>
            <td class="broke-news-form-rule" colspan="3">
                <div class="toggle-rule js-toggle-rule"></div>
                我已阅读并同意&nbsp<span class="js-show-broke-info">《活动线索爆料规则》</span></td>
        </tr>
        <tr>
            <td class="broke-news-form-space-rows"></td>
        </tr>
        <tr>
            <td colspan="3">
                <div class="broke-news-button tb-btn disabled js-broke-the-news">
                    我要爆料
                </div>
                <div style="text-align: center;margin-top: 20px;">
                    <a href="?action=broke_the_news_mine">管理我的爆料>></a></div>
            </td>
        </tr>
        <tr>
            <td class="broke-news-form-space-rows"></td>
        </tr>
    </table>
</div>
<div class="mask-layer"></div>
<div class="broke-news-form-info">
    <div class="icon js-hide-broke-news-form-info">
        <i class="ion-android-close"></i>
    </div>
    <div class="broke-news-form-info-icon"></div>
    <p class="broke-news-form-info-title">恭喜您爆料成功</p>
    <p class="broke-news-form-info-content">感谢您的参与！您的消息我们会尽快处理，并以手机短信通知您审核结果。</p>
    <p class="broke-news-form-info-usage">（备注：若爆料通过审核，我们将通过微信红包发放您的奖励，请留意查收。）</p>
    <a class="show-my-news-button tb-btn"  href="{$_home}broke_news?action=broke_the_news_mine">查看我的爆料</a>
</div>
{include "Web_Mobile_Static::broke_the_news.v1.0/inc.broke_the_news_rule.tpl"}
<script src="js/v1.0/jquery-1.11.1.min.js"></script>
<script src="js/broke_the_news.v1.0/broke_the_news.js"></script>
<script>
    {if $_COOKIE['is_one']==1}
    $(function(){
        $(".js-show-broke-info").click();
        document.cookie='is_one=2';
    })
    {/if}
</script>
{static "core/yunspace.js"}
</body>
</html>