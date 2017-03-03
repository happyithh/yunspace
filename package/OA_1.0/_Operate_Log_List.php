<?php

/**
 * Created by PhpStorm.
 * User: Administrator
 * Date: 15-6-11
 * Time: 下午4:48
 */
class OA_Operate_Log_List
{
    static function handle()
    {

        $conditions = array();
        //定义操作内容
        $operate_cont = array(
            1 => '套餐通过审核',
            2 => '套餐未通过审核',
            3 => '案例通过审核',
            4 => '案例未通过审核',
            5 => '产品通过审核',
            6 => '产品未通过审核',
            7 => '供应商审核通过',
            8 => '供应商未通过审核',
            9 => '供应商信息修改',
            10 => '套餐信息修改',
            11 => '案例信息修改',
            12 => '产品信息修改',
            13 => '提交身份认证信息',
            14 => '账户变更',
            15 => '账户审核通过',
            16 => '账户审核未通过',
            17 => '账户认证被拒绝',
            18 => '账户认证通过',
            20 => '广告位创建',
            21 => '广告位修改',
            22 => '广告创建',
            23 => '广告修改',
            24 => '表单创建',
            25 => '表单修改',
            26 => '用户表单信息审核',
            19 => '删除',

        );
        Tpl_Smarty::assign('operate_cont', $operate_cont);
        //定义操作类型
        $operate_sort = array(
            1 => '供应商审核',
            2 => '审核套餐',
            3 => '审核案例',
            4 => '审核产品',
            5 => '供应商信息修改',
            6 => '修改套餐',
            7 => '修改产品信息',
            8 => '修改案例',
            9 => '账户审核',
            10 => '删除',
            11 => '身份认证',
            12 => '用户认证',
            13 => '账户变更绑定的供应商',
            14 => '广告位管理',
            15 => '表单管理',
            16 => '百科审核',
            17 => '修改百科',
            18 => '新建百科',
        );
        Tpl_Smarty::assign('operate_sort', $operate_sort);
        //筛选条件
        if (!empty($_REQUEST['search'])) {
            $search = Func_Input::filter(array(
                'fullname' => 'string',
                'username' => 'string',
                'operate_cont' => 'int',
                'operate_sort' => 'int',
                'duixnag_id' => 'int',
//                'end_time' => 'string',
                'start_time' => 'string',
            ), $_REQUEST['search']);
            //账户名称或ID筛选
            if (!empty($search['fullname'])) {
                if (is_numeric($_REQUEST['search']['fullname'])) {
                    $conditions['{prefix}account.id = ? '] = $search['fullname'];
                } else {
                    //$conditions['{prefix}account.fullname = ? '] = $search['fullname'];
                    $conditions[] = "{prefix}account.fullname like '%" . $search['fullname'] . "%'";
                }
            }
            //操作人筛选
            if (!empty($search['username'])) {
                $conditions['{prefix}administrator.username = ? '] = $search['username'];
            }
            //操作内容筛选
            if (!empty($search['operate_cont'])) {
                $operate_message = $search['operate_cont'];
                switch ($operate_message) {
                    case 1:
                        $conditions[] = "operate_message='套餐通过审核'";
                        break;
                    case 2:
                        $conditions[] = "operate_message='套餐未通过审核'";
                        break;
                    case 3:
                        $conditions[] = "operate_message='案例通过审核'";
                        break;
                    case 4:
                        $conditions[] = "operate_message='案例未通过审核'";
                        break;
                    case 5:
                        $conditions[] = "operate_message='产品通过审核'";
                        break;
                    case 6:
                        $conditions[] = "operate_message='产品未通过审核'";
                        break;
                    case 7:
                        $conditions[] = "operate_message='供应商审核通过'";
                        break;
                    case 8:
                        $conditions[] = "operate_message='供应商未通过审核'";
                        break;
                    case 9:
                        $conditions[] = "operate_message='供应商信息修改'";
                        break;
                    case 10:
                        $conditions[] = "operate_message='套餐信息修改'";
                        break;
                    case 11:
                        $conditions[] = "operate_message='案例信息修改'";
                        break;
                    case 12:
                        $conditions[] = "operate_message='产品信息修改'";
                        break;
                    case 13:
                        $conditions[] = "operate_message='提交身份认证信息'";
                        break;
                    case 14:
                        $conditions[] = "operate_message='账户变更'";
                        break;
                    case 15:
                        $conditions[] = "operate_message='账户审核通过'";
                        break;
                    case 16:
                        $conditions[] = "operate_message='账户审核未通过'";
                        break;
                    case 17:
                        $conditions[] = "operate_message='账户认证被拒绝'";
                        break;
                    case 18:
                        $conditions[] = "operate_message='账户认证通过'";
                        break;
                    case 19:
                        $conditions[] = "operate_message like '%删除%'";
                        break;
                    case 20:
                        $conditions[] = "operate_message like '广告位创建--%'";
                        break;
                    case 21:
                        $conditions[] = "operate_message like '广告位修改--%'";
                        break;
                    case 22:
                        $conditions[] = "operate_message like '广告创建--%'";
                        break;
                    case 23:
                        $conditions[] = "operate_message like '广告修改--%'";
                        break;
                    case 24:
                        $conditions[] = "operate_message like '表单创建--%'";
                        break;
                    case 25:
                        $conditions[] = "operate_message like '表单修改--%'";
                        break;
                    case 26:
                        $conditions[] = "operate_message = '用户表单信息审核'";
                        break;
                    default :
                        '';
                        break;
                }


            }
            //操作类型筛选
            if (!empty($search['operate_sort'])) {
                $operate_type = $search['operate_sort'];
                switch ($operate_type) {
                    case 1:
                        $conditions[] = "operate_type='供应商审核'";
                        break;
                    case 2:
                        $conditions[] = "operate_type='审核套餐'";
                        break;
                    case 3:
                        $conditions[] = "operate_type='审核案例'";
                        break;
                    case 4:
                        $conditions[] = "operate_type='审核产品'";
                        break;
                    case 5:
                        $conditions[] = "operate_type='供应商信息修改'";
                        break;
                    case 6:
                        $conditions[] = "operate_type='修改套餐'";
                        break;
                    case 7:
                        $conditions[] = "operate_type='修改产品信息'";
                        break;
                    case 8:
                        $conditions[] = "operate_type='修改案例'";
                        break;
                    case 9:
                        $conditions[] = "operate_type='账户审核'";
                        break;
                    case 10:
                        $conditions[] = "operate_type like '%删除%'";
                        break;
                    case 11:
                        $conditions[] = "operate_type='身份认证'";
                        break;
                    case 12:
                        $conditions[] = "operate_type='用户认证'";
                        break;
                    case 13:
                        $conditions[] = "operate_type='账户变更绑定的供应商'";
                        break;
                    case 14:
                        $conditions[] = "operate_type='广告位管理'";
                        break;
                    case 15:
                        $conditions[] = "operate_type='表单管理'";
                        break;
                    case 16:
                        $conditions[] = "operate_type='百科审核'";
                        break;
                    case 17:
                        $conditions[] = "operate_type='修改百科'";
                        break;
                    case 18:
                        $conditions[] = "operate_type='新建百科'";
                        break;
                    default :
                        '';
                        break;
                }
            }
            //操作对象ID筛选
            if (isset($search['duixnag_id'])) {
                if (is_numeric($_REQUEST['search']['duixnag_id'])) {
                    $conditions['object_id'] = $search['duixnag_id'];
                }
            }
        }
        if (!empty($_REQUEST['search']) && !empty($search['start_time'])) {
            $month = date('Ym', strtotime($search['start_time']));
        } else {
            $month = date('Ym', time());
        }
        $order = 'ORDER BY {table}.create_time desc';
        $data = Data_Mysql_Table_Account_Log::subTable('_' . $month)->page(0, 10,
            '{table}.operate_message,{table}.operate_type,{table}.object_id,{table}.account_id,{table}.create_time,{prefix}account.fullname,{prefix}administrator.username',
            $conditions, $order,
            ' {table} LEFT JOIN {prefix}administrator ON {table}.admin_id={prefix}administrator.id LEFT JOIN {prefix}account ON {table}.account_id={prefix}account.id');
        Tpl_Smarty::assign('data', $data);
       Tpl_Smarty::display('OA_Static::elements/operate_log_list.tpl');
    }
}