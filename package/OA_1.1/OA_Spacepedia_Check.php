<?php

/**
 * Created by PhpStorm.
 * User: Administrator
 * Date: 15-10-20
 * Time: 下午3:54
 */
@session_start();
class OA_Spacepedia_Check
{
    static function handle()
    {
        $_REQUEST['action'] = empty($_REQUEST['action']) ? 'check_list' : $_REQUEST['action'];
        switch ($_REQUEST['action']) {
            case "check_list":
                self::getSpacepediaCheckList();
                break;
            case "check_detail":
                self::getHistoryCheckInfo();
                break;
            case "pass":
                self::handleSpacepediaPass();
                break;
            case "refuse":
                self::handleSpacepediaRefuse();
                break;
            default:
                Func_Header::notFound();
                break;
        }

    }

    /*
     *获取所有待审核的场地百科列表
     */
    static function getSpacepediaCheckList()
    {

        if (!empty($_REQUEST['search'])) {
            $search = Func_Input::filter(array(
                'title' => 'string',
                'vendor_name' => 'string',
                'city' => 'string',
                'category_id' => 'int',
                'end_time' => 'string',
                'start_time' => 'string',
                'create_time' => 'string',
            ), $_REQUEST['search']);
            //名称或ID筛选
            if (!empty($search['title'])) {
                if (is_numeric($search['title'])) {
                    $tables['id'] = $search['title'];
                } else {
                    $tables['space_name'] = $search['title'];
                }
            }

            //创建时间筛选
            if (!empty($search['create_time'])) {
                $condition[] = 'create_time >=' . strtotime($search['create_time']);
            }

            if (!empty($tables)) {
                $order = "ORDER BY {table}.create_time DESC";
                $rs = Data_Mysql_Table_Spacepedia::select('*', $tables, $order);
                if (!empty($rs)) {
                    $condition['object_id'] = $rs[0]['id'];
                }

            }
        }
        $tmp_date = date("Ym");
        //切割出年份
        $tmp_year = substr($tmp_date, 0, 4);
        //切割出月份
        $tmp_mon = substr($tmp_date, 4, 2);
        $tmp_forwardmonth[0] = $tmp_date;
        $tmp_forwardmonth[1] = date("Ym", mktime(0, 0, 0, $tmp_mon - 1, 1, $tmp_year));
        $tmp_forwardmonth[2] = date("Ym", mktime(0, 0, 0, $tmp_mon - 2, 1, $tmp_year));
        Tpl_Smarty::assign("month", $tmp_forwardmonth);

        $month = empty($_REQUEST['monthdate']) ? $tmp_date : $_REQUEST['monthdate'];
        $handle_type = empty($_REQUEST['handle_type']) ? "waiting" : $_REQUEST['handle_type'];
        switch ($handle_type) {
            case "waiting":
                $condition['{table}.status = ?'] = 0;
                break;
            case "history":
                $condition['{table}.status != ?'] = 0;
                break;
        }

        $data = Api_Spacepedia_List_And_Info::getHistory($condition, $month);

        if (!empty($search)) {
            $sea_url = '&search[title]=' . $search['title'] . '&search[create_time]=' . $search['create_time'];
            $data['other']['urls'] = $sea_url;
        }
        $data['other']['monthdate'] = $month;
        $data['other']['handle_type'] = $handle_type;

        //获取场地百科分类
        $category = Data_Mysql_Table_Spacepedia::$category_name;
        $categoryInfo = Data_Mysql_Table_Spacepedia::getCategoryInfo($category);
        Tpl_Smarty::assign('category_info', $categoryInfo);

        Tpl_Smarty::assign("_data", $data);
//        Tpl_Smarty::assign("_categoryList", Data_Mysql_Table_Product_Category::getTreeCache());
//        Tpl_Smarty::assign("_categoryInfo", Data_Mysql_Table_Product_Category::getInfoCache());
        Tpl_Smarty::display("OA_Static", "spacepedia_check/spacepedia_check_list.tpl");
    }

    /*
     *获取待审核百科的详细信息
     */
    static function getHistoryCheckInfo()
    {
        $request = Func_Input::filter(array(
            "history_id" => "int",
            'month' => 'string',
        ));
        if (empty($request['history_id']) || empty($request['month'])) {
            Func_Header::back('参数缺失！！');
        }
        $history = Api_Spacepedia_List_And_Info::getHistoryByHistoryId($request['history_id'], $request['month']);
        if (empty($history)) {
            Func_Header::back('数据不存在！！');
        }
        $vendor_info = Data_Config_Vendor_Attr::all();
        $contacts_city = $vendor_info['attr']['城市'];
        Tpl_Smarty::assign('_contacts_city', $contacts_city);
        if (!empty($spacepedia[0]['category_id'])) {
            Tpl_Smarty::assign('_tags_info', Data_Mysql_Table_Product_Category::getTagsInfo($spacepedia[0]['category_id']));
        }
        Tpl_Smarty::assign('_data', $history['data_backup']);
        Tpl_Smarty::assign('month', $_REQUEST['month']);

        //获取场地百科分类
        $category = Data_Mysql_Table_Spacepedia::$category_name;
        $categoryInfo = Data_Mysql_Table_Spacepedia::getCategoryInfo($category);
        Tpl_Smarty::assign('category_info', $categoryInfo);

//        Tpl_Smarty::assign("_categoryInfo", Data_Mysql_Table_Product_Category::getInfoCache());
        Tpl_Smarty::display("OA_Static", "spacepedia_check/spacepedia_check_detail.tpl");
    }


