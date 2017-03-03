<?php
/**
 * Created by PhpStorm.
 * User: adu
 * Date: 2016/11/10
 * Time: 15:46
 */
@session_start();
class Api_Annual_Meeting_Space_Auto_Complete  extends Api{
    static function handle()
    {
        if (empty($_SESSION['administrator']['id'])) {
            return false;
        }else{
            return self::companySearch();
        }
    }

    static function companySearch()
    {

        $request = Func_Input::filter(array(
            'q' => 'string',
        ));
        if (!$request['q']) {
            return false;
        }
        $condition =array(
//            "({table}.space_id = ? OR {prefix}spacepedia.space_name like ?)" => array($request['q'] , '%'.$request['q'] . '%'),
            "{table}.status=?"=>1
        );
        if(is_numeric($request['q'])){
            $condition['{table}.space_id = ? OR {prefix}spacepedia.space_name like ?'] =array($request['q'] , '%'.$request['q'].'%');
        }else{
            $condition['{prefix}spacepedia.space_name like ?'] =array('%'.$request['q'] . '%');
        }
//        $condition =array(
////            "({table}.space_id = ? OR {prefix}spacepedia.space_name like ?)" => array($request['q'] , '%'.$request['q'] . '%'),
//            "{table}.status=>?"=>1
//        );
        $cols="{table}.item_name,{table}.space_id,{prefix}spacepedia.space_name";
        $order="ORDER BY {prefix}spacepedia.space_name DESC";
        $table="{table} LEFT JOIN {prefix}spacepedia ON {table}.space_id = {prefix}spacepedia.id";
//        Data_Mysql_Table_Space_Item::debug(1);
        $data=Data_Mysql_Table_Space_Item::select($cols,$condition,$order,20,$table);

        foreach ($data as $key => $val) {
            $ajax_arr['results'][$key]['id'] = $val['space_name']."-".$val['item_name'];
            $ajax_arr['results'][$key]['name'] = $val['space_name']."-".$val['item_name'];
        }
        return $ajax_arr;


//        $request = Func_Input::filter(array(
//            'q' => 'string',
//        ), $_REQUEST);
//        $conditions['status !=?'] = -1;
//        if (!empty($request['q'])) {
//            $conditions['company like ?'] = $request['q'] . '%';
//            $data = Data_Mysql_Table_Winchance_Company::select('*', $conditions, 'ORDER BY create_time DESC', 10);
//        }
//        $dataNew = array();
//        if (!empty($data)) {
//            foreach ($data as $k => $v) {
//                $dataNew['results'][$k]['name'] = $v['company'];
//                $dataNew['results'][$k]['id'] = $v['company'];
//            }
//        }
//        return $dataNew;

    }
} 