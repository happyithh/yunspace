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
                'operation/overtime_order' => array(
                    'icon' => 'icon-list',
                    'text' => '超时订单处理',
                    'des' => '处理各类超时的订单',
                    'action' => '010',   //子操作:  增改删
                ),
                'operation/buyer_account_identity' => array(
                    'icon' => 'icon-shield',
                    'text' => '用户实名认证',
                    'des' => '审核客户的实名认证',
                    'action' => '010',   //子操作:  增改删
                ),
                'operation/personal_account_identity' => array(
                    'icon' => 'icon-shield',
                    'text' => '个人实名认证v1.0',
                    'des' => '个人实名认证v1',
                    'action' => '010',   //子操作:  增改删
                ),
                'operation/company_account_identity' => array(
                    'icon' => 'icon-shield',
                    'text' => '企业实名认证v1.0',
                    'des' => '企业实名认证v1',
                    'action' => '010',   //子操作:  增改删
                ),
                'operation/sms_notice_config' => array(
                    'icon' => 'icon-bell',
                    'text' => '短信通知设置',
                    'des' => '业务流转各个环节的短信/邮件通知',
//                    'action' => '010',   //子操作:  增改删
                ), 'operation/sms_notice_set' => array(
                    'icon' => 'icon-bell',
                    'text' => '短信通知设置1.1',
                    'des' => '业务流转各个环节的短信/邮件通知',
                    'action' => '111',   //子操作:  增改删
                ),
                'website/home_page_banner_v2' => array(
                    'icon' => 'icon-screen-desktop',
                    'text' => '首页内容管理v2',
                    'des' => '网站首页Banner和推荐内容管理',
                    'action' => '111',   //子操作:  增改删
                ),
                'website/home_page_banner_v4' => array(
                    'icon' => 'icon-screen-desktop',
                    'text' => '首页内容管理v4',
                    'des' => '网站首页Banner和推荐内容管理',
                    'action' => '111',   //子操作:  增改删
                ),
                'website/home_page_v2' => array(
                    'icon' => 'icon-screen-desktop',
                    'text' => '首页场地管理V2',
                    'des' => '其他内容管理',
//                    'action' => '111',   //子操作:  增改删
                ),
                'operation/pa_management' => array(
                    'icon' => 'icon-screen-desktop',
                    'text' => '广告位管理',
                    'des' => '网站内的广告位管理',
                    'action' => '111',   //子操作:  增改删
                ),
                'product_search/update_product_info_list' => array(
                    'icon' => 'icon-flag',
                    'text' => '地理数据处理',
                    'des' => '产品地理位置信息处理',
                    'action' => '010',   //子操作:  增改删
                ),
                'event_map_info/getUnsolvedEvent' => array(
                    'icon' => 'icon-flag',
                    'text' => '活动地理数据处理',
                    'des' => '活动地理位置信息处理',
                    'action' => '111',   //子操作:  增改删
                ),
                'event/list' => array(
                    'icon' => 'icon-list',
                    'text' => '活动列表',
                    'des' => '活动列表',
                    'action' => '111',   //子操作:  增改删
                ),
                'event/brand' => array(
                    'icon' => 'icon-list',
                    'text' => '活动品牌',
                    'des' => '活动品牌',
                    'action' => '111',   //子操作:  增改删
                ),
                'search_log/search' => array(
                    'icon' => 'icon-magnifier',
                    'text' => '搜索统计',
                    'des' => '统计用户搜索的详情',
                    'action' => '111',
                ),
                'marketing/help-center' => array(
                    'icon' => 'icon-heart',
                    'text' => '帮助中心',
                    'des' => '帮助内容的添加',
                    'action' => '111',//子操作:  增改删
                ),
                'weixin/manage' => array(
                    'icon' => 'fa fa-ticket',
                    'text' => '活动售票管理',
                    'des' => '',
                    'action' => '111',   //子操作:  增改删
                ),
                'weixin/orderManage' => array(
                    'icon' => 'fa fa-ticket',
                    'text' => '活动售票订单管理',
                    'des' => '',
                    'action' => '111',   //子操作:  增改删
                ),
                'operation/year_vote' => array(
                    'icon' => 'icon-list',
                    'text' => '年会投票列表',
                    'des' => '年会投票列表',
                    'action' => '111',     //子操作:  增改删
                ),
                'operation/raiders_list' => array(
                    'icon' => 'icon-list',
                    'text' => '云·发现列表',
                    'des' => '云·发现列表',
                    'action' => '111',     //子操作:  增改删
                ),
                'operation/raiders_check_list' => array(
                    'icon' => 'icon-list',
                    'text' => '投稿审核列表',
                    'des' => '投稿审核列表',
                    'action' => '010',     //子操作:  增改删
                ),
                'operation/raiders_candidate' => array(
                    'icon' => 'icon-list',
                    'text' => '资讯数据候选',
                    'des' => '资讯数据候选',
                    'action' => '111',     //子操作:  增改删
                ),
                'oa/comment/info' => array(
                    'icon' => 'icon-list',
                    'text' => '评论列表',
                    'des' => '评论列表',
                    'action' => '111',     //子操作:  增改删
                ),
                'operation/form_manage' => array(
                    'icon' => 'icon-shield',
                    'text' => '表单管理',
                    'des' => '存储不同的表单事件',
                    'action' => '111',   //子操作:  增改删
                ),
                'operation/form_retail' => array(
                    'icon' => 'icon-shield',
                    'text' => '零售短租',
                    'des' => '零售短租相关订单列表',
                    'action' => '010',   //子操作:  增改删
                ),
                'operation/winchance' => array(
                    'icon' => 'icon-list',
                    'text' => '文创项目列表',
                    'des' => '文创项目',
                    'action' => '111',     //子操作:  增改删
                ),
                'operation/broke_reward' => array(
                    'icon' => 'icon-shield',
                    'text' => '爆料管理',
                    'des' => '活动爆料奖励详情',
                    'action' => '111',   //子操作:  增改删
                ),
                'operation/vendor_join' => array(
                    'icon' => 'icon-docs',
                    'text' => '供应商加盟管理',
                    'des' => '管理供应商加盟的',
                    'action' => '010',   //子操作:  增改删
                ),
                'operation/cooperation_brand' => array(
                    'icon' => 'icon-docs',
                    'text' => '合作品牌管理',
                    'des' => '合作品牌管理',
                    'action' => '111',   //子操作:  增改删
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
                    'action' => '111',     //子操作:  增改删
                ),
                'winchance/site_list' => array(
                    'icon' => 'icon-list',
                    'text' => '文创场地报表',
                    'des' => '文创场地报表',
                    'action' => '111',     //子操作:  增改删
                ),
                'winchance/site_add' => array(
                    'icon' => 'icon-list',
                    'text' => '添加文创场地',
                    'des' => '添加文创场地',
                    'action' => '111',     //子操作:  增改删
                ),
                'winchance/site_statistical' => array(
                    'icon' => 'icon-list',
                    'text' => '场地进度统计',
                    'des' => '文创场地进度统计',
                    'action' => '110',
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
                    'action' => '111',
                ),
                'winchance_new/winchance_list' => array(
                    'icon' => 'icon-list',
                    'text' => 'IP列表',
                    'des' => '显示已入驻IP/未入驻IP',
                    'action' => '111',     //子操作:  增改删
                ),
                'winchance_new/winchance_statistical' => array(
                    'icon' => 'icon-list',
                    'text' => 'IP数据报表',
                    'des' => 'IP数据统计表单',
                    'action' => '111',     //子操作:  增改删
                ),
                'winchance_new/fields_manage' => array(
                    'icon' => 'icon-list',
                    'text' => 'IP字段管理',
                    'des' => '编辑IP字段',
                    'action' => '111',
                ),
                'winchance_new/winchance_check' => array(
                    'icon' => 'icon-list',
                    'text' => 'IP审核',
                    'des' => 'IP审核',
                    'action' => '111',
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
                    'action' => '111',
                ),
                'winchance_order/order_statistical' => array(
                    'icon' => 'icon-list',
                    'text' => 'IP订单数据报表',
                    'des' => '订单统计报表',
                    'action' => '111',
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
                    'action' => '110',   //子操作:  增改删
                ),
                'operation/demand_operate' => array(
                    'icon' => 'icon-docs',
                    'text' => '需求管理',
                    'des' => '管理提出的需求',
                    'action' => '010',   //子操作:  增改删
                ),
                'demand_offer/space_archives' => array(
                    'icon' => 'icon-docs',
                    'text' => '场地的报价状态',
                    'des' => '场地的报价状态',
                    'action' => '010',   //子操作:  增改删
                ),
                'operation/demand_tender' => array(
                    'icon' => 'icon-docs',
                    'text' => '需求报价列表',
                    'des' => '需求报价列表',
                    'action' => '010',   //子操作:  增改删
                ),
                'operation/demand_tender?action=is_my' => array(
                    'icon' => 'icon-docs',
                    'text' => '我的需求报价列表',
                    'des' => '我的需求报价列表',
                    'action' => '010',   //子操作:  增改删
                ),
                'operation/demand_offer_count' => array(
                    'icon' => 'icon-docs',
                    'text' => '统计列表',
                    'des' => '统计列表',
                    'action' => '010',   //子操作:  增改删
                ),
                'operation/demand_tender_list_statistics?action=list_v3' => array(
                    'icon' => 'icon-docs',
                    'text' => 'NEW报价统计列表',
                    'des' => 'NEW报价统计列',
                    'action' => '010',   //子操作:  增改删
                ),
