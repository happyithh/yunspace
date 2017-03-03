<?php

/**
 * Created by PhpStorm.
 * User: zzc
 * Date: 2015/10/30
 * Time: 10:03
 */
class Api_Space_Item_GetItemInfoByConditions extends Api
{

    /**
     * @param $args
     *根据手机号获取item_id
     * @return string
     */
    static function  getItemIdsByPhone($args)
    {
        $request = Func_Input::filter(array(
            'phone' => 'phone'
        ), $args);
        if (empty($request['phone'])) {
            return false;
        }
        $conditions['phone =? AND status>=?'] = array($request['phone'], 0);
//        Data_Mysql_Table_Space_Item::debug(1);
        $data = Data_Mysql_Table_Space_Item::select('id', $conditions, '', 100);
        if(empty($data[0])){
            return false;
        }
        $ids  =array();
        foreach($data as $val){
            $ids[] =$val['id'];
        }
        return implode(',',$ids);

    }
}