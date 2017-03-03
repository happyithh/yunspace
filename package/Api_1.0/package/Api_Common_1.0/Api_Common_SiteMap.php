<?php
/**
 * Created by PhpStorm.
 * User: adu
 * Date: 2015/9/22
 * Time: 17:42
 */
class Api_Common_SiteMap extends  Api{

//    static function handle(){
//        return self::postSiteMap();
//    }

    static function postSiteMap(){
        $urls  = self::newUrl();
        if(!empty($urls)){
            if(Core::$urls['host']=='www.yunspace.com.cn'){
                $api = 'http://data.zz.baidu.com/urls?site=www.yunspace.com.cn&token=XirciTyGRLeT9SjI';
            }else{
                $api = 'http://yun.com/test22';
            }
            $ch = curl_init();
            $options =  array(
                CURLOPT_URL => $api,
                CURLOPT_POST => true,
                CURLOPT_RETURNTRANSFER => true,
                CURLOPT_POSTFIELDS => implode("\n", $urls),
                CURLOPT_HTTPHEADER => array('Content-Type: text/plain'),
            );
            curl_setopt_array($ch, $options);
            $result = curl_exec($ch);
            //存日志
            $result = json_decode($result,1);
            if(isset($result['success'])){
                $not_same_site = !empty( $result['not_same_site']) ? implode('-', $result['not_same_site']) : '';
                $not_valid =  !empty( $result['not_valid']) ?implode('-', $result['not_valid']) : '';
                Core::log('baidu_sitemap', "success:".$result['success'], 'remain'.$result['remain'], 'not_same_site'.$not_same_site,'not_valid'.$not_valid);
            }
            if(isset($result['error'])){
                Core::log('baidu_sitemap', "error:".$result['error'],'message'.$result['message']);
            }
           return  self::request("success",'','提交sitemap成功');
        }else{
            return  self::request("error",'','没有更新数据！');
        }

//        echo $result;
    }
    static function newUrl(){
        /**
         * 这个是推送最新的链接 主要是主动推送,最新产生的url （首页，栏目页和二级分类暂时不提交吧。不过新增的城市分站url应该要提交）
         */

        $urlData = array();
        /**
         * 首页 ,栏目页 （空间场地，配套服务，超值套餐，活动攻略，服务商户）
         *
         */
        //暂时不提交
//        $urlData[] = 'http://www.yunspace.com.cn';

//        $urlData[] = "http://www.yunspace.com.cn/space/";
//        $urlData[] = "http://www.yunspace.com.cn/service/";
//        $urlData[] = "http://www.yunspace.com.cn/set_list/";
        $navigate_config = Web_SiteMap::navigate();
        if(!isset($navigate_config['is_post'])||empty($navigate_config['is_post'])){
        //空间场地，配套服务，超值套餐  地区分类
            foreach($_REQUEST['cities'] as $k=>$v){
                $urlData[] = "http://www.yunspace.com.cn/space/".$k."";
                $urlData[] = "http://www.yunspace.com.cn/service/".$k."";
                $urlData[] = "http://www.yunspace.com.cn/set_list/".$k."";
            }
            //暂时不提交
            //        $urlData[] =  'http://www.yunspace.com.cn/raiders';
             //        $urlData[] = 'http://www.yunspace.com.cn/vendor';

            $space_tree = New Web_Search_Space();
            $space_tree_list =  $space_tree->categoryTree( );
            /***
             * 二级栏目页（空间场地，配套服务，超值套餐，活动攻略，服务商户）  帮助页面
             */
            //空间场地 分类
            foreach($space_tree_list[112] as $k=>$v){
                foreach($_REQUEST['cities'] as $kk=>$vv){
                    $urlData[] =  "http://www.yunspace.com.cn/space/".$kk."-".$k."";
                }
            }
            //配套服务 分类
            foreach($space_tree_list[0] as $k=>$v){
                foreach($_REQUEST['cities'] as $kk=>$vv){
                    if($v!=''){
                        $urlData[] = "http://www.yunspace.com.cn/service/".$kk."-".$k."";
                    }
                    if($k==4||$k==152){
                        $urlData[] =  "http://www.yunspace.com.cn/service/".$kk."-".$k."";
                    }

                }
            }
            $set_tree = New Web_Set_list();
            $set_tree_list =  $set_tree->allCategory();
            //超值套餐 分类
            foreach($set_tree_list as $k=>$v){
                foreach($_REQUEST['cities'] as $kk=>$vv){
                    $urlData[] ="http://www.yunspace.com.cn/set_list/".$kk."-".$k."";
                }
            }
            //活动攻略 分类
            $raider_tree =  Web_Activity_Raiders::getInstance();
            foreach($raider_tree->allCategory as $k=>$v){
                $urlData[] = "http://www.yunspace.com.cn/raiders/".$v['id']."";
            }

            //服务商户
            $vendor_webConfig = Data_Config_Site::get('service_list');
            $vendor_categoryTree = Data_Mysql_Table_Product_Category::getTreeCache();
            unset($vendor_categoryTree[0][$vendor_webConfig['space_id']], $vendor_categoryTree[0][93], $vendor_categoryTree[0][10], $vendor_categoryTree[0][140], $vendor_categoryTree[0][3], $vendor_categoryTree[0][135]);
            foreach($vendor_categoryTree[0] as $k=>$v){
                if($v!=''){
                    $urlData[] ="http://www.yunspace.com.cn/vendor/".$k."";
                }
                if($k==152){
                    $urlData[] =  "http://www.yunspace.com.cn/vendor/".$k."";
                }
            }
            $navigate_config['is_post'] = 1;
             Web_SiteMap::set('navigate', $navigate_config);
            //帮助页面  暂时不提交！
//        $urlData[] =  "http://www.yunspace.com.cn/yunspace/about_us";
//        $urlData[] = "http://www.yunspace.com.cn/yunspace/business";
//        $urlData[] =  "http://www.yunspace.com.cn/yunspace/recruitment";
//        $urlData[] = "http://www.yunspace.com.cn/yunspace/contact_us";
//        $urlData[] = "http://www.yunspace.com.cn/yunspace/agreement";
//        $urlData[] =  "http://www.yunspace.com.cn/yunspace/drawback";
        }

        /**
         * 详细页面（空间场地，配套服务，超值套餐，活动攻略，商户列表）
         * 要写配置文件 或者写缓存  保存上次最后一条的id。如果存在就查找大于这个id的所有，如果不存在id 就按正常查询。id倒叙查询
         * */
        //空间场地 列表
//        Q(array_keys($space_tree_list[112]));
        $space_conditions = array();
        $space_config = Web_SiteMap::space();
        if(isset($space_config['last_id'])&&!empty($space_config['last_id'])){
            $space_conditions['id>?']=$space_config['last_id'];
        }
        $space_list = Data_Mysql_Table_Product_Search::select("id,update_time", $space_conditions, 'order by id DESC,update_time DESC',1000);
            foreach($space_list as $k=>$v){
                $urlData[] ="http://www.yunspace.com.cn/service_info/".$v['id'].".html";
            }
        if(isset($space_list[0]['id'])){
            $space_config['last_id'] = $space_list[0]['id'];
        }
        Web_SiteMap::set('space', $space_config);
        //配套服务 列表
        //暂定没有筛选条件都直接读取 参考上面的场地列表

        //超值套餐 列表
        $set_conditions = array(
            "status=?"=>1
        );
        $set_config = Web_SiteMap::setList();
        if(isset($set_config['last_id'])&&!empty($set_config['last_id'])){
            $set_conditions['id>?']=$set_config['last_id'];
        }
        $set_orderBy = " ORDER BY id DESC,update_time DESC";
        $set_rs = Data_Mysql_View_Product_Set::select("id,update_time", $set_conditions, $set_orderBy,100);
        $set_rs = self::object2array($set_rs);
            foreach($set_rs as $k=>$v){
                $urlData[] = "http://www.yunspace.com.cn/set_info/".$v->id.".html";
            }
        if(isset($set_rs[0]->id)){
            $set_config['last_id'] = $set_rs[0]->id;
        }
        Web_SiteMap::set('setList', $set_config);
        //活动攻略 列表
        $raiders_conditions = array();
        $raiders_conditions['status =?'] = 1;
        $raiders_config = Web_SiteMap::raiders();
        if(isset($raiders_config['last_id'])&&!empty($raiders_config['last_id'])){
            $raiders_conditions['id>?']=$raiders_config['last_id'];
        }
        $raiders_order = 'ORDER BY id DESC,create_time DESC';
        $raiders_list = Data_Mysql_Table_Raiders_Info::select('id,update_time', $raiders_conditions,$raiders_order,500);
            foreach($raiders_list as $k=>$v){
                $urlData[] = "http://www.yunspace.com.cn/raiders-info/".$v['id'].".html";
            }
        if(isset($raiders_list[0]['id'])){
            $raiders_config['last_id'] = $raiders_list[0]['id'];
        }
        Web_SiteMap::set('raiders', $raiders_config);
        //商户 列表
        $vendor_conditions = array();
        $vendor_conditions['status =?'] = 1;
        $vendor_config = Web_SiteMap::vendor();
        if(isset($vendor_config['last_id'])&&!empty($vendor_config['last_id'])){
            $vendor_conditions['id>?']=$vendor_config['last_id'];
        }
        $vendor_order = 'ORDER BY id DESC,create_time DESC';
        $vendor_list = Data_Mysql_Table_Vendor_Info::select("id, update_time", $vendor_conditions, $vendor_order,100);
            foreach($vendor_list as $k=>$v){
                $urlData[] = "http://www.yunspace.com.cn/vendor_info/".$v['id'].".html";
            }
        if(isset($vendor_list[0]['id'])){
            $vendor_config['last_id'] = $vendor_list[0]['id'];
        }
        Web_SiteMap::set('vendor', $vendor_config);
        return $urlData;
    }
    static function createSiteMap(){
        $urlData = array();
        /**
         * 首页 ,栏目页 （空间场地，配套服务，超值套餐，活动攻略，服务商户）
         *
         */
        $urlData[] = array(
            'http://www.yunspace.com.cn',date("Y-m-d",time()),'always ','1.0'
        );
        $urlData[] = array(
            "http://www.yunspace.com.cn/space/",date("Y-m-d",time()),'always ','1.0'
        );
        $urlData[] = array(
            "http://www.yunspace.com.cn/service/",date("Y-m-d",time()),'always ','1.0'
        );
        $urlData[] = array(
            "http://www.yunspace.com.cn/set_list/",date("Y-m-d",time()),'always ','1.0'
        );

        //空间场地，配套服务，超值套餐  地区分类
        foreach($_REQUEST['cities'] as $k=>$v){
            $urlData[] = array(
                "http://www.yunspace.com.cn/space/".$k."",date("Y-m-d",time()),'always ','1.0'
            );
            $urlData[] = array(
                "http://www.yunspace.com.cn/service/".$k."",date("Y-m-d",time()),'always ','1.0'
            );
            $urlData[] = array(
                "http://www.yunspace.com.cn/set_list/".$k."",date("Y-m-d",time()),'always ','1.0'
            );

        }
        $urlData[] =  array(
            'http://www.yunspace.com.cn/raiders',date("Y-m-d",time()),'always ','1.0'
        );
        $urlData[] =  array(
            'http://www.yunspace.com.cn/vendor',date("Y-m-d",time()),'always ','1.0'
        );
        $space_tree = New Web_Search_Space();
        $space_tree_list =  $space_tree->categoryTree( );
        /***
         * 二级栏目页（空间场地，配套服务，超值套餐，活动攻略，服务商户）  帮助页面
         */
        //空间场地 分类
        foreach($space_tree_list[112] as $k=>$v){
            foreach($_REQUEST['cities'] as $kk=>$vv){
                $urlData[] = array(
                    "http://www.yunspace.com.cn/space/".$kk."-".$k."",date("Y-m-d",time()),'always ','1.0'
                );
            }
        }
        //配套服务 分类
        foreach($space_tree_list[0] as $k=>$v){
            foreach($_REQUEST['cities'] as $kk=>$vv){
                if($v!=''){
                    $urlData[] = array(
                        "http://www.yunspace.com.cn/service/".$kk."-".$k."",date("Y-m-d",time()),'always ','1.0'
                    );
                }
                if($k==4||$k==152){
                    $urlData[] = array(
                        "http://www.yunspace.com.cn/service/".$kk."-".$k."",date("Y-m-d",time()),'always ','1.0'
                    );
                }

            }
        }
        $set_tree = New Web_Set_list();
        $set_tree_list =  $set_tree->allCategory();
        //超值套餐 分类
        foreach($set_tree_list as $k=>$v){
            foreach($_REQUEST['cities'] as $kk=>$vv){
                $urlData[] = array(
                    "http://www.yunspace.com.cn/set_list/".$kk."-".$k."",date("Y-m-d",time()),'always ','1.0'
                );
            }
        }
        //活动攻略 分类
        $raider_tree =  Web_Activity_Raiders::getInstance();
        foreach($raider_tree->allCategory as $k=>$v){
                $urlData[] = array(
                    "http://www.yunspace.com.cn/raiders/".$v['id']."",date("Y-m-d",time()),'always ','1.0'
                );
        }

        //服务商户
        $vendor_webConfig = Data_Config_Site::get('service_list');
        $vendor_categoryTree = Data_Mysql_Table_Product_Category::getTreeCache();
        unset($vendor_categoryTree[0][$vendor_webConfig['space_id']], $vendor_categoryTree[0][93], $vendor_categoryTree[0][10], $vendor_categoryTree[0][140], $vendor_categoryTree[0][3], $vendor_categoryTree[0][135]);
        foreach($vendor_categoryTree[0] as $k=>$v){
            if($v!=''){
                $urlData[] = array(
                    "http://www.yunspace.com.cn/vendor/".$k."",date("Y-m-d",time()),'always ','1.0'
                );
            }
            if($k==152){
                $urlData[] = array(
                    "http://www.yunspace.com.cn/vendor/".$k."",date("Y-m-d",time()),'always ','1.0'
                );
            }

        }
        //帮助页面
        $urlData[] = array(
            "http://www.yunspace.com.cn/yunspace/about_us",date("Y-m-d",time()),'always ','1.0'
        );
        $urlData[] = array(
            "http://www.yunspace.com.cn/yunspace/business",date("Y-m-d",time()),'always ','1.0'
        );
        $urlData[] = array(
            "http://www.yunspace.com.cn/yunspace/recruitment",date("Y-m-d",time()),'always ','1.0'
        );
        $urlData[] = array(
            "http://www.yunspace.com.cn/yunspace/contact_us",date("Y-m-d",time()),'always ','1.0'
        );
        $urlData[] = array(
            "http://www.yunspace.com.cn/yunspace/agreement",date("Y-m-d",time()),'always ','1.0'
        );
        $urlData[] = array(
            "http://www.yunspace.com.cn/yunspace/drawback",date("Y-m-d",time()),'always ','1.0'
        );
        /**
         * 详细页面（空间场地，配套服务，超值套餐，活动攻略）
         * */
        //空间场地 列表
//        Q(array_keys($space_tree_list[112]));
        $space_conditions = array();
//        $space_children_tree_list = array_keys($space_tree_list[112]);
//        $space_conditions[] = 'category_id in (' . implode(',', $space_children_tree_list) . ')';
        $space_list = Data_Mysql_Table_Product_Search::select("id,update_time", $space_conditions, 'order by update_time DESC',20000);
        foreach($space_list as $k=>$v){
            $urlData[] = array(
                "http://www.yunspace.com.cn/service_info/".$v['id'].".html",date("Y-m-d",$v['update_time']),'always ','1.0'
            );
        }
        //配套服务 列表
        //暂定没有筛选条件都直接读取 参考上面的场地列表
//        $space_conditions = array();
//        $space_children_tree_list = array_keys($space_tree_list[112]);
//        $space_conditions[] = 'category_id not in (' . implode(',', $space_children_tree_list) . ')';
//        $space_list = Data_Mysql_Table_Product_Search::select("id,update_time", $space_conditions, 'order by update_time DESC',20000);
//        $urlData =array();
//        foreach($space_list as $k=>$v){
//            $urlData[] = array(
//                "http://www.yunspace.com.cn/service_info/".$v['id'].".html",date("Y-m-d",$v['update_time']),'always ','1.0'
//            );
//        }
        //超值套餐 列表
        $set_conditions = array(
            "status=?"=>1
        );
        $set_orderBy = " ORDER BY id DESC";
        $set_rs = Data_Mysql_View_Product_Set::select("id,update_time", $set_conditions, $set_orderBy,5000,1);
        foreach($set_rs as $k=>$v){
            $urlData[] = array(
                "http://www.yunspace.com.cn/set_info/".$v->id.".html",date("Y-m-d",$v->update_time),'always ','1.0'
            );
        }
        //活动攻略 列表
        $raiders_conditions = array();
        $raiders_conditions['status =?'] = 1;
        $raiders_order = 'ORDER BY create_time DESC';
        $raiders_list = Data_Mysql_Table_Raiders_Info::select('id,update_time', $raiders_conditions,$raiders_order,5000);
        foreach($raiders_list as $k=>$v){
            $urlData[] = array(
                "http://www.yunspace.com.cn/raiders-info/".$v['id'].".html",date("Y-m-d",$v['update_time']),'always ','1.0'
            );
        }
        //商户分类 列表
        $vendor_conditions = array();
        $vendor_conditions['status =?'] = 1;
        $vendor_order = 'ORDER BY create_time DESC';
        $vendor_list = Data_Mysql_Table_Vendor_Info::select("id, update_time", $vendor_conditions, $vendor_order,5000);
        foreach($vendor_list as $k=>$v){
            $urlData[] = array(
                "http://www.yunspace.com.cn/vendor_info/".$v['id'].".html",date("Y-m-d",$v['update_time']),'always ','1.0'
            );
        }
        return $urlData;
    }
    static function object2array($object) {
        if (is_object($object)) {
            foreach ($object as $key => $value) {
                $array[$key] = $value;
            }
        }
        else {
            $array = $object;
        }
        return $array;
    }

}