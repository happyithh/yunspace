<?php

/**
 * Created by PhpStorm.
 * User: yaoli
 * Date: 2015/9/17
 * Time: 11:00
 *  案例列表和案例详情
 */
class  Api_Case_List_And_Info extends Api
{
    /*
     * 获取活动案例信息
     * @param   $table 是否查询update表  update 代表查询case_update表  info 代表查询case_info表
     * $param   $id     案例id
     */
    static function getCaseInfo($table="info",$id){
        $caseInfo=array();
        //获取旧的案例数据
        if($table=="update"){
            $case = Data_Mysql_Table_Event_Case::subTable('_update')->select('{table}.id,{table}.case_name,{table}.des,{table}.media,{prefix}event_info.event_name,{prefix}event_info.attr,{prefix}event_info.id as event_id', array(
                'id' => $id,
            ), '', 1, '{table} LEFT JOIN {prefix}event_info ON {table}.event_id = {prefix}event_info.id');
        }else{
            $case = Data_Mysql_Table_Event_Case::select('{table}.id,{table}.case_name,{table}.des,{table}.media,{prefix}event_info.event_name,{prefix}event_info.attr,{prefix}event_info.id as event_id', array(
                'id' => $id,
            ), '', 1, '{table} LEFT JOIN {prefix}event_info ON {table}.event_id = {prefix}event_info.id');
        }
        if(empty($case[0])){
            return self::request('error','',"案例信息不存在！");
        }
        $caseInfo = $case[0];
        $caseInfo['media'] = json_decode($caseInfo['media'], 1);
        $caseInfo['event_name'] = '[' . $caseInfo['event_id'] . ']&nbsp;' . $caseInfo['event_name'];

        if (!empty($caseInfo['media'])) {
            $media=$caseInfo['media'];
            unset($caseInfo['media']);
            $caseInfo['attr'] = $media[0];
            $caseInfo['media'] = $media[1];
        } else {
            $caseInfo['attr'] = json_decode($caseInfo['attr'], 1);
        }
        return self::request('success',$caseInfo,'返回案例信息详情');
    }

    /*
   * 获取产品或套餐下的活动列表信息
   * @param   $table 是否查询update表  update 代表查询case_update表  info 代表查询case_info表
   * $param   $id    产品id或套餐Id
   */
    static function getCaseList($object_id,$table="info",$object_type='product'){
        $caseList=$condition=array();
        //读取案例
        if($object_type=="product"){
            $condition['{table}.product_id = ?']=$object_id;
        }elseif($object_type=="set"){
            $condition['{table}.product_set_id = ?']=$object_id;
        }elseif($object_type=="vendor"){
            $condition['{table}.vendor_id = ?']=$object_id;
        }
        if($table=="info"){
            $caseList = Data_Mysql_Table_Event_Case::page(0, 5, '{table}.id,{table}.case_name,{table}.des,{table}.media,{table}.status,{prefix}event_info.event_name,{prefix}event_info.id as event_id,{prefix}event_info.attr', $condition,"", '{table} LEFT JOIN {prefix}event_info ON {table}.event_id = {prefix}event_info.id');
        }else{
            $caseList = Data_Mysql_Table_Event_Case::subTable('_update')->page(0, 5, '{table}.id,{table}.case_name,{table}.des,{table}.media,{table}.status,{prefix}event_info.event_name,{prefix}event_info.id as event_id,{prefix}event_info.attr', $condition,'', '{table} LEFT JOIN {prefix}event_info ON {table}.event_id = {prefix}event_info.id');
        }
        if (!empty($caseList['rows'])) {
            foreach ($caseList['rows'] as $k => $v) {
                if (!empty($v['media'])) {
                    $media = json_decode($v['media'], 1);
                    unset($caseList['rows'][$k]['media']);
                    $caseList['rows'][$k]['attr'] = $media[0];
                    $caseList['rows'][$k]['media'] = $media[1];
                } else {
                    $caseList['rows'][$k]['attr'] = json_decode($v['attr'], 1);
                }
                $caseList['rows'][$k]['event_name'] = '[' . $v['event_id'] . ']&nbsp;' . $v['event_name'];
            }
        }
        return self::request('success',$caseList,'返回案例列表');
    }

}