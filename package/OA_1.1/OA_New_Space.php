<?php

/**报价列表
 * Created by PhpStorm.
 * User: zzc
 * Date: 2015/9/8
 * Time: 13:49
 */
@session_start();

class  OA_New_Space
{
    static function   handle()
    {
        $action = empty($_REQUEST['action']) ? 'list' : $_REQUEST['action'];
        switch ($action) {
            case 'list':
                self::handleNewSpace();
                break;
            /* case 'audit':
                 self::handleAudit();
                 break;*/
            case 'details':
                self::handleDetails();
                break;
            case 'newspace':
                self::handleNewspacebaike();
                break;
            case 'ajaxSpaceRefuse':
                self::handleSpaceRefuse();
                break;
            case "is_submit":
                self::submitSpacepediaInfo();
                break;
        }

    }


    static function  handleNewSpace()
    {
        $request = Func_Input::filter(array(
            'type' => 'string',
            'search' => 'array',
        ), $_REQUEST);
        $type = !empty($request['type']) ? $request['type'] : "all";
        $conditions = array();
        $order = 'ORDER BY create_time DESC';
        if (!empty($_REQUEST['search'])) {
            $search = Func_Input::filter(array(
                'id' => 'int',
                'start_time' => 'string',
                'end_time' => 'string',
                'city' => 'string',
                'phone' => 'string',
            ), $_REQUEST['search']);
            if (!empty($search['id'])) {
                $conditions["id =?"] = $search['id'];
            }
            if (!empty($search['city'])) {
                $conditions['city =?'] = $search['city'];
            }
            if (!empty($search['phone'])) {
                $conditions['phone =?'] = $search['phone'];
            }
            if (!empty($search['start_time']) && !empty($search['end_time'])) {
                if (strtotime($search['start_time']) > strtotime($search['end_time'])) {
                    Func_Header::back('请正确选择时间范围！！');
                } else {
                    $conditions['create_time between ? and ?'] = array(strtotime($search['start_time']), strtotime($search['end_time']));
                }
            } elseif (!empty($search['start_time']) && empty($search['end_time'])) {
                $conditions['create_time > ?'] = strtotime($search['start_time']);
            } elseif (empty($search['start_time']) && !empty($search['end_time'])) {
                $conditions['create_time < ?'] = strtotime($search['end_time']);
            }
        }
        if (!empty($_REQUEST['search'])) {
            $searchArray = 'search[city]=' . $search['city'] . '&search[start_time]=' . $search['start_time']
                . '&search[end_time]=' . $search['end_time'] . '&search[phone]=' . $search['phone'] . '&search[id]=' . $search['id'];
            Tpl_Smarty::assign('urls', $searchArray);
        }
        //获取所有需求总数
        $totalNum = array(
            '0' => 0,
            '1' => 0,
            '2' => 0,
            '3' => 0,//总数
        );
        $conditions_total[] = 'GROUP BY status';
        $cities = Data_Mysql_Table_New_Space::select('city', '', 'GROUP BY city', 10000);
        Tpl_Smarty::assign('city', $cities[0]);
        $total = Data_Mysql_Table_New_Space::select('count(*) as count, status', '', $conditions_total, 4);
        foreach ($total as $v) {
            $totalNum[$v['status']] = $v['count'];
            $totalNum[3] += $v['count'];
        }

        switch ($type) {
            case 'all':
                $data = Data_Mysql_Table_New_Space::page(0, 10, '*', $conditions, $order);
                break;
            case 'waiting':
                $conditions['status = ?'] = '0';
                $data = Data_Mysql_Table_New_Space::page(0, 10, '*', $conditions, $order);
                break;
            case 'pass':
                $conditions['status = ?'] = '1';
                $data = Data_Mysql_Table_New_Space::page(0, 10, '*', $conditions, $order);
                break;
            case 'abandon':
                $conditions['status = ?'] = '2';
                $data = Data_Mysql_Table_New_Space::page(0, 10, '*', $conditions, $order);
                break;

        }
        Tpl_Smarty::assign('_data', $data);
        Tpl_Smarty::assign('type', $type);
        Tpl_Smarty::assign('total', $totalNum);
        Tpl_Smarty::assign('categoryTree', Data_Mysql_Table_Product_Category::getTreeCache());
        Tpl_Smarty::display("OA_Static::new_space/new_space.tpl");
    }

//通过
    /*  static function  handleAudit()
      {   Core::output('');
          $request = Func_Input::filter(array(
              'space_id' => 'int'
          ),$_REQUEST);
          if(empty($request['space_id'])){
              Func_Output::json('error', '', '请刷新后重新提交！');
          }
          $conditions['id = ?'] = $request['space_id'];
          $page = Data_Mysql_Table_New_Space::update($conditions,array('status=?' =>1));
          if($page){
                     Func_Output::json('success', '', ' 操作成功');

          }else{
              Func_Output::json('error', '', '操作失败');
          }

      }*/
    //放弃
    static function handleSpaceRefuse()
    {
        Core::output('');
        $request = Func_Input::filter(array(
            'space_id' => 'int',
            'refuse_reason' => 'string'
        ), $_REQUEST);
        if (empty($request['space_id'])) {
            Func_Output::json('error', '', '请刷新后重新提交！');
        }
        $conditions['id = ?'] = $request['space_id'];
        $page = Data_Mysql_Table_New_Space::update($conditions, array('status' => 2, 'refuse_reason' => $request['refuse_reason']));

        if ($page[0] > 0) {
            $space = Data_Mysql_Table_New_Space::select('space_name,refuse_reason,phone', array('id=?' => $request['space_id']));
            $openid = Data_Mysql_Table_Account_Wechat_Manager::handleGetAccountInfo(array('phone' => $space[0]['phone']));
            if (!empty($openid['openid'])) {
                $data = array(
                    'space_name' => $space[0]['space_name'],
                    'refuse_reason' => $space[0]['refuse_reason'],
                    'openid' => $openid['openid'],
                );

                $s = Api_Common_Send_Site_Text::SendWinReason($data);
            }

            Func_Output::json('success', '', ' 操作成功');

        } else {
            Func_Output::json('error', '', '操作失败');
        }
    }

