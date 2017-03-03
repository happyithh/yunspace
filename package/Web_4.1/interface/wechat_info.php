<?php
/**
 * Created by PhpStorm.
 * User: adu
 * Date: 2016/11/8
 * Time: 10:43
 */
Func_Header::to('','http://www.yunspace.com.cn');
die();
$list = Data_Mysql_Table_Account_Wechat::select('id,update_time,user_info',array('update_time>?'=>1477929624),'order by id desc',3000);
$data =array();
if($list){
    foreach($list as $k=>$v){
        if(!empty($v['user_info'])){
            $v['user_info'] = json_decode($v['user_info'],1);
            $sex ='';
            $nickname = '';
            $province='';
            $city='';
            $update_time = '';
            if(isset($v['user_info']['sex'])){
                $sex  = $v['user_info']['sex']==1?'男':'女';
            }

            if(isset($v['user_info']['nickname'])){
                $nickname = Func_String::utf8($v['user_info']['nickname']);
            }
            if(isset($v['user_info']['province'])){
                $province = Func_String::utf8($v['user_info']['province']);
            }
            if(isset($v['user_info']['city'])){
                $city = Func_String::utf8($v['user_info']['city']);
            }

            if(!empty($v['update_time'])){
                $update_time =  date('Y-m-d H:i:s',$v['update_time']);
            }
            $data[]=array(
                $v['id'],$update_time, $nickname, $sex,$province,$city
            );
        }
    }
}
$table_header = array('id','授权时间','昵称','性别','省份','城市');
Func_Csv::writeRow($table_header,$data);