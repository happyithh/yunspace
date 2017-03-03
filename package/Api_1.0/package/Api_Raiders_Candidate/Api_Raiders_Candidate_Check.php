<?php
/**
 * Created by PhpStorm.
 * User: Yangchenglin
 * Date: 2015/9/8
 * Time: 0:14
 */
class Api_Raiders_Candidate_Check extends Api
{
    //接收采集来的数据
    static function handle($args='')
    {
        return self::handleCheck($args);
    }

    static function handleCheck($args)
    {
        $str = $args['cont'];
        preg_match_all('/(http:\/\/.*?\.(jpg|png|bmp|jpeg|gif).*?)/i',$str,$match);
        //远程下载图片
        if(!empty($match[0])) {
            $candidate_img = array();
            foreach ($match[0] as $k => $v) {
                $img = file_get_contents($v);
                $date = gmdate('Ymd');
                $dir = Core::virtualPath('static/editor/') .'upload/ue/raiders_candidate_img/'.$date.'/';
                Core::mkdir($dir, 0777, true);
                preg_match_all('/http:\/\/.+?\/([^\/]+\.(jpg|png|bmp|jpeg|gif))/i',$v,$match_v);
                if(!empty($match_v[2][0])) {
                    $img_mime = $match_v[2][0];
                }
                $img_name = time().mt_rand(111,999);
                file_put_contents($dir . $img_name.'.'.$img_mime, $img);
                $dir_relative = '/static/editor/upload/ue/raiders_candidate_img/'.$date.'/';
                $candidate_img[] = $dir_relative . $img_name.'.'.$img_mime;
            }
            $str = str_replace($match[0],$candidate_img,$str);
            $args['cont'] = $str;
        }
        $request = Func_Input::filter(array(
            'title' => '200',
            'des' => 'html',
            'cont' => 'html',
            'from_where' => 'string',
            'code_key' => 'string',
        ),$args);
        if (empty($request['code_key']) || (md5(($request['code_key'])) !== md5('yunspace'))) {
            $result = array(
                'status' => 0,
                'msg' => "操作错误",
                "data" => ''
            );
            return $result;
        }
        $data = $request;
        $data['create_time'] = time();
        $data['status'] = 3;
        $row = Data_Mysql_Table_Raiders_Candidate::insert($data);
        if ($row[0] > 0) {
            $result = self::request('success','','处理成功');
        }else{
            $result = self::request('error','','处理失败');
        }
        return $result;
    }
}