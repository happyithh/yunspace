<?php

/**
 * Created by PhpStorm.
 * User: Administrator
 * Date: 2015/4/29
 * Time: 18:38
 */
class OA_Event_Brand extends Base
{
    static function handle($accountType = 1)
    {
        $_REQUEST['action'] = empty($_REQUEST['action']) ? 'normal' : $_REQUEST['action'];
        switch ($_REQUEST['action']) {
            case 'normal':
                self::handleNormal();
                break;
            case 'edit':
				self::handleEdit();
				break;
            case 'add':
                self::handleAdd();
                break;
            case 'event_add':
                self::handleEventAdd();
                break;
//			case 'listUnaccepted':
//				self::handleUnaccepted();
//				break;
//			case 'listStop':
//				self::handleStop();
//				break;
//			case 'listDelete':
//				self::handleDelete();
//				break;
			case 'update':
				self::updateEvent();
				break;
//			case 'accept':
//				self::acceptStartEvent();
//				break;
			case 'del':
				self::deleteEvent();
				break;
//			case 'delete_img':
//				self::deleteImg();
//				break;
        }

    }


    //正常活动
    static function handleNormal()
    {
        if (isset($_REQUEST['search']['title'])) {
            $_REQUEST['search']['title'] = trim($_REQUEST['search']['title']);
            if (!empty($_REQUEST['search']['title'])) {
                $conditions = self::handleSearch();
                $sea_url = '&search[title]=' . $_REQUEST['search']['title'];
                Tpl_Smarty::assign('urls', $sea_url);
            }
        }

        $conditions["{table}.status >?"] = '-1';
        $data = Data_Mysql_Table_Event_Brand::page(0, 10, 'id,event_name,event_time,update_time,des,status', $conditions, 'ORDER BY id DESC');

        Tpl_Smarty::assign('_data', $data);
        Tpl_Smarty::assign('page_nav', 'normal');
        Tpl_Smarty::display("OA", "event_brand_list.tpl");
    }

    //添加
    static function handleAdd()
    {
        Tpl_Smarty::display("OA", "event_brand_edit.tpl");
    }

    static function handleEventAdd()
    {
        $request = Func_Input::filter(array(
            'event_name' => 'string',
            // 'event_time' => 'string',
            'des' => 'string',
        ));

        $files = Func_Input::filter(array(
            '公司LOGO' => 'array',
        ), $_FILES);

        if (!empty($files['公司LOGO']['name'])) {
            $logo = Func_Upload::image('公司LOGO');
            if (!empty($logo)) {
                $request['data']['logo'] = $logo;
            }
        }
        if(empty($request['event_name'])) {
            Func_Header::back('活动品牌不能为空！');
        } else {
            $request['data']['event_name'] = $request['event_name'];
        }
        if(!empty($request['des'])){
            $request['data']['des'] = $request['des'];
        }

        if (!empty($request['data']['event_name']) || !empty($request['data']['des'])) {
            $request['data']['create_time'] = time();
            $request['data']['status'] = 1;
            $r = Data_Mysql_Table_Event_Brand::insert($request['data']);
            //创建操作日志
            // Data_Mysql_Table_Account_Log::insertAccountLog($request['id'],$_SESSION['administrator']['id'],'活动品牌','活动品牌',$r[0]);
        }

        Func_Header::to('提交成功，正在审核！！', Core::$urls['path']);
        // Func_Header::to(' 提交成功，正在审核！！', Core::$urls['path'] . '?action=detail&tab=' . $_REQUEST['tab'] . '&id=' . $_REQUEST['id'] . '&vendor_id=' . $_REQUEST['vendor_id']);
    }

    //编辑
    static function handleEdit()
    {
        $request = Func_Input::filter(array(
            'action' => 'string',
            'ids' => 'array'
        ));
        if (!$request['action']) {
            die("参数错误！！");
        }
        if (!$request['ids']) {
            die("参数错误！！");
        }
        $conditions = array(
            'id' => $request['ids'][0],
        );

        $data = Data_Mysql_Table_Event_Brand::select('id,event_name,event_time,des,logo', $conditions);

        Tpl_Smarty::assign('_data', $data);
        Tpl_Smarty::display("OA", "event_brand_edit.tpl");
    }

    //更新活动
    static function updateEvent()
    {
        $request = Func_Input::filter(array(
            'id' => 'int',
            'event_name' => 'string',
            'des' => 'string',
        ));

        $files = Func_Input::filter(array(
            '公司LOGO' => 'array',
        ), $_FILES);

        if (!empty($files['公司LOGO']['name'])) {
            $logo = Func_Upload::image('公司LOGO');
            if (!empty($logo)) {
                $request['logo'] = $logo;
            }
        }

        if (!$request['event_name']) {
            die('必须填写活动名称！！');
        }
        $conditions = array(
            'id' => (int)$request['id'],
        );
        // $request['media'] = $request['data']['media'];
        // unset($request['data']);

        // $request['des'] = $_REQUEST['des'];

        // $arr = explode(' ', $request['event_time']);
        // $date = explode('-', $arr[0]);
        // $str_time = mktime($arr[1], 0, 0, $date[1], $date[2], $date[0]);
        // $request['event_time'] = $str_time;
        $request['update_time'] = time();

        $update = Data_Mysql_Table_Event_Brand::update($conditions, $request);
        if ($update) {
            Func_Header::to('活动信息已更新！！', Core::$urls['path']);
        }
    }

    //删除活动
    static function deleteEvent()
    {
        $request = Func_Input::filter(array(
            'action' => 'string',
            'ids' => 'array'
        ));
        if (!$request['action']) {
            die("参数错误！！");
        }
        if (!$request['ids']) {
            die("参数错误！！");
        }
        $conditions = array(
            'id' => $request['ids'][0]
        );
        $data = array(
            'status' => 99
        );

        $update = Data_Mysql_Table_Event_Brand::update($conditions, $data);
        if ($update) {
            Func_Header::back('删除成功！！');
        }
    }

    static function handleSearch()
    {
        $_REQUEST['title'] = $_REQUEST['search']['title'];
        // $request = Func_Input::filter(array(
        //     'title' => 'string',
        // ));
        $search = Func_Input::filter(array(
            'title' => 'string',
            // 'admin_id' => 'int',
            'start_time' => 'string',
            'end_time' => 'string',
            // 'status' => 'int',
            // 'city' => 'string',
            // 'category_id' => 'int',
            // 'create_by_quick' => 'int',
        ), $_REQUEST['search']);

        if (!$search['title']) {
            Func_Header::back('参数错误！');
        }
        $conditions = array(
            "id=? or event_name=?" => array($search['title'], $search['title'])
        );

        if (!empty($search['start_time']) && !empty($search['end_time'])) {
            if (strtotime($search['start_time']) > strtotime($search['end_time'])) {
                Func_Header::back('请正确选择时间范围！！');
            } else {
               $conditions['{table}.create_time between ? and ?'] = array(strtotime($search['start_time']), strtotime($search['end_time']));
            }
        } elseif (!empty($search['start_time']) && empty($search['end_time'])) {
            $conditions['{table}.create_time > ?'] = strtotime($search['start_time']);
        } elseif (empty($search['start_time']) && !empty($search['end_time'])) {
            $conditions['{table}.create_time < ?'] = strtotime($search['end_time']);
        }

        return $conditions;
    }


}