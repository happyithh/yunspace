<?php
/**
 * Created by PhpStorm.
 * User: adu
 * Date: 2015/10/23
 * Time: 14:59
 */
class Api_Space_Item_Get_Info extends  Api{
    static function handle(){
        return self::getInfo();
    }

    static function getInfo(){
        $request=Func_Input::filter(array(
            'item_id' => 'int',
        ));
        if(empty($request['item_id'])){
                return self::request('error',"","参数错误!");
        }
        $itemInfo = Api_Space_Item_List_And_Info::getSpaceItemInfoById($request['item_id']);
        if($itemInfo){
            return self::request('success',$itemInfo,"返回成功!");
        }else{
            return self::request('error',"","数据不存在!");
        }
    }
}