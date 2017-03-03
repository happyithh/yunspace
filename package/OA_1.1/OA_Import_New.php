<?php
/**
 * Created by PhpStorm.
 * User: Administrator
 * Date: 15-11-25
 * Time: 下午6:17
 */
class OA_Import_New{
    //恢复旧的场地数据
    static function recoveryProductData($limit=200){
        q("已完成");
        $limit = 200;
        $request = Func_Input::filter(array(
            'start_id' => 'int',
        ));
        $request['start_id'] or $request['start_id'] = 0;
        set_time_limit(0);
        //1.获取批量更新的3000条数据
        $log=Data_Mysql_Table_Import_Log::select("id, product_id",array('id>?'=>$request['start_id']),'ORDER BY id ASC',$limit);
        foreach($log as $k=>$v){
            $request['start_id'] = $v['id'];
//            $v['product_id'] = 54;
            //2.获取旧的场地数据
            $old_product=Data_Mysql_Table_Product_Info::subTable('_update1')->select('id,attr_new',array("id"=>$v['product_id']));
            if(!empty($old_product[0]) && !empty($old_product[0]['attr_new'])){
                $old_attr_new=json_decode($old_product[0]['attr_new'],1);
            }
            //3.获取现有的场地数据
            $new_product=Data_Mysql_Table_Product_Info::subTable('_update')->select('id,attr_new',array("id"=>$v['product_id']));
            if(!empty($new_product[0]) && !empty($new_product[0]['attr_new'])){
                $new_attr_new=json_decode($new_product[0]['attr_new'],1);
            }
            //4.处理旧的场地数据和新的场地数据
            if(!empty($old_attr_new) && !empty($new_attr_new)){
                $new_attr_new = $new_attr_new+ $old_attr_new;
                //5.更新现有场地的attr_new
                Data_Mysql_Table_Product_Info::subTable("_update")->update(array("id"=>$v['product_id']),array("attr_new"=>$new_attr_new));
                Data_Mysql_Table_Product_Info::update(array("id"=>$v['product_id']),array("attr_new"=>$new_attr_new));
                //6.获取已转换的场地百科
                $baike=Data_Mysql_Table_Spacepedia::select("{table}.id,{table}.space_name,{prefix}space_item.product_id,{table}.attr",array("{prefix}space_item.product_id=?"=>$v['product_id']),'',1,"{table} LEFT JOIN {prefix}space_item ON {table}.id = {prefix}space_item.space_id");
                if(!empty($baike[0]) && !empty($baike[0]['attr'])){
                    $baike_attr=json_decode($baike[0]['attr'],1);
                    $baike_attr = $baike_attr+$new_attr_new;
                    //7.更新百科的attr,向历史表中放入一条审核通过的数据
                    Data_Mysql_Table_Spacepedia::update(array("id"=>$baike[0]['id']),array("attr"=>$baike_attr));
                    Api_Spacepedia_Submit::insertHistoryBySpaceIdOrName($baike[0]['id'],array("status"=>1));
                }
            }
        }
//        q($request);

        Func_Header::to('', Core::$urls['path'] . '?start_id=' . ($request['start_id']));
    }

    //脚本，更新现有子空间的最小人数，不能低于最大人数的50%，最大人数大于50人时执行
    static function updateItemMinPeople(){
        $condition['max_people >= ?']=50;
        //获取所有最大人数大于50的子空间
        $data=Data_Mysql_Table_Space_Item::select("id,min_people,max_people",$condition,'',15000);
        foreach($data as $k=>$v){
            $min=$v['max_people']*0.5;
            if($v['min_people']<$min){
                //更新子空间的最小人数
                Data_Mysql_Table_Space_Item::query("UPDATE {table} SET min_people=? WHERE id= ?",array($min,$v['id']));
                //更新匹配表的最小人数
                $match_data['item_id']=$v['id'];
                $match_data['people_down']=$min;
                Data_Mysql_Table_Demand_Match_Space_Archives::update($match_data);
            }
        }
    }

