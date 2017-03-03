<?php

/**
 * Created by PhpStorm.
 * User: zzc
 * Date: 2015/8/27
 * Time: 11:27
 *
 */
class  Api_Demand_Tender_MatchingProduct extends Api
{
    /**
     * 1.完全匹配（活动城市，活动类型，价格区间，活动人数） 搜索产品。
     * 获取产品对应的供应商ID（vendor_id）
     * 关联供应商信息表。获取供应商联系手机号（及优先级） 存数组1
     *
     * 2.部分匹配（  活动城市-价格区间    活动城市-活动人数） 搜索产品表
     * 获取产品对应的供应商ID（vendor_id）
     * 关联供应商信息表。获取供应商联系手机号（及优先级） 存数组2,3,4
     *
     *
     * 去除重复数据手机号  按照优先级排序手机号   保存到一个数组里，
     *
     *
     *
     * 保存数据到表里
     *
     *
     */


    static function  matching($args)
    {
        $request = Func_Input::filter(array(
            'demand_id' => 'int',
            'tender_id' => 'int',
        ), $args);
        if (empty($request['demand_id']) || empty($request['tender_id'])) {
            $result = self::request('error', '', "需求id或者报价id不能为空");
            return $result;
        }
        $info = Api_Demand_GetInfo::getInfo($request);
        if ($info['status'] == 0) {
            $result = self::request('error', '', $info['msg']);
            return $result;
        }
        //全部要求（条件）匹配的需求 的产品，存入数据
        //暂时不适用业务类型（后期可能会加上）  活动城市，活动类型，价格区间，活动人数
        if (!empty($info['data']['demand']['业务子类'])) {
            $conditions1['category_id'] = intval($info['data']['demand']['业务子类']);
        } else {
            $conditions1['attr_index'][49] = '+' . trim($info['data']['demand']['活动类型']);
        }
        //需求人数
        $demand_people = explode('-', $info['data']['demand']['活动人数']);
        $demand_people[1] =isset($demand_people[1]) ? $demand_people[1] : 0;
        $start_people = intval($demand_people[0]);
        $end_people = empty($demand_people[1]) ? 0 : intval($demand_people[1]);

        if (intval($demand_people[0]) == 50 && intval($demand_people[1]) == 0) {
            $start_people = 0;
            $end_people = 50;
        } elseif (intval($demand_people[0]) == 500 && intval($demand_people[1]) == 0) {
            $start_people = 500;
            $end_people = 50000;
        } elseif (intval($demand_people[0]) && @intval($demand_people[1]) == 0) {
            $start_people = intval($demand_people[0]);
            $end_people = intval($demand_people[0]) + 50;
        }


        $conditions1['status'] = 1;
        $conditions1['attr_index'][46] = '+' . trim($info['data']['city']);

        $conditions1["((price >= ? AND price <=?) OR price IS NULL)"] = array($info['data']['price_up'] * 100, $info['data']['price_down'] * 100);
        $conditions1['order_people_number >=? AND order_people_number <=?'] = array($start_people, $end_people);

        $rs_one = Data_Mysql_View_Product_Search::select('id,vendor_id,product_name,phone,account_id', $conditions1, 'ORDER BY expand_status DESC ', 200);

        $vendor_ids = array(1 => array(), 2 => array(), 3 => array());
        $product_ids = array(1 => array(), 2 => array(), 3 => array());
        $phones = array(1 => array(), 2 => array(), 3 => array());
        $productName = array();
        foreach ($rs_one as $k => $v) {

            if ($v->vendor_id) {
                $vendor_ids[1][] = $v->vendor_id;
            }
            if ($v->id) {
                $product_ids[1][] = $v->id;
            }
            if ($v->phone && $v->account_id) {
                $phones[1][$v->account_id] = $v->account_id . ":" . $v->phone;
                $productName[] = $v->product_name;
            }
        }
        //部分匹配。活动城市，价格区间
        $conditions2['status'] = 1;
        $conditions2['attr_index'][46] = '+' . trim($info['data']['city']);
        $conditions2["((price >= ? AND price <=?) OR price IS NULL)"] = array($info['data']['price_up'] * 100, $info['data']['price_down'] * 100);
        $conditions2['order_people_number >=? AND order_people_number <=?'] = array($start_people, $end_people);

        $rs_two = Data_Mysql_View_Product_Search::select("id,vendor_id,product_name,phone,account_id", $conditions2, 'ORDER BY expand_status DESC', 200);

        foreach ($rs_two as $k => $v) {
            if ($v->vendor_id) {
                $vendor_ids[2][] = $v->vendor_id;
            }
            if ($v->id) {
                $product_ids[2][] = $v->id;
            }
            if ($v->phone && $v->account_id) {
                $phones[2][$v->account_id] = $v->account_id . ":" . $v->phone;
                $productName[] = $v->product_name;
            }
        }

        //去除重复数据
        $vendor_ids[2] = @array_diff($vendor_ids[2], $vendor_ids[1]);
        $product_ids[2] = @array_diff($product_ids[2], $product_ids[1]);
        $phones[2] = @array_diff($phones[2], $phones[1]);

        //部分匹配 活动城市，活动人数
        $conditions3['status'] = 1;
        $conditions3['attr_index'][46] = '+' . trim($info['data']['city']);
        $conditions3["((price >= ? AND price <=?) OR price IS NULL)"] = array($info['data']['price_up'] * 100, $info['data']['price_down'] * 100);

        $rs_three = Data_Mysql_View_Product_Search::select("id,product_name,vendor_id,phone,account_id", $conditions3, 'ORDER BY expand_status DESC', 200);

        foreach ($rs_three as $k => $v) {

            if ($v->vendor_id) {
                $vendor_ids[3][] = $v->vendor_id;
            }
            if ($v->id) {
                $product_ids[3][] = $v->id;
            }
            if ($v->phone && $v->account_id) {
                $phones[3][$v->account_id] = $v->account_id . ":" . $v->phone;
                $productName[] = $v->product_name;
            }
        }

        //去除重复数据
        $vendor_ids[3] = @array_diff($vendor_ids[3], $vendor_ids[2], $vendor_ids[1]);
        $product_ids[3] = @array_diff($product_ids[3], $product_ids[2], $product_ids[1]);
        $phones[3] = @array_diff($phones[3], $phones[2], $phones[1]);

        if (empty($vendor_ids) || empty($phones)) {
            $result = self::request('error', '', "未匹配到相关商品！");
            return $result;
        }
        //整合手机号数据
        $newPhone = @array_merge($phones[1], $phones[2], $phones[3]);
        //加限制  如果匹配数量大于50个
        $countPhone = count($newPhone);
        if ($countPhone > 50) {
            $newPhone = @array_slice($newPhone, 0, 50, 0);
        }
        $data = array(
            'tender_id' => $request['tender_id'],       //报价ID
            'vendor_ids' => $vendor_ids,   //匹配的供应商id集合
            'product_ids' => $product_ids,    //匹配的产品id
            'product_name' => $productName,    //匹配的产品名字
            'phones' => $newPhone,    //供应商手机号
            'create_time' => time(),
            'update_time' => time(),
            'status' => 0,
        );
        Core::log("baojiaxitong", "匹配数据并插入数据之前 第0步",implode(',',$data));
        $rs = Data_Mysql_Table_Demand_Tender_Matching_Product::insert($data);
        if ($rs) {
            Data_Mysql_Table_Demand_Tender::update(
                array('id' => $data['tender_id']),
                array('product_sum' => count($newPhone))
            );
            if (count($newPhone) == 0) {
                //查询一下是否是正常流程。还是代理人流程
                $agent_result = Data_Mysql_Table_Demand_Tender::select("id,demand_id,agent_status",array("id=?"=>$request['tender_id'],'demand_id=?'=>$request['demand_id']),'',1);
                if($agent_result[0]['agent_status']==1){
                    //没有匹配数据的时候。暂时不发送给客户。直接发邮件给销售（代理人）
                    $noticeData = array(
                        'tender_id' => $request['tender_id'],
                        'title'=>'需求没有商家提交方案',
                        'content'=>'需求没有匹配到产品：<br>' . '需求ID:' . $request['demand_id'] . '<br>',
                    );
                    Core::log("baojiaxitong", "未匹配到给代理人发邮件",implode(',',$noticeData));
                    Api_Demand_Tender_NoticeAgent::NoticeAgentByEmail($noticeData);
                }else{
                    Core::log("baojiaxitong", "未匹配到给客户发短信",implode(',',$data['tender_id']));
                    Api_Demand_Tender_NoticeCustomer::noMatchingProductNotice(array('id' => $data['tender_id']));
                }
            } else {
                Core::log("baojiaxitong", "给匹配供应商发短信，有新的报价",$data['tender_id']);
                Api_Demand_Tender_NoticeVendor::notice(array(
                    'tender_id' => $data['tender_id'],
                ));
            }
            $result = self::request('success', '', "插入数据成功");
            return $result;
        } else {
            $result = self::request('error', '', "插入数据库失败");
            return $result;
        }

    }

}