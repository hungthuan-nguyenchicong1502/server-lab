<?php
/*
Plugin Name: Kill Image Crops System
Description: Chặn đứng hoàn toàn việc tự ý sinh ảnh rác của WP Core, RankMath và WooCommerce để tiết kiệm dung lượng ổ cứng.
Version: 1.0
Author: Solution Architect
*/

// Chặn đứng TẤT CẢ các bên thứ ba (Theme, WooCommerce, các plugin khác) tự ý tạo size ảnh mới
add_filter('intermediate_image_sizes_advanced', function($sizes) {
    
    // MẸO: Trích xuất giữ lại cấu hình của riêng thằng 'thumbnail'
    $thumbnail_size = isset($sizes['thumbnail']) ? $sizes['thumbnail'] : null;

    // Xóa sạch toàn bộ danh sách các size khác (medium, large, woocommerce_single,...)
    $sizes = [];

    // Nếu hệ thống có định nghĩa size thumbnail, ta nhét nó ngược lại vào mảng cho phép chạy
    if ($thumbnail_size) {
        $sizes['thumbnail'] = $thumbnail_size;
    }

    return $sizes;
});