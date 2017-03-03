<?php
/**
 * Created by PhpStorm.
 * User: adu
 * Date: 2016/11/16
 * Time: 16:52
 */
set_time_limit(0);
class Web_Export_Yml {
    static function handle(){
        $action =Core::$urls['action'];
        $request = Func_Input::filter(array(
            'id'=>'int',
        ),$_REQUEST);
        $id='';
        if(!empty($request['id'])){
            $id=$request['id'];
        }
        switch($action){
            case 'site':
                self::siteExport($id);
                break;
            case 'user':
                self::userExport();
                break;
            case 'space':
                self::spaceExport($id);
                break;
            case "article":
                self::articlesExport($id);
                break;
            case "special":
                self::specialExport();
                break;
            case "photo":
                self::photoExport();
                break;
            case "site_photo":
                self::sitePhotoExport( $id);
                break;
            case "space_photo":
                self::spacePhotoExport($id);
                break;
            case "wc_photo":
                self::wcPhotoExport($id);
                break;
            case 'project':
                self::projectExport();
                break;
            case 'article_space':
                self::articleSpace();
                break;
            default:
                Func_Header::notFound();
                break;
        }
    }
    static function specialExport(){
        $cols = array(
            'i_types',
            'title',
            'abstract',
            'first_picture',
            'state',
            'special_url',
            'details',
            'is_special',
            'created_at',
            'updated_at',
            'viewed',
        );
        $list =Data_Mysql_Table_Topic::select('*','','',100);
        $sql = 'set names utf8;'."\n";
        foreach($list as $k=>$v){
            $values=  array(
               40,$v['topic_name'],$v['topic_des'],$v['small_logo'],$v['status'],
                "http://www.yunspace.com.cn/topic/".Func_Url::str_urlencode($v['topic_url']),$v['topic_des'],1,date('Y-m-d H:i:s',$v['create_time']),date('Y-m-d H:i:s',$v['update_time']),
                $v['count_view']
            );
            $new_value = array_combine($cols,$values);
            $sql .= "insert into articles ".self::array_to_sql($new_value).";\n";
        }
        $f = fopen('special.sql',"w+");
        fwrite($f,$sql);
        fclose($f);
        echo Core::$urls['action']."导出成功";
    }
    static function articleSpace(){
        $cols = array('article_id','space_id');
        $article_list = Data_Mysql_Table_Raiders_Info::select('id,space_ids','','order by id ASC',6972);
        $space_site_ids = Data_Mysql_Table_Space_Item::select('id,space_id','','order by id asc',12846);
        $space_site_temp =array();
        foreach($space_site_ids as $k=>$v){
            $space_site_temp[$v['id']]=$v['space_id'];
        }
        $sql = 'set names utf8;'."\n";
        foreach($article_list as $k=>$v){
            if($v['space_ids']){
                $site_ids =explode(',',$v['space_ids']);
                foreach($site_ids as $kk=>$vv){
                    if(!empty($vv)){
                        $space_ids = array_keys($space_site_temp,$vv);
                        if($space_ids){
                            foreach($space_ids as $kkk=>$vvv){
                                $values = array(
                                    $v['id'],$vvv
                                );
                                $new_value = array_combine($cols,$values);
                                $sql .="insert into articles_spaces ".self::array_to_sql($new_value).";\n";
                            }
                        }
                    }
                }
            }
        }
        $f = fopen('articles_spaces.sql',"w+");
        fwrite($f,$sql);
        fclose($f);
        echo Core::$urls['action']."导出成功";
    }
    static function projectExport(){
        $cols = array(
            'id',
//            'keyword',
            'source',
            'area',
            'budget_amount',
//            'applicable_people',
            'title',
            'p_notes',
            'creation_people',
            'state',
            'audit_people',
            'p_type',
            'rec_city',
            'home_recommenda',
            'home_rec_time',
            'p_hot',
            'hot_rec_time',
            'is_brand',
            'brand_res_time',
            'created_at',
            'updated_at'
        );
        $sql = 'set names utf8;'."\n";
        $list = Data_Mysql_Table_Winchance::select('*','','order by id asc',345);
        $areas = Data_Mysql_Table_Winchance::$area_array;
        $category = Data_Mysql_Table_Winchance::$category;
        foreach($list as $k=>$v){
            $v['attr'] = json_decode($v['attr'],1);
            $v['tags_info'] = json_decode($v['tags_info'],1);
            $v['accessory'] = json_decode($v['accessory'],1);
            $values = array(
               $v['id'],
//                empty($v['tags_info'])?'':implode(',',$v['tags_info']),
                isset($v['attr']['资源来自国家'])?$v['attr']['资源来自国家']:'',
                isset($v['area'])?$areas[$v['area']]:0,isset($v['attr']['预算上限'])?$v['attr']['预算上限']:0,
//                $v['conform_crowd'],
               $v['title'],$v['marketing_title'], '',$v['status'],$v['yun_principal'],isset($category[$v['category']])?$category[$v['category']]:'',$v['operation_range'],
                0,date('Y-m-d H:i:s',0),0,date('Y-m-d H:i:s',0),0,date('Y-m-d H:i:s',0),date('Y-m-d H:i:s',$v['create_time']),date('Y-m-d H:i:s',$v['update_time'])
            );
            $new_value = array_combine($cols,$values);
            $sql .="insert into projects ".self::array_to_sql($new_value).";\n";
        }
        $f = fopen('projects.sql',"w+");
        fwrite($f,$sql);
        fclose($f);
        echo Core::$urls['action']."导出成功";
    }
    static function sitePhotoExport($id=0){
        /**
         * 1.场地
         */
        $condition = array();
        if(!empty($id)){
            $condition['id>?']=$id;
        }
        $cols = array(
//            'id',
            'photoable_id',
            'photoable_type',
            'path',
            'name',
            'tag',
            'created_at',
            'updated_at'
        );
        $sql = 'set names utf8;'."\n";
        $site_photo_list = Data_Mysql_Table_Spacepedia::select('id,media',$condition,'ORDER BY id ASC',12090);
        foreach($site_photo_list as $k=>$v){
            $v['media'] = json_decode($v['media'],1);
            if($v['media']){
                foreach($v['media'] as $kk=>$vv){
                    if(!empty($vv['path'])){
                        $values = array(
                            $v['id'],'Site',$vv['path'],empty($vv['name'])?'':$vv['name'],empty($vv['tags'])?'':$vv['tags'],date('Y-m-d H:i:s',0),date('Y-m-d H:i:s',0)
                        );
                        $new_value = array_combine($cols,$values);
                        $sql .="insert into photos".self::array_to_sql($new_value).";\n";
                    }
                }
            }
        }
        $f = fopen('photos.sql',"w+");
        fwrite($f,$sql);
        fclose($f);
        echo Core::$urls['action']."导出成功";
    }
    static function spacePhotoExport($id=0){
        /**
         *2.空间
         */
        $cols = array(
//            'id',
            'photoable_id',
            'photoable_type',
            'path',
            'name',
            'tag',
            'created_at',
            'updated_at'
        );
        $sql = 'set names utf8;'."\n";
        $condition = array();
        if(!empty($id)){
            $condition['id>?']=$id;
        }
        $space_photo_list = Data_Mysql_Table_Space_Item::select('id,media',$condition,'ORDER BY id ASC',12846);
        foreach($space_photo_list as $k=>$v){
            $v['media'] = json_decode($v['media'],1);
            if($v['media']){
                foreach($v['media'] as $kk=>$vv){
                    if(!empty($vv['path'])){
                        $values = array(
                            $v['id'],'Space',$vv['path'],empty($vv['name'])?'':$vv['name'],empty($vv['tags'])?'':$vv['tags'],date('Y-m-d H:i:s',0),date('Y-m-d H:i:s',0)
                        );
                        $new_value = array_combine($cols,$values);
                        $sql .="insert into photos".self::array_to_sql($new_value).";\n";
                    }
                }
            }
        }
        $f = fopen('photos.sql',"w+");
        fwrite($f,$sql);
        fclose($f);
        echo Core::$urls['action']."导出成功";
    }
    static function wcPhotoExport($id=0){
        /**
         * 3.文章
         */
        $cols = array(
//            'id',
            'photoable_id',
            'photoable_type',
            'path',
            'name',
            'tag',
            'created_at',
            'updated_at'
        );
        $condition = array();
        if(!empty($id)){
            $condition['id>?']=$id;
        }
        $sql = 'set names utf8;'."\n";
        $project_photo_list = Data_Mysql_Table_Winchance::select('id,media',$condition,'order by id desc',345);
        foreach($project_photo_list as $k=>$v){
            $v['media'] = json_decode($v['media'],1);
            if($v['media']){
                foreach($v['media'] as $kk=>$vv){
                    if(!empty($vv['path'])){
                        $values = array(
                            $v['id'],'Project',$vv['path'],empty($vv['name'])?'':$vv['name'],empty($vv['tags'])?'':$vv['tags'],date('Y-m-d H:i:s',0),date('Y-m-d H:i:s',0)
                        );
                        $new_value = array_combine($cols,$values);
                        $sql .="insert into photos".self::array_to_sql($new_value).";\n";
                    }
                }
            }
        }
        $f = fopen('photos.sql',"w+");
        fwrite($f,$sql);
        fclose($f);
        echo Core::$urls['action']."导出成功";
    }

