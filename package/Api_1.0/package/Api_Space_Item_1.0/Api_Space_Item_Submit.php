<?php
/**
 * Created by PhpStorm.
 * User: yl
 * Date: 15-10-19
 * Time: 下午2:51
 * 子空间数据提交
 */
class Api_Space_Item_Submit{
    static function spaceItemSubmit($data){
        $request=Func_Input::filter(array(
            'space_id' => 'int',
            'item_id' => 'int',
            'item_name' => 'string',
            'city' => 'string',
            'logo' => 'string',
            'size' => 'string',
            'location_area' => 'string',
            'lifetime' => 'string',
            'activity_type' => 'array',
            'tags' => 'array',
            'price_unit' => 'string',
            'min_price' => 'string',
            'max_price' => 'string',
            'min_people' => 'int',
            'max_people' => 'int',
            'media' => 'array',
            'des' => 'html',
            'contacts' => 'string',
            'phone' => 'phone',
            'email' => 'email',
            'product_id' => 'int',
            'expand_status' => 'int',
        ),$data);
//        if(empty($request['phone'])){
//            Func_Header::back('请输入正确的手机号');
//        }
        if(empty($request['item_name'])){
            Func_Header::back('子空间名称不能为空！！');
        }
//        if(empty($request['tags'])){
//            Func_Header::back('标签不能为空！！');
//        }else{
//            $request['tags']=explode(",",$request['tags']);
//        }
//        if(empty($request['tags'])){
//            Func_Header::back('标签不能为空！！');
//        }
        if(empty($request['min_price'])){
            $request['min_price']=1;
        }
        if(empty($request['max_price'])){
            $request['max_price']=$request['min_price'];
        }
        if($request['min_price'] > $request['max_price']){
            Func_Header::back('请正确填写最大价格和最小价格！！');
        }
        if(empty($request['min_people'])){
            $request['min_people']=1;
        }
        if(empty($request['max_people'])){
            $request['max_people']=$request['min_people'];
        }
        if($request['min_people'] > $request['max_people']){
            Func_Header::back('请正确填写最大人数和最小人数！！');
        }
//        if($request['max_people']>50 && $request['min_people'] < $request['max_people']*0.5){
//            Func_Header::back('最小人数不能低于最大人数的50%');
//        }
        if(!isset($data['status'])){
            $data['status']=2;
        }
        $update_data['min_price']=$request['min_price']*100;
        $update_data['max_price']=$request['max_price']*100;
        $update_data['min_people']=$request['min_people'];
        $update_data['max_people']=$request['max_people'];
        $update_data['space_id']=$request['space_id'];
        $update_data['item_name']=$request['item_name'];
        $update_data['tags']=$request['tags'];
        $update_data['location_area']=$request['location_area'];
        $update_data['lifetime']=$request['lifetime'];
        $update_data['price_unit']=$request['price_unit'];
        $update_data['des']=$request['des'];
        $update_data['contacts']=$request['contacts'];
        $update_data['phone']=$request['phone'];
        $update_data['email']=$request['email'];
        $update_data['city']=$request['city'];
        $update_data['product_id']=$request['product_id'];
        $update_data['status']=$data['status'];
        $update_data['expand_status']=$data['expand_status'];
        $update_data['size']=$data['size'];
        if (!empty($request['media'])) {
            unset($request['media']['$$']);
            $request['media'] = array_values($request['media']);
            foreach ($request['media'] as $mk => $mv) {
                //主图
                if (empty($request['logo'])) {
                    $request['logo'] = $mv['path'];
                }
                if (!empty($mv['tags']) && strpos($mv['tags'], '@主图') !== false) {
                    $request['logo'] = $mv['path'];
                    break;
                }
            }
        }
        $update_data['media']=$request['media'];
        $update_data['logo']=$request['logo'];
        if(empty($request['item_id'])){
            $rs=Data_Mysql_Table_Space_Item::insert($update_data);
            $match_data['item_id']=$rs[0];
        }else{
            $rs=Data_Mysql_Table_Space_Item::update(array('id'=>$request['item_id']),$update_data);
            $match_data['item_id']=$request['item_id'];
        }
        if(empty($rs[0])){
            return false;
        }else{
            //获取子空间所属百科的供应商
            $spacepedia=Api_Spacepedia_List_And_Info::getSpacepediaInfoById($update_data['space_id']);
            //同步匹配表
            $match_data['price_up'] = $update_data['max_price'];
            $match_data['price_down']=$update_data['min_price'];
            $match_data['people_up']=$update_data['max_people'];
            $match_data['people_down']=$update_data['min_people'];
            $match_data['tags'] = $update_data['tags'];
            $match_data['city'] = $update_data['city'];
            $match_data['vendor_id'] = $spacepedia['vendor_id'];
            Data_Mysql_Table_Demand_Match_Space_Archives::update($match_data);
            $item_id=empty($request['item_id'])?$rs[0]:$request['item_id'];
            return $item_id;
        }
    }
}