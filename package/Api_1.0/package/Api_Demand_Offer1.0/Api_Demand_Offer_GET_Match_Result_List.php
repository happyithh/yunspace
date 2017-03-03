<?php
/**
 * Created by PhpStorm.
 * User: adu
 * Date: 2015/10/16
 * Time: 16:53
 * 获取匹配结果列表
 */
class Api_Demand_Offer_GET_Match_Result_List extends Api{

        static function getList($args){
            /**
             * 接受参数
             * 搜索匹配的参数（人数范围。价格范围，标签数组）
             * 关联表 商品匹配结果表和 商品表 （可能后续会用到商品匹配表）  查出匹配结果表的列表.
             * 精准匹配为第一批.(精准匹配为match_level 匹配情况 的高低)
             * 泛匹配为第二批 (泛匹配的match_level 匹配情况 的高低)
             * 泛匹配可能会再点击tab切换的时候再读取（待定，如果是这样的话。可能需要再增加一个泛匹配结果表）
             */
            $request = Func_Input::filter(array(
                'demand_id' => 'int',       //需求ID
                'offer_id' => 'int',       //
                'search' => 'array',     //需求筛选条件
            ), $args);
            /**
             * 1.第一批精确匹配 主要匹配 价格区间，人数范围，城市，标签
             * */
            $conditions1['(people_down <=? AND  people_up >=?)'] = array($request['search']['end_people'],$request['search']['start_people']);
            $conditions1['city'] = $request['search']['city'];
            //价格*100了。
            $conditions1["((price_down <= ? AND   price_up >=?) OR price_up IS NULL OR price_down IS NULL)"] = array( $request['search']['end_price'] * 100, $request['search']['start_price'] * 100);
            $conditions1['status'] = 1;
            $conditions1['expand_status'] = 1;
            //标签搜索未添加，因为
            if(isset($request['search']['tags'])) {
                foreach($request['search']['tags'] as $k=>$v){
                    $conditions1['tags'][$k] = '+' . trim($v);
                }
            }
            if(isset($request['search']['admin_area']) && !empty($request['search']['admin_area'])){
                $conditions1['attr'][4] = '+' . trim($request['search']['admin_area']);
            }
            if(isset($request['search']['category_id']) && !empty($request['search']['category_id'])){
                $conditions1['category_id'] = $request['search']['category_id'];
            }
            $rs_one = Data_Mysql_View_Item_Search::select('id,item_name,phone,price_up,price_down,people_up,people_down,city,activity_type,tags,response_sum,contacts,space_name,size,product_id', $conditions1, 'ORDER BY grade DESC,notice_last_time ASC ', 50);
            //插入匹配表结果
            $one_arr =array();
            if(!empty($rs_one)){
                foreach($rs_one as $k=>$v){
                    $data = array(
                        'demand_id'=>$request['demand_id'],
                        'offer_id'=>$request['offer_id'],
                        'item_id'=> $v->id,
                        'match_level'=>5,
                        'notice_time'=>0,
                    );
                    Api_Demand_Offer_Match_Result_Insert::insertResult($data);
                    $one_arr[] =$v->id;
                }
//                $data_sms = array(
//                    'demand_id'=>$request['demand_id'],
//                    'offer_id'=>$request['offer_id'],
//                );
                //匹配的时候不发送 20151112
               // Api_Demand_Offer_Send_SMS_Vendor::Cron();
            }
            /**
             * 2.泛匹配。活动城市，价格区间 ,人数区间
             * */
            $conditions2['(people_down <=? AND  people_up >=?)'] = array($request['search']['end_people'],$request['search']['start_people']);
            $conditions2['city'] = $request['search']['city'];
            //价格*100了。
            $conditions2["((price_down <= ? AND   price_up >=?) OR price_up IS NULL OR price_down IS NULL)"] = array( $request['search']['end_price'] * 100, $request['search']['start_price'] * 100);
            $conditions2['status'] = 1;
            $conditions2['expand_status'] = 1;
            if($one_arr){
                $conditions2[] = "id not in (".implode(',',$one_arr).")";
            }
            if(isset($request['search']['admin_area']) && !empty($request['search']['admin_area'])){
                $conditions2['attr'][4] = '+' . trim($request['search']['admin_area']);
            }
            //标签搜索未添加，因为
//            if(isset($request['search']['tags'])) {
//                foreach ($request['search']['tags'] as $k => $v) {
//                    $conditions2['tags'][$k] = '+' . trim($v);
//                }
//            }
            $rs_two = Data_Mysql_View_Item_Search::select('id,item_name,phone,price_up,price_down,people_up,people_down,city,activity_type,tags,response_sum,contacts,space_name', $conditions2, 'ORDER BY grade DESC,notice_last_time ASC ', 25);
//            $two_arr = array();
            if(!empty($rs_two)){
                foreach($rs_two as $k=>$v){
                    $data = array(
                        'demand_id'=>$request['demand_id'],
                        'offer_id'=>$request['offer_id'],
                        'item_id'=> $v->id,
                        'match_level'=>3,
                    );
                    Api_Demand_Offer_Match_Result_Insert::insertResult($data);
//                    $two_arr[] =$v->id;
                }
            }


//            /**
//             * 3.泛匹配。活动城市，人数区间 （标签）
//             * */
//            $conditions3['city'] = $request['search']['city'];
//            $conditions3['(people_down <=? OR  people_up >=?)'] = array($request['search']['end_people'],$request['search']['start_people']);
//            $conditions3['status'] = 1;
//            $conditions3['expand_status'] = 1;
//            if(!empty($one_arr)&&!empty($two_arr)){
//                $three_arr = array_merge($one_arr,$two_arr);
//                $conditions3[] = "id not in (".implode(',',$three_arr).")";
//            }
//            //标签搜索未添加，因为
//            if(isset($request['search']['tags'])) {
//                foreach ($request['search']['tags'] as $k => $v) {
//                    $conditions3['tags'][$k] = '+' . trim($v);
//                }
//            }
//            $rs_three = Data_Mysql_View_Item_Search::select('id,item_name,phone,price_up,price_down,people_up,people_down,city,activity_type,tags,response_sum,contacts,space_name', $conditions2, 'ORDER BY grade DESC,response_sum ASC ', 25);
//            if(!empty($rs_three)){
//                foreach($rs_three as $k=>$v){
//                    $data = array(
//                        'demand_id'=>$request['demand_id'],
//                        'offer_id'=>$request['offer_id'],
//                        'item_id'=> $v->id,
//                        'match_level'=>3,
//                    );
//                    Api_Demand_Offer_Match_Result_Insert::insertResult($data);
//                }
//            }

            return $rs_one;
        }

