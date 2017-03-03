<?php
switch (Core::$urls['action']) {
    case  "year":
        Tpl_Smarty::display('Web_Mobile_Static::wechat_year/year_index.tpl');
        break;

}