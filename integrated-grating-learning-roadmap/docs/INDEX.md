# 集成波导光栅学习路线 — 完整文档索引

> 本文档是整个 `integrated-grating-learning-roadmap` 的**统一入口**和**导航图**。
> 所有文档的交叉引用、依赖关系和使用场景在此汇总。

---

## 文档地图

```
integrated-grating-learning-roadmap/
│
├─ README.md                          ← 快速入门（5分钟了解全貌）
├─ setup.m                            ← MATLAB 路径初始化
│
├─ docs/
│  ├─ INDEX.md                        ← 【你在这里】统一导航
│  │
│  ├─ ── 日程与规划 ──
│  ├─ 30_day_schedule.md              ← 主日程：每天理论+论文+MATLAB（280分钟/天）
│  ├─ 30_day_schedule_theory_only.md  ← 纯理论版日程（240分钟/天，不含代码）
│  ├─ progress_tracker.md             ← 每日进度记录模板
│  │
│  ├─ ── 理论框架 ──
│  ├─ stage_outline.md                ← 阶段总纲：知识主线、五套必备理论、SiN/LNOI对照
│  ├─ theory_notes.md                 ← 理论提纲（9章，从CMT到全波方法）
│  ├─ conventions.md                  ← 数学与物理约定（时间因子、单位、端口定义）
│  │
│  ├─ ── 深度专题 ──
│  ├─ vertical_gc_theory_deep.md      ← 垂直光栅耦合器深化理论
│  │                                     Part A: 辐射模严格电磁理论
│  │                                     Part B: 工程解析设计方法
│  │                                     完整计算链路（11步）
│  │
│  ├─ ── 参考文献 ──
│  ├─ enhanced_bookshelf.md           ← 12本核心教材的详细章节映射
│  ├─ references.md                   ← 论文文献索引（按阶段组织，含必读/选读）
│  ├─ references_supplement.md        ← 补充文献（高阶模式、垂直光栅、最新2024-2026）
│  │
│  ├─ ── 综述映射 ──
│  └─ cbg_review_integration.md       ← CBG-SiN综述论文与30天学习路线逐日映射
│
├─ matlab/+grating/                   ← 8个求解器函数
│  ├─ uniform_bg.m                    ← 均匀光栅解析解
│  ├─ uniform_design.m                ← 均匀光栅正向设计
│  ├─ nonuniform_bg.m                 ← 非均匀光栅分段TMM
│  ├─ multimode_bg.m                  ← 多模矩阵CMT
│  ├─ vertical_gc.m                   ← 垂直光栅解析设计
│  ├─ apodization_profile.m           ← 切趾函数库
│  ├─ coupling_overlap.m              ← 矢量场重叠积分
│  └─ phase_metrics.m                 ← 相位/群时延/GDD
│
├─ examples/                          ← 5个阶段示例脚本
│  ├─ day05_uniform_compare.m         ← 阶段一：CMT vs TMM 验证
│  ├─ day10_sin_lnoi_design.m         ← 阶段二：SiN/LNOI 正向设计
│  ├─ day17_chirped_apodized.m        ← 阶段三：切趾啁啾对比
│  ├─ day22_secondary_stopband.m      ← 阶段四：第二阻带诊断
│  └─ day28_vertical_gc.m             ← 阶段五：垂直光栅初算
│
└─ tests/
   └─ run_all_tests.m                 ← 6个自动化测试
```

---

## 按场景导航

### 🚀 我想快速开始（10分钟）

1. `README.md` — 了解学习包范围和 MATLAB 接口
2. `conventions.md` — 确认时间因子、单位和符号约定
3. `30_day_schedule.md` 或 `30_day_schedule_theory_only.md` — 选一个日程，开始第1天

### 📖 我想按天学习（跟随日程）

- 每天打开 `30_day_schedule.md`（含MATLAB）或 `30_day_schedule_theory_only.md`（纯理论）
- 每阶段开始前阅读 `stage_outline.md` 对应部分
- 每天结束时填写 `progress_tracker.md`

### 🔬 我想深入某个专题

| 专题 | 主文档 | 深度文档 |
|---|---|---|
| 耦合模理论（CMT）推导 | `theory_notes.md` §1–2 | `enhanced_bookshelf.md` → T1(Okamoto) §4, T2(Yariv) §13 |
| 传输矩阵法（TMM） | `theory_notes.md` §3 | `enhanced_bookshelf.md` → T3(Coldren) §3, T4(Kashyap) §5 |
| 切趾与啁啾 | `theory_notes.md` §5–6 | `enhanced_bookshelf.md` → T4(Kashyap) §5, §7 |
| 多模耦合与第二阻带 | `theory_notes.md` §7 | `references_supplement.md` 阶段四部分 |
| 垂直光栅耦合器 | `theory_notes.md` §8 | **`vertical_gc_theory_deep.md`**（全册，必读） |
| SiN vs LNOI 平台选择 | `stage_outline.md` §四 | `cbg_review_integration.md` §1.2 导读 |

### 📚 我想找教材章节

- 按阶段查：`enhanced_bookshelf.md` → 各阶段教材映射表
- 按教材查：`enhanced_bookshelf.md` → "按教材组织的阅读索引"

### 📄 我想找论文