        static function getListAll($args){
            $request = Func_Input::filter(array(
                'demand_id' => 'int',       //需求ID
                'offer_id' => 'int',       //
                'type'=>'int',
            ), $args);
            if($request['type'] ==1 || $request['type'] ==2){
                $demand_offer_info = Data_Mysql_Table_Demand_Offer::select("*",array('demand_id=?'=>$request['demand_id'],'status >=?'=>0),'',1);
                if(empty($demand_offer_info)){
                    return '';
                }
                $month = date('Ym', $demand_offer_info[0]['create_time']);
                if($request['type']==1){
                    $match_level = 5;
                }
                if($request['type']==2){
                    $match_level = 3;
                }
                $cols = "tb1.id as result_id,tb1.notice_time,tb2.*";
                $conditions =array(
                    'tb1.demand_id=?'=>$request['demand_id'],
                    'tb1.offer_id=?'=>$request['offer_id'],
                    'tb1.match_level=?'=>$match_level,
//                    'tb2.status=?'=>1,
                );
                $order = 'ORDER BY tb2.grade DESC,tb2.notice_last_time ASC ';
                $table ='{table} as tb1 LEFT JOIN {prefix}demand_match_space_archives as tb2 ON tb1.item_id =tb2.item_id';
                $list = Data_Mysql_Table_Demand_Match_Result::subTable('_' . $month)->page(0, 15, $cols, $conditions, $order, $table );
                //处理数据
                $itemids = array();
                if(isset($list['rows'])&&!empty($list['rows'])){
                    foreach($list['rows'] as $k=>$v){
                        $itemids[] =$v['item_id'];
                    }
                }
                //查询子空间相关数据
                $cols1 = 'tb1.*,tb2.space_name,tb2.category_id';
                $conditions1 =array(
                    'tb1.status=?'=>1,
                );
                if($itemids){
                    $conditions1[] = "tb1.id in (".implode(',',$itemids).")";
                }
                $table1 ='{table} as tb1  LEFT JOIN {prefix}spacepedia as tb2 ON tb1.space_id =tb2.id';
                $item_list = Data_Mysql_Table_Space_Item::select($cols1, $conditions1, '', 50, $table1 );

                if(isset($list['rows'])&&!empty($list['rows'])&&!empty($item_list)){
                    foreach($list['rows'] as $k=>$v){
                        foreach($item_list as $kk=>$vv){
                            if($vv['id']==$v['item_id']){
                                $list['rows'][$k]['item_name'] = $vv['item_name'];
                                $list['rows'][$k]['space_name'] = $vv['space_name'];
                                $list['rows'][$k]['space_id'] = $vv['space_id'];
                                $list['rows'][$k]['city'] = $vv['city'];
                                $list['rows'][$k]['size'] = $vv['size'];
                                $list['rows'][$k]['min_price'] = $vv['min_price'];
                                $list['rows'][$k]['max_price'] = $vv['max_price'];
                                $list['rows'][$k]['min_people'] = $vv['min_people'];
                                $list['rows'][$k]['max_people'] = $vv['max_people'];
                                $list['rows'][$k]['phone'] = $vv['phone'];
                                $list['rows'][$k]['contacts'] = $vv['contacts'];
                                $list['rows'][$k]['product_id'] = $vv['product_id'];
                                $list['rows'][$k]['category_id'] =$vv['category_id'];
                            }
                        }
                    }
                }
            }else{
                //未拓展或未通过审核的之类的
                $list = self::getNoExpand($request);
            }
            return $list;
        }

