# 发票自动管理分类系统 · Invoice Auto Sorter

<div align="center">

![Python](https://img.shields.io/badge/Python-3.9+-blue.svg)
![PyQt5](https://img.shields.io/badge/PyQt5-5.15+-green.svg)
![License](https://img.shields.io/badge/License-MIT-yellow.svg)

基于 PyQt5 的本地发票智能解析与分类工具，支持批量导入、OCR 识别、规则校验与账单导出。

[功能特性](#-功能特性) • [快速开始](#-快速开始) • [使用方法](#-使用方法) • [运行与构建](#-运行与构建) • [配置说明](#-配置说明) • [环境要求](#-环境要求) • [部署](#-部署) • [测试](#-测试) • [项目结构](#-项目结构) • [常见问题](#-常见问题) • [开发者](#-开发者)

</div>

---

## 📖 项目简介
发票自动管理分类系统是一个桌面端开源工具，面向需要高效整理发票的用户。通过 PDF 文本解析与 OCR（pytesseract + pdfium 加速），自动提取发票基础信息、商品明细并完成分类与校验，可一键导出标准 Excel 账单。

## ✨ 功能特性
- 批量导入 PDF 发票（中国电子发票）
- 自动提取发票号、开票日期、销售方/购买方、含税总额
- 明细提取：名称、数量、单价、金额、规格
- 关键词分类映射（耗材/设备/其他），支持手动修正
- 内置校验：必填项、金额一致性、购买方抬头匹配、重复检测
- 列表标签/校验状态展示，金额汇总
- 导出标准账单 Excel（含汇总行，可自定义目录）
- 配置管理：Tesseract 路径、OCR 语言、预览分辨率、自动校验/备份

## 🚀 快速开始
```bash
# Python 3.9+；可选虚拟环境
python -m venv .venv
.\.venv\Scripts\activate

# 安装依赖
pip install -U pip
pip install PyQt5 pdfplumber pypdfium2 pytesseract opencv-python pillow pandas openpyxl matplotlib numpy

# 运行
python main.py
```
首次运行若未找到 Tesseract，会弹窗提示。请安装 Tesseract-OCR 并在配置中填写路径，或将 `Tesseract-OCR` 目录与程序放在同级。

## 🧭 使用方法
- 导入：点击“批量导入发票”，选择 PDF 文件夹或多选 PDF；列表会展示解析进度。
- 预览与校验：左侧列表选中任意发票，右侧展示明细；校验结果与标签会标在列表行。
- 编辑：双击明细行可修改名称/数量/单价/分类等；分类下拉可手动调整。
- 重新识别：如 OCR 语言需调整，在设置中修改 `ocr_lang` 后重新导入或手动触发识别。
- 筛选与标记：支持按校验状态、标签筛查重复/异常发票。
- 导出：点击“导出账单”，选择目录；将生成符合账单模板的 Excel，并在末行附汇总。
- 自动加载：若开启 `auto_load_invoices`，下次启动自动恢复上次列表。

## 🛠️ 运行与构建
- 开发运行：`python main.py`
- Windows 打包（PyInstaller）：
  ```bash
  pyinstaller main.spec
  # 产物位于 dist/main.exe（或使用已有的 Output/Qz发票账单生成.exe）
  ```
- 图标：`logo.ico`
- PDF 渲染：`pdfium.dll` 自动寻址已在 `main.py` 处理，确保打包产物中包含。

## ⚙️ 配置说明
配置文件：`config.json`（启动自动读取/写入），主要字段：
- `tesseract_path`：Tesseract 可执行文件路径
- `ocr_lang`：OCR 语言包（例：`chi_sim`）
- `auto_load_invoices`：启动时自动加载上次发票列表
- `match_tolerance`：金额比较容差
- `auto_backup`/`backup_interval`/`backup_path`：自动备份
- `export_path`/`export_include_validation`：导出目录与校验信息
- `auto_validate`/`validation_strictness`：自动校验与严格度
- `list_show_tags`/`list_show_validation`：列表显示开关
- `preview_resolution`：PDF 预览分辨率
- `buyer_expected_name`：期望购买方抬头，用于校验提示

## 🧩 环境要求
- Python 3.9+（建议 64 位）
- Windows 10/11；其他平台需自测 PyQt5 与 Tesseract
- 依赖：PyQt5、pdfplumber、pypdfium2、pytesseract、opencv-python、pillow、pandas、openpyxl、matplotlib、numpy
- 外部：Tesseract-OCR（含语言包）

## 🚢 部署
- 开发者打包：`pyinstaller main.spec`，将 `dist/main.exe` 与 `Tesseract-OCR`（如需）放置同级即可分发。
- 便携示例：仓库已提供 `dist/main.exe` 与 `Output/Qz发票账单生成.exe`，可直接运行。

## ✅ 测试
- 解析测试：`python test_parser.py`
- 导出测试：`python test_export.py`（生成 `test_export.xlsx`）
- 手工验证：在 UI 中导入样例 `发票/` 查看解析与校验提示。

## 📁 项目结构
- `main.py`：GUI、解析、校验、导出核心逻辑
- `config.json`：默认配置
- `发票/`：样例 PDF
- `支付记录/`：样例付款截图
- `dist/`：已构建可执行文件
- `build/`：PyInstaller 中间产物
- `hooks/`：PyInstaller 自定义 hook（pdfium）
- `test_parser.py` / `test_export.py`：功能验证脚本
- `Output/`：示例输出可执行文件

## ❓ 常见问题
- 找不到 Tesseract：安装 Tesseract-OCR，设置 `config.json` 的 `tesseract_path` 或环境变量 `TESSERACT_PATH`。
- PDF 解析为空：确认为文本版电子发票；如是扫描件请安装对应 OCR 语言包后重试。
- 金额不一致：校验容差 0.01 元，差异大请检查明细或手动修正。
- 发票号重复：导入同号会标记错误，可在列表筛查。

## 👨‍💻 开发者与联系
- 开发者：石殷睿
- 邮箱：SYRQuartz@gmail.com
- 反馈：欢迎提交 Issue/PR 改进解析准确率、分类规则或 UI 体验。
