const options = @import("options");
const ShellyTabs = @import("../models/shelly_config.zig").ShellyTabs;

pub const version = options.version;

pub const flatpak_backend_package = options.flatpak_backend_package;

pub const builtWithDevario = options.devario;

pub const builtWithBackgroundServices = !options.skip_background_services;

pub const builtWithFlatpak = !options.exclude_flatpak;
pub const builtWithAur = !options.exclude_aur;
pub const builtWithRecommend = !options.exclude_recommend;
pub const builtWithAppImage = !options.exclude_appimage;
pub const builtWithShellySearch = !options.exclude_shelly_search;

pub fn builtWith(tab: ShellyTabs) bool {
    return switch (tab) {
        .packages, .update => true,
        .recommend => builtWithRecommend,
        .aur => builtWithAur,
        .flatpak => builtWithFlatpak,
        .app_image => builtWithAppImage,
        .shelly_search => builtWithShellySearch,
    };
}
