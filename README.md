# 超快光学知识库 (Ultrafast Optics Knowledge Base)

超快光学理论推导与实验分析文档集。当前收录：

## 📄 文档

### 时域、频域与射频域信号分析

`main.tex` — 系统阐述超快光学中三个核心信号域之间的数学关系：

- **时域脉冲** $I(t)$
- **光学频谱** $S_{\text{opt}}(\nu)$（含光学频率梳）
- **RF 功率谱** $S_{\text{RF}}(f)$（PD + 电谱仪测量）

基于平方律探测原理和 Wiener--Khinchin 定理，给出严格的数学推导。

### 三种脉冲类型对比

| 类型 | 脉宽 | 光谱结构 | RF 谱结构 | 核心理论 |
|------|------|---------|----------|---------|
| 主动锁模 | ps--ns | 频率梳 + 高斯包络 | 谐波梳 + 高斯滚降 | Kuizenga--Siegman |
| 孤子锁模 | fs--ps | 频率梳 + sech² + Kelly边带 | 谐波梳 + 指数滚降 | NLSE / Haus 主方程 |
| 调Q | ns--μs | 平滑宽带（无梳） | 连续噪声（无梳） | 速率方程 |

## 🔧 编译

```bash
# XeLaTeX / LuaLaTeX（推荐，支持中文）
xelatex main.tex
biber main
xelatex main.tex
xelatex main.tex

# 或使用 latexmk
latexmk -xelatex main.tex
```

## 📚 主要参考文献

- Diels & Rudolph, *Ultrashort Laser Pulse Phenomena*, 2nd ed. (2006)
- Kuizenga & Siegman, *IEEE JQE* 6(11), 694–708 (1970)
- Haus, *IEEE JSTQE* 6(6), 1173–1185 (2000)
- Udem, Holzwarth & Hänsch, *Nature* 416, 233–237 (2002)
- Kelly, *Electron. Lett.* 28(8), 806–807 (1992)

## 📝 License

MIT
