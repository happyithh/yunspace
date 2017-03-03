<?php
/*
 * Created by PhpStorm
 * User: Yangchenglin
 * Date: 2015/11/27
 * Time: 13:33
 */
//场地管理移动端上传图片
class Api_Demand_Product_Media_Upload extends Api
{
    static function handle($args='')
    {
        return self::handleUpload($args);
    }


    static function handleUpload($args)
    {
        $request = Func_Input::filter(array(
            'space_pedia_id' => 'int',
            'logo' => 'string',
//            'media' => 'array',
            'action' => 'string',
            'media_name' => 'string',
        ),$args);

        //修改logo
        if(!empty($request['logo'])) {
            if(strpos($request['logo'],'upload2')) {
                $request['logo'] = str_replace('upload2','upload',$request['logo']);
            }
            $request['logo'] = '/'.substr($request['logo'],strpos($request['logo'],'upload'));
            if($request['action'] == 'change') {

                $pedia_data = array();
                //调取历史表中的数据
                $spacepedia=Api_Spacepedia_List_And_Info::getHistoryInfoById($request['space_pedia_id']);
                if(empty($spacepedia)) {
                    //历史表中数据不存在，调用百科表数据
                    $spacepedia_info = Api_Spacepedia_List_And_Info::getSpacepediaInfoById($request['space_pedia_id']);
                    if(empty($spacepedia_info[0])){
                        Func_Header::back('数据不存在！！');
                    }else{
                        $pedia_data["object_id"]=$spacepedia_info[0]['id'];
                        $pedia_data["data_backup"]=$spacepedia_info[0];
                    }
                } else {
                    $pedia_data = $spacepedia[0];
                }

                $pedia_data['data_backup']['logo'] = $request['logo'];
                $pedia_data['data_backup']['space_id']=$request['space_pedia_id'];
//            q($pedia_data['data_backup']);
                $return=Api_Spacepedia_Submit::spacepediaInfoSubmit($pedia_data['data_backup']);
                if(!empty($return["status"])) {
                    return $result = self::request('success','','修改成功，请等待审核！');
                }else{
                    return $result = self::request('error','','上传失败');
                }
            }
            //添加更多图片
            elseif($request['action'] == 'add') {

                $pedia_data = array();
                //调取历史表中的数据
                $spacepedia=Api_Spacepedia_List_And_Info::getHistoryInfoById($request['space_pedia_id']);
                if(empty($spacepedia)) {
                    //历史表中数据不存在，调用百科表数据
                    $spacepedia_info = Api_Spacepedia_List_And_Info::getSpacepediaInfoById($request['space_pedia_id']);
                    if(empty($spacepedia_info[0])){
                        Func_Header::back('数据不存在！！');
                    }else{
                        $pedia_data["object_id"]=$spacepedia_info[0]['id'];
                        $pedia_data["data_backup"]=$spacepedia_info[0];
                    }
                } else {
                    $pedia_data = $spacepedia[0];
                }
                $num = count($pedia_data['data_backup']['media']);
                $pedia_data['data_backup']['media'][$num]['path'] = $request['logo'];
                $pedia_data['data_backup']['media'][$num]['name'] = mt_rand(1000,9999).'.'.end(explode('.',$request['media_name']));
                $pedia_data['data_backup']['media'][$num]['tags'] = '外景图片';
                $pedia_data['data_backup']['space_id']=$request['space_pedia_id'];
                $return=Api_Spacepedia_Submit::spacepediaInfoSubmit($pedia_data['data_backup']);
                if(!empty($return["status"])) {
                    return $result = self::request('success','','修改成功，请等待审核！');
                } else {
                    return $result = self::request('error','','上传失败');
                }
            }
        } else {
            return $result = self::request('error','','未知错误');
        }
    }
}