- 按阶段查：`references.md`（核心论文）或按天次查：`references_supplement.md` → "按天次的文献阅读建议"
- 按综述论文查：`cbg_review_integration.md` → "快速交叉引用表"

### 🔗 我想了解学习和综述的关系

- `cbg_review_integration.md` — 包含：
  - 综述每个节与30天日程的逐天映射
  - 每个阶段的综述导读要点
  - 综述的分级阅读指南（概览→理论→论文三级）
  - 快速交叉引用表："如果你想了解X → 先学Y → 再读综述Z → 再精读论文W"

---

## 六阶段核心问题速查

| 阶段 | 天次 | 核心问题 | 标志性公式 | 标志性代码 |
|:---:|:---:|---|---|---|
| 1 | 1–5 | 禁带为什么出现？ | $R_{\max}=\tanh^2(|\kappa|L)$ | `uniform_bg.m` |
| 2 | 6–10 | 周期和调制深度分别控制什么？ | $\Lambda=\lambda_B/(2n_{\text{eff}})$ | `uniform_design.m` |
| 3 | 11–17 | 如何控制旁瓣、带宽和色散？ | $\kappa(z)=\kappa_0 a(z)$ | `nonuniform_bg.m` |
| 4 | 18–22 | 第二阻带来自哪里？ | $\beta_m+\beta_n=K$ | `multimode_bg.m` |
| 5 | 23–28 | 如何从波导辐射到光纤？ | $dP/dz=-2\alpha(z)P(z)$ | `vertical_gc.m` |
| 6 | 29–30 | 综合 — 全部理论贯通 | 五套必备理论 | `run_all_tests.m` |

---

## 文档优先阅读顺序

### 必须读（按顺序）

| # | 文档 | 何时读 | 用时 |
|:---:|---|---|:---:|
| 1 | `README.md` | 开始前 | 5 min |
| 2 | `conventions.md` | 第1天前 | 10 min |
| 3 | `stage_outline.md` | 第1天前 | 15 min |
| 4 | `30_day_schedule.md`（或 theory_only） | 每天 | 2 min/天 |
| 5 | `theory_notes.md`（按阶段对应章节） | 每天 | 30-60 min/天 |

### 按需读（按阶段）

| # | 文档 | 何时读 | 
|:---:|---|---|
| 6 | `enhanced_bookshelf.md` | 每阶段开始前查教材章节 |
| 7 | `references.md` + `references_supplement.md` | 每天按天次查论文 |
| 8 | `cbg_review_integration.md` | 每阶段结束后对照综述 |
| 9 | `vertical_gc_theory_deep.md` | 第23–28天精读 |

### 工具文档

| # | 文档 | 用途 |
|:---:|---|---|
| 10 | `progress_tracker.md` | 每天记录产物和问题 |
| 11 | `INDEX.md`（本文档） | 总导航、交叉引用 |

---

## 交叉引用完整性检查

下表确保每个主要概念都有唯一的权威来源，避免分散和矛盾：

| 概念 | 定义来源 | 深度来源 |
|---|---|---|
| 时间因子 $e^{-i\omega t}$ | `conventions.md` §1 | — |
| $\delta = \beta - K/2$ | `conventions.md` §2, `theory_notes.md` §2 | `enhanced_bookshelf.md` → T1 §4 |
| 二模耦合方程形式 | `conventions.md` §2 | `theory_notes.md` §1 |
| S参数定义 | `conventions.md` §3 | — |
| $\tau_g$ 和 GDD 符号 | `conventions.md` §4 | — |
| 单位制 | `conventions.md` §5 | — |
| CMT推导 | `theory_notes.md` §1 | T2(Yariv) §13.1–5 |
| TMM推导 | `theory_notes.md` §3 | T3(Coldren) §3.3–5 |
| Bloch/Floquet | `theory_notes.md` §3 | T12(Joannopoulos) §3.1–3 |
| ERI-TMM | — | `cbg_review_integration.md` → Praena 2024 |
| 切趾函数比较 | `theory_notes.md` §5 | `apodization_profile.m` |
| 啁啾分类 | `theory_notes.md` §6 | `cbg_review_integration.md` §2.2 导读 |
| WKB分析 | `theory_notes.md` §6.1 | T4(Kashyap) §5.10; Poladian 1993 |
| 多模CMT矩阵 | `theory_notes.md` §7 | `multimode_bg.m` |
| 选择定则 | `theory_notes.md` §7.1 | `enhanced_bookshelf.md` → T1 §4.10 |
| $\alpha(z)$ 反演 | `theory_notes.md` §8.1 | `vertical_gc_theory_deep.md` §B.1 |
| 效率预算 | `theory_notes.md` §8.2 | `vertical_gc_theory_deep.md` §B.3 |
| 完全垂直耦合 | `theory_notes.md` §8.3 | `vertical_gc_theory_deep.md` §B.5 |
| Green函数法 | — | `vertical_gc_theory_deep.md` §A.3 |
| BOX干涉 | — | `vertical_gc_theory_deep.md` §A.4.2 |
| 辐射模严格理论 | — | `vertical_gc_theory_deep.md` Part A |

---

## 版本与更新

- **v1.0** (2025-07-29)：初始版本，包含完整30天路线、8个MATLAB求解器、5个示例、12本教材映射、CBG-SiN综述集成、垂直光栅深化理论
- 后续更新将在此处记录
