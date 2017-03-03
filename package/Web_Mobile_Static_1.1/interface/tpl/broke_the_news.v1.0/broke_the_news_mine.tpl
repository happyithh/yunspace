<!DOCTYPE html>
<html>
<head lang="en">
    <meta charset="UTF-8">
    <meta name="viewport"
          content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no,minimal-ui">
    <link rel="stylesheet" href="css/v1.0/global.css">
    <link rel="stylesheet" href="css/broke_the_news.v1.0/broke_the_news.css">
    <link rel="stylesheet" href="plugins/ionicons-master/css/ionicons.css"/>
    <title>我的爆料[云·Space 爆料]</title>
</head>
<body>
<div class="broke_news_mine_content">
    <table>
        <tr>
            <td colspan="4" class="broke_news_mine_title hard-td"><label><span class="js-year"></span>年<span class="js-month"></span>月<i class="ion-chevron-down js-show-month"></i></label></td>
        </tr>
        <tr>
            <td colspan="2"><label>爆料总数</label></td>
            <td colspan="1" class="sumBroke"><label>{$data['sumBroke']}</label></td>
            <td colspan="1"><label></label></td>
        </tr>
        <tr>
            <td colspan="2"><label>正在审核</label></td>
            <td colspan="1" class="waitingBroke"><label>{$data['waitingBroke']}</label></td>
            <td colspan="1"><label></label></td>
        </tr>
        <tr>
            <td colspan="2"><label>未过审核</label></td>
            <td colspan="1" class="abandonBroke"><label>{$data['abandonBroke']}</label></td>
            <td colspan="1"><label></label></td>
        </tr>
        <tr>
            <td colspan="2"><label>通过审核</label></td>
            <td colspan="1" class="doneBroke"><label>{$data['doneBroke']}</label></td>
            <td colspan="1"><label></label></td>
        </tr>
        <tr>
            <td colspan="2"><label>奖励额度</label></td>
            <td colspan="1" class="price"><label>{$data['reward']['price']}元/条</label></td>
            <td colspan="1"><label></label></td>
        </tr>
        <tr>
            <td colspan="2"><label>奖金预计</label></td>
            <td colspan="1" ><label style="color: #e4034f" class="reward">{$data['reward']['reward']} 元</label></td>
            <td colspan="1"><label></label></td>
        </tr>
    </table>
</div>
<div class="broke_news_mine_usage">小云提醒：再提供<span id="num" style="color: #e50150">{$data['reward']['num']}</span>条有效线索，即可将奖励额度提升为<span id='reward_price' style="color: #e50150">{$data['reward']['reward_price']}</span>元/条哦！</div>
<div class="broke_news_mine_content content-bottom">
    <table>
        <tr>
            <td class="broke_news_mine_title hard-td"><label>温馨提示</label></td>
        </tr>
        <tr>
            <td class="broke_news_mine_tb_usage">为方便查询爆料，记得收藏本页面哦！您也可以到云Space服务号&lt;活动爆料&gt;中“我的爆料”查看！</td>
        </tr>
    </table>
</div>
<div class="broke_news_mine_bottom">
    <a href="{$_home}broke_news" class="js_broke_continue b_n_btn">我要继续爆料</a>
    <div class="divide"></div>
    <a href="{$_home}broke_news?action=broke_validate" class="js_broke_show_detail b_n_btn">我的爆料详情</a>
</div>
    <div class="mask-layer"></div>
    <div class="broke-news-mine-month">
        <table>
            <tr>
                <td  colspan="4" class="js-date-data"><span class="js-tb-year"></span>年<span class="js-tb-month"></span>月</td>
                <td colspan="1" class="border-none"></td>
                <td  colspan="4" class="js-date-data"><span class="js-tb-year"></span>年<span class="js-tb-month"></span>月</td>
            </tr>
            <tr><td class="broke-news-mine-month-space"></td></tr>
            <tr>
                <td  colspan="4" class="js-date-data"><span class="js-tb-year"></span>年<span class="js-tb-month"></span>月</td>
                <td colspan="1" class="border-none"></td>
                <td  colspan="4" class="js-date-data"><span class="js-tb-year"></span>年<span class="js-tb-month"></span>月</td>
            </tr>
            <tr><td class="broke-news-mine-month-space"></td></tr>
            <tr>
                <td  colspan="4" class="js-date-data"><span class="js-tb-year"></span>年<span class="js-tb-month"></span>月</td>
                <td colspan="1" class="border-none"></td>
                <td  colspan="4" class="js-date-data"><span class="js-tb-year"></span>年<span class="js-tb-month"></span>月</td>
            </tr>
        </table>
    </div>
<script src="js/v1.0/jquery-1.11.1.min.js"></script>
<script src="js/broke_the_news.v1.0/broke_the_news.js"></script>
{static "core/yunspace.js"}
</body>
</html>