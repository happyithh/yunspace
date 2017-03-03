<?php

/**
 * Created by PhpStorm.
 * User: yl
 * Date: 2016/02/17
 * Time: 10:05
 * 用户轨迹统计
 */
class Api_Track_Count extends Api
{
    static function  handle($args = '')
    {
        $request=Func_Input::filter(array(
            'start_id'=>'int',
            'end_id'=>'int',
            'datetime'=>'string',
            'action'=>'string',
        ));
        if(empty($request['start_id']) || empty($request['end_id'])){
            return self::request('error','','参数缺失！！');
        }
        $request['datetime']=empty($request['month_time'])?date('_Ym'):date('_Ym',strtotime($request['datetime']));

        if($request['action']=="referer"){
            //处理来源页
            return self::handleResourceData($request);
        }elseif($request['action']=="land"){
            //处理落地页
            return self::handleLandData($request);
        }else{
            return self::request('error','','操作错误！！');
        }
    }

    //处理来源页
    static function handleResourceData($args){
        $condition['id >= ?']=$args['start_id'];
        $condition['id < ?']=$args['end_id'];
        $rs=Data_Mysql_Table_StaticLog::subTable($args['datetime'])->select('*',$condition,'ORDER BY create_time DESC',9999);
        if(empty($rs)){
            return self::request('error','','无符合条件的数据');
        }
        foreach($rs as $k=>$v){
            //1.处理来源页
            if(!empty($v['referer'])){
                $url_arr=explode("/",str_replace("http://",'',$v['referer']));
                $url_arr[1]=empty($url_arr[1])?'':$url_arr[1];
                $url="http://".$url_arr[0].'/'.$url_arr[1];
                Data_Mysql_Table_Track_Referer_Url::subTable($args['datetime'])->query(
                    'INSERT INTO {table} (referer_url,datetime,count,create_time) VALUES (?,?,?,?)  ON DUPLICATE KEY UPDATE count = count +1',
                    array(
                        $url,
                        date("Y-m-d",$v['create_time']),
                        1,
                        time(),
                    )
                );
            }
        }
        return self::request('success','','来源页数据处理');
    }

    //处理落地页
    static function handleLandData($args){
        $condition['id >= ?']=$args['start_id'];
        $condition['id < ?']=$args['end_id'];
        $rs=Data_Mysql_Table_StaticLog::subTable($args['datetime'])->select('*',$condition,'ORDER BY create_time DESC',9999);
        if(empty($rs)){
            return self::request('error','','无符合条件的数据');
        }

        if(!empty($rs)){
            //1.处理作为落地页次数
            $layer=self::operateLayer($rs);
            //2.处理作为跳出页次数
            $land=self::operateLand($rs,$layer);
        }

        //处理三维数组
        foreach($land as $k=>$v){
            foreach($v as $k1=>$v1){
                $v1['land_url']=$k;
                $v1['datetime']=$k1;
                $temp_arr[]=$v1;
            }
        }
        //放入数据库
        foreach($temp_arr as $k=>$v){
            Data_Mysql_Table_Track_Land_Url::subTable(date('_Ym',strtotime($v['datetime'])))->query(
                'INSERT INTO {table} (land_url,datetime,create_time,layer_1,layer_2,layer_3,layer_4,layer_5,land_1,land_2,land_3,land_4,land_5)
                    VALUES (?,?,?,?,?,?,?,?,?,?,?,?,?)
                    ON DUPLICATE KEY UPDATE layer_1=layer_1+?,layer_2=layer_2+?,layer_3=layer_3+?,layer_4=layer_4+?,layer_5=layer_5+?,land_1=land_1+?,land_2=land_2+?,land_3=land_3+?,land_4=land_4+?,land_5=land_5+?',
                array(
                    $v['land_url'],
                    $v['datetime'],
                    time(),
                    empty($v['layer_1'])?0:$v['layer_1'],
                    empty($v['layer_2'])?0:$v['layer_2'],
                    empty($v['layer_3'])?0:$v['layer_3'],
                    empty($v['layer_4'])?0:$v['layer_4'],
                    empty($v['layer_5'])?0:$v['layer_5'],
                    empty($v['land_1'])?0:$v['land_1'],
                    empty($v['land_2'])?0:$v['land_2'],
                    empty($v['land_3'])?0:$v['land_3'],
                    empty($v['land_4'])?0:$v['land_4'],
                    empty($v['land_5'])?0:$v['land_5'],
                    empty($v['layer_1'])?0:$v['layer_1'],
                    empty($v['layer_2'])?0:$v['layer_2'],
                    empty($v['layer_3'])?0:$v['layer_3'],
                    empty($v['layer_4'])?0:$v['layer_4'],
                    empty($v['layer_5'])?0:$v['layer_5'],
                    empty($v['land_1'])?0:$v['land_1'],
                    empty($v['land_2'])?0:$v['land_2'],
                    empty($v['land_3'])?0:$v['land_3'],
                    empty($v['land_4'])?0:$v['land_4'],
                    empty($v['land_5'])?0:$v['land_5'],
                )
            );
        }
        return self::request('success','','落地页数据处理');
    }

