<?php

switch (Core::$urls['action']) {
    case  "sign":
        Tpl_Smarty::display('Web_Mobile_Static::sign_in/sign_in_list.tpl');
        break;
    case  "time":
        Tpl_Smarty::display('Web_Mobile_Static::sign_in/sign_in_time.tpl');
        break;
    case  "refuse":
        Tpl_Smarty::display('Web_Mobile_Static::sign_in/sign_in_mark_refuse.tpl');
        break;
}