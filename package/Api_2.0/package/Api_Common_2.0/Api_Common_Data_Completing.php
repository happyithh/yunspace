<?php
/**
 * Created by PhpStorm.
 * User: adu
 * Date: 2016/11/23
 * Time: 10:35
 */

class Api_Common_Data_Completing extends Api {

    static function handle(){
        $request = Func_Input::filter(array(
            'action'=>'11',
            'id'=>'int',
            'token'=>'string'
        ),$_REQUEST);
        if(empty($request['token'])||$request['token']!='31eff8'){
            return self::request('-1','','非法请求');
        }
        if(empty($request['action'])||empty($request['id'])){
            return self::request('-1','','参数错误');
        }
        switch($request['action']){
            case 'space':
              return  self::spaces($request['id']);
                break;
            case 'site':
                return self::sites($request['id']);
                break;
            case 'article':
                return self::articles($request['id']);
                break;
            case 'project':
                return  self::projects($request['id']);
                break;
            default:
                return self::request('error','','非法请求,参数错误!');
            break;
        }
    }
    static $facility=[
        5 => '停车泊位',
        12 => '休息室',
        13 => '化妆间',
        14 => '洗手间',
        15 => '空间吊点',
        17 => '空调暖气',
        18 => '网络WIFI',
        19 => '货运电梯',
        20 => '投影LED',
        21 => '灯光音响',
        22 => '餐饮',
    ];
    //百科等级定义
    static $level=array(
        "A"=>'4',
        "B"=>'3',
        "C"=>'0',
        "D"=>'-1',
        "E"=>'-2',
    );
    //分类级别定义
    static $type_level=array(
        "2"=>'核心场地',
        "1"=>'自营场地',
        "0"=>'其他',
    );
    static function spaces($id){
//        $cols = "tb1.id,tb1.tags_new,tb1.status,tb2.attr as space_attr";
        $cols = "id,space_id,tags_new,status,min_price,max_price,inner_price,price_unit,create_time,update_time";
//        $tables = '{table} as tb1 left join {prefix}spacepedia as tb2 on tb1.space_id=tb2.id';
//        $rs = Data_Mysql_Table_Space_Item::select($cols,array('tb1.id=?'=>$id),'',1,$tables);
        $rs = Data_Mysql_Table_Space_Item::select($cols,array('id=?'=>$id),'',1);
        if(empty($rs)){
            return self::request('error','','数据不存在');
        }
        $info=$rs[0];
        $price_list = Data_Mysql_Table_Item_Price::select('id,price_unit,market_price,inner_price',array('space_id=?'=>$info['space_id'],'item_id=?'=>$info['id']),'order by market_price desc,inner_price asc',10);
        $market_price = 0;
        $inner_price = 0;
        $price_unit='';
        if($price_list){
            foreach($price_list as $k=>$v){
                if($v['market_price']>$market_price||$market_price==0){
                    $market_price=$v['market_price'];
                    $price_unit = $v['price_unit'];
                }
                if($v['inner_price']<$inner_price||$inner_price==0){
                    $inner_price=$v['inner_price'];
                }
            }
        }else{
            $market_price = $info['max_price'];
            $inner_price = $info['inner_price'];
            $price_unit = $info['price_unit'];
        }
//        $info['space_attr'] = json_decode($info['space_attr'],1);
//        $facilities = array();
//        if($info['space_attr']){
//            foreach($info['space_attr'] as $kk=>$vv){
//                if(isset(self::$facility[$kk])&&$vv=="有"){
//                    $facilities[]=self::$facility[$kk];
//                }
//            }
//        }
        $data= array(
            'space_tags'=>!empty($info['tags_new'])?$info['tags_new']:'',
//            'space_facilities'=> implode(',',$facilities),
            'space_keywords'=>'',
            'status'=>$info['status'],
//            'min_price'=>$info['min_price']/100,
            'market_price'=>$market_price/100,
            'inner_price'=>$inner_price/100,
            'price_unit'=>$price_unit,
            'create_time'=>date('Y-m-d H:i:s',$info['create_time']),
            'update_time'=>date('Y-m-d H:i:s',$info['update_time']),
        );
        return self::request('success',$data,'返回成功');
    }
    static function sites($id){
        $rs =  Data_Mysql_Table_Spacepedia::select('*',array('id=?'=>$id),'',1);
        if(empty($rs)){
            return self::request('error','','数据不存在');
        }
        $info= $rs[0];
        $info['attr'] = json_decode($info['attr'],1);
        $facilities = array();
        if($info['attr']){
            foreach($info['attr'] as $kk=>$vv){
                if(isset(self::$facility[$kk])&&$vv=="有"){
                    $facilities[]=self::$facility[$kk];
                }
            }
        }
        $level = array_flip(self::$level);
        $type_level = self::$type_level;
        $data= array(
            'business_circles'=>isset($info['attr'][2])?$info['attr'][2]:'',
            'facilities'=> implode(',',$facilities),
            'industry_types'=>isset($info['attr'][9])?$info['attr'][9]:'',
            'event_types'=>isset($info['attr'][49])?$info['attr'][49]:'',
            'district'=>isset($info['attr'][4])?$info['attr'][4]:'',
            'keywords'=>'',
            'city'=>$info['city'],
            'status'=>$info['status'],
            'addr'=>$info['addr'],
            'level'=>isset($level[$info['level']])?$level[$info['level']]:0,
            'type_level'=>isset($type_level[$info['type_level']])?$type_level[$info['type_level']]:0,
            'site_type'=>$info['category_id'],
            'create_time'=>date('Y-m-d H:i:s',$info['create_time']),
            'update_time'=>date('Y-m-d H:i:s',$info['update_time']),
        );
        return self::request('success',$data,'返回成功');
    }

