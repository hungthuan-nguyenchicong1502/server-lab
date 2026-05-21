docker exec -it redis-alpine-ncc-feature redis-cli

127.0.0.1:6379> ping
PONG
127.0.0.1:6379> set test_key "Hello NCC"
OK
127.0.0.1:6379> get test_key
"Hello NCC"
127.0.0.1:6379> exit

# test

 internal-bridge-laravel-octane-feature:
  driver: bridge
  internal: true

docker network inspect internal-bridge-laravel-octane-feature

docker network rm internal-bridge-laravel-octane-feature

docker network prune -f