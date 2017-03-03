<?php
/**
 * Created by PhpStorm.
 * User: adu
 * Date: 2015/12/17
 * Time: 10:36
 * 场地库
 */
class Web_Search_Space_New extends Web_Global{
    function seo(){
        $title_inc = '场地库';
        if(isset($this->request['city_key'])){
            $title_inc .=Web_Space_Search::$city_name[$this->request['city_key']];
        }
        if(isset($this->request['filter'][9])){
            $title_inc .='-'.$this->request['filter'][9];
        }
        if(isset($this->request['filter'][49])){
            $title_inc .='-'.$this->request['filter'][49];
        }
        if(isset($this->request['category_id'])){
            $title_inc .='-'.Data_Mysql_Table_Spacepedia::getCategoryNameById($this->request['category_id']);
        }
        if(!empty($this->request['keyword'])){
            if($this->request['keyword']){
                $title_inc .='-'.$this->request['keyword'];
            }
            $title =$title_inc."相关场地,全国活动场地库-【云SPACE】";
        }else{
            if($title_inc){
                $title = $title_inc."相关场地,全国活动场地库-【云SPACE】";
            }else{
                $title = "全国活动场地库-【云SPACE】";
            }
        }
        return array(
            '网页标题'=>$title,
            '网页简介'=>"云SPACE是专业的活动场地预订、租赁平台。为您提供上海、北京、广州、深圳、成都、杭州、南京、苏州等一二线城市活动场地,年会场地,购物中心,秀场,商场,loft空间,适合开办特卖,试乘试驾,走秀,高级定制,沙龙,集客等活动的特价活动空间。举办路演、推广活动、发布会选址是关键.一键直达,专业的服务,精准的报价,轻松搞定",
            '网页关键词'=>"云SPACE,活动场地,北京活动场地,上海活动场地,场地租赁,秀场租赁,路演场地,发布会场地,年会场地",
        );
    }

    function __construct()
    {
        $this->topCategoryId;
    }

    //默认值
    function  webConfig()
    {
        return Data_Config_Site::get('service_list');
    }

    //接受REQUEST 过的值
    function  request()
    {
        $request = Func_Input::filter(array(
            'keyword' => 'string',
            'category_id' => 'int',
            'filter' => 'array',
            'size_range' => 'int',
            'orderBy' => 'int',
            'nearbymi' => 'string',   //附近距离
            'baidu_lng' => 'string',  //坐标点
            'baidu_lat' => 'string',  //坐标点
            "activity" => "string",   //活动类型
            "industry" => "string",   //适合行业
            "adminarea" => "string",   //行政区域
            "businesscircle" => "string",   //商圈
            'city_key'=> "string",
        ), $_REQUEST);
//        foreach($request as $k=>$v){
//            if(!empty($v)&&!is_array($v)){
//                $request[$k]= Func_String::RemoveXSS($v);
//            }
//            if(!empty($v)&&is_array($v)){
//                $v_tmp = array_map(function ($val) {
//                    $val= Func_String::RemoveXSS($val);
//                    return $val;
//                }, $v);
//                $request[$k]= $v_tmp;
//            }
//        }
//        if (!empty($request['activity'])) {
//            $request['filter'][49] = $request['activity'];
//        }
//        if (!empty($request['industry'])) {
//            $request['filter'][9] = $request['industry'];
//        }
//        if (!empty($request['adminarea']) && !isset($request['nearbymi']) && !isset($request['businesscircle'])) {
//            $request['filter'][4] = $request['adminarea'];
//        }
//        if (!empty($request['businesscircle']) && !isset($request['nearbymi']) && !isset($request['adminarea'])) {
//            $request['filter'][2] = $request['businesscircle'];
//        }
        if (!empty($request['filter'])) {
            foreach ($request['filter'] as $k => $v) {
                if ($v == 'all') {
                    unset($request['filter'][$k]);
                }
            }
        }
        return $request;
    }

    //城市tags  id
    function  cityId()
    {
        $cityId = Page_Site_Global::tagsName('城市');
        return $cityId;
    }

    //分类categoryId
    function  categoryId()
    {

        if (!empty($this->request['category_id'])) {
            $categoryId = $this->request['category_id'];
        } elseif (is_numeric(Core::$urls['action'])) {
            $categoryId = Core::$urls['action'];
        } else {
            $categoryId = 0;
        }
        return $categoryId;
    }

