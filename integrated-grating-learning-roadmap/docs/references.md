# 阅读书目和文献索引

## 使用原则

- “必读”论文要求看完模型、关键推导、图和结论，并复现至少一张图。
- “选读”论文主要用于平台和结构对比。
- 教材只读对应专题，不在 30 天内通读。

## 核心教材

1. K. Okamoto, *Fundamentals of Optical Waveguides*, 2nd ed.：模式正交、微扰和耦合模理论。
2. A. W. Snyder and J. D. Love, *Optical Waveguide Theory*：严格模式理论参考。
3. R. Kashyap, *Fiber Bragg Gratings*, 2nd ed.：均匀、切趾、啁啾、相移和逆设计。
4. A. Othonos and K. Kalli, *Fiber Bragg Gratings*：物理解释和应用补充。
5. L. Chrostowski and M. Hochberg, *Silicon Photonics Design*：集成器件设计和数值工作流。
6. R. G. Hunsperger, *Integrated Optics: Theory and Technology*：集成周期结构背景。

## 阶段一：CMT、TMM 和 Bloch 理论

### 必读

- H. Kogelnik, “Coupled Wave Theory for Thick Hologram Gratings,” 1969. [DOI](https://doi.org/10.1002/j.1538-7305.1969.tb01198.x)
- T. Erdogan, “Fiber grating spectra,” 1997. [DOI](https://doi.org/10.1109/50.618322)
- E. Peral and J. Capmany, “Generalized Bloch wave analysis for fiber and waveguide gratings,” 1997. [DOI](https://doi.org/10.1109/50.618325)

### 选读

- K. O. Hill and G. Meltz, “Fiber Bragg grating technology fundamentals and overview,” 1997. [DOI](https://doi.org/10.1109/50.618320)

## 阶段二：集成波导光栅

### 必读

- A. D. Simard et al., “Apodized Silicon-on-Insulator Bragg Gratings,” 2012. [DOI](https://doi.org/10.1109/LPT.2012.2194278)
- J. Zhan et al., “Silicon nitride polarization beam splitter based on polarization-independent MMIs and apodized Bragg gratings,” 2021. [DOI](https://doi.org/10.1364/OE.420499)

### 平台对比

- C. Guyot et al., “Optical characterization of ultra-short Bragg grating on lithium niobate ridge waveguide,” 2014. [DOI](https://doi.org/10.1364/OL.39.000371)
- D. Pohl et al., “100-GBd Waveguide Bragg Grating Modulator in Thin-Film Lithium Niobate,” 2021. [DOI](https://doi.org/10.1109/LPT.2020.3044648)

## 阶段三：切趾、啁啾和逆设计

### 必读

- L. Poladian, “Graphical and WKB analysis of nonuniform Bragg gratings,” 1993. [DOI](https://doi.org/10.1103/PhysRevE.48.4758)
- J. Skaar, L. Wang and T. Erdogan, “On the synthesis of fiber Bragg gratings by layer peeling,” 2001. [DOI](https://doi.org/10.1109/3.903065)
- J. Á. Praena and A. Carballar, “Chirped Integrated Bragg Grating Design,” 2024. [DOI](https://doi.org/10.3390/photonics11050476)

### SiN 案例

- Z. Du et al., “Silicon nitride chirped spiral Bragg grating with large group delay,” 2020. [DOI](https://doi.org/10.1063/5.0022963)

## 阶段四：多模和偏振耦合

### 必读

- C. Lu and Y. Cui, “Fiber Bragg grating spectra in multimode optical fibers,” 2006. [DOI](https://doi.org/10.1109/JLT.2005.859841)
- N. Ning et al., “Narrow-band Add-Drop Filters Based on Silicon Nitride Multimode Waveguide Bragg Grating,” 2024. [DOI](https://doi.org/10.1109/LPT.2023.3289864)
- Z. Xu, B. Tu and H. Liu, “High performance TM-pass polarizer using multimode Bragg grating waveguide,” 2024. [DOI](https://doi.org/10.1364/OE.520833)

## 阶段五：垂直光栅耦合器

### 基础理论

- T. Tamir and S. T. Peng, “Analysis and design of grating couplers,” 1977. [DOI](https://doi.org/10.1007/BF00882729)
- D. Taillaert et al., “Grating Couplers for Coupling between Optical Fibers and Nanophotonic Waveguides,” 2006. [DOI](https://doi.org/10.1143/JJAP.45.6071)
- F. Van Laere et al., “Compact and Highly Efficient Grating Couplers,” 2007. [DOI](https://doi.org/10.1109/JLT.2006.888164)
- Z. Zhao and S. Fan, “Design Principles of Apodized Grating Couplers,” 2020. [DOI](https://doi.org/10.1109/JLT.2020.2992574)

### 进阶设计

- D. Benedikovic et al., “Subwavelength index engineered surface grating coupler with sub-decibel efficiency,” 2015. [DOI](https://doi.org/10.1364/OE.23.022628)
- A. Michaels and E. Yablonovitch, “Inverse design of near unity efficiency perfectly vertical grating couplers,” 2018. [DOI](https://doi.org/10.1364/OE.26.004766)
- C. Xue et al., “Inverse design and fabrication of high-efficiency perfectly vertical LNOI grating couplers,” 2025. [DOI](https://doi.org/10.1364/OL.549856)
- J. Zou et al., “Ultra efficient silicon nitride grating coupler with bottom grating reflector,” 2015. [DOI](https://doi.org/10.1364/OE.23.026305)

## 建议的文献笔记模板

每篇论文只回答六个问题：

1. 器件和平台是什么？
2. 使用什么理论模型，核心假设是什么？
3. 输入和输出量如何归一化？
4. 哪个几何参数控制相位匹配，哪个控制耦合强度？
5. 仿真和实验的主要偏差来自哪里？
6. 哪张图值得用本学习包复现？

