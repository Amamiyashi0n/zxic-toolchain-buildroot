################################################################################
#
# uclient-fetch
#
################################################################################

# 使用您提供的 Git 提交哈希值
UCLIENT_FETCH_VERSION = 99bd3d2b167ccdffb6de072d02c380cb37b23e33
# 指向 Buildroot 的本地下载目录
UCLIENT_FETCH_SITE = $(BR2_PRIMARY_SITE)
# 指定您创建的 tarball 文件名
UCLIENT_FETCH_SOURCE = ustream-ssl-20250727.tar.gz

# uclient-fetch 位于 ustream-ssl 仓库的子目录中
UCLIENT_FETCH_SUBDIRECTORY = uclient-fetch

# uclient-fetch 使用标准的 Makefile 构建系统
# 这里尝试在编译命令中添加 NO_SSL=1 宏，以禁用 SSL/HTTPS 支持
# 这是一个常见的 Makefile 选项，用于裁剪功能，但具体是否有效取决于 uclient-fetch 源码的 Makefile
# 如果后续编译失败，可以尝试移除此行
define UCLIENT_FETCH_BUILD_CMDS
	$(MAKE) -C $(@D)/$(UCLIENT_FETCH_SUBDIRECTORY) \
		$(TARGET_CONFIGURE_OPTS) \
		CROSS_COMPILE="$(TARGET_CROSS)" \
		ARCH=$(ARCH) \
		NO_SSL=1
endef

# 安装命令：将编译好的 uclient-fetch 可执行文件安装到目标系统的 /usr/bin/ 目录
define UCLIENT_FETCH_INSTALL_TARGET_CMDS
	$(INSTALL) -m 0755 $(@D)/$(UCLIENT_FETCH_SUBDIRECTORY)/uclient-fetch \
		$(TARGET_DIR)/usr/bin/uclient-fetch
endef

# 这是 Buildroot 包定义文件的必要行，请勿修改
$(eval $(generic-package))
