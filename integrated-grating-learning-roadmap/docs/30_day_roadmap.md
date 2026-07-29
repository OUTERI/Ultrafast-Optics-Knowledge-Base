# 集成波导光栅 30 天一站式学习路线图


> **📐 公式渲染**：GitHub 网页端不渲染 LaTeX 公式。建议用 **VS Code**（Markdown+Math 扩展）、**Typora** 或 **Obsidian** 打开，或安装浏览器扩展 "MathJax 3 for GitHub"。
> **📖 参考文献库**：文末附 64 篇论文 + 12 本教材的完整分类文献库，全部含 DOI 链接。
> **这是唯一需要逐天跟随的文件**。每天的学习目标、推导任务、阅读材料（教材章节+论文DOI+综述段落）、代码文件和产出清单全部内联在此。其他 `docs/` 下的文件为深度参考，按需查阅。

---

## 使用说明

### 阅读深度标记

| 标记 | 含义 | 要求 |
|:---:|---|---|
| ★ 精读 | 必须逐页阅读，理解每一个公式 | 能复现关键推导和图表 |
| ● 通读 | 理解主要结论和方法 | 能用自己的话概括 |
| ○ 速览 | 了解背景和结论 | 知道在哪里可以找到细节 |

### 代码标记

- 🔧 = 含 MATLAB 代码任务。纯理论学习者可跳过，不影响理解。
- 所有代码文件路径相对于 `integrated_grating_30day/` 根目录。

### 前置知识自检

开始前确认已掌握：
- [ ] Maxwell 方程组的微分形式和边界条件
- [ ] 平板波导和条形波导的模式概念（TE/TM 模）
- [ ] 有效折射率法（Effective Index Method）的基本思想
- [ ] 复 Poynting 矢量和功率流
- [ ] Fourier 级数和 Fourier 变换的基本运算

---

## 30 天总览

| 阶段 | 天次 | 核心问题 | 标志性公式 | 标志性代码 |
|:---:|:---:|---|---|:---:|
| 一：均匀光栅 | 1–5 | 禁带为什么出现？ | $R_{\max}=\tanh^2(|\kappa|L)$ | `uniform_bg.m` |
| 二：几何与设计 | 6–10 | 周期和调制深度分别控制什么？ | $\Lambda=\lambda_B/(2n_{\text{eff}})$ | `uniform_design.m` |
| 三：切趾与啁啾 | 11–17 | 如何控制旁瓣、带宽和色散？ | $\kappa(z)=\kappa_0 a(z)$ | `nonuniform_bg.m` |
| 四：多模与偏振 | 18–22 | 第二阻带来自哪里？ | $\beta_m+\beta_n=K$ | `multimode_bg.m` |
| 五：垂直光栅 | 23–28 | 如何从波导辐射到光纤？ | $dP/dz=-2\alpha P$ | `vertical_gc.m` |
| 六：综合 | 29–30 | 全部贯通 | — | `run_all_tests.m` |

### 符号约定速查

- 时间因子：$e^{-i\omega t}$
- 前向模：$A(z)e^{+i\beta z}$，后向模：$B(z)e^{-i\beta z}$
- 失谐：$\delta = \beta - K/2$，光栅矢量：$K=2\pi/\Lambda$
- 反射相位和群时延：$\tau_g = -d\phi_r/d\omega$
- 所有长度单位 [m]，频率 [Hz]，传播常数/耦合系数 [m$^{-1}$]

> 完整约定见 [`conventions.md`](conventions.md)

---

## 第一阶段：均匀集成布拉格光栅（第 1–5 天）

> **核心目标**：从 Maxwell 方程出发独立推导二模耦合方程，理解禁带的物理起源，掌握 CMT 解析解、TMM 和 Bloch 波三种方法的等价与差异。

---

### 第 1 天：模式正交与功率归一化

#### 🎯 学习目标
建立前向/后向模式的正交性概念，理解"功率归一化"和"场幅归一化"的区别——这是所有 S 参数计算的基础。

#### 📖 理论推导（约 100 分钟）
1. 从复 Poynting 矢量导出单模携带的功率 $P = \frac{1}{2}\iint (\mathbf{E}\times\mathbf{H}^*)\cdot\hat{z}\,dA$
2. 写出前向模 $(\mathbf{e}_m^+, \mathbf{h}_m^+)$ 和后向模 $(\mathbf{e}_m^-, \mathbf{h}_m^-)$ 的横向场关系
3. 推导模式正交性：$\iint (\mathbf{e}_m^\pm\times\mathbf{h}_n^{\pm*})\cdot\hat{z}\,dA = \pm 2P_m\delta_{mn}$
4. 统一符号表：所有后续推导中 $A(z)$、$B(z)$、$\beta$、$\kappa$ 的精确定义

> 详细推导骨架见 [`theory_notes.md`](theory_notes.md) §1

#### 📚 阅读材料

| 类型 | 内容 | 章节/页码 | 用时 | 深度 |
|------|------|-----------|:---:|:---:|
| 教材 | Okamoto, *Fundamentals of Optical Waveguides* 2nd ed. | §3.1–3.3（模式正交性） | 45 min | ★ |
| 教材 | Okamoto | §4.1–4.3（微扰理论导论） | 30 min | ● |
| 参考 | Snyder & Love, *Optical Waveguide Theory* | Part II §11, §31（严格正交性） | — | ○ |

#### 💻 代码 🔧
暂不运行代码。今天专注手写推导。

#### ✅ 今日产出
- [ ] 一页符号表，包含 $A,B,\beta,\kappa,\delta,P$ 的精确定义和单位
- [ ] 手写推导：从 Poynting 矢量到模式功率归一化的完整过程
- [ ] 回答：为什么 $S_{11}$ 和 $S_{21}$ 的平方和等于 1？（无损条件下）

---

### 第 2 天：Lorentz 互易定理 → 耦合模方程

#### 🎯 学习目标
从两个电磁状态的 Lorentz 互易关系出发，推导前向-后向模耦合方程，理解 $\kappa$（耦合系数）和 $\delta$（相位失配）的物理来源。

#### 📖 理论推导（约 100 分钟）
1. 写出两个电磁状态 $(\mathbf{E}_1,\mathbf{H}_1)$ 和 $(\mathbf{E}_2,\mathbf{H}_2)$ 的 Lorentz 互易关系
2. 将介电扰动展开为 Fourier 级数：$\Delta\epsilon(x,y,z) = \sum_q \Delta\epsilon_q(x,y) e^{iqKz}$
3. 代入慢变包络近似，使用旋波近似（RWA）保留相位匹配项
4. 推导二模耦合方程的最终形式（与本学习包约定一致）：
   $$\frac{d}{dz}\begin{bmatrix}A\\B\end{bmatrix} = \begin{bmatrix}i\delta-\alpha/2 & i\kappa\\ -i\kappa^* & -i\delta+\alpha/2\end{bmatrix}\begin{bmatrix}A\\B\end{bmatrix}$$

> 详细推导骨架见 [`theory_notes.md`](theory_notes.md) §1

#### 📚 阅读材料

| 类型 | 内容 | 章节/页码 | 用时 | 深度 |
|------|------|-----------|:---:|:---:|
| 论文 | Kogelnik, "Coupled Wave Theory for Thick Hologram Gratings," *Bell Syst. Tech. J.*, 1969 | 全文 | 40 min | ★ |
| 论文 | Erdogan, "Fiber grating spectra," *JLT*, 1997 | §II（耦合方程推导部分） | 30 min | ★ |
| 教材 | Okamoto | §4.4–4.6（耦合模方程推导） | 30 min | ★ |
| 综述 | CBG-SiN review | §2.1（CMT 方程推导，式1-2） | 15 min | ● |

