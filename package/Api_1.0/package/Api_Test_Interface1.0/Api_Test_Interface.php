<?php

/**
 * Created by PhpStorm.
 * User: bxy
 * Date: 2015/7/22
 * Time: 12:30
 *
 *
 * 测试接口
 *
 * 开发人员内部使用
 */
class Api_Test_Interface extends Api
{
    static function handle($args)
    {
        if ($args['tab'] == 'getInterface') {
//            q($args);
            return self::interfaceName($args);
        } elseif ($args['tab'] == 'getInterfaceField') {
            return self::InterfaceField($args);
        } elseif ($args['tab'] == 'addSubmit') {
            return self::testInterfaceAdd($args);
        } elseif ($args['tab'] == 'deleteInterface') {
            return self::testInterfaceDelete($args);
        } elseif ($args['tab'] == 'editInterface') {
            return self::testInterfaceEdit($args);
        } elseif ($args['tab'] == 'testInterfaceAdd') {
            return self::testInterfaceAdd($args);
        }
    }

    // 测试接口的添加
    static function testInterfaceAdd($args)
    {
        $request = Func_Input::filter(array(
            'id' => 'int',
            'interface_name' => 'string',
            'category' => 'string',
            'des' => 'string',
            'type' => 'string',
            'data' => 'string'
        ), $args);
        //对接收的参数进行处理
        if (empty($request['interface_name'])) {
            return self::request('error', '', '接口名称不能为空！');
        }
        if (empty($request['category'])) {
            return self::request('error', '', '接口分类不能为空！');
        }
        //字段处理
        $da['interface_name'] = $request['interface_name'];
        $da['category'] = $request['category'];
        $da['des'] = $request['des'];
        $da['type'] = $request['type'];
        $da['status'] = 0;
        $da['update_time'] = time();
        $da['data'] = $request['data'];
        // 修改提交
        if (!empty($request['id'])) {
            $res = Data_Mysql_Table_Test_Interface::update(array('id' => $request['id']), $da);
            if (!empty($res)) {
                return self::request('success', $res, '修改成功！');
            }
        }
        //接口名存在的情况下 更新接口内容   否则 添加测试接口
        if (!empty($request['interface_name'])) {
            $re = Data_Mysql_Table_Test_Interface::select('id', array('interface_name' => $request['interface_name']));
            if (!empty($re)) {
                $res = Data_Mysql_Table_Test_Interface::update(array('id' => $re[0]['id']), $da);
                if (!empty($res)) {
                    return self::request('success', $res, '接口已存在，更新成功！');
                }
            } else {
                $da['create_time'] = time();
                $res = Data_Mysql_Table_Test_Interface::insert($da);
                if (!empty($res)) {
                    return self::request('success', $res, '添加成功！');
                }
            }
            if (empty($res)) {
                return self::request('error', '', '添加失败！');
            }
        }


    }

    // 测试接口显示列表
    static function testInterfaceList($args)
    {
        $data = Data_Mysql_Table_Test_Interface::page(0, 15, "id,interface_name,category,des,type,update_time,status", array('status' => 0), 'ORDER BY id DESC');
        return self::request('success', $data, '');
    }

    //测试接口 修改显示
    static function testInterfaceEdit($args)
    {
        $request = Func_Input::filter(array(
            'id' => 'int',
        ), $args);
        $res = Data_Mysql_Table_Test_Interface::select("*", array('id' => $request['id']));
        if (!empty($res[0])) {
            return self::request('success', $res, '');
        } else {
            return self::request('error', '', '参数错误！');
        }
    }

    // 删除 （更改状态）
    static function testInterfaceDelete($args)
    {
        $request = Func_Input::filter(array(
            'id' => 'int'
        ), $args);
        $res = Data_Mysql_Table_Test_Interface::update(array('id' => $request['id']), array('status' => -1));
        if (!empty($res[0])) {
            return self::request('success', '', '删除成功！');
        } else {
            return self::request('error', '', '删除失败,请重试！');
        }
    }

    /*************接口测试前端使用************************/

    //获取接口的所有的分类
    static function interfaceCategory($args)
    {
//        $res = Data_Mysql_Table_Test_Interface::select('category',array('status'=>0),'GROUP BY category',9999);
        $res = Data_Mysql_Table_Test_Interface::$category;
        return $res;
    }

    //获取某分类下的接口
    static function interfaceName($args)
    {
        $request = Func_Input::filter(array(
            'category' => 'string'
        ), $args);
        $res = Data_Mysql_Table_Test_Interface::select('interface_name', array('status' => 0, 'category' => $request['category']), '', 9999);
        if (!empty($res)) {
            return self::request('success', $res, '');
        } else {
            return self::request('error', '', '暂无数据！');
        }
    }

    //调用Api参数返回数据
    static function InterfaceField($args)
    {
        $request = Func_Input::filter(array(
            'interface_name' => 'string'
        ), $args);
        $res = Data_Mysql_Table_Test_Interface::select('data,des', array('status' => 0, 'interface_name' => $request['interface_name']), '', 9999);
        if (!empty($res)) {
            return self::request('success', $res, '');
        } else {
            return self::request('error', '', '暂无数据！');
        }
    }


}