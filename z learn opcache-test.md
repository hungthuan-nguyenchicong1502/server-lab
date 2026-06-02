# opcache-test
apk add --no-cache php84-opcache

vi /etc/php84/conf.d/00_opcache.ini
## dev
```
## default: zend_extension=opcache
zend_extension=opcache.so
opcache.enable=1
opcache.enable_cli=1
```
## prod
```
opcache.enable=1
opcache.enable_cli=1        # Cực kỳ quan trọng vì Octane chạy qua giao diện CLI
opcache.memory_consumption=256
opcache.interned_strings_buffer=16
opcache.max_accelerated_files=20000
opcache.validate_timestamps=0 # Tắt hẳn việc check file thay đổi để đạt hiệu năng tối đa
```
# test
vi routes/web.php

```
use Illuminate\Support\Facades\Route;

Route::get('/opcache-test', function () {
    if (!function_exists('opcache_get_status')) {
        return response()->json(['status' => 'OPcache chưa được cài hoặc chưa bật!']);
    }

    $status = opcache_get_status();

    return response()->json([
        'enabled' => $status['opcache_enabled'],
        'cached_keys' => $status['opcache_statistics']['num_cached_keys'], // Số file đã được nạp vào RAM
        'free_memory_mb' => round($status['memory_usage']['free_memory'] / 1024 / 1024, 2),
        'jit' => $status['jit'] ?? 'Không hỗ trợ JIT', // Thêm dòng này để soi JIT
    ]);
});
```

## run https://hungthuan.com/opcache-test
https://hungthuan.com/opcache-test

## prod
vi /etc/php84/conf.d/00_opcache.ini
```
; Nạp extension (chọn 1 trong 2 cách viết)
;zend_extension=opcache
zend_extension=opcache.so

; [CẤU HÌNH KÍCH HOẠT]
opcache.enable=1
opcache.enable_cli=1        ; Bắt buộc phải có để ăn vào Laravel Octane (Swoole)

; [TỐI ƯU BỘ NHỚ & TÀI NGUYÊN]
opcache.memory_consumption=256       ; Cấp 256MB RAM để lưu Bytecode (Tăng nếu app siêu lớn)
opcache.interned_strings_buffer=16   ; Cấp 16MB để lưu các chuỗi trùng lặp (như biến, tên class)
opcache.max_accelerated_files=20000  ; Số lượng file tối đa cho phép cache (Laravel + Vendor khoảng ~5k-10k files)

; [TỐI ƯU HIỆU NĂNG - CỰC KỲ QUAN TRỌNG TRÊN PRODUCTION]
opcache.validate_timestamps=0        ; TẮT hẳn việc kiểm tra file vật lý thay đổi. Đạt tốc độ tối đa!
; opcache.revalidate_freq=0          ; Dòng này vô tác dụng khi validate_timestamps=0, giữ lại để tham khảo

; [TỐI ƯU COMPILER & ĐỘN/DỌN CODE]
opcache.save_comments=1              ; BẮT BUỘC bằng 1 để Laravel đọc được các Docblock (Annotations) của Package
opcache.fast_shutdown=1              ; Giải phóng bộ nhớ cực nhanh khi tắt tiến trình (PHP 7.2+ tự tối ưu nhưng ghi vào cho chắc)
opcache.max_wasted_percentage=10     ; Nếu lượng cache rác vượt quá 10%, OPcache sẽ tự động dọn dẹp

; [JIT COMPILER - ĐẶC SẢN TĂNG TỐC CỦA PHP 8+]
opcache.jit=tracing                  ; Bật JIT chế độ Tracing (Tối ưu nhất cho các ứng dụng web chạy lâu như Octane)
opcache.jit_buffer_size=64M          ; Cấp 64MB RAM riêng cho tầng biên dịch JIT mã máy trực tiếp
```

## docker file
find . -type f -name "*.php" | wc -l
```
Các mốc số nguyên tố mà OPcache dùng để cấu hình bảng băm (Hash Table):

3907
7963
16229 (Mốc số 1)
32531 (Mốc số 2)
65407
```
### opcache-prod.ini
### mo rong
```
opcache.memory_consumption=512       ; Tăng lên 512MB để thả ga lưu Bytecode và View Cache
opcache.interned_strings_buffer=32   ; Khi tăng memory lên 512M, nên tăng interned strings lên 32M để lưu chuỗi string thoải mái hơn
opcache.jit_buffer_size=64M          ; Giữ nguyên 64MB vì JIT dùng không bao giờ hết mốc này
```
```
; opcache-prod.ini
zend_extension=opcache.so
opcache.enable=1
opcache.enable_cli=1
opcache.memory_consumption=256
opcache.interned_strings_buffer=16
opcache.max_accelerated_files=15000
opcache.validate_timestamps=0
opcache.save_comments=1
opcache.fast_shutdown=1
opcache.max_wasted_percentage=10
opcache.jit=tracing
opcache.jit_buffer_size=64M
```
### docker file
```
# Cài đặt gói opcache (nếu chưa cài)
RUN apk add --no-cache php84-opcache

# COPY file cấu hình tối ưu từ thư mục gốc vào đường dẫn của Alpine
COPY opcache-prod.ini /etc/php84/conf.d/00_opcache.ini
```
### RUN echo ngay trong Dockerfile

```
# Cài đặt opcache
RUN apk add --no-cache php84-opcache

# Tạo/Ghi đè cấu hình tối ưu thẳng vào file ini của Alpine
RUN echo "zend_extension=opcache.so" > /etc/php84/conf.d/00_opcache.ini \
    && echo "opcache.enable=1" >> /etc/php84/conf.d/00_opcache.ini \
    && echo "opcache.enable_cli=1" >> /etc/php84/conf.d/00_opcache.ini \
    && echo "opcache.memory_consumption=256" >> /etc/php84/conf.d/00_opcache.ini \
    && echo "opcache.interned_strings_buffer=16" >> /etc/php84/conf.d/00_opcache.ini \
    && echo "opcache.max_accelerated_files=15000" >> /etc/php84/conf.d/00_opcache.ini \
    && echo "opcache.validate_timestamps=0" >> /etc/php84/conf.d/00_opcache.ini \
    && echo "opcache.save_comments=1" >> /etc/php84/conf.d/00_opcache.ini \
    && echo "opcache.fast_shutdown=1" >> /etc/php84/conf.d/00_opcache.ini \
    && echo "opcache.max_wasted_percentage=10" >> /etc/php84/conf.d/00_opcache.ini \
    && echo "opcache.jit=tracing" >> /etc/php84/conf.d/00_opcache.ini \
    && echo "opcache.jit_buffer_size=64M" >> /etc/php84/conf.d/00_opcache.ini
```

Lệnh đầu tiên sử dụng một dấu > duy nhất để xóa sạch nội dung cũ của file gốc (nếu có) và ghi dòng đầu tiên.

Các dòng sau sử dụng hai dấu >> để ghi nối đuôi vào cuối file.