//                //临时
//                'operation/demand_offer' => array(
//                    'icon' => 'icon-docs',
//                    'text' => '进入报价系统（临时）',
//                    'des' => '需求报价列表',
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
                    'action' => '110',   //子操作:  增改删
                ),

                'sales/my_demand_list' => array(
                    'icon' => 'icon-plus',
                    'text' => '我的需求',
                    'des' => '我领取的所有联系人的所有需求',
                    'action' => '110',   //子操作:  增改删
                ),
                'sales/team_demand_list' => array(
                    'icon' => 'icon-list',
                    'text' => '组需求管理',
                    'des' => '组需求管理',
                    'action' => '110',   //子操作:  增改删
                ),
                'sales/department_demand_list' => array(
                    'icon' => 'icon-list',
                    'text' => '部门需求管理',
                    'des' => '部门需求',
                    'action' => '110',   //子操作:  增改删
                ),
                'sales/team_demand_list_new' => array(
                    'icon' => 'icon-list',
                    'text' => '组需求管理1.1',
                    'des' => '组需求管理',
                    'action' => '110',   //子操作:  增改删
                ),
                'sales/department_demand_list_new' => array(
                    'icon' => 'icon-list',
                    'text' => '城市需求管理1.1',
                    'des' => '城市需求',
                    'action' => '110',   //子操作:  增改删
                ),
                'sales/department_demand_list_all' => array(
                    'icon' => 'icon-list',
                    'text' => '所有需求管理',
                    'des' => '全国所有需求',
                    'action' => '110',   //子操作:  增改删
                ),
