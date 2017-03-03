<?php
/*
 * Created by PhpStorm
 * User: Yangchenglin
 * Date: 2015/11/27
 * Time: 13:33
 */
//场地管理移动端上传图片
class Api_Demand_Product_Media_Upload_Edit extends Api
{
    static function handle($args='')
    {
        return self::handleUploadEdit($args);
    }


    static function handleUploadEdit($args)
    {
        $request = Func_Input::filter(array(
            'space_pedia_id' => 'int',
            'media' => 'array',
        ), $args);


        if(empty($request['space_pedia_id']) || empty($request['media'])) {
            return $result = self::request('error', '', '参数错误！');
        }else{
            $media = array_chunk($request['media'],3);
            foreach($media as $k=>$v) {
                foreach($v as $kk=>$vv) {
                    if($kk==0) {
                        unset($media[$k][$kk]);
                        $media[$k]['path'] = $vv;
                    }
                    if($kk==1) {
                        unset($media[$k][$kk]);
                        $media[$k]['name'] = $vv;
                    }
                    if($kk==2) {
                        unset($media[$k][$kk]);
                        $media[$k]['tags'] = $vv;
                    }
                }
            }
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

            $pedia_data['data_backup']['media'] = $media;
            $pedia_data['data_backup']['space_id']=$request['space_pedia_id'];
//            q($pedia_data['data_backup']);
            $return=Api_Spacepedia_Submit::spacepediaInfoSubmit($pedia_data['data_backup']);
            if(!empty($return["status"])) {
                return $result = self::request('success','','修改成功，请等待审核！');
            }else{
                return $result = self::request('error','','上传失败');
            }
        }

    }
}