    static function photoExport(){
        /**
         * 1.场地
         *2.空间
         * 3.文章
         */
        $cols = array(
//            'id',
            'photoable_id',
            'photoable_type',
            'path',
            'name',
            'tag',
            'created_at',
            'updated_at'
        );
        $sql = 'set names utf8;'."\n";
        $site_photo_list = Data_Mysql_Table_Spacepedia::select('id,media','','ORDER BY id ASC',12090);
        foreach($site_photo_list as $k=>$v){
            $v['media'] = json_decode($v['media'],1);
            if($v['media']){
                foreach($v['media'] as $kk=>$vv){
                    if(!empty($vv['path'])){
                        $values = array(
                            $v['id'],'Site',$vv['path'],empty($vv['name'])?'':$vv['name'],empty($vv['tags'])?'':$vv['tags'],date('Y-m-d H:i:s',0),date('Y-m-d H:i:s',0)
                         );
                        $new_value = array_combine($cols,$values);
                        $sql .="insert into photos".self::array_to_sql($new_value).";\n";
                    }
                }
            }
        }

        $space_photo_list = Data_Mysql_Table_Space_Item::select('id,media','','ORDER BY id ASC',12846);
        foreach($space_photo_list as $k=>$v){
            $v['media'] = json_decode($v['media'],1);
            if($v['media']){
                foreach($v['media'] as $kk=>$vv){
                    if(!empty($vv['path'])){
                        $values = array(
                            $v['id'],'Space',$vv['path'],empty($vv['name'])?'':$vv['name'],empty($vv['tags'])?'':$vv['tags'],date('Y-m-d H:i:s',0),date('Y-m-d H:i:s',0)
                        );
                        $new_value = array_combine($cols,$values);
                        $sql .="insert into photos".self::array_to_sql($new_value).";\n";
                    }
                }
            }
        }
        $project_photo_list = Data_Mysql_Table_Winchance::select('id,media','','order by id desc',345);
        foreach($project_photo_list as $k=>$v){
            $v['media'] = json_decode($v['media'],1);
            if($v['media']){
                foreach($v['media'] as $kk=>$vv){
                    if(!empty($vv['path'])){
                        $values = array(
                            $v['id'],'Project',$vv['path'],empty($vv['name'])?'':$vv['name'],empty($vv['tags'])?'':$vv['tags'],date('Y-m-d H:i:s',0),date('Y-m-d H:i:s',0)
                        );
                        $new_value = array_combine($cols,$values);
                        $sql .="insert into photos".self::array_to_sql($new_value).";\n";
                    }
                }
            }
        }
        $f = fopen('photos.sql',"w+");
        fwrite($f,$sql);
        fclose($f);
        echo Core::$urls['action']."导出成功";
    }
    static function articlesExport(){
        $cols = array(
            'id',
            'i_types',
            'i_class',
            'source',
            'title',
            'abstract',
            'first_picture',
            'i_time',
            'home_recommenda',
            'home_rec_time',
            'viewed',
            'up_number',
//            'keyword',
            'creation_people',
            'state',
            'audit_people',
            'i_hot',
            'hot_rec_time',
            'details',
            'rec_city',
            'is_special',
            'created_at',
            'updated_at'
        );
        $condition = array();
        if(!empty($id)){
            $condition['id>?']=$id;
        }
        $list = Data_Mysql_Table_Raiders_Info::select('*',$condition,'order by id ASC',6972);
        $sql = 'set names utf8;'."\n";
        foreach($list as $k=>$v){
           // $v['activity_type'] = json_decode($v['activity_type'],1);
            //i_types i_class
            $v['tags_info'] = json_decode($v['tags_info'],1);
            $values=  array(
                $v['id'],0,$v['category_id'],$v['from_where'],$v['title'],addslashes($v['des']),$v['logo'],date('Y-m-d H:i:s',$v['update_time']),$v['is_good'],date('Y-m-d H:i:s',0),$v['counter_view'],
                $v['counter_praise'],
//                empty($v['tags_info'])?'':implode(',',$v['tags_info']),
                $v['author'],$v['status'],'',$v['is_hot'],date('Y-m-d H:i:s',0),addslashes($v['cont']),$v['city'],
                0,date('Y-m-d H:i:s',$v['create_time']),date('Y-m-d H:i:s',$v['update_time'])
            );
            $new_value = array_combine($cols,$values);
            $sql .= "insert into articles ".self::array_to_sql($new_value).";\n";
        }
        $f = fopen('articles.sql',"w+");
        fwrite($f,$sql);
        fclose($f);
        echo Core::$urls['action']."导出成功";
    }

