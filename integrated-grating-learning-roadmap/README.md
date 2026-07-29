# 集成波导光栅 30 天一站式学习路线图

本学习包面向已掌握 Maxwell 方程、波导模式和有效折射率法的学习者，从集成波导光栅出发，依次学习均匀布拉格光栅、切趾与啁啾光栅、多模/偏振耦合光栅，以及集成垂直光栅耦合器。

## 🚀 开始学习

📑 **打开 [`docs/30_day_roadmap.md`](docs/30_day_roadmap.md)** — 这是唯一需要逐天跟随的文件。

每天直接列出：学习目标、具体推导任务、教材章节+页码、论文+DOI链接、对应代码文件、产出要求。

### 其他文档（按需查阅）

| 文档 | 用途 |
|---|---|
| [`docs/30_day_roadmap.md`](docs/30_day_roadmap.md) | **← 主入口**，一站式30天路线图 |
| [`docs/theory_notes.md`](docs/theory_notes.md) | 理论推导骨架（9章，从 CMT 到全波方法） |
| [`docs/vertical_gc_theory_deep.md`](docs/vertical_gc_theory_deep.md) | 垂直光栅耦合器深化理论（Green函数法+解析设计） |
| [`docs/conventions.md`](docs/conventions.md) | 数学与物理约定（时间因子、单位、端口定义） |
| [`docs/stage_outline.md`](docs/stage_outline.md) | 阶段总纲（知识主线、五套必备理论、SiN/LNOI对照） |
| [`docs/references.md`](docs/references.md) | 核心论文文献索引 |
| [`docs/references_supplement.md`](docs/references_supplement.md) | 补充文献（高阶模式+垂直光栅+最新进展） |
| [`docs/enhanced_bookshelf.md`](docs/enhanced_bookshelf.md) | 12本核心教材的章节映射（备查） |
| [`docs/cbg_review_integration.md`](docs/cbg_review_integration.md) | CBG-SiN综述与学习阶段映射（备查） |
| [`docs/progress_tracker.md`](docs/progress_tracker.md) | 每日进度记录模板 |
| [`docs/INDEX.md`](docs/INDEX.md) | 完整文档地图和交叉引用 |

### 旧版日程（已被 roadmap 替代，保留备查）

| 文档 | 说明 |
|---|---|
| [`docs/30_day_schedule.md`](docs/30_day_schedule.md) | 旧版日程（含MATLAB，信息分散） |
| [`docs/30_day_schedule_theory_only.md`](docs/30_day_schedule_theory_only.md) | 旧版纯理论日程 |

## 目录

```text
integrated_grating_30day/
├─ README.md
├─ setup.m
├─ docs/
│  ├─ 30_day_roadmap.md               ← ★ 主入口：一站式30天路线图
│  ├─ theory_notes.md                  ← 理论提纲
│  ├─ vertical_gc_theory_deep.md       ← 垂直光栅深化
│  ├─ conventions.md                   ← 约定
│  ├─ stage_outline.md, INDEX.md       ← 总纲与索引
│  ├─ references.md, references_supplement.md
│  ├─ enhanced_bookshelf.md, cbg_review_integration.md
│  ├─ 30_day_schedule.md, 30_day_schedule_theory_only.md  ← 旧版（备查）
│  └─ progress_tracker.md
├─ matlab/+grating/ (8个求解器)
├─ examples/ (5个示例脚本)
└─ tests/ (run_all_tests.m)
```

## 求解器接口

```matlab
[S11,S21,phi,tau,out] = grating.uniform_bg( ... );
[S11,S21,phi,tau,gdd,out] = grating.nonuniform_bg( ... );
[S11,S21,radiationLoss,out] = grating.multimode_bg( ... );
out = grating.vertical_gc( ... );
```

所有长度单位 [m]、频率 [Hz]、传播常数/耦合系数 [m⁻¹]、角度 [rad]。

## 模型边界

- MATLAB 模型用于理论推导、初始设计和快速参数扫描，不代替全矢量模式求解。
- `coupling_overlap` 需要外部模式求解器提供功率归一化矢量场。
- `vertical_gc` 是相位匹配、辐射包络和效率预算模型；方向性需 RCWA/FDTD/FEM 校验。
- 多模模型只包含显式离散模式。辐射连续谱需通过等效损耗或附加离散辐射模式表示。
