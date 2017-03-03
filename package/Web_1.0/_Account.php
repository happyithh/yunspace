<?php
/**
 * Created by PhpStorm.
 * User: liushengchun
 * Date: 15/3/13
 * Time: 09:47
 */
@session_start();

class Web_Account extends Base
{

    /**
     * 判断是否登录并处理转向
     */
    static function handleIsLogin($msg = '请先登录!')
    {
        if (!empty($_SESSION['access_url'])) {
            if (strpos(Core::$urls['path'], $_SESSION['access_url']) === false) {
                unset($_SESSION['user'], $_SESSION['access_url']);
                Func_Header::to($msg, Core::$urls['root'] . 'user_center/login?url_back=' . urlencode(Core::$urls['uri']));
            }
        }
        if (empty($_SESSION['user']['id'])) {
            if(Core::$urls['host']=='m.yunspace.com.cn'){
                Func_Header::to($msg, Core::$urls['root'] . 'user_center/');
            }else{
                Func_Header::to($msg, Core::$urls['root'] . 'user_center/login?url_back=' . urlencode(Core::$urls['uri']));
            }
        }
        //如果有正在待审核的实名认证信息, 则查询数据库看看是否有变更
        if (!empty($_SESSION['user']['attr']['new_identity']) && !isset($_SESSION['user']['attr']['new_identity']['rejectReason'])) {
            $r = Data_Mysql_Table_Account::select('id, fullname, attr', array('id' => $_SESSION['user']['id'], 'identity_time>-2'));
            if (!empty($r[0]['id'])) {
                $_SESSION['user']['fullname'] = $r[0]['fullname'];
                $_SESSION['user']['attr'] = json_decode($r[0]['attr'], 1);
            }
        }
        if (!empty($_COOKIE['unid'])) {
            Data_Mysql_Table_Dwz_Record::updataRecord(); //更新通过分享url点击的记录
        }
    }

    static function handleAccountHasAuth($authNameOrId, $accountType = 1)
    {
        if (!self::subAccountHasAuth($authNameOrId, $accountType)) {
            Func_Header::back('您的账号没有该权限!');
        }
    }

    static $subAccountAuthIndex = array(
        1 => array(
            '下单' => 1,
            '签约' => 3,
            '支付' => 4,
            '结算' => 5,
        ),
        21 => array(
            '下单' => 1,
            '审核' => 2,
            '签约' => 3,
            '支付' => 4,
            '结算' => 5,
            '产品管理' => 9,
        ),
    );

    /**
     * 判断子账号权限
     */
    static function subAccountHasAuth($authNameOrId, $accountType = 1)
    {
        if ($accountType != $_SESSION['user']['account_type']) {
//            return false;
        }
        if (empty($_SESSION['user']['sub_account'])) {
            return true;
        }
        if (!is_numeric($authNameOrId)) {
            $authNameOrId = empty(self::$subAccountAuthIndex[$accountType][$authNameOrId]) ? 0 : self::$subAccountAuthIndex[$accountType][$authNameOrId];
        }
        return !empty($_SESSION['user']['sub_account']['auth'][$authNameOrId]);
    }

    static function footPrint($productInfo)
    {
        if (!empty($productInfo['id'])) {
            //更新产品计数器
            Data_Mysql_Table_Product_Info::query('UPDATE {table} SET counter_view = counter_view+1 WHERE id = ?', array($productInfo['id']));
            if (rand(1, 30) == 2) {
                Data_Mysql_Table_Product_Info::exec("UPDATE  {table} SET counter_view_index =  counter_view");
            }
        }
        //历史访问指纹
        @session_start();
        $footPrint = &$_SESSION['footprint'];
        //分类
        if (!empty($productInfo['category_id'])) {
            unset($footPrint['category'][$productInfo['category_id']]);
            $footPrint['category'][$productInfo['category_id']] = 1;
            $footPrint['category'] = array_slice($footPrint['category'], -5, 5, 1);
        }
        //属性1: 基本信息>适合活动类型
        //属性2: 基本信息>城市
        //属性3: 基本信息>所属商圈
        $attrs = array(
            '基本信息>适合活动类型',
            '基本信息>所属商圈',
            '城市',
        );
        foreach ($attrs as $attr) {
            if (!empty($productInfo['attr'][$attr])) {
                $tmp = explode(',', $productInfo['attr'][$attr]);
                foreach ($tmp as $v) {
                    empty($footPrint['attr'][$attr][$v]) and $footPrint['attr'][$attr][$v] = 0;
                    $footPrint['attr'][$attr][$v]++;
                }
                arsort($footPrint['attr'][$attr]);
                $footPrint['attr'][$attr] = array_fill_keys(array_keys(array_slice($footPrint['attr'][$attr], 0, 5, 1)), 2);
            }
        }
    }

    static function getFootPrintConditions()
    {
        if (empty($_SESSION['footprint'])) {
            return array('id < ?' => rand(500, 5000));
        }
        $footPrint = $_SESSION['footprint'];
        $conditions = array();
        if (!empty($footPrint['category'])) {
            $conditions[] = "category_id in (" . implode(',', array_keys($footPrint['category'])) . ")";
        }
        if (!empty($footPrint['attr'])) {
            foreach ($footPrint['attr'] as $k => $v) {
                $conditions['attr_index'] [$k] = implode(',', array_keys($v));
            }
        }
        return $conditions;
    }
}