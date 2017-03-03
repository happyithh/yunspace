<?php
/**
 * Created by PhpStorm.
 * User: bxy
 * Date: 2015/7/14
 * Time: 14:24
 */
//
//class Api_Contact_Allot extends Api
//{
//    static function handle($args){
//        return self::handleContactAllotHead($args);
//    }
//    //快速分配负责人
//    static function handleContactAllotHead()
//    {
//        Core::output('');
//        $request = Func_Input::filter(
//            array(
//                'id'=>'int',
//                'response_account_id'=>'int'
//            ));
//        $res = Data_Mysql_Table_Demand::update(array('id'=>$request['id']),array('response_account_id'=>$request['response_account_id']));
//        if($res[0] >0 ){
//            Func_Output::json('success', '', ' 领取成功！');
//        }
//        Func_Output::json('error', '', '领取失败,请稍后再试！');
//    }
//}