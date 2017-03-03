<?php
/**
 * Created by PhpStorm.
 * User: adu
 * Date: 2016/1/12
 * Time: 18:05
 */
set_time_limit(0);
   $list =  Data_Mysql_Table_Space_Item::select("id,media,is_thc",array('is_thc=?'=>3),'',50);
    if(!empty($list)){
        foreach($list as $k=>$v){
            $v['media'] = json_decode($v['media'],1);
            if(!empty($v['media'])){
                foreach($v['media'] as $kk=>$vv){
                    $v['media'][$kk]['path'] ='thc_'.$vv['path'];
                }
                $v['media'] = json_encode($v['media']);
                Data_Mysql_Table_Space_Item::query('UPDATE {table} SET media=?,is_thc=? WHERE id=?',array($v['media'],4,$v['id']));
            }else{
                Data_Mysql_Table_Space_Item::query('UPDATE {table} SET is_thc=? WHERE id=?',array(4,$v['id']));
            }
            echo "更新:".($v['id'])."<br>";
        }
    }else{
        q('结束');
    }

