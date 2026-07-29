# 集成波导光栅理论提纲

这份讲义不是基础电磁学教材，而是连接“波导模式”与“可计算光栅模型”的推导骨架。详细证明应结合指定教材和论文自行补全。

## 1. 从波导模式到耦合模方程

设未扰动波导的模式为

$$
\mathbf E_m^{\pm}(x,y,z)=\mathbf e_m^{\pm}(x,y)e^{\pm i\beta_m z},
$$

介电常数扰动为

$$
\Delta\epsilon(x,y,z)=
\sum_q \Delta\epsilon_q(x,y)e^{iqKz}.
$$

将总场展开为慢变包络的模式叠加，并代入 Lorentz 互易关系。快速振荡项在长距离积分后相互抵消，只有满足近似相位匹配的项保留。对前向模式 $m$ 和后向模式 $n$，相位失配为

$$
\Delta\beta_{mn}=\beta_m+\beta_n-qK.
$$

当模式按功率 $P_m,P_n$ 归一化时，常见的矢量耦合积分形式为

$$
\kappa_{mn}=
\frac{\omega}{4\sqrt{P_mP_n}}
\iint \Delta\epsilon_q
\mathbf e_m^*\cdot\mathbf e_n\,dA.
$$

不同文献可能将 $1/2$、复共轭或负号吸收到模式和 $\kappa$ 的定义中。比较数值前，应以中心反射率和功率守恒校准约定。

## 2. 均匀布拉格光栅

对单模自耦合，令

$$
\delta=\beta-K/2.
$$

无损常系数矩阵的特征量为

$$
\gamma=\sqrt{|\kappa|^2-\delta^2}.
$$

- $|\delta|<|\kappa|$：$\gamma$ 为实数，场沿光栅呈双曲函数变化，对应禁带。
- $|\delta|>|\kappa|$：$\gamma$ 为虚数，场呈振荡，对应通带。

在中心频率：

$$
r=i\frac{\kappa^*}{|\kappa|}\tanh(|\kappa|L),
\qquad
t=\operatorname{sech}(|\kappa|L).
$$

因此 $R+T=1$。若 $\kappa$ 很小，即使严格满足布拉格条件，也不会得到高反射；布拉格条件只决定相位匹配，不决定耦合强度。

### 2.1 近似阻带宽度

在中心附近取

$$
\delta\approx\frac{n_g}{c}(\omega-\omega_B).
$$

无限长均匀光栅的禁带边缘满足 $|\delta|=|\kappa|$，故全频率宽度近似为

$$
\Delta f_{\rm stop}\approx\frac{c|\kappa|}{\pi n_g},
$$

对应波长宽度

$$
\Delta\lambda_{\rm stop}\approx
\frac{\lambda_B^2|\kappa|}{\pi n_g}.
$$

有限长度器件的 3 dB 带宽与此不完全相同，必须从实际谱线提取。

## 3. 传递矩阵和 Bloch 波

若一段长度 $\Delta z$ 内参数为常数：

$$
\Psi(z+\Delta z)=
\exp(\mathbf H\Delta z)\Psi(z),
\qquad
\Psi=[A,B]^T.
$$

非均匀光栅的总矩阵按传播顺序左乘：

$$
\mathbf M_{\rm total}=
\mathbf M_N\mathbf M_{N-1}\cdots\mathbf M_1.
$$

周期结构的单周期矩阵满足

$$
\cos(k_B\Lambda)=\frac{1}{2}\operatorname{Tr}(\mathbf M_{\Lambda}).
$$

当右侧绝对值大于 1 时，Bloch 波数出现虚部，形成禁带。CMT 是围绕指定布拉格阶次的窄带近似；Bloch/Floquet 分析保留更多周期结构信息。

## 4. 集成结构中的耦合强度

光栅设计分成两个相对独立的问题：

1. **相位匹配**：由 $n_{\rm eff}$ 和 $\Lambda$ 决定中心波长。
2. **场重叠**：由扰动位置、深度、占空比和模式场决定 $\kappa$。

矩形占空比为 $D$ 的周期扰动，其第 $q$ 阶傅里叶幅度与

$$
\frac{\sin(\pi qD)}{\pi q}
$$

成正比。占空比既影响主耦合，也影响高阶谐波和寄生阻带。

SiN 通常可实现低传播损耗和长光栅，但宽/厚波导容易支持高阶模式。LNOI 必须使用各向异性介电张量求模；晶轴、传播方向和偏振会改变 $n_{\rm eff}$ 与耦合积分。

## 5. 切趾光栅

有限均匀光栅等价于无限光栅乘以矩形窗口，因此其空间频谱带有 sinc 旁瓣。令

$$
\kappa(z)=\kappa_0 a(z)
$$

并使 $a(z)$ 在端点平滑趋近于零，可以压低旁瓣。代价通常是有效耦合长度下降、主瓣变宽或获得同一反射率所需器件变长。

比较切趾函数时必须固定一个公平条件，例如：

