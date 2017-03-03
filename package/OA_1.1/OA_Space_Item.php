<?php
/**
 * Created by PhpStorm.
 * User: yl
 * Date: 15-10-16
 * Time: 上午10:02
 * 场地百科管理
 */
class OA_Space_Item{

    /*
     *获取子空间的列表信息
     */
    static function getSpaceItemList(){
        $condition['{prefix}spacepedia.id = ?']=$_REQUEST['space_id'];
        $item_lis=Api_Space_Item_List_And_Info::getSpaceItemList($condition);
        Tpl_Smarty::assign("item_list",$item_lis);
    }

    /*
     *子空间修改表单
     */
    static function editItemShow(){
        //获取所有标签
        $_REQUEST['search_type']=2;
        $tag_value=array();
        $tag_result = Api_Demand_Offer_Get_Demand_Tag_List::getTagList();
        if(!empty($tag_result['data'])){
            foreach($tag_result['data'] as $k=>$v){
                $tag_value[]=$v['tag_value'];
            }
        }
        Tpl_Smarty::assign('tag_value',$tag_value);
        if(!empty($_REQUEST['item_id'])){

            $space_item=Api_Space_Item_List_And_Info::getSpaceItemInfoById($_REQUEST['item_id']);
            if(empty($space_item)){
                Func_Header::back('子空间数据不存在！！');
            }
           if(!empty($space_item['tags'])){
                foreach($space_item['tags'] as $k=>$v){
                    if(!empty($v)){
                        $space_item['tags_name'][]=empty($tag_result['data'][$k]['tag_value'])?"":$tag_result['data'][$k]['tag_value'];
                    }
                }
            }
            Tpl_Smarty::assign('space_item',$space_item);
        }
        Tpl_Smarty::assign('location_area',Data_Mysql_Table_Space_Item::$location_area);
        Tpl_Smarty::assign('lifetime',Data_Mysql_Table_Space_Item::$lifetime);



    }

    /*
     *子空间修改表单提交
     */
    static function editItemInfoSubmit(){
        //处理提交的标签
        if(!empty($_REQUEST['data_i']['tags'])){
//            Func_Header::back('标签不能为空！！');
            $tags_arr=explode(",",$_REQUEST['data_i']['tags']);
            unset($_REQUEST['data_i']['tags']);
            foreach($tags_arr as $tk=>$tv){
                //添加标签
                $tags_id=Api_Demand_Offer_Check_Demand_Tag::getTagID($tv);
                if($tags_id){
                    $_REQUEST['data_i']['tags'][$tags_id]=1;
                }else{
                    continue;
                }
            }
        }

        $_REQUEST['data_i']['space_id']=$_REQUEST['space_id'];
        $_REQUEST['data_i']['item_id']=$_REQUEST['item_id'];
        $return=Api_Space_Item_Submit::spaceItemSubmit($_REQUEST['data_i']);
        if($return){
            Func_Header::to(" 子空间数据已添加/更新，请等待审核！！","?action=".$_REQUEST['action']."&space_id=".$_REQUEST['space_id']);
        }else{
            Func_Header::back("子空间数据添加/更新失败！！");
        }
    }
}