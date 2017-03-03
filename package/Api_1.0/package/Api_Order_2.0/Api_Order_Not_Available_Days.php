<?php
/**
 * Created by PhpStorm.
 * User: yl
 * Date: 15-7-23
 * Time: 下午2:19
 * 获取预订对象的所有不可用日期
 */
class Api_Order_Not_Available_Days extends Api{
    /*
     * @args=array(
     *      'id'=>对象id
     *      'type'=>1 产品    2   套餐
     *  )
     * @$node array 节点数组;
     */
    static function handle($args=''){
      return  self::getAllNotOrderDays($args);
    }
    static function getAllNotOrderDays($args){
        $request=Func_Input::filter(array(
            'id'=>'int',
            'type'=>'int'
        ));
        if(empty($request['id']) || empty($request['type'])){
            return self::request('error','','参数缺失！');
        }
        if($request['type']==1){
            $data=self::getProductNotOrderDays($request['id']);
        }elseif($request['type']==2){
            $data=self::getSetNotOrderDays($request['id']);
        }else{
            return self::request('error','','未知参数！！');
        }
        $json=array();
        if(!empty($data)){
            foreach($data as $k=>$v){
                $json[$k]['end'] = $v['end_time'].'000';
                $json[$k]['start'] = $v['start_time'].'000';
            }
        }
        return self::request('success',$json,'返回所有不可预订日期！');
    }

    static function getProductNotOrderDays($id){
        $data=array();
        //获取产品信息
        $oProduct = Web_Product_Info::getInstance();
        $oProduct->id = $id;
        $productInfo = $oProduct->productInfo;
        //获取产品已预订档期
        $s_conditions['product_id']=$id;
        $s_conditions[]='status > 0';
        $data = Data_Mysql_Table_Product_Schedule::select('start_time,end_time',$s_conditions,'',100);
        return $data;
    }
    static function getSetNotOrderDays($id){
        $data=array();
        //获取套餐信息
        $oProductSet = Web_Product_Set_Info::getInstance();
        $oProductSet->id = $id;
        $productSet = $oProductSet->info;
        //获取套餐已预订档期
        if(!empty($productSet['schedule_product_id'])){
            $s_conditions['product_id']=$productSet['schedule_product_id'];
            $s_conditions[]='status > 0';
            $data = Data_Mysql_Table_Product_Schedule::select('start_time,end_time',$s_conditions,'',100);
        }
        return $data;
    }
}