<!-- 遮罩层 -->
<div class="layer" id="layer"></div>

<!-- 地图弹窗 -->
<div class="modal fade" id="openMap" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
                <h4 class="modal-title" id="myModalLabel">
                    地图</h4>
            </div>
            <div class="modal-body map_con" style="height: 300px;" id="map_con">
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">
                    关闭
                </button>
            </div>
        </div>
    </div>
    <script type="text/javascript" src="http://api.map.baidu.com/api?v=2.0&ak=aaNCRRcGGai6klHMOGZ8yBbP"></script>
    <script>
        var mapIsOpen = false;
        $('#openMap').on('show.bs.modal', function (e) {
            openMap();
        })
        function openMap() {
            if (mapIsOpen)return;
            // 百度地图API功能
            var map = new BMap.Map("map_con");
            var point = new BMap.Point(116.331398, 39.897445);
            map.centerAndZoom(point, 12);
            map.enableScrollWheelZoom();   //启用滚轮放大缩小，默认禁用
            map.enableContinuousZoom();    //启用地图惯性拖拽，默认禁用
            var top_right_navigation = new BMap.NavigationControl({
                anchor: BMAP_ANCHOR_TOP_RIGHT,
                type: BMAP_NAVIGATION_CONTROL_SMALL
            }); //右上角，仅包含平移和缩放按钮
            map.addControl(top_right_navigation);
            // 创建地址解析器实例
            var myGeo = new BMap.Geocoder();
            // 将地址解析结果显示在地图上,并调整地图视野
            myGeo.getPoint("{$page->productInfo['city']}{$page->productInfo['addr']}", function (point) {
                if (point) {
                    map.centerAndZoom(point, 16);
                    var marker = new BMap.Marker(point);  // 创建标注
                    map.addOverlay(marker);
                    marker.setAnimation(BMAP_ANIMATION_BOUNCE); //跳动的动画
                } else {
                    alert("您选择地址没有解析到结果!");
                }
            }, "{$page->productInfo['city']}");
            mapIsOpen = true;
        }
    </script>
</div>