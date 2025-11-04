# 变更日志

本项目的所有重大变更均会记录在此文件中。

格式基于 [Keep a Changelog](https://keepachangelog.com/en/1.0.0/)，

本项目遵循 [语义化版本控制](https://semver.org/spec/v2.0.0.html) 规范。

## [1.0.0](https://github.com/Huanyou229/hmutils_simple/releases/tag/v1.0.0) - 2025-10-29

### 新增

* 🎉 基础工具库首次发布

* 集成 hilog 的日志工具（Logger）


* 支持 debug、info、warn、error 四种日志级别

* 可配置领域（domain）和前缀（prefix）

* 简洁的可变参数调用接口

* 增强型导航管理路由模块（RouterModule）


* 基于 NavPathStack API 开发

* 支持页面入栈（push）、替换（replace）、出栈（pop）操作

* 带类型安全的导航参数管理

* 内置错误处理与日志记录

* 栈大小管理功能

* 数据持久化工具（PreferenceUtil）


* 支持全局上下文，简化使用流程

* 单例模式设计，基于文件隔离存储

* 数组操作方法（putToArray、removeFromArray）

* 自动错误处理机制

* 支持自定义偏好设置文件

* 通用枚举类型

* 存储键值枚举（AppStorageMap）

* 路由定义枚举（RouterMap）

* 完整支持 TypeScript/ArkTS

* 双语详细文档（英文 / 中文）

### 变更

* 无（首次发布）

### 弃用

* 无（首次发布）

### 移除

* 无（首次发布）

### 修复

* 无（首次发布）

### 安全相关

* 采用 HarmonyOS 5.0+ 最新 API

* 移除已弃用的 `getContext()` API 调用

* 实现规范的上下文管理机制

## API 迁移说明

### 从已弃用 API 迁移

本版本使用 HarmonyOS 最新 API，移除所有已弃用的 API 调用：

**旧 API（已弃用）：**

```
const context = getContext() as common.UIAbilityContext;
```

**新 API（当前）：**

```
// 在 UI 组件中

const context = this.getUIContext().getHostContext() as common.UIAbilityContext;

// 在工具类中

PreferenceUtil.initGlobalContext(context); // 初始化一次

PreferenceUtil.getInstance(); // 全局任意位置调用
```

## 升级指南

### 从预发布版本升级至 1.0.0

本版本为首次公开发布，暂无从先前版本的升级路径。

### 破坏性变更

* 无（首次发布）

## 已知问题

* 暂无已上报问题

## 路线图

### 1.1.0 版本（计划中）

新增网络工具模块

新增存储加密支持

新增更多通用工具（日期、字符串等）

路由模块（RouterModule）性能优化

新增单元测试

### 1.2.0 版本（计划中）

新增国际化（i18n）支持

新增主题管理工具

新增权限辅助工具

增强日志工具（Logger），支持文件输出

### 2.0.0 版本（未来规划）

基于社区反馈重构核心 API

支持 HarmonyOS NEXT 新特性

增强 TypeScript 严格模式支持

## 支持渠道

如需咨询、反馈问题或提出功能需求：

* GitHub Issues：https://github.com/Huanyou229/hmutils_simple/issues

* 邮箱：Huanyou229@outlook.com

## 贡献者

* 初始开发者：huanyou
