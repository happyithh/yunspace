<?php

/**
 * Created by PhpStorm.
 * User: yl
 * Date: 2016/05/19
 * Time: 16:11
 * 一键租场地page页
 */

class  Web_Rent_Space_Item extends Web_Global
{
    function seo()
    {
        return array(
            '网页标题' => '【云SPACE－商业空间短租平台】一键租场地_活动场地预订',
            '网页简介' => "云SPACE是专业的活动场地预订、租赁平台。为您提供上海、北京、广州、深圳、成都、杭州、南京、苏州等一二线城市活动场地,年会场地,购物中心,秀场,商场,loft空间,适合开办特卖,试乘试驾,走秀,高级定制,沙龙,集客等活动的特价活动空间。举办路演、推广活动、发布会选址是关键.一键直达,专业的服务,精准的报价,轻松搞定",
            '网页关键词' => "云SPACE,活动场地,北京活动场地,上海活动场地,场地租赁,秀场租赁,路演场地,发布会场地,年会场地",

        );
    }

    /*
    * request的值
    */
    function request(){
        $request = Func_Input::filter(array(
            'action' => 'string',
            'people' => 'string',
            'activity' => 'string',
            'demand_id' => 'int',
            'phone' => 'string',
            'level' => 'int',
            'space_id' => 'string',
            'item_id' => 'string',
            'price_id'=>'string',
        ));
        return $request;
    }

    /*
    * 获取场地信息
    */
    function space(){
        if ($this->request['space_id']) {
            $space_id = Func_NumEncode::d($this->request['space_id']);
            $space = Data_Mysql_Table_Spacepedia_Search::select('id,space_name,city,attr,logo,addr',
                array("id" => $space_id), '');
            if (!empty($space[0]['attr'])) {
                $space[0]['attr'] = json_decode($space[0]['attr'], 1);
            }
            if (!empty($space[0]['attr']['特色标签'])) {
                $space[0]['tags'] = explode(",", $space[0]['attr']['特色标签']);
            }
        }
        if(empty($space[0])){
            return array();
        }
        return $space[0];
    }

    function item_id(){
        if($this->request['item_id']){
           return Func_NumEncode::d($this->request['item_id']);
        }
        return 0;
    }

    function price_id(){
        if($this->request['price_id']){
           return Func_NumEncode::d($this->request['price_id']);
        }
        return 0;
    }
    
    /*
    *获取空间和场地信息
    */
    function item(){
        if ($this->item_id) {   
            //根据空间id获取场地信息
            $cols='{table}.id as item_id,{table}.item_name,{table}.min_price,{table}.max_price,{table}.price_unit,{prefix}spacepedia_search.id as space_id,{prefix}spacepedia_search.space_name,{prefix}spacepedia_search.city,{prefix}spacepedia_search.attr,{prefix}spacepedia_search.logo,{prefix}spacepedia_search.addr';
            $cond1["{table}.id = ?"]=$this->item_id;
            $table="{table} LEFT JOIN {prefix}spacepedia_search ON {table}.space_id = {prefix}spacepedia_search.id";
            $item_info=Data_Mysql_Table_Space_Item::select($cols,$cond1,'',1,$table);
            if(!empty($item_info[0])){
                if($item_info[0]['item_name'] != $item_info[0]['space_name']){
                    $item_info[0]['item_space_name']=$item_info[0]['space_name'].'-'.$item_info[0]['item_name'];
                }else{
                    $item_info[0]['item_space_name']=$item_info[0]['space_name'];
                }
                $min_price=$item_info[0]['min_price']/100;
                $max_price=$item_info[0]['max_price']/100;
                if($min_price==$max_price && $min_price > 100){
                    // $min_price=$item_info[0]['min_price'];
                    $price_unit=empty($item_info[0]['price_unit'])?"元/天":"元".$item_info[0]['price_unit'];
                    $item_info[0]['item_space_name'].="&nbsp;&nbsp;参考价：￥".$min_price.$price_unit;
                }else{
                    $min_price="¥".$min_price ."~". $max_price;
                    $price_unit=empty($item_info[0]['price_unit'])?"元/天":"元".$item_info[0]['price_unit'];
                    $item_info[0]['item_space_name'].="&nbsp;&nbsp;参考价：".$min_price.$price_unit;
                }
                
                if (!empty($item_info[0]['attr'])) {
                    $item_info[0]['attr'] = json_decode($item_info[0]['attr'], 1);
                }
                if (!empty($item_info[0]['attr']['特色标签'])) {
                    $item_info[0]['tags'] = explode(",", $item_info[0]['attr']['特色标签']);
                }  
            }
              
        }
        if(empty($item_info[0])){
            return array();
        }
        return $item_info[0];
    }

    /*
    *获取空间价格信息
    */
    function item_price(){
        if($this->price_id){
            $cols='{table}.*,{prefix}space_item.item_name,{prefix}spacepedia_search.id as space_id,{prefix}spacepedia_search.space_name,{prefix}spacepedia_search.city,{prefix}spacepedia_search.attr,{prefix}spacepedia_search.logo,{prefix}spacepedia_search.addr';
            $cond1["{table}.id = ?"]=$this->price_id;
            $table="{table} LEFT JOIN {prefix}space_item ON {table}.item_id={prefix}space_item.id LEFT JOIN {prefix}spacepedia_search ON {table}.space_id = {prefix}spacepedia_search.id";
            $item_price=Data_Mysql_Table_Item_Price::select($cols,$cond1,'',1,$table);
             
            if(!empty($item_price[0])){
                if($item_price[0]['item_name'] != $item_price[0]['space_name']){
                    $item_price[0]['item_space_name']=$item_price[0]['space_name'].'-'.$item_price[0]['item_name']."-".$item_price[0]['standard'];
                }else{
                    $item_price[0]['item_space_name']=$item_price[0]['space_name']."-".$item_price[0]['standard'];
                }

                if($item_price[0]['is_public']==1){
                    $show_price=empty($item_price[0]['discount_price'])?$item_price[0]['market_price']/100:$item_price[0]['discount_price']/100;
                    $price_unit=empty($item_price[0]['price_unit'])?"元/天":$item_price[0]['price_unit'];
                    $item_price[0]['item_space_name'].="&nbsp;&nbsp;售价：￥".$show_price.$price_unit;
                }

                if (!empty($item_price[0]['attr'])) {
                    $item_price[0]['attr'] = json_decode($item_price[0]['attr'], 1);
                }
                if (!empty($item_price[0]['attr']['特色标签'])) {
                    $item_price[0]['tags'] = explode(",", $item_price[0]['attr']['特色标签']);
                }   
                return $item_price[0];
            }
        } 
        return array();
    }
}