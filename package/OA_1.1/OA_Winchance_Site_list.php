<?php
/**
 * Created by PhpStorm.
 * User: bxy
 * Date: 2016/4/7
 * Time: 17:29
 * 文创需求管理
 */
class OA_Winchance_Site_list {
    static function handle(){
        $action = empty($_REQUEST['action'])?'list':$_REQUEST['action'];
        switch($action)
        {
            case 'list':
                self::siteList();
                break;
        }
    }
    // 文创场地列表
    static function siteList(){
        $citys = Data_Mysql_Table_Winchance::$citys;
        Tpl_Smarty::assign('citys',$citys);
        $step = Data_Mysql_Table_Winchance_Site::$step;
        Tpl_Smarty::assign('step',$step);
        $site_type = Data_Mysql_Table_Winchance_Site::$site_type;
        Tpl_Smarty::assign('site_type',$site_type);
        $data = Api_Winchance_Site_list::siteList($_REQUEST);
        Tpl_Smarty::assign('_data',$data);
        if(!empty($_REQUEST['type']) && $_REQUEST['type']=="export"){
            if(!empty($data)){
                self::exportData($data);
            }else{
                Func_Header::back('没有要导出的数据！');
            }
        }
        Tpl_Smarty::display('OA_Static::winchance/site_list.tpl');
    }
    // 数据导出
    static function exportData($data){
//        q($data);
        $cols = array("#ID","场地名称","工作状态","类型","城市","场地基本资料以及需求","本周进展","下周计划","负责人","备注");
        $list = array();
            foreach($data as $k=>$v){
                $list[$k][] = $v['id'];
                $list[$k][] = $v['site_name'];
                $list[$k][] = $v['step'];
                $list[$k][] = $v['site_type'];
                $list[$k][] = $v['city'];
                $des_1='';
                if(!empty($v['des'][0])){
                    foreach($v['des'] as $kk=>$vv){
                        $des_1 = $des_1.intval($kk+1).'、'.$vv.'   ';
                    }
                }
                $list[$k][] = $des_1;
                $plan_1 = '';
                if(!empty($v['plan']['本周进展'][0])){
                    foreach($v['plan']['本周进展'] as $kk=>$vv){
                        $plan_1 = $plan_1.intval($kk+1).'、'.$vv.'   ';
                    }
                }
                $list[$k][] = $plan_1;
                $plan_2 = '';
                if(!empty($v['plan']['下周计划'][0])){
                    foreach($v['plan']['下周计划'] as $kk=>$vv){
                        $plan_2 = $plan_2.intval($kk+1).'、'.$vv.'   ';
                    }
                }
                $list[$k][] = $plan_2;
                $list[$k][] = $v['operator'];
                $note = '';
                if(!empty($v['note'][0])){
                    foreach($v['note'] as $kk=>$vv){
                        $note = $note.intval($kk+1).'、'.$vv.'   ';
                    }
                }
                $list[$k][] = $note;
            }
        Func_Csv::writeRow($cols,$list);
        return ;
    }
}

