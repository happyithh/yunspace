<?php

/**
 * Created by PhpStorm.
 * User: bxy
 * Date: 2015/10/22
 * Time: 18:22
 * 广告添加
 *
 */
class Api_Pa_Add extends Api
{
    static function paSubmit($args)
    {
        $request=Func_Input::filter(array(
            'id'=>'int',
            'rank' => 'int',
            'site_id' => 'int',
            'city' => 'string',
            'price' => 'string',
            'price_unit'=>'string',
            'company' => 'string',
            'contact' => 'string',
            'phone'=>'string',
            'email' => 'email',
            'advertising_title'=>'string',
            'advertising_link'=>'string',
            'content'=>'string',
            'note'=>'string',
            'media'=>'array',
            'default_adver'=>'int',
            'status'=>'int',
            'start_time' => 'string',
            'end_time' => 'string',
        ),$args);
//        q($args);
        if(!empty($request)){
            if(empty($request['site_id'])){
                return self::request('error','','请选择广告位置!');
            }
            $request['rank']=trim($request['rank']);
            if(empty($request['rank'])){
                return self::request('error','','排列顺序不能为空!');
            }
            $arr = Data_Mysql_Table_Pa_Site::select('site,adver_city',array('id'=>$request['site_id']));
            if($arr[0]['adver_city']==1 && empty($request['city'])){
                return self::request('error','','请选择城市!');
            }
            if($arr[0]['adver_city']==0){
               $request['city']='';
            }
            // 图片处理
            if(count($request['media'])==1){
                return self::request('error','','请上传一张图片!');
            }
//            q(count($request['media']));
            if(count($request['media'])>2){
//                q($arr[0]['number']);
                return self::request('error','','只能上传一张图片!');
            }
//            q($request['media']);
            foreach($request['media'] as $k=>$v){
               if($k=='$$'){
                   unset($request['media']['$$']);
               }
                $media_path = $v['path'];
            }
//            q($media_path);
            if (!empty($request['start_time']) && !empty($request['end_time'])) {
                if (strtotime($request['start_time'] . "00:00:00") > strtotime($request['end_time'] . "23:59:59")) {
                    return self::request('error', '', '请正确选择时间范围!!');
                }
                $request['start_time'] = strtotime($request['start_time'] . "00:00:00");
                $request['end_time'] = strtotime($request['end_time'] . "23:59:59");
            }
            if (empty($request['start_time']) || empty($request['end_time'])) {
                return self::request('error', '', '请选择时间范围!!');
            }

        }
        $data=array();
        $data['rank']=$request['rank'];
        $data['site_id']=$request['site_id'];
        $data['city']=$request['city'];
        $data['start_time']=$request['start_time'];
        $data['end_time']=$request['end_time'];
        $data['price']=$request['price'].'/'.$request['price_unit'];
        $data['company']=$request['company'];
        $data['contact']=$request['contact'];
        $data['email']=$request['email'];
        $data['phone']=$request['phone'];
        $data['advertising_title']=$request['advertising_title'];
        $data['advertising_link']=$request['advertising_link'];
        $data['content']=$request['content'];
        $data['status']=$request['status'];
        $data['note']=$request['note'];
        $data['path']=$media_path;
        $data['default_adver']=$request['default_adver'];
//        q($data);
        @session_start();
        if(empty($request['id'])){
            $data['create_time']=time();
            $res = Data_Mysql_Table_Pa::insert($data);
            if($res[0]>0){
                //创建操作日志
                $account_id = Api_Administrator_GetBaseAccountInfo::getBastAccountInfo(array('admin_id'=>$_SESSION['administrator']['id']));
                Data_Mysql_Table_Account_Log::insertAccountLog($account_id['account_id'],$_SESSION['administrator']['id'],'广告创建--'.$data['advertising_title'],'广告位管理',$res[0]);
                return self::request('success','','添加成功！');
            }else{
                return self::request('error','','添加失败！');
            }
        }else{
            $data['update_time']=time();
//            Data_Mysql_Table_Pa::debug(1);
            $res = Data_Mysql_Table_Pa::update(array('id'=>$request['id']),$data);
//            q($res);
            if($res[0]>0){
                //创建操作日志
                $account_id = Api_Administrator_GetBaseAccountInfo::getBastAccountInfo(array('admin_id'=>$_SESSION['administrator']['id']));
                Data_Mysql_Table_Account_Log::insertAccountLog($account_id['account_id'],$_SESSION['administrator']['id'],'广告修改--'.$data['advertising_title'],'广告位管理',$request['id']);
                return self::request('success','','修改成功！');
            }else{
                return self::request('error','','修改失败！');
            }
        }


    }
}