# 30 天集成波导光栅理论与 MATLAB 学习包

本学习包面向已经掌握 Maxwell 方程、波导模式和有效折射率法的学习者，从集成波导光栅出发，依次学习均匀布拉格光栅、切趾与啁啾光栅、多模/偏振耦合光栅，以及集成垂直光栅耦合器。

> **2025年7月更新**：新增五份增强文档，深化教材引用、CBG-SiN综述映射、垂直光栅耦合器的严格理论计算、补充文献索引和统一导航。

## 快速导航

📑 **[docs/INDEX.md](docs/INDEX.md)** — 统一文档地图：按场景导航、按专题深入、交叉引用完整性检查。**建议首先阅读。**

## 使用顺序

0. **首先阅读** [`docs/INDEX.md`](docs/INDEX.md) 了解完整文档地图和所有文档的依赖关系。
1. 阅读 [`docs/30_day_schedule.md`](docs/30_day_schedule.md)，按天执行任务。
2. 开始计算前阅读 [`docs/conventions.md`](docs/conventions.md)，统一时间因子、传播方向、功率和损耗定义。
3. 每一阶段先阅读 [`docs/theory_notes.md`](docs/theory_notes.md) 的对应章节，再运行 `examples/` 中的脚本。
4. **教材章节**：查阅 [`docs/enhanced_bookshelf.md`](docs/enhanced_bookshelf.md) 获取每个阶段的详细教材章节映射（12本核心教材）。
5. **综述映射**：查阅 [`docs/cbg_review_integration.md`](docs/cbg_review_integration.md) 了解本学习路线与 [CBG-SiN综述论文](https://github.com/OUTERI/Ultrafast-Optics-Knowledge-Base/tree/master/cbg-sin-review) 的对应关系。
6. **垂直光栅深化**：第23–28天额外阅读 [`docs/vertical_gc_theory_deep.md`](docs/vertical_gc_theory_deep.md) 的辐射模严格理论和解析设计方法。
7. 用 [`docs/references.md`](docs/references.md) 和 [`docs/references_supplement.md`](docs/references_supplement.md) 中的"必读/选读"顺序精读文献。
8. 在 MATLAB 中运行：

   ```matlab
   cd('integrated_grating_30day');
   setup;
   run_all_tests;
   ```

9. 每天在 [`docs/progress_tracker.md`](docs/progress_tracker.md) 中记录公式推导、代码结果、问题和次日修正。

## 目录

```text
integrated_grating_30day/
├─ README.md
├─ setup.m
├─ docs/
│  ├─ INDEX.md                         ← [NEW] 统一导航与文档地图
│  ├─ 30_day_schedule.md              ← 主日程（含MATLAB）
│  ├─ 30_day_schedule_theory_only.md   ← 纯理论版日程
│  ├─ conventions.md                   ← 数学与物理约定
│  ├─ theory_notes.md                  ← 理论提纲
│  ├─ stage_outline.md                 ← 阶段总纲
│  ├─ references.md                    ← 文献索引
│  ├─ references_supplement.md         ← [NEW] 补充文献（高阶模式+垂直光栅+最新进展）
│  ├─ enhanced_bookshelf.md            ← [NEW] 增强版教材章节指南（12本核心教材）
│  ├─ cbg_review_integration.md        ← [NEW] CBG-SiN综述与学习阶段映射
│  ├─ vertical_gc_theory_deep.md       ← [NEW] 垂直光栅耦合器深化理论
│  └─ progress_tracker.md              ← 进度记录
├─ matlab/+grating/
│  ├─ uniform_bg.m
│  ├─ uniform_design.m
│  ├─ nonuniform_bg.m
│  ├─ multimode_bg.m
│  ├─ vertical_gc.m
│  ├─ apodization_profile.m
│  ├─ coupling_overlap.m
│  └─ phase_metrics.m
├─ examples/
│  ├─ day05_uniform_compare.m
│  ├─ day10_sin_lnoi_design.m
│  ├─ day17_chirped_apodized.m
│  ├─ day22_secondary_stopband.m
│  └─ day28_vertical_gc.m
└─ tests/
   └─ run_all_tests.m
```

## 求解器接口

```matlab
[S11,S21,phi,tau,out] = grating.uniform_bg( ... );
[S11,S21,phi,tau,gdd,out] = grating.nonuniform_bg( ... );
[S11,S21,radiationLoss,out] = grating.multimode_bg( ... );
out = grating.vertical_gc( ... );
```

所有长度单位为 m、频率为 Hz、角频率为 rad/s、传播常数和耦合系数为 m^-1、功率损耗系数为 m^-1、角度为 rad。绘图脚本再将坐标转换为 nm、THz、ps 和 ps/nm。

## 模型边界

- MATLAB 模型用于理论推导、初始设计和快速参数扫描，不代替复杂横截面的全矢量模式求解。
- `coupling_overlap` 需要外部模式求解器提供已经功率归一化的矢量场。
- `vertical_gc` 是相位匹配、辐射包络和效率预算模型；方向性仍需由多层结构的 RCWA/FDTD/FEM 校验。详见 `docs/vertical_gc_theory_deep.md` 中的完整计算链路（§"从理论到设计的计算链路"）。
- 多模模型只包含显式给出的离散模式。辐射连续谱必须通过等效损耗或附加离散辐射模式表示。
