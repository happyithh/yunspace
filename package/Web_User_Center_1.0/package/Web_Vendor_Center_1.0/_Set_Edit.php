<?php

/**
 * Created by PhpStorm.
 * User: Administrator
 * Date: 15-6-8
 * Time: 下午1:19
 */
class Web_Vendor_Center_Set_Edit
{
    static $vendor = '';

    static function handle()
    {
        //检查是否有修改权限
        Web_Vendor_Center_Product_Edit::handleCheckProductAuth();
        $vendor = Data_Mysql_Table_Vendor_Info::select('id,vendor_name', array(
            'vendor_account_id = ?' => $_SESSION['user']['id']
        ));
        if (empty($vendor[0])) {
            Func_Header::notFound();
        }
        self::$vendor = $vendor[0];
        Tpl_Smarty::assign('vendor', $vendor[0]);
        switch (Core::$urls['action']) {
            case 'set_edit/online':
                self::handleSetOnline();
                break;
            case 'set_edit/delete_recover':
                self::handleSetStatus();
                break;
            case 'set_edit/submit':
                self::handleSetEditSubmit();
                break;
            case 'set_edit/product_auto_complete':
                self::productAutoComplete();
                break;
            case 'set_edit/case':
                self::handleSetEditCase();
                break;
            default:
                self::handleSetEdit();
                break;
        }
    }

    /*
     *编辑套餐
     */
    static function handleSetEdit()
    {
        $request = Func_Input::filter(array(
            'set_id' => 'int',
        ));
        if (empty($_REQUEST['url_to'])) {
            $_REQUEST['url_to'] = Core::$urls['referer'];
        }
        if (!empty($request['set_id'])) {
            $data = Data_Mysql_Table_Product_Set::subTable('_update')->select('*', array('id' => $request['set_id']));
            if (empty($data[0])) {
                $data = Data_Mysql_Table_Product_Set::select('*', array('id' => $request['set_id']));
            }
            $setInfo = array();
            if (!empty($data[0])) {
                $setInfo = $data[0];
                if (!empty($setInfo['attr_index'])) {
                    $setInfo['attr_index'] = json_decode($setInfo['attr_index'], 1);
                }
                if (!empty($setInfo['media'])) {
                    $setInfo['media'] = json_decode($setInfo['media'], 1);
                }
                if (!empty($setInfo['detail_data'])) {
                    $setInfo['detail_data'] = json_decode($setInfo['detail_data'], 1);
                }
                if (!empty($setInfo['detail'])) {
                    $setInfo['detail'] = json_decode($setInfo['detail'], 1);
                }
            }
            Tpl_Smarty::assign('_data', $setInfo);
        }
        Tpl_Smarty::assign("category_name", Data_Mysql_Table_Product_Set::$category_name);
        //获取活动类型和行业标签
        Tpl_Smarty::assign('_attrs', Data_Config_Vendor_Attr::get('attr'));
        Tpl_Smarty::display('set_edit.tpl');
    }

    /*
       * 获取案例
       */
    static function handleSetEditCase()
    {
        $request = Func_Input::filter(array(
            'set_id' => 'int',
        ));
        if (!empty($request['set_id'])) {
            $data = Data_Mysql_Table_Product_Set::subTable('_update')->select('*', array('id' => $request['set_id']));
            if (empty($data[0])) {
                $data = Data_Mysql_Table_Product_Set::select('*', array('id' => $request['set_id']));
            }
        }
        Tpl_Smarty::assign('_data', $data[0]);
        $eventInfo = self::getCaseBySetId($request['set_id']);
        Tpl_Smarty::assign('_event', $eventInfo);
        Tpl_Smarty::display('set_case.tpl');
    }

    /*
     *套餐表单提交
     */
    static function handleSetEditSubmit()
    {
        $request = Func_Input::filter(array(
            'set_id' => 'int',
            'url_to' => 'string',
            'schedule_product_id' => 'int',
            'data' => 'array',
        ));

        $request['data']['hours'] = !empty($request['data']['hours']) ? intval($request['data']['hours']) : 0;
        $request['data']['people'] = !empty($request['data']['people']) ? intval($request['data']['people']) : 0;
        $request['data']['detail']['计价下限'] = !empty($request['data']['detail']['计价下限']) ? intval($request['data']['detail']['计价下限']) : 1;
        $request['data']['detail']['计价上限'] = !empty($request['data']['detail']['计价上限']) ? intval($request['data']['detail']['计价上限']) : 1;
        if (empty($request['data']['version'])) {
            $request['data']['version'] = '品质版';
        }
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
            Func_Header::back('套餐名称不能为空！');
        }
        if (empty($request['data']['marketing_title'])) {
//            Func_Header::back('营销标题不能为空！');
        }
        if (empty($request['data']['category_id'])) {
            Func_Header::back('类别不能为空！');
        }
        if (empty($request['data']['attr_index']['城市'])) {
            Func_Header::back('城市不能为空！');
        }
        if (empty($request['data']['des'])) {
            Func_Header::back('套餐简介不能为空！');
        }
        if (empty($request['data']['hours'])) {
            Func_Header::back('服务时长不能为空！');
        }
        if ($request['data']['detail']['套餐价'] == '') {
            Func_Header::back('套餐价不能为空！');
        }
        if (!(is_numeric($request['data']['detail']['套餐价']))) {
            Func_Header::back('套餐价填写必须为数字！！');
        }
        if ($request['data']['detail']['套餐价'] == 0) {
            Func_Header::back('套餐价不能为0！');
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
            Func_Header::back('请正确填写套餐的有效期！');
        }
        if (empty($request['data']['attr_index']['人数'])) {
            $request['data']['attr_index']['人数'] = '不限';
        }

