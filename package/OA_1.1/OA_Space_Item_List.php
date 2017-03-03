<?php

/**
 * Created by PhpStorm.
 * User: bxy
 * Date: 2016/1/13
 * Time: 10:41
 *
 * 子空间列表
 *
 */
class OA_Space_Item_List
{
    static function handle()
    {
        $action = !empty($_REQUEST['action']) ? $_REQUEST['action'] : 'list';
        switch ($action) {
            case 'list':
                self::getItemList();
                break;
            case 'update_info':
                self::updateInfo();
                break;
            case 'update_price':
                self::updatePrice();
                break;
            case 'updateSearchItem':
                Api_Search_Space_Item::getWaitingUpdateSpaceItemList();
                self::getItemList();
                break;
            default:
                self::getItemList();
        }
    }

    // 获取子空间列表信息
    static function getItemList()
    {
        if (!empty($_REQUEST['search'])) {
            $request = Func_Input::filter(array(
                'status' => 'int',
                'item_name' => 'string',
                'space_name' => 'string',
                'city' => 'string',
                'start_time' => 'string',
                'end_time' => 'string',
            ), $_REQUEST['search']);
            if (!empty($request['item_name'])) {
                $request['item_name'] = trim($request['item_name'], '');
                if(is_numeric($request['item_name'])){
                    $conditions['t1.id=?'] = $request['item_name'];
                }else{
                    $conditions['t1.item_name=?'] = $request['item_name'];
                }
            }
            if (!empty($request['space_name'])) {
                $request['space_name'] = trim($request['space_name'], '');
                if(is_numeric($request['space_name'])){
                    $conditions['t2.id=?'] = $request['space_name'];
                }else{
                    $conditions['t2.space_name=?'] = $request['space_name'];
                }
            }
            if(!empty($request['status'])){
                if($request['status']!=-2){
                    $conditions['t1.status =?']=$request['status'];
                }else{
                    $conditions['t1.status =?']=0;
                }
            }
            if(!empty($request['city'])){
                $conditions['t1.city=?'] = $request['city'];
            }
            if(!empty($request['start_time']) && !empty($request['end_time'])){
                if(strtotime($request['start_time'].'00:00:00') > strtotime($request['end_time'].'23:59:59')){
                    Func_Header::back('请选择正确的起止时间！');
                }else{
                    $conditions['t1.create_time between ? and ?'] = array(strtotime($request['start_time'].'00:00:00'),strtotime($request['end_time'].'23:59:59'));
                }
            }elseif(!empty($request['start_time']) && empty($request['end_time'])){
                $conditions['t1.create_time >?'] =  strtotime($request['start_time'].'00:00:00');
            }elseif(empty($request['start_time']) && !empty($request['end_time'])){
                $conditions['t1.create_time <?'] =  strtotime($request['end_time'].'23:59:59');
            }
            $urls = '&search[item_name]='.$request['item_name'].'&search[city] ='.$request['city'].'&search[status]='.$request['status'].'&search[start_time]='.$request['start_time'].'&search[end_time]='.$request['end_time'].'&search[space_name]='.$request['space_name'];
        }
        $type = empty($_REQUEST['type']) ? 'all' : $_REQUEST['type'];
        switch ($type) {
            case 'no_phone':
                $conditions['t1.phone =?'] = '';
                break;
            case 'no_email':
                $conditions['t1.email =?'] = '';
                break;
            case 'no_price':
                $conditions['(min_price =? OR max_price =?)'] = array(100, 100);
        }
        $conditions['t1.status !=?'] = -1;
//        Data_Mysql_Table_Space_Item::debug(1);
        $data = Data_Mysql_Table_Space_Item::page(0, 15, 't1.*,t2.space_name', $conditions, 'ORDER BY t1.create_time DESC','{table} as t1 LEFT JOIN {prefix}spacepedia as t2 ON t1.space_id = t2.id');
        if(!empty($urls)){
            Tpl_Smarty::assign('url', $urls);
        }
        Tpl_Smarty::assign('type', $type);
        Tpl_Smarty::assign('_data', $data);
        Tpl_Smarty::display('OA_Static::spacepedia/space_item_list.tpl');
    }

    // 更新子空间联系信息
    static function updateInfo()
    {
        Core::output('');
        $request = Func_Input::filter(array(
            'id' => 'int',
            'contacts' => 'string',
            'phone' => 'string',
            'email' => 'string',
        ), $_REQUEST);
        $data['contacts'] = $request['contacts'];
        $data['phone'] = $request['phone'];
        $data['email'] = $request['email'];
        $data['update_time'] = time();
        $res = Data_Mysql_Table_Space_Item::update(array('id' => $request['id']), $data);
        if (!empty($res[0])) {
            Func_Output::json('success', '', '  联系信息更新成功！');
        } else {
            Func_Output::json('error', '', '联系信息更新失败！');
        }
    }

    // 更新价格信息
    static function updatePrice()
    {
        Core::output('');
        $request = Func_Input::filter(array(
            'id' => 'int',
            'min_price' => 'int',
            'max_price' => 'int',
            'price_unit' => 'string',
        ), $_REQUEST);

        if ((!empty($request['min_price']) && !empty($request['max_price'])) && ($request['min_price'] > $request['max_price'])) {
            Func_Output::json('error', '', '请填写正确的价格区间！');
        }
        $request['min_price'] = empty($request['min_price']) ? 1 : $request['min_price'];
        $request['max_price'] = empty($request['max_price']) ? 1 : $request['max_price'];
        $data['min_price'] = $request['min_price'] * 100;
        $data['max_price'] = $request['max_price'] * 100;
        $data['price_unit'] = $request['price_unit'];
        $data['update_time'] = time();
        $res = Data_Mysql_Table_Space_Item::update(array('id' => $request['id']), $data);
        if (!empty($res[0])) {
            Func_Output::json('success', '', '  价格信息更新成功！');
        } else {
            Func_Output::json('error', '', '价格信息更新失败！');
        }
    }
}