//                'sales/department_demand_all' => array(
//                    'icon' => 'icon-list',
//                    'text' => '所有需求管理（报价）',
//                    'des' => '全国所有需求',
//                    'action' => '110',   //子操作:  增改删
//                ),
                'sales/department_demand_lists_all' => array(
                    'icon' => 'icon-list',
                    'text' => '所有需求管理（新）',
                    'des' => '全国所有需求',
                    'action' => '110',   //子操作:  增改删
                ),
                'sales/department_demand_city_partner' => array(
                    'icon' => 'icon-list',
                    'text' => '城市需求管理（合伙人）',
                    'des' => '城市需求管理（合伙人）',
                    'action' => '110',   //子操作:  增改删
                ),
                'sales/demand_statistics' => array(
                    'icon' => 'icon-shield',
                    'text' => '需求统计',
                    'des' => '统计需求进度',
                    'action' => '111',   //子操作:  增改删
                ),
                'sales/order_statistics' => array(
                    'icon' => 'icon-shield',
                    'text' => '订单统计',
                    'des' => '统计订单详情',
                    'action' => '110',   //子操作:  增改删
                ),
                'sales/demand_record' => array(
                    'icon' => 'icon-shield',
                    'text' => '需求回访',
                    'des' => '需求记录情况',
                    'action' => '111',   //子操作:  增改删
                ),
                'sales/contact_record' => array(
                    'icon' => 'icon-docs',
                    'text' => '联系记录列表',
                    'des' => '联系记录列表',
                    'action' => '010',   //子操作:  增改删
                ),
