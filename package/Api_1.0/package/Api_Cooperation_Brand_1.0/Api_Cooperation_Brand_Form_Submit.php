<?php
/**
 * Created by PhpStorm.
 * User: bxy
 * Date: 2016/5/4
 * Time: 11:24
 * 品牌入驻表单提交
 * $args = array(
 *      'company'=>'公司名称',
 *      'brand'=>'品牌名称',
 *      'mode'=>'开店方式',
 *      'number'=>'开店数量',
 *      'contacts'=>'联系人',
 *      'phone'=>'手机号码',
 * );
 */
class Api_Cooperation_Brand_Form_Submit extends Api{
    static function handle(){
        return self::formSubmit($_REQUEST);
    }
    static function formSubmit($args){
        $request = Func_Input::filter(array(
            'company'=>'string',
            'brand'=>'string',
            'mode'=>'string',
            'number'=>'int',
            'contacts'=>'string',
            'phone'=>'int',
        ),$args);
        if(empty($request['company'])){
            return self::request('error','','请填写您的公司名称！');
        }
        if(empty($request['brand'])){
            return self::request('error','','请填写品牌名称！');
        }
        if(empty($request['mode'])){
            return self::request('error','','请填写开店方式！');
        }
        if(empty($request['number'])){
            return self::request('error','','请填写开店数量！');
        }
        if(empty($request['contacts'])){
            return self::request('error','','请填写您的姓名！');
        }
        if(empty($request['phone'])){
            return self::request('error','','请填写手机号码！');
        }
        $data['company'] = $request['company'];
        $data['brand'] = $request['brand'];
        $data['mode'] = $request['mode'];
        $data['number'] = $request['number'];
        $data['contacts'] = $request['contacts'];
        $data['phone'] = $request['phone'];
        $data['create_time'] = time();
        $res = Data_Mysql_Table_Brand_Form::insert($data);
        if(!empty($res[0])){
            return self::request('success',$res,'入驻成功！');
        }else{
            return self::request('error',$res,'入驻失败！');
        }
    }
}