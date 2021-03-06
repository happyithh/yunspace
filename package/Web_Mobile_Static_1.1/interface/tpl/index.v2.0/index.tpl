<!DOCTYPE html>
<html lang="en">
<head>
    <meta name=”viewport” content=”width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no”/>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta content="width=device-width,minimum-scale=1.0,maximum-scale=1.0,user-scalable=no,minimal-ui" name="viewport" />
    <meta name="apple-mobile-web-app-capable" content="yes" />
    <meta name="apple-mobile-web-app-status-bar-style" content="black">
    <meta content="telephone=no" name="format-detection" />
    <meta name="full-screen" content="yes" />
    <meta name="browsermode" content="application" />
    <meta name="x5-orientation" content="portrait" />
    <meta name="x5-fullscreen" content="true" />
    <meta name="x5-page-mode" content="app" />
    {include file="Web_Static::v2.0/html_goto_pc.tpl" url=""}
    {include "Web_Mobile_Static::v1.0/head_meta.tpl"}
    {static "v1.0/global.css"}
    {static "index.v2.0/index.css"}
    {static "v1.0/jquery-1.11.1.min.js"}
    {static "index.v2.0/index.v2.0.js"}
    <link rel="stylesheet" href="plugins/ionicons-master/css/ionicons.min.css">
</head>
<body>
<div yun="hide-app/hide-app.js::init" src=""></div>
{include 'Web_Mobile_Static::index.v2.0/home.tpl'}
{include 'Web_Mobile_Static::index.v2.0/city-select.tpl'}
{include 'Web_Mobile_Static::index.v2.0/search.tpl'}
{include "Web_Static::v2.0/html_tj.tpl"}
{static "core/yunspace.js"}
</body>
</html>