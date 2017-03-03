<?php
/*
 * Created by PhpStorm
 * User: Yangchenglin
 * Date: 2015/10/26
 * Time: 14:03
 */
class OA_Vendor_Delete_Img
{
    static function handle()
    {
        $action = empty($_REQUEST['action']) ? 'img_list' : $_REQUEST['action'];
        if($action == 'img_list') {
            self::handleImgList();
        } elseif ($action == 'deal') {
            self::handleDeal();
        }elseif($action == 'change_status'){
            self::changeStatus();
        }
    }


    static function handleImgList()
    {
        $conditions[] = '{table}.from_where like "%taohuichang.com%"';
//        $conditions['status'] = 1;
        $handle_type = empty($_REQUEST['handle_type']) ? 'waiting' : $_REQUEST['handle_type'];
        switch ($handle_type) {
            case "waiting":
                $conditions['{table}.is_deal_water = ? '] = 0;
                break;
            case "pass":
                $conditions['{table}.is_deal_water = ? '] = 1;
                break;
        }
        $rs = Data_Mysql_Table_Vendor_Candidate::page(0,0,'id,product_name,from_where', $conditions);
        Tpl_Smarty::assign('handle_type',$handle_type);
        Tpl_Smarty::assign('data',$rs);
        Tpl_Smarty::display('OA_Static', 'water_img/img_list.tpl');

    }



    static function handleDeal()
    {
        return 1;
        if (empty($_REQUEST['id'])) {
            Func_Header::back('参数错误！');
        }
        $conditions['id'] = $_REQUEST['id'];
        $ra = Data_Mysql_Table_Vendor_Candidate::select('id,product_media,status',$conditions);
        if(empty($ra)) {
            Func_Header::back('没有相关图片');
        }
        $ra[0]['product_media'] = json_decode($ra[0]['product_media'], 1);
        if($ra[0]['status'] == 1) {
            if(file_exists(Core::virtualPath('upload/').mb_substr($ra[0]['product_media'][0]['path'],8))) {
                foreach ($ra[0]['product_media'] as $kk => $vv) {
                    Func_Image::thumbImage(Core::virtualPath('upload/').mb_substr($vv['path'],8), Core::virtualPath('upload/').mb_substr($vv['path'],8), 0, 0, 590, 440, 590);
                }
            }else{
                foreach ($ra[0]['product_media'] as $kk => $vv) {
                    Func_Image::thumbImage(Core::virtualPath('upload2/').mb_substr($vv['path'],8), Core::virtualPath('upload2/').mb_substr($vv['path'],8), 0, 0, 590, 440, 590);
                }
            }
        } else {
            foreach ($ra[0]['product_media'] as $k => $v) {
                Func_Image::thumbImage(Core::virtualPath('upload/').mb_substr($v['path'],8), Core::virtualPath('upload/').mb_substr($v['path'],8), 0, 0, 590, 440, 590);
            }
        }

        $rs_candidate = Data_Mysql_Table_Vendor_Candidate::update(array('id'=>$_REQUEST['id']),array('is_deal_water' => 1));
        if(!empty($rs_candidate[0])) {
            Func_Header::to(' 处理成功！', Core::$urls['path']);
        }
    }

    static function  changeStatus(){
        for($i=1;$i<=145;$i++){
           $rs =  self::doQuery();
            if(empty($rs)){
                echo "<script>alert('没有数据了');</script>";
                break;
            }else{
                Core::log('条数',$i,22);
            }
        }
        Func_Header::back(' 处理成功！');
    }

    static function doQuery(){
        return 1;
        $table = "{table} as tb1 LEFT JOIN {prefix}vendor_candidate AS tb2 ON tb1.addr=tb2.product_addr";
        $conditions =array(
            'tb1.create_by_quick!=?'=>3,
        );
        $conditions[] = 'tb2.from_where like "%taohuichang.com%"';
        $list = Data_Mysql_Table_Product_Info::subTable('_update')->select('tb1.id',$conditions,'',100,$table);
        $ids = array();
        $rs=0;
        if(!empty($list)){
            foreach($list as $k=>$v){
                $ids[] =$v['id'];
                $rs++;
            }
        }
        Data_Mysql_Table_Product_Info::debug(1);
        Data_Mysql_Table_Product_Info::subTable('_update')->update(array("id in (".implode(',',$ids).")"),array('create_by_quick=?'=>3));
        Data_Mysql_Table_Product_Info::update(array("id in (".implode(',',$ids).")"),array('create_by_quick=?'=>3));
        return $rs;
    }
}