        $request['data']['schedule_product_id'] = intval($request['schedule_product_id']);
        $request['data']['set_price'] = intval($request['data']['detail']['套餐价']);
        $request['data']['status'] = 2;
        if (!empty($request['set_id'])) {
            $rs = Data_Mysql_Table_Product_Set::subTable('_update')->update(array('id' => $request['set_id']), $request['data']);
        } else {
            $request['data']['vendor_id'] = self::$vendor['id'];
            $rs = Data_Mysql_Table_Product_Set::subTable('_update')->insert($request['data']);
        }
        if ($rs[0] > 0) {
            //创建操作日志
            $id = empty($request['set_id']) ? $rs[0] : $request['set_id'];
            //更改所属供应商的状态
            Data_Mysql_Table_Vendor_Info::subTable('_update')->update(array('id = ? and status != ?' => array(self::$vendor['id'], 2)), array('status' => 4));
            Func_Header::to(' 正在审核中，您现在可以继续添加案例，showtime的机会哦！', Core::$urls['root'] . Core::$urls['package'] . Core::$urls['route'] . 'product/set');
        }
        Func_Header::back('操作错误！！');
    }

    /*
     *获取套餐相关案例
     */
    static function getCaseBySetId($setId)
    {
        $data = array();
        $data = OA_My_Customer_Handle_Product_Set::getCaseById($setId);
        return $data;
    }

    /*
     *改变套餐的状态
     */
    static function handleSetOnline()
    {
        Core::output('');
        if (isset($_REQUEST['set_online'])) {
            $request = Func_Input::filter(array(
                'set_online' => 'int',
                'set_id' => 'int',
            ));
            if (!$request['set_id']) {
                Func_Output::json('error', '', '参数错误');
            }
            //更新在线状态
            $r = Data_Mysql_Table_Product_Set::query("UPDATE {table} SET status = ? WHERE id = ?", array(
                $request['set_online'] ? 1 : 0,
                $request['set_id']
            ), 1);
            Core::log('online_offline_set2', $request['set_id'], $request['set_online'], $_SESSION['user']['id']);
            if (empty($r[0])) {
                Func_Output::json('error', '', '操作失败,可能是网络异常,请稍候再试!');
            } else {
                Func_Output::json('success', '', '更新套餐状态成功！');
            }
        }
    }

    /*
     *产品信息自动完成
     */
    static function productAutoComplete()
    {
        Core::output('');
        $request = Func_Input::filter(array(
            'product_id' => 'int',
            'q' => 'string',
            'vendor_id' => 'int',
        ));
        if (!$request['product_id'] && !$request['q']) {
            die('参数错误!');
        }
        $conditions['{prefix}vendor_info.id =?'] = $request['vendor_id'];
        $conditions['{table}.status >= ?'] = 0;
        if ($request['product_id']) {
            $conditions['{table}.id = ?'] = $request['product_id'];
            $rs = Data_Mysql_Table_Product_Info::select('{table}.id, CONCAT( "[", {table}.id, "] ", product_name) as name', $conditions, '', 1, "{table} LEFT JOIN {prefix}vendor_info ON {table}.vendor_id ={prefix}vendor_info.id");
        } else {
            $conditions['({table}.id like ? OR {table}.product_name like ?)'] = array($request['q'] . '%', $request['q'] . '%');
            $rs = Data_Mysql_Table_Product_Info::select('{table}.id, CONCAT( "[", {table}.id, "] ", product_name) as name', $conditions, '', 5, "{table} LEFT JOIN {prefix}vendor_info ON {table}.vendor_id ={prefix}vendor_info.id");
        }
        $ajax_arr = array(
            "total_count" => 2,
            "incomplete_results" => false,
            "items" => array(
                array(
                    'id' => 0,
                    'name' => '',
                    'full_name' => ''
                ),
            )
        );
        foreach ($rs as $key => $val) {
            $ajax_arr['items'][$key]['id'] = $val['id'];
            $ajax_arr['items'][$key]['name'] = '';
            $ajax_arr['items'][$key]['full_name'] = $val['name'];
        }
        echo json_encode($ajax_arr);
        die();
    }

    /*
     *删除套餐
     */
    static function handleSetStatus()
    {
        Core::output('');
        if (isset($_REQUEST['set_id'])) {
            $request = Func_Input::filter(array(
                'set_id' => 'int',
                'set_status' => 'int',
            ));
            if (!$request['set_id']) {
                Func_Output::json('error', '', '参数错误！！');
            }
            $rs = Data_Mysql_Table_Product_Set::handleDelete($request['set_id'], $request['set_status'] ? $request['set_status'] : -1);
            if ($rs) {
                Func_Output::json('success', '', '套餐删除成功！！');
            } else {
                Func_Output::json('error', '', '套餐删除失败！！');
            }
        }
    }
}