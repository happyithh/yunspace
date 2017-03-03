<?php
/*
 * Created by PhpStorm
 * User: yl
 * Date: 2015/9/24
 * Time: 12:00
 * 活动案例提交接口
 */
class Api_Case_Submit extends Api
{

    static function handle($args='')
    {
        return self::handleCaseSubmit();
    }

    static function handleCaseSubmit($args="") {
        $request = Func_Input::filter(array(
            'set_id' => 'int',
            'product_id'=>'int',
            'case_id' => 'int',
            'vendor_id' => 'int',
            'data' => 'array',
        ));
        if (!$request['data']['event_name']) {
            Func_Header::back("操作失败, 活动名称不能为空！");
        }
        if (!empty($request['data']['media'])) {
            unset($request['data']['media']['$$']);
        }
        $media = array_values($request['data']['media']);

        $event_id = Func_String::strCut($request['data']['event_name'], '[', ']');
        if (empty($event_id)) {
            $logo = '';
            if (!empty($media)) {
                foreach ($media as $mk => $mv) {
                    $logo = $mv['path'];
                    if (strpos($mv['tags'], '@主图') !== false) {
                        $logo = $mv['path'];
                        break;
                    }
                }
            }
            $attr = $request['data']['attr'];
            $attr['城市'] = $_COOKIE['city'];
            $event_data = array(
                'event_name' => $request['data']['event_name'],
                'attr' => $attr,
                'logo' => $logo,
                'media' => $media,
                'des' => $request['data']['des'],
                'status' => 0,
                'create_time' => time(),
            );
            $event_rs = Data_Mysql_Table_Event_Info::insert($event_data);
            if (!empty($event_rs)) {
                $event_id = $event_rs[0];
                $request['data']['event_name'] = "[" . $event_id . "] " . $request['data']['event_name'];
            } else {
                return self::request("error","",'添加活动失败！！');
            }
        }

        $data = array(
            'product_id' => empty($request['product_id'])?0:$request['product_id'],
            'product_set_id' => empty($request['set_id'])?0:$request['set_id'],
            'vendor_id' => $request['vendor_id'],
            'case_name' => empty($request['data']['case_name']) ? $request['data']['event_name'] : $request['data']['case_name'],
            'des' => $request['data']['des'],
            'media' => array($request['data']['attr'], $media),
            'event_id' => $event_id,
            'status' => 2,
        );
        if (!empty($request['case_id'])) {
            $r = Data_Mysql_Table_Event_Case::subTable('_update')->update(array('id' => $request['case_id']), $data);
        } else {
            $r = Data_Mysql_Table_Event_Case::subTable('_update')->insert($data);
        }
        //添加案例信息
        if ($r[0] > 0) {
            Data_Mysql_Table_Vendor_Info::subTable('_update')->update(array('id = ? and status != ?' => array($data['vendor_id'], 2)), array('status' => 4));
            if (!empty($request['case_id'])) {
                return self::request('success',$request['case_id'],"活动案例信息修改成功！");
            }else{
                return self::request('success',$r[0],"活动案例信息修改成功！");
            }
        } else {
            return self::request('error',"","活动案例信息添加/修改失败！");
        }
    }


}