    static function spaceExport(){
            $cols = array(
                'id',
                'site_id',
                'title',
                'space_type',
                'market_price',
                'units',
                'through_three_areas',
                'Max_seating_capacity',
                'area',
                'height',
//                'supporting_facilities',
                'introduced',
                'booking_notes',
//                'keyword',
                'is_recommended',
                'reasons',
                'recommended_time',
                'creation_people',
                'state',
                'audit_people',
                'created_at',
                'updated_at',
                'set_info',
                'accept_weight',
//                'tags',
                'contact',
                'phone',
                'email',
                'inner_price'
            );
            $sql = 'set names utf8;'."\n";
            $condition = array();
            if(!empty($id)){
                $condition['id>?']=$id;
            }
            $list = Data_Mysql_Table_Space_Item::select('*',$condition,'order by id asc',12846);
            foreach($list as $k=>$v){
                  $v['activity_type'] = json_decode($v['activity_type'],1);
                $values=  array(
                   $v['id'],$v['space_id'],$v['item_name'],'',$v['max_price'],$v['price_unit'],$v['location_area'],
                    $v['max_people'],$v['size'],$v['layer_height'],
//                    '',
                    addslashes($v['des']),'',
//                    '',
                    0,'',date('Y-m-d H:i:s',0),$v['admin_name'],$v['status'],'',date('Y-m-d H:i:s',$v['create_time']),date('Y-m-d H:i:s',$v['update_time']),
                    '',$v['item_weight'],
//                    $v['tags_new'],
                    $v['contacts'],$v['phone'],$v['email'],''
                );
                $new_value = array_combine($cols,$values);
                $sql .= "insert into spaces ".self::array_to_sql($new_value).";\n";
            }
        $f = fopen('spaces.sql',"w+");
        fwrite($f,$sql);
        fclose($f);
        echo Core::$urls['action']."导出成功";
    }

