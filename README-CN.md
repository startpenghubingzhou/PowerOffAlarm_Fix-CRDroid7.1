# PowerOffAlarm_Fix-CRDroid7.1
[English](https://github.com/startpenghubingzhou/PowerOffAlarm_Fix-CRDroid7.1)|[简体中文](https://github.com/startpenghubingzhou/PowerOffAlarm_Fix-CRDroid7.1/blob/main/README-CN.md)

## 这是什么？

此模块旨在修复CRDroid7.1 Whyred（红米Note 5 / Note 5 Pro）在启用强制模式（SELinux）时关机闹钟无法正常工作的问题。

## 它是如何工作的？

关机闹钟将其数据存储在`/persist/alarm/data`中，该文件包含设备开机的时间。CRDroid7.1拥有`com.qualcomm.qti.PowerOffAlarm`服务及实现关机闹钟的所有其他必需文件。然而，由于ROM问题，在启用强制模式（即SElinux）的情况下，此服务无法访问`/persist/alarm/data`，这将导致设备无法成功开机。此模块修复了对`/persist/alarm/data`的访问权限，以便能够成功写入时间数据，从而使关机闹钟能够正常工作。

## 如何使用？
只需使用`KernelSU`、`ResukiSU`或其他SU管理器进行安装即可。
## 如何构建？
运行`make`命令进行构建。
## 许可证
此模块遵循[MIT](https://github.com/startpenghubingzhou/PowerOffAlarm_Fix-CRDroid7.1/blob/main/LICENSE) 许可协议。
## 致谢
[@startpenghubingzhou](https://github.com/startpenghubingzhou/) 编写此模块
[@deepseek-ai](https://github.com/deepseek-ai/)  开发的DeepSeek
