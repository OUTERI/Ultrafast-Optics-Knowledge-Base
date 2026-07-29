# 集成垂直光栅耦合器 — 深化理论计算

> 本文档深化 `theory_notes.md` §8 和 30 天日程第 23–28 天的垂直光栅耦合器理论。
> 分为两大部分：**Part A** 为辐射模严格电磁理论；**Part B** 为工程解析设计方法。
> 两部分形成从"第一性原理"到"手算设计表"的完整计算链路。

---

## Part A：辐射模严格电磁理论

### A.1 问题设定：从导模到辐射连续谱

未扰动波导（无光栅）支持一组离散的导模和连续的辐射模。导模的传播常数 $\beta_m$ 满足

$$
k_0 n_{\text{clad}} < |\beta_m| < k_0 n_{\text{core}}
$$

辐射模的传播常数连续分布在

$$
|\beta| < k_0 n_{\text{clad}}
$$

引入周期光栅后，导模通过 Floquet 空间谐波与辐射连续谱耦合，能量从波导向自由空间泄漏。

#### A.1.1 泄漏模本征值问题

严格的处理方式是将光栅单元视为沿 $z$ 方向的周期结构，求解泄漏模（leaky mode）的复传播常数：

$$
\tilde{\beta} = \beta - i\alpha
$$

其中实部 $\beta$ 决定相位匹配和辐射角，虚部 $\alpha$（功率衰减系数的一半，$dP/dz = -2\alpha P$）决定辐射率。

泄漏模满足准周期边界条件（Floquet 定理）：

$$
\mathbf{E}(x, y, z+\Lambda) = \mathbf{E}(x, y, z)\, e^{i\tilde{\beta}\Lambda}
$$

**关键点**：泄漏模的复传播常数 $\tilde{\beta}$ 是光栅几何的全波解，不能简单用未刻蚀直波导的 $n_{\text{eff}}$ 替代。这是 `theory_notes.md` §8 中强调"周期单元是泄漏 Bloch 模"的数学原因。

#### A.1.2 泄漏模的数值求解框架

对于二维结构（$y$ 方向无限延伸，侧壁调制在 $x$–$z$ 平面）：

1. **RCWA（严格耦合波分析）**：将场展开为空间谐波，在 Fourier 域求解 Maxwell 方程
2. **FEM 本征模求解**：在单个周期单元内用 Floquet 边界条件求解复本征值
3. **FDTD + Prony 法**：时域激发后通过 Prony 或矩阵束方法提取复传播常数

对于弱耦合光栅（大多数集成波导光栅属于此类），泄漏模的 $\alpha$ 很小（$\alpha \ll \beta$），可以用微扰方法从导模展开出发近似计算。

### A.2 辐射模展开法

#### A.2.1 辐射模的正交性和完备性

未扰动波导的辐射模构成连续谱的正交基：

