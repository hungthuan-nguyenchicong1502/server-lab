# cloudflared-tunnel/_create-docker-compose-yml.mk

define CLOUDFLARED_TUNNEL_DOCKER_COMPOSE_YML
services:
  $(CLOUDFLARED_TUNNEL_NAME):
    # Sử dụng image alpine để nhẹ và đồng bộ với hệ điều hành chủ
    image: cloudflare/cloudflared:latest
    container_name: $(CLOUDFLARED_TUNNEL_NAME)
    restart: unless-stopped
    networks:
      - $(CLOUDFLARED_TUNNEL_NAME)-net
    environment:
      - TUNNEL_TOKEN=$${TUNNEL_TOKEN}
      # Thiết lập log level về mức fatal (chỉ ghi khi sập tunnel) để giảm I/O
      - TUNNEL_LOGLEVEL=fatal
    # Chuyển các thư mục làm việc và log vào RAM để triệt tiêu Disk I/O
    tmpfs:
      - /tmp
      - /home/nonroot/.cloudflared # Nơi cloudflared có thể ghi metadata tạm
    # Cấu hình logging của Docker về mức 'none' để không ghi log ra ổ cứng
    logging:
      driver: "none"
    command: tunnel --no-autoupdate run

networks:
  $(CLOUDFLARED_TUNNEL_NAME)-net:
    external: true
    name: $(MY_APP_NET)
endef

export CLOUDFLARED_TUNNEL_DOCKER_COMPOSE_YML

_cloudflared-tunnel/_create-docker-compose-yml.mk:
	@echo "_cloudflared-tunnel/_create-docker-compose-yml.mk"
	printf "$$CLOUDFLARED_TUNNEL_DOCKER_COMPOSE_YML" > $(CLOUDFLARED_TUNNEL_PROJECT_PATH)/docker-compose.yml

_cloudflared-tunnel/_create-docker-compose-yml.mk-cat:
	@echo "_cloudflared-tunnel/_create-docker-compose-yml.mk-cat"
	cat $(CLOUDFLARED_TUNNEL_PROJECT_PATH)/docker-compose.yml