<?php

/**
 * Created by PhpStorm.
 * User: zhaozhichao
 * Date: 2015/7/19
 * Time: 15:15
 * @
 * 1.获取一个需求的所有推荐记录
 */
class  Api_Recommend_GetList extends Api
{
    /**
     *
     * 传入参数
     *$args= array(
     *          account_id => [Api_Session::user_id()]
     *          demand_id =>   需求ID
     *          num =>   条数  :20-100
     *          last_id =>   最后一条记录ID【用于分页】
     *
     *返回参数 array(
     * )
     */
    static function  handle($args = '')
    {
        $args['account_id'] = Api_Session::user_id();
        return self::getList($args);

    }

    static function  getList($args)
    {
        $request = Func_Input::filter(array(
            'demand_id' => 'int',
            'num' => 'int',
            'last_id' => 'int',
        ), $args);
        if (empty($request['demand_id'])) {
            return Api::request('error', '', '缺少参数或者参数不正确，请检查参数合法性');
        }
        $list = self::getDemandRecommend($request);
        if (empty($list[0])) {
            return Api::request('error', '', '没有获取到数据');
        }
        return Api::request('success', $list, '获取推荐记录成功');
    }

    static function  getDemandRecommend($args)
    {
        $request = Func_Input::filter(array(
            'demand_id' => 'int',
            'last_id' => 'int',
            'num' => 'int',
        ), $args);

        if (empty($request['demand_id'])) {
            return false;
        }
        $num = 15;
        if (!empty($request['num'])) {
            $num = $request['num'];
        }
        $conditions['t1.demand_id =?'] = $request['demand_id'];
        if (isset($request['last_id'])) {
            $conditions['t1.id <?'] = $request['last_id'];
        }
        $table = "{table} as t1 LEFT JOIN {prefix}product_info as t2 ON t1.product_id = t2.id  LEFT JOIN {prefix}product_set as t3 ON t3.id=t1.set_id LEFT JOIN {prefix}demand as t4 ON t1.demand_id=t4.id";
        $data = Data_Mysql_Table_Demand_Recommend::select('SQL_CALC_FOUND_ROWS t1.*,t2.product_name,t2.media as product_media,t3.set_name,t3.media as set_media,t4.account_id',
            $conditions, ' ORDER BY t1.id DESC', $num, $table);

        if (empty($data[0])) {
            return false;
        }
        foreach ($data as $k => $val) {

            $data[$k]['look_time'] = empty($val['look_time']) ? '' : date('Y-m-d', $val['look_time']);
            $data[$k]['market_remark'] = json_decode($val['market_remark'], true);
            $data[$k]['clientele_remark'] = json_decode($val['clientele_remark'], true);

            if ($val['product_media']) {
                $data[$k]['link'] = 'http://' . Core::$urls['host'] . '/service_info/' . $val['product_id'] . '.html';
                $data[$k]['product_media'] = json_decode($val['product_media'], true);
            } elseif ($val['set_media']) {
                $data[$k]['link'] = 'http://' . Core::$urls['host'] . '/set_info/' . $val['set_id'] . '.html';
                $data[$k]['set_media'] = json_decode($val['set_media'], true);
            } else {
                unset($data[$k]);
            }
        }

        return $data;

    }

}