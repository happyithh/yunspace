<?php  
 class Api_Item_Price_Info extends Api{
    /*
    * 返回场地的最大价格和最小价格
    * space_ids  场地id数组
    * is_inner   是否是内部使用  涉及到空间报价的显示问题 1为内部使用  0 为网站展示
    */
    static function getSpacePriceByIds($space_ids,$is_inner=0){ 
        $itemPriceNew=$itemPriceOld=$priceNew=$priceOld=array();
        //获取场地的空间报价
        if(is_array($space_ids)){
            $condition[] ='{table}.space_id in ('.implode(",",$space_ids).')';
        }else{
            $condition['{table}.space_id = ?'] = $space_ids;
        }
        
        $item_prices = Api_Item_Price_Info::getSpaceItemPrice($condition);
        //处理返回的有空间报价的数组
        foreach ($item_prices as $key => $value) {
            $itemPriceNew[$value['space_id']][]=$value;
        }
        //获取没有空间报价的场地id
        $new_space=$space_ids;
        if(!empty($itemPriceNew)){
            //处理有报价的
            foreach ($itemPriceNew as $k => $v) {
                $priceNew[$k]=self::handlePriceNew($v,$is_inner);
            }
            if(is_array($space_ids)){
                $new_space=array_diff($space_ids,array_keys($itemPriceNew));
            }else{
                $new_space=array();
            }
            
        }

        //处理没有报价的
        if(!empty($new_space)){
            //获取这些场地的空间
            if(is_array($space_ids)){
                $condition[] ='space_id in ('.implode(",",$space_ids).')';
            }else{
                $condition['space_id = ?'] = $space_ids;
            } 
            $condition['status'] = 1;
            $itemList = Api_Space_Item_List_And_Info::getSpaceItemList($condition, 1);
            // $itemList=Api_Item_List::getItemListBySpaceId($new_space,'',1);
            foreach ($itemList as $key => $value) {
                $itemPriceOld[$value['space_id']][]=$value;
            }
            //处理没有报价的
            foreach ($itemPriceOld as $k => $v) {
                $priceOld[$k]=self::handlePriceOld($v);
            }
        }
        $return_price=$priceNew+$priceOld;    
        return $return_price;
    }
    /*
    *处理有空间报价的
    */
    static function handlePriceNew($data,$is_inner,$is_low="起",$text_show="参考价",$min_price=0,$max_price=0){
        $unit=$unit_max="元/天";
        $return=array();
        foreach ($data as $key => $v) {
            //如果价格是在网站显示时，判断报价是否公开
            if($is_inner==0){
                if($v['is_public']==1 && $min_price==0){
                    $min_price=$v['discount_price'];
                    $min_price_B=$v['discount_price_B'];
                    $max_price=$v['discount_price'];
                    $max_price_B=$v['discount_price_B'];
                    $unit=$unit_max=empty($v['price_unit'])?"元/天":$v['price_unit'];  
                }
                if($v['is_public']==1){
                    if($v['discount_price']<$min_price){
                        $min_price=$v['discount_price'];
                        $min_price_B=$v['discount_price_B'];
                        $unit=empty($v['price_unit'])?"元/天":$v['price_unit'];  
                    }
                    if($v['discount_price']>$max_price){
                        $max_price=$v['discount_price'];
                        $max_price_B=$v['discount_price_B'];
                        $unit_max=empty($v['price_unit'])?"元/天":$v['price_unit'];  
                    }    
                }
                
            }else{
                if($min_price==0){
                    $min_price=$v['discount_price'];
                    $min_price_B=$v['discount_price_B'];
                    $max_price=$v['discount_price'];
                    $max_price_B=$v['discount_price_B'];
                    $unit=$unit_max=empty($v['price_unit'])?"元/天":$v['price_unit'];
                }
                if($v['discount_price']<$min_price){
                    $min_price=$v['discount_price'];
                    $min_price_B=$v['discount_price_B'];
                    $unit=empty($v['price_unit'])?"元/天":$v['price_unit'];
                }
                if($v['discount_price']>$max_price){
                    $max_price=$v['discount_price'];
                    $max_price_B=$v['discount_price_B'];
                    $unit_max=empty($v['price_unit'])?"元/天":$v['price_unit'];
                }
            }
        }
       
        $text_show="市场价";
        $return['baike_price']=$min_price;
        $return['min_price']=$min_price;
        $return['min_price_B']=$min_price_B;
        $return['max_price']=$max_price;
        $return['max_price_B']=$max_price_B;
        $unit=str_replace("元/",'',$unit);
        $unit_max=str_replace("元/",'',$unit_max);
        $return['price_unit']=$unit;
        $return['price_unit_max']=$unit_max;
        $return['text_show']=$text_show;
        if($min_price==$max_price){
            $is_low="";
        }
        $return['is_low']=$is_low;
        return $return;
    }
    /*
    *处理没有空间报价的
    */
    static function handlePriceOld($data,$is_low="起",$text_show="参考价",$min_price=0,$max_price=0){
        $unit=$unit_max='天';
        foreach($data as $k=>$v){
            if($v['min_price'] > 100){
                if($min_price==0){
                    $min_price=$v['min_price'];
                    $max_price=$v['max_price'];
                    $unit=$unit_max=empty($v['price_unit'])?"天":$v['price_unit'];
                }
                if($v['min_price']<$min_price){
                    $min_price=$v['min_price'];
                    $unit=empty($v['price_unit'])?"天":$v['price_unit'];
                }
                if($v['max_price']>$max_price){
                    $max_price=$v['max_price'];
                    $unit_max=empty($v['price_unit'])?"天":$v['price_unit'];
                }
            }
        }
        $text_show="参考价";
        $return['baike_price']=$min_price;
        $return['min_price']=$min_price;
        $return['max_price']=$max_price;
        $return['min_price_B'] = 0;
        $return['max_price_B'] = 0;
        $unit=str_replace("元/",'',$unit);
        $unit_max=str_replace("元/",'',$unit_max);
        $return['price_unit']=$unit;
        $return['price_unit_max']=$unit_max;
        $return['text_show']=$text_show;
        if($min_price==$max_price){
            $is_low="";
        }
        $return['is_low']=$is_low;
        return $return;
    }

    /*
     *根据场地id获取子空间价格列表
     * @param:$condition  array 检索条件
     * @return:列表数组
     */
    static function getSpaceItemPrice($condition=array(),$no_page=0){
        $condition['{prefix}space_item.status = ?']=1;
        $condition['{table}.price_status = ?']=1;
        $cols="{table}.*";
        $order="ORDER BY {table}.update_time DESC";
        $table="{table} LEFT JOIN {prefix}space_item ON {table}.item_id = {prefix}space_item.id LEFT JOIN {prefix}spacepedia ON {prefix}space_item.space_id = {prefix}spacepedia.id";
        $data=Data_Mysql_Table_Item_Price::select($cols,$condition,$order,50,$table);
        if(empty($data)){
            return array();
        }
        foreach($data as $k=>$v){
            if(!empty($v['market_price'])){
                $data[$k]['market_price']=$v['market_price']/100;
            }
            if(!empty($v['discount_price'])){
                $data[$k]['discount_price']=$v['discount_price']/100;
            }
            if(!empty($v['discount_price_B'])){
                $data[$k]['discount_price_B']=$v['discount_price_B']/100;
            }
            if(!empty($v['inner_price'])){
                $data[$k]['inner_price']=$v['inner_price']/100;
            }
            if(!empty($v['inner_price_B'])){
                $data[$k]['inner_price_B']=$v['inner_price_B']/100;
            }
        }
        return $data;
    }
 }
    