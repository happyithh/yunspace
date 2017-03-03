<?php
/**
 * Created by PhpStorm.
 * User: Administrator
 * Date: 2016/6/22
 * Time: 9:51
 */
class Api_Get_Click_Sum extends Api
{
    static function handle(){
        return self::updateTopicSpaceCountClick();
    }
    static function updateTopicSpaceCountClick(){
        Core::output('');
        $request = Func_Input::filter(array(
            'tsid' => 'int',
        ));
        if(empty($request['tsid'])){
            return Api::request('error','','参数缺失！！');
        }
       Data_Mysql_Table_Topic_Space::query('UPDATE {table} SET click_num = click_num +? WHERE id = ?',array(1,$request['tsid']));
        return Api::request('success','','成功');
    }


    // static function handle(){
    //     Core::output('');
    //     $request = Func_Input::filter(
    //         array(
    //             'name' => 'string',
    //         ), $_REQUEST);
    //     $click_sum = Data_Config::get($request['name']);
    //   //  q($click_sum);
    //     if (empty($click_sum)) {
    //         $click_sum = 0;
    //     }
    //     $click_sum = $click_sum + 1;
    //     Data_Config::set($request['name'], $click_sum);
    //     return Api::request('success',Data_Config::get($request['name']),'chengg');
    // }
}


