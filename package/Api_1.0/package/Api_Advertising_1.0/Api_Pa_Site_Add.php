<?php

/**
 * Created by PhpStorm.
 * User: bxy
 * Date: 2015/10/22
 * Time: 10:02
 *
 * 广告位添加
 */
class Api_Pa_Site_Add extends Api
{
    static function siteAdd($args)
    {
        $request = Func_Input::filter(
            array(
                'id' => 'int',
                'site' => 'string',
                'description' => 'string',
                'size' => 'array',
                'adver_city' => 'int',
            ), $args);
//        q($request);
        $request['site']=trim($request['site'],"");
        if (empty($request['site'])) {
            return self::request('error', '', '广告位置不能为空！');
        }
        if(empty($request['id'])){
            $condition['site'] = $request['site'];
            $site = Data_Mysql_Table_Pa_Site::select('id', $condition);
            if (!empty($site[0])) {
                return self::request('error', '', '广告位不能重复添加！');
            }
        }
        $request['size']['width']=trim($request['size']['width'],'');
        if (empty($request['size']['width'])) {
            return self::request('error', '', '版位宽度不能为空！');
        }
        $request['size']['height']=trim($request['size']['height'],' ');
        if (empty($request['size']['height'])) {
            return self::request('error', '', '版位高度不能为空！');
        }
        $data['site'] = $request['site'];
        $data['description'] = $request['description'];
        $data['size'] = $request['size'];
        $data['adver_city'] = $request['adver_city'];
        @session_start();
        if (empty($request['id'])) {
            $data['create_time'] = time();
            $res = Data_Mysql_Table_Pa_Site::insert($data);
            if ($res > 0) {
                //创建操作日志
                $account_id = Api_Administrator_GetBaseAccountInfo::getBastAccountInfo(array('admin_id'=>$_SESSION['administrator']['id']));

                Data_Mysql_Table_Account_Log::insertAccountLog($account_id['account_id'],$_SESSION['administrator']['id'],'广告位创建--'.$data['site'],'广告位管理',$res[0]);
                return self::request('success', '', '添加成功！');
            } else {
                return self::request('error', '', '添加失败成功！');
            }
        } else {
            $data['update_time'] = time();
            $res = Data_Mysql_Table_Pa_Site::update(array('id'=>$request['id']),$data);
            if ($res > 0) {
                //创建操作日志
                $account_id = Api_Administrator_GetBaseAccountInfo::getBastAccountInfo(array('admin_id'=>$_SESSION['administrator']['id']));
                Data_Mysql_Table_Account_Log::insertAccountLog($account_id['account_id'],$_SESSION['administrator']['id'],'广告位修改--'.$data['site'],'广告位管理',$request['id']);
                return self::request('success', '', '修改成功！');
            } else {
                return self::request('error', '', '修改失败成功！');
            }
        }

    }
}
