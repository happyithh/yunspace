<?php
switch(Core::$urls['action']){
    case  "retail":
        Tpl_Smarty::display('Web_Static::retail_special/retail_special.tpl');
        break;
    case  "dtl":
        Tpl_Smarty::display('Web_Static::retail_special/retail_special_detail.tpl');
        break;
}
