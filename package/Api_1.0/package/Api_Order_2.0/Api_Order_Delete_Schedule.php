<?php

/**
 * Created by PhpStorm.
 * User: yl
 * Date: 15/7/9
 * Time: 10:10
 * 订单--删除档期
 */
class Api_Order_Delete_Schedule extends Api
{
    //删除档期
    static function deleteSchedule($object_id,$object_type='product',$start_time,$end_time){
//        if(empty($object_id)){
//            return self::request('error','','参数错误！！');
//        }
        $conditions=array();
        if($object_type=='set'){
            $set=Data_Mysql_Table_Product_Set::select('id,schedule_product_id',array('id'=>$object_id));
            if(!empty($set[0])){
                $conditions['product_id']=$set[0]['schedule_product_id'];
            }
//            }else{
//                return self::request('error','','套餐不存在！');
//            }
        }else{
            $conditions['product_id']=$object_id;
        }
        $conditions['start_time']=$start_time;
        $conditions['end_time']=$end_time;
        $rs=Data_Mysql_Table_Product_Schedule::update($conditions,array('status'=>-1));
//        if(empty($rs[0])){
//            return self::request('error','','档期删除失败！！');
//        }else{
//            return self::request('success','','档期删除成功！');
//        }
    }

}