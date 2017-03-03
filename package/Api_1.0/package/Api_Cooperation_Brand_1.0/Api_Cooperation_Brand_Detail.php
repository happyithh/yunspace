<?php
/**
 * Created by PhpStorm.
 * User: bxy
 * Date: 2016/5/4
 * Time: 10:25
 * 合作品牌详情页面
 */
class Api_Cooperation_Brand_Detail extends Api{
    static function getBrandDetail($type=1){
        $request=Func_Input::filter(array(
            'id'=>'int',
        ),$_REQUEST);
        if(empty($request['id'])){
            Func_Header::back('操作异常！');
        }
        $conditions['id =?'] = $request['id'];
        $conditions['status != ?'] =-1;
        $conditions['type = ?'] =$type;

        $data = Data_Mysql_Table_Cooperation_Brand::select('*',$conditions);
        if(!empty($data[0]['attr'])){
            $data[0]['attr'] = json_decode($data[0]['attr'],1);
        }
        if(!empty($data[0]['brand_pic'])){
            $data[0]['brand_pic'] = json_decode($data[0]['brand_pic'],1);
        }
        if(!empty($data[0]['brand_case'])){
            $data[0]['brand_case'] = json_decode($data[0]['brand_case'],1);
        }
//        q($data[0]['brand_pic']);
        return $data;
    }
}