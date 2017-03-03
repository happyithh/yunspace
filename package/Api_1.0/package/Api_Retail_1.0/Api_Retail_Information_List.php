<?php
/**
 * Created by PhpStorm.
 * User: bxy
 * Date: 2016/5/4
 * Time: 15:05
 * 零售页面行业资讯
 */
class Api_Retail_Information_List extends Api{
    static function InformationList(){
        $conditions['status =?'] =1;
        $conditions['space_ids =?'] =10644;
        $conditions['logo !=?'] ='';
        $data = Data_Mysql_Table_Raiders_Info::select('id,title,logo',$conditions,'ORDER BY is_good DESC, update_time DESC',10);
        $dataNew = array();
        if(strstr(Core::$urls['path'],'/m/') && !empty($data)){
            foreach($data as $k=>$v){
                if($k==1 || $k==2){
                    $dataNew[1][] = $v;
                }elseif($k==6 || $k==7){
                    $dataNew[6][] = $v;
                }else{
                    $dataNew[$k]= $v;
                }
            }
        }else{
            $dataNew = $data;
        }
        return $dataNew;
    }
}