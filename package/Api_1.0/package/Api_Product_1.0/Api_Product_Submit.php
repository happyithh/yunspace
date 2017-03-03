<?php

/*
 * Created by PhpStorm
 * User: Yangchenglin
 * Date: 2015/9/18
 * Time: 17:13
 */

class Api_Product_Submit extends Api
{

    //产品表单验证提交接口
    static function handle($table, $args = '', $type = '')
    {
//        if(Api_Session::user_info())
        if (Api_Session::user_id() || Api_Session::admin_id()) {
            if ($type == 'check') {
                $result = self::handleCheck($args);
            } elseif ($type == 'submit') {
                $result = self::handleSubmit($table, $args);
            } elseif (empty($type)) {
                $result = self::handleCheckSubmit($table, $args);
            }
        } else {
            $result = array(
                'status' => 0,
                'msg' => "请登录后再操作~",
                "data" => ''
            );
        }
        return $result;
    }

    //验证产品表单字段和提交入库
    static function handleCheckSubmit($table, $args)
    {
        $request = Func_Input::filter(array(
            'product_id' => 'int',
            'hide_price' => 'int',
            'city' => 'string',
            'data' => 'array',
            'data_p' => 'array',
            'edit' => 'int',
        ), $args);

        if (!empty($request['edit']) && empty($request['product_id'])) {
            $result = array(
                'status' => 0,
                'msg' => "参数错误！！",
                "data" => ''
            );
            return $result;
        }
        if (!empty($request['data_p'])) {
            $request['data'] = $request['data_p'];
        }
        if (empty($request['data']['product_name'])) {
            $result = array(
                'status' => 0,
                'msg' => "产品名称不能为空！！",
                "data" => ''
            );
            return $result;
        }
        if (!empty($request['data']['price']) && !is_numeric($request['data']['price'])) {
            $result = array(
                'status' => 0,
                'msg' => "价格填写必须为数字！！",
                "data" => ''
            );
            return $result;
        }
        if (empty($request['data']['des'])) {
            $result = array(
                'status' => 0,
                'msg' => "产品描述不能为空！！",
                "data" => ''
            );
            return $result;
        }
        if (empty($request['data']['attr_new'][46])) {
            $request['data']['attr_new'][46] = $request['city'];
            if (empty($request['data']['attr_new'][46])) {
                $result = array(
                    'status' => 0,
                    'msg' => "城市不能为空！！",
                    "data" => ''
                );
                return $result;
            }
        }
        if (!empty($request['data']['attr_new']['计价单位']) && (empty($request['data']['attr_new']['计价下限']) || empty($request['data']['attr_new']['计价上限']))) {
            $result = array(
                'status' => 0,
                'msg' => "订购数量的上下限不能为空！！",
                "data" => ''
            );
            return $result;
        }
        if (!empty($request['data']['attr_new']['计价下限']) && !empty($request['data']['attr_new']['计价上限']) && $request['data']['attr_new']['计价下限'] > $request['data']['attr_new']['计价上限']) {
            $result = array(
                'status' => 0,
                'msg' => "请正确填写订购数量的上下限！！",
                "data" => ''
            );
            return $result;
        }

        if (!empty($request['data']['price'])) {
            if (!empty($request['hide_price']) || !empty($request['data']['hide_price'])) {
                $request['data']['price'] *= -100;
            } else {
                $request['data']['price'] *= 100;
            }
        } else {
            $request['data']['price'] = 0;
        }
        if (!empty($request['data']['media'])) {
            unset($request['data']['media']['$$']);
            $request['data']['media'] = array_values($request['data']['media']);
            $request['data']['media_num'] = count($request['data']['media']);
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
        $request['data']['status'] = 2;
        $request['data']['admin_id'] = $_SESSION['administrator']['id'];
        if ($table == 'update') {
            if (!empty($request['product_id'])) {
                $row = Data_Mysql_Table_Product_Info::subTable('_update')->update(array('id' => $request['product_id']), $request['data']);
            } else {
                $row = Data_Mysql_Table_Product_Info::subTable('_update')->insert($request['data']);
            }
        } else {
            if (!empty($request['product_id'])) {
                $row = Data_Mysql_Table_Product_Info::update(array('id' => $request['product_id']), $request['data']);
            } else {
                $row = Data_Mysql_Table_Product_Info::insert($request['data']);
            }
        }
        if ($row[0] > 0) {
            $result = array(
                'status' => 1,
                'msg' => "操作成功",
                "data" => $row[0]
            );
        } else {
            $result = array(
                'status' => 0,
                'msg' => "操作失败",
                "data" => ''
            );
        }
        return $result;
    }


    //只验证产品表单字段
    static function handleCheck($args)
    {
        $request = Func_Input::filter(array(
            'product_id' => 'int',
            'hide_price' => 'int',
            'city' => 'string',
            'data' => 'array',
            'data_p' => 'array',
            'edit' => 'int',
        ), $args);

        if (!empty($request['edit']) && empty($request['product_id'])) {
//            Func_Header::back('参数错误！！');
            $result = array(
                'status' => 0,
                'msg' => "参数错误！！",
                "data" => ''
            );
            return $result;
        }
        if (!empty($request['data_p'])) {
            $request['data'] = $request['data_p'];
        }
        if (empty($request['data']['product_name'])) {
            $result = array(
                'status' => 0,
                'msg' => "产品名称不能为空！！",
                "data" => ''
            );
            return $result;
        }
        if (!empty($request['data']['price']) && !is_numeric($request['data']['price'])) {
            $result = array(
                'status' => 0,
                'msg' => "价格填写必须为数字！！",
                "data" => ''
            );
            return $result;
        }
        if (empty($request['data']['des'])) {
            $result = array(
                'status' => 0,
                'msg' => "产品描述不能为空！！",
                "data" => ''
            );
            return $result;
        }
        if (empty($request['data']['attr_new'][46])) {
            $request['data']['attr_new'][46] = $request['city'];
            if (empty($request['data']['attr_new'][46])) {
                $result = array(
                    'status' => 0,
                    'msg' => "城市不能为空！！",
                    "data" => ''
                );
                return $result;
            }
        }
        if (!empty($request['data']['attr_new']['计价单位']) && (empty($request['data']['attr_new']['计价下限']) || empty($request['data']['attr_new']['计价上限']))) {
            $result = array(
                'status' => 0,
                'msg' => "订购数量的上下限不能为空！！",
                "data" => ''
            );
            return $result;
        }
        if (!empty($request['data']['attr_new']['计价下限']) && !empty($request['data']['attr_new']['计价上限']) && $request['data']['attr_new']['计价下限'] > $request['data']['attr_new']['计价上限']) {
            $result = array(
                'status' => 0,
                'msg' => "请正确填写订购数量的上下限！！",
                "data" => ''
            );
            return $result;
        } else {
            return $result = array(
                'status' => 1,
                'msg' => "成功",
                "data" => ''
            );
        }
    }


    //给一个数组，只将数组插入到product_info_(update)表中
    static function handleSubmit($table, $args)
    {
        $request = Func_Input::filter(array(
            'product_id' => 'int',
            'hide_price' => 'int',
            'city' => 'string',
            'data' => 'array',
            'data_p' => 'array',
            'edit' => 'int',
        ), $args);

        if (!empty($request['data_p'])) {
            $request['data'] = $request['data_p'];
        }

        if (empty($request['data']['attr_new'][46])) {
            $request['data']['attr_new'][46] = $request['city'];
        }

        if (!empty($request['data']['price'])) {
            if (!empty($request['hide_price']) || !empty($request['data']['hide_price'])) {
                $request['data']['price'] *= -100;
            } else {
                $request['data']['price'] *= 100;
            }
        } else {
            $request['data']['price'] = 0;
        }
        if (!empty($request['data']['media'])) {
            unset($request['data']['media']['$$']);
            $request['data']['media'] = array_values($request['data']['media']);
            $request['data']['media_num'] = count($request['data']['media']);
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
        $request['data']['status'] = 2;
        $request['data']['admin_id'] = $_SESSION['administrator']['id'];
        if ($table == 'update') {
            if (!empty($request['product_id'])) {
                $row = Data_Mysql_Table_Product_Info::subTable('_update')->update(array('id' => $request['product_id']), $request['data']);
            } else {
                $row = Data_Mysql_Table_Product_Info::subTable('_update')->insert($request['data']);
            }
        } else {
            if (!empty($request['product_id'])) {
                $row = Data_Mysql_Table_Product_Info::update(array('id' => $request['product_id']), $request['data']);
            } else {
                $row = Data_Mysql_Table_Product_Info::insert($request['data']);
            }
        }
        if ($row[0] > 0) {
            $result = array(
                'status' => 1,
                'msg' => "操作成功",
                "data" => $row[0]
            );
        } else {
            $result = array(
                'status' => 0,
                'msg' => "操作失败",
                "data" => ''
            );
        }
        return $result;
    }
}