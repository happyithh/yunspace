<?php
/**
 * Created by PhpStorm.
 * User: bxy
 * Date: 2016/5/4
 * Time: 14:55
 * 零售页面合作品牌
 */
class Api_Retail_Cooperation_Brand_List extends Api{
    static function brandList(){
        $data = Data_Mysql_Table_Cooperation_Brand::select('id,title,logo',array('status'=>1,'type'=>1),'ORDER BY is_good DESC,  update_time DESC',10);
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