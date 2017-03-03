<?php

/**
 * Created by PhpStorm.
 * User: adu
 * Date: 15/7/9
 * Time: 15:09
 */
@session_start();
class Api_Account_Identity_Personal_List extends Api
{
//    //个人身份认证信息
//    static function handle()
//    {
//        //判断是否登录 //判断权限
////        if(empty($_SESSION['user']['id'])){
////            $result = self::request('error','',"没有登录");
////            return $result;
////        }
//        //接受参数
//        /**
//         * 登录用户id
//         */
//
//        //返回结果：提交结果，
//        //插入成功 1  失败0 失败原因
//        $result = self::getList($_REQUEST);
//        return $result;
//    }
    //返回参数
    static function getList($args)
    {
        $request = Func_Input::filter(array(
            'status'=>'int',
            'search_title'=>'string'
        ),$args);
        $conditions=array();
        if (!empty($request['search_title'])) {
                 $request['search_title'] = trim($_REQUEST['search_title']);
                $conditions = self::handleSearch($request['search_title']);
        }
        if(isset($request['status']) && $request['status']!=99){
            $conditions['tb1.status=?'] = $request['status'];
        }
        $table = "{table} as tb1 left join {prefix}account as tb2 ON tb1.account_id=tb2.id";
        $cols = "tb1.*,tb2.username,tb2.phone,tb2.email";
//        Q($conditions);
        $rs = Data_Mysql_Table_Account_Identity_Personal_Info::page(0, 15, $cols, $conditions, 'ORDER BY tb1.create_time DESC',$table);//, 'account_type' => $accountType
        if($rs['rows']){
            $result =self::request('success',$rs,"返回成功");
            return $result;
        }else{
            $result =self::request('error','',"没有认证用户信息");
            return $result;
        }

    }

    //  搜索

    static function handleSearch($search_title)
    {
        //名称或ID筛选
        if (!empty($search_title)) {
            if (is_numeric($search_title)) {
                $conditions = array(
                    " (tb2.id=? or tb2.username like ? or tb2.phone=?)" => array($search_title, '%'.$search_title.'%', $search_title)
                );
            } else {
                $conditions = array(
                    " (tb2.username=? or tb1.fullname like ? or tb2.email=?)" => array($search_title, '%'.$search_title.'%', $search_title)
                );
            }
        }
        return $conditions;
    }

}