    static function articles($id){
        $rs = Data_Mysql_Table_Raiders_Info::select('id,tags_info,category_id,baike_cid,status,create_time,update_time',array('id=?'=>$id),'',1);
        if(empty($rs)){
            return self::request('error','','数据不存在');
        }
        $info= $rs[0];
        $info['tags_info'] = json_decode($info['tags_info'],1);
        $baike_ids =explode(',',$info['baike_cid']);
        $temp_baike_id = array();
        if($baike_ids){
            foreach($baike_ids as $k=>$v){
                $parent_id = Data_Mysql_Table_Spacepedia::getParent($v);
                if($parent_id==112||$parent_id==300){
                    $temp_baike_id[] = Data_Mysql_Table_Spacepedia::getCategoryNameById($parent_id);
                }else{
                    $temp_baike_id[]= Data_Mysql_Table_Spacepedia::getCategoryNameById($v);;
                }
            }
        }
        $temp_baike_id=  array_values(array_unique($temp_baike_id));
        $data= array(
            'i_types'=>$info['category_id'],
            'i_class'=>implode(',',$temp_baike_id),
            'article_keywords'=>implode(',',$info['tags_info']),
            'status'=>$info['status'],
            'create_time'=>date('Y-m-d H:i:s',$info['create_time']),
            'update_time'=>date('Y-m-d H:i:s',$info['update_time']),
        );
        return self::request('success',$data,'返回成功');
    }

    static function projects($id){
        $rs =Data_Mysql_Table_Winchance::select('id,tags_info,conform_crowd,status,category,create_time,update_time',array('id=?'=>$id),'',1);
        if(empty($rs)){
            return self::request('error','','数据不存在');
        }
        $info= $rs[0];
        $info['tags_info'] = json_decode($info['tags_info'],1);
        if($info['conform_crowd']){
            $info['conform_crowd']=str_replace(array('，','、'),array(',',','),$info['conform_crowd']);
        }
        $data= array(
            'applicable_peoples'=>$info['conform_crowd'],
            'project_keywords'=>implode(',', $info['tags_info']),
            'status'=>$info['status'],
            'category'=>$info['category'],
            'create_time'=>date('Y-m-d H:i:s',$info['create_time']),
            'update_time'=>date('Y-m-d H:i:s',$info['update_time']),
        );
        return self::request('success',$data,'返回成功');
    }
} 