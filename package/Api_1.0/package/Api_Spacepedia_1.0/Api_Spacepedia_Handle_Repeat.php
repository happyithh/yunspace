<?php

/**
 * Created by PhpStorm.
 * User: yl
 * Date: 15-12-09
 * Time: 下午18：27
 * 场地百科去重复
 */
class Api_Spacepedia_Handle_Repeat extends Api
{
    static function handle($args=""){

        return self::getRepeatList($args);
    }
    static function getRepeatList($args=''){
        $space_id=$args['space_id'];
        $conditions['{table}.id = ?']=$space_id;
        $table="{table} LEFT JOIN {prefix}vendor_info_update ON {table}.vendor_id = {prefix}vendor_info_update.id";
        $spacepedia=Data_Mysql_Table_Spacepedia::select('{table}.*,{prefix}vendor_info_update.vendor_name',$conditions,'',1,$table);
        if(!empty($spacepedia[0])){
            //获取10条未处理的重复数据
            $condition2['space_name'] =$spacepedia[0]['space_name'];
            $condition2['repeat_ids = ?']="";
            $condition2['{table}.status >= ?']=0;
            //与当前数据相同的城市
            $city_exist="";
            if(!empty($spacepedia[0]['city'])){
                $condition2['{table}.city = ?']=$spacepedia[0]['city'];
                //判断名称中是否有城市字样
                $city_exist=strstr($spacepedia[0]['space_name'],$spacepedia[0]['city']);
            }
            $repeat_list=Api_Spacepedia_List_And_Info::getSpacepediaList($condition2,2,10); //无分页，查10条数据
            if(empty($city_exist) && count($repeat_list)==1){
                Data_Mysql_Table_Spacepedia::query("UPDATE {table} SET repeat_ids= ? WHERE id = ?",array(0,$spacepedia[0]['id']));
                return self::request('error',"","无重复数据！！");
            }else{
                return self::request('success',$repeat_list,"返回重复数据列表！！");
            }
        }else{
            return self::request('error',"","该场地百科数据不存在！！");
        }
    }
    /*
     *处理重复的场地百科
     */
    static function handleRepeatSpacepedia($data){
        $request=Func_Input::filter(array(
            'space_id'=>'int',
            'repeat_ids'=>'array',
            'repeat_items'=>'array',
            'space_name'=>'string',
            'old_space_name'=>'string',
        ),$data);
        if(empty($request['space_id'])){
            return false;
        }
        if(!empty($request['space_name']) && $request['space_name']!=$request['old_space_name']){
            //更新场地百科名称
            self::updateSpaceName($request['space_id'],$request['space_name']);
        }

        if(empty($request['repeat_ids']) && empty($request['repeat_items'])){
            //1.处理要保留的数据，下次不会再出现在重复列表中
            Data_Mysql_Table_Spacepedia::query("UPDATE {table} SET repeat_ids= ? WHERE id = ?",array(0,$request['space_id']),1);
        }else{
            //2.将标记为重复的数据和标记为子空间的数据标记为重复
            $repeat_ids_arr=array();
            if(!empty($request['repeat_ids'])){
                $repeat_ids_arr=$request['repeat_ids'];
            }
            if(!empty($request['repeat_items'])){
                $repeat_ids_arr=array_unique(array_merge($repeat_ids_arr,$request['repeat_items']));
            }
            $repeat_ids=implode(',',$repeat_ids_arr);
            //修改保留的百科repeat_ids;
            $rs=Data_Mysql_Table_Spacepedia::query("UPDATE {table} SET repeat_ids= ? WHERE id = ?",array($repeat_ids,$request['space_id']),1);
            if(!empty($rs[0])){
                //修改重复的百科的状态（-1 删除）和repeat_ids
                Data_Mysql_Table_Spacepedia::query("UPDATE {table} SET repeat_ids= ?,status=? WHERE id in (".$repeat_ids.")",array($request['space_id'],-1),1);
                foreach($request['repeat_ids'] as $k=>$v){
                    Api_Spacepedia_Submit::changeHistoryStatusToCancel($v);
                }
                //修改旧场地的状态（-2 删除）
                $product_condition[]="space_id in (".$repeat_ids.")";
                $old_product=Data_Mysql_Table_Space_Item::select('id,product_id',$product_condition,'',100);
                if(!empty($old_product)){
                    foreach($old_product as $k=>$v){
                        $product_ids[]=$v['product_id'];
                    }
                    Data_Mysql_Table_Product_Info::query("UPDATE {table} SET status=? WHERE id in (".implode(",",$product_ids).")",array("-2"),1);
                    Data_Mysql_Table_Product_Info::subTable("_update")->query("UPDATE {table} SET status=? WHERE id in (".implode(",",$product_ids).")",array("-2"),1);
                }

                if(!empty($request['repeat_items'])){
                    //将现有百科的子空间的百科id更改为保留的百科id
                    $space_item_ids=implode(',',$request['repeat_items']);
                    Data_Mysql_Table_Space_Item::query("UPDATE {table} SET space_id= ? WHERE space_id in (".$space_item_ids.")",array($request['space_id']),1);
                }
            }
        }
    }

    //更新场地百科名称
    static function updateSpaceName($space_id,$space_name){
        $condit['id !=?']=$space_id;
        $condit['space_name =?']=$space_name;
        $name_exists = Data_Mysql_Table_Spacepedia::select("id,space_name",$condit);
        if (!empty($name_exists[0])) {
            Func_Header::back('该场地百科名称已经存在！');
        }else{
            //更新场地百科名称
//            Data_Mysql_Table_Spacepedia::query("UPDATE {table} SET space_name= ?,status=? WHERE id = ?",array($space_name,1,$space_id),1);
            Data_Mysql_Table_Spacepedia::update(array("id"=>$space_id),array("space_name"=>$space_name));
            //更新历史表中的待审核数据为取消
            Api_Spacepedia_Submit::changeHistoryStatusToCancel($space_id);
            //向历史history中的添加一条审核通过数据
            $insert_data['status']=1;
            Api_Spacepedia_Submit::insertHistoryBySpaceIdOrName($space_id,$insert_data);
        }
    }

}