$$
\int_{A_\infty} \left[ \mathbf{e}_{\nu}(\beta) \times \mathbf{h}_{\mu}^*(\beta') \right] \cdot \hat{z} \, dA
= P_\mu(\beta)\,\delta_{\mu\nu}\,\delta(\beta-\beta')
$$

其中 $\mu,\nu$ 标记辐射模的不同偏振分支，$\delta(\beta-\beta')$ 是 Dirac $\delta$ 函数。

与导模离散正交（Kronecker $\delta$）不同，辐射模的正交性是连续谱的正交（Dirac $\delta$），这导致耦合系数的处理和功率归一化出现根本差异。

#### A.2.2 总场展开

在微扰光栅存在下，总场可展开为导模 + 辐射连续谱：

$$
\mathbf{E}(x,y,z) = \sum_m A_m(z)\mathbf{e}_m(x,y)e^{i\beta_m z}
+ \sum_\nu \int A_\nu(z,\beta)\mathbf{e}_\nu(x,y;\beta)e^{i\beta z} d\beta
$$

辐射模的积分（而非求和）使得直接的数值处理非常困难，通常需要：
- **离散化**：将连续谱用泄漏模或 PML 离散模替代
- **Green 函数法**：避免显式展开，直接用 Green 函数处理辐射场

### A.3 Green 函数法推导辐射场

#### A.3.1 等效电流源

光栅区域的介电扰动 $\Delta\epsilon(x,y,z)$ 在导模的电场 $\mathbf{E}_g$ 存在下产生极化电流：

$$
\mathbf{J}_{\text{pol}}(x,y,z) = -i\omega\epsilon_0\Delta\epsilon(x,y,z)\,\mathbf{E}_g(x,y,z)
$$

对于周期为 $\Lambda$ 的光栅，将 $\Delta\epsilon$ 展开为 Fourier 级数：

$$
\Delta\epsilon(x,y,z) = \sum_{q=-\infty}^{\infty} \Delta\epsilon_q(x,y) e^{iqKz}, \quad K = \frac{2\pi}{\Lambda}
$$

#### A.3.2 辐射场的 Green 函数表示

分层介质（波导芯/包层/衬底/埋氧层）的并矢 Green 函数 $\overleftrightarrow{G}(\mathbf{r},\mathbf{r}')$ 给出位于 $\mathbf{r}'$ 的单位偶极子在 $\mathbf{r}$ 处产生的电场：

$$
\mathbf{E}_{\text{rad}}(\mathbf{r}) = i\omega\mu_0 \int_{V_{\text{grating}}} \overleftrightarrow{G}(\mathbf{r},\mathbf{r}') \cdot \mathbf{J}_{\text{pol}}(\mathbf{r}')\, d^3r'
$$

在远场（$r \to \infty$），Green 函数通过稳相法（stationary phase method）退化为球面波（三维）或柱面波（二维）。

#### A.3.3 功率辐射的角谱分布

将远场辐射功率分解为立体角 $(\theta,\phi)$ 的函数：

$$
\frac{dP_{\text{rad}}}{d\Omega} = \frac{\omega^2\mu_0^2}{8\pi^2 c}
\left| \hat{\mathbf{p}} \cdot \int_{V_{\text{grating}}} \mathbf{J}_{\text{pol}}(\mathbf{r}')\, e^{-i\mathbf{k}_{\text{rad}}\cdot\mathbf{r}'}\, d^3r' \right|^2
$$

其中 $\mathbf{k}_{\text{rad}}$ 是辐射方向的波矢，$\hat{\mathbf{p}}$ 是远场偏振方向。

对于一维周期光栅（光沿 $z$ 方向传播、光栅周期在 $z$ 方向），辐射角 $\theta$（相对于表面法线）由 Floquet 条件决定：

$$
k_0 n_c \sin\theta = \beta - qK
$$

**这正是 `theory_notes.md` §8 中的相位匹配条件**，但现在有了严格的电磁学基础：
- $q$ = 衍射级次（$q = \pm1, \pm2, \ldots$）
- 每个衍射级次对应一个辐射方向 $\theta_q$
- 只有 $|k_0 n_c \sin\theta_q| < k_0 n_c$（即 $|\beta - qK| < k_0 n_c$）的级次才能传播（辐射），否则是倏逝波

#### A.3.4 辐射率 $\alpha$ 的第一性原理计算

局域功率泄漏率 $\alpha(z)$ 可以从辐射场的 Green 函数积分获得。对于弱耦合光栅：

$$
\alpha(z) = \frac{1}{2P_g} \frac{dP_{\text{rad}}}{dz}
$$

其中 $P_g$ 是导模功率。代入 Green 函数表示：

$$
\alpha(z) = \frac{\omega^2\mu_0}{4\pi c P_g} \sum_{q\in\text{radiating}} \int_{-\pi/2}^{\pi/2}
\left| \iint_{A} \Delta\epsilon_q(x,y)\,\mathbf{e}_g(x,y)\cdot\mathbf{e}_{\text{rad},q}(x,y;\theta)\,dA \right|^2
\frac{n_c\cos^2\theta}{\cos\theta_g}\, d\theta
$$

其中：
- $\mathbf{e}_{\text{rad},q}$ 是第 $q$ 阶辐射模的横向场分布（由分层介质的 Green 函数或传输矩阵给出）
- 积分覆盖所有辐射级次和所有辐射角
- 分母的 $\cos\theta_g$ 来自导模的群速度因子

**这是连接几何设计参数（$\Delta\epsilon_q$、占空比、刻蚀深度）与可计算量 $\alpha$ 的核心公式。** 对每一组几何参数，可以通过数值积分给出 $\alpha$ 值，从而建立几何→$\alpha$ 的标定数据库。

### A.4 分层介质的辐射场

集成垂直光栅耦合器通常涉及多层介质结构：波导芯、上包层、下包层（BOX）、衬底。每一层都对向上和向下的辐射产生透射、反射和干涉。

#### A.4.1 传输矩阵法计算方向性

将多层结构沿 $y$（垂直于芯片表面的方向）离散，每层用 $2\times 2$ 传输矩阵表示：

$$
\begin{bmatrix} E_y^+ \\ E_y^- \end{bmatrix}_{y=y_{i+1}} =
\begin{bmatrix}
e^{-ik_{y,i}d_i} & 0 \\
0 & e^{+ik_{y,i}d_i}
\end{bmatrix}
\begin{bmatrix} E_y^+ \\ E_y^- \end{bmatrix}_{y=y_i}
$$

对于 TE 偏振，界面处的 Fresnel 系数为：

$$
r_{i,i+1}^{\text{TE}} = \frac{k_{y,i} - k_{y,i+1}}{k_{y,i} + k_{y,i+1}}, \quad
t_{i,i+1}^{\text{TE}} = \frac{2k_{y,i}}{k_{y,i} + k_{y,i+1}}
$$

多层结构的总反射和透射给出**向上功率分数** $D_{\text{up}}$ 和**向下功率分数** $D_{\text{down}}$：

$$
D_{\text{up}} = \frac{P_{\text{up}}}{P_{\text{up}} + P_{\text{down}}}, \quad
D_{\text{up}} + D_{\text{down}} = 1
$$

#### A.4.2 BOX 厚度干涉

埋氧层（BOX）厚度 $h_{\text{BOX}}$ 是方向性设计的核心参数。从光栅辐射到衬底的向下波在 BOX/衬底界面部分反射，与直接向上辐射的波发生干涉：

$$
D_{\text{up}}(\lambda, h_{\text{BOX}}) =
\frac{1 + |r_{\text{BOX}}|^2 + 2|r_{\text{BOX}}|\cos(2k_{y,\text{BOX}}h_{\text{BOX}} + \phi_r)}
{1 + |r_{\text{BOX}}|^2}
\times D_{\text{up}}^{(0)}
$$

其中 $D_{\text{up}}^{(0)}$ 是无 BOX 反射时的方向性，$r_{\text{BOX}}$ 是 BOX/衬底界面的复反射系数。方向性随 $h_{\text{BOX}}$ 呈周期性振荡，周期为 $\lambda/(2n_{\text{BOX}}\cos\theta_{\text{BOX}})$。

---

## Part B：工程解析设计方法

### B.1 从目标场到辐射包络的逆问题

#### B.1.1 问题陈述

**给定**：目标光纤模式的复场分布 $\mathbf{E}_{\text{fiber}}(x,y,z)$（在光栅出射面上方某参考面）。

**求**：光栅的局域辐射率 $\alpha(z)$、耦合系数分布 $\kappa(z)$、以及最终的几何参数（周期、占空比、刻蚀深度）。

**约束**：
1. 功率守恒：$\int_0^L 2\alpha(z)P(z)dz = \eta_e P(0)$（抽取效率 $\eta_e$）
2. 相位匹配：$\Lambda(z) = \lambda / [n_{\text{eff}}(z) - n_c\sin\theta]$
3. 辐射场的高斯重叠最大化

#### B.1.2 $\alpha(z)$ 反演公式

设：
- $P(z)$ 为剩余导波功率（沿 $z$ 方向）
- $p_t(z)$ 为归一化目标辐射功率密度（$\int_0^L p_t(z)dz = 1$）
- $\eta_e$ 为目标抽取效率

功率衰减方程为：

$$
\frac{dP}{dz} = -2\alpha(z)P(z)
$$

期望的辐射功率密度为：

$$
-\frac{dP_{\text{rad}}}{dz} = \eta_e P(0) p_t(z)
$$

同时 $dP_{\text{rad}}/dz = dP/dz$（从导模泄漏的功率全部转化为辐射），因此：

$$
\eta_e P(0) p_t(z) = - \frac{dP}{dz} = 2\alpha(z)P(z)
$$

由 $P(z) = P(0) - \eta_e P(0) \int_0^z p_t(s)ds = P(0)[1 - \eta_e\int_0^z p_t(s)ds]$，得到 **$\alpha(z)$ 反演公式**：

$$
\boxed{\alpha(z) = \frac{\eta_e\, p_t(z)}{2\left[1 - \eta_e\int_0^z p_t(s)ds\right]}}
$$

这就是 `theory_notes.md` §8.1 中公式的完整推导。

**数值实现注意事项**：
- $z$ 网格必须足够密：$\Delta z < \min(\Lambda/10, 1/\alpha_{\max})$
- 积分用梯形法或 Simpson 法
- 检查分母 $1 - \eta_e\int_0^z p_t(s)ds > 0$ 对所有 $z$ 成立，否则目标抽取率不可行
- 当 $\eta_e \to 1$ 时，$\alpha(z)$ 在 $z \to L$ 发散——实际器件必须在末端截断

### B.2 高斯模式匹配：重叠效率

#### B.2.1 目标光纤模场的复振幅

单模光纤（如 SMF-28）的基模可用高斯函数高度精确地近似：

$$
E_{\text{fiber}}(x,y,z) = E_0 \exp\left[-\frac{(x-x_0)^2}{w_x^2} - \frac{(z-z_0)^2}{w_z^2}\right]
$$

对于垂直耦合，光纤通常倾斜角 $\theta$ 放置。在光栅出射面坐标系中，将倾斜光纤的高斯场投影到出射平面上：

$$
E_{\text{fiber}}(x,z;\theta) = E_0 \exp\left[-\frac{x^2}{w_x^2} - \frac{(z\cos\theta)^2}{w_z^2}\right] e^{i k_0 n_c z\sin\theta}
$$

其中最后的相位因子 $e^{i k_0 n_c z\sin\theta}$ 来自光纤的倾斜入射/出射角度——这与光栅的辐射方向必须相位匹配。

#### B.2.2 辐射场的复振幅

辐射场沿 $z$ 的复振幅为（见 §A.3）：

$$
E_{\text{rad}}(z) = \sqrt{2\alpha(z)P(z)}\, e^{i\phi_{\text{rad}}(z)}
$$

其中相位 $\phi_{\text{rad}}(z)$ 由光栅单元的辐射相位和传播相位共同决定。对于一阶衍射：

$$
\phi_{\text{rad}}(z) = \int_0^z [\beta(s) - K(s)]\, ds + \phi_{\text{grating}}(z)
$$

$\phi_{\text{grating}}(z)$ 来自光栅单元本身的辐射相位（与占空比、刻蚀深度等有关，需通过 RCWA/FDTD 标定）。

#### B.2.3 重叠效率

辐射场与光纤目标场在出射参考面上的复振幅重叠效率为：

$$
\eta_{\text{overlap}} = \frac{\left|\int_0^L E_{\text{rad}}(z)\,E_{\text{fiber}}^*(z)\,dz\right|^2}
{\int_0^L |E_{\text{rad}}(z)|^2\,dz \cdot \int_0^L |E_{\text{fiber}}(z)|^2\,dz}
$$

**关键区别**：这是**复振幅**的重叠，而非仅功率密度的重叠。幅度匹配保证功率分布一致；相位匹配保证辐射波前与倾斜光纤的相位面相干叠加。幅度匹配而相位不匹配，重叠效率仍然很低。

#### B.2.4 目标场的来源选择

对于不同的目标光纤模式：

| 目标 | $p_t(z)$ 形式 | 参数 |
|---|---|---|
| SMF-28 单模光纤（倾斜 $\theta$） | $p_t(z) \propto \exp[-2(z\cos\theta/w_z)^2]$ | $w_z \approx 5.2$ μm @ 1550 nm |
| 高斯光束（自由空间） | $p_t(z) \propto \exp[-2(z/w_0)^2]$ | $w_0$ 为束腰半径 |
| 平顶（均匀辐射） | $p_t(z) = 1/L$ | 牺牲重叠效率以换取制造容差 |

### B.3 效率预算分解

将垂直光栅耦合器的总效率拆解为可独立优化和诊断的子效率：

$$
\boxed{\eta_{\text{total}} = \eta_{\text{extract}} \times D_{\text{up}} \times \eta_{\text{overlap}} \times \eta_{\text{transition}}}
$$

#### B.3.1 各因子的物理含义和计算来源

| 因子 | 物理含义 | 计算来源 |
|---|---|---|
| $\eta_{\text{extract}}$ | 从导模抽取到辐射通道的功率比例 | $\alpha(z)$ 反演（式 B.1.2）→ 积分 $2\alpha(z)P(z)$ |
| $D_{\text{up}}$ | 辐射功率中向上（朝光纤）的比例 | 分层介质传输矩阵（§A.4.1）→ $P_{\text{up}}/(P_{\text{up}}+P_{\text{down}})$ |
| $\eta_{\text{overlap}}$ | 辐射场与目标光纤模式的复振幅重叠 | 式 B.2.3（需 $\alpha(z)$ 和辐射相位） |
| $\eta_{\text{transition}}$ | 光栅前端过渡损耗 | 模式展开或 FDTD 仿真（过渡区的散射和反射） |

#### B.3.2 典型参数范围和瓶颈诊断

| $\eta_{\text{total}}$ | 瓶颈 | 诊断 |
|---|---|---|
| <10% | 多因素 | 逐一检查各因子 |
| <30% 且 $D_{\text{up}} < 40\%$ | 方向性 | 优化 BOX 厚度或添加底反射镜 |
| <30% 且 $\eta_{\text{overlap}} < 50\%$ | 模式失配 | 检查 $\alpha(z)$ 分布和高斯重叠 |
| <50% 且 $\eta_{\text{extract}} < 70\%$ | 抽取不足 | 增大 $\alpha_{\max}$（增大占空比或刻蚀深度） |
| >70% | 接近最优 | 微调 $\alpha(z)$ 和 BOX 厚度 |

### B.4 容差分析

#### B.4.1 灵敏度因果图

```
周期误差 ΔΛ ──→ 中心波长偏移 (dλ_B/dΛ = 2n_eff)
                ├── 重叠效率变化 (光纤位置—辐射角耦合)
                └── 方向性变化 (辐射角—BOX干涉条件改变)

刻蚀深度误差 Δh ──→ α 变化 (h↑→α↑)
                   ├── 抽取效率和α(z)剖面畸变
                   └── 过渡损耗变化

占空比误差 ΔDC ──→ κ_1 和 α 同时变化
                  └── 高阶辐射谐波增强

BOX厚度误差 Δh_BOX ──→ 方向性振荡
                      └── 中心波长微移 (等效n_eff变化)

光纤对准误差 (Δx,Δy,Δθ) ──→ 重叠效率下降
```

#### B.4.2 最敏感参数排序

对于典型的 SOI/SiN 垂直光栅耦合器（1550 nm 波段）：

1. **周期**：1 nm 周期误差 → ~2 nm 中心波长偏移（最敏感）
2. **光纤角度**：1° 角度误差 → ~10–20 nm 中心波长偏移 + 重叠效率下降
3. **刻蚀深度**：10 nm 误差 → $\alpha$ 变化 ~10–20%
4. **BOX 厚度**：~50 nm 周期（方向性振荡周期）
5. **占空比**：5% 误差 → $\kappa_1$ 变化 ~5–10%

### B.5 完全垂直耦合的特殊挑战

#### B.5.1 二阶后向反射

当 $\theta = 0$（完全垂直耦合，光纤垂直于芯片表面）时：

- **一阶辐射条件**：$k_0 n_c \sin 0 = \beta - 1\cdot K \Rightarrow K = \beta$（光栅周期 $= \lambda/n_{\text{eff}}$）
- **二阶布拉格条件**：$2\beta = 2K$（因为 $K = \beta$，自动满足！）

这意味着完全垂直耦合的一阶辐射周期恰好也是二阶后向布拉格反射的周期——入射光的一部分被反射回波导，形成不需要的反向传播模式。

#### B.5.2 抑制策略

| 方法 | 原理 | 典型效率 | 参考文献 |
|---|---|---|---|
| 非对称光栅单元 | 破坏光栅单元的前后对称性，使二阶 Fourier 系数接近零 | ~80% | Michaels–Yablonovitch 2018 |
| 闪耀光栅（双层） | 通过两层结构的相消干涉抑制反射 | ~85% | 多层 SOI/SiN 报道 |
| 亚波长工程 | 利用等效介质调控各阶 Fourier 系数 | ~90% (sub-decibel) | Benedikovic 2015 |
| 底反射镜 | 金属或 Bragg 反射镜回收向下辐射 | ~95% | Zou 2015 |
| 逆向设计 | 拓扑优化自动搜索反射最小的几何 | ~90%+ | Michaels–Yablonovitch 2018; Xue 2025 |

---

## 从理论到设计的计算链路

将 Part A（严格理论）和 Part B（工程设计）串联为可执行的计算流程：

```text
┌─────────────────────────────────────────────────────────────────┐
│ 步骤 1: 模式求解                                                  │
│ COMSOL/Lumerical MODE → n_eff(λ,W), n_g(λ,W), 模场分布 e(x,y)     │
│ 输出: n_eff 数据库、模式色散曲线                                   │
├─────────────────────────────────────────────────────────────────┤
│ 步骤 2: 泄漏模本征值 (可选，用于高精度设计)                          │
│ COMSOL/RSoft → 复 β̃(Λ,DC,h) 对一组几何参数扫描                      │
│ 输出: α(Λ,DC,h) 查找表、辐射相位 φ_rad(Λ,DC,h)                     │
├─────────────────────────────────────────────────────────────────┤
│ 步骤 3: 相位匹配                                                 │
│ 选定 λ_target, θ → Λ_center = λ/(n_eff - n_c*sinθ)              │
│ 输出: 中心周期估算值                                              │
├─────────────────────────────────────────────────────────────────┤
│ 步骤 4: 目标场设定                                                │
│ 光纤模场 → p_t(z) (归一化功率密度)                                 │
│ 输出: p_t(z) 函数                                                │
├─────────────────────────────────────────────────────────────────┤
│ 步骤 5: α(z) 反演                                                │
│ α(z) = η_e*p_t(z) / [2*(1 - η_e*∫p_t)]                          │
│ 检查: α(z) 可行域、光栅长度 L                                      │
│ 输出: α(z) 剖面、P(z) 剖面                                        │
├─────────────────────────────────────────────────────────────────┤
│ 步骤 6: α → 几何映射                                              │
│ 利用步骤 2 的 α(Λ,DC,h) 查找表，沿 z 查表                          │
│ 输出: Λ(z), DC(z), h(z) 剖面                                     │
├─────────────────────────────────────────────────────────────────┤
│ 步骤 7: 分层辐射场                                                │
│ 传输矩阵法 → D_up(λ, θ, h_BOX)                                   │
│ 输出: 方向性、BOX 厚度最优值                                       │
├─────────────────────────────────────────────────────────────────┤
│ 步骤 8: 重叠效率                                                  │
│ η_overlap = |∫E_rad(z)·E*_fiber(z)dz|² / (∫|E_rad|²·∫|E_fiber|²) │
│ 输出: 重叠效率                                                    │
├─────────────────────────────────────────────────────────────────┤
│ 步骤 9: 效率预算                                                  │
│ η_total = η_extract × D_up × η_overlap × η_transition            │
│ 输出: 总效率估算值、效率瓶颈诊断                                    │
├─────────────────────────────────────────────────────────────────┤
│ 步骤 10: 容差分析                                                 │
│ 扫描 ΔΛ, Δh, ΔDC, Δh_BOX, Δθ, Δx, Δy → 效率退化曲线               │
│ 输出: 3σ 容差窗口、最敏感参数排序                                   │
├─────────────────────────────────────────────────────────────────┤
│ 步骤 11: 全波验证                                                  │
│ FDTD (Lumerical/Meep) 或 RCWA → 验证解析设计的实际性能               │
│ 输出: 最终 S 参数、辐射场分布、效率                                  │
└─────────────────────────────────────────────────────────────────┘
```

步骤 1–9 可在分钟内完成（MATLAB/Python），步骤 10 需要数分钟（参数扫描），步骤 11 需要数小时（单次 3D FDTD）或数分钟（2D FDTD/RCWA）。

---

## 参考文献（垂直光栅耦合器专用）

### 严格理论基础

1. **T. Tamir and S. T. Peng**, "Analysis and design of grating couplers," *Appl. Phys.*, vol. 14, pp. 235–254, 1977. — 经典理论，从 Floquet-Bloch 展开推导辐射条件
2. **D. Marcuse**, *Theory of Dielectric Optical Waveguides*, 2nd ed., Academic Press, 1991. — §3: 辐射模的严格展开；§4: 多层介质辐射场
3. **R. F. Harrington**, *Time-Harmonic Electromagnetic Fields*, McGraw-Hill, 1961. — §3–4: 并矢 Green 函数和等效原理的基础
4. **W. C. Chew**, *Waves and Fields in Inhomogeneous Media*, IEEE Press, 1995. — §2–4: 分层介质 Green 函数

### 辐射分析

5. **V. A. Sychugov et al.**, "Radiation losses in corrugated waveguides," *Sov. J. Quantum Electron.*, vol. 10, pp. 186–190, 1980. — 泄漏模微扰计算
6. **K. A. Bates et al.**, "Gaussian beams from variable groove depth grating couplers," *Appl. Opt.*, vol. 32, pp. 2112–2116, 1993. — 变深度光栅的辐射场控制

### 解析设计方法

7. **D. Taillaert et al.**, "Grating Couplers for Coupling between Optical Fibers and Nanophotonic Waveguides," *Jpn. J. Appl. Phys.*, vol. 45, pp. 6071–6077, 2006. — SOI 光栅耦合器的完整分析框架
8. **F. Van Laere et al.**, "Compact and Highly Efficient Grating Couplers Between Optical Fiber and Nanophotonic Waveguides," *J. Lightwave Technol.*, vol. 25, pp. 151–156, 2007. — 效率预算和实验验证
9. **Z. Zhao and S. Fan**, "Design Principles of Apodized Grating Couplers," *J. Lightwave Technol.*, vol. 38, pp. 4435–4444, 2020. — $\alpha(z)$ 反演的系统理论和设计图表
10. **R. Marchetti et al.**, "Coupling strategies for silicon photonics integrated chips," *Photonics Res.*, vol. 7, pp. 201–239, 2019. — 光栅耦合器综述（含亚波长和逆向设计进展）

### 先进设计

11. **D. Benedikovic et al.**, "Subwavelength index engineered surface grating coupler with sub-decibel efficiency for 220-nm silicon-on-insulator waveguides," *Opt. Express*, vol. 23, pp. 22628–22635, 2015. — 亚波长工程实现 sub-decibel 效率
12. **A. Michaels and E. Yablonovitch**, "Inverse design of near unity efficiency perfectly vertical grating couplers," *Opt. Express*, vol. 26, pp. 4766–4779, 2018. — 逆向设计实现近单位效率垂直耦合
13. **C. Xue et al.**, "Inverse design and fabrication of high-efficiency perfectly vertical LNOI grating couplers," *Opt. Lett.*, vol. 50, pp. 549–552, 2025. — LNOI 平台的垂直光栅逆向设计
14. **J. Zou et al.**, "Ultra efficient silicon nitride grating coupler with bottom grating reflector," *Opt. Express*, vol. 23, pp. 26305–26312, 2015. — SiN 底反射镜光栅耦合器
15. **Y. Ding et al.**, "Fully etched apodized grating coupler on the SOI platform with −0.58 dB coupling efficiency," *Opt. Lett.*, vol. 39, pp. 5348–5350, 2014. — 全刻蚀切趾光栅耦合器

---

## 与30天日程的集成

| 本文档章节 | 对应天次 | 如何使用 |
|---|---|---|
| A.1–A.2（泄漏模、辐射模展开）| 第 23 天 | 阅读后理解"为什么严格周期是泄漏 Bloch 模，不是 $n_{\text{eff}}$ 波导" |
| A.3（Green 函数法）| 第 24 天 | 理解辐射功率角谱分布的来源，不要求手算 Green 函数 |
| A.4（分层介质方向性）| 第 24, 26 天 | 第 24 天学基本概念，第 26 天用传输矩阵法计算方向性 vs BOX 厚度 |
| B.1（$\alpha(z)$ 反演）| 第 25 天 | 核心计算：给定目标场 → 输出 $\alpha(z)$ |
| B.2（高斯模式匹配）| 第 25 天 | 理解为什么需要**复振幅**重叠（而非仅功率重叠） |
| B.3（效率预算）| 第 24, 28 天 | 第 24 天学框架，第 28 天填写完整预算表 |
| B.4（容差分析）| 第 26 天 | 构建灵敏度因果图，排序最敏感参数 |
| B.5（完全垂直耦合）| 第 27 天 | 理解二阶反射问题 + 五种抑制策略的比较 |
| 完整计算链路 | 第 28 天 | 按步骤 1–11 完成 SiN/LNOI 的解析初始设计表 |
