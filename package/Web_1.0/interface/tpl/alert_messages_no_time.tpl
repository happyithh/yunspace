<!DOCTYPE html>
<html>
<head>
    {include 'Web::inc/html_head.tpl'}
    <link rel="stylesheet" type="text/css" href="css/register-2.css">
    <style>
        @media (max-width: 1024px) {
            body {
                display: none;
            }
        }
    </style>
</head>
<body>
<!--头部  -->
{include 'Web::inc/header_nav.tpl'}

<div class="content">
    <div class="wrap con clearfix banner_wrap">
        <div class="register_person">
            <div class="reg_end reg_end2" style="width: 577px;">

                <p class="info_title">
                    <span><i class="fa fa-lightbulb-o"></i></span>{$info}
                </p>

            </div>
        </div>
    </div>
    <div class="clear"></div>
</div>
{include file="Web_Static::v2.0/html_footer.tpl"}
</body>
</html>