        static function getNoExpand($request){
            //获取条件
            $offer_info =  Data_Mysql_Table_Demand_Offer::select('*',array('id=?'=>$request['offer_id']),'',1);
            $request['search']  = json_decode($offer_info[0]['demand_filter'],1);
            if($request['type']==3){
                $conditions1['(people_down <=? AND  people_up >=?)'] = array($request['search']['end_people'],$request['search']['start_people']);
                $conditions1['city'] = $request['search']['city'];
                //价格*100了。
                $conditions1["((price_down <= ? AND   price_up >=?) OR price_up IS NULL OR price_down IS NULL)"] = array( $request['search']['end_price'] * 100, $request['search']['start_price'] * 100);
//                $conditions1['status !=?'] = 1;
                $conditions1['expand_status =?'] = 0;
                //标签搜索未添加，因为
                if(isset($request['search']['tags'])) {
                    foreach($request['search']['tags'] as $k=>$v){
                        $conditions1['tags'][$k] = '+' . trim($v);
                    }
                }
                $rs_one = Data_Mysql_View_Item_Search::select('id,item_id,item_name,phone,price_up,price_down,people_up,people_down,city,activity_type,tags,response_sum,contacts,space_name', $conditions1, 'ORDER BY grade DESC,notice_last_time ASC ', 20);
                return $rs_one;
            }
            if($request['type']==4){
                $_searchNew =  Func_Input::filter(array(
                    'search_new' => 'array',       //需求ID
                ), $_REQUEST);
                //完全没有发送过短信的未拓展的。倒序排列
                $cols = "tb1.id as result_id,tb2.*,tb3.space_name,tb3.category_id";
                $conditions =array(
                    '(tb2.expand_status =? or tb2.expand_status =?)'=>array(0,-1),
                    '(tb2.status >=? and tb2.status !=?)'=>array(0,3),
                );
                $conditions['tb2.city=?'] = $request['search']['city'];
                //价格*100了。
                if(!empty($_searchNew['search_new'])  &&  isset($_searchNew['search_new']['start_price']) &&  isset($_searchNew['search_new']['end_price'])&&  intval($_searchNew['search_new']['start_price'])>=0 && !empty($_searchNew['search_new']['end_price'])){
                    $conditions["((tb1.price_down <= ? AND tb1.price_up >=?) OR tb1.price_up IS NULL OR tb1.price_down IS NULL)"] = array( intval($_searchNew['search_new']['end_price'], 10) * 100, intval($_searchNew['search_new']['start_price'], 10) * 100);
                }
//                else{
//                    $conditions["((tb1.price_down <= ? AND tb1.price_up >=?) OR tb1.price_up IS NULL OR tb1.price_down IS NULL)"] = array( 20000 * 100, 0);
//                }
                if(!empty($_searchNew['search_new'])  &&  isset($_searchNew['search_new']['start_size']) &&  isset($_searchNew['search_new']['end_size'])&&  intval($_searchNew['search_new']['start_size'])>=0 && !empty($_searchNew['search_new']['end_size'])){
                    $conditions['tb2.size <=?']=intval($_searchNew['search_new']['end_size'],10);
                    $conditions['tb2.size >=?']=intval($_searchNew['search_new']['start_size'],10);
                }
                if(!empty($_searchNew['search_new'])  &&  isset($_searchNew['search_new']['category_id']) && !empty($_searchNew['search_new']['category_id'])){
                    $conditions['tb3.category_id =?']=$_searchNew['search_new']['category_id'];
                }
                //用like 是个坑？20151109
                if(!empty($_searchNew['search_new']) && isset($_searchNew['search_new']['item_name']) && !empty($_searchNew['search_new']['item_name'])){
                    $item_name = trim($_searchNew['search_new']['item_name']);
                    if(!empty($item_name)){
                        $conditions[] = "tb2.item_name like '%".$item_name."%'";
//                        $conditions["(tb2.expand_status =? or tb2.expand_status =? or tb2.expand_status =? or tb2.expand_status =? )"] = array(0,1,2,-3);
                        unset($conditions['(tb2.expand_status =? or tb2.expand_status =?)']);
                        $conditions['tb2.expand_status !=? '] =array(-3);
//                        unset($conditions['(tb2.status >=? and tb2.status !=?)']);
                    }
                }
                $table ='{table} as tb1 LEFT JOIN {prefix}space_item as tb2 ON tb1.item_id =tb2.id LEFT JOIN {prefix}spacepedia as tb3 ON tb2.space_id =tb3.id';
                $order = ' order by tb2.contacts desc ,tb2.expand_status desc';
//                Data_Mysql_Table_Demand_Match_Space_Archives::debug(1);
                $list =  Data_Mysql_Table_Demand_Match_Space_Archives::page(0,20,$cols,$conditions,$order,$table);
                return $list;
            }
        }

