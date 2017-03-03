<?php
/*
 * Created by PhpStorm
 * User: Yangchenglin
 * Date: 2015/8/11
 * Time: 11:03
 */
class Api_Vendor_Candidate_Check extends Api
{
    //接收采集来的数据
    static function handle($args='')
    {
        return self::handleCheck($args);
    }

    static function handleCheck($args)
    {
        $str = $args['product_media'];
        preg_match_all('/(http:\/\/.*?\.(jpg|png|bmp|jpeg|gif).*)/i',$str,$match);
        //根据正则获取到的远程图片地址循环下载图片
        $candidate_img = array();
        if(!empty($match[0])) {
            //最大采集10张图片
            $match[0] = array_slice($match[0], 0, 10);
            foreach ($match[0] as $k => $v) {
                $img = file_get_contents($v);
                $date = gmdate('Ymd');
                $dir = Core::virtualPath('upload/') .'vendor_candidate_img/'.$date.'/';
                Core::mkdir($dir, 0777, true);
                preg_match_all('/http:\/\/.+?\/([^\/]+\.(jpg|png|bmp|jpeg|gif))/i',$v,$match_v);
//                if(!empty($match_v[1][0])) {
//                    $img_name = str_replace('.','',$match_v[1][0]);
//                }
                if(!empty($match_v[2][0])) {
                    $img_mime = $match_v[2][0];
                }
                $img_name = time().mt_rand(111,999999);
                file_put_contents($dir . $img_name.'.'.$img_mime, $img);
                $candidate_img[$k]['path'] = '/upload/vendor_candidate_img/' .$date.'/'.$img_name.'.'.$img_mime;
                $candidate_img[$k]['name'] = mt_rand(1, 99999) . '.'.$img_mime;
                $candidate_img[$k]['tags'] = '';
                $candidate_img[$k]['video'] = '';
            }
        }
        $args['product_media'] = $candidate_img;

        $request = Func_Input::filter(array(
            //联系人字段->account账户表和contact_library联系人表
            'username' => 'string',
            'phone' => 'string',
            'business' => 'string',
            'sub_business' => 'string',
            'city' => 'string',
            'company' => 'string',

            //供应商字段->vendor_info_update表
            'vendor_name' => 'string',
            'vendor_categories_id' => 'int',
            'vendor_addr' => 'string',
            'vendor_logo' => 'string',
            'vendor_des' => 'html',
            'vendor_attr' => 'array',
            'vendor_base_info' => 'array',

            //产品字段->product_info_update表
            'product_name' => 'string',
            'product_category_id' => 'int',
            'product_addr' => 'string',
            'product_price' => 'int',
            'product_size' => 'int',
            'product_attr_new' => 'array',
            'product_des' => 'html',
            'product_media' => 'array',

            //'create_time' => 'int',     //入库时间
            //'status' => 'int',          //状态 1为已接受，2为重复，3为待处理，4为无效
            //'from_where' => 'int',      //数据来源 1为采集，2为表格导入
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
//        if (empty($request['city'])) {
//            $request['city'] = '上海';
//        }

        $data = $request;
        $data['create_time'] = time();
        $data['status'] = 3;
//        $data['from_where'] = 1;
        $row = Data_Mysql_Table_Vendor_Candidate::insert($data);
        if ($row[0] > 0) {
            $result = self::request('success','','处理成功');
        }else{
            $result = self::request('error','','处理失败');
        }
        return $result;
    }
}