//                'sales/contact_detail?action=add&type=1&is_my=1' => array(
//                    'icon' => 'icon-plus',
//                    'text' => '创建联系人',
//                    'des' => '公共联系人库',
//                    'action' => '110',   //子操作:  增改删
//                ),
//                'sales/contact_list' => array(
//                    'icon' => 'icon-users',
//                    'text' => '联系人库',
//                    'des' => '公共联系人库',
//                    'action' => '010',   //子操作:  增改删
//                ),
//                'sales/my_contact_list' => array(
//                    'icon' => 'icon-list',
//                    'text' => '我的联系人',
//                    'des' => '我的联系人',
//                    'action' => '010',   //子操作:  增改删
//                ),
//                'sales/list' => array(
//                    'icon' => 'icon-docs',
//                    'text' => '我的客户',
//                    'des' => '管理提出的需求',
//                    'action' => '010',   //子操作:  增改删
//                ),
//                'sales/contact_iska_urgent_list' => array(
//                    'icon' => 'icon-users',
//                    'text' => 'KA组-紧急联系人',
//                    'des' => '公共联系人库',
//                    'action' => '010',   //子操作:  增改删
//                ),
//                'sales/contact_notka_urgent_list' => array(
//                    'icon' => 'icon-users',
//                    'text' => '标准组-紧急联系人',
//                    'des' => '公共联系人库',
//                    'action' => '010',   //子操作:  增改删
//                ),
//                'sales/contact_urgent_list' => array(
//                    'icon' => 'icon-users',
//                    'text' => '部门紧急联系人',
//                    'des' => '公共联系人库',
//                    'action' => '010',   //子操作:  增改删
//                ),
//                'sales/team_contact_list' => array(
//                    'icon' => 'icon-list',
//                    'text' => '组联系人',
//                    'des' => '组联系人',
//                    'action' => '010',   //子操作:  增改删
//                ),
//                'sales/department_contact_list' => array(
//                    'icon' => 'icon-users',
//                    'text' => '部门联系人',
//                    'des' => '部门联系人（已领取）',
//                    'action' => '010',   //子操作:  增改删
//                ),
//                'sales/department_manage' => array(
//                    'icon' => 'icon-pie-chart',
//                    'text' => '部门管理',
//                    'des' => '管理部门成员的指标与配额',
//                    'action' => '111',   //子操作:  增改删
//                ),
//                'sales/department_sum' => array(
//                    'icon' => 'icon-graph',
//                    'text' => '部门统计',
//                    'des' => '统计部门相关数据',
////                    'action' => '111',   //子操作:  增改删
//                ),
            )
        ),

        'operation_new' => array(
            'icon' => 'icon-users',
            'text' => '运维部管理',
            'children' => array(
                'operation_new/my_vendor_new' => array(
                    'icon' => 'icon-like',
                    'text' => '我的供应商-New',
                    'des' => '自身负责的供应商列表',
                    'action' => '010',   //子操作:  增改删
                ),
                'operation_new/all_vendor_new' => array(
                    'icon' => 'icon-grid',
                    'text' => '所有供应商-New',
                    'des' => '所有供应商-New',
                    'action' => '010',   //子操作:  增改删
                ),
                'operation_new/all_vendor_city' => array(
                    'icon' => 'icon-grid',
                    'text' => '城市供应商-New',
                    'des' => '城市供应商-New',
                    'action' => '010',   //子操作:  增改删
                ),
                'operation_new/all_vendor_check' => array(
                    'icon' => 'icon-grid',
                    'text' => '所有供应商审核',
                    'des' => '所有供应商审核',
                    'action' => '010',   //子操作:  增改删
                ),
//                'operation_new/delete_img' => array(
//                    'icon' => 'icon-grid',
//                    'text' => '图片水印处理',
//                    'des' => '采集图片水印处理',
//                    'action' => '010',   //子操作:  增改删
//                ),
            )
        ),

        'marketing' => array(
            'icon' => 'icon-fire',
            'text' => '市场部管理',
            'children' => array(
                'marketing/quick_create_product' => array(
                    'icon' => 'icon-grid',
                    'text' => '快速创建产品',
                    'des' => '快速添加产品，供应商，联系人，账号',
                    'action' => '010',   //子操作:  增改删
                ),
//                'marketing/commission_order' => array(
//                    'icon' => 'icon-list',
//                    'text' => '订单佣金管理',
//                    'des' => '处理佣金订单的订单',
//                    'action' => '010',   //子操作:  增改删
//                ),
//                'marketing/my_demand_list' => array(
//                    'icon' => 'icon-plus',
//                    'text' => '我的需求列表',
//                    'des' => '我领取的所有联系人的所有需求',
//                    'action' => '110',   //子操作:  增改删
//                ),
//                'marketing/contact_detail?action=add&type=21&is_my=1' => array(
//                    'icon' => 'icon-plus',
//                    'text' => '创建联系人',
//                    'des' => '公共联系人库',
//                    'action' => '110',   //子操作:  增改删
//                ),
//                'marketing/contact_urgent_list' => array(
//                    'icon' => 'icon-users',
//                    'text' => '紧急联系人库',
//                    'des' => '公共联系人库',
//                    'action' => '010',   //子操作:  增改删
//                ),
//                'marketing/contact_list' => array(
//                    'icon' => 'icon-list',
//                    'text' => '联系人库',
//                    'des' => '公共联系人库',
//                    'action' => '010',   //子操作:  增改删
//                ),
//                'marketing/my_contact_list' => array(
//                    'icon' => 'icon-grid',
//                    'text' => '我的联系人',
//                    'des' => '我的联系人',
//                    'action' => '010',   //子操作:  增改删
//                ),
//                'marketing/my_vendor_list' => array(
//                    'icon' => 'icon-like',
//                    'text' => '我的供应商',
//                    'des' => '自身负责的账户下的供应商列表',
//                    'action' => '010',   //子操作:  增改删
//                ),
//                'marketing/my_vendor_new' => array(
//                    'icon' => 'icon-like',
//                    'text' => '我的供应商-New',
//                    'des' => '自身负责的供应商列表',
//                    'action' => '010',   //子操作:  增改删
//                ),
//                'marketing/all_vendor_new' => array(
//                    'icon' => 'icon-grid',
//                    'text' => '所有供应商-New',
//                    'des' => '所有供应商-New',
//                    'action' => '010',   //子操作:  增改删
//                ),
//                'marketing/list' => array(
//                    'icon' => 'icon-like',
//                    'text' => '我的供应商账户',
//                    'des' => '销售为活动需求推荐相应产品',
//                    'action' => '010',   //子操作:  增改删
//                ),
//                'marketing/team_contact_list' => array(
//                    'icon' => 'icon-grid',
//                    'text' => '组联系人',
//                    'des' => '所属组联系人',
//                    'action' => '010',   //子操作:  增改删
//                ),
//                'marketing/team_vendor' => array(
//                    'icon' => 'icon-grid',
//                    'text' => '组供应商',
//                    'des' => '组供应商',
//                    'action' => '010',   //子操作:  增改删
//                ),
//                'marketing/team_vendor_check' => array(
//                    'icon' => 'icon-grid',
//                    'text' => '组供应商审核',
//                    'des' => '组供应商/产品/案例审核',
//                    'action' => '010',   //子操作:  增改删
//                ),
//                'marketing/department_contact_list' => array(
//                    'icon' => 'icon-grid',
//                    'text' => '部门联系人',
//                    'des' => '部门所有已领取的联系人',
//                    'action' => '111',   //子操作:  增改删
//                ),
//                'marketing/department_vendor' => array(
//                    'icon' => 'icon-grid',
//                    'text' => '部门供应商',
//                    'des' => '部门供应商',
//                    'action' => '010',   //子操作:  增改删
//                ),
//                'marketing/all_vendor_list' => array(
//                    'icon' => 'icon-grid',
//                    'text' => '所有供应商',
//                    'des' => '所有供应商',
//                    'action' => '010',   //子操作:  增改删
//                ),
//                'marketing/department_vendor_check' => array(
//                    'icon' => 'icon-grid',
//                    'text' => '部门供应商审核',
//                    'des' => '部门供应商/产品/案例审核',
//                    'action' => '010',   //子操作:  增改删
////                ),
//                'marketing/all_vendor' => array(
//                    'icon' => 'icon-grid',
//                    'text' => '所有供应商审核',
//                    'des' => '所有供应商审核',
//                    'action' => '010',   //子操作:  增改删
//                ),
//                'marketing/department_manage' => array(
//                    'icon' => 'icon-pie-chart',
//                    'text' => '部门管理',
//                    'des' => '管理部门成员的指标与配额',
//                    'action' => '010',   //子操作:  增改删
//                ),
                'marketing/department_sum' => array(
                    'icon' => 'icon-graph',
                    'text' => '部门统计',
                    'des' => '统计部门相关数据',
//                    'action' => '111',   //子操作:  增改删
                ),
                'marketing/vendor_candidate' => array(
                    'icon' => 'icon-grid',
                    'text' => '供应商候选数据',
                    'des' => '供应商候选数据',
                    'action' => '010',   //子操作:  增改删
                ),
//                'marketing/audit/vendor_info' => array(
//                    'icon' => 'icon-puzzle',
//                    'text' => '(废弃)供应商信息审核',
//                    'des' => '所有人商家开拓与成长统计',
//                    'action' => '010',   //子操作:  增改删
//                ),
//                'marketing/audit/product_info' => array(
//                    'icon' => 'icon-wallet',
//                    'text' => '(废弃)供应商产品审核',
//                    'des' => '',
//                    'action' => '010',   //子操作:  增改删
//                ),
//                'marketing/audit/case_info' => array(
//                    'icon' => 'icon-tag',
//                    'text' => '(废弃)供应商案例审核',
//                    'des' => '',
//                    'action' => '010',   //子操作:  增改删
//                ),
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
                'space/spacepedia_repeat' => array(
                    'icon' => 'icon-list',
                    'text' => '场地百科去重复列表',
                    'des' => '场地百科去重复列表',
                    'action' => '010',   //子操作:  增改删
                ),
                'space/demand_tag' => array(
                    'icon' => 'icon-list',
                    'text' => '需求标签列表',
                    'des' => '需求标签列表',
                    'action' => '011',   //子操作:  增改删
                ),
                'space/pedia_space_assign' => array(
                    'icon' => 'icon-list',
                    'text' => '百科/子空间授权列表',
                    'des' => '百科/子空间授权列表',
                    'action' => '011',   //子操作:  增改删
                ),
                'space/new_space' => array(
                    'icon' => 'icon-list',
                    'text' => 'NEW_场地出租初审',
                    'des' => 'NEW_场地出租初审',
                    'action' => '011',   //子操作:  增改删
                ),
                // 'space/pedia_space_update' => array(
                //     'icon' => 'icon-list',
                //     'text' => '百科地理位置更新',
                //     'des' => '百科地理位置更新',
                //     'action' => '011',   //子操作:  增改删
                // ),
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
                    'action' => '111',   //子操作:  增改删
                ),
                'site/old_article' => array(
                    'icon' => 'icon-grid',
                    'text' => '文库管理',
                    'des' => '文库列表',
                    'action' => '111',   //子操作:  增改删
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
                'element/vendor' => array(
                    'icon' => 'icon-list',
                    'text' => '供应商列表',
                    'des' => '供应商列表',
                    'action' => '010',   //子操作:  增改删
                ),
                'element/product_set' => array(
                    'icon' => 'icon-list',
                    'text' => '套餐列表',
                    'des' => '套餐列表',
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
                'element/set_recommend' => array(
                    'icon' => 'icon-list',
                    'text' => '套餐推荐列表',
                    'des' => '套餐推荐列表',
                    'action' => '010',   //子操作:  增改删
                ),
                'element/order_log' => array(
                    'icon' => 'icon-list',
                    'text' => '订单操作日志列表',
                    'des' => '订单操作日志列表',
                    'action' => '010',   //子操作:  增改删
                ),
                'element/sign_list' => array(
                    'icon' => 'icon-list',
                    'text' => '签约订单列表',
                    'des' => '签约订单查询列表',
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
                    'action' => '111',   //子操作:  增改删
                ),
                'pm/tags' => array(
                    'icon' => 'icon-tag',
                    'text' => '全局标签',
                    'des' => '',
                    'action' => '111',   //子操作:  增改删
                ),
                'pm/interface' => array(
                    'icon' => 'icon-tag',
                    'text' => 'Api接口',
                    'des' => '用于储存接口的字段信息',
                    'action' => '111',   //子操作:  增改删
                ),
            )
        ),

        'account' => array(
            'icon' => 'icon-users',
            'text' => '账号管理',
            'children' => array(
//                'account/user_corp' => array(
//                    'icon' => 'icon-user-following',
//                    'text' => '公司用户管理',
//                    'des' => '',
//                    'action' => '111',   //子操作:  增改删
//                ),
//                'account/vendor' => array(
//                    'icon' => 'icon-puzzle',
//                    'text' => '供应商用户管理',
//                    'des' => '',
//                    'action' => '111',   //子操作:  增改删
//                ),
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
                    'action' => '111',   //子操作:  增改删
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
                'marketing/broker_account_identity' => array(
                    'icon' => 'icon-user',
                    'text' => '经纪人审核',
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
//                'inner_management/market_member' => array(
//                    'icon' => 'icon-bell',
//                    'text' => '市场部-成员管理',
//                    'des' => '',
//                    'action' => '111',   //子操作:  增改删
//                ),
                'inner_management/admin_management?action=integral_list' => array(
                    'icon' => 'icon-bell',
                    'text' => '积分列表',
                    'des' => '',
                    'action' => '111',   //子操作:  增改删
                ),
                'notice/list' => array(
                    'icon' => 'icon-bell',
                    'text' => '公告管理',
                    'des' => '',
                    'action' => '111',   //子操作:  增改删
                ),
                'inner_management/admin_management' => array(
                    'icon' => 'icon-bell',
                    'text' => '管理员列表',
                    'des' => '',
                    'action' => '111',   //子操作:  增改删
                ),
                'inner_management/personal' => array(
                    'icon' => 'icon-bell',
                    'text' => '个人资料修改',
                    'des' => '',
                    'action' => '111',   //子操作:  增改删
                ),
                'inner_management/sign_in' => array(
                    'icon' => 'icon-bell',
                    'text' => '外出签到列表',
                    'des' => '',
                    'action' => '110',   //子操作:  增改删
                ),
                'inner_management/sign_in_check' => array(
                    'icon' => 'icon-bell',
                    'text' => '外出签到审核列表',
                    'des' => '',
                    'action' => '110',   //子操作:  增改删
                ),
            )
        ),
//        'data_expand' => array(
//            'icon' => 'icon-volume-2',
//            'text' => '数据拓展',
//            'children' => array(
//                'data_expand/data_list' => array(
//                    'icon' => 'icon-bell',
//                    'text' => '待拓展列表',
//                    'des' => '',
//                    'action' => '010',   //子操作:  增改删
//                ),
//                'data_expand/send_msg' => array(
//                    'icon' => 'icon-bell',
//                    'text' => '发送短信',
//                    'des' => '',
//                    'action' => '010',   //子操作:  增改删
//                ),
//                'data_expand/data_activate_list' => array(
//                    'icon' => 'icon-bell',
//                    'text' => '激活列表',
//                    'des' => '',
//                    'action' => '010',   //子操作:  增改删
//                ),
//                'data_expand/expand_list' => array(
//                    'icon' => 'icon-bell',
//                    'text' => '拓展列表',
//                    'des' => '',
//                    'action' => '010',   //子操作:  增改删
//                ),
//                'data_expand/my_expand_list' => array(
//                    'icon' => 'icon-bell',
//                    'text' => '我的拓展列表',
//                    'des' => '',
//                    'action' => '010',   //子操作:  增改删
//                ),
//                'operation/vendor_join' => array(
//                    'icon' => 'icon-docs',
//                    'text' => '供应商加盟管理',
//                    'des' => '管理供应商加盟的',
//                    'action' => '010',   //子操作:  增改删
//                ),
//            )
//        ),
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
                'cron/import_log' => array(
                    'icon' => 'fa fa-clock-o',
                    'text' => '导入日志',
                    'des' => '',
                    'action' => '010',   //子操作:  增改删
                ),
                'cron/user_track_list' => array(
                    'icon' => 'fa fa-clock-o',
                    'text' => '用户轨迹',
                    'des' => '',
                    'action' => '010',   //子操作:  增改删
                ),
                'cron/track_referer' => array(
                    'icon' => 'fa fa-clock-o',
                    'text' => '轨迹来源统计',
                    'des' => '',
                    'action' => '010',   //子操作:  增改删
                ),
                'cron/track_land' => array(
                    'icon' => 'fa fa-clock-o',
                    'text' => '轨迹落地统计',
                    'des' => '',
                    'action' => '010',   //子操作:  增改删
                ),
            )
        ),
        'grab_order' => array(
            'icon' => 'fa fa-cog',
            'text' => '抢单分配',
            'children' => array(
                'grab_order/list' => array(
                    'icon' => 'fa fa-clock-o',
                    'text' => '抢单列表',
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
                'pm/add_son' => array(
                    'no_auth' => '1',
                ),
                '../system/personal' => array(
                    'no_auth' => '1',
                ),
                'marketing/handle_product' => array(
                    'no_auth' => '1',
                ),
                'marketing/commission_order' => array(
                    'no_auth' => '1',
                ),
                'marketing/contact_urgent_list' => array(
                    'no_auth' => '1',
                ),
                'product_search/update_product_info_list' => array(
                    'no_auth' => '1',
                ),
                'notice/list' => array(
                    'no_auth' => '1',
                ),
                'space/space_level' => array(
                    'text' => '更换场地级别权限',
                ),
            )
        ),
    );
}