    //脚本，将现有文章中的关联百科得百科名称添加到百科id字段
    static function updateSpaceIdsBySpaceName($id=0){
        $condition["id > ?"]=$id;
        $data=Data_Mysql_Table_Raiders_Info::select('id,baike_word',$condition,'ORDER BY id ASC',200);
        if(empty($data)){
            q("已完成");
        }
        foreach($data as $k=>$v){
            $id = $v['id'];
            if(!$v['baike_word']){
                continue;
            }
            $baike_word=json_decode($v['baike_word'],1);
            $baike_word = array_flip($baike_word);
            unset($baike_word['J'],$baike_word['酒店'],$baike_word['迷']);
            $baike_word = array_flip($baike_word);
            if(empty($baike_word)){
                continue;
            }
            $con=array();
            if(count($baike_word)==1){
                $con["space_name = ?"]=$baike_word[0];
            }else{
                $con[]="space_name in ('".implode("','",$baike_word)."')";
            }
            $baike=Data_Mysql_Table_Spacepedia::select('id,space_name',$con,'',20);
            if(!empty($baike)){
                $space_ids=array();
                foreach($baike as $k1=>$v1){
                    $space_ids[]=$v1['id'];
                }
                Data_Mysql_Table_Raiders_Info::query("UPDATE {table} SET space_ids = ? WHERE id = ?",array(implode(",",array_unique($space_ids)),$v['id']));
            }
        }
        return $id;
    }

    //一键审核所有供应商和供应商下的product
    static function checkAllVendor($id=0){
        $condition_vendor[] = 'status IN (2,4)';
        $condition_vendor["id > ?"]=$id;
        //获取所有待审核的供应商信息
        $vendor = Data_Mysql_Table_Vendor_Info::subTable('_update')->select("*", $condition_vendor, "ORDER BY update_time DESC",100);
        if(empty($vendor)){
            q("已结束");
        }
        foreach($vendor as $k=>$v){
            $id = $v['id'];
            //获取该供应商下所有待审核的产品
            $condition_product['status'] = 2;
            $condition_product['vendor_id'] = $v['id'];
            $productInfo = Data_Mysql_Table_Product_Info::subTable('_update')->select('*', $condition_product, 'ORDER BY status DESC', 10);
            $rs=false;
            //审核上线该产品
            foreach($productInfo as $k1=>$v1){
               $rs=self::passProduct($v1);
            }
            //审核上线该供应商
            self::passVendor($v);
        }
        return $id;
    }
    static function passProduct($data){
        if (!empty($data['attr'])) {
            $data['attr'] = json_decode($data['attr'], 1);
        }
        if (!empty($data['attr_new'])) {
            $data['attr_new'] = json_decode($data['attr_new'], 1);
        }
        if (empty($data['attr_new'][46])) {
            return false;
        }
        if (!empty($data['attr_index'])) {
            $data['attr_index'] = json_decode($data['attr_index'], 1);
        }
        if (!empty($data['media'])) {
            $data['media'] = json_decode($data['media'], 1);
        }
        if (!$data['admin_id']) {
            $data['admin_id'] = $_SESSION['administrator']['id'];
        }
        //如果之前被拒绝过则去掉名称“|”以及后面之前的拒绝理由
        if (!empty($data['product_name'])) {
            $data['product_name'] = preg_replace('/\|.*/','',$data['product_name']);
        }
        //更新产品状态，主表和update表信息
        $condition = array('id' => $data['id']);
        $update_data = array('status' => 1,'refuse_reason' => '');
        $update_rs = Data_Mysql_Table_Product_Info::subTable('_update')->update($condition, $update_data);
        //产品通过并上线
        $data['status'] = 1;
        if ($update_rs[0] > 0) {
            //将信息放入主表中
            $rs = Data_Mysql_Table_Product_Info::update($data);
            if ($rs[0] > 0) {
                //创建操作日志
                $vendorInfo = Data_Mysql_Table_Vendor_Info::select('id,vendor_account_id', array('id' => $data['vendor_id']));
                if (!empty($vendorInfo[0])) {
                    Data_Mysql_Table_Account_Log::insertAccountLog($vendorInfo[0]['vendor_account_id'], $_SESSION['administrator']['id'], '产品通过审核', '审核产品', $data['id']);
                }
                //创建历史记录
                $history_data = array('object_id' => $data['id'], 'admin_id' => $_SESSION['administrator']['id'], 'operate_type' => 1, 'data_backup' => $data);
                Data_Mysql_Table_History::subTable('_product' . date("_Ym"))->insert($history_data);
                return true;
            }
        }
        return false;
    }
    static function passVendor($data){
        if (empty($data['categories_id'])) {
            return false;
        }
        if (!empty($data['attr'])) {
            $data['attr'] = json_decode($data['attr'], 1);
        }
        if (!empty($data['attr_index'])) {
            $data['attr_index'] = json_decode($data['attr_index'], 1);
        }
        if (!empty($data['media'])) {
            $data['media'] = json_decode($data['media'], 1);
        }
        if (!empty($data['base_info'])) {
            $data['base_info'] = json_decode($data['base_info'], 1);
        }
        if (!empty($data['vendor_remarks'])) {
            $data['vendor_remarks'] = json_decode($data['vendor_remarks'], 1);
        }
        //如果之前被拒绝过则去掉名称“|”以及后面之前的拒绝理由
        if (!empty($data['vendor_name'])) {
            $data['vendor_name'] = preg_replace('/\|.*/','',$data['vendor_name']);
        }
        //更新update表信息
        $condition = array('id' => $data['id']);
        $update = array('status' => 1);
        $update_rs = Data_Mysql_Table_Vendor_Info::subTable('_update')->update($condition, $update);

        //将信息放入主表中
        $data['status'] = 1;
        $rs = Data_Mysql_Table_Vendor_Info::update($data);
        if ($update_rs[0]>0 && $rs[0] > 0) {
            //创建操作日志
            Data_Mysql_Table_Account_Log::insertAccountLog($data['vendor_account_id'],$_SESSION['administrator']['id'],'供应商审核通过','供应商审核',$data['id']);
            //创建历史记录
            $history_data=array('object_id'=>$data['id'],'admin_id'=>$_SESSION['administrator']['id'],'operate_type'=>1,'data_backup'=>$data);
            Data_Mysql_Table_History::subTable('_vendor' . date("_Ym"))->insert($history_data);
        }
    }

