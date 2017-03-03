<!DOCTYPE html>
<html>
<head>
    <title>云·Space 更新记录</title>
    {include file="Web_Static::v2.0/html_head.tpl"}
    {static "changelog/changelog.css"}
    {*{static "changelog/changelog.js"}*}
    {*<link rel="stylesheet" href="css/changelog/changelog.css"/>*}
</head>
<body yun-src="{$_root}package/Web_Static_1.1/interface/assets/js/changelog/">
{*{include file="Web_Static::v2.0/html_header.tpl"}*}
<div class="update-header">
    <p class="title">云·Space 更新记录</p>
</div>
<div class="update-nav">
    <ul>
        <li>
            <a href="javascript:;" class="update-name update-name-active" yun="changelog.js::show@click" data-id="update-web">网站-运营</a>
        </li>
        <li>
            <a href="javascript:;" class="update-name" yun="changelog.js::show@click" data-id="update-base">基础平台</a>
        </li>
        <li>
            <a href="javascript:;" class="update-name" yun="changelog.js::show@click" data-id="update-broker">云经纪</a>
        </li>
        <li>
            <a href="javascript:;" class="update-name" yun="changelog.js::show@click" data-id="update-vendor">云管家</a>
        </li>
        <li>
            <a href="javascript:;" class="update-name" yun="changelog.js::show@click" data-id="update-buyer">客户增值</a>
        </li>
        {*<li><a href="javascript:;" class="update-name" yun="changelog.js::show@click" data-id="update-vendor">供应商增值</a></li>*}
        <li>
            <a href="javascript:;" class="update-name" yun="changelog.js::show@click" data-id="update-admin">内部管理系统</a>
        </li>
        <li class="clear"></li>
    </ul>
</div>
<div class="contain" style="padding:20px;">
{*平台运营*}
<div id="update-web">
    <p class="version">
        1.1.5&nbsp;<span>2015-07-17</span></p>

    <p class="update">本次更新包含以下优化：</p>

    <p class="update-content">* 活动攻略支持移动端浏览</p>

    <p class="update-content">* 新版页头页脚在旧页面上增加响应式支持</p>

    <p class="update-content">* 侧边浮动分享按钮样式优化</p>

    <p class="update-content">* 搜索页的筛选项顺序不再随机排列</p>

    <p class="update">本次更新修复以下问题：</p>

    <p class="update-content">* 修复首页部分内容被个别浏览器当成广告过滤</p>

    <p class="version">
        1.1.4&nbsp;<span>2015-07-10</span></p>

    <p class="update">本次更新包含以下优化：</p>

    <p class="update-content">* 首页增加新的楼层:新奇特</p>

    <p class="update-content">* 优化城市切换，增加独立城市主页</p>

    <p class="update-content">* 优化活动攻略评论功能</p>

    <p class="update-content">* 统一其他页面的页头导航与页脚为新的版式</p>

    <p class="update-content">* 升级页面分享的二维码，增加供应商LOGO</p>

    <p class="update-content">* 增加右侧浮动分享层</p>

    <p class="update-content">* 新增光影新感觉多媒体供应商专题</p>

    <p class="update-content">* 新增禅茶专题</p>

    <p class="update-content">* 套餐分类调整合并</p>

    <p class="update">本次更新修复以下问题：</p>

    <p class="update-content">* 套餐详情页版本名称过长时显示异常修复</p>

    <p class="update-content">* 套餐图片水印位置调整</p>

    <p class="update-content">* 因分类标签设置城市为不可搜索导致搜索结果异常的
        Bug 修复</p>
</div>
{*用户后台*}
<div id="update-base" class="none">
    <p class="version">
        1.1.5&nbsp;<span>2015-07-17</span></p>

    <p class="update">本次更新包含以下优化：</p>

    <p class="update-content">* 订单通知邮件将提供更多的信息</p>

    <p class="update-content">*
        实名认证增加上传文件大小提示(新的实名认证方式正在开发, 下个版本更新)</p>

    <p class="update">本次更新修复以下问题：</p>

    <p class="update-content">*
        修复实名认证表单中的提示文本：</p>

    <p class="version">
        1.1.4&nbsp;<span>2015-07-10</span></p>

    <p class="update">本次更新包含以下优化：</p>

    <p class="update-content">* 消息系统对接需求管理</p>

    <p class="update-content">* 消息系统, 增加群组聊天功能</p>

    <p class="update-content">* 需求提交增加关注微信号提示</p>

    <p class="update-content">* 档期管理增加档期类型和颜色选择</p>

    <p class="update-content">*
        实名认证增加上传文件大小提示(新的实名认证方式正在开发, 下个版本更新)</p>

    <p class="update">本次更新修复以下问题：</p>

    <p class="update-content">*
        修复套餐自管理个别情况下无法提交显示"操作错误"：</p>
