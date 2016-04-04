LOCAL_PATH := $(call my-dir)

apps := AtvWidget \
    FuguPairingTutorial \
    PlayGames \
    VideosPano \
    Backdrop \
    LeanbackIme  \
    SecondScreenSetup \
    WebViewGoogle \
    BugReportSender \
    Music2Pano \
    SecondScreenSetupAuthBridge \
    YouTubeLeanback \
    CanvasPackageInstaller \
    NoTouchAuthDelegate \
    TvVoiceInput \
    talkback

priv-apps := AndroidMediaShell \
    AtvCustomization \
    AtvRemoteService \
    ConfigUpdater \
    GamepadPairingService \
    GlobalKeyInterceptor \
    GoogleBackupTransport \
    GoogleServicesFramework \
    Katniss \
    Overscan \
    PhoneskyKamikazeCanvas \
    PrebuiltGmsCorePano \
    RemoteControlService \
    SetupWraith \
    TV

define include_app
$(eval include $$(CLEAR_VARS))
$(eval LOCAL_MODULE := $(1))
$(eval LOCAL_PRIVILEGED_MODULE := false)
$(eval LOCAL_MODULE_CLASS := APPS)
$(eval LOCAL_SRC_FILES := app/$(1)/$(1).apk)
$(eval LOCAL_PREBUILT_JNI_LIBS := $(subst $(LOCAL_PATH)/,,$(wildcard $(LOCAL_PATH)/app/$(1)/lib/x86/*.so)))
$(eval LOCAL_CERTIFICATE := PRESIGNED)
$(eval include $$(BUILD_PREBUILT))
endef

define include_priv_app
$(eval include $$(CLEAR_VARS))
$(eval LOCAL_MODULE := $(1))
$(eval LOCAL_PRIVILEGED_MODULE := true)
$(eval LOCAL_MODULE_CLASS := APPS)
$(eval LOCAL_SRC_FILES := priv-app/$(1)/$(1).apk)
$(eval LOCAL_PREBUILT_JNI_LIBS := $(subst $(LOCAL_PATH)/,,$(wildcard $(LOCAL_PATH)/priv-app/$(1)/lib/x86/*.so)))
$(eval LOCAL_CERTIFICATE := PRESIGNED)
$(eval include $$(BUILD_PREBUILT))
endef

$(foreach app,$(apps),$(eval $(call include_app,$(app))))
$(foreach priv-app,$(priv-apps),$(eval $(call include_priv_app,$(priv-app))))

include $(CLEAR_VARS)
LOCAL_MODULE := LeanbackLauncher
LOCAL_PRIVILEGED_MODULE := true
LOCAL_MODULE_CLASS := APPS
LOCAL_SRC_FILES := priv-app/$(LOCAL_MODULE)/$(LOCAL_MODULE).apk
LOCAL_PREBUILT_JNI_LIBS := $(wildcard priv-app/$(LOCAL_MODULE)/lib/x86/*.so)
LOCAL_OVERRIDES_PACKAGES := Launcher2
LOCAL_CERTIFICATE := PRESIGNED
include $(BUILD_PREBUILT)


