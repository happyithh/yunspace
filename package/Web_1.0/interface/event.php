<?php
/**
 * Created by PhpStorm.
 * User: Jim
 * Date: 2015/2/26
 * Time: 15:22
 */

$cols = '{table}.id,logo,event_name,{prefix}event_case.media';
$list = Data_Mysql_Table_Event_Info::page(0, 20, $cols, array('status' => 1, '{prefix}event_case.id IS NOT NULL'), 'ORDER BY {table}.id DESC', '{table} LEFT JOIN {prefix}event_case ON {table}.id = {prefix}event_case.event_id');
//如果logo为空，将调取event_case的图片作为logo
$case_media = array();
foreach ($list['rows'] as $k => $v) {
    if (empty($v['logo']) && isset($v['media'])) {
        $case_media = json_decode($v['media'], 1);
        foreach ($case_media[1] as $kk => $vv) {
            $list['rows'][$k]['logo'] = $vv['path'];
            break;
        }
    }
}
Data_Config_Site::seo('活动案例');
Tpl_Smarty::assign('list', $list);
Tpl_Smarty::assign('nav_index', 4);
Tpl_Smarty::display('Web', 'event-home.tpl');