</div>
{*云经纪*}
<div id="update-broker" class="none">
    <p class="version">
        1.0.5&nbsp;<span>2015-07-17</span></p>

    <p class="update">本次更新包含以下优化：</p>

    <p class="update-content">* 服务详情页图片焦点图高度增加</p>

    <p class="update-content">* 推荐算法修改</p>

    <p class="version">
        1.0.4&nbsp;<span>2015-07-10</span></p>

    <p class="update">本次更新包含以下优化：</p>

    <p class="update-content">* 增加 App 启动引导图</p>

    <p class="update-content">* 增加云经纪规则显示</p>

    <p class="update-content">* 优化套餐详情中的价格显示</p>

    <p class="update">本次更新修复以下问题：</p>

    <p class="update-content">* 修复套餐详情中的图片显示问题：</p>

    <p class="update-content">* 修复个别套餐详情无法打开 Bug</p>
</div>
{*供应商后台*}
<div id="update-vendor" class="none">
    <p class="version">
        1.0.6&nbsp;<span>2015-07-10</span></p>

    <p class="update">本次更新包含以下优化：</p>

    <p class="update-content">* 增加 App 启动引导图</p>

    <p class="update-content">* 增加 无内容的引导</p>

    <p class="update-content">* 原生开发 IOS 版内测</p>

    <p class="update-content">* 原生开发 Android 版内测</p>
</div>
{*客户增值*}
<div id="update-buyer" class="none">
    <p class="version">
        1.0.2&nbsp;<span>2015-07-17</span></p>

    <p class="update">本次更新包含以下优化：</p>

    <p class="update-content">* 活动售票功能优化用户引导</p>

    <p class="version">
        1.0.1&nbsp;<span>2015-07-10</span></p>

    <p class="update">本次更新包含以下优化：</p>

    <p class="update-content">* 增加用户的微信头像显示</p>

    <p class="update-content">* 每个活动的订单都是独立的</p>

    <p class="update-content">* 增加二维码识别支付方式</p>

    <p class="update-content">* 优化智能填表, 路由器页面填写更准确</p>

    <p class="update">本次更新修复以下问题：</p>

    <p class="update-content">* 修复在从订阅号进入微信无法跨号支付问题：</p>
</div>
<div id="update-admin" class="none">
    <p class="version">
        1.1.3&nbsp;<span>2015-07-17</span></p>

    <p class="update">本次更新包含以下优化：</p>

    <p class="update-content">* 需求列表显示逻辑修改</p>

    <p class="update-content">* 联系人列表显示逻辑修改</p>

    <p class="update">本次更新修复以下问题：</p>

    <p class="update-content">* 套餐上下线操作时影响到已下线套餐</p>

    <p class="version">
        1.1.2&nbsp;<span>2015-07-10</span></p>

    <p class="update">本次更新包含以下优化：</p>

    <p class="update-content">* 联系人增加分级定义(A/B/C/D)</p>

    <p class="update-content">* 联系人增加负责人筛选和分组筛选</p>

    <p class="update-content">*
        联系人根据城市和类型进行分离，不同城市/客户与供应商联系人不再互相干扰</p>

    <p class="update-content">* 审核拒绝后优先通知到负责,其次才是供应商</p>

    <p class="update-content">* 供应商套餐列表增加标题筛选和分类筛选</p>

    <p class="update-content">* 订单管理增加订单恢复功能</p>

    <p class="update-content">*
        部门管理增加员工职级，用于更细化的权限管理</p>

    <p class="update-content">*
        个人资料管理增加手机和邮箱设置，用于跨城市需求和通知处理</p>

    <p class="update-content">* 信息查询中增加供应商签约状态查询和统计</p>

    <p class="update-content">* 活动售票管理增加二维码生成功能</p>

    <p class="update">本次更新修复以下问题：</p>

    <p class="update-content">* 修复首页管理 V2的
        个别城市Banner不能添加超过3个的 Bug</p>
</div>
</div>
{static "core/yunspace.js"}
</body>
</html>