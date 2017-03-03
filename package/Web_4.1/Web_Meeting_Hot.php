<?php
/**
 * Created by PhpStorm.
 * User: adu
 * Date: 2016/11/11
 * Time: 17:17
 */

class Web_Meeting_Hot extends Web_Global {

    static $hos_list ;

    static function getList($type='',$limit=''){
        $list_data = self::$hos_list;
        if(empty($list_data)){
            $condition =array(
//                "category in ('特色空间','大型空间','中型空间','酒店','影院')",
                'status=?'=>1
            );
            if($type){
                $condition["category=?"] =$type;
            }else{
                $condition[] = "category in ('特色空间','大型空间','中型空间','酒店','影院')";
            }
            $limit = $limit ? $limit:200;
            $list_data = Data_Mysql_Table_Annual_Meeting::select('*',$condition,'order by create_time desc',$limit);
        }
        $type_data = array();
       foreach($list_data as $k=>$v){
            if($v['category']==$type){
                $type_data[] = $v;
            }
       }
        return $type_data;
    }

    function getTeSeList(){
        return self::getList('特色空间');
    }
    function getLargeScaleList(){
        return self::getList('大型空间');
    }
    function getMidSizeList(){
        return self::getList('中型空间');
    }
    function getHotelList(){
        return self::getList('酒店');
    }
    function getCinemaList(){
        return self::getList('影院');
    }
    function getWandaList(){
        return self::getList('万达专题');
    }

    function id(){
        $id = substr(Core::$urls['action'], 0, -5);
        return Func_NumEncode::d($id)-100;
    }

    function detail(){
        $id = $this->id();
        if(!is_numeric($id)){
            Func_Header::notFound();
        }
        $info = Data_Mysql_Table_Annual_Meeting::select('*',array('id=?'=>$id),'',1);
        if(!$info||!isset($info[0])){
            Func_Header::back('非法请求');
        }
        $info[0]['info_img']=json_decode($info[0]['info_img'],1);
        return $info[0];
    }

    function recommendList(){
        $info = $this->detail();
        $list= array();
        if($info){
            $list  = self::getList($info['category'],10);
            if($list){
                foreach($list as $k=>$v){
                    if($v['id']==$info['id']){
                        unset($list[$k]);
                    }
                }
            }
        }
        return $list;
    }
} 