<?php
/**
 * Created by PhpStorm.
 * User: yl
 * Date: 15-10-16
 * Time: 上午10:02
 * 场地百科去重复管理
 */
class OA_Spacepedia_Repeat{
    static function handle(){
        $action=empty($_REQUEST['action'])?"list":$_REQUEST['action'];
        switch($action){
            case "list":
                self::getNotHandleSpacepediaList();
                break;
            case "save_submit":
                self::handleRepeatSpacepedia();
                break;
            default:
                Func_Header::notFound();
                break;
        }
    }

    /*
     *获取未操作的场地百科的列表信息
     */
    static function getNotHandleSpacepediaList(){
        $data=self::getRepeatList();
        Tpl_Smarty::assign("_data",$data);
//        Tpl_Smarty::assign("_categoryList",Data_Mysql_Table_Product_Category::getTreeCache());
        Tpl_Smarty::assign("_categoryInfo",Data_Mysql_Table_Product_Category::getInfoCache());
        Tpl_Smarty::display("OA_Static","spacepedia_repeat/spacepedia_repeat_list.tpl");
    }
    /*
     *获取处理的场地百科的递归函数
     */
    static function getRepeatList(){
        $conditions['repeat_ids = ?']="";
        $conditions['{table}.status >= ?']=0;
        $table="{table} LEFT JOIN {prefix}vendor_info_update ON {table}.vendor_id = {prefix}vendor_info_update.id";
        $spacepedia=Data_Mysql_Table_Spacepedia::select('{table}.*,{prefix}vendor_info_update.vendor_name',$conditions,'ORDER BY rand()',1,$table);
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
                return self::getRepeatList();
            }else{
                return $repeat_list;
            }
        }
    }

    /*
     *处理重复的场地百科
     */
    static function handleRepeatSpacepedia(){
        $request=Func_Input::filter(array(
            'save_id'=>'int',
            'repeat_ids'=>'array',
            'repeat_items'=>'array',
            'space_name'=>'string',
            'old_space_name'=>'string',
        ));
//        q($request);
        if(empty($request['save_id'])){
            Func_Header::back("参数缺失！！");
        }
        if(empty($request['space_name'])){
            Func_Header::back("请输入修改后的场地百科名称！！");
        }

        if($request['space_name']!=$request['old_space_name']){
            //更新场地百科名称
            self::updateSpaceName($request['save_id'],$request['space_name']);
        }

        if(empty($request['repeat_ids']) && empty($request['repeat_items'])){
            //1.处理要保留的数据，下次不会再出现在重复列表中
            $rs=Data_Mysql_Table_Spacepedia::query("UPDATE {table} SET repeat_ids= ? WHERE id = ?",array(0,$request['save_id']),1);
            if(!empty($rs[0])){
                Func_Header::to(" 数据已保留/已修改，不会再出现在重复列表中！！","?");
            }else{
                Func_Header::back("数据保留失败！！","?");
            }
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
            $rs=Data_Mysql_Table_Spacepedia::query("UPDATE {table} SET repeat_ids= ? WHERE id = ?",array($repeat_ids,$request['save_id']),1);
            if(empty($rs[0])){
                Func_Header::back("去重复操作失败！！");
            }else{
                //修改重复的百科的状态（-1 删除）和repeat_ids
                Data_Mysql_Table_Spacepedia::query("UPDATE {table} SET repeat_ids= ?,status=? WHERE id in (".$repeat_ids.")",array($request['save_id'],-1),1);
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
                    Data_Mysql_Table_Space_Item::query("UPDATE {table} SET space_id= ? WHERE space_id in (".$space_item_ids.")",array($request['save_id']),1);
                }
                Func_Header::to(" 去重复操作成功！！","?");
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