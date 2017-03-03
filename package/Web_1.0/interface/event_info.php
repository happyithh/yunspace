<?php
if (!strpos(Core::$urls['action'], '.html') || substr(Core::$urls['action'], -5) !== '.html') {
    Func_Header::notFound();
}
//读取产品信息
$eventId = substr(Core::$urls['action'], 0, -5);
$rs = Data_Mysql_Table_Event_Info::select('{table}.*', array('id' => $eventId), '', 1, '{table} LEFT JOIN {prefix}event_case ON {table}.id = {prefix}event_case.event_id');

if (empty($rs[0]['id'])) {
    Func_Header::notFound();
}
$event = $rs[0];
$event['media'] = json_decode($event['media'], 1);
//读取案例
$case = Data_Mysql_Table_Event_Case::select('{table}.event_id,{table}.case_name,{table}.des,{table}.media', array(
    'event_id' => $event['id'],
), '', 4, '{table} LEFT JOIN {prefix}event_info ON  {prefix}event_info.id = {table}.event_id');
$case_media = array();
if (!empty($case)) {
    foreach ($case as $ck => $cv) {
        $case[$ck]['media'] = json_decode($cv['media'], 1);
        //处理案例图片数组
        if (!empty($case[$ck]['media'])) {
            $case_media = array_merge($case_media, $case[$ck]['media'][1]);
            foreach ($case[$ck]['media'][1] as $cvk => $cvv) {
                $case[$ck]['logo']=$cvv['path'];
                //主图
                if (strpos($cvv['tags'], '@主图') !== false) {
                    $case[$ck]['logo'] = $cvv['path'];
                    break;
                }
            }
        }
        $case_name_arr = explode(']', $cv['case_name']);
        $case[$ck]['case_name'] = empty($case_name_arr[1]) ? $case_name_arr[0] : $case_name_arr[1];
    }
}
if (!is_array($event['media'])) {
    $event['media'] = array();
}
foreach ($case_media as $v) {
    $event['media'] [] = $v;
}
//处理活动图片数组
if (!empty($event['media'])) {
    $media = array();
    foreach ($event['media'] as $k => $v) {
        if(empty($v['name'])){
            $v['name']='其他图片';
        }
        if (!empty($v['tags'])) {
            $tags = explode(',', $v['tags']);
            foreach ($tags as $tv) {
                if (empty($tv)) {
                    $tv = '其他';
                }
                $media[$tv][1][$k] = array($v['name'], $v['path']);
            }
        } else {
            $media['其他'][1][$k] = array($v['name'], $v['path']);
        }
    }
    $i = 1;
    foreach ($media as $k => $v) {
        $media[$k][0] = $i;
        $i += count($v[1]);
    }
    $event['media'] = $media;
}
$event['attr'] = json_decode($event['attr'], 1);
Data_Config_Site::seo($event['event_name']);
Tpl_Smarty::assign('info', $event);
Tpl_Smarty::assign('events', $case);
Tpl_Smarty::assign('nav_index', 4);
Tpl_Smarty::display('Web', 'event-info.tpl');