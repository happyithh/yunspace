<?php

/**
 * Created by PhpStorm.
 * User: adu
 * Date: 2015/10/23
 * Time: 14:59
 */
class Api_New_Space extends Api
{
    static function handle()
    {
        $action = empty($_REQUEST['action']) ? '' : $_REQUEST['action'];
        //q($_REQUEST);
        switch ($action) {
            //预约咨询
            case 'createspace':
                $data = self::handleCreateSpace();
                return $data;
                break;
            //办活动
            case 'events':
                self::handleCreateEventsDemand();
                break;

        }
    }

    //创建场地百科
    static function handleCreateSpace()
    {
        Core::output('');
        $request = Func_Input::filter(array(
            'space_name' => 'string',
            'category_id' => 'int',
            'city' => 'string',
            'addr' => 'string',
            'contacts' => 'string',
            'phone' => 'string',
            'email' => 'string',
            'media' => 'string',
            'countyname' => 'string',
            'account_id'=>'int',
        ), $_REQUEST);
        if (empty($request['contacts']) || empty($request['category_id']) || empty($request['phone']) || empty($request['account_id'])) {
            return self::request('error', '', '缺少参数或者参数不正确');
        }
        $data['space_name'] = $request['space_name'];
        $data['category_id'] = $request['category_id'];
        $data['city'] = $request['city'];
        /*$data['attr']['46'] = $request['city'];
        $data['attr']['4'] = $request['countyname'];*/
        $data['area'] = $request['countyname'];
        $data['addr'] = $request['addr'];
        $data['status'] = 0;
        $data['create_time'] = time();
        $data['card'] = self::MediaFormat($request['media']);
        $data['contacts'] = $request['contacts'];
        $data['phone'] = $request['phone'];
        $data['email'] = $request['email'];
        $data['account_id'] =$request['account_id'];
        $space = Data_Mysql_Table_New_Space::insert($data);
        if ($space[0] > 0) {
          //发邮箱通知
            if(Func_Input::isLocal()){
                return self::request('success', '', '场地信息提交成功，请等待审核');
            }else{
                $rs = array(
                    'space_id'=>$space[0],
                );
                Api_New_Space_Notice::noticeSpaceRefuse($rs);
                return self::request('success', '', '场地信息提交成功，请等待审核');
            }
        }else{
            return self::request('error', '', '场地信息提交失败');
         }

    }

    static function  MediaFormat($media)
    {
        $media = explode(',', $media);
        $formatMedia = array();
        foreach ($media as $k => $val) {
            if (!empty($val)) {
                $formatMedia[$k]['path'] = $val;
                $formatMedia[$k]['tags'] = '';
                $formatMedia[$k]['name'] = '';
                $formatMedia[$k]['video'] = '';
            }
        }
        return $formatMedia;
    }
}