    //处理作为跳出页次数
    static function operateLand($data,$layer){
        $temp_arr=array();
        foreach($data as $k=>$v){
            if(!empty($v['url'])){
                $temp_arr[$v['session_id']][$v['layer']]['land_url']=$v['url'];
                $temp_arr[$v['session_id']][$v['layer']]['land_time']=date("Y-m-d",$v['create_time']);
            }
        }
        if(!empty($temp_arr)){
            foreach($temp_arr as $k=>$v){
                $max_key=max(array_keys($v));
                $k1=$v[$max_key]['land_url'];
                $k2=$v[$max_key]['land_time'];
                switch($max_key){
                    case 1:
                        if(!empty($layer[$k1][$k2]['land_1'])){
                            $layer[$k1][$k2]['land_1']=$layer[$k1][$k2]['land_1']+1;
                        }else{
                            $layer[$k1][$k2]['land_1']=1;
                        }
                        break;
                    case 2:
                        if(!empty($layer[$k1][$k2]['land_2'])){
                            $layer[$k1][$k2]['land_2']=$layer[$k1][$k2]['land_2']+1;
                        }else{
                            $layer[$k1][$k2]['land_2']=1;
                        }
                        break;
                    case 3:
                        if(!empty($layer[$k1][$k2]['land_3'])){
                            $layer[$k1][$k2]['land_3']=$layer[$k1][$k2]['land_3']+1;
                        }else{
                            $layer[$k1][$k2]['land_3']=1;
                        }
                        break;
                    case 4:
                        if(!empty($layer[$k1][$k2]['land_4'])){
                            $layer[$k1][$k2]['land_4']=$layer[$k1][$k2]['land_4']+1;
                        }else{
                            $layer[$k1][$k2]['land_4']=1;
                        }
                        break;
                    default:
                        if(!empty($layer[$k1][$k2]['land_5'])){
                            $layer[$k1][$k2]['land_5']=$layer[$k1][$k2]['land_5']+1;
                        }else{
                            $layer[$k1][$k2]['land_5']=1;
                        }
                        break;

                }

            }

        }

        return $layer;
    }

    //处理作为落地页次数
    static function operateLayer($data){
        $temp_arr=array();
        foreach($data as $k=>$v){
            if(!empty($v['url'])){
                $k1=$v['url'];
                $k2=date("Y-m-d",$v['create_time']);
                switch($v['layer']){
                    case 1:
                        if(!empty($temp_arr[$k1][$k2]['layer_1'])){
                            $temp_arr[$k1][$k2]['layer_1']=$temp_arr[$k1][$k2]['layer_1']+1;
                        }else{
                            $temp_arr[$k1][$k2]['layer_1']=1;
                        }
                        break;
                    case 2:
                        if(!empty($temp_arr[$k1][$k2]['layer_2'])){
                            $temp_arr[$k1][$k2]['layer_2']=$temp_arr[$k1][$k2]['layer_2']+1;
                        }else{
                            $temp_arr[$k1][$k2]['layer_2']=1;
                        }
                        break;
                    case 3:
                        if(!empty($temp_arr[$k1][$k2]['layer_3'])){
                            $temp_arr[$k1][$k2]['layer_3']=$temp_arr[$k1][$k2]['layer_3']+1;
                        }else{
                            $temp_arr[$k1][$k2]['layer_3']=1;
                        }
                        break;
                    case 4:
                        if(!empty($temp_arr[$k1][$k2]['layer_4'])){
                            $temp_arr[$k1][$k2]['layer_4']=$temp_arr[$k1][$k2]['layer_4']+1;
                        }else{
                            $temp_arr[$k1][$k2]['layer_4']=1;
                        }
                        break;
                    default:
                        if(!empty($temp_arr[$k1][$k2]['layer_5'])){
                            $temp_arr[$k1][$k2]['layer_5']=$temp_arr[$k1][$k2]['layer_5']+1;
                        }else{
                            $temp_arr[$k1][$k2]['layer_5']=1;
                        }
                        break;
                }
            }
        }
        return $temp_arr;
    }

}