- 相同物理长度和峰值 $\kappa$；或
- 相同积分耦合量 $\int|\kappa(z)|dz$；或
- 相同中心反射率。

三种条件会得到不同结论，报告中必须说明采用哪一种。

## 6. 啁啾光栅

啁啾可写入周期、有效折射率或光栅相位：

$$
K=K(z),\qquad
\delta(z,\omega)=\beta(\omega)-K(z)/2.
$$

给定频率的局域布拉格位置满足 $\delta(z_B,\omega)=0$。不同频率在不同位置反射，从而产生宽反射带和频率相关群时延。

### 6.1 WKB 图像

局域特征量

$$
\gamma(z)=\sqrt{|\kappa(z)|^2-\delta(z)^2}
$$

将空间分成传播区和禁带区。$|\delta|=|\kappa|$ 是转折点。只有当参数在一个局域耦合长度内变化足够慢时，WKB/绝热图像才可靠。

### 6.2 谱纹和鬼阻带

- 光栅两端未平滑切趾：产生普通有限长度旁瓣。
- 同一频率存在多个有效反射位置：产生相干谱纹。
- 分段啁啾或周期量化：空间频谱出现额外峰，形成鬼阻带。
- 支持多个模式：每对模式都有独立相位匹配分支，形成真正的第二阻带。

## 7. 多模和偏振耦合

定义前向和后向模式向量 $\mathbf A,\mathbf B$：

$$
\frac{d}{dz}
\begin{bmatrix}\mathbf A\\\mathbf B\end{bmatrix}
=
\begin{bmatrix}
i\mathbf D-\mathbf L/2 & i\mathbf K_c\\
-i\mathbf K_c^\dagger & -i\mathbf D+\mathbf L/2
\end{bmatrix}
\begin{bmatrix}\mathbf A\\\mathbf B\end{bmatrix}.
$$

其中 $D_{mm}=\beta_m-K/2$。耦合矩阵元素由矢量重叠积分决定。

### 7.1 选择定则

若扰动关于横向中心面对称，而两个模式的相关场积为奇函数，则横截面积分为零。单侧侧壁光栅、倾斜光栅或上下不对称包层会破坏选择定则，使原本禁戒的耦合出现。

### 7.2 第二阻带判别

1. 分别计算所有 $2\beta_m=K$ 和 $\beta_m+\beta_n=K$ 分支。
2. 在低谷中心进行反射端模式分解。
3. 将可疑 $\kappa_{mn}$ 置零；若低谷消失，即为该模式通道。
4. 若 $R+T<1$，继续区分材料吸收、辐射/PML 功率和未统计模式。
5. 改变光栅长度：旁瓣间距随长度改变，而真正的模式相位匹配中心主要随有效折射率和周期移动。

## 8. 垂直光栅耦合器

对衍射阶次 $m$：

$$
\beta-k_0n_c\sin\theta=mK.
$$

在选定符号和一阶衍射后：

$$
\Lambda=\frac{\lambda}{n_{\rm eff}-n_c\sin\theta}.
$$

这只是中心周期的第一估计。周期单元是泄漏 Bloch 模，严格设计应使用其复传播常数，而不是未刻蚀直波导的 $n_{\rm eff}$。

### 8.1 辐射包络

若剩余导波功率为 $P(z)$，局域功率泄漏率为 $\alpha(z)$：

$$
\frac{dP}{dz}=-2\alpha(z)P(z).
$$

给定归一化目标辐射功率密度 $p_t(z)$，希望总共抽取比例 $\eta_e$：

$$
\alpha(z)=
\frac{\eta_e p_t(z)}
{2\left[1-\eta_e\int_0^z p_t(s)ds\right]}.
$$

实际几何设计需要建立占空比、刻蚀深度或亚波长等效折射率到 $\alpha$ 的标定表。

### 8.2 效率预算

将总效率拆为

$$
\eta_{\rm total}=
\eta_{\rm extract}\,
D_{\rm up}\,
\eta_{\rm overlap}\,
\eta_{\rm transition}.
$$

这种分解能指出低效率来自抽取不足、向下辐射、模式失配还是光栅前端过渡损耗。

### 8.3 完全垂直耦合

当 $\theta=0$ 时，一阶辐射条件常与二阶后向布拉格条件相关，因此容易产生反射。常用抑制办法包括非对称单元、双层/闪耀结构、亚波长工程、底反射镜和逆向设计。

## 9. 何时转向全波方法

必须使用 RCWA/FDTD/FEM/EME 的情况：

- 单周期不再是弱扰动；
- 多个空间谐波同时接近相位匹配；
- 辐射连续谱、强纵向场或强偏振转换不可忽略；
- 垂直光栅的上下干涉和三维聚焦决定效率；
- 需要定量评估侧壁角、圆角、粗糙度及有限包层。

CMT/TMM 的任务是提供物理解释、数量级和可靠初值，而不是用更快的模型替代适用范围之外的 Maxwell 求解。

