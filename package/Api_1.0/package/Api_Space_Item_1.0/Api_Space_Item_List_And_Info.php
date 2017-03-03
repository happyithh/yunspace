<?php
/**
 * Created by PhpStorm.
 * User: yl
 * Date: 15-10-16
 * Time: 上午10:29
 * 查询子空间列表和详情方法
 */
class Api_Space_Item_List_And_Info{
    /*
     *获取子空间的列表
     * @param:$condition  array 检索条件
     * @return:列表数组
     */
    static function getSpaceItemList($condition=array(),$no_page=0){
        if($no_page){
            $cols="*";
            $order="ORDER BY update_time DESC";
            $table="{table}";
            $data=Data_Mysql_Table_Space_Item::select($cols,$condition,$order,50,$table);
            if(empty($data)){
                return array();
            }
            foreach($data as $k=>$v){
                if(!empty($v['tags'])){
                    $data[$k]['tags']=self::getTagsValue(json_decode($v['tags']));
                }
                if(!empty($v['media'])){
                    $data[$k]['media']=json_decode($v['media'],1);
                }
                if(!empty($v['min_price'])){
                    $data[$k]['min_price']=$v['min_price']/100;
                }
                if(!empty($v['max_price'])){
                    $data[$k]['max_price']=$v['max_price']/100;
                }
            }
        }else{
            $cols="{table}.*,{prefix}spacepedia.space_name,{prefix}spacepedia.new_id";
            $order="ORDER BY {table}.update_time DESC";
            $table="{table} LEFT JOIN {prefix}spacepedia ON {table}.space_id = {prefix}spacepedia.id";
            $data=Data_Mysql_Table_Space_Item::page(0,20,$cols,$condition,$order,$table);
            if(empty($data['rows'])){
                return array();
            }
            foreach($data['rows'] as $k=>$v){
                if(!empty($v['tags'])){
                    $data['rows'][$k]['tags']=self::getTagsValue(json_decode($v['tags']));
                }
                if(!empty($v['media'])){
                    $data['rows'][$k]['media']=json_decode($v['media'],1);
                }
                if(!empty($v['min_price'])){
                    $data['rows'][$k]['min_price']=$v['min_price']/100;
                }
                if(!empty($v['max_price'])){
                    $data['rows'][$k]['max_price']=$v['max_price']/100;
                }
            }
        }
        return $data;
    }

    static function getSpaceItemInfoById($id,$condition=array()){
        $condition['{table}.id = ?']=$id;
        $cols="{table}.*,{prefix}spacepedia.space_name,{prefix}spacepedia.addr";
        $table="{table} LEFT JOIN {prefix}spacepedia ON {table}.space_id = {prefix}spacepedia.id";
        $data=Data_Mysql_Table_Space_Item::select($cols,$condition,'',1,$table);
        if(empty($data[0])){
            return array();
        }
        if(!empty($data[0]['tags'])){
            $data[0]['tags']=self::getTagsValue(json_decode($data[0]['tags']));
        }
        if(!empty($data[0]['media'])){
            $data[0]['media']=json_decode($data[0]['media'],1);
        }
        if(!empty($data[0]['min_price'])){
            $data[0]['min_price']=$data[0]['min_price']/100;
        }
        if(!empty($data[0]['max_price'])){
            $data[0]['max_price']=$data[0]['max_price']/100;
        }

        return $data[0];
    }

    // 获取tags标签下的值
    static function getTagsValue($tags){
        $_REQUEST['search_type']=2;
        $tags_arr = Api_Demand_Offer_Get_Demand_Tag_List::getTagList();
        $tags_new = array();
        foreach ($tags as $k => $v) {
            if (!empty($v)) {
                $tags_new[] = $tags_arr['data'][$k]['tag_value'];
            }
        }
        return $tags_new;
    }

    // 获取子空间最低价格（移动子空间详情使用）
    static function getMinPrice($item_ids){
        $conditions[] = '{table}.item_id IN ('.implode(',',$item_ids).')';
        $conditions[] = 't1.status =1';
//        Data_Mysql_Table_Item_Price::debug(1);
        $data = Data_Mysql_Table_Item_Price::select('item_id,discount_price,{table}.price_unit',$conditions,'',100,'{table} LEFT JOIN {prefix}space_item AS t1 ON {table}.item_id = t1.id');
        if(!empty($data)){
            $price = array();
            foreach($data as $k=>$v){
                $price[$v['item_id']][] = $v;
            }
            $price_new = array();
            foreach($price as $k=>$v){
                $price_new[$k]['item_min_price'] = intval(min(array_column($v,'discount_price'))/100);
                $price_new[$k]['item_price_unit'] = $v[0]['price_unit'];
            }
           return $price_new;
        }

    }
}