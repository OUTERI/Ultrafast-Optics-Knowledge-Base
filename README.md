# 超快光学知识库 (Ultrafast Optics Knowledge Base)

超快光学与光子学理论推导、文献综述和实验分析文档集。

## 📂 目录

| 目录 | 内容 | PDF |
|------|------|-----|
| [time-freq-rf-analysis/](./time-freq-rf-analysis/) | 超快脉冲的时域/光谱域/RF域信号分析与数学推导 | [main.pdf](./time-freq-rf-analysis/main.pdf) |
| [cavity-model/](./cavity-model/) | Figure 9 — 光学腔模型理论分析 | [main.pdf](./cavity-model/main.pdf) |
| [cbg-sin-review/](./cbg-sin-review/) | CBG-SiN（光栅耦合布拉格光栅-氮化硅）文献综述 | [review_cbg_sin_v3.pdf](./cbg-sin-review/review_cbg_sin_v3.pdf) |

---

### 1. time-freq-rf-analysis — 时域/频域/RF谱分析

`main.tex` 系统阐述超快光学中三个核心信号域之间的数学关系：

- **时域脉冲** $I(t)$、**光学频谱** $S_{\text{opt}}(\nu)$（含光学频率梳）、**RF 功率谱** $S_{\text{RF}}(f)$（PD + 电谱仪）
- 平方律探测原理与 Wiener--Khinchin 定理的严格推导
- **三种脉冲类型对比**：主动锁模（Kuizenga--Siegman）、孤子锁模（NLSE）、调Q（速率方程）
- RF 谱判别脉冲类型的实用准则

### 2. cavity-model — 光学腔模型

`main.tex` — 光学腔（微环/FP腔/光栅腔）的理论模型与计算。

### 3. cbg-sin-review — CBG-SiN 文献综述

`review_cbg_sin_v3.tex` — 光栅耦合布拉格光栅-氮化硅（Corrugated Bragg Grating on SiN）平台的文献综述与设计分析。

## 🔧 LaTeX 编译

各子文件夹独立编译：
```bash
cd time-freq-rf-analysis
xelatex main.tex && biber main && xelatex main.tex && xelatex main.tex
```

## 📚 主要参考文献

- Diels & Rudolph, *Ultrashort Laser Pulse Phenomena*, 2nd ed. (2006)
- Kuizenga & Siegman, *IEEE JQE* 6(11), 694–708 (1970)
- Haus, *IEEE JSTQE* 6(6), 1173–1185 (2000)
- Udem, Holzwarth & Hänsch, *Nature* 416, 233–237 (2002)

## 📝 License

MIT
