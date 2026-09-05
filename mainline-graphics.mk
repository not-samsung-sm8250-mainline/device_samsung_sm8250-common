# SPDX-License-Identifier: Apache-2.0
#
# Mainline graphics stack for sm8250 (Adreno 650 via Mesa Freedreno/Turnip).
#
# NOT inherited by any product yet. To use it, the manifest must provide
# external/minigbm-upstream and external/drm_hwcomposer (LineageOS mirrors),
# external/mesa already ships with AOSP. Then inherit this file after
# BoardConfigCommon.mk / sm8250-common.mk.
#
# Follows LineageOS android_device_mainline_common optional/mesa,
# optional/minigbm-upstream and optional/drm_hwcomposer.

# Mesa EGL + Vulkan (Turnip) instead of the downstream Adreno blobs.
TARGET_GRAPHICS := mesa
TARGET_GRAPHICS_EGL := mesa
TARGET_GRAPHICS_VULKAN := mesa
BOARD_MESA3D_GALLIUM_DRIVERS += freedreno
BOARD_MESA3D_VULKAN_DRIVERS += freedreno
PRODUCT_PACKAGES += \
    mesa3d
PRODUCT_VENDOR_PROPERTIES += \
    ro.hardware.egl=mesa \
    ro.hardware.vulkan=freedreno

# AIDL allocator/mapper backed by minigbm.
TARGET_GRAPHICS_ALLOCATOR_HAL := minigbm-upstream
# Bring-up only: enable every minigbm backend, narrow to msm once UI boots.
$(call soong_config_set,minigbm_upstream,platform,all)
PRODUCT_PACKAGES += \
    android.hardware.graphics.allocator-service.minigbm_upstream \
    mapper.minigbm_upstream
BOARD_VENDOR_SEPOLICY_DIRS += \
    external/minigbm-upstream/cros_gralloc/sepolicy

# AIDL composer backed by drm_hwcomposer.
TARGET_GRAPHICS_COMPOSER_HAL := drm_hwcomposer
TARGET_DRM_HWCOMPOSER_VARIANT := upstream
TARGET_DRM_HWCOMPOSER_HAL_INTERFACE := aidl
TARGET_DRM_HWCOMPOSER_INSIDE_APEX := false
PRODUCT_PACKAGES += \
    android.hardware.composer.hwc3-service.drm_upstream
