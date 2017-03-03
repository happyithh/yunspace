<?php
/**
 * Created by PhpStorm.
 * User: Administrator
 * Date: 16-3-1
 * Time: 下午2:19
 */
class OA_Contact_Record{
    static function handle()
    {
        $action = empty($_REQUEST['action']) ? 'list' : $_REQUEST['action'];
        switch ($action) {
            case 'list':
                self::getContactRecord();
                break;
            default:
                self::getContactRecord();
                break;
        }
    }

    static function getContactRecord(){
        $conditions=array();
        if(!empty($_REQUEST['search'])){
            $search=Func_Input::filter(array(
                'demand_id'=>'int',
                'admin_id'=>'int',
                'start_time'=>'string',
                'end_time'=>'string',
                'city'=>'string',
            ),$_REQUEST['search']);
            if(!empty($search['demand_id'])){
                $conditions['{table}.demand_id = ?']=$search['demand_id'];
            }
            if(!empty($search['admin_id'])){
                $conditions['{table}.admin_id = ?']=$search['admin_id'];
            }
            if(isset($_REQUEST['search']['step']) && is_numeric($_REQUEST['search']['step'])){
                $conditions['{table}.step = ?']=$_REQUEST['search']['step'];
            }
            if (!empty($search['city'])) {
                $conditions['{prefix}demand.city =?'] =  $search['city'];
            }
            if (!empty($search['start_time']) && !empty($search['end_time'])) {
                if (strtotime($search['start_time']) > strtotime($search['end_time'])) {
                    Func_Header::back('请正确选择时间范围！！');
                } else {
                    $conditions['{prefix}demand.create_time between ? and ?'] = array(strtotime($search['start_time'].'00:00:00'), strtotime($search['end_time'].'23:59:59'));
                }
            } elseif (!empty($search['start_time']) && empty($search['end_time'])) {
                $conditions['{prefix}demand.create_time >= ?'] = strtotime($search['start_time'].'00:00:00');
            } elseif (empty($search['start_time']) && !empty($search['end_time'])) {
                $conditions['{prefix}demand.create_time <= ?'] = strtotime($search['end_time'].'23:59:59');
            }
        }
     //   Data_Mysql_Table_Demand_Step_Record::debug(1);
        $rs=Data_Mysql_Table_Demand_Step_Record::page(0,20,"{table}.*,{prefix}demand.demand_name,{prefix}demand.city ",$conditions,'ORDER BY {prefix}demand.create_time ASC',"{table} LEFT JOIN {prefix}demand ON {table}.demand_id = {prefix}demand.id");

        $administrator = OA_Demand_Lists_All::getMemberList("销售部");
        foreach($administrator as $k=>$v){
            $admin[$v['admin_id']]=$v;
        }
        Tpl_Smarty::assign('admin', $admin);
        Tpl_Smarty::assign("_data",$rs);
        Tpl_Smarty::assign('step', Data_Mysql_Table_Demand::$step_funnel);
        Tpl_Smarty::display("OA_Static","contact_record/contact_record_list.tpl");
    }

}