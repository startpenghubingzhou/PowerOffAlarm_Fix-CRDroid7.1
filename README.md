# PowerOffAlarm_Fix-CRDroid7.1
[English](https://github.com/startpenghubingzhou/PowerOffAlarm_Fix-CRDroid7.1)|[简体中文](https://github.com/startpenghubingzhou/PowerOffAlarm_Fix-CRDroid7.1/blob/main/README-CN.md)

##  What's This?

This module is intend to fix PowerOffAlarm not work on with enforcing-mode (SELinux) for CRDroid7.1 Whyred (RedMi Note 5 / Note 5 Pro) .

## How does it work?

The power off alarm clock stores its data in `/persist/alarm/data`,  which contains the time the device will power on. [CRDroid7.1 official](https://sourceforge.net/projects/crdroid/files/whyred/7.x/crDroidAndroid-11.0-20211002-whyred-v7.10.zip/download) has `com.qualcomm.qti.PowerOffAlarm` service and all the other necessary files to implement power-off alarm clock. However, this service has no access to `/persist/alarm/data` with enforcing-mode (aka SElinux) on since the ROM bug, which will cause the device can' t power on successfully.  This module fixed the access to `/persist/alarm/data` so that the time data can be written successfully, then the power-off alarm clock will work.

## How to use?

This project will build two files: one is `PowerOffAlarm_Fix-CRDroid7.1`, which is a module file, and the other is `PowerOffAlarm_REC_Fix-CRDroid7.1`, which is a TWRP installation package. You need to install `PowerOffAlarm_REC_Fix-CRDroid7.1` with TWRP first， Then install `PowerOffAlarm_Fix-CRDroid7.1` with `KernelSU`,  `ResukiSU` or other SU manager.

## How to Build?

Run  `make` in the project root directory to build.

## License

This module observe [MIT](https://github.com/startpenghubingzhou/PowerOffAlarm_Fix-CRDroid7.1/blob/main/LICENSE) license.

## Acknowlegement

[@startpenghubingzhou](https://github.com/startpenghubingzhou/) for write this module

[@deepseek-ai](https://github.com/deepseek-ai/)  for DeepSeek