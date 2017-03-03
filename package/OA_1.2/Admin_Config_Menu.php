<?php

/**
 * Created by PhpStorm.
 * User: liushengchun
 * Date: 15/1/28
 * Time: 11:41
 */
class Admin_Config_Menu extends Data_Config
{
    public $all = array(
        'index' => array(
            'icon' => 'icon-home',
            'text' => '控制台',
            'des' => '系统状态和快捷入口',
            'no_auth' => 0
        ),
        'business' => array(
            'icon' => 'icon-mouse',
            'text' => '运营部管理',
            'children' => array(
                'operation/sms_notice_config' => array(
                    'icon' => 'icon-bell',
                    'text' => '短信通知设置',
                    'des' => '业务流转各个环节的短信/邮件通知',
                ),
                'website/home_page_banner_v4' => array(
                    'icon' => 'icon-screen-desktop',
                    'text' => '首页内容管理v4',
                    'des' => '网站首页Banner和推荐内容管理',
                    'action' => '010',   //子操作:  增改删
                ),
                'operation/pa_management' => array(
                    'icon' => 'icon-screen-desktop',
                    'text' => '广告位管理',
                    'des' => '网站内的广告位管理',
                    'action' => '010',   //子操作:  增改删
                ),
                'marketing/help-center' => array(
                    'icon' => 'icon-heart',
                    'text' => '帮助中心',
                    'des' => '帮助内容的添加',
                    'action' => '010',//子操作:  增改删
                ),
                'weixin/manage' => array(
                    'icon' => 'fa fa-ticket',
                    'text' => '活动售票管理',
                    'des' => '',
                    'action' => '010',   //子操作:  增改删
                ),
                'weixin/orderManage' => array(
                    'icon' => 'fa fa-ticket',
                    'text' => '活动售票订单管理',
                    'des' => '',
                    'action' => '010',   //子操作:  增改删
                ),
                'operation/form_manage' => array(
                    'icon' => 'icon-shield',
                    'text' => '表单管理',
                    'des' => '存储不同的表单事件',
                    'action' => '010',   //子操作:  增改删
                ),
                'operation/form_retail' => array(
                    'icon' => 'icon-shield',
                    'text' => '零售短租',
                    'des' => '零售短租相关订单列表',
                    'action' => '010',   //子操作:  增改删
                ),
                'operation/city_partner' => array(
                    'icon' => 'icon-shield',
                    'text' => '城市合伙人',
                    'des' => '城市合伙人列表',
                    'action' => '010',   //子操作:  增改删
                ),
                'operation/winchance' => array(
                    'icon' => 'icon-list',
                    'text' => '文创项目列表',
                    'des' => '文创项目',
                    'action' => '010',     //子操作:  增改删
                ),
                'operation/cooperation_brand' => array(
                    'icon' => 'icon-docs',
                    'text' => '合作品牌管理',
                    'des' => '合作品牌管理',
                    'action' => '010',   //子操作:  增改删
                ),
                'operation/adm_manage' => array(
                    'icon' => 'icon-docs',
                    'text' => 'ADM参展商户',
                    'des' => 'ADM参展商户',
                    'action' => '010',   //子操作:  增改删
                ),
                'website/annual_meeting' => array(
                    'icon' => 'icon-docs',
                    'text' => '年会专题',
                    'des' => '年会专题',
                    'action' => '110',   //子操作:  增改删
                ),
            )
        ),
        'wechat_web' => array(
            'icon' => 'icon-mouse',
            'text' => '微官网管理',
            'children' => array(
                'wechat_web/category' => array(
                    'icon' => 'icon-list',
                    'text' => '网站分类管理',
                    'des' => '网站分类管理',
                    'action' => '010',     //子操作:  增改删
                ),
                'wechat_web/article' => array(
                    'icon' => 'icon-list',
                    'text' => '网站文章管理',
                    'des' => '网站文章管理',
                    'action' => '010',     //子操作:  增改删
                ),
            )
        ),
        'winchance' => array(
            'icon' => 'icon-mouse',
            'text' => '文创管理',
            'children' => array(
                'operation/winchance' => array(
                    'icon' => 'icon-list',
                    'text' => 'IP运营管理',
                    'des' => 'IP项目报表',
                    'action' => '010',     //子操作:  增改删
                ),
                'winchance/site_list' => array(
                    'icon' => 'icon-list',
                    'text' => '文创场地报表',
                    'des' => '文创场地报表',
                    'action' => '010',     //子操作:  增改删
                ),
                'winchance/site_add' => array(
                    'icon' => 'icon-list',
                    'text' => '添加文创场地',
                    'des' => '添加文创场地',
                    'action' => '010',     //子操作:  增改删
                ),
                'winchance/site_statistical' => array(
                    'icon' => 'icon-list',
                    'text' => '场地进度统计',
                    'des' => '文创场地进度统计',
                    'action' => '010',
                ),
            )
        ),
        'winchance_new' => array(
            'icon' => 'icon-mouse',
            'text' => 'IP内容管理',
            'children' => array(
                'winchance_new/brand_manage' => array(
                    'icon' => 'icon-list',
                    'text' => 'IP品牌管理',
                    'des' => 'IP人物形象/品牌公司的操作',
                    'action' => '010',
                ),
                'winchance_new/winchance_list' => array(
                    'icon' => 'icon-list',
                    'text' => 'IP列表',
                    'des' => '显示已入驻IP/未入驻IP',
                    'action' => '010',     //子操作:  增改删
                ),
                'winchance_new/winchance_statistical' => array(
                    'icon' => 'icon-list',
                    'text' => 'IP数据报表',
                    'des' => 'IP数据统计表单',
                    'action' => '010',     //子操作:  增改删
                ),
                'winchance_new/fields_manage' => array(
                    'icon' => 'icon-list',
                    'text' => 'IP字段管理',
                    'des' => '编辑IP字段',
                    'action' => '010',
                ),
                'winchance_new/winchance_check' => array(
                    'icon' => 'icon-list',
                    'text' => 'IP审核',
                    'des' => 'IP审核',
                    'action' => '010',
                ),
            )
        ),
        'winchance_order' => array(
            'icon' => 'icon-mouse',
            'text' => 'IP订单管理',
            'children' => array(
                'winchance_order/order_list' => array(
                    'icon' => 'icon-list',
                    'text' => 'IP订单管理',
                    'des' => 'IP订单列表',
                    'action' => '010',
                ),
                'winchance_order/order_statistical' => array(
                    'icon' => 'icon-list',
                    'text' => 'IP订单数据报表',
                    'des' => '订单统计报表',
                    'action' => '010',
                ),

            )
        ),

        'operation' => array(
            'icon' => 'icon-docs',
            'text' => '需求报价管理',
            'children' => array(
                'operation/demand_contact' => array(
                    'icon' => 'icon-plus',
                    'text' => '创建需求/400电话',
                    'des' => '创建新联系人并添加需求',
                    'action' => '010',   //子操作:  增改删
                ),
                'operation/demand_operate' => array(
                    'icon' => 'icon-docs',
                    'text' => '需求管理',
                    'des' => '管理提出的需求',
                    'action' => '010',   //子操作:  增改删
                ),
//                'demand_offer/space_archives' => array(
//                    'icon' => 'icon-docs',
//                    'text' => '场地的报价状态',
//                    'des' => '场地的报价状态',
//                    'action' => '010',   //子操作:  增改删
//                ),
//                'operation/demand_tender' => array(
//                    'icon' => 'icon-docs',
//                    'text' => '需求报价列表',
//                    'des' => '需求报价列表',
//                    'action' => '010',   //子操作:  增改删
//                ),
//                'operation/demand_tender?action=is_my' => array(
//                    'icon' => 'icon-docs',
//                    'text' => '我的需求报价列表',
//                    'des' => '我的需求报价列表',
//                    'action' => '010',   //子操作:  增改删
//                ),
//                'operation/demand_offer_count' => array(
//                    'icon' => 'icon-docs',
//                    'text' => '统计列表',
//                    'des' => '统计列表',
//                    'action' => '010',   //子操作:  增改删
//                ),
//                'operation/demand_tender_list_statistics?action=list_v3' => array(
//                    'icon' => 'icon-docs',
//                    'text' => 'NEW报价统计列表',
//                    'des' => 'NEW报价统计列',
//                    'action' => '010',   //子操作:  增改删
//                ),
            ),
        ),
        'sales' => array(
            'icon' => 'icon-basket-loaded',
            'text' => '销售部管理',
            'children' => array(
                'sales/demand_contact' => array(
                    'icon' => 'icon-plus',
                    'text' => '创建需求/400电话',
                    'des' => '创建新联系人并添加需求',
                    'action' => '010',   //子操作:  增改删
                ),

                'sales/my_demand_list' => array(
                    'icon' => 'icon-plus',
                    'text' => '我的需求',
                    'des' => '我领取的所有联系人的所有需求',
                    'action' => '010',   //子操作:  增改删
                ),
                'sales/department_demand_list' => array(
                    'icon' => 'icon-list',
                    'text' => '部门需求管理',
                    'des' => '部门需求',
                    'action' => '010',   //子操作:  增改删
                ),
                'sales/team_demand_list_new' => array(
                    'icon' => 'icon-list',
                    'text' => '组需求管理',
                    'des' => '组需求管理',
                    'action' => '010',   //子操作:  增改删
                ),
                'sales/department_demand_list_new' => array(
                    'icon' => 'icon-list',
                    'text' => '城市需求管理',
                    'des' => '城市需求',
                    'action' => '010',   //子操作:  增改删
                ),
                'sales/department_demand_lists_all' => array(
                    'icon' => 'icon-list',
                    'text' => '所有需求管理',
                    'des' => '全国所有需求',
                    'action' => '010',   //子操作:  增改删
                ),
                'sales/department_demand_city_partner' => array(
                    'icon' => 'icon-list',
                    'text' => '城市需求管理（合伙人）',
                    'des' => '城市需求管理（合伙人）',
                    'action' => '010',   //子操作:  增改删
                ),
                'sales/demand_statistics' => array(
                    'icon' => 'icon-shield',
                    'text' => '需求统计',
                    'des' => '统计需求进度',
                    'action' => '010',   //子操作:  增改删
                ),
                'sales/order_statistics' => array(
                    'icon' => 'icon-shield',
                    'text' => '订单统计',
                    'des' => '统计订单详情',
                    'action' => '010',   //子操作:  增改删
                ),
//                'sales/demand_record' => array(
//                    'icon' => 'icon-shield',
//                    'text' => '需求回访',
//                    'des' => '需求记录情况',
//                    'action' => '010',   //子操作:  增改删
//                ),
                'sales/contact_record' => array(
                    'icon' => 'icon-docs',
                    'text' => '联系记录列表',
                    'des' => '联系记录列表',
                    'action' => '010',   //子操作:  增改删
                ),
            )
        ),
        'space' => array(
            'icon' => 'icon-list',
            'text' => '场地管理',
            'children' => array(
                'space/old_product' => array(
                    'icon' => 'icon-list',
                    'text' => '旧场地转换列表',
                    'des' => '旧场地转换列表',
                    'action' => '010',   //子操作:  增改删
                ),
                'space/convert_once' => array(
                    'icon' => 'icon-list',
                    'text' => '旧场地一键转换',
                    'des' => '旧场地一键转换',
                    'action' => '010',   //子操作:  增改删
                ),
                'space/spacepedia' => array(
                    'icon' => 'icon-list',
                    'text' => '场地百科列表',
                    'des' => '场地百科列表',
                    'action' => '010',   //子操作:  增改删
                ),
                'space/spacepedia_check' => array(
                    'icon' => 'icon-list',
                    'text' => '场地百科审核列表',
                    'des' => '场地百科审核列表',
                    'action' => '010',   //子操作:  增改删
                ),
                'space/space_item_list' => array(
                    'icon' => 'icon-list',
                    'text' => '子空间列表',
                    'des' => '子空间列表',
                    'action' => '010',   //子操作:  增改删
                ),
                'space/space_item_check' => array(
                    'icon' => 'icon-list',
                    'text' => '子空间审核列表',
                    'des' => '子空间审核列表',
                    'action' => '010',   //子操作:  增改删
                ),
                'space/new_space' => array(
                    'icon' => 'icon-list',
                    'text' => 'NEW_场地出租初审',
                    'des' => 'NEW_场地出租初审',
                    'action' => '010',   //子操作:  增改删
                ),
            )
        ),
        'site' => array(
            'icon' => 'icon-grid',
            'text' => '内容管理',
            'children' => array(
                'site/baike_112' => array(
                    'icon' => 'icon-list',
                    'text' => '空间类百科管理',
                    'des' => '百科类百科列表',
                    'action' => '010',   //子操作:  增改删
                ),
                'site/baike_200' => array(
                    'icon' => 'icon-list',
                    'text' => '文创类百科管理',
                    'des' => '文创类百科列表',
                    'action' => '010',   //子操作:  增改删
                ),
                'site/baike_300' => array(
                    'icon' => 'icon-list',
                    'text' => '发现类百科管理',
                    'des' => '发现类型百科列表',
                    'action' => '010',   //子操作:  增改删
                ),
                'site/baike_400' => array(
                    'icon' => 'icon-list',
                    'text' => '零售类百科管理',
                    'des' => '零售类百科管理',
                    'action' => '010',   //子操作:  增改删
                ),
                'site/my_baike' => array(
                    'icon' => 'icon-grid',
                    'text' => '我的百科',
                    'des' => '我的百科列表',
                    'action' => '010',   //子操作:  增改删
                ),
                'site/article' => array(
                    'icon' => 'icon-grid',
                    'text' => '文章管理',
                    'des' => '文章列表',
                    'action' => '010',   //子操作:  增改删
                ),
                'site/old_article' => array(
                    'icon' => 'icon-grid',
                    'text' => '文库管理',
                    'des' => '文库列表',
                    'action' => '010',   //子操作:  增改删
                ),
                'site/contribute' => array(
                    'icon' => 'icon-grid',
                    'text' => '投稿管理',
                    'des' => '投稿列表',
                    'action' => '010',   //子操作:  增改删
                ),

            )
        ),
        'public_number' => array(
            'icon' => 'icon-wallet',
            'text' => '公众号管理',
            'children' => array(
                'public_number/public_list' => array(
                    'icon' => 'icon-list',
                    'text' => '关键词管理列表',
                    'des' => '关键词管理列表',
                    'action' => '010',   //子操作:  增改删
                ),
                'public_number/wechat_article' => array(
                    'icon' => 'icon-list',
                    'text' => '微信文章管理列表',
                    'des' => '微信文章管理',
                    'action' => '010',   //子操作:  增改删
                ),
                'public_number/wechat_author' => array(
                    'icon' => 'icon-list',
                    'text' => '公众号管理列表',
                    'des' => '公众号管理',
                    'action' => '010',   //子操作:  增改删
                ),
                'public_number/article_log' => array(
                    'icon' => 'icon-list',
                    'text' => '文章采集日志',
                    'des' => '文章采集详情',
                    'action' => '010',   //子操作:  增改删
                ),
            )
        ),
        'element' => array(
            'icon' => 'icon-list',
            'text' => '信息查询',
            'children' => array(
                'element/product' => array(
                    'icon' => 'icon-list',
                    'text' => '产品列表',
                    'des' => '产品列表',
                    'action' => '010',   //子操作:  增改删
                ),
                'element/product_update' => array(
                    'icon' => 'icon-list',
                    'text' => '完整产品列表（查询用）',
                    'des' => '完整产品列表',
                    'action' => '010',   //子操作:  增改删
                ),
                'account/account_info' => array(
                    'icon' => 'icon-list',
                    'text' => '账户列表',
                    'des' => '账户列表',
                    'action' => '010',   //子操作:  增改删
                ),
                'element/order' => array(
                    'icon' => 'icon-list',
                    'text' => '订单列表',
                    'des' => '订单列表',
                    'action' => '010',   //子操作:  增改删
                ),
                'element/demand_take' => array(
                    'icon' => 'icon-list',
                    'text' => '带看场地列表',
                    'des' => '带看场地列表',
                    'action' => '010',   //子操作:  增改删
                ),
                'element/demand_recommend' => array(
                    'icon' => 'icon-list',
                    'text' => '需求推荐列表',
                    'des' => '需求推荐列表',
                    'action' => '010',   //子操作:  增改删
                ),
                'element/operate_log' => array(
                    'icon' => 'icon-list',
                    'text' => '操作日志列表',
                    'des' => '操作日志列表',
                    'action' => '010',   //子操作:  增改删
                ),
                'element/demand_recommend' => array(
                    'icon' => 'icon-list',
                    'text' => '场地推荐列表',
                    'des' => '场地推荐列表',
                    'action' => '010',   //子操作:  增改删
                ),
                'element/order_log' => array(
                    'icon' => 'icon-list',
                    'text' => '订单操作日志列表',
                    'des' => '订单操作日志列表',
                    'action' => '010',   //子操作:  增改删
                ),
                'operation/demand_tender_statistics' => array(
                    'icon' => 'icon-docs',
                    'text' => '需求报价统计',
                    'des' => '需求报价统计',
                    'action' => '010',   //子操作:  增改删
                ),
            )

        ),
        'finance' => array(
            'icon' => 'icon-book-open',
            'text' => '财务管理',
            'children' => array(
//                'finance/income_check/99bill' => array(
//                    'icon' => 'icon-plus',
//                    'text' => '快钱收款对账',
//                    'des' => '快钱天下提供的收款账户对账',
//                ),
                'finance/income_check/pnr' => array(
                    'icon' => 'icon-notebook',
                    'text' => '汇付收款对账',
                    'des' => '汇付天下提供的收款账户对账',
                    'action' => '010',   //子操作:  增改删
                ),
                'finance/cash_check/pnr' => array(
                    'icon' => 'icon-envelope-open',
                    'text' => '提现代发审核',
                    'des' => '用户提现申请的前置审核',
                    'action' => '010',   //子操作:  增改删
                ),
                'finance/cash_result/pnr' => array(
                    'icon' => 'icon-envelope-letter',
                    'text' => '提现代发结果确认',
                    'des' => '提现代发操作的结果确认',
                    'action' => '010',   //子操作:  增改删
                ),
                'finance/global_static' => array(
                    'icon' => 'icon-bar-chart',
                    'text' => '平台收支统计',
                    'des' => '平台收付款总计及相关手续费',
                    'action' => '010',   //子操作:  增改删
                ),
                'finance/auto_cash' => array(
                    'icon' => 'icon-bar-chart',
                    'text' => '自动提现列表',
                    'des' => '自动提现列表',
                    'action' => '010',   //子操作:  增改删
                ),
            )
        ),
        'pm' => array(
            'icon' => 'icon-wallet',
            'text' => '产品管理',
            'children' => array(
                'product/category' => array(
                    'icon' => 'icon-share',
                    'text' => '产品分类',
                    'des' => '',
                    'action' => '010',   //子操作:  增改删
                ),
                'pm/tags' => array(
                    'icon' => 'icon-tag',
                    'text' => '全局标签',
                    'des' => '',
                    'action' => '010',   //子操作:  增改删
                ),
                'pm/interface' => array(
                    'icon' => 'icon-tag',
                    'text' => 'Api接口',
                    'des' => '用于储存接口的字段信息',
                    'action' => '010',   //子操作:  增改删
                ),
            )
        ),

        'account' => array(
            'icon' => 'icon-users',
            'text' => '账号管理',
            'children' => array(
                'account/change_vendor' => array(
                    'icon' => 'icon-puzzle',
                    'text' => '账户变更供应商',
                    'des' => '',
                    'action' => '010',   //子操作:  增改删
                ),
                'account/reset_password' => array(
                    'icon' => 'icon-settings',
                    'text' => '重置密码',
                    'des' => '',
                    'action' => '010',   //子操作:  增改删
                ),
                'marketing/account_check' => array(
                    'icon' => 'icon-user',
                    'text' => '账户更改审核',
                    'des' => '',
                    'action' => '010',   //子操作:  增改删
                ),
                'marketing/vendor_account_identity' => array(
                    'icon' => 'icon-user',
                    'text' => '实名认证',
                    'des' => '',
                    'action' => '010',   //子操作:  增改删
                ),
                'marketing/vendor_change_account' => array(
                    'icon' => 'icon-user',
                    'text' => '供应商变更账户审核',
                    'des' => '',
                    'action' => '010',   //子操作:  增改删
                ),
            )
        ),
        'inner_management' => array(
            'icon' => 'icon-volume-2',
            'text' => '人事管理',
            'children' => array(
                'inner_management/admin_management?action=integral_list' => array(
                    'icon' => 'icon-bell',
                    'text' => '积分列表',
                    'des' => '',
                    'action' => '010',   //子操作:  增改删
                ),
                'notice/list' => array(
                    'icon' => 'icon-bell',
                    'text' => '公告管理',
                    'des' => '',
                    'action' => '010',   //子操作:  增改删
                ),
                'inner_management/admin_management' => array(
                    'icon' => 'icon-bell',
                    'text' => '管理员列表',
                    'des' => '',
                    'action' => '010',   //子操作:  增改删
                ),
                'inner_management/personal' => array(
                    'icon' => 'icon-bell',
                    'text' => '个人资料修改',
                    'des' => '',
                    'action' => '010',   //子操作:  增改删
                ),
            )
        ),
        'system_related' => array(
            'icon' => 'fa fa-cog',
            'text' => '系统相关',
            'children' => array(
                'cron/cron_list' => array(
                    'icon' => 'fa fa-clock-o',
                    'text' => '计划任务',
                    'des' => '',
                    'action' => '010',   //子操作:  增改删
                ),
                'cron/rebuild_index' => array(
                    'icon' => 'fa fa-clock-o',
                    'text' => '重建索引',
                    'des' => '',
                    'action' => '010',   //子操作:  增改删
                ),
                'cron/update_search_keyword' => array(
                    'icon' => 'fa fa-clock-o',
                    'text' => '搜索关键词更新',
                    'des' => '',
                    'action' => '010',   //子操作:  增改删
                ),
            )
        ),
        'hidden' => array(
            'no_auth' => '1',
            'text' => '其他',
            'children' => array(
                '../system/personal' => array(
                    'no_auth' => '1',
                ),
                'notice/list' => array(
                    'no_auth' => '1',
                ),
                'space/space_level' => array(
                    'text' => '更换场地级别权限',
                ),
                'sales/demand_export' => array(
                    'text' => '导出demand',
                    'no_auth' => '1',
                ),
            )
        ),
    );
}