<?php
/**
 * Created by PhpStorm.
 * User: adu
 * Date: 2015/12/23
 * Time: 19:18
 */
class OA_Pedia_Make_Index {

    /**
     *
     */
    static function updatePediaIndex($info){
        /**
         * 浏览量 比重20% 基数是 日期增加 每天有技术增加 喜欢量暂时搁置
         * 面积 15%  0-1000m 一档。分数比较大。1000以上分数较少
         * logo+图片 5+10% =15%  有logo 5分 有图片的增加每张加一分。满分10分
         * 地理位置 -》商圈 轨道交通   10%     有商圈。有地铁 热门商圈的。 分档 ：商圈 地铁 热门;商圈，地铁；商圈 热门；商圈;地铁
         * 层高，承重 供电量 基础设置  20%  层高 无 0-3m 3m以上 其他有就是有就加分  基础设置。按照前端显示的几个表示  有就加，存储数据“无‘或者空的都算没有。其他都有
         * 一个月内更新的  5%
         * 等级 15%
         * 最终指数显示是0-10 保存是0-100
         * */
        $start_time = strtotime("2015-12-24 01:00:00");
        $info['attr'] = json_decode($info['attr'],1);
        $tag_info =  Data_Mysql_Table_Product_Category::getTagsInfo($info['category_id']);
        $total_index =50+round((time()-$start_time)/86400)*20;
        $info['order_index'] = 0;
        //浏览量 比重20% 基数是 日期增加 每天有基数上对比  2016.2.16 调整权重为10%

        if($info['click']){
            $info['order_index'] = round(($info['click']/$total_index)*10);
            if($info['order_index']>10){
                $info['order_index']=10;
            }
        }else{
            $info['click'] =  mt_rand(1,100);
            Data_Mysql_Table_Baike_Statistical::update(array("space_id"=>$info['id']),array("click"=>$info['click']));
        }
        //面积 15%
        if(isset($info['attr'][10])&&$info['attr'][10]){
            if(intval($info['attr'][10])>0&&intval($info['attr'][10])<1000){
                $info['order_index'] =  $info['order_index']+10;
            }
            if(intval($info['attr'][10])>1000){
                $info['order_index'] =  $info['order_index']+5;
            }
        }
        //logo+图片 5+15% =15%
        if($info['logo']){
            $info['order_index'] =  $info['order_index']+5;
        }
        if($info['media']){
            $media_num=  count($info['media']);
            if($media_num>0&&$media_num<=10){
                $info['order_index'] = $info['order_index']+$media_num;
            }
            if($media_num>10){
                $info['order_index'] = $info['order_index']+10;
            }
        }
        //地理位置 -》商圈 轨道交通   10%
        if((isset($info['attr'][2])&&$info['attr'][2])){
            $info['attr'][2] = explode(',',$info['attr'][2]);
        }
        if((isset($info['attr'][2])&&$info['attr'][2]) && (isset($info['attr'][3]) && $info['attr'][3]) &&count(@array_intersect($info['attr'][2],self::hotShangQuan())) ){
            $info['order_index'] =  $info['order_index']+10;
        }elseif((isset($info['attr'][2])&&$info['attr'][2]) && (isset($info['attr'][3]) && $info['attr'][3]) && !count(@array_intersect($info['attr'][2],self::hotShangQuan()))){
            $info['order_index'] =  $info['order_index']+8;
        }elseif((isset($info['attr'][2])&&$info['attr'][2]) && (!isset($info['attr'][3]) || !$info['attr'][3]) && count(@array_intersect($info['attr'][2],self::hotShangQuan()))){
            $info['order_index'] =  $info['order_index']+8;
        }elseif((!isset($info['attr'][2])||!$info['attr'][2]) && (isset($info['attr'][3])  && $info['attr'][3]) && !count(@array_intersect($info['attr'][2],self::hotShangQuan()))){
            $info['order_index'] =  $info['order_index']+4;
        }elseif((isset($info['attr'][2])&&$info['attr'][2]) && (!isset($info['attr'][3]) || !$info['attr'][3]) && !count(@array_intersect($info['attr'][2],self::hotShangQuan()))){
            $info['order_index'] =  $info['order_index']+4;
        }
        if(is_array($info['attr'][2])){
            $info['attr'][2] = implode(',',$info['attr'][2]);
        }else{
            $info['attr'][2] = array();
        }

        //层高 0 》3m》 ，承重 供电量 10%
        if(isset($info['attr'][6])&&$info['attr'][6] && $info['attr'][6]>0 &&$info['attr'][6]<3){
            $info['order_index'] =  $info['order_index']+4;
        }
        if(isset($info['attr'][6])&&$info['attr'][6] && $info['attr'][6]>3 ){
            $info['order_index'] =  $info['order_index']+3;
        }
        if(isset($info['attr'][11]) && $info['attr'][11]&&$info['attr'][11]!='无'){
            $info['order_index'] =  $info['order_index']+3;
        }
        if(isset($info['attr'][7]) && $info['attr'][7] &&$info['attr'][7]!='无'){
            $info['order_index'] =  $info['order_index']+3;
        }
        //基础设置  10%
        $temp_index=0;
        $baseinfo = array(12,13,14,15,17,18,19,20,21,5,22);
        foreach($tag_info as $k=>$v){
            if($k=='配套设施'||$k=='使用规格'||$k=='附属空间'||$k=='配餐饮品'||$k=='收费标准'){
                foreach($v as $kk=>$vv){
                    if(in_array($kk,$baseinfo)&&isset($info['attr'][$kk])&&$info['attr'][$kk]&&$info['attr'][$kk]!='无'){
                        $temp_index =$temp_index+1;
                    }
                }
            }
        }
        if($temp_index){
            $temp_index = $temp_index>10?10:$temp_index;
            $info['order_index'] =  $info['order_index']+$temp_index;
        }
        //一个月内更新的  5%
        if(round((time()-$info['update_time'])/86400)<30){
            $info['order_index'] =  $info['order_index']+5;
        }
        //等级 15%
        if($info['level']>0){
            $s_num = ($info['level']==3)?10:15;
            $info['order_index'] =  $info['order_index']+$s_num;
        }
        return $info;
    }

    //热门商圈
    static function  hotShangQuan(){
        return array('徐家汇',
            '五角场大学区',
            '八佰伴',
            '人民广场',
            '中山公园',
            '淮海路',
            '静安寺',
            '虹桥',
            '莘庄',
            '打浦桥',
            '南京东路',
            '南京西路',
            '天山',
            '世纪公园',
            '金桥',
            '虹口足球场',
            '陆家嘴',
            '大宁地区',
            '大华地区',
            '七宝',
            );
    }
}