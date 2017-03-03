<?php
/**
 * Created by PhpStorm.
 * User: Administrator
 * Date: 2015/5/27
 * Time: 14:39
 */
class Data_Mysql_Table_Help_Center extends Data_Mysql_Table
{
    public $cols = array(
        'username_id' => '200',
        'username' => '200',
        'title' => '200',
        'contents'=> 'html',                           // 文章内容
        'category' => '200',                           //  文章类别
        'create_time'=> 'int',                        //   创建时间
        'update_time'=> 'int',                        //   更新时间
        'hotsearch'=> 'int',                            //热门搜索
        'status'=> 'tinyint',                         //  1 发布   -n 删除
    );
    public $index = array (
        'title' => 'title',          //p:主键, u:唯一索引, i:索引
        'category'=> 'i',
        'status' => 'i',
    );

    public $title =array(
        'username' => '作者',
        'title' => '帮助中心标题',
        'category'=> '帮助中心文章分类',
        'status' => '状态'
    );
    static $category =array(
         1=> '注册流程',
         2=> '订单咨询',
         3=>'交易管理',
         4=>'云服务',
         5=>'云消息',
         6=>'云收藏',
         7=>'我的钱包',
         8=>'账户管理',
         9=>'订单查询',
         10=>'订单修改',
         11=>'订单取消',
         12=>'修改合同',
         13=>'订单审核',
         14=>'特色服务',
         15=>'价格保护',
         16=>'供应商加盟',
    );
    static $hotSearch = array(
        1=> '供应商',
        2=> '注册',
        3=> '订单',
        4=> '交易'
    );
    static function hotSearch($id){
        $conditions['id']=$id;
        $hot = Data_Mysql_Table_Help_Center::select('hotsearch',$conditions);
        if(empty($hot)){
            $data['hotsearch'] = 1;
        }else{
            $data['hotsearch'] = $hot[0]['hotsearch'] + 1;
        }
        Data_Mysql_Table_Help_Center::update($conditions,$data);
    }
}