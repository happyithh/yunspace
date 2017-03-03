<?php
/**
 * Created by PhpStorm.
 * User: Administrator
 * Date: 15-4-14
 * Time: 下午6:33
 * yl
 * 全局标签
 */
switch (Core::$urls['action']) {
    case 'tags':
        Admin_Data_Table_Tags::handle();
        break;
    case 'add_son':
        Admin_Data_Table_Tags::handleAddSon();
        break;
    case 'interface':
        OA_Test_Interface::handle();
    default:
        Func_Header::notFound();
        break;
}
