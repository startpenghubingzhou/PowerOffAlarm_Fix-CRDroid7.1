# PowerOffAlarm_Fix-CRDroid7.1
English|简体中文

##  What's This?

This module is intend to fix PowerOffAlarm not work on with enforcing-mode (SELinux) for CRDroid7.1 Whyred (RedMi Note 5 / Note 5 Pro) .

## How does it work?

The power off alarm clock stores its data in `/persist/alarm/data`,  which contains the time the device will power on. CRDroid7.1 has `com.qualcomm.qti.PowerOffAlarm` service and all the other necessary files to implement power-off alarm clock. However, this service has no access to `/persist/alarm/data` with enforcing-mode (aka SElinux) on since the ROM bug, which will cause the device can' t power on successfully.  This module fixed the access to `/persist/alarm/data` so that the time data can be written successfully, then the power-off alarm clock will work.

## How to use?

Just install it with `KernelSU`,  `ResukiSU` or other SU manager.

## How to Build?

Run `make` to build.

## License

This module observe MIT license.

## Acknowlegement

[@startpenghubingzhou](https://github.com/startpenghubingzhou/) for write this module
[@deepseek-ai](https://github.com/deepseek-ai/)  for DeepSeek