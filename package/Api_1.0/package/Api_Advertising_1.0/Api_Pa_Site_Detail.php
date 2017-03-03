<?php

/**
 * Created by PhpStorm.
 * User: bxy
 * Date: 2015/10/23
 * Time: 14:27
 */
class Api_Pa_Site_Detail extends Api
{
    static function getSiteDetail($args)
    {
        $request=Func_Input::filter(array(
            'id'=>'int',
        ));
        if(!empty($request['id'])){
            $conditions['id']=$request['id'];
        }
        $conditions['status !=?']=-1;
        $res = Data_Mysql_Table_Pa_Site::select('*', $conditions);
        $res[0]['size']=json_decode($res[0]['size'],1);
        return $res;
    }
}