<?php
/*
 * Created by PhpStorm
 * User: yl
 * Date: 2015/9/24
 * Time: 10:13
 * 套餐表单提交接口
 */
class Api_Product_Set_Submit extends Api
{

    static function handle($args="")
    {
        return self::handleSetSubmit($args);
    }

    //验证产品表单字段和提交入库
    static function handleSetSubmit($args="") {
        $request = Func_Input::filter(array(
            'set_id' => 'int',
            'vendor_id'=>'int',
            'schedule_product_id' => 'int',
            'data' => 'array',
        ));

        $request['data']['hours'] = !empty($request['data']['hours']) ? intval($request['data']['hours']) : 0;
        $request['data']['people'] = !empty($request['data']['people']) ? intval($request['data']['people']) : 0;
        $request['data']['people'] = !empty($request['data']['people']) ? intval($request['data']['people']) : 0;
        $request['data']['detail']['计价下限'] = !empty($request['data']['detail']['计价下限']) ? intval($request['data']['detail']['计价下限']) : 1;
        $request['data']['detail']['计价上限'] = !empty($request['data']['detail']['计价上限']) ? intval($request['data']['detail']['计价上限']) : 1;
        if (!empty($request['data']['detail_data'])) {
            unset($request['data']['detail_data']['$$']);
            $request['data']['detail_data'] = array_values($request['data']['detail_data']);
        }
        if (!empty($request['data']['media'])) {
            unset($request['data']['media']['$$']);
            $request['data']['media'] = array_values($request['data']['media']);
            foreach ($request['data']['media'] as $mk => $mv) {
                //主图
                if (empty($request['data']['logo'])) {
                    $request['data']['logo'] = $mv['path'];
                }
                if (strpos($mv['tags'], '@主图') !== false) {
                    $request['data']['logo'] = $mv['path'];
                    break;
                }
            }
        }

        if (empty($request['data']['set_name'])) {
            return self::request('error',"",'套餐名称不能为空！');
        }
        if (empty($request['data']['marketing_title'])) {
//            Func_Header::back('营销标题不能为空！');
        }
        if (empty($request['data']['category_id'])) {
            return self::request('error',"",'类别不能为空！');
        }
        if (empty($request['data']['attr_index']['城市'])) {
            $request['data']['attr_index']['城市'] = '上海';
        }
        if (empty($request['data']['des'])) {
            return self::request('error',"",'套餐简介不能为空！');
        }
        if (empty($request['data']['hours'])) {
            return self::request('error',"",'小时数不能为空！');
        }
        if (empty($request['data']['detail']['套餐价']) || !(is_numeric($request['data']['detail']['套餐价']))) {
            return self::request('error',"",'套餐价必须正确填写！');
        }
        if (!empty($request['data']['detail']['计价单位'])) {
            if ((empty($request['data']['detail']['计价下限']) || empty($request['data']['detail']['计价上限']))) {
                $request['data']['detail']['计价下限'] = $request['data']['detail']['计价上限'] = 1;
            }
            if (!empty($request['data']['detail']['计价下限']) && !empty($request['data']['detail']['计价上限']) && $request['data']['detail']['计价下限'] > $request['data']['detail']['计价上限']) {
                $request['data']['detail']['计价上限'] = $request['data']['detail']['计价下限'];
            }
        }
        if (!empty($request['data']['attr_index']['开始时间']) && !empty($request['data']['attr_index']['结束时间']) && $request['data']['attr_index']['开始时间'] > $request['data']['attr_index']['结束时间']) {
            return self::request('error',"",'请正确填写套餐的有效期！');
        }
        if (empty($request['data']['version'])) {
            $request['data']['version'] = '品质版';
        }
        if (empty($request['data']['attr_index']['人数'])) {
            $request['data']['attr_index']['人数'] = '不限';
        }
        $data = array();
        $data['schedule_product_id'] = intval($request['schedule_product_id']);
        $data['vendor_id'] = $request['vendor_id'];
        $data['set_name'] = $request['data']['set_name'];
        $data['addr'] = $request['data']['addr'];
        $data['version'] = $request['data']['version'];
        $data['category_id'] = $request['data']['category_id'];
        $data['attr_index'] = $request['data']['attr_index'];
        $data['detail_des'] = $request['data']['detail_des'];
        $data['detail'] = $request['data']['detail'];
        $data['media'] = $request['data']['media'];
        $data['logo'] = !empty($request['data']['logo']) ? $request['data']['logo'] : '';
        $data['des'] = $request['data']['des'];
        $data['hours'] = intval($request['data']['hours']);
        $data['people'] = intval($request['data']['people']);
        $data['set_price'] = $request['data']['detail']['套餐价'];
        $data['marketing_title'] = empty($request['data']['marketing_title'])?'':$request['data']['marketing_title'];
        $data['status'] = 2;
        if ($request['set_id']) {
            $rs = Data_Mysql_Table_Product_Set::subTable('_update')->update(array('id' => $request['set_id']), $data);
        } else {
            $rs = Data_Mysql_Table_Product_Set::subTable('_update')->insert($data);
        }
        if ($rs[0] > 0) {
            //更改所属供应商的状态
            Data_Mysql_Table_Vendor_Info::subTable('_update')->update(array('id = ? and status != ?' => array($request['vendor_id'], 2)), array('status' => 4));
            if(!empty($request['set_id'])){
                $set_id=$request["set_id"];
            }else{
                $set_id=$rs[0];
            }
            return self::request('success',$set_id,"套餐添加/修改成功！");

        }else{
            return self::request('error',"","套餐添加/修改失败！");
        }
    }

}