    //一键将旧场地转换为场地百科
    static function convertOldProduct(){
        //1.获取所有未转换的场地信息
        $condition['status'] = 1;
//        $condition["id > ?"]=$id;
        $condition['is_convert']=0;
        $children = Data_Mysql_Table_Product_Category::getChildren(Data_Config_Site::$staticConfig['space_id']);
        $children[] = Data_Config_Site::$staticConfig['space_id'];
        $condition[] = 'category_id in (' . implode(',', $children) . ')';
        $product = Data_Mysql_Table_Product_Info::select("*", $condition, "ORDER BY update_time DESC",100);
        if(empty($product)){
            return "已结束";
        }
        foreach($product as $k=>$v){
            $spacepedia = $create_history = $item = $match_data = array();
//            $id = $v['id'];
            //2.判断场地是否已存在于场地百科中
            $is_exists=Api_Spacepedia_List_And_Info::getSpacepediaInfoByName($v['product_name']);
            if(empty($is_exists)){
                //3.向百科表中添加一条已审核数据
                $spacepedia['space_name']=$v['product_name'];
                $spacepedia['vendor_id']=$v['vendor_id'];
                $spacepedia['category_id']=$v['category_id'];
                $spacepedia['addr']=$v['addr'];
                $spacepedia['des']=$v['des'];
                $spacepedia['attr']=array();
                if(!empty($v['attr_new'])){
                    $spacepedia['attr']=json_decode($v['attr_new'],1);
                    $spacepedia['city']=empty($attr[46])?'':$attr[46];
                }
                $spacepedia['status']=1;
                $spacepedia['product_id']=$v['id'];
//                var_dump(json_decode($v['attr_new'],1),$spacepedia['attr']);
                $baike_rs = Data_Mysql_Table_Spacepedia::insert($spacepedia);
                if(!empty($baike_rs[0])){
                    $space_id = $baike_rs[0];
                    //4.向历史表中添加一条已审核数据
                    $create_history['data_backup']['space_name'] = $spacepedia['space_name'];
                    $create_history['data_backup']['category_id'] = $spacepedia['category_id'];
                    $create_history['data_backup']['vendor_id'] = $spacepedia['vendor_id'];
                    $create_history['data_backup']['addr'] = $spacepedia['addr'];
                    $create_history['data_backup']['des'] = str_replace(">","&gt;",$spacepedia['des']) ;
                    $create_history['data_backup']['des'] = str_replace("<","&lt;",$create_history['data_backup']['des']) ;
                    $create_history['data_backup']['des'] = str_replace('"',"&#34;",$create_history['data_backup']['des']) ;
                    $create_history['data_backup']['attr'] = empty($spacepedia['attr'])?'':$spacepedia['attr'];
                    $create_history['data_backup']['city'] = empty($spacepedia['city'])?'':$spacepedia['city'];
                    $create_history['data_backup']['product_id'] = $spacepedia['product_id'];
                    $create_history['data_backup']['space_id'] = $space_id;
                    $create_history['object_id'] = $space_id;
                    $create_history['admin_id'] = $_SESSION['administrator']['id'];
                    $create_history['create_time'] = time();
                    $create_history['status'] = 1;
                    Data_Mysql_Table_History::subTable('_baike_' . date("Ym"))->insert($create_history);

                    //5.向子空间表中添加一条已审核数据
                    $item['status']=1;
                    $item['space_id']=$space_id;
                    $item['item_name']=$spacepedia['space_name'];
                    $item['product_id']=$spacepedia['product_id'];
                    $item['city']=empty($spacepedia['city'])?'':$spacepedia['city'];
                    $item['size']=$v['product_size'];
                    $item['min_price']=empty($v['price'])?1:$v['price'];
                    $item['max_price']=empty($v['price'])?1:$v['price'];
                    $item['min_people']=1;
                    $item['max_people']=1;
                    $item['price_unit']=empty($spacepedia['attr']['计价单位'])?"":$spacepedia['attr']['计价单位'];
                    $item['des']=$spacepedia['des'];
                    $item['media']=$media=array();
                    if(!empty($v['media'])){
                        $media=json_decode($v['media'],1);
                        unset($media['$$']);
                        $item['media'] = array_values($media);
                        foreach ($media as $mk => $mv) {
                            $item['logo'] = $mv['path'];
                        }
                    }
                    $item['status']=1;
                    $item_rs=Data_Mysql_Table_Space_Item::insert($item);

                    //6.同步匹配表
                    if(!empty($item_rs[0])){
                        $match_data['price_up'] = $item['max_price'];
                        $match_data['price_down']=$item['min_price'];
                        $match_data['people_up']=1;
                        $match_data['people_down']=1;
                        $match_data['city'] = $item['city'];
                        $match_data['vendor_id'] = $v['vendor_id'];
                        Data_Mysql_Table_Demand_Match_Space_Archives::update($match_data);
                    }

                    //7.更新旧场地为已转换
                    Data_Mysql_Table_Product_Info::query("UPDATE {table} SET is_convert = ? WHERE id= ?",array(1,$v['id']),1);
                    Data_Mysql_Table_Product_Info::query("UPDATE {table}_update SET is_convert = ? WHERE id= ?",array(1,$v['id']),1);

                    //8.向转换中间表中添加一条数据
                    $convert_temp['product_id']=$v['id'];
                    $convert_temp['product_name']=$v['product_name'];
                    $convert_temp['space_id']=$space_id;
                    $convert_temp['space_name']=$spacepedia['space_name'];
                    Data_Mysql_Table_Convert_Temp::insert($convert_temp);

                }

            }else{
                return "已结束";
            }

        }
        return true;
    }