    //详情
    static function handleDetails()
    {
        Core::output('');
        $request = Func_Input::filter(array(
            'space_id' => 'int'
        ), $_REQUEST);
        $conditions['id =?'] = $request['space_id'];
        // $table ='{table} as t1 LEFT JOIN {prefix}space_item as t2 ON t1.id=t2.space_id';
        $data = Data_Mysql_Table_New_Space::select('*', $conditions, '', 1);
        if (!empty($data[0])) {
            foreach ($data as $k => $v) {
                $data[$k]['card'] = json_decode($v['card'], 1);
            }
            Tpl_Smarty::assign('_data', $data[0]);
        }
        Tpl_Smarty::assign('categoryTree', Data_Mysql_Table_Product_Category::getTreeCache());
        Tpl_Smarty::display('OA_Static::new_space/inc/new_space_detail.tpl');
    }

    //跳到添加场地百科
    static function handleNewspacebaike()
    {
        $request = Func_Input::filter(array(
            'space_id' => 'int'
        ), $_REQUEST);
        if (empty($request['space_id'])) {
            Func_Header::back('请刷新后重新提交！');
        }

        //获取所有标签
        $_REQUEST['search_type'] = 2;
        $tag_value = array();
        $tag_result = Api_Demand_Offer_Get_Demand_Tag_List::getTagList();
        if (!empty($tag_result['data'])) {
            foreach ($tag_result['data'] as $k => $v) {
                $tag_value[] = $v['tag_value'];
            }
        }
        Tpl_Smarty::assign('tag_value', $tag_value);
        //
        $vendor_info = Data_Config_Vendor_Attr::all();
        $contacts_city = $vendor_info['attr']['城市'];
        Tpl_Smarty::assign('_contacts_city', $contacts_city);
        Tpl_Smarty::assign('_categories', Data_Mysql_Table_Product_Category::getTreeCache());
        $spacepedia = Data_Mysql_Table_New_Space::select('*', array('id' => $request['space_id']));
        if (!empty($spacepedia[0])) {
            $data['id'] = $spacepedia[0]['id'];
            $data['space_name'] = $spacepedia[0]['space_name'];
            $data['category_id'] = $spacepedia[0]['category_id'];
            $data['addr'] = $spacepedia[0]['addr'];
            $data['attr']['4'] = $spacepedia[0]['area'];
            $data['attr']['46'] = $spacepedia[0]['city'];
            $product['phone'] = $spacepedia[0]['phone'];
            $product['email'] = $spacepedia[0]['email'];
            $product['contacts'] = $spacepedia[0]['contacts'];
            $product['product_name'] = $spacepedia[0]['space_name'];
            $_REQUEST['tab'] = "spacepedia";
        } else {
            $_REQUEST['tab'] = "space_item";
        }
        if (!empty($spacepedia[0]['category_id'])) {
            Tpl_Smarty::assign('_tags_info', Data_Mysql_Table_Product_Category::getTagsInfo($spacepedia[0]['category_id']));
        }
        Tpl_Smarty::assign('_data', $data);
        Tpl_Smarty::assign('_product', $product);
        Tpl_Smarty::display('OA_Static', "spacepedia/old_product_convert_edit.tpl");
    }


//添加场地百科
    static function submitSpacepediaInfo()
    {
        $request = Func_Input::filter(array(
            "space_id" => 'int',
            'product_id' => 'int',
            'data' => 'array',
            'data_i' => 'array',
        ));
        /* if(empty($request['product_id'])){
             Func_Header::back('参数缺失！');
         }*/
        //添加或修改场地百科
        // $request['data']['status']=2;
        $request['data']['space_id'] = '';
        $request['data']['new_id'] = $request['space_id'];
        $return = Api_Spacepedia_Submit::spacepediaInfoSubmit($request['data']);
        if ($return['status'] == 1) {

            //处理提交的标签
            if (!empty($request['data_i']['tags'])) {
                $tags_arr = explode(",", $request['data_i']['tags']);
                unset($request['data_i']['tags']);
                foreach ($tags_arr as $tk => $tv) {
                    //添加标签
                    $tags_id = Api_Demand_Offer_Check_Demand_Tag::getTagID($tv);
                    if ($tags_id) {
                        $request['data_i']['tags'][$tags_id] = 1;
                    } else {
                        continue;
                    }

                }
            }
            $request['data_i']['status'] = 2;
            $request['data_i']['space_id'] = $return['data'];
            $request['data_i']['product_id'] = $request['product_id'];
            $request['data_i']['city'] = $request['data']['attr'][46];
            $return_item = Api_Space_Item_Submit::spaceItemSubmit($request['data_i']);
            if ($return_item) {
                $conditions['id = ?'] = $request['space_id'];
                $page = Data_Mysql_Table_New_Space::update($conditions, array('status' => 1));


                Func_Header::to(' 创建新的场地百科和新的子空间，请等待审核！', '?');
            } else {
                Func_Header::to('创建新的子空间失败！');
            }
        } else {
//            q('http://'.Core::$urls['host'].Core::$urls['path']."?action=details&space_id=".$request['space_id']);
            Func_Header::to($return['msg'], "?action=newspace&space_id=" . $request['space_id']);
            // Func_Header::back($return['msg']);
        }
    }
}