🔗 **论文链接**：[Kogelnik 1969](https://doi.org/10.1002/j.1538-7305.1969.tb01198.x) | [Erdogan 1997](https://doi.org/10.1109/50.618322)

#### 💻 代码 🔧
暂不运行代码。

#### ✅ 今日产出
- [ ] 手写推导：从互易积分到二模耦合方程的完整过程（≤2页）
- [ ] 能口头解释：$\kappa$ 的实部和虚部分别代表什么？$\delta=0$ 意味着什么？
- [ ] 将自己的推导与 Erdogan 1997 的式(1)-(5)逐行对照，标出约定差异

---

### 第 3 天：均匀光栅解析解

#### 🎯 学习目标
求解均匀光栅（$\kappa$ 为常数）的解析解，推导反射率 $R(\lambda)$、透射率 $T(\lambda)$、反射相位 $\phi_r(\lambda)$ 和群时延 $\tau_g(\lambda)$。

#### 📖 理论推导（约 100 分钟）
1. 求解常系数矩阵的特征值问题：$\gamma = \sqrt{|\kappa|^2 - \delta^2}$
2. 应用边界条件：$A(0)=1$（左端前向入射），$B(L)=0$（右端无后向入射）
3. 推导中心反射率：$R_{\max} = \tanh^2(|\kappa|L)$
4. 区分两种情况：$|\delta| < |\kappa|$（禁带，$\gamma$ 实）vs $|\delta| > |\kappa|$（通带，$\gamma$ 虚）
5. 推导近似阻带宽度：$\Delta\lambda_{\text{stop}} \approx \lambda_B^2|\kappa|/(\pi n_g)$

> 详细推导见 [`theory_notes.md`](theory_notes.md) §2

#### 📚 阅读材料

| 类型 | 内容 | 章节/页码 | 用时 | 深度 |
|------|------|-----------|:---:|:---:|
| 论文 | Erdogan, "Fiber grating spectra," *JLT*, 1997 | §III（均匀光栅解析解） | 40 min | ★ |
| 教材 | Kashyap, *Fiber Bragg Gratings* 2nd ed. | §4.1–4.4（均匀 Bragg 光栅） | 40 min | ★ |
| 教材 | Yariv & Yeh, *Photonics* 6th ed. | §13.6（周期波导的禁带和色散关系） | 30 min | ● |

🔗 **论文链接**：[Erdogan 1997](https://doi.org/10.1109/50.618322)

#### 💻 代码 🔧

| 操作 | 文件 | 重点关注 |
|------|------|----------|
| 运行 | `examples/day05_uniform_compare.m` | 观察 CMT 与 TMM 反射率曲线差异 |
| 研读 | `matlab/+grating/uniform_bg.m` | L28–35：`expm(h*L)` 矩阵指数法的构造和边界条件处理 |

**关键 API**：
```matlab
[S11, S21, reflectionPhase, groupDelay, out] = grating.uniform_bg(kappa, delta, loss, lengthGrating, frequency);
```

#### ✅ 今日产出
- [ ] 手写 $R(\lambda)$、$T(\lambda)$ 的完整推导（从边界条件到最终表达式）
- [ ] 用 MATLAB 画出 $R,T,\phi_r,\tau_g$ 四张曲线图，标注禁带边缘
- [ ] 验证 $R+T=1$（无损条件下）

---

### 第 4 天：传递矩阵法与 Bloch 波

#### 🎯 学习目标
掌握传输矩阵法（TMM）的构造原理，理解 Bloch 波数和禁带的对应关系，能说明 CMT 禁带与 Bloch 禁带何时一致、何时不同。

#### 📖 理论推导（约 100 分钟）
1. 推导单段均匀光栅的 $2\times2$ 传输矩阵：$\mathbf{T}_i = \exp(\mathbf{H}_i\Delta z)$
2. 总矩阵左乘顺序：$\mathbf{M}_{\text{total}} = \mathbf{M}_N\mathbf{M}_{N-1}\cdots\mathbf{M}_1$
3. 从单周期矩阵迹提取 Bloch 波数：$\cos(k_B\Lambda) = \frac{1}{2}\operatorname{Tr}(\mathbf{M}_\Lambda)$
4. 比较三种方法：解析 CMT vs 分段 TMM vs Bloch/Floquet

> 详细推导见 [`theory_notes.md`](theory_notes.md) §3

#### 📚 阅读材料

| 类型 | 内容 | 章节/页码 | 用时 | 深度 |
|------|------|-----------|:---:|:---:|
| 论文 | Peral & Capmany, "Generalized Bloch wave analysis for fiber and waveguide gratings," *JLT*, 1997 | 全文 | 40 min | ★ |
| 教材 | Coldren & Corzine, *Diode Lasers and Photonic Integrated Circuits* 2nd ed. | §3.3–3.5（传输矩阵法） | 30 min | ★ |
| 教材 | Joannopoulos, *Photonic Crystals* 2nd ed. | §3.1–3.3（一维 Bloch 态和禁带） | 20 min | ● |

🔗 **论文链接**：[Peral & Capmany 1997](https://doi.org/10.1109/50.618325) | [Cheng & Chrostowski 2021 教程](https://doi.org/10.1109/JLT.2020.3044648)（○速览）

#### 💻 代码 🔧

| 操作 | 文件 | 重点关注 |
|------|------|----------|
| 运行 | `examples/day05_uniform_compare.m` | 对比解析 CMT 和分段 TMM（301段）的反射率差异 |
| 研读 | `matlab/+grating/nonuniform_bg.m` | L27–38：分段矩阵级联、矩阵乘法顺序 |

#### ✅ 今日产出
- [ ] 三列表：解析 CMT、分段 TMM、Bloch 方法的输入、优点、失效条件
- [ ] 用 MATLAB 验证：N=10 段 vs N=300 段的 TMM 与解析解的最大偏差
- [ ] 回答：一个周期 $\Lambda$ 远小于光波长时，Bloch 禁带与 CMT 禁带是否重合？

---

### 第 5 天：阶段一考核

#### 🎯 学习目标
闭卷验证阶段一的掌握程度，识别薄弱环节。

#### 📖 理论推导（约 60 分钟）
在[`progress_tracker.md`](progress_tracker.md)中记录以下问题的闭卷回答：

1. 写出布拉格条件 $2\beta(\omega_B)=K$，并在此基础上推导 $\Lambda = \lambda_B/(2n_{\text{eff}})$
2. 写出 $R_{\max}=\tanh^2(|\kappa|L)$ 的适用条件
3. 解释为什么"满足布拉格条件"不等于"具有高反射率"
4. 说明有限长度旁瓣、端面反射和光栅阻带的区别来源

#### 📚 阅读材料

| 类型 | 内容 | 用时 | 深度 |
|------|------|:---:|:---:|
| 综述 | CBG-SiN review §2（全文通读，用你的推导验证每一行公式） | 30 min | ★ |
| 回顾 | Erdogan 1997 全文（现在应该能完全理解） | 20 min | ● |

#### 💻 代码 🔧
```matlab
setup; run_all_tests;
```
确认 `test_uniform_center` 和 `test_uniform_vs_nonuniform` 通过。

#### ✅ 今日产出
- [ ] 4 道闭卷题的书面回答
- [ ] 所有测试通过
- [ ] 列出本周 3 个最困惑的概念，写清楚困惑的具体原因

---

## 第二阶段：从集成波导几何到光栅设计（第 6–10 天）

> **核心目标**：将第一阶段的抽象 $\kappa,\delta$ 连接到具体的波导几何参数（宽度、刻蚀深度、占空比），掌握正向设计方法。

---

### 第 6 天：几何扰动与矢量耦合积分

#### 🎯 学习目标
推导 $\Delta\epsilon(x,y,z)$ 与 $\kappa_{mn}$ 之间的矢量场重叠积分，理解为什么侧壁、顶层和包层调制会产生不同的耦合强度。

#### 📖 理论推导（约 100 分钟）
1. 推导耦合系数的矢量重叠积分形式：
   $$\kappa_{mn} = \frac{\omega}{4\sqrt{P_m P_n}} \iint \Delta\epsilon_q \mathbf{e}_m^*\cdot\mathbf{e}_n\,dA$$
2. 分析五类扰动的场重叠区域：侧壁调制、顶层调制、包层调制、双侧对称、单侧非对称
3. 理解 $\kappa$ 的大小取决于三个因素：$\Delta\epsilon$ 的幅度 × 模式场在扰动区域的强度 × 两个模式场的方向匹配度

> 详细推导见 [`theory_notes.md`](theory_notes.md) §4

#### 📚 阅读材料

| 类型 | 内容 | 章节/页码 | 用时 | 深度 |
|------|------|-----------|:---:|:---:|
| 教材 | Okamoto | §4.7–4.9（介电微扰的耦合系数计算） | 45 min | ★ |
| 教材 | Yariv & Yeh | §13.4（矢量耦合模理论中的重叠积分） | 30 min | ● |
| 综述 | CBG-SiN review | §2.4（ERI-TMM 如何从模式求解器获取耦合参数） | 20 min | ● |

#### 💻 代码 🔧

| 操作 | 文件 | 重点关注 |
|------|------|----------|
| 研读 | `matlab/+grating/coupling_overlap.m` | 归一化公式 `kappa = ωε₀·∫Δεᵣ·e*_f·e_b·dA / (4√(P_f·P_b))` |

#### ✅ 今日产出
- [ ] 画出五类几何扰动的横截面示意图，标出每种扰动的场重叠区域
- [ ] 解释：为什么单侧侧壁光栅可以耦合 TE₀ 和 TE₁，而双侧对称光栅可能禁止这一耦合？

---

### 第 7 天：占空比与空间傅里叶谐波

#### 🎯 学习目标
理解矩形周期光栅的 Fourier 展开，掌握占空比如何同时影响一阶耦合强度和寄生高阶谐波。

#### 📖 理论推导（约 90 分钟）
1. 推导矩形光栅的第 $q$ 阶 Fourier 系数：$\Delta\epsilon_q \propto \sin(\pi q D)/(\pi q)$
2. 分析占空比 $D=0.5$ 时的特殊情况（偶数阶消失）
3. 区分：一阶反射光栅（$\Lambda \approx \lambda/(2n_{\text{eff}})$）、二阶光栅（辐射+反射）、采样光栅

#### 📚 阅读材料

| 类型 | 内容 | 章节/页码 | 用时 | 深度 |
|------|------|-----------|:---:|:---:|
| 教材 | Kashyap | §3.1–3.4（光栅的傅里叶分析和空间谐波） | 40 min | ★ |
| 教材 | Chrostowski & Hochberg, *Silicon Photonics Design* | §5.1–5.4（硅基波导光栅的几何依赖性） | 30 min | ● |

#### 💻 代码 🔧
今天暂不运行代码。手算占空比 $D=0.3, 0.5, 0.7$ 时前 3 阶 Fourier 系数的数值。

#### ✅ 今日产出
- [ ] 手算表：$D=0.3, 0.5, 0.7$ 时 $\Delta\epsilon_1, \Delta\epsilon_2, \Delta\epsilon_3$ 的相对幅度
- [ ] 回答：为什么二阶光栅（$q=2$）可以同时用于反射和辐射？

---

### 第 8 天：相移光栅与缺陷态

#### 🎯 学习目标
理解如何在 Bragg 光栅中引入相位跃迁（$\pi$ 相移），以及缺陷态如何在禁带中产生窄带透射峰。

#### 📖 理论推导（约 90 分钟）
1. 用两段光栅 + 中间相位跃迁 $\Delta\phi$ 表示相移光栅的总传输矩阵
2. 推导 $\pi$ 相移时透射峰在禁带中心的出现条件
3. 分析透射峰线宽与光栅长度、$\kappa$ 的关系
4. 区分：相移光栅缺陷态 vs Fabry-Pérot 腔 vs 普通有限长度旁瓣

#### 📚 阅读材料

| 类型 | 内容 | 章节/页码 | 用时 | 深度 |
|------|------|-----------|:---:|:---:|
| 教材 | Coldren & Corzine | §6.4–6.5（DFB 激光器中的相移光栅和缺陷模） | 40 min | ★ |
| 教材 | Joannopoulos | §4.4–4.5（一维光子晶体中的缺陷态） | 20 min | ● |
| 论文 | Zhang & Yao, "A fully reconfigurable waveguide Bragg grating," *Nat. Commun.*, 2018 | 摘要+图1-3 | 15 min | ○ |

🔗 **论文链接**：[Zhang & Yao 2018](https://doi.org/10.1038/s41467-018-03742-1)

#### 💻 代码 🔧
在 `nonuniform_bg.m` 中手动构造两段光栅+中间相位跳变，观察透射峰的出现。

#### ✅ 今日产出
- [ ] 画出均匀光栅（无相移）和 $\pi$ 相移光栅的 $T(\lambda)$ 对比图
- [ ] 解释：$\pi$ 相移透射峰的线宽如何随 $\kappa L$ 变化？

---

### 第 9 天：SiN 与 LNOI 平台比较

#### 🎯 学习目标
理解 SiN（氮化硅）和 LNOI（铌酸锂薄膜）两个材料平台对 Bragg 光栅设计的影响——区别不仅在于折射率数值，更在于各向异性、损耗机制和工艺约束。

#### 📖 理论推导（约 60 分钟）
1. 分别计算 SiN 和 LNOI 典型波导在 1550 nm 处的 $n_{\text{eff}}$、$n_g$、TE/TM 分裂
2. SiN：低损耗（0.05 dB/cm）、各向同性近似 → 适合超长光栅（$L>$10 cm）
3. LNOI：各向异性介电张量、晶轴方向 → $\kappa$ 依赖于晶轴取向和偏振
4. 扫描周期误差 $\pm\Delta\Lambda$、宽度误差 $\pm\Delta W$ 对 $\lambda_B$ 的影响

#### 📚 阅读材料

| 类型 | 内容 | 章节/页码 | 用时 | 深度 |
|------|------|-----------|:---:|:---:|
| 综述 | CBG-SiN review | §1.2（SiN 平台五大优势，含定量数据） | 30 min | ★ |
| 论文 | Guyot et al., "Optical characterization of ultra-short Bragg grating on lithium niobate ridge waveguide," *OL*, 2014 | 全文 | 25 min | ★ |
| 论文 | Pohl et al., "100-GBd Waveguide Bragg Grating Modulator in Thin-Film Lithium Niobate," *LPT*, 2021 | 摘要+器件结构 | 15 min | ● |
| 教材 | Chrostowski & Hochberg | §2.1–2.4（硅光子学材料平台比较） | 20 min | ● |

🔗 **论文链接**：[Guyot 2014](https://doi.org/10.1364/OL.39.000371) | [Pohl 2021](https://doi.org/10.1109/LPT.2020.3044648)

#### ✅ 今日产出
- [ ] SiN/LNOI 平台对照表：$n_{\text{eff}}$、$n_g$、TE/TM 分裂、$\kappa$ 典型值、损耗、工艺误差敏感度
- [ ] 排列三个最敏感的设计参数（周期、宽度、刻蚀深度），说明理由

---

### 第 10 天：1550 nm 正向设计 + 阶段二考核

#### 🎯 学习目标
给定目标波长和反射率，能独立反推出光栅周期、所需长度和近似阻带宽度。理解 ERI-TMM 为什么是对传统 CMT-TMM 的重要改进。

#### 📖 理论推导（约 60 分钟）
1. 从 $\lambda_B=1550$ nm 和 $R_{\text{target}}=0.99$ 出发，反推 $\Lambda$ 和 $L$
2. 手算阻带宽度 $\Delta\lambda_{\text{stop}}$ 的近似值
3. 理解 ERI-TMM 的核心创新：直接使用模式求解器的 $n_{\text{eff}}(\lambda,W)$ 数据库，避免 CMT 的弱耦合假设

#### 📚 阅读材料

| 类型 | 内容 | 章节/页码 | 用时 | 深度 |
|------|------|-----------|:---:|:---:|
| 论文 | Praena & Carballar, "Chirped Integrated Bragg Grating Design," *Photonics*, 2024 | 全文 | 40 min | ★ |
| 教材 | Chrostowski & Hochberg | §5.5–5.8（硅基 Bragg 光栅的设计流程和容差分析） | 30 min | ● |

🔗 **论文链接**：[Praena & Carballar 2024](https://doi.org/10.3390/photonics11050476)

#### 💻 代码 🔧

| 操作 | 文件 | 重点关注 |
|------|------|----------|
| 运行 | `examples/day10_sin_lnoi_design.m` | SiN 和 LNOI 的周期、长度、阻带宽度初算 |
| 研读 | `matlab/+grating/uniform_design.m` | L14–20：`atanh(sqrt(R))/abs(kappa)` 长度反推公式 |

#### ✅ 今日产出
- [ ] SiN 和 LNOI 的正向设计手算表（$\Lambda$、$L$、$\Delta\lambda_{\text{stop}}$）
- [ ] 阶段考核：闭卷回答——为什么材料折射率 $n_{\text{SiN}}\approx2.0$ 不能直接替代模式有效折射率？给出至少两个原因。
- [ ] 🔧 运行 `day10_sin_lnoi_design.m`，对比代码输出与手算结果

---

## 第三阶段：切趾、啁啾和非均匀光栅（第 11–17 天）

> **核心目标**：从均匀光栅跃迁到 $\kappa(z)$ 和 $\delta(z)$ 随位置变化的光栅，掌握切趾（控制旁瓣）、啁啾（控制色散）和 WKB 分析工具。

---

### 第 11 天：非均匀 CMT 与分段 TMM

#### 🎯 学习目标
将 $\kappa$ 和 $\delta$ 推广为 $z$ 的函数，理解分段均匀近似的收敛条件。

#### 📖 理论推导（约 90 分钟）
1. 将 $z$ 轴离散为 $N$ 段，每段 $[\kappa_i,\delta_i]$ 为常数
2. 推导分段尺寸的约束条件：$\Delta z \ll \min(\Lambda, 1/|\kappa|, 2\pi/|\delta|)$
3. 验证常数 $\kappa$ 剖面退化为均匀解

> 详细推导见 [`theory_notes.md`](theory_notes.md) §5–6

#### 📚 阅读材料

| 类型 | 内容 | 章节/页码 | 用时 | 深度 |
|------|------|-----------|:---:|:---:|
| 教材 | Coldren & Corzine | §6.6–6.8（非均匀光栅的传输矩阵处理） | 40 min | ★ |
| 论文 | Strain, "Integrated chirped Bragg gratings for dispersion control," PhD, U. Glasgow, 2007 | Ch.3（TMM 实现细节） | 30 min | ● |
| 教材 | Kashyap | §5.1–5.4（非均匀光纤光栅的分段均匀近似） | 20 min | ● |

#### 💻 代码 🔧

| 操作 | 文件 | 重点关注 |
|------|------|----------|
| 研读 | `matlab/+grating/nonuniform_bg.m` | L27–38：循环构造分段矩阵+级联；L55–95：剖面扩展函数 `expand_profile` 对多种输入格式的智能处理 |

#### ✅ 今日产出
- [ ] 非均匀光栅理论求解流程图（从 $\kappa(z),\delta(z)$ 到 $R(\lambda),\phi_r(\lambda)$）
- [ ] 🔧 构造一个 $\kappa(z)$ 为阶梯函数的光栅，验证 N=10 vs N=500 的收敛性

---

### 第 12 天：切趾与旁瓣抑制

#### 🎯 学习目标
理解有限矩形窗口 → sinc 旁瓣的数学根源，比较五种切趾函数在旁瓣抑制上的权衡。

#### 📖 理论推导（约 90 分钟）
1. 有限均匀光栅 = 无限光栅 × 矩形窗口 → Fourier 变换给出 sinc 型旁瓣
2. 令 $\kappa(z)=\kappa_0 a(z)$，$a(z)$ 在端点平滑→0 来压低旁瓣
3. 比较：uniform、Gaussian、tanh、raised-cosine、sinc 五种函数
4. **关键**：比较前必须固定公平条件（相同 $\int|\kappa(z)|dz$ 或相同 $R_{\max}$），否则结论无意义

> 详细推导见 [`theory_notes.md`](theory_notes.md) §5

#### 📚 阅读材料

| 类型 | 内容 | 章节/页码 | 用时 | 深度 |
|------|------|-----------|:---:|:---:|
| 教材 | Kashyap | §5.5–5.8（切趾函数、旁瓣抑制和设计权衡） | 45 min | ★ |
| 论文 | Simard et al., "Apodized Silicon-on-Insulator Bragg Gratings," *LPT*, 2012 | 全文 | 30 min | ★ |
| 综述 | CBG-SiN review | §2.5（切趾技术，式5：tanh 切趾） | 20 min | ● |

🔗 **论文链接**：[Simard 2012](https://doi.org/10.1109/LPT.2012.2194278)

#### 💻 代码 🔧

| 操作 | 文件 | 重点关注 |
|------|------|----------|
| 研读 | `matlab/+grating/apodization_profile.m` | 五种切趾函数的实现，特别注意 tanh 的 `Steepness` 参数和 raised-cosine 的端点行为 |

#### ✅ 今日产出
- [ ] 五种切趾函数的优缺点对照表（旁瓣抑制 dB、主瓣展宽比例、长度代价）
- [ ] 回答：为什么比较切趾函数时必须固定公平条件？给出一个固定 $\int|\kappa|dz$ 的实例。

---

### 第 13 天：线性、二次和分段啁啾

#### 🎯 学习目标
理解啁啾如何在频率和空间之间建立映射，掌握三种啁啾实现方式（周期啁啾、宽度啁啾、联合啁啾）的物理差异。

#### 📖 理论推导（约 100 分钟）
1. 写出局域布拉格条件：$\lambda_B(z) = 2n_{\text{eff}}(z)\Lambda(z)$
2. 线性啁啾：$\lambda_B(z) = \lambda_{B,\min} + (\Delta\lambda_B/L)z$
3. 频率→反射位置映射：不同频率的光在不同 $z$ 处满足布拉格条件
4. 区分三种啁啾方式（周期变化、宽度变化、联合变化）及其制造容差

> 详细推导见 [`theory_notes.md`](theory_notes.md) §6

#### 📚 阅读材料

| 类型 | 内容 | 章节/页码 | 用时 | 深度 |
|------|------|-----------|:---:|:---:|
| 论文 | **Ouellette, "Dispersion cancellation using linearly chirped Bragg grating filters in optical waveguides," *Opt. Lett.*, 1987** | 全文 | 35 min | ★ |
| 论文 | Du et al., "Silicon nitride chirped spiral Bragg grating with large group delay," *APL Photonics*, 2020 | 全文（重点关注螺旋几何） | 30 min | ★ |
| 教材 | Kashyap | §7.1–7.4（啁啾光纤光栅的类型和色散） | 30 min | ● |
| 综述 | CBG-SiN review | §2.2（图1：三种啁啾方式的 TiKZ 示意图） | 20 min | ● |

🔗 **论文链接**：[Ouellette 1987](https://doi.org/10.1364/OL.12.000847) | [Du 2020](https://doi.org/10.1063/5.0022963)

#### 💻 代码 🔧
今天暂不运行代码。手算一个线性啁啾光栅的 $\lambda_B(z)$ 曲线。

#### ✅ 今日产出
- [ ] 给定啁啾率 $d\lambda_B/dz = 0.5$ nm/mm，$L=10$ mm，画出 $\lambda_B(z)$ 并标出 1545–1555 nm 波段内反射位置的范围
- [ ] 比较周期啁啾和宽度啁啾各一个优点和缺点

---

### 第 14 天：反射相位、群时延和 GDD

#### 🎯 学习目标
掌握从复数反射系数 $S_{11}(\omega)$ 提取群时延 $\tau_g$ 和群时延色散 GDD 的方法，理解啁啾光栅中色散量 $D \propto 2n_g L/(c\Delta\lambda_B)$ 的来源。

#### 📖 理论推导（约 90 分钟）
1. 反射相位展开：$\phi_r = \operatorname{unwrap}(\arg S_{11})$
2. 群时延：$\tau_g = -d\phi_r/d\omega$（本包约定，与 $e^{-i\omega t}$ 一致）
3. GDD：$\text{GDD} = d\tau_g/d\omega$
4. 线性啁啾光栅的色散表达式：$D \equiv d\tau_g/d\lambda \approx 2n_g L/(c\Delta\lambda_B)$
5. 理解核心矛盾：**色散量 $|D|$ ∝ 光栅长度 $L$，∝ 1/啁啾带宽 $\Delta\lambda_B$** ——长光栅→大色散但窄带宽

> 详细推导见 [`theory_notes.md`](theory_notes.md) §6

#### 📚 阅读材料

| 类型 | 内容 | 章节/页码 | 用时 | 深度 |
|------|------|-----------|:---:|:---:|
| 论文 | Du et al., 2020（同上） | 重点关注图3-4（群时延和色散测量） | 25 min | ★ |
| 论文 | Li et al., "Large group delay and low loss optical delay line based on chirped waveguide Bragg gratings," *OE*, 2023 | 摘要+图4-6 | 20 min | ● |
| 教材 | Kashyap | §7.5–7.7（啁啾光栅的群时延、GDD 和纹波） | 30 min | ● |

🔗 **论文链接**：[Li 2023](https://doi.org/10.1364/OE.480253)

#### 💻 代码 🔧

| 操作 | 文件 | 重点关注 |
|------|------|----------|
| 研读 | `matlab/+grating/phase_metrics.m` | L22–33：`unwrap(angle(response))` 和 `gradient(phase, omega)` 的实现 |

#### ✅ 今日产出
- [ ] 推导 $\tau_g = -d\phi_r/d\omega$（注意检查时间因子的符号）
- [ ] 列出群时延、GDD 的常用单位换算表（ps, ps/nm, fs², s², s²/m）

---

### 第 15 天：WKB 分析与转折点

#### 🎯 学习目标
掌握非均匀光栅的 WKB（Wentzel-Kramers-Brillouin）近似方法，能标出传播区、禁带区和转折点，判断绝热条件何时成立。

#### 📖 理论推导（约 100 分钟）
1. 定义局域特征量：$\gamma(z) = \sqrt{|\kappa(z)|^2 - \delta(z)^2}$
2. $|\delta(z)| < |\kappa(z)|$ → 禁带区（$\gamma$ 实），$|\delta(z)| > |\kappa(z)|$ → 传播区（$\gamma$ 虚）
3. 转折点：$|\delta(z)| = |\kappa(z)|$
4. 绝热条件：参数在局域耦合长度 $1/|\gamma(z)|$ 内变化足够慢
5. 强耦合/慢啁啾近似何时成立？

#### 📚 阅读材料

| 类型 | 内容 | 章节/页码 | 用时 | 深度 |
|------|------|-----------|:---:|:---:|
| 论文 | **Poladian, "Graphical and WKB analysis of nonuniform Bragg gratings," *Phys. Rev. E*, 1993** | 全文 | 50 min | ★ |
| 教材 | Kashyap | §5.10（非均匀光栅的 WKB 近似） | 30 min | ★ |
| 参考 | Marcuse, *Theory of Dielectric Optical Waveguides* | §5.1–5.3（WKB 法在非均匀波导中的应用） | — | ○ |

🔗 **论文链接**：[Poladian 1993](https://doi.org/10.1103/PhysRevE.48.4758)

#### 💻 代码 🔧
今天不运行代码。在纸上练习标出给定 $\kappa(z),\delta(z)$ 的转折点位置。

#### ✅ 今日产出
- [ ] 给定 $\kappa(z)=\kappa_0$（常数）、$\delta(z)=\text{chirp\_slope}\times(z-L/2)$，画出 $\gamma(z)$ 曲线，标出转折点
- [ ] 回答：WKB 法在什么条件下失效？给出两个具体场景。

---

### 第 16 天：Layer Peeling 与逆设计思想

#### 🎯 学习目标
理解为什么仅给定 $|r(\omega)|$ 无法唯一确定光栅结构（相位信息丢失），以及 layer peeling 算法如何利用复反射谱逐层反推 $\kappa(z)$。

#### 📖 理论推导（约 90 分钟）
1. 理解正问题（$\kappa(z)$ → $r(\omega)$）和逆问题（$r(\omega)$ → $\kappa(z)$）的根本不对称性
2. Layer peeling 的核心思想：光栅前端主要影响短时延响应 → 从时域响应逐层剥离
3. 理解为什么需要复反射系数（幅度 + 相位），仅凭反射率 $R(\omega)$ 不够

#### 📚 阅读材料

| 类型 | 内容 | 章节/页码 | 用时 | 深度 |
|------|------|-----------|:---:|:---:|
| 论文 | **Skaar, Wang & Erdogan, "On the synthesis of fiber Bragg gratings by layer peeling," *IEEE JQE*, 2001** | 全文 | 50 min | ★ |
| 教材 | Kashyap | §8.1–8.6（逆散射与光栅合成：layer-peeling 算法） | 40 min | ★ |
| 参考 | Yariv & Yeh | §13.8（耦合模方程的反问题） | — | ○ |

🔗 **论文链接**：[Skaar et al. 2001](https://doi.org/10.1109/3.903065)

#### 💻 代码 🔧
今天不要求实现 layer peeling。阅读论文中的算法伪代码，理解输入/输出格式。

#### ✅ 今日产出
- [ ] 画出 layer peeling 算法的流程图（输入→初始化→循环→输出）
- [ ] 回答：如果测量只提供了 $R(\omega)$（功率反射率）而没有相位信息，layer peeling 还能用吗？为什么？

---

### 第 17 天：切趾啁啾光栅综合设计 + 阶段三考核

#### 🎯 学习目标
综合切趾和啁啾的知识，完成一个完整的非均匀光栅设计：给定带宽、旁瓣和色散目标，设计 $\kappa(z)$ 和啁啾率。

#### 📖 理论推导（约 60 分钟）
1. 目标：在给定 $\Delta\lambda$ 带宽内实现平坦 GDD，旁瓣 < −30 dB
2. 设计策略：先确定啁啾率（满足带宽和色散），再加切趾（抑制 GDD 纹波和旁瓣）
3. 理解为什么切趾主要改旁瓣、啁啾主要改带宽和色散——以及两者如何相互影响

#### 📚 阅读材料

| 类型 | 内容 | 章节/页码 | 用时 | 深度 |
|------|------|-----------|:---:|:---:|
| 论文 | **Sinobad et al., "Dispersion Compensating SiN Waveguide Bragg Gratings for Ultrashort Pulse Compression," 2025** | 全文 | 40 min | ★ |
| 论文 | Huang et al., "Broadband on-chip dispersion compensation at 2-μm waveband using SiN chirped Bragg gratings," *OE*, 2025 | 摘要+图 | 15 min | ● |
| 综述 | CBG-SiN review | §3.3（Sinobad 2025：164 nm 带宽、62 fs 脉冲压缩） | 25 min | ★ |

🔗 **论文链接**：[Huang 2025](https://doi.org/10.1364/OE.570174) | [CBG-SiN 综述 §3.3](https://github.com/OUTERI/Ultrafast-Optics-Knowledge-Base/blob/master/cbg-sin-review/review_cbg_sin_v3.pdf)

#### 💻 代码 🔧

| 操作 | 文件 | 重点关注 |
|------|------|----------|
| 运行 | `examples/day17_chirped_apodized.m` | 四种切趾函数在相同 $\int\kappa dz$ 下的旁瓣和群时延对比 |

#### ✅ 今日产出
- [ ] 设计说明书：目标带宽、允许旁瓣、目标群时延、$\kappa(z)$ 参数、端部切趾方案
- [ ] 阶段考核：关闭啁啾和切趾后，你的光栅是否恢复为均匀光栅的响应？验证。
- [ ] 🔧 运行 `day17_chirped_apodized.m`，对比四种切趾的群时延纹波

---

## 第四阶段：高阶模式与偏振耦合（第 18–22 天）

> **核心目标**：从单模二方程推广到 N 模 2N×2N 矩阵 CMT，掌握模间相位匹配条件、选择定则和第二阻带的系统诊断方法。

---

### 第 18 天：多模矩阵 CMT

#### 🎯 学习目标
将二模耦合方程推广到 N 个前向模 + N 个后向模的 2N×2N 矩阵形式，理解多端口 S 参数的定义和总功率闭合。

#### 📖 理论推导（约 100 分钟）
1. 将状态向量扩展为 $[\mathbf{A}; \mathbf{B}]$，其中 $\mathbf{A},\mathbf{B}$ 是 $N\times1$ 向量
2. 推导块矩阵形式（见 `theory_notes.md` §7）
3. 多端口边界条件：$\mathbf{A}(0) = \mathbf{A}_0$（已知前向入射），$\mathbf{B}(L) = \mathbf{0}$（无后向入射）
4. 模式分辨功率闭合：$\sum_m R_m + \sum_m T_m + P_{\text{abs}} + P_{\text{rad}} = 1$

> 详细推导见 [`theory_notes.md`](theory_notes.md) §7

#### 📚 阅读材料

| 类型 | 内容 | 章节/页码 | 用时 | 深度 |
|------|------|-----------|:---:|:---:|
| 教材 | Coldren & Corzine | §6.10–6.12（多模耦合：矩阵形式和边界条件） | 45 min | ★ |
| 论文 | Lu & Cui, "Fiber Bragg grating spectra in multimode optical fibers," *JLT*, 2006 | §II–III（多模 CMT 公式推导） | 35 min | ★ |
| 参考 | Haus, *Waves and Fields in Optoelectronics* | §6.6–6.8（非正交模的耦合处理） | — | ○ |

🔗 **论文链接**：[Lu & Cui 2006](https://doi.org/10.1109/JLT.2005.859841)

#### 💻 代码 🔧

| 操作 | 文件 | 重点关注 |
|------|------|----------|
| 研读 | `matlab/+grating/multimode_bg.m` | L60–82：2N×2N 矩阵的构造；L84–95：多端口 S 参数的边界条件求解 |

#### ✅ 今日产出
- [ ] 手写推导：从二模方程到多模块矩阵的完整过程（N=2 情况即可）
- [ ] 验证：N=1 时多模代码退化为 `uniform_bg.m` 的结果（运行 `test_multimode_single_mode_limit`）

---

### 第 19 天：模式重叠积分与选择定则

#### 🎯 学习目标
掌握基于模场对称性的选择定则——为什么某些模式对之间的 $\kappa_{mn}=0$，以及几何不对称如何"打开"禁戒耦合通道。

#### 📖 理论推导（约 90 分钟）
1. 横向对称性分析：扰动关于 $x$（横向）中心面对称时，奇偶性不同的模式对 $\iint \to 0$
2. 纵向对称性：光栅齿的对称轮廓 → 特定 Fourier 谐波消失
3. 对比单侧侧壁光栅（对称性破缺）和双侧对称光栅的允许耦合通道

> 详细推导见 [`theory_notes.md`](theory_notes.md) §7.1

#### 📚 阅读材料

| 类型 | 内容 | 章节/页码 | 用时 | 深度 |
|------|------|-----------|:---:|:---:|
| 教材 | Okamoto | §4.10（耦合系数的对称性和选择定则） | 30 min | ★ |
| 教材 | Snyder & Love | Part II §12（模式分类和宇称性质） | 25 min | ● |
| 论文 | Hardy & Streifer, "Coupled mode theory of parallel waveguides," *JLT*, 1985 | §III（耦合系数的对称性） | 20 min | ● |

#### ✅ 今日产出
- [ ] 选择定则判断表：TE₀–TE₁、TE₀–TE₂、TE₀–TM₀ 在双侧对称/单侧/倾斜光栅下的 $\kappa$ 是否为零
- [ ] 解释：如果想用单侧光栅实现 TE₀–TE₁ 耦合，应该如何放置光栅齿？

---

### 第 20 天：TE/TM 双阻带

#### 🎯 学习目标
理解 TE 和 TM 偏振由于 $n_{\text{eff}}$ 不同而在不同波长处产生 Bragg 反射，掌握 SiN 几何双折射 vs LNOI 材料双折射的区别。

#### 📖 理论推导（约 80 分钟）
1. 分别写出 TE 和 TM 的 Bragg 条件：$\lambda_B^{\text{TE}} = 2n_{\text{eff}}^{\text{TE}}\Lambda$，$\lambda_B^{\text{TM}} = 2n_{\text{eff}}^{\text{TM}}\Lambda$
2. 双折射 $\Delta n = n_{\text{eff}}^{\text{TE}} - n_{\text{eff}}^{\text{TM}}$ 决定阻带分离量
3. SiN：几何双折射（波导截面形状）为主 → 可通过波导设计调控
4. LNOI：材料双折射（晶轴各向异性）+ 几何双折射 → 设计更复杂但自由度更多

#### 📚 阅读材料

| 类型 | 内容 | 章节/页码 | 用时 | 深度 |
|------|------|-----------|:---:|:---:|
| 论文 | **Zhan et al., "Silicon nitride polarization beam splitter based on polarization-independent MMIs and apodized Bragg gratings," *OE*, 2021** | 全文 | 40 min | ★ |
| 论文 | Liu & Dai, "Large-scale dispersion compensation with a TM-type chirped multimode waveguide grating," *COL*, 2024 | 摘要+Fig.1-3 | 20 min | ● |
| 综述 | CBG-SiN review | §4.2（TM 型 CMWG 的工艺鲁棒性） | 20 min | ● |

🔗 **论文链接**：[Zhan 2021](https://doi.org/10.1364/OE.420499) | [Liu & Dai 2024](https://doi.org/10.3788/COL202422.121301)

#### ✅ 今日产出
- [ ] 计算：SiN 波导 TE 和 TM 的 $n_{\text{eff}}$ 差 0.05 时，1550 nm 处的阻带间隔是多少 nm？
- [ ] 回答：为什么用偏振分束器（PBS）+ Bragg 光栅可以实现偏振选择性的色散补偿？

---

### 第 21 天：基模—高阶模反向耦合

#### 🎯 学习目标
区分两类根本不同的相位匹配条件：自耦合 $2\beta_m = K$ 和模间耦合 $\beta_m + \beta_n = K$，理解耦合后的模式去向。

#### 📖 理论推导（约 90 分钟）
1. 枚举所有候选模式对的相位匹配条件
2. 功率去向分析：反射回输入端口 vs 耦合到其他导模 vs 辐射泄漏 vs 未被检测

#### 📚 阅读材料

| 类型 | 内容 | 章节/页码 | 用时 | 深度 |
|------|------|-----------|:---:|:---:|
| 论文 | **Ning et al., "Narrow-band Add-Drop Filters Based on Silicon Nitride Multimode Waveguide Bragg Grating," *LPT*, 2024** | 全文 | 35 min | ★ |
| 论文 | Xu, Tu & Liu, "High performance TM-pass polarizer using multimode Bragg grating waveguide," *OE*, 2024 | 摘要+Fig.1-4 | 20 min | ● |
| 综述 | CBG-SiN review | §4.1（Liu & Dai 2023：CMWG 正/负色散可调谐的架构） | 30 min | ★ |

🔗 **论文链接**：[Ning 2024](https://doi.org/10.1109/LPT.2023.3289864) | [Xu 2024](https://doi.org/10.1364/OE.520833)

#### 💻 代码 🔧

| 操作 | 文件 | 重点关注 |
|------|------|----------|
| 运行 | `examples/day22_secondary_stopband.m` | 观察 `couplingWithCrossMode` vs `couplingWithoutCrossMode` 的透射谱差异 |

#### ✅ 今日产出
- [ ] 列出 2 模系统中所有可能的 $(m,n)$ 对及其相位匹配条件
- [ ] 解释：为什么 TE₀ 自耦合阻带和 TE₀→TE₁ 模间耦合阻带可能出现在不同波长？

---

### 第 22 天：第二阻带系统诊断 + 阶段四考核

#### 🎯 学习目标
面对未知器件的反射/透射谱中出现"意料之外的凹陷"时，能给出有优先级、可证伪的诊断流程。

#### 📖 四步诊断流程
1. **相位匹配分析**：叠加所有 $2\beta_m=K$ 和 $\beta_m+\beta_n=K$ 分支
2. **对称性筛选**：根据光栅几何判断哪些 $\kappa_{mn}=0$
3. **对照实验**：在仿真中将可疑 $\kappa_{mn}$ 置零 → 若凹陷消失，确认来源
4. **功率闭合**：$R+T+$吸收+辐射+未统计模式 $=1$

> 完整流程见 [`theory_notes.md`](theory_notes.md) §7.2

#### 📚 阅读材料

| 类型 | 内容 | 章节/页码 | 用时 | 深度 |
|------|------|-----------|:---:|:---:|
| 论文 | **Liu & Dai, "On-chip digitally-tunable positive/negative dispersion controller using bidirectional chirped multimode waveguide gratings," *Adv. Photonics*, 2023** | 全文（以该器件的多阻带谱图为诊断练习） | 45 min | ★ |
| 回顾 | 阶段四所有 ★ 论文 | 复习关键图表 | 20 min | ● |

#### 💻 代码 🔧

| 操作 | 文件 | 重点关注 |
|------|------|----------|
| 运行 | `examples/day22_secondary_stopband.m` | 置零交叉耦合项后观察第二凹陷消失 |
| 验证 | `tests/run_all_tests.m` | `test_cross_mode_stopband` 通过 |

#### ✅ 今日产出
- [ ] 对 `day22_secondary_stopband.m` 的谱图写出正式的四步诊断报告
- [ ] 阶段考核：给出旁瓣、偏振阻带、模间阻带、辐射损耗的四步判别流程图
- [ ] 改变光栅长度 → 验证旁瓣间距变化而模式相位匹配中心不变

---

## 第五阶段：集成垂直光栅耦合器（第 23–28 天）

> **核心目标**：从波导模间的耦合跃迁到波导模→自由空间辐射模的耦合，掌握 Floquet 相位匹配、辐射包络设计、效率预算和完全垂直耦合的挑战。

> **深度参考**：完整的辐射模严格电磁理论（Green 函数法、泄漏模本征值、分层介质方向性）见 [`vertical_gc_theory_deep.md`](vertical_gc_theory_deep.md)，建议第 24–25 天按需精读对应章节。

---

### 第 23 天：Floquet 衍射与相位匹配

#### 🎯 学习目标
从纵向动量守恒推导辐射角与光栅周期的关系，理解衍射级次和符号约定。

#### 📖 理论推导（约 90 分钟）
1. 写出周期波导中导模→辐射模的 Floquet 条件：$\beta - k_0 n_c\sin\theta = mK$，$m=0,\pm1,\pm2,\ldots$
2. 选定一阶衍射 $m=1$：$\Lambda = \lambda / (n_{\text{eff}} - n_c\sin\theta)$
3. 解释为什么严格设计应使用泄漏 Bloch 模的复传播常数 $\tilde{\beta} = \beta - i\alpha$

> 详细推导见 [`theory_notes.md`](theory_notes.md) §8 和 [`vertical_gc_theory_deep.md`](vertical_gc_theory_deep.md) §A.1

#### 📚 阅读材料

| 类型 | 内容 | 章节/页码 | 用时 | 深度 |
|------|------|-----------|:---:|:---:|
| 论文 | **Tamir & Peng, "Analysis and design of grating couplers," *Appl. Phys.*, 1977** | §II–III（Floquet-Bloch 展开和辐射条件） | 45 min | ★ |
| 论文 | **Taillaert et al., "Grating Couplers for Coupling between Optical Fibers and Nanophotonic Waveguides," *JJAP*, 2006** | 全文 | 40 min | ★ |
| 教材 | Yariv & Yeh | §13.10（光栅耦合器的波矢匹配） | 20 min | ● |

🔗 **论文链接**：[Tamir & Peng 1977](https://doi.org/10.1007/BF00882729) | [Taillaert 2006](https://doi.org/10.1143/JJAP.45.6071)

#### ✅ 今日产出
- [ ] 手写推导：从 $\beta - k_0 n_c\sin\theta = mK$ 到 $\Lambda = \lambda/(n_{\text{eff}} - n_c\sin\theta)$
- [ ] 计算：$\lambda=1550$ nm，$n_{\text{eff}}=1.8$，$n_c=1.0$，$\theta=8°$ 时 $\Lambda$ 是多少？如果改用 $\theta=0°$ 呢？

---

### 第 24 天：辐射率、抽取与方向性

#### 🎯 学习目标
掌握功率衰减方程 $dP/dz = -2\alpha P$ 和效率预算的四个因子分解，理解多层介质中向上/向下辐射的干涉。

#### 📖 理论推导（约 100 分钟）
1. 功率衰减方程和辐射包络的概念
2. 效率分解：$\eta_{\text{total}} = \eta_{\text{extract}} \times D_{\text{up}} \times \eta_{\text{overlap}} \times \eta_{\text{transition}}$
3. 方向性 $D_{\text{up}}$：向上辐射功率占总辐射功率的比例，由多层介质的 Fresnel 反射和干涉决定
4. BOX 厚度对方向性的周期性调制（周期 $\approx \lambda/(2n_{\text{BOX}}\cos\theta)$）

> 深度内容见 [`vertical_gc_theory_deep.md`](vertical_gc_theory_deep.md) §A.3–A.4

#### 📚 阅读材料

| 类型 | 内容 | 章节/页码 | 用时 | 深度 |
|------|------|-----------|:---:|:---:|
| 论文 | **Van Laere et al., "Compact and Highly Efficient Grating Couplers Between Optical Fiber and Nanophotonic Waveguides," *JLT*, 2007** | 全文 | 40 min | ★ |
| 教材 | Marcuse | §3.1–3.5（辐射模的严格展开和泄漏模分析） | 35 min | ● |
| 参考 | Joannopoulos | §4.6–4.7（光子晶体平板中的泄漏模） | — | ○ |

🔗 **论文链接**：[Van Laere 2007](https://doi.org/10.1109/JLT.2006.888164)

#### 💻 代码 🔧

| 操作 | 文件 | 重点关注 |
|------|------|----------|
| 研读 | `matlab/+grating/vertical_gc.m` | L55–65：效率预算的四因子乘法和总效率计算 |

#### ✅ 今日产出
- [ ] 画出完整效率预算框图（四因子×箭头→总效率）
- [ ] 解释：如果总效率很低（<10%），如何从四个因子中定位瓶颈？

---

### 第 25 天：高斯模式匹配与解析切趾

#### 🎯 学习目标
掌握 **$\alpha(z)$ 反演公式**的完整推导，理解为什么需要**复振幅**重叠（而不仅仅是功率重叠）才能实现高效耦合。

#### 📖 理论推导（约 100 分钟）
1. 从功率守恒推导 $\alpha(z)$ 反演公式
2. 辐射场复振幅：$E_{\text{rad}}(z) = \sqrt{2\alpha(z)P(z)} e^{i\phi_{\text{rad}}(z)}$
3. **复振幅重叠效率**（核心公式）：$\eta_{\text{overlap}} = |\int E_{\text{rad}} E_{\text{fiber}}^* dz|^2 / (\int |E_{\text{rad}}|^2 \cdot \int |E_{\text{fiber}}|^2)$

> 完整推导和数值注意事项见 [`vertical_gc_theory_deep.md`](vertical_gc_theory_deep.md) §B.1–B.2

#### 📚 阅读材料

| 类型 | 内容 | 章节/页码 | 用时 | 深度 |
|------|------|-----------|:---:|:---:|
| 论文 | **Zhao & Fan, "Design Principles of Apodized Grating Couplers," *JLT*, 2020** | 全文 | 45 min | ★ |
| 教材 | Okamoto | §5.1–5.3（光纤模式和高斯近似） | 20 min | ● |

🔗 **论文链接**：[Zhao & Fan 2020](https://doi.org/10.1109/JLT.2020.2992574)

#### 💻 代码 🔧

| 操作 | 文件 | 重点关注 |
|------|------|----------|
| 研读 | `matlab/+grating/vertical_gc.m` | L43–48：$\alpha(z)$ 反演的代码实现；L49–55：复振幅重叠效率计算 |

#### ✅ 今日产出
- [ ] 手写推导 $\alpha(z)$ 反演公式的完整过程（从 $dP/dz=-2\alpha P$ 出发）
- [ ] 解释：为什么 $\eta_e \to 1$ 时 $\alpha(z)$ 在 $z\to L$ 处发散？这说明什么物理限制？
- [ ] 给定高斯型 $p_t(z)$，$\eta_e=0.9$，手算 $\alpha(z)$ 在 $z=0, L/2, 0.9L$ 处的值

---

### 第 26 天：带宽、方向性与容差分析

#### 🎯 学习目标
构建垂直光栅耦合器的容差因果图，能排序最敏感参数。

#### 📖 理论推导（约 80 分钟）
1. 灵敏度因果图：$\Delta\Lambda \to \Delta\lambda_B$、$\Delta h \to \Delta\alpha$、$\Delta h_{\text{BOX}} \to \Delta D_{\text{up}}$、$\Delta\theta \to \Delta\eta_{\text{overlap}}$
2. 最敏感参数排序：周期 > 光纤角度 > 刻蚀深度 > BOX 厚度 > 占空比

> 详细容差因果图见 [`vertical_gc_theory_deep.md`](vertical_gc_theory_deep.md) §B.4

#### 📚 阅读材料

| 类型 | 内容 | 章节/页码 | 用时 | 深度 |
|------|------|-----------|:---:|:---:|
| 教材 | Chrostowski & Hochberg | §5.9–5.11（光栅耦合器的容差分析和制造考虑） | 30 min | ● |
| 论文 | 回顾 Van Laere 2007 | 容差分析部分 | 20 min | ● |
| 参考 | Marcuse | §4.1–4.4（多层结构中的辐射场和干涉效应） | — | ○ |

#### ✅ 今日产出
- [ ] 容差因果图（箭头图）：标注 6 个工艺参数→效率因子的影响路径
- [ ] 排列 TOP 3 最敏感参数，给出 3σ 容差窗口的估算值

---

### 第 27 天：聚焦光栅、亚波长工程与完全垂直耦合

#### 🎯 学习目标
理解亚波长光栅（SWG）的等效介质原理，掌握完全垂直耦合（$\theta=0$）的核心挑战——二阶后向 Bragg 反射——及五种抑制策略。

#### 📖 理论推导（约 80 分钟）
1. 亚波长光栅的等效折射率：当 $\Lambda \ll \lambda/(2n_{\text{eff}})$ 时，光栅表现为均匀等效介质
2. 完全垂直耦合的矛盾：一阶辐射条件 $K=\beta$ 自动满足二阶 Bragg 条件 $2\beta=2K$
3. 五种抑制反射策略的原理对比

> 详细分析见 [`vertical_gc_theory_deep.md`](vertical_gc_theory_deep.md) §B.5

#### 📚 阅读材料

| 类型 | 内容 | 章节/页码 | 用时 | 深度 |
|------|------|-----------|:---:|:---:|
| 论文 | **Benedikovic et al., "Subwavelength index engineered surface grating coupler with sub-decibel efficiency," *OE*, 2015** | 全文 | 40 min | ★ |
| 论文 | **Michaels & Yablonovitch, "Inverse design of near unity efficiency perfectly vertical grating couplers," *OE*, 2018** | 全文 | 40 min | ★ |
| 教材 | Joannopoulos | §5.1–5.4（亚波长光栅和等效介质理论） | 25 min | ● |

🔗 **论文链接**：[Benedikovic 2015](https://doi.org/10.1364/OE.23.022628) | [Michaels & Yablonovitch 2018](https://doi.org/10.1364/OE.26.004766)

#### ✅ 今日产出
- [ ] 五种抑制二阶反射策略的对比表（原理、典型效率、复杂度）
- [ ] 回答：Benedikovic 的亚波长方案是如何同时实现高方向性 + 抑制后向反射的？

---

### 第 28 天：SiN/LNOI 垂直光栅解析初算 + 阶段五考核

#### 🎯 学习目标
完成 SiN 和 LNOI 垂直光栅耦合器的完整解析初始设计表，明确哪些量可解析计算、哪些必须由全波方法提供。

#### 📚 阅读材料

| 类型 | 内容 | 章节/页码 | 用时 | 深度 |
|------|------|-----------|:---:|:---:|
| 论文 | **Xue et al., "Inverse design and fabrication of high-efficiency perfectly vertical LNOI grating couplers," *OL*, 2025** | 全文 | 35 min | ★ |
| 论文 | **Zou et al., "Ultra efficient silicon nitride grating coupler with bottom grating reflector," *OE*, 2015** | 全文 | 35 min | ★ |
| 回顾 | Tamir & Peng, Taillaert, Van Laere, Zhao & Fan | 关键公式 | 15 min | ● |

🔗 **论文链接**：[Xue 2025](https://doi.org/10.1364/OL.549856) | [Zou 2015](https://doi.org/10.1364/OE.23.026305)

#### 💻 代码 🔧

| 操作 | 文件 | 重点关注 |
|------|------|----------|
| 运行 | `examples/day28_vertical_gc.m` | SiN 和 LNOI 的效率预算对比（注意 `directionality` 是假设值） |
| 验证 | `tests/run_all_tests.m` | `test_vertical_gc` 通过 |

#### ✅ 今日产出
- [ ] SiN 和 LNOI 垂直光栅的完整设计表（9 项参数 + 效率预算四分拆）
- [ ] 标注：哪些量可以解析计算（✓）、哪些必须全波仿真标定（✗）、哪些是设计假设（?）
- [ ] 阶段考核：解释为什么解析周期 $\Lambda = \lambda/(n_{\text{eff}} - n_c\sin\theta)$ 只是全波优化的初始值

---

## 第六阶段：综合与贯通（第 29–30 天）

> **核心目标**：将五个阶段的知识串联为统一的物理图像，整理公式手册，完成综合报告。

---

### 第 29 天：统一公式手册与模型边界

#### 🎯 学习目标
将所有推导整理成不超过 10 页的公式手册，统一约定，明确每个理论模型的适用范围和失效条件。

#### 📖 任务（约 180 分钟）
1. 整理五套必备理论的公式（见 `stage_outline.md` §三）
2. 为每个 MATLAB 求解器编写 3 行接口说明：输入、输出、守恒检查

#### 📚 阅读材料

| 类型 | 内容 | 用时 | 深度 |
|------|------|:---:|:---:|
| 回顾 | 所有 ★ 论文的关键公式 | 60 min | ○ |
| 回顾 | 本路线图第 1–28 天的所有"今日产出" | 30 min | ● |
| 参考 | Marcuse §5.5–5.7（模式展开的收敛性和截断误差） | 20 min | ○ |

#### 💻 代码 🔧

| 操作 | 命令 |
|------|------|
| 全测试 | `setup; run_all_tests;` （6 个测试应全部通过） |

#### ✅ 今日产出
- [ ] ≤10 页的统一公式手册（含约定、核心公式、失效条件）
- [ ] 四个求解器的接口规格（输入/输出/守恒检查）
- [ ] 所有 6 个测试通过

---

### 第 30 天：综合报告

#### 🎯 学习目标
完成一份涵盖全部五个阶段关键产出的综合报告。

#### 📖 报告结构（必须包含 5 个部分）

**§1 — SiN 切趾啁啾 Bragg 光栅理论设计**
- 目标指标（带宽、色散、旁瓣）、$\kappa(z)$ 和啁啾率的设计选择、切趾方案

**§2 — 第二阻带的模式分辨诊断**
- 展示多模 CMT 仿真谱图、应用四步诊断法

**§3 — LNOI 垂直光栅耦合器解析初算**
- 完整设计表（9 项参数 + $\eta_{\text{total}}$ 四分拆）

**§4 — 各理论方法的适用条件与全波边界**
- CMT 失效条件（≥3 个）、TMM 失效条件（≥2 个）、必须转入 RCWA/FDTD/FEM/EME 的场景（≥5 个）

**§5 — 后续代码的生成顺序与测试标准**

#### 📚 阅读材料

| 类型 | 内容 | 用时 | 深度 |
|------|------|:---:|:---:|
| 综述 | CBG-SiN review §7（总结与展望） | 30 min | ★ |
| 教材 | Chrostowski & Hochberg §10（从设计到版图） | 20 min | ● |

#### ✅ 今日产出
- [ ] 综合报告（≥5 个必需章节，建议总篇幅 8–15 页）
- [ ] 报告中每个数值结论都有对应的公式来源或代码验证

---

## 月底验收标准

完成 30 天学习后，你应该能够：

- [ ] 从互易定理独立推导二模和多模耦合方程
- [ ] 闭卷写出 Bragg 条件、$R_{\max}$ 公式和阻带宽度估算
- [ ] 说明相位匹配、耦合强度、长度、切趾和啁啾分别控制光栅响应的哪个方面
- [ ] 从目标波长和反射率反推光栅周期与 $\kappa L$ 的数量级
- [ ] 对未知器件谱图中的"异常凹陷"提出有优先级、可证伪的诊断方案
- [ ] 完成垂直光栅的周期、$\alpha(z)$ 辐射包络、模式重叠和效率预算
- [ ] 识别每个理论模型的失效边界，知道何时应转入全波方法

---

> **后续**：完成本路线图后，可进入 MATLAB 代码的逐行补全和仿真练习阶段（参考现有代码骨架 `matlab/+grating/` 和 `examples/`）。

---

## 📖 完整参考文献库

### 使用说明
- 每篇文献标注了对应的天次和深度标记（★精读/●通读/○速览）
- DOI 链接可直接打开（需机构订阅或 Sci-Hub）
- 教材标注了具体章节和页码范围
- 综述论文（CBG-SiN Review）标注了对应节号

### 论文全文获取
多数论文可通过以下方式获取全文：
1. 通过机构图书馆的 CARSI 认证
2. [Sci-Hub](https://sci-hub.se)（输入 DOI）
3. [arXiv](https://arxiv.org)（预印本）
4. [ResearchGate](https://researchgate.net)（作者上传版）

---

### 阶段一：均匀集成布拉格光栅（第 1–5 天）

| # | 天次 | 深度 | 文献 | DOI |
|:---:|:---:|:---:|---|---|
| 1 | 2 | ★ | H. Kogelnik, "Coupled Wave Theory for Thick Hologram Gratings," *Bell Syst. Tech. J.*, vol. 48, pp. 2909–2947, 1969 | [10.1002/j.1538-7305.1969.tb01198.x](https://doi.org/10.1002/j.1538-7305.1969.tb01198.x) |
| 2 | 2,3 | ★ | T. Erdogan, "Fiber grating spectra," *J. Lightwave Technol.*, vol. 15, pp. 1277–1294, 1997 | [10.1109/50.618322](https://doi.org/10.1109/50.618322) |
| 3 | 4 | ★ | E. Peral and J. Capmany, "Generalized Bloch wave analysis for fiber and waveguide gratings," *J. Lightwave Technol.*, vol. 15, pp. 1295–1302, 1997 | [10.1109/50.618325](https://doi.org/10.1109/50.618325) |
| 4 | 1 | ● | A. Yariv, "Coupled-mode theory for guided-wave optics," *IEEE J. Quantum Electron.*, vol. 9, pp. 919–933, 1973 | [10.1109/JQE.1973.1077767](https://doi.org/10.1109/JQE.1973.1077767) |
| 5 | 2 | ● | H. A. Haus and W.-P. Huang, "Coupled-mode theory," *Proc. IEEE*, vol. 79, pp. 1505–1518, 1991 | [10.1109/5.104225](https://doi.org/10.1109/5.104225) |
| 6 | 2 | ● | W.-P. Huang, "Coupled-mode theory for optical waveguides: an overview," *J. Opt. Soc. Am. A*, vol. 11, pp. 963–983, 1994 | [10.1364/JOSAA.11.000963](https://doi.org/10.1364/JOSAA.11.000963) |
| 7 | 4 | ● | P. Yeh, A. Yariv, and C.-S. Hong, "Electromagnetic propagation in periodic stratified media. I. General theory," *J. Opt. Soc. Am.*, vol. 67, pp. 423–438, 1977 | [10.1364/JOSA.67.000423](https://doi.org/10.1364/JOSA.67.000423) |
| 8 | 4 | ○ | P. St. J. Russell, "Bloch wave analysis of dispersion and pulse propagation in pure distributed feedback structures," *J. Mod. Opt.*, vol. 38, pp. 1599–1619, 1991 | [10.1080/09500349114551751](https://doi.org/10.1080/09500349114551751) |
| 9 | 1 | ○ | K. O. Hill and G. Meltz, "Fiber Bragg grating technology fundamentals and overview," *J. Lightwave Technol.*, vol. 15, pp. 1263–1276, 1997 | [10.1109/50.618320](https://doi.org/10.1109/50.618320) |

### 阶段二：集成结构与正向设计（第 6–10 天）

| # | 天次 | 深度 | 文献 | DOI |
|:---:|:---:|:---:|---|---|
| 10 | 6 | ★ | W. Streifer, D. Scifres, and R. Burnham, "Coupling coefficients for distributed feedback single- and double-heterostructure diode lasers," *IEEE J. Quantum Electron.*, vol. 11, pp. 867–873, 1975 | [10.1109/JQE.1975.1068537](https://doi.org/10.1109/JQE.1975.1068537) |
| 11 | 8 | ★ | M. J. Strain et al., "Design and Fabrication of Integrated Chirped Bragg Gratings for On-Chip Dispersion Control," *IEEE J. Quantum Electron.*, vol. 46, pp. 774–782, 2010 | [10.1109/JQE.2010.2042464](https://doi.org/10.1109/JQE.2010.2042464) |
| 12 | 10 | ★ | J. Á. Praena and A. Carballar, "Chirped Integrated Bragg Grating Design," *Photonics*, vol. 11, 476, 2024 | [10.3390/photonics11050476](https://doi.org/10.3390/photonics11050476) |
| 13 | 9 | ● | C. Guyot et al., "Optical characterization of ultra-short Bragg grating on lithium niobate ridge waveguide," *Opt. Lett.*, vol. 39, pp. 371–374, 2014 | [10.1364/OL.39.000371](https://doi.org/10.1364/OL.39.000371) |
| 14 | 9 | ● | D. Pohl et al., "100-GBd Waveguide Bragg Grating Modulator in Thin-Film Lithium Niobate," *IEEE Photon. Technol. Lett.*, vol. 33, pp. 85–88, 2021 | [10.1109/LPT.2020.3044648](https://doi.org/10.1109/LPT.2020.3044648) |
| 15 | 9 | ● | J. Zhan et al., "Silicon nitride polarization beam splitter based on polarization-independent MMIs and apodized Bragg gratings," *Opt. Express*, vol. 29, pp. 14476–14485, 2021 | [10.1364/OE.420499](https://doi.org/10.1364/OE.420499) |
| 16 | 10 | ● | R. Cheng and L. Chrostowski, "Spectral Design of Silicon Integrated Bragg Gratings: A Tutorial," *J. Lightwave Technol.*, vol. 39, pp. 712–729, 2021 | [10.1109/JLT.2020.3032659](https://doi.org/10.1109/JLT.2020.3032659) |
| 17 | 8 | ○ | W. Zhang and J. Yao, "A fully reconfigurable waveguide Bragg grating for programmable photonic signal processing," *Nat. Commun.*, vol. 9, 1396, 2018 | [10.1038/s41467-018-03742-1](https://doi.org/10.1038/s41467-018-03742-1) |

### 阶段三：切趾与啁啾（第 11–17 天）

| # | 天次 | 深度 | 文献 | DOI |
|:---:|:---:|:---:|---|---|
| 18 | 13 | ★ | F. Ouellette, "Dispersion cancellation using linearly chirped Bragg grating filters in optical waveguides," *Opt. Lett.*, vol. 12, pp. 847–849, 1987 | [10.1364/OL.12.000847](https://doi.org/10.1364/OL.12.000847) |
| 19 | 12 | ★ | A. D. Simard et al., "Apodized Silicon-on-Insulator Bragg Gratings," *IEEE Photon. Technol. Lett.*, vol. 24, pp. 1035–1037, 2012 | [10.1109/LPT.2012.2194278](https://doi.org/10.1109/LPT.2012.2194278) |
| 20 | 15 | ★ | L. Poladian, "Graphical and WKB analysis of nonuniform Bragg gratings," *Phys. Rev. E*, vol. 48, pp. 4758–4767, 1993 | [10.1103/PhysRevE.48.4758](https://doi.org/10.1103/PhysRevE.48.4758) |
| 21 | 16 | ★ | J. Skaar, L. Wang, and T. Erdogan, "On the synthesis of fiber Bragg gratings by layer peeling," *IEEE J. Quantum Electron.*, vol. 37, pp. 165–173, 2001 | [10.1109/3.903065](https://doi.org/10.1109/3.903065) |
| 22 | 13 | ★ | Z. Du et al., "Silicon nitride chirped spiral Bragg grating with large group delay," *APL Photonics*, vol. 5, 101302, 2020 | [10.1063/5.0022963](https://doi.org/10.1063/5.0022963) |
| 23 | 14 | ● | Li et al., "Large group delay and low loss optical delay line based on chirped waveguide Bragg gratings," *Opt. Express*, vol. 31, pp. 4630–4641, 2023 | [10.1364/OE.480253](https://doi.org/10.1364/OE.480253) |
| 24 | 17 | ★ | M. Sinobad et al., "Dispersion Compensating Silicon Nitride Waveguide Bragg Gratings for Ultrashort Pulse Compression," *IEEE Photon. Conf. (IPC)*, 2025 | search on Google Scholar |
| 25 | 17 | ● | Huang et al., "Broadband on-chip dispersion compensation at 2-μm waveband using silicon nitride chirped Bragg gratings," *Opt. Express*, vol. 33, 26939, 2025 | [10.1364/OE.570174](https://doi.org/10.1364/OE.570174) |
| 26 | 13 | ● | K. O. Hill et al., "Chirped in-fiber Bragg gratings for compensation of optical fiber dispersion," *Opt. Lett.*, vol. 19, pp. 1314–1316, 1994 | [10.1364/OL.19.001314](https://doi.org/10.1364/OL.19.001314) |
| 27 | 13 | ○ | B. J. Eggleton et al., "Experimental demonstration of compression of dispersed optical pulses by reflection from self-chirped optical fibre Bragg gratings," *Opt. Lett.*, vol. 19, pp. 877–879, 1994 | [10.1364/OL.19.000877](https://doi.org/10.1364/OL.19.000877) |
| 28 | 17 | ○ | W. H. Loh et al., "10 cm chirped fibre Bragg grating for dispersion compensation at 10 Gbit/s over 400 km of non-dispersion shifted fibre," *Electron. Lett.*, vol. 31, pp. 2203–2204, 1995 | [10.1049/el:19951497](https://doi.org/10.1049/el:19951497) |
| 29 | 11 | ○ | M. J. Strain, "Integrated chirped Bragg gratings for dispersion control," PhD Thesis, University of Glasgow, 2007 | [theses.gla.ac.uk](https://theses.gla.ac.uk/23/) |
| 30 | 11 | ○ | H. Kogelnik, "Filter Response of Nonuniform Almost-Periodic Structures," *Bell Syst. Tech. J.*, vol. 55, pp. 109–126, 1976 | [10.1002/j.1538-7305.1976.tb02862.x](https://doi.org/10.1002/j.1538-7305.1976.tb02862.x) |

### 阶段四：高阶模式与偏振耦合（第 18–22 天）

| # | 天次 | 深度 | 文献 | DOI |
|:---:|:---:|:---:|---|---|
| 31 | 18 | ★ | C. Lu and Y. Cui, "Fiber Bragg grating spectra in multimode optical fibers," *J. Lightwave Technol.*, vol. 24, pp. 306–314, 2006 | [10.1109/JLT.2005.859841](https://doi.org/10.1109/JLT.2005.859841) |
| 32 | 22 | ★ | S. Liu, D. Liu, Z. Yu, L. Liu, Y. Shi, D. Dai, "On-chip digitally-tunable positive/negative dispersion controller using bidirectional chirped multimode waveguide gratings," *Adv. Photonics*, vol. 5, 056005, 2023 | [10.1117/1.AP.5.5.056005](https://doi.org/10.1117/1.AP.5.5.056005) |
| 33 | 21 | ★ | N. Ning et al., "Narrow-band Add-Drop Filters Based on Silicon Nitride Multimode Waveguide Bragg Grating," *IEEE Photon. Technol. Lett.*, vol. 36, pp. 125–128, 2024 | [10.1109/LPT.2023.3289864](https://doi.org/10.1109/LPT.2023.3289864) |
| 34 | 21 | ● | Z. Xu, B. Tu, and H. Liu, "High performance TM-pass polarizer using multimode Bragg grating waveguide," *Opt. Express*, vol. 32, pp. 10123–10133, 2024 | [10.1364/OE.520833](https://doi.org/10.1364/OE.520833) |
| 35 | 20 | ★ | J. Zhan et al., "Silicon nitride polarization beam splitter based on polarization-independent MMIs and apodized Bragg gratings," *Opt. Express*, 2021 | (see #15 above) |
| 36 | 20 | ● | S. Liu, R. Ma, W. Zhao, Z. Yu, D. Dai, "Large-scale dispersion compensation with a TM-type chirped multimode waveguide grating," *Chin. Opt. Lett.*, vol. 22, 121301, 2024 | [10.3788/COL202422.121301](https://doi.org/10.3788/COL202422.121301) |
| 37 | 21 | ● | S. Hong et al., "Multimode-enabled silicon photonic delay lines: break the delay-density limit," *Light Sci. Appl.*, vol. 14, 114, 2025 | [10.1038/s41377-025-01778-9](https://doi.org/10.1038/s41377-025-01778-9) |
| 38 | 19 | ● | A. Hardy and W. Streifer, "Coupled mode theory of parallel waveguides," *J. Lightwave Technol.*, vol. 3, pp. 1135–1146, 1985 | [10.1109/JLT.1985.1074291](https://doi.org/10.1109/JLT.1985.1074291) |
| 39 | 18 | ○ | T. Mizuno et al., "Coupled-mode theory of multiwaveguide systems," *J. Lightwave Technol.*, vol. 20, pp. 1250–1258, 2002 | [10.1109/JLT.2002.800294](https://doi.org/10.1109/JLT.2002.800294) |
| 40 | 18 | ○ | C.-S. Kim et al., "Multimode photonic wire Bragg grating," *Opt. Express*, vol. 21, pp. 31367–31374, 2013 | [10.1364/OE.21.031367](https://doi.org/10.1364/OE.21.031367) |

### 阶段五：垂直光栅耦合器（第 23–28 天）

| # | 天次 | 深度 | 文献 | DOI |
|:---:|:---:|:---:|---|---|
| 41 | 23 | ★ | T. Tamir and S. T. Peng, "Analysis and design of grating couplers," *Appl. Phys.*, vol. 14, pp. 235–254, 1977 | [10.1007/BF00882729](https://doi.org/10.1007/BF00882729) |
| 42 | 23 | ★ | D. Taillaert et al., "Grating Couplers for Coupling between Optical Fibers and Nanophotonic Waveguides," *Jpn. J. Appl. Phys.*, vol. 45, pp. 6071–6077, 2006 | [10.1143/JJAP.45.6071](https://doi.org/10.1143/JJAP.45.6071) |
| 43 | 24 | ★ | F. Van Laere et al., "Compact and Highly Efficient Grating Couplers Between Optical Fiber and Nanophotonic Waveguides," *J. Lightwave Technol.*, vol. 25, pp. 151–156, 2007 | [10.1109/JLT.2006.888164](https://doi.org/10.1109/JLT.2006.888164) |
| 44 | 25 | ★ | Z. Zhao and S. Fan, "Design Principles of Apodized Grating Couplers," *J. Lightwave Technol.*, vol. 38, pp. 4435–4444, 2020 | [10.1109/JLT.2020.2992574](https://doi.org/10.1109/JLT.2020.2992574) |
| 45 | 27 | ★ | D. Benedikovic et al., "Subwavelength index engineered surface grating coupler with sub-decibel efficiency for 220-nm silicon-on-insulator waveguides," *Opt. Express*, vol. 23, pp. 22628–22635, 2015 | [10.1364/OE.23.022628](https://doi.org/10.1364/OE.23.022628) |
| 46 | 27 | ★ | A. Michaels and E. Yablonovitch, "Inverse design of near unity efficiency perfectly vertical grating couplers," *Opt. Express*, vol. 26, pp. 4766–4779, 2018 | [10.1364/OE.26.004766](https://doi.org/10.1364/OE.26.004766) |
| 47 | 28 | ★ | C. Xue et al., "Inverse design and fabrication of high-efficiency perfectly vertical LNOI grating couplers," *Opt. Lett.*, vol. 50, pp. 549–552, 2025 | [10.1364/OL.549856](https://doi.org/10.1364/OL.549856) |
| 48 | 28 | ★ | J. Zou et al., "Ultra efficient silicon nitride grating coupler with bottom grating reflector," *Opt. Express*, vol. 23, pp. 26305–26312, 2015 | [10.1364/OE.23.026305](https://doi.org/10.1364/OE.23.026305) |
| 49 | 23 | ● | M. L. Dakss et al., "Grating coupler for efficient excitation of optical guided waves in thin films," *Appl. Phys. Lett.*, vol. 16, pp. 523–525, 1970 | [10.1063/1.1653091](https://doi.org/10.1063/1.1653091) |
| 50 | 24 | ● | A. Hardy, D. Welch, and W. Streifer, "Analysis of a dual grating coupler," *IEEE J. Quantum Electron.*, vol. 25, pp. 2091–2098, 1989 | [10.1109/3.35723](https://doi.org/10.1109/3.35723) |
| 51 | 24 | ● | V. A. Sychugov et al., "Radiation losses in corrugated waveguides," *Sov. J. Quantum Electron.*, vol. 10, pp. 186–190, 1980 | [10.1070/QE1980v010n02ABEH009937](https://doi.org/10.1070/QE1980v010n02ABEH009937) |
| 52 | 25 | ● | K. A. Bates et al., "Gaussian beams from variable groove depth grating couplers," *Appl. Opt.*, vol. 32, pp. 2112–2116, 1993 | [10.1364/AO.32.002112](https://doi.org/10.1364/AO.32.002112) |
| 53 | 26 | ● | Y. Ding et al., "Fully etched apodized grating coupler on the SOI platform with -0.58 dB coupling efficiency," *Opt. Lett.*, vol. 39, pp. 5348–5350, 2014 | [10.1364/OL.39.005348](https://doi.org/10.1364/OL.39.005348) |
| 54 | 23 | ○ | R. Marchetti et al., "Coupling strategies for silicon photonics integrated chips," *Photonics Res.*, vol. 7, pp. 201–239, 2019 | [10.1364/PRJ.7.000201](https://doi.org/10.1364/PRJ.7.000201) |
| 55 | 23 | ○ | L. Cheng et al., "Grating couplers on silicon photonics: design principles, emerging trends and practical issues," *Micromachines*, vol. 11, 666, 2020 | [10.3390/mi11070666](https://doi.org/10.3390/mi11070666) |
| 56 | 27 | ○ | N. V. Sapra et al., "Inverse design and demonstration of broadband grating couplers," *IEEE J. Sel. Top. Quantum Electron.*, vol. 25, 6100207, 2019 | [10.1109/JSTQE.2019.2899758](https://doi.org/10.1109/JSTQE.2019.2899758) |

### 阶段六及综合参考

| # | 天次 | 深度 | 文献 | DOI |
|:---:|:---:|:---:|---|---|
| 57 | 30 | ★ | F. Gardes et al., "A Review of Capabilities and Scope for Hybrid Integration Offered by Silicon-Nitride-Based Photonic Integrated Circuits," *Sensors*, vol. 22, 4227, 2022 | [10.3390/s22114227](https://doi.org/10.3390/s22114227) |
| 58 | 30 | ● | S. Kaushal et al., "Optical signal processing based on silicon photonics waveguide Bragg gratings: review," *Front. Optoelectron.*, vol. 11, pp. 163–188, 2018 | [10.1007/s12200-018-0819-x](https://doi.org/10.1007/s12200-018-0819-x) |
| 59 | 30 | ● | N. Singh, J. Lorenzen, M. Sinobad et al., "Integrated photonic frequency comb sources," *Nat. Photonics*, vol. 18, pp. 485–491, 2024 | search on Google Scholar |
| 60 | 30 | ○ | H. Sun et al., "Integrated Subwavelength Grating Waveguide Bragg Gratings for Microwave Photonics," *J. Lightwave Technol.*, vol. 40, pp. 6636–6649, 2022 | [10.1109/JLT.2022.3194562](https://doi.org/10.1109/JLT.2022.3194562) |

### 锁模激光器与 SiN 色散管理（补充专题）

| # | 天次 | 深度 | 文献 | DOI |
|:---:|:---:|:---:|---|---|
| 61 | 17,30 | ● | K. Shtyrkova, P. T. Callahan et al., "Integrated CMOS-compatible Q-switched mode-locked lasers at 1900nm with an on-chip artificial saturable absorber," *Opt. Express*, vol. 27, pp. 3542–3555, 2019 | [10.1364/OE.27.003542](https://doi.org/10.1364/OE.27.003542) |
| 62 | 17,30 | ● | S. Cuyvers et al., "Low Noise Heterogeneous III-V-on-Silicon-Nitride Mode-Locked Comb Laser," *Laser Photonics Rev.*, vol. 15, 2000485, 2021 | [10.1002/lpor.202000485](https://doi.org/10.1002/lpor.202000485) |
| 63 | 17,30 | ● | A. Hermans et al., "High-pulse-energy III-V-on-silicon-nitride mode-locked laser," *APL Photonics*, vol. 6, 096102, 2021 | [10.1063/5.0058024](https://doi.org/10.1063/5.0058024) |
| 64 | 17,30 | ○ | E. Vissers et al., "Hybrid integrated mode-locked laser diodes with a silicon nitride extended cavity," *Opt. Express*, vol. 29, pp. 15013–15022, 2021 | [10.1364/OE.422560](https://doi.org/10.1364/OE.422560) |

### 核心教材速查

| # | 教材 | 作者/版本 | 核心章节 | 适用天次 |
|:---:|---|---|---|:---:|
| T1 | *Fundamentals of Optical Waveguides* | K. Okamoto, 2nd ed., 2006 | §3.1–3.3, §4.1–4.10, §5.1–5.3 | 1–2, 6, 19, 25 |
| T2 | *Photonics: Optical Electronics in Modern Communications* | A. Yariv, P. Yeh, 6th ed., 2007 | §13.1–13.10 | 2–4, 6, 14, 20, 23 |
| T3 | *Diode Lasers and Photonic Integrated Circuits* | L. A. Coldren et al., 2nd ed., 2012 | §3.3–3.5, §6.4–6.14 | 4, 8, 11, 13, 18, 21 |
| T4 | *Fiber Bragg Gratings* | R. Kashyap, 2nd ed., 2010 | §3.1–3.4, §4.1–4.8, §5.1–5.10, §7.1–7.10, §8.1–8.7 | 3, 7, 10–17, 25 |
| T5 | *Optical Waveguide Theory* | A. W. Snyder, J. D. Love, 1983 | Part II §11–14, §31–33 | 1, 9, 19, 21 |
| T6 | *Theory of Dielectric Optical Waveguides* | D. Marcuse, 2nd ed., 1991 | §3.1–3.5, §4.1–4.4, §5.1–5.7 | 15, 24, 26, 29 |
| T7 | *Waves and Fields in Optoelectronics* | H. A. Haus, 1984 | §6.1–6.8 | 2, 18 |
| T8 | *Silicon Photonics Design* | L. Chrostowski, M. Hochberg, 2015 | §2.1–2.4, §3.1–3.3, §5.1–5.11, §10 | 7, 9–10, 26, 30 |
| T9 | *Foundations for Guided-Wave Optics* | C.-L. Chen, 2007 | §8.1–8.10, §9.1–9.4 | 4, 20, 23, 27 |
| T10 | *Fiber Bragg Gratings* | A. Othonos, K. Kalli, 1999 | 物理解释和应用补充 | 3, 12, 13 |
| T11 | *Integrated Optics: Theory and Technology* | R. G. Hunsperger, 6th ed., 2009 | 集成周期结构背景 | 6, 8 |
| T12 | *Photonic Crystals: Molding the Flow of Light* | J. D. Joannopoulos et al., 2nd ed., 2008 | §3.1–3.3, §4.4–4.7, §5.1–5.4 | 4, 8, 24, 27 |

---

> **提示**：在 GitHub 上查看 `.md` 文件时，LaTeX 公式默认不会渲染。建议以下任一方式获得公式渲染：
> 1. **VS Code** 安装扩展 "Markdown All in One" + "Markdown+Math"
> 2. **Typora** 或 **Obsidian** 直接打开 `.md` 文件
> 3. **浏览器扩展** "MathJax 3 for GitHub"（Chrome/Firefox）
> 4. **克隆到本地**后用任何支持 MathJax 的 Markdown 编辑器打开