        static  function  getOfferList($args){
            $request = Func_Input::filter(array(
                'demand_id' => 'int',       //需求ID
                'offer_id' => 'int',       //
                'type'=>'int',
                'change_id'=>'int'
            ), $args);
            $demand_offer_info = Data_Mysql_Table_Demand_Offer::select("*",array('demand_id=?'=>$request['demand_id'],'status >=?'=>0),'',1);
            if(empty($demand_offer_info)){
                return '';
            }
             $month = date('Ym', $demand_offer_info[0]['create_time']);
                $cols = "tb1.id as result_id,tb1.offer_id,tb1.item_id,tb1.notice_time,tb1.offer_price,tb1.offer_time,tb1.offer_info,tb1.change_phone_time,tb1.offer_unit,tb2.*,tb3.space_name";
                $conditions =array(
                    'tb1.demand_id=?'=>$request['demand_id'],
                    'tb1.offer_id=?'=>$request['offer_id'],
                    'tb1.offer_price>?'=>0,
                    'tb1.offer_time >?'=>0,
                    'tb2.status=?'=>1,
                );
            if(!empty($request['change_id'])){
                $conditions[]="tb1.change_phone_time !=0";
            }
                $table ='{table} as tb1 LEFT JOIN {prefix}space_item as tb2 ON tb1.item_id =tb2.id LEFT JOIN {prefix}spacepedia as tb3 ON tb2.space_id =tb3.id';
                $list = Data_Mysql_Table_Demand_Match_Result::subTable('_' . $month)->select($cols, $conditions, '',100, $table );
            return $list;
        }

