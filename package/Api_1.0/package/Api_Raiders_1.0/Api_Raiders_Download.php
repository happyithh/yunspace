<?php
/**
 * Created by PhpStorm.
 * User: Liuyuping
 * Date: 2015/9/7
 * Time: 11:30
 */
@session_start();
class Api_Raiders_Download extends Api
{
    static function handle($args='')
    {
        $result =   self::handleDownload($args);
        return $result;
    }


    //下载量
    static function  handleDownload($data)
    {
        $request = Func_Input::filter(array(
            'id' => 'int',
        ),$data);

       /* if(empty($_SESSION['user'])) {
            return  $result = array(
                'status' => 3,
                'msg' => "请先登录",
                "data" => ''
            );
        } else {*/
            $conditions['status =?'] = 1;
            $conditions['id = ?'] = $request['id'];
            $rs = Data_Mysql_Table_Raiders_Info::select('*', $conditions);

            //如果没有相关数据，则显示404页面
            if (empty($rs[0]['id'])) {
                return  $result = array(
                    'status' => 0,
                    'msg' => "没有相关数据",
                    "data" => ''
                );
            }else {
                $rows = Data_Mysql_Table_Raiders_Info::query("UPDATE {table} set  download = download+1 WHERE id =?", array($request['id']), 1);
                if ($rows > 0) {
                    $rs[0]['accessory'] = json_decode($rs[0]['accessory'], 1);
                    $result = array(
                        'status' => 1,
                        'msg' => "成功",
                        "data" => $rs[0]['accessory']['name'],
                    );
                } else {
                    $result = array(
                        'status' => 0,
                        'msg' => "失败",
                        "data" => ''
                    );
                }
                return $result;
            }

        /*}*/
    }
}
