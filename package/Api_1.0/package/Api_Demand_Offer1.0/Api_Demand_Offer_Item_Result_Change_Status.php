<?php
/**
 * Created by PhpStorm.
 * User: adu
 * Date: 2015/12/9
 * Time: 16:30
 */
class Api_Demand_Offer_Item_Result_Change_Status extends Api
{
    static function handle()
    {
        return self::changeStatus($_REQUEST);
    }

    static function changeStatus($args)
    {

        $request = Func_Input::filter(array(
            'item_id' => 'int',
            'expand_status' => 'int',
        ), $args);
        if (empty($request['item_id']) || empty($request['expand_status'])) {
            return self::request('error', "", "参数错误!");
        }
        $space_item_info = Data_Mysql_Table_Space_Item::select("*", array('id=?' => $request['item_id']), '', 1);
        if (empty($space_item_info)) {
            return self::request('error', '', '数据错误。');
        }
        $dataItem = array(
            'expand_status' => $request['expand_status'],
        );
        $rs = Data_Mysql_Table_Space_Item::update(array('id=?' => $request['item_id']), $dataItem);
        if ($rs) {
            return self::request('success', $request, "添加报价短信列表成功!");
        } else {
            return self::request('error', "", "添加报价短信失败!");
        }
    }
}