    //脚本，更新关联文章中baike_category_id为空的数据
    static function updateRaidersCategoryId($id=0){
        //1.获取baike_category_id为空的文章
        $condition['(baike_category_id = ? OR baike_category_id= ?)']=array("",0);
        $condition['space_ids != ?']="";
        $condition["id > ?"]=$id;
        $data=Data_Mysql_Table_Raiders_Info::select('id,space_ids',$condition,'',100);
        if(empty($data)){
            q("已结束");
        }
        foreach($data as $k=>$v) {
            $id = $v['id'];
            $space_id_arr = explode(",", $v['space_ids']);
            $con['id'] = $space_id_arr[0];
            $baike_category = Data_Mysql_Table_Spacepedia::select('category_id', $con);
            if (!empty($baike_category[0])) {
                //2.更新当前文章的baike_category_id
                Data_Mysql_Table_Raiders_Info::update(array("id" => $v['id']), array('baike_category_id' => $baike_category[0]['category_id']));

            }
        }
        return $id;
    }

    //脚本，更新关联文章中baike_category_id,根据所有的关联百科的分类
    static function updateAllRaidersCategoryId($id=0){
        $condition['space_ids != ?']="";
        $condition["id > ?"]=$id;
        $data=Data_Mysql_Table_Raiders_Info::select('id,space_ids',$condition,'',100);
        if(empty($data)){
            return false;
        }
        foreach($data as $k=>$v) {
            $baike_category_id='';
            $con=$category_arr=$space_id_arr=$baike_category=array();
            $id = $v['id'];
            $space_id_arr = explode(",", $v['space_ids']);
            $con[] ='id in ('.implode(",",array_filter($space_id_arr)).')' ;
            $baike_category = Data_Mysql_Table_Spacepedia::select('id,space_name,category_id',$con,'',count($space_id_arr));
            if(!empty($baike_category)){
                foreach($baike_category as $k1=>$v1){
                    $category_arr[]=$v1['category_id'];
                }
                $baike_category_id=implode(',',array_unique($category_arr));
            }
            if (!empty($baike_category_id)) {
                //2.更新当前文章的baike_category_id
                Data_Mysql_Table_Raiders_Info::update(array("id" => $v['id']), array('baike_cid' => $baike_category_id));
            }
        }
        return $id;
    }
}