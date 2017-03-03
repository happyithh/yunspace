<?php

/**
 * Created by PhpStorm.
 * User: bxy
 * Date: 2016/5/9
 * Time: 13:19
 * 公司名称搜索  自动完成
 */
@session_start();

class Api_Winchance_New_Company_Auto_Complete extends Api
{
    static function handle()
    {
        if (empty($_SESSION['administrator']['id'])) {
            return false;
        }else{
            return self::companySearch();
        }
    }

    static function companySearch()
    {
        $request = Func_Input::filter(array(
            'q' => 'string',
        ), $_REQUEST);
        $conditions['status !=?'] = -1;
        if (!empty($request['q'])) {
            $conditions['company like ?'] = $request['q'] . '%';
            $data = Data_Mysql_Table_Winchance_Company::select('*', $conditions, 'ORDER BY create_time DESC', 10);
        }
        $dataNew = array();
        if (!empty($data)) {
            foreach ($data as $k => $v) {
                $dataNew['results'][$k]['name'] = $v['company'];
                $dataNew['results'][$k]['id'] = $v['company'];
            }
        }
        return $dataNew;

    }
}