        static  function getAllNum($args){
            $request = Func_Input::filter(array(
                'demand_id' => 'int',       //需求ID
                'offer_id' => 'int',       //
            ), $args);
            $demand_offer_info = Data_Mysql_Table_Demand_Offer::select("*",array('demand_id=?'=>$request['demand_id'],'status >=?'=>0),'',1);
            if(empty($demand_offer_info)){
                return '';
            }
            $demand_offer_info[0]['demand_filter'] = json_decode($demand_offer_info[0]['demand_filter'],1);
            $month = date('Ym', $demand_offer_info[0]['create_time']);
            $cols = "count(id) as rs_num,match_level";
            $conditions =array(
                'demand_id=?'=>$request['demand_id'],
                'offer_id=?'=>$request['offer_id'],
            );
            $rs_nums = Data_Mysql_Table_Demand_Match_Result::subTable('_' . $month)->select($cols, $conditions, 'group by match_level',100 );
            $new_num =array(
                'type_1'=>0,
                'type_2'=>0,
                'type_3'=>0,
            );
            if(!empty($rs_nums)){
                foreach($rs_nums as $k=>$v){
                    if($v['match_level']==5){
                        $new_num['type_1'] = $v['rs_num'];
                    }
                    if($v['match_level']==3){
                        $new_num['type_2'] = $v['rs_num'];
                    }
                }

            }
            $conditions =array(
                '(tb2.expand_status =? or tb2.expand_status =?)'=>array(0,-1),
                '(tb2.status >=? and tb2.status !=?)'=>array(0,3),
            );
            $conditions['tb2.city=?'] = @$demand_offer_info[0]['demand_filter']['city'];

            $table ='{table} as tb1 LEFT JOIN {prefix}space_item as tb2 ON tb1.item_id =tb2.id';
            $expend_num =  Data_Mysql_Table_Demand_Match_Space_Archives::select('count(tb1.id) as rs_num',$conditions,'',1,$table);
            if(!empty($expend_num)){
                if(isset($expend_num[0]['rs_num'])){
                    $new_num['type_4'] = $expend_num[0]['rs_num'];
                }
            }
            return $new_num;

        }

        static function haveSendMessageNum($args){
            $request = Func_Input::filter(array(
                'demand_id' => 'int',       //需求ID
                'offer_id' => 'int',       //
            ), $args);
            $demand_offer_info = Data_Mysql_Table_Demand_Offer::select("*",array('demand_id=?'=>$request['demand_id'],'status >=?'=>0),'',1);
            if(empty($demand_offer_info)){
                return '';
            }

            $month = date('Ym', $demand_offer_info[0]['create_time']);
            $rs = Data_Mysql_Table_Demand_Match_Result::subTable('_' . $month)->select('count(id) as nums', array('notice_time>?'=>1,'demand_id=?'=>$request['demand_id'],'offer_id=?'=>$request['offer_id']), '',1 );
            if(isset($rs[0]) && isset($rs[0]['nums'])){
                return $rs[0]['nums'];
            }else{
                return 0;
            }
        }
}