<?php
/**
 * Created by PhpStorm.
 * User: yl
 * Date: 15-6-2
 * Time: 上午9:48
 */
class OA_Product_Set_List{
    static function handle(){
        $_REQUEST['action']=empty($_REQUEST['action'])?'list':$_REQUEST['action'];
        if (!empty($_REQUEST['action']) && $_REQUEST['action'] == 'detail') {
            self::productSetDetail();
        } elseif (!empty($_REQUEST['action']) && $_REQUEST['action'] == 'edit') {
            self::productSetEdit();
        } elseif (!empty($_REQUEST['action']) && $_REQUEST['action'] == 'delete_set') {
            self::productSetDelete();
        } elseif (!empty($_REQUEST['vendor_auto_complete'])) {
            Admin_Data_Table_Product_Info::handleVendorAutoComplete();
        } elseif (!empty($_REQUEST['product_auto_complete'])) {
            Admin_Data_Table_Product_Info::handleProductInfoAutoComplete();
        } elseif (!empty($_REQUEST['is_submit'])) {
            self::productSetEditSubmit();
        } else {
            self::productSetList();
        }
    }
    /*
     *套餐列表页
     */
    static function productSetList(){
        $conditions=array();
        if (!empty($_REQUEST['search'])) {
            $search = Func_Input::filter(array(
                'title' => 'string',
                'vendor_name' => 'string',
                'search_city' => 'string',
                'min_hours' => 'int',
                'max_hours' => 'int',
                'min_people' => 'int',
                'max_people' => 'int',
                'category_id' => 'int',
                'end_time' => 'string',
                'start_time' => 'string',
                'orderBy' => 'int',
            ), $_REQUEST['search']);
            //名称或ID筛选
            if (!empty($search['title'])) {
                if (is_numeric($_REQUEST['search']['title'])) {
                    $conditions['id'] = $search['title'];
                } else {
                    $conditions['set_name'] = $search['title'];
                }
            }
            //供应商筛选
            if (!empty($search['vendor_name'])) {
                $conditions[] ='{prefix}vendor_info.vendor_name like "%'.$search['vendor_name'].'%"'; ;
            }
            //更新时间筛选
            if (!empty($search['start_time']) && !empty($search['end_time'])) {
                if (strtotime($search['start_time']) > strtotime($search['end_time'])) {
                    Func_Header::back('请正确选择时间范围！！');
                }
            }
            if (!empty($search['start_time'])) {
                $conditions['attr_index']['开始时间'] = $search['start_time'];
            }
            if (!empty($search['end_time'])) {
                $conditions['attr_index']['结束时间'] = $search['end_time'];
            }

            //小时数筛选
            if (!empty($search['min_hours']) && !empty($search['max_hours'])) {
                if ($search['min_hours'] > $search['max_hours']) {
                    Func_Header::back('请正确选择时间范围！！');
                } else {
                    $conditions['{table}.hours between ? and ?'] = array($search['min_hours'], $search['max_hours']);
                }
            } elseif (!empty($search['min_hours']) && empty($search['max_hours'])) {
                $conditions['{table}.hours > ?'] = $search['min_hours'];
            } elseif (empty($search['min_hours']) && !empty($search['max_hours'])) {
                $conditions['{table}.hours < ?'] = $search['max_hours'];
            }

            //人数筛选
            if (!empty($search['min_people']) && !empty($search['max_people'])) {
                if ($search['min_people'] > $search['max_people']) {
                    Func_Header::back('请正确选择人数范围！！');
                } else {
                    $conditions['{table}.people between ? and ?'] = array($search['min_people'], $search['max_people']);
                }
            } elseif (!empty($search['min_people']) && empty($search['max_people'])) {
                $conditions['{table}.people > ?'] = $search['min_people'];
            } elseif (empty($search['min_people']) && !empty($search['max_people'])) {
                $conditions['{table}.people < ?'] = $search['max_people'];
            }

            //城市筛选
            if (!empty($search['search_city'])) {
                $conditions['attr_index']['城市'] = '+' . $search['search_city'];
            }
            //服务分类筛选
            if (!empty($search['category_id'])) {
                $conditions['{table}.category_id = ?']=$search['category_id'];
            }
        }

        $handle_type = empty($_REQUEST['handle_type']) ? 'online' : $_REQUEST['handle_type'];
        switch ($handle_type) {
            case "reject":
                $conditions['{table}_update.status = ? '] = 3;
                break;
            case "waiting":
                $conditions['{table}_update.status = ? '] = 2;
                break;
            case "online":
                $conditions['{table}.status = ? '] = 1;
                break;
            case "offline":
                $conditions['{table}.status = ? '] = 0;
                break;
            case "recycle":
                $conditions['{table}_update.status = ? '] = -2;
                break;
            case "all":
                break;
        }

        //排序方式
        $orderBy = empty($search['orderBy']) ? '' : $search['orderBy'];
        switch ($orderBy) {
            case '1':
                //浏览量+订单量+更新时间+评分（组成一个综合排名算法）
                $order = 'ORDER BY ({table}.counter_view+{table}.counter_order+{table}.update_time+{table}.score) DESC';
                break;
            case '2':
                $order = 'ORDER BY {table}.counter_view DESC';
                break;
            case '3':
                $order = 'ORDER BY {table}.id DESC';
                break;
            default:
                //默认排序
                $order = 'ORDER BY {table}.update_time ASC';
                break;
        }

        $productSet = Data_Mysql_Table_Product_Set::page(0, 20, '{table}.*,{table}_update.status as update_status,{prefix}vendor_info.vendor_name as vendor_name2', $conditions, $order, '{table} LEFT JOIN {table}_update ON {table}.id={table}_update.id LEFT JOIN {prefix}vendor_info ON {table}.vendor_id={prefix}vendor_info.id');

        if (!empty($productSet['rows'])) {
            foreach ($productSet['rows'] as $k => $v) {
                $productSet['rows'][$k]['attr_index'] = json_decode($v['attr_index'], 1);
                $productSet['rows'][$k]['detail_data'] = json_decode($v['detail_data'], 1);
                $follow['follow_id']= $v['id'];
              $rs = Data_Mysql_Table_Follow::subTable('_set')->select('count(follow_id) AS follow',$follow);
               $productSet['rows'][$k]['counter_follow'] = $rs[0]['follow'];
            }
        }

        if (!empty($_REQUEST['search'])) {
            $sea_url = '&search[title]='.$search['title'].'&search[vendor_name]='.$search['vendor_name'].'&search[min_hours]='.$search['min_hours'].'&search[search_city]='.$search['search_city'].'&search[max_hours]='.$search['max_hours'].
                '&search[end_time]='.$search['end_time'].'&search[start_time]='.$search['start_time'].'&search[min_people]='.$search['min_people'].'&search[category_id]='.$search['category_id'].'&search[orderBy]='.$search['orderBy'];
            Tpl_Smarty::assign('urls', $sea_url);
        }
        Tpl_Smarty::assign('categoryList', Data_Mysql_Table_Product_Category::getTreeCache());
        Tpl_Smarty::assign('_category', Data_Mysql_Table_Product_Category::getInfoCache());
        Tpl_Smarty::assign('_data', $productSet);
        Tpl_Smarty::assign('handle_type', $handle_type);
        Tpl_Smarty::assign('category_name', Data_Mysql_Table_Product_Set::$category_name);
        Tpl_Smarty::assign('is_admin', Admin_Authority::checkUrl('marketing/contact_urgent_list', 0));
        Tpl_Smarty::assign('orderBy', Data_Mysql_Table_Product_Set::$orderBy);
        Tpl_Smarty::display('OA','element/element_product_set_list.tpl');
    }
    /*
     *套餐详情页
     */
    static function productSetDetail(){
        if (empty($_REQUEST['id'])) {
            Func_Header::back('参数错误！！');
        }
        $setInfo = self::getProductSetById();
        Tpl_Smarty::assign("category_name", Data_Mysql_Table_Product_Set::$category_name);
        Tpl_Smarty::assign('data',$setInfo);
        Tpl_Smarty::display('OA','element/element_product_set_detail.tpl');
    }
    /*
     *套餐编辑页
     */
    static function productSetEdit(){
        if (!Admin_Authority::checkUrl('marketing/contact_urgent_list', 0)) {
            Func_Header::back('没有权限！！');
        }
        if (empty($_REQUEST['id'])) {
            Func_Header::back('参数错误！！');
        }
        $setInfo = self::getProductSetById();
        Tpl_Smarty::assign("category_name", Data_Mysql_Table_Product_Set::$category_name);
        Tpl_Smarty::assign('_data', $setInfo);
        //获取活动类型和行业标签
        Tpl_Smarty::assign('_attrs', Data_Config_Vendor_Attr::get('attr'));
        Tpl_Smarty::display('OA', 'element/element_product_set_edit.tpl');
    }
    /*
     *套餐编辑修改提交
     */
    static function productSetEditSubmit()
    {
        if (!Admin_Authority::checkUrl('marketing/contact_urgent_list', 0)) {
            Func_Header::back('没有权限！！');
        }
        $request = Func_Input::filter(array(
            'set_id' => 'int',
            'schedule_product_id' => 'int',
            'data' => 'array',
        ));

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
//        if (empty($request['data']['addr'])) {
//            Func_Header::back('套餐地址不能为空！');
//        }
        if (empty($request['data']['hours'])) {
            Func_Header::back('小时数不能为空！');
        }
        if (empty($request['data']['detail']['套餐价'])) {
            Func_Header::back('套餐价不能为空！');
        }
        if(!empty($request['data']['detail']['计价单位']) && (empty($request['data']['detail']['计价下限']) || empty($request['data']['detail']['计价上限']))){
            Func_Header::back('计价产品的上下限不能为空！');
        }
        if(!empty($request['data']['detail']['计价下限']) && !empty($request['data']['detail']['计价上限']) && $request['data']['detail']['计价下限'] > $request['data']['detail']['计价上限']){
            Func_Header::back('请正确填写计价产品的上下限！');
        }

        if (empty($request['data']['attr_index']['天数']) ) {
            $request['data']['attr_index']['天数']=1;
        }

        $data = array();
        $data['schedule_product_id'] = intval($request['schedule_product_id']);
        $data['vendor_id'] = $request['data']['vendor_id'];
        $data['set_name'] = $request['data']['set_name'];
        $data['addr'] = $request['data']['addr'];
        $data['version'] = $request['data']['version'];
        $data['category_id'] = $request['data']['category_id'];
        $data['attr_index'] = $request['data']['attr_index'];
        $data['detail_des'] = $request['data']['detail_des'];
        $data['detail'] = $request['data']['detail'];
        $data['media'] = $request['data']['media'];
        $data['people'] = $request['data']['people'];
        $data['hours'] = $request['data']['hours'];
        $data['logo'] = !empty($request['data']['logo']) ? $request['data']['logo'] : '';
        $data['des'] = !empty($request['data']['des']) ? $request['data']['des'] : '';
        $data['status']=2;
        $data['counter_view'] = $request['data']['counter_view'];
        if ($request['set_id']) {
            $rs = Data_Mysql_Table_Product_Set::subTable('_update')->update(array('id'=>$request['set_id']),$data);
        } else {
            $rs = Data_Mysql_Table_Product_Set::subTable('_update')->insert($data);
        }
        if ($rs[0] > 0) {
            //创建操作日志
            $id = $request['set_id'] ? $request['set_id'] : $rs[0];
            //更改所属供应商的状态
            Data_Mysql_Table_Vendor_Info::subTable('_update')->update(array('id = ? and status != ?' => array($request['data']['vendor_id'], 2)), array('status' => 4));
            Func_Header::to(' 套餐修改信息已提交！', '?');
        }
        Func_Header::to('操作错误！！');
    }
    /*
     *获取套餐信息
     */
    static function getProductSetById(){
        $setInfo = array();
        $condition['{table}.id = ?'] = $_REQUEST['id'];
        $productSet = Data_Mysql_Table_Product_Set::select('{table}.*,{table}_update.status as update_status,{prefix}vendor_info.vendor_name as vendor_name2', $condition, '', 1, '{table} LEFT JOIN {table}_update ON {table}_update.id={table}.id LEFT JOIN {prefix}vendor_info ON {table}.vendor_id ={prefix}vendor_info.id');
        if (empty($productSet[0])) {
            Func_Header::back('套餐不存在！！');
        }
        $setInfo = $productSet[0];
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
        return $setInfo;
    }
    /*
     *删除套餐产品
     */
    static function productSetDelete(){
        Core::output('');
        if(empty($_REQUEST['id'])){
            Func_Header::back('参数错误！！');
        }
        if(!Admin_Authority::checkUrl('marketing/contact_urgent_list', 0)){
            Func_Header::back('没有权限！！');
        }
        $request = Func_Input::filter(array(
            'id' => 'int',
        ));
        //更新套餐状态
        $r = Data_Mysql_Table_Product_Set::query("UPDATE {table} SET status = ? WHERE id = ?", array(-2,$request['id']), 1);
        $r_update = Data_Mysql_Table_Product_Set::query("UPDATE {table}_update SET status = ? WHERE id = ?", array(-2,$request['id']), 1);
        if (empty($r[0]) || empty($r_update[0])) {
            Func_Output::json('error','','删除套餐失败！！');
        } else {
            Func_Output::json('success','','删除套餐成功！！');
        }
    }
}