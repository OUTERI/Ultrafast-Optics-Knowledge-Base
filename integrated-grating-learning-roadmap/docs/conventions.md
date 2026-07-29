# 数学与物理约定

## 1. 时间因子和传播方向

- 采用时间因子 $e^{-i\omega t}$。
- 前向模式写为 $A(z)\mathbf e_+(x,y)e^{+i\beta z}$。
- 后向模式写为 $B(z)\mathbf e_-(x,y)e^{-i\beta z}$。
- 光栅主空间谐波为 $K=2\pi/\Lambda$。

均匀自耦合布拉格条件为

$$
2\beta(\omega_B)=K.
$$

前向模式 $m$ 与后向模式 $n$ 的模间布拉格条件为

$$
\beta_m(\omega)+\beta_n(\omega)=K.
$$

## 2. 二模耦合方程

学习包采用

$$
\frac{d}{dz}
\begin{bmatrix}A\\B\end{bmatrix}
=
\begin{bmatrix}
i\delta-\alpha/2 & i\kappa\\
-i\kappa^* & -i\delta+\alpha/2
\end{bmatrix}
\begin{bmatrix}A\\B\end{bmatrix}.
$$

其中：

- $\delta=\beta-K/2$；
- $\kappa$ 是复数振幅耦合系数；
- $\alpha$ 是沿实际传播方向定义的功率衰减系数；
- 无损且中心失谐为零时 $R=\tanh^2(|\kappa|L)$。

后向方程中的损耗符号与前向不同，是因为状态统一沿正 $z$ 方向积分，而后向波的能量沿负 $z$ 方向传播。

## 3. 端口和 S 参数

设左端入射 $A(0)=1$，右端没有反向入射 $B(L)=0$：

$$
S_{11}=B(0),\qquad S_{21}=A(L).
$$

模式按单位功率归一化时：

$$
R=|S_{11}|^2,\qquad T=|S_{21}|^2.
$$

无损模型应满足 $R+T=1$。

## 4. 反射相位和群时延

反射相位采用连续展开：

$$
\phi_r=\operatorname{unwrap}(\arg S_{11}).
$$

按本学习包约定：

$$
\tau_g=-\frac{\partial\phi_r}{\partial\omega},\qquad
\mathrm{GDD}=\frac{\partial\tau_g}{\partial\omega}.
$$

比较其他软件或论文时必须先检查其时间因子和群时延符号。

## 5. 单位

| 量 | 单位 |
|---|---|
| $z,L,\Lambda,\lambda$ | m |
| $f$ | Hz |
| $\omega$ | rad/s |
| $\beta,K,\kappa,\delta,\alpha$ | m^-1 |
| $\tau_g$ | s |
| GDD | s^2 |
| $\theta$ | rad |

## 6. COMSOL 对接检查

1. 端口模式必须归一化为相同输入功率。
2. 输出优先使用复数 S 参数，而不是未归一化场积分。
3. 对多模端口分别保存 $S_{m\leftarrow n}$，不能只看总场范数。
4. 检查 $\sum_m R_m+\sum_m T_m+P_{\mathrm{abs}}+P_{\mathrm{rad}}=1$。
5. 比较反射相位前先统一参考面，否则群时延会包含额外直波导传播时间。

