<?php
/**
 * Created by PhpStorm.
 * User: adu
 * Date: 2015/10/23
 * Time: 16:21
 */

class Api_Space_Item_Change_Contacts_Info extends Api{

    static function changeContactsInfo($args){

        $request = Func_Input::filter(array(
            'item_id' => 'int',
            'space_id' => 'int',
            'submit_type' => 'int',
            'phone' => 'phone',
            'email' => 'email',
            'contacts' => 'string',
            'min_price' => '100',
            'max_price' => '100',
            'min_people' => 'int',
            'max_people' => 'int',
            'size' => 'int',
            'status' => 'int',
            'demand_id'=>'int',
            'expand_refuse_reason'=>'string',
        ),$args);
        if($request['submit_type']==1 || $request['submit_type']==2){
            $request['expand_status'] = 1;
        }
        if($request['submit_type']==-3){
            $request['expand_status'] = -3;
        }
        if(!empty($request['min_price'])){
            $request['min_price'] = $request['min_price']*100;
        }
        if(!empty($request['max_price'])){
            $request['max_price'] = $request['max_price']*100;
        }
        $request['status'] = empty($request['status']) ? 2 :$request['status'];
        $dataItem = array(
            'expand_status' => $request['expand_status'],
            'contacts' => $request['contacts'],
            'phone' => $request['phone'],
            'email' => empty($request['email'])?'':$request['email'],
            'status' =>  $request['status'],
            'min_price' => $request['min_price'],
            'max_price' => $request['max_price'],
            'min_people' => $request['min_people'],
            'max_people' => $request['max_people'],
            'size' => $request['size'],
            'expand_demand_id'=>$request['demand_id'],
            'expand_refuse_reason'=>$request['expand_refuse_reason']?$request['expand_refuse_reason']:'',
        );
       $rs =  Data_Mysql_Table_Space_Item::update(array('id=?'=>$request['item_id']),$dataItem);

        $data_space_archives =array(
            'price_up' => $request['max_price'],          //价格上限
            'price_down' => $request['min_price'],          //价格下限
            'people_up' => $request['max_people'],            //人数上限
            'people_down' => $request['min_people'],            //人数下限
            'update_time' => time(),
        );
        Data_Mysql_Table_Demand_Match_Space_Archives::update(array('item_id=?'=>$request['item_id']),$data_space_archives);
        if($rs){
            return self::request('success',$request,"拓展信息修改成功!");
        }else{
            return self::request('error',"","拓展信息修改失败!");
        }
    }
}