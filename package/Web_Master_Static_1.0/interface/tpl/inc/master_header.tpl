<!-- BEGIN HEADER -->
<header class="page-header">
    <nav class="navbar mega-menu" role="navigation">
        <div class="container-fluid">
            <div class="clearfix navbar-fixed-top">
                <div class="cover none"></div>
                <!-- Brand and toggle get grouped for better mobile display -->
                <button type="button" class="navbar-toggle" data-toggle="collapse">
                    <!--data-target=".navbar-responsive-collapse"-->
                    <span class="sr-only">Toggle navigation</span>
                                <span class="toggle-icon">
                                    <span class="icon-bar"></span>
                                    <span class="icon-bar"></span>
                                    <span class="icon-bar"></span>
                                </span>
                </button>
                <!-- End Toggle Button -->
                <!-- BEGIN LOGO -->
                <a id="index" class="page-logo" href="{$_route}index.html">
                    <img src="img/logo.png" alt="Logo"> </a>
                <!-- END LOGO -->
                <!-- BEGIN SEARCH -->
                <form class="search" action="extra_search.html" method="GET">
                    <input type="name" class="form-control" name="query" placeholder="Search...">
                    <a href="javascript:;" class="btn submit">
                        <i class="fa fa-search"></i>
                    </a>
                </form>
                <!-- END SEARCH -->
                <!-- BEGIN TOPBAR ACTIONS -->
                <div class="topbar-actions">
                    <!-- BEGIN GROUP NOTIFICATION -->
                    <div class="btn-group-notification btn-group" id="header_notification_bar">
                        <button type="button" class="btn btn-sm dropdown-toggle" data-toggle="dropdown" data-hover="dropdown" data-close-others="true">
                            <i class="icon-bell"></i>
                            <span class="badge">7</span>
                        </button>
                        <ul class="dropdown-menu-v2">
                            <li class="external">
                                <h3>
                                    <span class="bold">12 pending</span> notifications</h3>
                                <a href="#">view all</a>
                            </li>
                            <li>
                                <ul class="dropdown-menu-list scroller" style="height: 250px; padding: 0;" data-handle-color="#637283">
                                    <li>
                                        <a href="javascript:;">
                                                        <span class="details">
                                                            <span class="label label-sm label-icon label-success">
                                                                <i class="fa fa-plus"></i>
                                                            </span> New user registered. </span>
                                            <span class="time">just now</span>
                                        </a>
                                    </li>
                                    <li>
                                        <a href="javascript:;">
                                                        <span class="details">
                                                            <span class="label label-sm label-icon label-danger">
                                                                <i class="fa fa-bolt"></i>
                                                            </span> Server #12 overloaded. </span>
                                            <span class="time">3 mins</span>
                                        </a>
                                    </li>
                                    <li>
                                        <a href="javascript:;">
                                                        <span class="details">
                                                            <span class="label label-sm label-icon label-warning">
                                                                <i class="fa fa-bell-o"></i>
                                                            </span> Server #2 not responding. </span>
                                            <span class="time">10 mins</span>
                                        </a>
                                    </li>
                                    <li>
                                        <a href="javascript:;">
                                                        <span class="details">
                                                            <span class="label label-sm label-icon label-info">
                                                                <i class="fa fa-bullhorn"></i>
                                                            </span> Application error. </span>
                                            <span class="time">14 hrs</span>
                                        </a>
                                    </li>
                                    <li>
                                        <a href="javascript:;">
                                                        <span class="details">
                                                            <span class="label label-sm label-icon label-danger">
                                                                <i class="fa fa-bolt"></i>
                                                            </span> Database overloaded 68%. </span>
                                            <span class="time">2 days</span>
                                        </a>
                                    </li>
                                    <li>
                                        <a href="javascript:;">
                                                        <span class="details">
                                                            <span class="label label-sm label-icon label-danger">
                                                                <i class="fa fa-bolt"></i>
                                                            </span> A user IP blocked. </span>
                                            <span class="time">3 days</span>
                                        </a>
                                    </li>
                                    <li>
                                        <a href="javascript:;">
                                                        <span class="details">
                                                            <span class="label label-sm label-icon label-warning">
                                                                <i class="fa fa-bell-o"></i>
                                                            </span> Storage Server #4 not responding dfdfdfd. </span>
                                            <span class="time">4 days</span>
                                        </a>
                                    </li>
                                    <li>
                                        <a href="javascript:;">
                                                        <span class="details">
                                                            <span class="label label-sm label-icon label-info">
                                                                <i class="fa fa-bullhorn"></i>
                                                            </span> System Error. </span>
                                            <span class="time">5 days</span>
                                        </a>
                                    </li>
                                    <li>
                                        <a href="javascript:;">
                                                        <span class="details">
                                                            <span class="label label-sm label-icon label-danger">
                                                                <i class="fa fa-bolt"></i>
                                                            </span> Storage server failed. </span>
                                            <span class="time">9 days</span>
                                        </a>
                                    </li>
                                </ul>
                            </li>
                        </ul>
                    </div>
                    <!-- END GROUP NOTIFICATION -->
                    <!-- BEGIN GROUP INFORMATION -->
                    <div class="btn-group-red btn-group">
                        <button type="button" class="btn btn-sm dropdown-toggle" data-toggle="dropdown" data-hover="dropdown" data-close-others="true">
                            <i class="fa fa-plus"></i>
                        </button>
                        <ul class="dropdown-menu-v2" role="menu">
                            <li class="active">
                                <a href="#">New Post</a>
                            </li>
                            <li>
                                <a href="#">New Comment</a>
                            </li>
                            <li>
                                <a href="#">Share</a>
                            </li>
                            <li class="divider"></li>
                            <li>
                                <a href="#">Comments
                                    <span class="badge badge-success">4</span>
                                </a>
                            </li>
                            <li>
                                <a href="#">Feedbacks
                                    <span class="badge badge-danger">2</span>
                                </a>
                            </li>
                        </ul>
                    </div>
                    <!-- END GROUP INFORMATION -->
                    <!-- BEGIN USER PROFILE -->
                    <div class="btn-group-img btn-group">
                        <button type="button" class="btn btn-sm dropdown-toggle" data-toggle="dropdown" data-hover="dropdown" data-close-others="true">
                            <span>Hi, Marcus</span>
                            <img src="img/avatar1.jpg" alt=""> </button>
                        <ul class="dropdown-menu-v2" role="menu">
                            <li>
                                <a href="page_user_profile_1.html">
                                    <i class="icon-user"></i> My Profile
                                    <span class="badge badge-danger">1</span>
                                </a>
                            </li>
                            <li>
                                <a href="app_calendar.html">
                                    <i class="icon-calendar"></i> My Calendar </a>
                            </li>
                            <li>
                                <a href="app_inbox.html">
                                    <i class="icon-envelope-open"></i> My Inbox
                                    <span class="badge badge-danger"> 3 </span>
                                </a>
                            </li>
                            <li>
                                <a href="app_todo_2.html">
                                    <i class="icon-rocket"></i> My Tasks
                                    <span class="badge badge-success"> 7 </span>
                                </a>
                            </li>
                            <li class="divider"> </li>
                            <li>
                                <a href="page_user_lock_1.html">
                                    <i class="icon-lock"></i> Lock Screen </a>
                            </li>
                            <li>
                                <a href="page_user_login_1.html">
                                    <i class="icon-key"></i> Log Out </a>
                            </li>
                        </ul>
                    </div>
                    <!-- END USER PROFILE -->
                    <!-- BEGIN QUICK SIDEBAR TOGGLER -->
                    <button type="button" class="quick-sidebar-toggler" data-toggle="collapse">
                        <span class="sr-only">Toggle Quick Sidebar</span>
                        <i class="icon-logout"></i>
                    </button>
                    <!-- END QUICK SIDEBAR TOGGLER -->
                </div>
                <!-- END TOPBAR ACTIONS -->
            </div>

            <!-- BEGIN HEADER MENU -->
            <div class="nav-collapse collapse navbar-collapse navbar-responsive-collapse in fix-nav" style="display: block">
                <div class="nav-relative">
                    <ul class="nav navbar-nav">
                        <li class="dropdown dropdown-fw  ">
                            <a href="javascript:;" class="text-uppercase">
                                <i class="icon-home"></i> 控制中心 </a>
                        </li>
                        <li class="dropdown dropdown-fw  ">
                            <a href="javascript:;" class="text-uppercase">
                                <i class="icon-puzzle"></i> 业务管理 </a>
                        </li>
                        <li class="dropdown dropdown-fw  ">
                            <a href="javascript:;" class="text-uppercase">
                                <i class="icon-briefcase"></i> 场地管理 </a>
                        </li>
                        <li class="dropdown dropdown-fw  active open selected">
                            <a href="javascript:;" class="text-uppercase">
                                <i class="icon-layers"></i> 团队管理 </a>
                        </li>
                    </ul>
                </div>

                <div class="close-nav">
                    <span class="fa fa-close"></span>
                </div>
            </div>
            <!-- END HEADER MENU -->
        </div>
        <!--/container-->
    </nav>
</header>