    //条件
    function  conditions()
    {
        $conditions = array(
            '{table}.status=?' => 1,
        );
        $request = $this->request;
        $categoryId = $this->categoryId;
        $webConfig = $this->webConfig;
        $cityId = $this->cityId;
        $request['keyword'] = trim($request['keyword']);
        if (!empty($request['keyword'])) {
            $conditions['space_name'] = $request['keyword'];
            Data_Mysql_Table_Search_Logm::searchLog($request['keyword'],'site_space');
        }
        if (!empty($request['filter'])) {
            $conditions['attr'] = array();
            foreach ($request['filter'] as $k => $v) {
                $conditions['attr'][$k] = '+' . trim($v);
            }
        }
        if(!empty($request['city_key'])&&!empty($this->getCityArr[$request['city_key']])){
            $conditions['attr'][$cityId] = '+' . $this->getCityArr[$request['city_key']].',全国';
        }

        //分类
        if(!empty($request['category_id'])){
            $conditions['{table}.category_id=?'] = $request['category_id'];
        }else{
            $children = Data_Mysql_Table_Spacepedia::getChildren(112);
            $children[] = 112;
            $conditions[] = '{table}.category_id in (' . implode(',', $children) . ') ';
        }
        //面积筛选
        if (!empty($request['size_range'])) {
            $product_size = $request['size_range'];
            switch ($product_size) {
                case 1:
                    $conditions[] = '{table}.size < 200';
                    break;
                case 200:
                    $conditions[] = '{table}.size >=200 and  {table}.size <= 500';
                    break;
                case 500:
                    $conditions[] = '{table}.size >=500 and  {table}.size <= 800';
                    break;
                case 800:
                    $conditions[] = '{table}.size >=800 and  {table}.size <= 1000';
                    break;
                case 1000:
                    $conditions[] = '{table}.size >=1000 and  {table}.size <= 2000';
                    break;
                case 2000:
                    $conditions[] = '{table}.size > 2000';
                    break;
                default :
                    '';
                    break;
            }
        }
//        if (!empty($request['nearbymi']) && !empty($request['baidu_lng']) && !empty($request['baidu_lat']) && !isset($request['adminarea']) && !isset($request['businesscircle'])) {
//            $request['baidu_lng'] = (float)$request['baidu_lng'] * 1000;
//            $lng = substr($request['baidu_lng'], 0, 6);
//            $request['baidu_lat'] = (float)$request['baidu_lat'] * 1000;
//            $lat = substr($request['baidu_lat'], 0, 5);
//            switch ($request['nearbymi']) {
//                case 1:
//                    $conditions[] = "geo_lat < " . ($lat + 0.5 * 10.4) . " and geo_lat > " . ($lat - 0.5 * 10.4);
//                    $conditions[] = "geo_lng < " . ($lng + 0.5 * 10.4) . " and geo_lng > " . ($lng - 0.5 * 10.4);
//                    break;
//                case 2:
//                    $conditions[] = "geo_lat < " . ($lat + 1 * 10.4) . " and geo_lat > " . ($lat - 1 * 10.4);
//                    $conditions[] = "geo_lng < " . ($lng + 1 * 10.4) . " and geo_lng > " . ($lng - 1 * 10.4);
//                    $conditions[] = "(geo_lat >= " . ($lat + 0.5 * 10.4) . " OR geo_lat <= " . ($lat - 0.5 * 10.4) . ')';
//                    $conditions[] = "(geo_lng >= " . ($lng + 0.5 * 10.4) . " OR geo_lng <= " . ($lng - 0.5 * 10.4) . ')';
//                    break;
//                case 3:
//                    $conditions[] = "geo_lat < " . ($lat + 2 * 10.4) . " and geo_lat > " . ($lat - 2 * 10.4);
//                    $conditions[] = "geo_lng < " . ($lng + 2 * 10.4) . " and geo_lng > " . ($lng - 2 * 10.4);
//                    $conditions[] = "(geo_lat >= " . ($lat + 1 * 10.4) . " OR geo_lat <= " . ($lat - 1 * 10.4) . ')';
//                    $conditions[] = "(geo_lng >= " . ($lng + 1 * 10.4) . " OR geo_lng <= " . ($lng - 1 * 10.4) . ')';
//                    break;
//                case 4:
//                    $conditions[] = "geo_lat < " . ($lat + 4 * 10.4) . " and geo_lat > " . ($lat - 4 * 10.4);
//                    $conditions[] = "geo_lng < " . ($lng + 4 * 10.4) . " and geo_lng > " . ($lng - 4 * 10.4);
//                    $conditions[] = "(geo_lat >= " . ($lat + 2 * 10.4) . " OR geo_lat <= " . ($lat - 2 * 10.4) . ')';
//                    $conditions[] = "(geo_lng >= " . ($lng + 2 * 10.4) . " OR geo_lng <= " . ($lng - 2 * 10.4) . ')';
//                    break;
//                case 5:
//                    $conditions[] = "geo_lat < " . ($lat + 10 * 10.4) . " and geo_lat > " . ($lat - 10 * 10.4);
//                    $conditions[] = "geo_lng < " . ($lng + 10 * 10.4) . " and geo_lng > " . ($lng - 10 * 10.4);
//                    $conditions[] = "(geo_lat >= " . ($lat + 4 * 10.4) . " OR geo_lat <= " . ($lat - 4 * 10.4) . ')';
//                    $conditions[] = "(geo_lng >= " . ($lng + 4 * 10.4) . " OR geo_lng <= " . ($lng - 4 * 10.4) . ')';
//                    break;
//                default :
//                    '';
//                    break;
//            }
//        }
        return $conditions;
    }


