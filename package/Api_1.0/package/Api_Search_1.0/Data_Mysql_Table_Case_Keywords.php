<?php

/**
 * Created by PhpStorm.
 * User: bxy
 * Date: 2016/7/1
 * Time: 13:49
 *
 * 过往案例关键词储存表  即 子空间搜索时使用的 用途字段
 * 注：活动类型与过往案例是一对多的关系
 *
 */
class Data_Mysql_Table_Case_Keywords extends Data_Mysql_Table
{
    public $cols = array(
        'case_name' => '50',  // 过往案例名称
        'active_type' => '50',  // 活动类型
        'click' => '50',
        'create_time' => 'int',
        'update_time' => 'int',
        'status' => 'int',
    );
    public $index = array(
        'case_name,active_type' => 'u',
        'case_name' => 'i',
        'active_type' => 'i',
    );

    // 获取所有活动类型 (即用途，注：搜索条件显示使用)
        static function getActiveName()
    {
        $conditions[] = 'status !=-1';
        $data = Data_Mysql_Table_Case_Keywords::select('active_type', $conditions, 'GROUP BY active_type ORDER BY id ASC', 50);
        $data_new = array();
        if (!empty($data)) {
            foreach ($data as $k => $v) {
                $data_new[] = $v['active_type'];
            }
        }else{
            self::setCase();
            self::getActiveName();
        }
        $data_new = array_unique($data_new);
        return $data_new;
    }

    // 过往案例数据脚本
    static function setCase()
    {
        $active = self::$activeTypeName;
        if (!empty($active)) {
            foreach ($active as $k => $v) {
                $data['active_type'] = $k;
                foreach($v as $kk=>$vv){
                    $data['case_name'] = $vv;
                    $data['create_time'] = time();
                    Data_Mysql_Table_Case_Keywords::insert($data);
                }
            }
        }

    }

    // 活动类型下的活动案例
    static public $activeTypeName = array(
        '展览展示' => array('展览展示', '公益展览', '艺术展出', '主题展览'),
        '商业发布' => array('商业发布', '新品发布会', '品牌发布会', '商业发布会', '奢饰品发布会'),
        '零售短租' => array('零售短租', '快闪店', '店中店', 'DP点'),
        '晚会年会' => array('晚会年会', '颁奖晚会', '年会晚宴', '答谢晚宴'),
        '演出走秀' => array('演出走秀', '时尚走秀', '演唱演出'),
        '论坛会议' => array('论坛会议', '会议会务', '行业博览会'),
        '婚礼宴会' => array('婚礼宴会', '婚礼喜宴', '公司宴会', '宴会会议'),
        '路演地推' => array('路演地推'),
        '拓展团建' => array('拓展团建', '户外拓展', '团建'),
        '讲座沙龙' => array('讲座沙龙', '培训讲座', '演讲', '沙龙'),
        '体验品鉴' => array('体验品鉴', '主题体验', '专享品鉴'),
        '主题派对' => array('主题派对', '生日聚会'),
        '创意活动' => array('创意活动', '快闪行动', '枕头大战'),
        '亲子活动' => array('亲子活动', '全家总动员', '亲子公益'),
        '试乘试驾' => array('试乘试驾', '汽车嘉年华', '驾考培训', '比赛'),
        '文体娱乐' => array('文体娱乐'),
    );
}