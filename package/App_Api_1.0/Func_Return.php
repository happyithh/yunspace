<?php
/**
 * Created by PhpStorm.
 * User: Administrator
 * Date: 2015/5/28
 * Time: 14:42
 */
// 已作废
Class  Func_Return{

    static function jsonReturn($data,$info='',$status=''){
        header('Content-Type:application/json; charset=utf-8');
        $array = array(
            'data'=>$data,
            'info'=>$info,
            'status'=>$status
        );
        exit(json_encode($array));
    }
}