    //
    function  categoryTree()
    {
        $webConfig = $this->webConfig;
        $categoryTree = Data_Mysql_Table_Product_Category::getTreeCache();
        unset($categoryTree[0][$webConfig['space_id']], $categoryTree[0][93], $categoryTree[0][10], $categoryTree[0][140], $categoryTree[0][3], $categoryTree[0][135]);
        return $categoryTree;
    }

    //活动类型
    static function  getActiveType(){
//       $active_type_array= Data_Mysql_Table_Cache_Array::get('_space_category','active_type');
//        if($active_type_array){
//            return $active_type_array;
//        }else{
            $vendor_attr =  Data_Config_Vendor_Attr::get('attr');
            $new_active_type_array =$vendor_attr['活动类型'];
//            Data_Mysql_Table_Cache_Array::set('_space_category','active_type',$new_active_type_array,3600*24*7);
            return $new_active_type_array;
//        }
    }

    //行业类型
    function  getIndustryType(){
        $industry_type_array= Data_Mysql_Table_Cache_Array::get('_space_category','industry_type');
        if($industry_type_array){
            return $industry_type_array;
        }else{
            $new_industry_type_array = array();
            $list = Data_Mysql_Table_Spacepedia_Search::select("id,attr",array('status=?'=>1),'ORDER BY level DESC',200);
            foreach($list as $k=>$v){
                $v['attr']=json_decode($v['attr'],1);
                if(!empty($v['attr'][9])&& !in_array($v['attr'][9],$new_industry_type_array)){
                    $new_industry_type_array[] = $v['attr'][9];
                }
            }
            Data_Mysql_Table_Cache_Array::set('_space_category','industry_type',$new_industry_type_array,3600*24*7);
            return $new_industry_type_array;
        }
    }

    //城市，行政区域
    function  getCityArr(){
        return Web_Space_Search::$city_name;
    }

    function getAreas($city){
        if(empty($city)){
            $city = empty($_REQUEST['city_key'])?'':$_REQUEST['city_key'];
        }
        $cityArray = $this->getCityArr();
        if(!empty($cityArray[$city])){
           $areaArray =  Data_Mysql_Table_Cache_Array::get('_space_category',$cityArray[$city]);
            if(!empty($areaArray)){
                return $areaArray;
            }else{
                $new_area_array = array();
                $list = Data_Mysql_Table_Spacepedia_Search::select("id,attr",array('city=?'=>$cityArray[$city],'status=?'=>1),'ORDER BY level DESC',200);
                foreach($list as $k=>$v){
                    $v['attr']=json_decode($v['attr'],1);
                    if(!empty($v['attr'][4])&& !in_array($v['attr'][4],$new_area_array)){
                        $new_area_array[] = $v['attr'][4];
                    }
                }
                Data_Mysql_Table_Cache_Array::set('_space_category',$cityArray[$city],$new_area_array,3600*24*7);
               return $new_area_array;
            }
        }else{
            return array();
        }
    }


    //百科类型
    function  getBaiKeCategory($cid=112){
        $category_name_array = Data_Mysql_Table_Spacepedia::$category_name;
        $new_category_name_array  = array();
        foreach($category_name_array as $k=>$v){
            if($v['parent']==$cid){
                $new_category_name_array[$v['id']] = $v['name'];
            }
        }
        return $new_category_name_array;
    }

    //面积范围