    static $facility=[
        5 => '停车泊位',
        12 => '休息室',
        13 => '化妆间',
        14 => '洗手间',
        15 => '空间吊点',
        17 => '空调暖气',
        18 => '网络WIFI',
        19 => '货运电梯',
        20 => '投影LED',
        21 => '灯光音响',
        22 => '餐饮',
    ];
    static function siteExport($id=''){
        $condition = array();
        if(!empty($id)){
            $condition['id>?']=$id;
        }
        $list = Data_Mysql_Table_Spacepedia::select('*',$condition,'ORDER BY id ASC',12090);
        $cols = [
            'id',
            'supplier_id',
            'title',
            'site_type',
//            'facilities',
            'site_statue',
            'brand_story',
            'city_id',
            'address',
            'x_coordinates',
            'y_conrdinates',
//            'areas',
//            'keyword',
            'logo',
            'creation_people',
            'update_people',
            'state',
            'audit_people',
            'created_at',
            'updated_at',
            'district_id',
            'nickname',
            'level',
            'second_type',
            'recommend_reason',
//            'industry_type',
//            'event_type',
            'subway_distance',
            'loop_info'
        ];
        $sql = 'set names utf8;'."\n";
        foreach($list as $k=>$v){
            $v['attr']= json_decode($v['attr'],1);
            $v['media']= json_decode($v['media'],1);
            $facilities = array();
            if($v['attr']){
                foreach($v['attr'] as $kk=>$vv){
                    if(isset(self::$facility[$kk])&&$vv=="有"){
                        $facilities[]=self::$facility[$kk];
                    }
                }
            }
            $values=  array(
                $v['id'],$v['vendor_id'],$v['space_name'],!empty($v['category_id'])?Data_Mysql_Table_Spacepedia::getCategoryNameById($v['category_id']):'',
//                implode(',',$facilities),
                $v['status'],addslashes($v['des']),
                0,$v['city'].$v['addr'],$v['geo_lat'],$v['geo_lng'],
//                isset($v['attr'][4])?$v['attr'][4]:'','',
                $v['logo'],'','',0,'',
                date('Y-m-d H:i:s',$v['create_time']),date('Y-m-d H:i:s',$v['update_time']),0,$v['nickname'],$v['type_level'],'',$v['subhead'],
//                isset($v['attr'][9])?$v['attr'][9]:'',isset($v['attr'][49])?$v['attr'][49]:'',
                '',''
            );
            $new_value = array_combine($cols,$values);
            $sql .= "insert into sites ".self::array_to_sql($new_value).";\n";
        }
        $f = fopen('sites.sql',"w+");
        fwrite($f,$sql);
        fclose($f);
        echo Core::$urls['action']."导出成功";

    }

