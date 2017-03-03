<?php

/**
 * Created by PhpStorm.
 * User: bxy
 * Date: 2015/10/26
 * Time: 18:19
 *
 * 广告 PV获取
 */
class Api_Pa_Goto extends Api
{
    static function handle($args)
    {
     self::setClickCounter($args);
    }


    static function setClickCounter($args)
    {
        $request = Func_Input::filter(array(
            'id' => 'int',
        ),$args);
      if(!empty($request['id'])){
          // 解密
          $ad_id = Func_NumEncode::d($request['id']);
          // 广告链接 广告位id
          $link = Data_Mysql_Table_Pa::select('advertising_link,site_id',array('id'=>$ad_id));
          $date = date('ymdH');
          Data_Mysql_Table_Pa_Static::subTable(date('_Ym'))->query(
              'UPDATE {table} SET click = click +1 WHERE adv_id = ? AND date_time = ? AND site_id = ?',
              array(
                  $ad_id,
                  $date,
                  $link[0]['site_id'],
              )
          );

          if(!empty($link[0])){
//              q($link[0]);
              Func_Header::location($link[0]['advertising_link']);
          }

      }
    }
}