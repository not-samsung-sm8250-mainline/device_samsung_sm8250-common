# SPDX-License-Identifier: Apache-2.0
#
# Mainline graphics stack for sm8250 (Adreno 650 via Mesa Freedreno/Turnip).
#
# Follows LineageOS android_device_mainline_common optional/mesa,
# optional/minigbm-upstream and optional/drm_hwcomposer.

TARGET_USES_MAINLINE_GRAPHICS := true

# Mesa EGL + Vulkan (Turnip) instead of the downstream Adreno blobs.
TARGET_GRAPHICS := mesa
TARGET_GRAPHICS_EGL := mesa
TARGET_GRAPHICS_VULKAN := mesa
PRODUCT_PACKAGES += \
    mesa3d
PRODUCT_VENDOR_PROPERTIES += \
    ro.hardware.egl=mesa \
    ro.hardware.vulkan=freedreno

# AIDL allocator/mapper backed by minigbm.
TARGET_GRAPHICS_ALLOCATOR_HAL := minigbm-upstream
TARGET_MINIGBM_PLATFORM := gbm_mesa
$(call soong_config_set,minigbm_upstream,platform,$(TARGET_MINIGBM_PLATFORM))
$(call soong_config_set_bool,minigbm_upstream,enable_gbm_mesa_driver,true)
PRODUCT_PACKAGES += \
    dri_gbm \
    libgbm_mesa \
    android.hardware.graphics.allocator-service.minigbm_upstream \
    mapper.minigbm_upstream
ifeq ($(TARGET_MAINLINE_SIMPLEDRM_BOOTSTRAP),true)
PRODUCT_VENDOR_PROPERTIES += \
    vendor.minigbm.avoid_ubwc=true
endif

# AIDL composer backed by drm_hwcomposer.
TARGET_GRAPHICS_COMPOSER_HAL := drm_hwcomposer
TARGET_DRM_HWCOMPOSER_VARIANT := upstream
TARGET_DRM_HWCOMPOSER_HAL_INTERFACE := aidl
TARGET_DRM_HWCOMPOSER_INSIDE_APEX := false
PRODUCT_PACKAGES += \
    android.hardware.composer.hwc3-service.drm_upstream

# AIDL memtrack replacement for the downstream QTI service.
TARGET_MEMTRACK_HAL := default-aidl
PRODUCT_PACKAGES += \
    com.android.hardware.memtrack
