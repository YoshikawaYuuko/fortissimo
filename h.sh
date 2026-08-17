#!/bin/bash

repo init -u https://github.com/Evolution-X/manifest.git -b bka --git-lfs --depth=1
/opt/crave/resync.sh # sync source

rm -rf device/xiaomi/earth
git clone https://github.com/YoshikawaYuuko/android_device_xiaomi_earth.git -b EvolutionX-16 device/xiaomi/earth

# for when gms not synced
git clone --depth=1 https://github.com/Evolution-X/vendor_gms.git -b bka vendor/gms

export BUILD_USERNAME=yuuko
export BUILD_HOSTNAME=sweet_bullet

# build start
. build/envsetup.sh
lunch lineage_earth-bp4a-userdebug
make installclean
m evolution

# Upload files to gofile
echo "Upload to gofile will be started..."
if [ -f out/target/product/earth/*202608*.zip ]; then
    wget https://raw.githubusercontent.com/lordgaruda/GoFile-Upload/refs/heads/master/upload.sh
    chmod +x upload.sh ; ./upload.sh out/target/product/earth/*202608*.zip
    echo "Upload Done!"
else
    echo "No zip found!" 
fi