    /*
     *获取待审核百科的详细信息 (暂无用)
     */
    static function getCheckInfo()
    {
        if (empty($_REQUEST['space_id'])) {
            Func_Header::back('参数缺失！！');
        }
        $spacepedia = Api_Spacepedia_List_And_Info::getSpacepediaInfoById($_REQUEST['space_id']);
        if (empty($spacepedia)) {
            Func_Header::back('数据不存在！！');
        }
        $vendor_info = Data_Config_Vendor_Attr::all();
        $contacts_city = $vendor_info['attr']['城市'];
        Tpl_Smarty::assign('_contacts_city', $contacts_city);
        if (!empty($spacepedia[0]['category_id'])) {
            Tpl_Smarty::assign('_tags_info', Data_Mysql_Table_Product_Category::getTagsInfo($spacepedia[0]['category_id']));
        }
        Tpl_Smarty::assign('_data', $spacepedia[0]);
        Tpl_Smarty::assign('month', $_REQUEST['month']);
        Tpl_Smarty::assign("_categoryInfo", Data_Mysql_Table_Product_Category::getInfoCache());
        Tpl_Smarty::display("OA_Static", "spacepedia_check/spacepedia_check_detail.tpl");
    }


    /*
     *场地百科通过审核
     */
    static function handleSpacepediaPass()
    {
        $request = Func_Input::filter(array(
            'history_id' => 'id',
            'month' => 'string',
            'status' => 'int',
        ));
        if (empty($request['history_id']) || empty($request['month'])) {
            Func_Header::back("参数错误！！");
        }
        $request['status'] = empty($request['status']) ? 0 : $request['status'];
        $return = Api_Spacepedia_Submit::spacepediaInfoAudit($request);
//        q($return);
        if ($return[0]>0) {
            //创建操作日志
            if(!empty($request['status']) && $request['status']==1) {
                $message = '百科审核通过并上线';
            } else {
                $message = '百科审核通过';
            }
            $account = Api_Administrator_GetBaseAccountInfo::getBastAccountInfo(array('admin_id' => Api_Session::admin_id()));
            $account_id = !empty($account['account_id']) ? $account['account_id'] : $_SESSION['administrator']['id'];
            Data_Mysql_Table_Account_Log::insertAccountLog($account_id,$_SESSION['administrator']['id'],$message,'百科审核',$return[1]);

            $tab="{table} as t1 LEFT JOIN {prefix}space_item as t2 on t1.id=t2.space_id";
            $cons['t1.id =?'] =$return[1];
           // Data_Mysql_Table_Spacepedia::debug(1);
            $space = Data_Mysql_Table_Spacepedia::select('t1.space_name,t1.create_time,t2.phone',$cons,'',1,$tab);
            if(!empty($space[0])){
                $openid = Data_Mysql_Table_Account_Wechat_Manager::handleGetAccountInfo(array('phone' => $space[0]['phone']));
                if (!empty($openid['openid'])) {
                    $data = array(
                        'space_name' => $space[0]['space_name'],
                        'create_time' => $space[0]['create_time'],
                        'openid' =>$openid['openid'],
                    );
                    $s =  Api_Common_Send_Site_Text::SendWinInform($data);
                }
            }
            Func_Header::to(' 场地百科信息审核成功！', "?");
        } else {
            Func_Header::back("场地百科数据审核失败！！");
        }
    }

    /*
     *场地百科未通过审核
     */
    static function handleSpacepediaRefuse()
    {
        $request = Func_Input::filter(array(
            'history_id' => 'id',
            'reason' => 'string',
            'month' => 'string',
        ));
        if (empty($request['history_id']) || empty($request['month'])) {
            Func_Header::back("参数错误！！");
        }
        if (empty($request['reason'])) {
            Func_Header::back('请输入拒绝理由');
        }
        $rs = Api_Spacepedia_Submit::spacepediaInfoRefuse($request);
        if ($rs[0]>0) {
            $tab="{table} as t1 LEFT JOIN {prefix}space_item as t2 on t1.id=t2.space_id";
            $cons['t1.id =?'] =$rs[1];
            $space = Data_Mysql_Table_Spacepedia::select('t1.space_name,t1.refuse_reason,t2.phone',$cons,'',1,$tab);

            if(!empty($space[0])){
                $openid = Data_Mysql_Table_Account_Wechat_Manager::handleGetAccountInfo(array('phone' => $space[0]['phone']));

            if (!empty($openid['openid'])) {
                $data = array(
                    'space_name' => $space[0]['space_name'],
                    'refuse_reason' => $space[0]['refuse_reason'],
                    'openid' => $openid['openid'],
                );
               $s = Api_Common_Send_Site_Text::SendWinReason($data);
            }
            }
            //创建操作日志
            $account = Api_Administrator_GetBaseAccountInfo::getBastAccountInfo(array('admin_id' => Api_Session::admin_id()));
            $account_id = !empty($account['account_id']) ? $account['account_id'] : $_SESSION['administrator']['id'];
            Data_Mysql_Table_Account_Log::insertAccountLog($account_id,$_SESSION['administrator']['id'],'百科审核拒绝','百科审核',$rs[1]);
            Func_Header::to(' 该场地百科未通过审核！', '?');
        } else {
            Func_Header::back('场地百科未通过失败');
        }
    }
}