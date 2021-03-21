# Device Tree Xiaomi Mi A1 (Xiaomi Tissot)

The Xioami Mi A1 (codenamed _"tissot"_) is a smartphone from Xioami.
It was released in September 2017.

## Compile

First download omni-10.0 tree:

```
repo init -u git://github.com/minimal-manifest-twrp/platform_manifest_twrp_omni.git -b twrp-10.0
```
Then add this project to a new local manifest (.repo/local_manifests/<your-file-name.xml>: 

```xml
<project name="android_device_xiaomi_tissot" path="device/xiaomi/tissot" remote="TeamWin" revision="android-10.0" />
```

Now you can sync your source:

```
repo sync
```

To automatically make the twrp installer, you need to import this commit in the build/make path: https://gerrit.omnirom.org/#/c/android_build/+/33182/
and add @osm0sis' standard twrp_abtemplate repo to a local manifest as indicated below (followed by another `repo sync` to download the repo):

```xml
<project name="osm0sis/twrp_abtemplate" path="bootable/recovery/installer" remote="github" revision="master"/>
```

Finally execute these:

```
. build/envsetup.sh
lunch omni_tissot-eng 
mka bootimage
```

To test it:

```
fastboot boot out/target/product/tissot/boot.img
```