    function  getSizeRange(){
        $product_size = array(
            1 => '小于200㎡',
            200 => '200-500㎡',
            500 => '500-800㎡',
            800 => '800-1000㎡',
            1000 => '1000-2000㎡',
            2000 => '2000㎡以上',
        );
        return $product_size;
    }




    //标签id
    function  tagsName()
    {
        $global = Page_Site_Global::getInstance();
        return $global->tags;
    }

    //返回给页面的筛选条件
    function filterString()
    {
        $filterString = http_build_query($this->request);
        return $filterString . '&';
    }



    //、执行查询返回数据     地图页面
    function getMapList()
    {
        $conditions = $this->conditions;
        $order = 'ORDER BY update_time DESC';

        $list = Data_Mysql_Table_Product_Search::page(0, 100, "id, category_id, vendor_id,geo_lat,geo_lng, product_name, attr_index, logo, addr, update_time", $conditions, $order);
        if (!empty($list['rows'])) {
            foreach ($list['rows'] as $k => $v) {
                $list['rows'][$k]['attr_index'] = json_decode($v['attr_index'], 1);
                if (!empty($v['logo'])) {
                    $logo = Page_Site_Global::displayMedia($v['logo'], 275, 195);
                } else {
                    $logo = 'images/map1.jpg';
                }
                $list['rows'][$k]['logo'] = $logo;
            }

        }
        return $list;
    }

    //执行查询返回数据      搜索页面
    function  getSpaceList()
    {
        $conditions = $this->conditions;
        $webConfig = $this->webConfig;
        $request = $this->request;
        //排序方式
        switch ($request['orderBy']) {
            case '2':
                $order = 'ORDER BY {table}.update_time DESC';
                break;
            case '3':
                $order = 'ORDER BY {table}.level DESC';
                break;
            default:
                $order = 'ORDER BY {table}.order_index DESC';
                break;
        }

        //查询数据库
//        Data_Mysql_Table_Spacepedia_Search::debug(1);
        $table='{table}  left join {prefix}baike_statistical  as tb2 ON tb2.space_id={table}.id';
        $list = Data_Mysql_Table_Spacepedia_Search::page(0, 8, "{table}.*,tb2.click as n_click", $conditions, $order,$table);
//        Data_Mysql_Table_Spacepedia_Search::getlastsql(1);
        if (!empty($list['rows'])) {
            foreach ($list['rows'] as $k => $v) {
//                $list['rows'][$k]['price'] = $list['rows'][$k]['price'] > 10000 ? $list['rows'][$k]['price'] / 100 : 0;
                $list['rows'][$k]['attr'] = json_decode($v['attr'], 1);
                $list['rows'][$k]['media'] = array();
                if(strstr($v['price_unit'],'/')==false){
                    $list['rows'][$k]['price_unit']='元/'.$v['price_unit'];
                }
                $list['rows'][$k]['price'] = $v['min_price'];
            }
//            Data_Mysql_Table_Search_Log::searchLog($request['keyword'], $request['filter'], $list['page']['dt']);
        }
        return $list;
    }

    static function getRandList()
    {
        $rand = mt_rand(1, 8000);
        $conditions = array(
            'id<?' => $rand,
            'status=?' => 1,
        );

        //查询数据库

//        Data_Mysql_Table_Product_Search::debug(1);
        $list = Data_Mysql_Table_Product_Search::select("id, category_id, vendor_id,vendor_name, product_name, attr_index, logo, addr, update_time, price", $conditions, 'ORDER BY id DESC', 3);

        if (!empty($list)) {
            foreach ($list as $k => $v) {
                $list[$k]['price'] = $list[$k]['price'] > 10000 ? $list[$k]['price'] / 100 : 0;
                $list[$k]['attr_index'] = json_decode($v['attr_index'], 1);
                $list[$k]['media'] = array();
            }
        }
        return $list;
    }