    static function userExport(){
        $list = Data_Mysql_Table_Account::select('*','','order by id ASC',41836);
        $cols = [
            'id','name', 'mobile', 'nickname','company_name','head_portrait', 'QQ_binding','QQ_account', 'QQ_primary_key','wechat_binding',
            'wechat_account','wechat_primary_key','sina_binding','sina_primary_key', 'registered_IP', 'registered_city',
            'state','the_reviewer', 'created_at','updated_at','email','encrypted_password','reset_password_token','reset_password_sent_at',
            'remember_created_at','sign_in_count','current_sign_in_at', 'last_sign_in_at','current_sign_in_ip','last_sign_in_ip','provider',
            'uid','confirmation_token','confirmed_at','confirmation_sent_at','unconfirmed_email','image','tokens'
        ];
        $sql = 'set names utf8;'."\n";
        foreach($list as $k=>$v){
            $v['attr'] = json_decode($v['attr'],1);
           $values=  array(
                $v['id'],$v['fullname'],$v['phone'],$v['username'],'',$v['avatar'],0,
                '','',0,'','',0,'',isset($v['attr']['register_ip'])?$v['attr']['register_ip']:'','',$v['status'],'',date('Y-m-d H:i:s',$v['register_time']),empty($v['update_time'])?date('Y-m-d H:i:s',$v['register_time']):date('Y-m-d H:i:s',$v['update_time']),empty($v['email'])?"example@example.com":$v['email'],
                empty($v['password'])?md5('123456'):$v['password'],'',date('Y-m-d H:i:s',0),date('Y-m-d H:i:s',0),empty($v['sign_num'])?1:$v['sign_num'],date('Y-m-d H:i:s',0),date('Y-m-d H:i:s',0),'','',($v['account_type']==21)?1:0,$v['id'],'',date('Y-m-d H:i:s',0),date('Y-m-d H:i:s',0),'','','',
            );
            $newvalue = array_combine($cols,$values);
            $sql .= "insert into users ".self::array_to_sql($newvalue).";\n";
         }
//        echo '<pre>YAML Data dumped back:<br/>';
//        echo $sql;
//        echo '</pre>';
        $f = fopen('users.sql',"w+");
        fwrite($f,$sql);
        fclose($f);
        echo Core::$urls['action']."导出成功";
    }
   static  function array_to_sql($array, $type='insert', $exclude = array()){

        $sql = '';
        if(count($array) > 0){
            foreach ($exclude as $exkey) {
                unset($array[$exkey]);//剔除不要的key
            }

            if('insert' == $type){
                $keys = array_keys($array);
                $values = array_values($array);
                $col = implode("`, `", $keys);
                $val = implode("', '", $values);
                $sql = "(`$col`) values('$val')";
            }else if('update' == $type){
                $tempsql = '';
                $temparr = array();
                foreach ($array as $key => $value) {
                    $tempsql = "'$key' = '$value'";
                    $temparr[] = $tempsql;
                }

                $sql = implode(",", $temparr);
            }
        }
        return $sql;
    }
} 