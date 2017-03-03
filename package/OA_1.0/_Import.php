<?php

/**
 * Created by PhpStorm.
 * User: Administrator
 * Date: 2015/4/8
 * @账号管理
 */
Class OA_Import
{


    //批量导入联系人
    static function update_vendor_account_id()
    {
        set_time_limit(0);

//        $vendor_conditions[] = 'id <500';
        $vendor_conditions['vendor_account_id'] = 0;
        $vendor_list = Data_Mysql_Table_Vendor_Info::select('id,categories_id,vendor_name,vendor_account_id,base_info,attr,attr_index', $vendor_conditions, '', '10000');
        echo count($vendor_list);
        $categories = Data_Mysql_Table_Product_Category::getInfoCache();


        foreach ($vendor_list as $kes => $val) {
            $vendor_list[$kes]['base_info'] = json_decode($val['base_info'], 1);
            $vendor_list[$kes]['attr_index'] = json_decode($val['attr_index'], 1);
            $vendor_list[$kes]['attr'] = json_decode($val['attr'], 1);
            //处理手机号
            if (preg_match_all('(\d{11})', $vendor_list[$kes]['base_info']['联系方式'], $a)) {
                $phone = $a[0][0];
            } elseif (preg_match_all('(\d{7,11})', $vendor_list[$kes]['base_info']['联系方式'], $b)) {
                $phone = $b[0][0];
            } else {
                continue;
            }
            //处理categories
            $business = $sub_business = '';
            $catIds = explode(',', $val['categories_id']);
            foreach ($catIds as $catId) {
                if (!empty($categories[$catId])) {
                    $catInfo = $categories[$catId];
                    if ($catInfo[3]) {
                        $business = $catInfo[3] . $categories[$catInfo[3]][0];
                        $sub_business = $catId . $catInfo[0];
                        break;
                    } else {
                        $business = $catId . $catInfo[0];
                        $sub_business = '';
                    }
                }
            }
            $address = array_key_exists('公司地址', $vendor_list[$kes]['base_info']) ? $vendor_list[$kes]['base_info']['公司地址'] : '';
            $scale = array_key_exists('员工总数', $vendor_list[$kes]['attr']) ? $vendor_list[$kes]['attr']['员工总数'] : '';
            $city_string = array_key_exists('城市', $vendor_list[$kes]['attr_index']) ? $vendor_list[$kes]['attr_index']['城市'] : '';
            $city = explode(',', $city_string);
            $username = array_key_exists('主要联系人', $vendor_list[$kes]['base_info']) ? $vendor_list[$kes]['base_info']['主要联系人'] : '';

            //组装基本信息
            $attr_arr = array(
                '基本信息' => array(),
                '联系方式' => array(),
                '公司信息' => array(
                    '所在行业' => '',
                    '从业年数' => '',
                    '公司地址' => $address,
                    '人数规模' => $scale,
                ),
                '其他备注' => $vendor_list[$kes]['base_info']
            );
            $vendor_insert = array(
                'phone' => $phone,
                'company' => $val['vendor_name'],
                'username' => $username,
                'type' => '21',
                'status' => 1,
                'state' => 1,
                'attr' => $attr_arr,
                'account_id' => $val['vendor_account_id'],
                'business' => $business,
                'sub_business' => $sub_business,
                'city' => $city[0]
            );
//            q($vendor_insert);
            Data_Mysql_Table_Contact_Library::insert($vendor_insert);

        }

    }

    //批量导入联系人
    static function update_vendor_info_account_id()
    {
        set_time_limit(0);

//        $vendor_conditions[] = 'id <500';
        $vendor_conditions['vendor_account_id'] = 0;
        $vendor_list = Data_Mysql_Table_Vendor_Info::select('id,categories_id,vendor_name,vendor_account_id,base_info,attr,attr_index', $vendor_conditions, '', '10000');
        echo count($vendor_list);
        $categories = Data_Mysql_Table_Product_Category::getInfoCache();


        foreach ($vendor_list as $kes => $val) {
            $vendor_list[$kes]['base_info'] = json_decode($val['base_info'], 1);
            $vendor_list[$kes]['attr_index'] = json_decode($val['attr_index'], 1);
            $vendor_list[$kes]['attr'] = json_decode($val['attr'], 1);
            //处理手机号
            if (preg_match_all('(\d{11})', $vendor_list[$kes]['base_info']['联系方式'], $a)) {
                $phone = $a[0][0];
            } elseif (preg_match_all('(\d{7,11})', $vendor_list[$kes]['base_info']['联系方式'], $b)) {
                $phone = $b[0][0];
            } elseif (!empty($vendor_list[$kes]['base_info']['公司电话']) && preg_match_all('(\d{7,11})', $vendor_list[$kes]['base_info']['公司电话'], $b)) {
                $phone = $b[0][0];
            } else {
                continue;
            }
            if ($phone) {

            }
            Data_Mysql_Table_Contact_Library::update(array(
                'phone' => $phone,
            ), array(
                'vendor_id' => $val['id'],
            ));

        }

    }

    static function newTags()
    {
        //更新分类中的属性信息
        set_time_limit(0);
        $category = Data_Mysql_Table_Product_Category::getInfoCache();
//        foreach ($category as $key => $value) {
//            if (!empty($value[1])) {
//                $tags_info = array();
//                foreach ($value[1] as $ak => $av) {
//                    $rrv = Data_Mysql_Table_Tags::getTagsId($av['name'], $av['values']);
//                    $tags_info[$rrv]['select'] = '1';
//                }
//                $data['tags_info'] = $tags_info;
//                Data_Mysql_Table_Product_Category::update($key, $data);
//            }
//        }
//        Data_Mysql_Table_Product_Category::updateCache();
        //更新产品服务表中的属性
        $tagsId = array(
            '城市' => 46,
            '适合活动类型' => 49,
            '所属商圈' => 2,
            '行政区域' => 4,
            '轨道交通' => 3,
            '停车位' => 5,
            '层高' => 6,
            '供电量' => 7,
            '人数上限' => 8,
            '餐饮配套' => 51,
            '面积' => 50,
            '使用面积' => 10,
            '服务行业类型' => 9,
            '演出范围' => 36,
            '市场价' => 47,
            '价格单位' => 48,
            '基本信息>适合活动类型' => 49,
            '基本信息>设备类型' => 39,
            '基本信息>服务行业类型' => 9,
            '基本信息>所属商圈' => 2,
            '基本信息>轨道交通' => 3,
            '基本信息>行政区域' => 4,
            '基本信息>停车位' => 5,
            '基本信息>层高' => 6,
            '基本信息>供电量' => 7,
            '基本信息>人数上限' => 8,
            '基本信息>使用面积' => 10,
            '基本信息>场地承重' => 11,
            '基本信息>休息室' => 12,
            '基本信息>化妆间' => 13,
            '基本信息>卫生间' => 14,
            '基本信息>空间吊点' => 15,
            '基本信息>灯具高度' => 16,
            '基本信息>空调暖气' => 17,
            '基本信息>网路WIFI' => 18,
            '基本信息>货运电梯' => 19,
            '基本信息>投影LED' => 20,
            '基本信息>灯光音响' => 21,
            '基本信息>餐饮种类' => 22,
            '基本信息>人均价格（餐饮）' => 23,
            '基本信息>配餐清单' => 24,
            '基本信息>空调费用' => 25,
            '基本信息>接电费' => 26,
            '基本信息>搭建费' => 27,
            '基本信息>人员加班费' => 28,
            '基本信息>物业管理费' => 29,
            '基本信息>进场押金' => 30,
            '基础信息>演出范围' => 36,
            '基本信息>礼仪范围' => 76,
            '基本信息>拍摄类型' => 44,
            '基本信息>拍摄周期' => 45,
            '基本信息>搭建材质' => 31,
            '基本信息>工艺类型' => 32,
            '基本信息>加工方式' => 33,
            '基本信息>搭建面积' => 34,
        );
        $productInfo = Data_Mysql_Table_Product_Info::select('id,attr,attr_new', array('attr is not null and attr_new is null'), '', 999999999);
        $attrKeys = array();
        if (!empty($productInfo)) {
            foreach ($productInfo as $key => $value) {
                $attr = json_decode($value['attr'], 1);
//                $attrKeys += $attr;
//                continue;
                $attrNew = array();
                if (!empty($attr)) {
                    foreach ($attr as $ak => $av) {
                        $akId = $tagsId[$ak];
                        $attrNew[$akId] = $av;
                    }
                    Data_Mysql_Table_Product_Info::update($value['id'], array('attr_new' => $attrNew));
                    Data_Mysql_Table_Product_Info::subTable('_update')->update($value['id'], array('attr_new' => $attrNew));
                }
            }
        }
        //产品表初始化
        Data_Mysql_Table_Product_Info::subTable("_update")->select();
        Data_Mysql_Table_Product_Info::exec('INSERT IGNORE INTO {table}_update (id, category_id, vendor_id,product_name,attr,attr_new,product_size,logo,media,des,addr,status,price, update_time, create_time) SELECT id, category_id, vendor_id,product_name,attr,attr_new,product_size,logo,media,des,addr,status,price, update_time, create_time FROM {table}');
        Data_Mysql_Table_Product_Info::exec('INSERT IGNORE INTO {table} (id, category_id, vendor_id,product_name,attr,attr_new,product_size,logo,media,des,addr,status,price, update_time, create_time) SELECT id, category_id, vendor_id,product_name,attr,attr_new,product_size,logo,media,des,addr,status,price, update_time, create_time FROM {table}_update');

        //供应商表初始化
        Data_Mysql_Table_Vendor_Info::subTable("_update")->select();
        Data_Mysql_Table_Vendor_Info::exec('INSERT IGNORE INTO {table}_update (id, vendor_name, categories_id, attr,vendor_remarks,logo,media,base_info,vendor_account_id,status,des, update_time, create_time) SELECT id,vendor_name, categories_id, attr,vendor_remarks,logo,media,base_info,vendor_account_id,status, des,update_time, create_time FROM {table}');
        Data_Mysql_Table_Vendor_Info::exec('INSERT IGNORE INTO {table} (id, vendor_name, categories_id, attr,vendor_remarks,logo,media,base_info,vendor_account_id,status,des, update_time, create_time) SELECT id,vendor_name, categories_id, attr,vendor_remarks,logo,media,base_info,vendor_account_id,status, des,update_time, create_time FROM {table}_update');
        //活动案例初始化
        Data_Mysql_Table_Event_Case::subTable("_update")->select();
        Data_Mysql_Table_Event_Case::exec('INSERT IGNORE INTO {table}_update (id, event_id, product_id, vendor_id, case_name,des,status) SELECT id, event_id, product_id, vendor_id, case_name,des,status FROM {table}');
        Data_Mysql_Table_Event_Case::exec('INSERT IGNORE INTO {table} (id, event_id, product_id, vendor_id, case_name,des,status) SELECT id, event_id, product_id, vendor_id, case_name,des,status FROM {table}_update');
    }

    static function updateOldCategoryAndProduct()
    {
        $category = Data_Mysql_Table_Product_Category::getTreeCache();
        foreach ($category[0] as $k => $v) {
            if (!empty($category[$k])) {
                foreach ($category[$k] as $vk => $vv) {
                    if (!empty($category[$vk])) {
                        foreach ($category[$vk] as $vvk => $vvv) {
                            self::updateOldCategoryAndProductDo($vvk, $vk);
                            if (!empty($category[$vvk])) {
                                foreach ($category[$vvk] as $vvvk => $vvvv) {
                                    self::updateOldCategoryAndProductDo($vvvk, $vk);
                                }
                            }
                        }
                    }
                    if (!$vv) {
//                        self::updateOldCategoryAndProductDo($vk, $k, 0);
                    }
                }
            }
        }
        Data_Mysql_Table_Product_Category::updateCache();
    }

    static function updateOldCategoryAndProductDo($cid, $newCid, $updateCate = 1)
    {
        Data_Mysql_Table_Product_Info::query('UPDATE {table} SET category_id = ? WHERE category_id = ?', array($newCid, $cid));
        if ($updateCate) {
            Data_Mysql_Table_Product_Category::query('UPDATE {table} SET parent_id=10, status=5 WHERE id = ?', array($cid));
        }
    }

    /*
     *为现有联系人创建账号，同时将现有账户转化为联系人
     */
    static function reverseAccountAndContacts()
    {
        q(1);
        //为现有联系人创建账户
        $contacts = Data_Mysql_Table_Contact_Library::select('id,username,phone,company,type', '', '', 9999999);
        if (!empty($contacts)) {
            foreach ($contacts as $key => $value) {
                $data = array(
                    'fullname' => empty($value['company']) ? $value['username'] : $value['company'],
                    'phone' => $value['phone'],
                    'username' => empty($value['company']) ? $value['username'] . uniqid() : $value['company'],
                    'attr' => array(
                        'register_ip' => Func_Input::ip(),
                        'email' => '',
                        'phone' => $value['phone']
                    ),
                    'account_type' => $value['type'],
                    'password' => Data_Mysql_Table_Account::makePassword($value['phone']),
                    'register_time' => time(),
                );
                $r = Data_Mysql_Table_Account::select('id, phone', array('phone = ?' => array($value['phone'])));
                if (!empty($r[0]['id'])) {
                    Data_Mysql_Table_Contact_Library::update($value['id'], array('account_id' => $r[0]['id']));
                } else {
                    $rs = Data_Mysql_Table_Account::insert($data);
                    if (!empty($rs[0])) {
                        Data_Mysql_Table_Contact_Library::update($value['id'], array('account_id' => $rs[0]));
                    }
                }
            }
        }

        //将现有账户创建为联系人
        $accounts = Data_Mysql_Table_Account::select('id,username,phone,fullname,account_type', '', '', 9999999);
        if (!empty($accounts)) {
            foreach ($accounts as $key => $value) {
                $data = array();
                $data = array(
                    'company' => empty($value['fullname']) ? '' : $value['fullname'],
                    'phone' => $value['phone'],
                    'username' => $value['username'],
                    'type' => $value['account_type'],
                    'account_id' => $value['id'],
                    'city' => $_COOKIE['city'],
                );
                $r = Data_Mysql_Table_Contact_Library::select('id, phone', array('phone = ?' => array($value['phone'])), '', 999);
                if (empty($r)) {
                    Data_Mysql_Table_Contact_Library::insert($data);
                }
            }
        }
    }

    /*
    *将现有空间场地的联系人，分配给指定管理员
    */
    static function allocateContactsToAdmin($adminId)
    {
        q(1);
        Data_Mysql_Table_Contact_Relation::delete(array('admin_id' => $adminId));

        $admin = Data_Mysql_Table_Administrator::select('id, username', $adminId);
        if (empty($admin[0])) {
            Func_Header::back('管理员不存在！！');
        }
        $conditions [] = '{prefix}contact_relation.admin_id IS NULL';
        $conditions ['{table}.business = ?'] = '112空间场地';
        $conditions ['{table}.city = ?'] = '上海';
        $table = "{table} LEFT JOIN {prefix}contact_relation ON {table}.id = {prefix}contact_relation.contact_id";
        $contacts = Data_Mysql_Table_Contact_Library::select('{table}.id', $conditions, '', 9999999, $table);
        if (!empty($contacts)) {
            foreach ($contacts as $key => $value) {
                Data_Mysql_Table_Contact_Relation:: insert(array(
                    'contact_id' => $value['id'],
                    'admin_id' => $adminId,
                    'allocate_time' => time(),
                ));
            }
        }
    }

    /*
    *将批量生成的账号的username换成fullname
    */
    static function changeUsernameToFullname()
    {
        $accounts = Data_Mysql_Table_Account::select('id,username,fullname',array('login_times'=>0),'',999999);
        if (!empty($accounts)) {
            foreach($accounts as $key=>$value){
                Data_Mysql_Table_Account::update($value['id'],array('username'=>$value['fullname']));
            }
        }
    }
    static function outputVendor()
    {
//        error_reporting(0);
        ob_clean();
        $condition['{table}.vendor_account_id!=0 AND {prefix}contact_library.business!=?'] = '112空间场地';
        $cols = "{table}.id,{table}.vendor_name,{table}.categories_id,{table}.des,{table}.addr,{prefix}contact_library.username,{prefix}contact_library.phone,{prefix}contact_library.business,{prefix}contact_library.sub_business";
        Data_Mysql_Table_Vendor_Info::debug(1);
        $list = Data_Mysql_Table_Vendor_Info::select($cols, $condition, "GROUP BY {table}.id", 10000, "{table} LEFT JOIN {prefix}contact_library ON {table}.vendor_account_id = {prefix}contact_library.account_id");
        die();
        $title = array('公司名称', '联系人', '联系电话', '公司地址', '服务类型', '服务类型2', '公司简介');
        $data = array();
        foreach ($list as $k => $v) {
            $data[$k][] = $v['vendor_name'];
            $data[$k][] = $v['username'];
            $data[$k][] = $v['phone'];
            $data[$k][] = $v['addr'];
            $data[$k][] = $v['business'];
            $data[$k][] = $v['sub_business'];
            $data[$k][] = (strip_tags($v['des']));
        }
        Func_Csv::writeRow($title, $data, "所有供应商信息");
        return;
    }
    /*
     *批量更新供应商的city
     */
    static function changeVendorInfoCity()
    {
        //更新update表的city字段
        $data = Data_Mysql_Table_Vendor_Info::subTable('_update')->select('id,attr','','',999999999);
        foreach($data as $k=>$v){
            if(!empty($v['attr'])){
                $attr=json_decode($v['attr'],1);
                $city=empty($attr['城市'])?"上海":$attr['城市'];
            }else{
                $city="上海";
            }
           Data_Mysql_Table_Vendor_Info::subTable('_update')->update(array('id'=>$v['id']),array('city'=>$city));
        }

        //更新info表的city字段
        $data = Data_Mysql_Table_Vendor_Info::select('id,attr','','',999999999);
        foreach($data as $k=>$v){
            if(!empty($v['attr'])){
                $attr=json_decode($v['attr'],1);
                $city=empty($attr['城市'])?"上海":$attr['城市'];
            }else{
                $city="上海";
            }
            Data_Mysql_Table_Vendor_Info::update(array('id'=>$v['id']),array('city'=>$city));
        }
    }
    /*
    *批量将案例数据导入活动攻略
    */
    static function convertEventCaseToRaiders()
    {
        $cols='{table}.case_name,{table}.status,{table}.des as case_des, {table}.product_id,{table}.product_set_id,{table}.media as case_media,
        t2.category_id,t2.attr,t2.media as event_media,t2.des as event_des,t2.logo,t2.counter_view,t2.counter_follow ';
        $table='{table} LEFT JOIN {prefix}event_info as t2 ON {table}.event_id = t2.id ';
        $event = Data_Mysql_Table_Event_Case::select($cols, '', '',9999999, $table);
        $raider_data=array();
        foreach ($event as $k => $v) {
            $raider_data['title']=$v['case_name'];
//            $raider_data[$k]['status']=$v['status'];
            $raider_data['status']=2;   //待审核
            $raider_data['counter_view']=empty($v['counter_view'])?100:$v['counter_view'];
            $raider_data['counter_praise']=empty($v['counter_follow'])?100:$v['counter_follow'];
            $raider_data['from_where']=100;   //1 手动录入    2 自动采集  100 案例转换


            //处理案例描述
            $des=empty($v['case_des'])?$v['event_des']:$v['case_des'];
            $raider_data['des']= mb_substr(trim(strip_tags($des)),0,100,'utf-8');
            if(!empty($v['product_id'])){
                //获取上线的场地
                $product=Data_Mysql_Table_Product_Info::select('id,product_name',array("id"=>$v['product_id'],'status'=>1));
            }
            if(!empty($v['product_set_id'])){
                //获取上线的套餐
                $set=Data_Mysql_Table_Product_Set::select('id,set_name',array("id"=>$v['product_set_id'],'status'=>1));
            }
            if((!empty($product[0]) && !empty($product[0]['product_name'])) || (!empty($set[0]) && !empty($set[0]['set_name']))){
                $des.="<p>相关场地/套餐链接&nbsp;:&nbsp;";
                if(!empty($product[0]) && !empty($product[0]['product_name'])){
                    $des.="<a target='_blank' href='http://www.yunspace.com.cn/service_info/".$product[0]['id'].".html'>".$product[0]['product_name']."</a><br/>";
                }
                if(!empty($set[0]) && !empty($set[0]['set_name'])){
                    $des.="<a target='_blank' href='http://www.yunspace.com.cn/set_info/".$set[0]['id'].".html'>".$set[0]['set_name']."</a><br/>";
                }
                $des.='</p>';
            }
            $raider_data['cont']=$des;


            //处理图片数组
            $media=empty($v['case_media'])?$v['event_media']:$v['case_media'];
            if (!empty($media)) {
                $raider_data['media'] = json_decode($media, 1);
                foreach ($raider_data['media'] as $mk => $mv) {
                    $raider_data['logo'] = empty($mv['path'])?"":$mv['path'];
                    //主图
                    if (!empty($mv['tags']) && !empty($mv['path']) && strpos($mv['tags'], '@主图') !== false) {
                        $raider_data['logo'] = $mv['path'];
                        break;
                    }
                }
            }


            //处理城市和分类
            if(!empty($v['attr'])){
                $attr=json_decode($v['attr'],1);
            }
            $raider_data['city'] = empty($attr['城市'])?"":$attr['城市'];

//            '活动类型' =>
//            array (size=20)
//              0 => string '商业发布' (length=12)
//              1 => string ' 展览展示' (length=13)
//              2 => string ' 文体娱乐' (length=13)
//              3 => string ' 会议会务' (length=13)
//              4 => string ' 新品发布会' (length=16)
//              5 => string ' 行业博览会' (length=16)
//              6 => string ' 演场演出' (length=13)
//              7 => string ' 宴会会议' (length=13)
//              8 => string ' 体验品鉴会' (length=16)
//              9 => string ' 艺术品展出' (length=16)
//              10 => string ' 颁奖晚会/盛典' (length=20)
//              11 => string ' 培训演讲' (length=13)
//              12 => string ' 推广路演' (length=13)
//              13 => string ' 主题展览' (length=13)
//              14 => string ' 主题派对' (length=13)
//              15 => string ' 晚会年会' (length=13)
//              16 => string ' 时尚走秀' (length=13)
//              17 => string ' 动漫游戏' (length=13)
//              18 => string ' 亲子活动' (length=13)
//              19 => string ' 户外拓展' (length=13)

            $array1=array(0,1,4,5,6,9,11,12,13,17,18,19);     //  id=20   发布会/路演/展览
            $array2=array(2,7,8,10,15);     //  id=21   典礼/晚会/年会
            $array3=array(14,16);     //  id=5   派对/沙龙
            $array4=array(3);     //  id=24   会议/讲座

            if(in_array($v['category_id'],$array1)){
                $raider_data['category_id'] = 20;
            }elseif(in_array($v['category_id'],$array2)){
                $raider_data['category_id'] = 21;
            }elseif(in_array($v['category_id'],$array3)){
                $raider_data['category_id'] = 5;
            }elseif(in_array($v['category_id'],$array4)){
                $raider_data['category_id'] = 24;
            }else{
                $raider_data['category_id'] = 20;
            }
            $raider_data['create_time'] =strtotime("2015-03-16 13:20:56");
            $raider_data['update_time'] =strtotime("2015-03-20 13:20:56");
            //放入待审核中
//            Data_Mysql_Table_Product_Info::exec('INSERT IGNORE INTO {table} (title,status,counter_view,counter_praise,from_where,des,cont,media,logo,city,category_id,category_time,update_time) values ($raider_data["title"],$raider_data["status"],$raider_data["counter_view"],$raider_data["counter_praise"],$raider_data["from_where"],$raider_data["des"],$raider_data["cont"],$raider_data["media"],$raider_data["logo"],$raider_data["city"],category_id,category_time,update_time)');
            Data_Mysql_Table_Raiders_Info::subTable('_update')->insert($raider_data);
        }
    }

    //处理采集的地址中有「」的场地数据
    static function handleProductAddr(){
        $rs_product=$rs_product_update=array();
        //处理场地
        $condition[]='addr like "%「%」%"';
        $rs_product=Data_Mysql_Table_Product_Info::select('id,product_name,addr',$condition,'',50);
        foreach($rs_product as $k=>$v){
            $addr=substr($v['addr'],0,strpos($v['addr'],"「"));
            Data_Mysql_Table_Product_Info::query("UPDATE {table} SET addr = ? WHERE id = ?",array($addr,$v['id']),1);
        }
        $rs_product_update=Data_Mysql_Table_Product_Info::subTable('_update')->select('id,product_name,addr',$condition,'',50);
        foreach($rs_product_update as $k=>$v){
            $addr=substr($v['addr'],0,strpos($v['addr'],"「"));
            Data_Mysql_Table_Product_Info::query("UPDATE {table}_update SET addr = ? WHERE id = ?",array($addr,$v['id']),1);
        }
    }

    //处理采集的地址中有「」的供应商数据
    static function handleVendorAddr(){
        $rs_vendor=$rs_vendor_update=array();
        //处理场地
        $condition[]='addr like "%「%」%"';
        $rs_vendor=Data_Mysql_Table_Vendor_Info::select('id,vendor_name,addr',$condition,'',50);
        foreach($rs_vendor as $k=>$v){
            $addr=substr($v['addr'],0,strpos($v['addr'],"「"));
            Data_Mysql_Table_Vendor_Info::query("UPDATE {table} SET addr = ? WHERE id = ?",array($addr,$v['id']),1);
        }
        $rs_vendor_update=Data_Mysql_Table_Vendor_Info::subTable('_update')->select('id,vendor_name,addr',$condition,'',50);
        foreach($rs_vendor_update as $k=>$v){
            $addr=substr($v['addr'],0,strpos($v['addr'],"「"));
            Data_Mysql_Table_Vendor_Info::query("UPDATE {table}_update SET addr = ? WHERE id = ?",array($addr,$v['id']),1);
        }
    }

    //将现有场地百科数据放入history表中
    static function insertHistoryBySpacepediaData(){
        $data=Data_Mysql_Table_Spacepedia::select('*','','',10);
//        q($data);
        foreach($data as $k=>$v){
            if(!empty($v['attr'])){
                $create_history['data_backup']['attr'] = json_decode($v['attr'],1);
                $create_history['data_backup']['city'] = $create_history['data_backup']['attr'][46];
            }
            $create_history['data_backup']['space_name'] = $v['space_name'];
            $create_history['data_backup']['nickname'] = $v['nickname'];
            $create_history['data_backup']['category_id'] = $v['category_id'];
            $create_history['data_backup']['vendor_id'] = $v['vendor_id'];
            $create_history['data_backup']['addr'] = $v['addr'];
            $create_history['data_backup']['des'] = $v['des'];
            $create_history['data_backup']['logo'] = $v['logo'];
            $create_history['data_backup']['media'] = empty($v['media'])?"":json_decode($v['media'],1);
            $create_history['data_backup']['space_id'] = $v['id'];
            $create_history['object_id'] = $v['id'];
            $create_history['admin_id'] = 87;
            $create_history['create_time'] = time();
            $create_history['status'] = $v['status'];
            Data_Mysql_Table_History::subTable('_baike_' . date("Ym"))->insert($create_history);
        }

    }

    //脚本，更新百科历史表中object_id为0的数据
    static function updateHistoryObjectId(){
        $history=Data_Mysql_Table_History::subTable('_baike_' . date("Ym"))->select('id,object_id,data_backup',array('object_id'=>0),'',1000);
        if(!empty($history)){
            foreach($history as $k=>$v){
                if(!empty($v['data_backup'])){
                    $data_backup=json_decode($v['data_backup'],1);
                    $space_name=$data_backup['space_name'];
                    $data_spacepedia=Data_Mysql_Table_Spacepedia::select('id,space_name',array('space_name'=>$space_name));
                    if(!empty($data_spacepedia[0])){
                        $update_data['object_id']=$data_spacepedia[0]['id'];
                        $update_data['data_backup']=$data_backup;
                        $update_data['data_backup']['space_id']=$data_spacepedia[0]['id'];
                        Data_Mysql_Table_History::subTable('_baike_' . date("Ym"))->update(array('id'=>$v['id']),$update_data);
                    }
                }
            }
        }
    }

    //脚本，更新现有云发现的关键词
    static function updateRaidersTagsInfo(){
        $data=Data_Mysql_Table_Raiders_Info::select('id,tags_info','','',5000);
        foreach($data as $k=>$v){
            if(!empty($v['tags_info'])){
                $tags_info=json_decode($v['tags_info'],1);
                if(!is_array($tags_info)){
                    $tags_info=array();
                }
                if($tags_info){
                    if(strpos($tags_info[0],",")){
                        $arr=explode(",",$tags_info[0]);
                        Data_Mysql_Table_Raiders_Info::update(array("id"=>$v['id']),array('tags_info'=>$arr));
                    }
                }

            }
        }
    }

    //脚本，一键审核所有场地百科
    static function passAllSpacepedia(){
        $tmp_date=date("Ym");
        //切割出年份
        $tmp_year=substr($tmp_date,0,4);
        //切割出月份
        $tmp_mon =substr($tmp_date,4,2);
        $tmp_forwardmonth[0]=mktime(0,0,0,$tmp_mon-1,1,$tmp_year);
        $tmp_forwardmonth[1]=mktime(0,0,0,$tmp_mon-2,1,$tmp_year);
        $month=empty($_REQUEST['monthdate'])?$tmp_date:$_REQUEST['monthdate'];
        $condition['{table}.status = ?'] = 0;
        $limit=empty($_REQUEST['limit'])?20:$_REQUEST['limit'];
        $data = Api_Spacepedia_List_And_Info::getHistory($condition,$month,$limit);
        if(!empty($data['rows'])){
            foreach($data['rows'] as $k=>$v){
                $data['status'] = 1;
                $data['history_id'] = $v['id'];
                $data['month'] = $month;
                Api_Spacepedia_Submit::spacepediaInfoAudit($data);
            }
        }
    }
}