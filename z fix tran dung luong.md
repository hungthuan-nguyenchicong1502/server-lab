# Xem có bao nhiêu tiến trình đang đăng ký inotify và số lượng cụ thể
find /proc/*/fd -lname anon_inode:inotify -exec stat -c '%h %p' {} \; 2>/dev/null | sort -nr

sysctl fs.inotify.max_user_watches fs.inotify.max_user_instances

cat /proc/sys/fs/file-nr

lsof -u cong | awk '{print $1}' | sort | uniq -c | sort -rn | head -n 10

lsof -i -P -n | grep docker

dmesg -T | tail -n 20

volumes:
  my_custom_data:
    driver: local
    driver_opts:
      type: 'none'
      o: 'bind'
      device: '/path/to/phandung/ocungmoi/data' # Thư mục trên ổ cứng phụ của bạn