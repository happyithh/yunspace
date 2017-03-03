<?php

/**
 * Created by PhpStorm.
 * User: zzc
 * Date: 2015/12/8
 * Time: 20:56
 * 报价统计
 */
class Api_Demand_Offer_Count extends Api
{


    /**
     * @param $args
     * @return array
     *
     */
    static function  countByConditions($args)
    {
        $request = Func_Input::filter(array(
            'conditions' => 'array',
            'start_time' => 'int',
            'end_time' => 'int',
        ), $args);

        $demand_ids = array();      //需求ID
        $admin_ids = array();       //负责人ID
        $close = 0;                    //关闭数量
        $close_ids = array();
        $dataYM = array();          //
        $customer_view_sum = 0;     //客户浏览量
        $vendor_view_sum = 0;     //商家浏览量
        foreach ($B as $k => $val) {
            if ($val['status'] < 0) {
                $close++;
                $close_ids[] = $val['demand_id'];
            }

            if ($val['view_count_c']) {
                $customer_view_sum = $customer_view_sum + intval($val['view_count_c']);
            }

            $demand_ids[] = $val['demand_id'];
            $admin_ids[] = $val['admin_id'];
            $dataYM[] = date("Ym", $val['create_time']);
        }

        /**需求订单量**/
        $data['offer_sum'] = count($B);

        /**客户浏览量***/
        $data['customer_view_sum'] = $customer_view_sum;


        /**订单关闭量**/
        $data['close_sum'] = $close;

        /**拓展量**/

        //拓展场地数据
        $administratorAccount = Api_Administrator_GetBaseAccountInfo::getBastAccountInfo(array('admin_id' => $_SESSION['administrator']['id']));
        if (!empty($administratorAccount['account_id'])) {
            $account_id = $administratorAccount['account_id'];
        }
        $expand_data = Data_Mysql_Table_Account_Log::selectAll(array(
            'dateYM' => $dataYM,
            'operate_message' => '拓展场地数据',
            'admin_id' => $_SESSION['administrator']['id'],
            'account_id' => $account_id,
            'start_time' => $request['start_time'],
            'end_time' => $request['end_time'],
        ));
        $data['expand_sum'] = @count($expand_data);

        foreach ($dataYM as $k => $val) {
            $dataYM[$k] = 'demand_match_result_' . $val;
        }

        $recommend_sum = 0;

        $change_phone_sum = 0;

        $union = Data_Mysql_Table_Demand_Match_Result::HandleSubSql(implode(',', $dataYM), '*');
        $sql = 'SELECT * FROM ( ' . $union . ' )  t  WHERE demand_id IN (' . implode(',', $demand_ids) . ') ';
        $match_data = Data_Mysql_Table_Demand_Match_Result::query($sql, '', 1);
        foreach ($match_data as $k => $val) {

            if ($val['notice_time'] > 1) {
                $recommend_sum = ($recommend_sum + 1);
            }
            if ($val['hits']) {
                $vendor_view_sum = ($vendor_view_sum + intval($val['hits']));
            }
            if ($val['change_phone_time'] > 0) {
                $change_phone_sum = ($change_phone_sum + 1);
            }
        }
        /**商家浏览量**/
        $data['vendor_view_sum'] = $vendor_view_sum;
        /**推荐量**/
        $data['recommend_sum'] = $recommend_sum;
        /***电话交换量**/
        $data['change_phone_sum'] = $change_phone_sum;
        return array();
    }


    /**
     * @昨日关键指数
     * 1.客户浏览量为0
     * 2.客户浏览量大于3
     * return Percent
     */
    static function  yesterdayIndex($args)
    {
        //上个月的数据
        $Data = self::demandOfferByCondition(array('conditions' => array('create_time >?' => strtotime('-1 month'))));
        //昨天
        $view0DayData = array();
        $view0WeekData = array();
        $view0MonthData = array();
        $view3DayData = array();
        $view3WeekData = array();
        $view3MonthData = array();
        foreach ($Data as $val) {
            if ($val['view_count_c'] == 0) {
                if ($val['create_time'] > strtotime('-1 day')) {
                    $view0DayData[] = $val;
                }
                if ($val['create_time'] > strtotime('-1 week')) {
                    $view0WeekData[] = $val;
                }
                if ($val['create_time'] > strtotime('-1 month')) {
                    $view0MonthData[] = $val;
                }
            }
            if ($val['view_count_c'] >= 3) {
                if ($val['create_time'] > strtotime('-1 day')) {
                    $view3DayData[] = $val;
                }
                if ($val['create_time'] > strtotime('-1 week')) {
                    $view3WeekData[] = $val;
                }
                if ($val['create_time'] > strtotime('-1 month')) {
                    $view3MonthData[] = $val;
                }
            }
        }
        //上两个月的数据
        $Data2 = self::demandOfferByCondition(array('conditions' => array('create_time >?' => strtotime('-2 month'), 'create_time <?' => strtotime('-1 month'))));
        $view0DayData2 = array();
        $view0WeekData2 = array();
        $view0MonthData2 = array();
        $view3DayData2 = array();
        $view3WeekData2 = array();
        $view3MonthData2 = array();
        foreach ($Data2 as $val) {
            if ($val['view_count_c'] == 0) {
                if ($val['create_time'] > strtotime('-2 day')) {
                    $view0DayData2[] = $val;
                }
                if ($val['create_time'] > strtotime('-2 week')) {
                    $view0WeekData2[] = $val;
                }
                if ($val['create_time'] > strtotime('-2 month')) {
                    $view0MonthData2[] = $val;
                }
            }
            if ($val['view_count_c'] >= 3) {
                if ($val['create_time'] > strtotime('-2 day')) {
                    $view3DayData2[] = $val;
                }
                if ($val['create_time'] > strtotime('-2 week')) {
                    $view3WeekData2[] = $val;
                }
                if ($val['create_time'] > strtotime('-2 month')) {
                    $view3MonthData2[] = $val;
                }
            }
        }
        //客户浏览量为0 的比例
        $view0Percent['day'] = count($view0DayData2) == 0 ? count($view0DayData) : count($view0DayData) / count($view0DayData2);
        $view0Percent['week'] = count($view0WeekData2) == 0 ? count($view0WeekData) : count($view0WeekData) / count($view0WeekData2);
        $view0Percent['month'] = count($view0MonthData2) == 0 ? count($view0MonthData) : count($view0MonthData) / count($view0MonthData2);
        //客户浏览量大于3 的比例
        $view3Percent['day'] = count($view3DayData2) == 0 ? count($view3DayData) : count($view3DayData) / count($view3DayData2);
        $view3Percent['week'] = count($view3WeekData2) == 0 ? count($view3WeekData) : count($view3WeekData) / count($view3WeekData2);
        $view3Percent['month'] = count($view3MonthData2) == 0 ? count($view3MonthData) : count($view3MonthData) / count($view3MonthData2);
        return array(
            'view0' => $view0Percent,
            'view0_count' => count($view0DayData),
            'view3' => $view3Percent,
            'view3_count' => count($view3DayData)
        );
    }

    /**
     * 根据条件查询 符合的需求
     * @param $args
     * @return array
     */
    static function  demandOfferByCondition($args)
    {
        $request = Func_Input::filter(array(
            'conditions' => 'array',
        ), $args);

        if (empty($request['conditions'])) {
            return false;
        }

        $data = Data_Mysql_Table_Demand_Offer::select("admin_id,demand_id,id,view_count_c,status,create_time", $request['conditions'], '', 9999);
        return $data;
    }
}