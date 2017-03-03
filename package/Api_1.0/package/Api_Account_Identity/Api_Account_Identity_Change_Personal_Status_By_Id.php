<?php

/**
 * Created by PhpStorm.
 * User: adu
 * Date: 15/7/9
 * Time: 15:09
 */
@session_start();
class Api_Account_Identity_Change_Personal_Status_By_Id extends Api
{
//    //个人身份认证信息
//    static function handle()
//    {
//        //判断是否登录 //判断权限
//        if(empty($_SESSION['user']['id'])){
//            $result = self::request('error','',"没有登录");
//            return $result;
//        }
//        //接受参数
//        /**
//         * 登录用户id
//         */
//
//        //返回结果：提交结果，
//        //插入成功 1  失败0 失败原因
//        $result = self::getInfo();
//        return $result;
//    }
    //返回参数
    static function changeStatus($args)
    {
        $request = Func_Input::filter(array(
            'identity_id'=>'int',
            'status'=>'int',
            'rejectReason'=>'string'
        ),$args);
        if(empty($request['identity_id'])){
            $result =self::request('error','',"非法请求");
            return $result;
        }
        $request['rejectReason'] = isset($request['rejectReason']) ? trim($request['rejectReason']) :'';
        if(!empty($request['rejectReason']) && $request['status']>=0){
            $result =self::request('error','',"请求错误！");
            return $result;
        }
        $rs = Data_Mysql_Table_Account_Identity_Personal_Info::update(
            array('id'=>$request['identity_id']),
            array(
                'status'=>$request['status'],
                'refuse_reason'=>$request['rejectReason'],
                'pass_time'=>time(),
                'update_time'=>time()
            ));
        if($rs && isset($rs[0])){
            $info = Api_Account_Identity_Get_Personal_Info_By_Id::getInfo($request);
            $result =self::request('success',$info['data'],"修改成功");
            return $result;
        }else{
            $result =self::request('error','',"修改失败");
            return $result;
        }

    }

}

