<?php
switch (Core::$urls['action']) {
    case  "bk":
        Tpl_Smarty::display('Web_Static::baike.v1.0/baike.tpl');
        break;
    case  "bk1":
        Tpl_Smarty::display('Web_Static::baike.v1.0/baike_old.tpl');
        break;
}