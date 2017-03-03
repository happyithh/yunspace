<?php

/**
 * Created by PhpStorm.
 * User: Administrator
 * Date: 2015/5/28
 * Time: 14:50
 * @ 经纪人 的服务列表
 */
Class App_Api_Broker_Service
{
    //分享头
    public static $_share_head = '推荐您预定';
    //分享小尾巴
    public static $_share_tail = '--【云·Space－活动场地专家】';

    /**
     *  typeId  1 表示  空间场地类型   2. 表示配套服务    3.表示套餐
     *
     * return
     *       "id": "1",
     *       "product_id": "产品的id",
     *       "product_name": 产品名称,
     *      "logo": "http://yun.cc/uploads/275_195/201502/o_19f511mipob3g9lmpv9bg154ol.jpg",
     *       "recommend_charges": 佣金比例
     *
     *      "vendor_name": 供应商名称
     */
    static function getService()
    {
        $request = Func_Input::filter(array(
            'id' => 'int',
            'typeId' => 'int',
        ));
        if (!empty($request['typeId'])) {
            $webConfig = Data_Config_Site::get('service_list');
            $children = Data_Mysql_Table_Product_Category::getChildren($webConfig['space_id']);
            $children[] = $webConfig['space_id'];

            if ($request['typeId'] == 1) {
                $conditions[] = 't1.category_id IN (' . implode(',', $children) . ')';
            } elseif ($request['typeId'] == 2) {
                $conditions[] = 't1.category_id  NOT IN (' . implode(',', $children) . ')';
            }
        }
        if (empty($request['typeId'])) {
            Func_Output::json('error', '', '没有选择分类~');
        }
        if (!empty($request['id'])) {
            $conditions[] = 't1.id <' . $request['id'];
        }
        $conditions[] = "t1.status  =1 ";
        $conditions[] = "t2.recommend_charges  >=1000 && t2.recommend_charges  <10000 ";
        if ($request['typeId'] == 3) {
            $cols = "t1.id,t1.set_name as product_name,t1.logo,t2.recommend_charges,t3.vendor_name";
            $table = "{table} as t1 LEFT JOIN {prefix}product_marketing_set as t2 ON t1.id=t2.id LEFT JOIN {prefix}vendor_info as t3 ON t3.id = t1.vendor_id";
            $data = Data_Mysql_Table_Product_Set::select($cols, $conditions, "ORDER BY t2.id DESC", 10, $table);
        } else {
            $cols = "t1.id,t1.product_name,t1.logo,t2.recommend_charges,t3.vendor_name";
            $table = "{table} as t1 LEFT JOIN {prefix}Product_Marketing as t2 ON t1.id =t2.id LEFT JOIN {prefix}vendor_info as t3 ON t3.id = t1.vendor_id";
            $data = Data_Mysql_Table_Product_Search::select($cols, $conditions, 'ORDER BY t2.id desc', 10, $table);
        }
        if (empty($data[0])) {
            Func_Output::json('error', '', '没有获取到数据~');
        }
        foreach ($data as $key => $val) {
            $data[$key]['recommend_charges'] = ($val['recommend_charges'] / 100) . '%';
            $data[$key]['typeId'] = $request['typeId'];
            if (!empty($val['logo'])) {
                $data[$key]['logo'] = 'http://' . Core::$urls['host'] . Page_Site_Global::displayMedia($val['logo'], 200, 200);
            }
        }
        Func_Output::json('success', $data, '成功获取数据');
    }

    /**
     *
     *
     *
     * return
     * "product_name": 产品,
     * "media": 数组类型，图片的URL,
     * "product_size": 产品面积,
     * "recommend_charges": 佣金比例,
     * "vendor_name": 供应商名称,
     * "addr": 供应商地址
     * "email": 邮箱
     *
     */
    static function getServiceInfo()
    {
        $request = Func_Input::filter(array(
            'id' => 'int',
            'user_id' => 'int',
            'typeId' => 'int'
        ));
        if (empty($request['typeId']) || empty($request['id']) || empty($request['user_id'])) {
            Func_Output::json('error', '', '缺少参数！');
        }
        if ($request['typeId'] == 3) {
            $conditions[] = 't5.id = ' . $request['id'];
            $conditions[] = 't5.status = 1 AND t2.recommend_charges > 0';
            //这个是读取的  product_marketing_set表哦
            $cols = "t5.set_name as product_name,t5.logo,t5.des,t5.set_price as price,t5.media,t1.attr_new,t1.product_size,t2.recommend_charges,t3.vendor_name,t3.addr,t4.email";
            $table = "{prefix}product_set as t5 LEFT JOIN {table} as t1 ON t5.schedule_product_id=t1.id LEFT JOIN {prefix}product_marketing_set as t2 ON t5.id = t2.id LEFT JOIN {prefix}vendor_info as t3 ON t1.vendor_id= t3.id LEFT JOIN {prefix}account as t4 ON t4.id = t3.vendor_account_id";
            $product = Data_Mysql_Table_Product_Info::select($cols, $conditions, '', 1, $table);
        } else {
            $conditions[] = 't1.id = ' . $request['id'];
            $conditions[] = 't1.status = 1 AND t2.recommend_charges > 0';
            $cols = "t1.price,t1.product_name,t1.logo,t1.des,t1.media,t1.attr_new,t1.product_size,t2.recommend_charges,t3.vendor_name,t3.addr,t4.email";
            $table = "{table} as t1  LEFT JOIN {prefix}product_marketing as t2 ON t1.id = t2.id LEFT JOIN {prefix}vendor_info as t3 ON t1.vendor_id= t3.id LEFT JOIN {prefix}account as t4 ON t4.id = t3.vendor_account_id";
            $product = Data_Mysql_Table_Product_Info::select($cols, $conditions, '', 1, $table);
        }
        if (empty($product[0])) {
            Func_Output::json('error', '', '没有获取到数据~');
        }
        if (empty($product[0]["logo"])) {
            $productArray['logo'] = $product[0]['logo'];
            $productArray['media'] = $product[0]['media'];
            $logo = Admin_Search_Product_Search::getLogo($productArray);
            $product[0]["logo"] = 'http://' . Core::$urls['host'] . Page_Site_Global::displayMedia($logo['logo'], 200, 200);
        } else {
            $product[0]["logo"] = 'http://' . Core::$urls['host'] . Page_Site_Global::displayMedia($product[0]["logo"], 200, 200);
        }
        foreach ($product as $key => $val) {
            $product[$key]['des'] = str_replace('src="/', 'src="http://' . Core::$urls['host'] . '/', $product[$key]['des']);
            $product[$key]['product_size'] = intval($val['product_size']) . '平方米';
            $product[$key]['recommend_charges'] = ($val['recommend_charges'] / 100) . '%';
            $product[$key]['activityType'] = '';
            $attr = json_decode($val['attr_new'], 1);
            if (!empty($val['price'])) {
                if ($request['typeId'] == 3) {
                    $product[$key]['price'] = ($val['price']) . '元';
                } else {
                    if ($val['price'] > 0) {
                        $product[$key]['price'] = ($val['price'] / 100) . '元';
                    } else if ($val['price'] == 0) {
                        $product[$key]['price'] = '面议';
                    } else {
                        $tmpPrice = abs(intval($val['price'] / 10000) * 100);
                        $product[$key]['price'] = $tmpPrice . '~' . ($tmpPrice + $tmpPrice / 10) . '元';
                    }
                }
                if (!empty($attr['起价'])) {
                    $product[$key]['price'] .= '起';
                }
            } else {
                $product[$key]['price'] = '面议';
            }
            if (!empty($attr[49])) {
                $product[$key]['activityType'] = $attr[49];
            }
            if (!empty($val['media'])) {
                $val['media'] = json_decode($val['media'], 1);
                $media = '';
                foreach ($val['media'] as $mm => $vv) {
                    $media[] = 'http://' . Core::$urls['host'] . Page_Site_Global::displayMedia($vv['path'], 768, "", 1);
                }
            }
            $product[$key]['append'] = '<p style="color:#f00"><font>价格：</font>' . $product[0]['price'] . '</p>' . '<style>img{max-width: 100%;height:auto!important;} td{width:auto!important;} .cont img{width:auto!important; }</style><p class="cont">' . $product[$key]['des'] . '</p>';
            $product[$key]['media'] = $media;
            unset($media);
            unset($product['attr_new']);
        }
        $product['shareDes'] = mb_substr(strip_tags($val['des']), 0, 1000, 'utf-8');
        $product['shareTitle'] = self::$_share_head . $product[0]['product_name'] . self::$_share_tail;
        $product['shareUrl'] = Data_Mysql_Table_Dwz::getUrl($request['user_id'], $request['id'], $request['typeId'] == 3 ? 2 : 1);
//
        Func_Output::json('success', $product, '成功获取~');
    }

}