    //返回给页面拼接后的URL
    static  function concatUrlTags($tag_no, $tag_name = '')
    {
        $preuri = '/spaces-';  //拿到Uri前缀
        $uri = str_replace($preuri, '', urldecode(Core::$urls['uri']));     //去除前缀，避免匹配到Action数字
        $uri_arr = explode('?', $uri);      //标签显示过滤掉Uri中的面积 ?size_range=200
        $uri_arr = explode('/', $uri_arr[0]);
        $tag_arr = explode('-', $uri_arr[0]);
//        preg_match_all('/-(49|9|4|2+)+/i', $uri, $tag_nos);
        if (array_key_exists($tag_arr[0], Web_Space_Search::$city_name)) {
            array_shift($tag_arr);
        }
        array_pop($tag_arr);
        $sps =new Web_Search_Space_New();
        if(!empty($tag_arr)&&array_key_exists($tag_name, $sps->getCityArr())&&array_key_exists($tag_arr[0], $sps->getCityArr())){
            array_pop($tag_arr);
        }
        $ch_arr = explode('-', $uri_arr[1]);
        if (!empty($uri_arr[2]) && preg_match("/([\x{4e00}-\x{9fa5}]+)/u", $uri_arr[2])) {     //匹配中文  颁奖晚会/盛典
            $chs_arr = array_slice($uri_arr, 1, 2);
            $chs = implode('/', $chs_arr);
            $ch_arr = explode('-', $chs);
        }

        $ch_chars = array_map(function ($val) {
            $val= trim(Func_String::utf8(urldecode(trim($val))));
//            $val= Func_String::RemoveXSS($val);
            return $val;
        }, $ch_arr);
        if(count($tag_arr)<count($ch_chars)){
            if(count($ch_chars)-count($tag_arr)>1){
                $_REQUEST['keyword'] = array_pop($ch_chars);
            }
            $ch_chars = array_slice($ch_chars,0,count($tag_arr));
        }
        $tag_array = @array_combine($tag_arr, $ch_chars);
        $tag_name = self::urlEncodeTags(Func_String::utf8(trim($tag_name)));   //URL加密每个标签名
        if (strpos(urldecode($tag_name), '/') !== false) {    //颁奖晚会/盛典
            list($tagl, $tagr) = explode('/', urldecode($tag_name));    //取出两边,加密后再拼接
            $tag_name = self::urlEncodeTags(Func_String::utf8(trim($tagl))) . '/' . self::urlEncodeTags(Func_String::utf8($tagr));
        }
        if($tag_no=='city'){
            if (array_key_exists($tag_name, $sps->getCityArr())) {
//                $city_key = $tag_name;
//                setcookie('city', $_REQUEST['cities'][$tag_name], time() + 60 * 60 * 24 * 30, '/');        //更新城市
//                setcookie('city_key', $tag_name, time() + 60 * 60 * 24 * 30, '/');        //更新城市
//                $_COOKIE['city'] = $_REQUEST['cities'][$tag_name];
//                $_COOKIE['city_key'] = $tag_name;
                $suburi = "spaces-".$tag_name;
                if($tag_name!=$_REQUEST['city_key']){
                    if(isset($tag_array[4])){
                        unset($tag_array[4]);
                    }
                }
            }
            if(empty($tag_name)){
                unset($tag_array[4]);
                $suburi = "spaces";
            }
        }else{
            if(!empty($tag_name)){
                unset($tag_array[$tag_no]);
                $tag_array[$tag_no] = $tag_name;
            }else{
                unset($tag_array[$tag_no]);
            }
            if($_REQUEST['city_key']){
                $suburi =  "spaces-".$_REQUEST['city_key'];
            }else{
                unset($tag_array[4]);
                $suburi =  "spaces";
            }
        }
        $tag_keys = array_keys($tag_array);
        $tag_value = array_values($tag_array);
        if(!empty($_REQUEST['keyword'])&&$tag_keys){
            $suburi .= '-' .implode('-', $tag_keys)."-tags/".implode('-', $tag_value)."-".$_REQUEST['keyword'];
        }
        if(empty($_REQUEST['keyword'])&&$tag_keys){
            $suburi .= '-' .implode('-', $tag_keys)."-tags/".implode('-', $tag_value);
        }
        if(empty($_REQUEST['keyword'])&&!$tag_keys){
            $suburi .="-tags/";
        }
        if(!empty($_REQUEST['keyword'])&&!$tag_keys){
            $suburi .="-tags/".$_REQUEST['keyword'];
        }
        return $suburi;

    }
    static function urlEncodeTags($tname)
    {
        return (urlencode($tname) == $tname) ? $tname : urlencode($tname);
    }
     function getSearchList(){
         $request = $this->request;
         if (!empty($request['keyword'])) {
             $condition  =array(
                " search_title like '".$request['keyword']."%'"
             );
                 $condition['search_type'] = 'site_space';
             $list = Data_Mysql_Table_Search_Logm::select("*",$condition,' group by search_title order by search_time desc,date_time desc',10);
             return $list;
         }else{
             $list =   Data_Mysql_Table_Search_Logm::hotSearchList('site_space');
             return $list;
         }
     }

}