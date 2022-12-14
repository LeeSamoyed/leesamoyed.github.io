# 高斯分布

Linear Gaussian Model（线性高斯模型）
Kalman Fillter（卡诺曼滤波）
高斯分布非常重要！！！

### 极大似然估计：

$X:(x_1,x_2,...,x_n)^T=\begin{gathered}\begin{pmatrix}x_1\\x_2\\...\\x_n\end{pmatrix}\end{gathered}$

$x_i \epsilon R^p \quad x_i \mathop{\sim}^{iid} N(\mu,\Sigma) \quad \theta  = (\mu,\Sigma)$

其中，iid：独立同分布 

$MLE:\theta_{MLE} = \arg\max\limits_{\theta} P(X|\theta)$

令$p=1,\theta=(\mu,\sigma^2)$（$p=1$方便计算）

一维：

$p(x) = \frac {1}{\sqrt{2\pi}\sigma}exp(-\frac{(x-\mu)^2}{2\sigma^2})$

多维（假设是$p$维）：

$p(x) = \frac {1}{(2\pi)^{\frac{p}{2}}|\Sigma|^{\frac{1}{2}}}exp(-\frac{1}{2}(x-\mu)^T\Sigma^{-1}(x-\mu))$

---

那么我们可以写出他的似然函数：

$\log P(X|\theta)= \log \mathop \Pi \limits_{i=1} \limits^{N} p(x_i|\theta) =\mathop \Pi \limits_{i=1} \limits^{N} \log p(x_i|\theta)\\=\mathop \Sigma \limits_{i=1} \limits^{N}\log\frac{1}{\sqrt{2\pi}\sigma}exp(-\frac{(x-\mu)^2}{2\sigma^2})\\=\mathop \Sigma \limits_{i=1} \limits^{N}[\log\frac{1}{\sqrt{2\pi}}+log{\frac{1}{\sigma}}-\frac{(x_i-\mu)^2}{2\sigma^2}]$

那么$\mu$估计：

$\mu_{MLE} = \arg\max\limits_{\mu}\log p(X|\theta)\\=\arg\max \mathop \Sigma \limits_{i=1}\limits^{N}-\frac{(x_i-\mu)^2}{2\sigma^2}\\=\arg\min\limits_{\mu} \mathop \Sigma \limits_{i=1}\limits^{N}(x_i-\mu)^2$

对$\mu$进行求导：

$\frac{\partial}{\partial\mu}\Sigma(x_i-\mu)^2 = \mathop \Sigma \limits_{i-1}\limits^{N} 2\cdot(x_i-\mu) \cdot (-1)=0\\\mathop \Sigma \limits_{i=1}\limits^{N}(x_i-\mu)=0\\\mathop \Sigma \limits_{i=1}\limits^{N}x_i -\mathop \Sigma \limits_{i=1}\limits^{N} \mu =0\\\mu_{MLE} = \frac{1}{N}\mathop \Sigma \limits_{i=1}\limits^{N}x_i$

无偏估计 $E[\mu_{MLE}]\\= \frac{1}{N}\mathop \Sigma \limits_{i=1}\limits^{N}E[x_i]\\= \frac{1}{N}\mathop \Sigma \limits_{i=1}\limits^{N}\mu\\= \frac{1}{N}N\cdot\mu\\=\mu$

---


那么$\sigma^2$估计：

$\sigma^2_{MLE} = \arg\max\limits_{\sigma} p(X|\sigma)\\=\arg\max \Sigma \begin{matrix}\underbrace{ (-\log\sigma - \frac{1}{2\sigma^2}(x_i-\mu)^2)}\\ \alpha\end{matrix}$

求导：

$\$ $\frac{\partial\alpha}{\partial\sigma} = \mathop \Sigma \limits_{i=1}\limits^{N}[-\frac{1}{\sigma}+\frac{1}{2}(x_i-\mu)^2 \cdot (+2)\sigma^{-3}] = 0\\\mathop \Sigma \limits_{i=1}\limits^{N}[-\frac{1}{\sigma}+ (x_i-\mu)^2 \cdot \sigma^{-3}] = 0\\\mathop \Sigma \limits_{i=1}\limits^{N}[-\sigma^2 + (x_i-\mu)^2] = 0\\-\mathop \Sigma \limits_{i=1}\limits^{N}\sigma^2 + \mathop \Sigma \limits_{i-1}\limits^{N}(x_i-\mu)^2 = 0\\\mathop \Sigma \limits_{i=1}\limits^{N}\sigma^2 = \mathop \Sigma \limits_{i-1}\limits^{N(x_i-\mu)^2\\\sigma^2_{MLE} = \frac{1}{N}\mathop \Sigma \limits_{i=1}\limits^{N}(x_i-\mu)^2$

$\sigma^2_{MLE} = \frac{1}{N}\mathop \Sigma \limits_{i=1}\limits^{N}(x_i-\mu_{MLE})^2$

有偏估计

实际上：$E[\sigma^2_{MLE}] = \frac{N-1}{N}\sigma^2$

然而真正的无偏是这样的：$\widehat{\sigma} = \frac{1}{N-1}\mathop \Sigma \limits_{i=1}\limits^{N}(x_i-\mu_{MLE})^2$


### 无偏&有偏：

无偏估计：$\mu_{MLE} = \frac{1}{N}\mathop \Sigma \limits_{i=1}\limits^{N}x_i$

有偏估计：$\sigma^2_{MLE} = \frac{1}{N}\mathop \Sigma \limits_{i=1}\limits^{N}(x_i-\mu)^2$

其中：$x_i \sim N(\mu,\sigma^2)$

有偏估计和无偏估计的判断：$E[T(x)] = T(x)$例如：$E[\widehat{\mu}] = \mu \quad E[\widehat{\sigma}] = \sigma$相等则无偏，不相等则有偏

---

$E[\mu_{MLE}] = E[\frac{1}{N}\mathop \Sigma \limits_{i=1}\limits^{N}x_i]= \frac{1}{N}\mathop \Sigma \limits_{i=1}\limits^{N}E[x_i]= \frac{1}{N}\mathop \Sigma \limits_{i=1}\limits^{N}\mu = \mu$所以无偏差

那么有偏差其实是看：

$E[\sigma^2_{MLE}] \mathop = \limits^? \sigma^2$

$\sigma^2_{MLE} = \frac{1}{N}\mathop \Sigma \limits_{i-1}\limits^{N}(x_i-\mu_{MLE})^2= \frac{1}{N}\mathop \Sigma \limits_{i-1}\limits^{N}(x_i^2 - 2x_i\mu_{MLE} + \mu^2_{MLE}) =\frac{1}{N}\mathop \Sigma \limits_{i-1}\limits^{N}x_i^2 - \begin{matrix}\underbrace{\frac{1}{N}\mathop \Sigma \limits_{i-1}\limits^{N}2x_i\mu_{MLE}} \\ 2\cdot\mu_{MLE}^2\end{matrix} + \begin{matrix}\underbrace{\frac{1}{N}\mathop \Sigma \limits_{i-1}\limits^{N}\mu^2_{MLE}} \\ \mu^2_{MLE}\end{matrix}\\=\frac{1}{N}\mathop \Sigma \limits_{i=1}\limits^{N}x_i^2 -\mu^2_{MLE}$

  $E[\sigma^2_{MLE}] = E[\frac{1}{N}\mathop \Sigma \limits_{i=1}\limits^{N}x_i^2 -\mu^2_{MLE}]= E[\frac{1}{N}\mathop \Sigma \limits_{i=1}\limits^{N}x_i^2 -\mu^2 - (\mu^2_{MLE}- \mu^2)] \\\begin{matrix}\underbrace{=E[\frac{1}{N}\mathop \Sigma \limits_{i=1}\limits^{N}x_i^2 -\mu^2]} \\ \underbrace{E[\frac{1}{N}\mathop \Sigma \limits_{i=1}\limits^{N}(x_i^2 -\mu^2)]}\\\underbrace{\frac{1}{N}\mathop \Sigma \limits_{i=1}\limits^{N}E(x_i^2 -\mu^2)}\\\underbrace{\frac{1}{N}\mathop \Sigma \limits_{i=1}\limits^{N}(E(x_i^2) -\mu^2)}\\ \underbrace{\frac{1}{N}\mathop \Sigma \limits_{i=1}\limits^{N} Var(x_i)}\\\underbrace{\frac{1}{N}\mathop \Sigma \limits_{i=1}\limits^{N} \sigma^2}\\\sigma^2\end{matrix}\begin{matrix}\underbrace{-E[(\mu^2_{MLE}- \mu^2)]}\\ \underbrace{E[\mu^2_{MLE}]- E[\mu^2]}\\ \underbrace{E[\mu^2_{MLE}]- \mu^2}\\ \underbrace{E[\mu^2_{MLE}]- \mu_{MLE}^2}\\ \underbrace{Var(\mu_{MLE})}\\ \frac{1}{N}\sigma^2\end{matrix}=\frac{N-1}{N}\sigma^2$

利用极大似然估计对于高斯分布：方差估计小了；

其中对于$Var(\mu_{MLE})$：

有：$Var[\mu_{MLE}] = Var[\frac{1}{N}\mathop \Sigma \limits_{i=1}\limits^{N}x_i] = \frac{1}{N^2}\mathop \Sigma \limits_{i=1}\limits^{N}Var(x_i) = \frac{1}{N^2}\mathop \Sigma \limits_{i=1}\limits^N \sigma^2 = \frac{1}{N^2}\cdot N \cdot \sigma^2 = \frac{\sigma}{N}$

### 从概率密度（PDF）角度观察：

$x \sim (\mu,\Sigma) = p(x) = \frac {1}{(2\pi)^{\frac{p}{2}}|\Sigma|^{\frac{1}{2}}}exp(-\frac{1}{2}(x-\mu)^T\Sigma^{-1}(x-\mu))$

其中（一般$\Sigma$是半正定，在这里假设是正定的）：

$x_i \epsilon R^p \quad r.v$

$x:(x_1,x_2,...,x_n)^T=\begin{gathered}\begin{pmatrix}x_1\\x_2\\...\\x_p\end{pmatrix}\end{gathered}$    

$\mu=\begin{gathered}\begin{pmatrix}\mu_1\\\mu_2\\...\\\mu_p\end{pmatrix}\end{gathered}$   $\Sigma=\begin{gathered}\begin{pmatrix}\sigma_{11} \quad \sigma_{12} \quad ... \quad \sigma_{1p}\\\sigma_{21} \quad \sigma_{22} \quad ... \quad \sigma_{2p}\\... \quad ... \quad ... \quad ...\\\sigma_{p1} \quad \sigma_{p2} \quad ... \quad \sigma_{pp}\end{pmatrix}\end{gathered}_{p×p}$ 

主要研究式子中与$x$有关的部分即：$(x-\mu)^T\Sigma^{-1}(x-\mu)$    可以看作是马氏距离（$x$与$\mu$之间）
 当然最后得到的：$(1×p)×(p×p)×(p×1)=1×1$    其实就是一个数（毕竟是概率密度）

$(x-\mu)^T\Sigma^{-1}(x-\mu)$    可以看作是马氏距离（$x$与$\mu$之间）（当$\Sigma$是单位矩阵，马氏距离等于欧式距离）

---

$\Sigma = U \wedge U^T$（特征分解），$UU^T=U^TU=I$，$\wedge = diag(\lambda_i) \quad i=1,...,p \quad  U=(U_1,U_2,...,U_p)_{p×p}$

$=(u_1 \quad u_2 \quad ... \quad u_p)\begin{gathered}\begin{pmatrix}\lambda_1 \quad ... \quad ... \quad ...\\ ... \quad \lambda_2 \quad ... \quad ...\\ ... \quad ... \quad ... \quad ...\\  ... \quad ... \quad ... \quad \lambda_p\end{pmatrix}\end{gathered}$

$=(u1\lambda_1 \quad u2\lambda_2 \quad ... \quad  up\lambda_p)\begin{gathered}\begin{pmatrix}u_1^T\\u_2^T\\...\\u_p^T\end{pmatrix}\end{gathered}$ $=$ $\mathop \Sigma \limits_{i=1} \limits^{p}u_i\lambda_iu_i^T$

$\Sigma^{-1}=(U^T\wedge U)^{-1}=(U^T)^{-1}\wedge^{-1}U^{-1}=U\wedge^{-1}U^T$其中：$\wedge^{-1}=diag(\frac{1}{\lambda_i})$，$i=1,...,p$

$=\mathop \Sigma \limits_{i=1} \limits^{p}u_i\frac{1}{\lambda_i}u_i^T$

$(x-\mu)^T \Sigma^{-1}(x-\mu)\quad = \quad (x-\mu)^T\mathop \Sigma \limits_{i=1} \limits^{p}u_i\frac{1}{\lambda_i}u_i^T(x-\mu)\quad =\quad \mathop \Sigma \limits_{i=1} \limits^{p}(x-\mu)^Tu_i\frac{1}{\lambda_i}u_i^T(x-\mu)$

令：$y_i=\begin{gathered}\begin{pmatrix}y_1\\y_2\\...\\y_p\end{pmatrix}\end{gathered}$    

$y_i=(x-\mu)^Tu_i \quad = \quad \mathop \Sigma \limits_{i=1} \limits^{p}y_i\frac{1}{\lambda_i}y_i^T \quad  = \quad \mathop \Sigma \limits_{i=1} \limits^{p}\frac{y_i^2}{\lambda_i}$

---

令$p=2$，$\Delta=(x-\mu)^T \Sigma^{-1}(x-\mu)$

$\Delta=\frac{y_1^2}{\lambda_1} + \frac{y_2^2}{\lambda_2}=1$

（P.S 这一章节理解起来巨麻烦）


### 局限性：

1. 参数个数：$\Sigma_{p×p} \rightarrow \frac{p^2-p}{2}+p=\frac{p^2+p}{2}=O(p^2)$    参数太多计算会太复杂
   $\Sigma \rightarrow$对角矩阵

2. 用一个高斯分布没法表达模型（无法确切表达模型）（多个高斯混合模型）；


### 求边缘概率及条件概率：

高维高斯分布推到最复杂的地方章节！！！（要敏感）

已知：$x=\begin{gathered}\begin{pmatrix}x_a\\x_b\end{pmatrix}\end{gathered}\begin{gathered}\begin{matrix}\rightarrow m\\\rightarrow n\end{matrix}\end{gathered}$    

$m+n=p$    

$u=\begin{gathered}\begin{pmatrix}u_a\\u_b\end{pmatrix}\end{gathered}$    

$\Sigma=\begin{gathered}\begin{pmatrix}\Sigma_{aa} \quad \Sigma_{ab}\\\Sigma_{ba} \quad \Sigma_{bb}\end{pmatrix}\end{gathered}$

求：$P(x_a)$，$P(x_b|x_a)$（$P(x_b)$，$P(x_a|x_b)$用对称性）：

通用方法：配方法；

---

**记住一个定理：**

**已知：   $X \sim N(\mu,\Sigma)$    $y=AX+B$**

**结论：    $y \sim N(A\mu+B,A\Sigma A^T) \quad\begin{gathered}\begin{matrix}E[y]=E[Ax+B]\\ =AE[x]+B\\ =A\mu+B \end{matrix}\end{gathered}\quad\begin{gathered}\begin{matrix}Var[y]=Var[Ax+B]\\=Var[Ax]+Var[B]\\=A\cdot \Sigma \cdot A^T\end{matrix}\end{gathered}$**

**关于$A$和$A^T$先后顺序，用矩阵维度去推理就可以**

---

 现在定义：$x_a=\begin{gathered}\begin{matrix}\underbrace{\begin{pmatrix}I_m & 0_n\end{pmatrix}}\\A\end{matrix}\end{gathered}\begin{gathered}\begin{matrix}\underbrace{\begin{pmatrix}x_a\\x_b\end{pmatrix}}\\x\end{matrix}\end{gathered}+0$

$E[x_a] = \begin{gathered}\begin{pmatrix}I_m & 0\end{pmatrix}\end{gathered}\begin{gathered}\begin{pmatrix}\mu_a\\ \mu_b \end{pmatrix}\end{gathered}=\mu_a\quadVar[x_a] = \begin{gathered}\begin{pmatrix}I_m & 0\end{pmatrix}\end{gathered}\begin{gathered}\begin{pmatrix}\Sigma_{aa} & \Sigma_{ab}\\ \Sigma_{ba} & \Sigma_{bb} \en{pmatrix}\end{gathered}=\begin{gathered}\begin{pmatrix}\Sigma_{aa} & \Sigma{ab}\end{pmatrix}\end{gathered}\begin{gathered}\begin{pmatrix}I_m \\ 0\end{pmatrix}\end{gathered}=\Sigma_{aa}$

对于$x_b|x_a$，我们可以先定义：$x_{b \cdot a}=x_b - \Sigma_{ba} \Sigma_{aa}^{-1}x_a$（大量实践）$\mu_{b \cdot a}=\mu_b - \Sigma_{ba} \Sigma_{aa}^{-1}\mu_a$

$\Sigma_{b \cdot a}=\Sigma_b - \Sigma_{ba} \Sigma_{aa}^{-1}\Sigma_a$（$\Sigma_{aa}$schur complement）

$x_{b \cdot a} = \begin{gathered}\begin{matrix}\underbrace{\begin{pmatrix}-\Sigma_{ba} \Sigma_{aa}^{-1} & I \end{pmatrix}}\\A \end{matrix}\end{gathered}\begin{gathered}\begin{matrix}\underbrace{\begin{pmatrix}x_a \\ x_b\end{pmatrix}}\\x \end{matrix}\end{gathered}$

$E[x_{b \cdot a}] = \begin{gathered}\begin{pmatrix}-\Sigma_{ba} \Sigma_{aa}^{-1} & I \end{pmatrix}\end{gathered}\begin{gathered}\begin{pmatrix}x_a \\ x_b\end{pmatrix}\end{gathered}=\mu_a-\Sigma_{ba}\Sigma_{aa}^{-1}\mu_a=\mu_{b \cdot a}$

$Var[x_{b \cdot a}] = \begin{gathered}\begin{pmatrix}-\Sigma_{ba} \Sigma_{aa}^{-1} & I \end{pmatrix}\end{gathered}\begin{gathered}\begin{pmatrix}\Sigma_{aa} & \Sigma_{ab} \\ \Sigma_{ba} & \Sigma_{bb}\end{pmatrix}\end{gathered}\begin{gathered}\begin{pmatrix}\Sigma_{aa} & \Sigma_{ab} \\ \Sigma_{ba} & \Sigma_{bb}\end{pmatrix}\end{gathered}\begin{gathered}\begin{pmatrix}-\Sigma_{aa}^{-1} & \Sigma_{ba}^{-1} \\ I\end{pmatrix}\end{gathered}\\=\begin{gathered}\begin{pmatrix}\Sigma_{ba}\Sigma_{aa}^{-1}\Sigma_{aa}+\Sigma_{ba} & -\Sigma_{ba}\Sigma_{aa}^{-1}\Sigma_{ab}+\Sigma_{bb}\end{pmatrix}\end{gathered}\begin{gathered}\begin{pmatrix}-\Sigma_{aa}^{-1} & \Sigma_{ba}^{-1} \\ I\end{pmatrix}\end{gathered}\\=\begin{gathered}\begin{pmatrix}0 & \Sigma_{bb}-\Sigma_{ba}\Sigma_{aa}^{-1}\Sigma_{ab}\end{pmatrix}\end{gathered}\begin{gathered}\begin{pmatrix}-\Sigma_{aa}^{-1} & \Sigma_{ba}^{-1} \\ I\end{pmatrix}\end{gathered}\\=\Sigma_{bb}-\Sigma_{ba}\Sigma_{aa}^{-1}\Sigma_{ab}\\=\Sigma_{bba}$

**所以**：$x_{b \cdot a} \sim N(\mu_{b \cdot a},\Sigma_{b \cdot b \cdot a})$

**求：$x_b|x_a$**

**其中：$x_b = x_{b \cdot a}+ \Sigma_{ba}\Sigma_{aa}^{-1}x_a$**

**所以：$E[x_b|x_a] = \mu_{b \cdot a}+\Sigma_{ba}\Sigma_{aa}^{-1}x_a$    $Var[x_b|x_a] = Var[x_{b \cdot a}]=\Sigma_{b \cdot b \cdot a}$**

**最后得到：$x_b|x_a \sim N(\mu_{b \cdot a}+\Sigma_{ba}\Sigma_{aa}^{-1}x_a,\Sigma_{b \cdot b \cdot a})$    $x_a|x_b$把其中a换b，b换a就行**

### 求联合概率分布：

已知：$p(x)=N(x|\mu,\wedge^{-1}) \quad p(y|x)=N(y|Ax+b,L^{-1})$

求：$p(y),p(x|y)$

$p(x|y) = \frac{p(y|x) \cdot p(x)}{p(y)}$    已知：$p(x),p(y|x)$

解：$y=Ax+b+\varepsilon \quad \varepsilon \sim N(0,L^{-1})$

---

①第一步：
![](data:image/svg+xml,%3Csvg%20xmlns%3Axlink%3D%22http%3A%2F%2Fwww.w3.org%2F1999%2Fxlink%22%20width%3D%2251.38ex%22%20height%3D%222.843ex%22%20style%3D%22vertical-align%3A%20-0.838ex%3B%22%20viewBox%3D%220%20-863.1%2022121.9%201223.9%22%20role%3D%22img%22%20focusable%3D%22false%22%20xmlns%3D%22http%3A%2F%2Fwww.w3.org%2F2000%2Fsvg%22%20aria-labelledby%3D%22MathJax-SVG-1-Title%22%3E%0A%3Ctitle%20id%3D%22MathJax-SVG-1-Title%22%3EE%5By%5D%3DE%5BAx%2Bb%2B%5Cvarepsilon%5D%3DE%5BAx%2Bb%5D%2BE%5B%5Cvarepsilon%5D%3DA%5Cmu%2Bb%3C%2Ftitle%3E%0A%3Cdefs%20aria-hidden%3D%22true%22%3E%0A%3Cpath%20stroke-width%3D%221%22%20id%3D%22E1-MJMATHI-45%22%20d%3D%22M492%20213Q472%20213%20472%20226Q472%20230%20477%20250T482%20285Q482%20316%20461%20323T364%20330H312Q311%20328%20277%20192T243%2052Q243%2048%20254%2048T334%2046Q428%2046%20458%2048T518%2061Q567%2077%20599%20117T670%20248Q680%20270%20683%20272Q690%20274%20698%20274Q718%20274%20718%20261Q613%207%20608%202Q605%200%20322%200H133Q31%200%2031%2011Q31%2013%2034%2025Q38%2041%2042%2043T65%2046Q92%2046%20125%2049Q139%2052%20144%2061Q146%2066%20215%20342T285%20622Q285%20629%20281%20629Q273%20632%20228%20634H197Q191%20640%20191%20642T193%20659Q197%20676%20203%20680H757Q764%20676%20764%20669Q764%20664%20751%20557T737%20447Q735%20440%20717%20440H705Q698%20445%20698%20453L701%20476Q704%20500%20704%20528Q704%20558%20697%20578T678%20609T643%20625T596%20632T532%20634H485Q397%20633%20392%20631Q388%20629%20386%20622Q385%20619%20355%20499T324%20377Q347%20376%20372%20376H398Q464%20376%20489%20391T534%20472Q538%20488%20540%20490T557%20493Q562%20493%20565%20493T570%20492T572%20491T574%20487T577%20483L544%20351Q511%20218%20508%20216Q505%20213%20492%20213Z%22%3E%3C%2Fpath%3E%0A%3Cpath%20stroke-width%3D%221%22%20id%3D%22E1-MJMAIN-5B%22%20d%3D%22M118%20-250V750H255V710H158V-210H255V-250H118Z%22%3E%3C%2Fpath%3E%0A%3Cpath%20stroke-width%3D%221%22%20id%3D%22E1-MJMATHI-79%22%20d%3D%22M21%20287Q21%20301%2036%20335T84%20406T158%20442Q199%20442%20224%20419T250%20355Q248%20336%20247%20334Q247%20331%20231%20288T198%20191T182%20105Q182%2062%20196%2045T238%2027Q261%2027%20281%2038T312%2061T339%2094Q339%2095%20344%20114T358%20173T377%20247Q415%20397%20419%20404Q432%20431%20462%20431Q475%20431%20483%20424T494%20412T496%20403Q496%20390%20447%20193T391%20-23Q363%20-106%20294%20-155T156%20-205Q111%20-205%2077%20-183T43%20-117Q43%20-95%2050%20-80T69%20-58T89%20-48T106%20-45Q150%20-45%20150%20-87Q150%20-107%20138%20-122T115%20-142T102%20-147L99%20-148Q101%20-153%20118%20-160T152%20-167H160Q177%20-167%20186%20-165Q219%20-156%20247%20-127T290%20-65T313%20-9T321%2021L315%2017Q309%2013%20296%206T270%20-6Q250%20-11%20231%20-11Q185%20-11%20150%2011T104%2082Q103%2089%20103%20113Q103%20170%20138%20262T173%20379Q173%20380%20173%20381Q173%20390%20173%20393T169%20400T158%20404H154Q131%20404%20112%20385T82%20344T65%20302T57%20280Q55%20278%2041%20278H27Q21%20284%2021%20287Z%22%3E%3C%2Fpath%3E%0A%3Cpath%20stroke-width%3D%221%22%20id%3D%22E1-MJMAIN-5D%22%20d%3D%22M22%20710V750H159V-250H22V-210H119V710H22Z%22%3E%3C%2Fpath%3E%0A%3Cpath%20stroke-width%3D%221%22%20id%3D%22E1-MJMAIN-3D%22%20d%3D%22M56%20347Q56%20360%2070%20367H707Q722%20359%20722%20347Q722%20336%20708%20328L390%20327H72Q56%20332%2056%20347ZM56%20153Q56%20168%2072%20173H708Q722%20163%20722%20153Q722%20140%20707%20133H70Q56%20140%2056%20153Z%22%3E%3C%2Fpath%3E%0A%3Cpath%20stroke-width%3D%221%22%20id%3D%22E1-MJMATHI-41%22%20d%3D%22M208%2074Q208%2050%20254%2046Q272%2046%20272%2035Q272%2034%20270%2022Q267%208%20264%204T251%200Q249%200%20239%200T205%201T141%202Q70%202%2050%200H42Q35%207%2035%2011Q37%2038%2048%2046H62Q132%2049%20164%2096Q170%20102%20345%20401T523%20704Q530%20716%20547%20716H555H572Q578%20707%20578%20706L606%20383Q634%2060%20636%2057Q641%2046%20701%2046Q726%2046%20726%2036Q726%2034%20723%2022Q720%207%20718%204T704%200Q701%200%20690%200T651%201T578%202Q484%202%20455%200H443Q437%206%20437%209T439%2027Q443%2040%20445%2043L449%2046H469Q523%2049%20533%2063L521%20213H283L249%20155Q208%2086%20208%2074ZM516%20260Q516%20271%20504%20416T490%20562L463%20519Q447%20492%20400%20412L310%20260L413%20259Q516%20259%20516%20260Z%22%3E%3C%2Fpath%3E%0A%3Cpath%20stroke-width%3D%221%22%20id%3D%22E1-MJMATHI-78%22%20d%3D%22M52%20289Q59%20331%20106%20386T222%20442Q257%20442%20286%20424T329%20379Q371%20442%20430%20442Q467%20442%20494%20420T522%20361Q522%20332%20508%20314T481%20292T458%20288Q439%20288%20427%20299T415%20328Q415%20374%20465%20391Q454%20404%20425%20404Q412%20404%20406%20402Q368%20386%20350%20336Q290%20115%20290%2078Q290%2050%20306%2038T341%2026Q378%2026%20414%2059T463%20140Q466%20150%20469%20151T485%20153H489Q504%20153%20504%20145Q504%20144%20502%20134Q486%2077%20440%2033T333%20-11Q263%20-11%20227%2052Q186%20-10%20133%20-10H127Q78%20-10%2057%2016T35%2071Q35%20103%2054%20123T99%20143Q142%20143%20142%20101Q142%2081%20130%2066T107%2046T94%2041L91%2040Q91%2039%2097%2036T113%2029T132%2026Q168%2026%20194%2071Q203%2087%20217%20139T245%20247T261%20313Q266%20340%20266%20352Q266%20380%20251%20392T217%20404Q177%20404%20142%20372T93%20290Q91%20281%2088%20280T72%20278H58Q52%20284%2052%20289Z%22%3E%3C%2Fpath%3E%0A%3Cpath%20stroke-width%3D%221%22%20id%3D%22E1-MJMAIN-2B%22%20d%3D%22M56%20237T56%20250T70%20270H369V420L370%20570Q380%20583%20389%20583Q402%20583%20409%20568V270H707Q722%20262%20722%20250T707%20230H409V-68Q401%20-82%20391%20-82H389H387Q375%20-82%20369%20-68V230H70Q56%20237%2056%20250Z%22%3E%3C%2Fpath%3E%0A%3Cpath%20stroke-width%3D%221%22%20id%3D%22E1-MJMATHI-62%22%20d%3D%22M73%20647Q73%20657%2077%20670T89%20683Q90%20683%20161%20688T234%20694Q246%20694%20246%20685T212%20542Q204%20508%20195%20472T180%20418L176%20399Q176%20396%20182%20402Q231%20442%20283%20442Q345%20442%20383%20396T422%20280Q422%20169%20343%2079T173%20-11Q123%20-11%2082%2027T40%20150V159Q40%20180%2048%20217T97%20414Q147%20611%20147%20623T109%20637Q104%20637%20101%20637H96Q86%20637%2083%20637T76%20640T73%20647ZM336%20325V331Q336%20405%20275%20405Q258%20405%20240%20397T207%20376T181%20352T163%20330L157%20322L136%20236Q114%20150%20114%20114Q114%2066%20138%2042Q154%2026%20178%2026Q211%2026%20245%2058Q270%2081%20285%20114T318%20219Q336%20291%20336%20325Z%22%3E%3C%2Fpath%3E%0A%3Cpath%20stroke-width%3D%221%22%20id%3D%22E1-MJMATHI-3B5%22%20d%3D%22M190%20-22Q124%20-22%2076%2011T27%20107Q27%20174%2097%20232L107%20239L99%20248Q76%20273%2076%20304Q76%20364%20144%20408T290%20452H302Q360%20452%20405%20421Q428%20405%20428%20392Q428%20381%20417%20369T391%20356Q382%20356%20371%20365T338%20383T283%20392Q217%20392%20167%20368T116%20308Q116%20289%20133%20272Q142%20263%20145%20262T157%20264Q188%20278%20238%20278H243Q308%20278%20308%20247Q308%20206%20223%20206Q177%20206%20142%20219L132%20212Q68%20169%2068%20112Q68%2039%20201%2039Q253%2039%20286%2049T328%2072T345%2094T362%20105Q376%20103%20376%2088Q376%2079%20365%2062T334%2026T275%20-8T190%20-22Z%22%3E%3C%2Fpath%3E%0A%3Cpath%20stroke-width%3D%221%22%20id%3D%22E1-MJMATHI-3BC%22%20d%3D%22M58%20-216Q44%20-216%2034%20-208T23%20-186Q23%20-176%2096%20116T173%20414Q186%20442%20219%20442Q231%20441%20239%20435T249%20423T251%20413Q251%20401%20220%20279T187%20142Q185%20131%20185%20107V99Q185%2026%20252%2026Q261%2026%20270%2027T287%2031T302%2038T315%2045T327%2055T338%2065T348%2077T356%2088T365%20100L372%20110L408%20253Q444%20395%20448%20404Q461%20431%20491%20431Q504%20431%20512%20424T523%20412T525%20402L449%2084Q448%2079%20448%2068Q448%2043%20455%2035T476%2026Q485%2027%20496%2035Q517%2055%20537%20131Q543%20151%20547%20152Q549%20153%20557%20153H561Q580%20153%20580%20144Q580%20138%20575%20117T555%2063T523%2013Q510%200%20491%20-8Q483%20-10%20467%20-10Q446%20-10%20429%20-4T402%2011T385%2029T376%2044T374%2051L368%2045Q362%2039%20350%2030T324%2012T288%20-4T246%20-11Q199%20-11%20153%2012L129%20-85Q108%20-167%20104%20-180T92%20-202Q76%20-216%2058%20-216Z%22%3E%3C%2Fpath%3E%0A%3C%2Fdefs%3E%0A%3Cg%20stroke%3D%22currentColor%22%20fill%3D%22currentColor%22%20stroke-width%3D%220%22%20transform%3D%22matrix(1%200%200%20-1%200%200)%22%20aria-hidden%3D%22true%22%3E%0A%20%3Cuse%20xlink%3Ahref%3D%22%23E1-MJMATHI-45%22%20x%3D%220%22%20y%3D%220%22%3E%3C%2Fuse%3E%0A%20%3Cuse%20xlink%3Ahref%3D%22%23E1-MJMAIN-5B%22%20x%3D%22764%22%20y%3D%220%22%3E%3C%2Fuse%3E%0A%20%3Cuse%20xlink%3Ahref%3D%22%23E1-MJMATHI-79%22%20x%3D%221043%22%20y%3D%220%22%3E%3C%2Fuse%3E%0A%20%3Cuse%20xlink%3Ahref%3D%22%23E1-MJMAIN-5D%22%20x%3D%221540%22%20y%3D%220%22%3E%3C%2Fuse%3E%0A%20%3Cuse%20xlink%3Ahref%3D%22%23E1-MJMAIN-3D%22%20x%3D%222096%22%20y%3D%220%22%3E%3C%2Fuse%3E%0A%20%3Cuse%20xlink%3Ahref%3D%22%23E1-MJMATHI-45%22%20x%3D%223153%22%20y%3D%220%22%3E%3C%2Fuse%3E%0A%20%3Cuse%20xlink%3Ahref%3D%22%23E1-MJMAIN-5B%22%20x%3D%223917%22%20y%3D%220%22%3E%3C%2Fuse%3E%0A%20%3Cuse%20xlink%3Ahref%3D%22%23E1-MJMATHI-41%22%20x%3D%224196%22%20y%3D%220%22%3E%3C%2Fuse%3E%0A%20%3Cuse%20xlink%3Ahref%3D%22%23E1-MJMATHI-78%22%20x%3D%224946%22%20y%3D%220%22%3E%3C%2Fuse%3E%0A%20%3Cuse%20xlink%3Ahref%3D%22%23E1-MJMAIN-2B%22%20x%3D%225741%22%20y%3D%220%22%3E%3C%2Fuse%3E%0A%20%3Cuse%20xlink%3Ahref%3D%22%23E1-MJMATHI-62%22%20x%3D%226742%22%20y%3D%220%22%3E%3C%2Fuse%3E%0A%20%3Cuse%20xlink%3Ahref%3D%22%23E1-MJMAIN-2B%22%20x%3D%227393%22%20y%3D%220%22%3E%3C%2Fuse%3E%0A%20%3Cuse%20xlink%3Ahref%3D%22%23E1-MJMATHI-3B5%22%20x%3D%228394%22%20y%3D%220%22%3E%3C%2Fuse%3E%0A%20%3Cuse%20xlink%3Ahref%3D%22%23E1-MJMAIN-5D%22%20x%3D%228860%22%20y%3D%220%22%3E%3C%2Fuse%3E%0A%20%3Cuse%20xlink%3Ahref%3D%22%23E1-MJMAIN-3D%22%20x%3D%229417%22%20y%3D%220%22%3E%3C%2Fuse%3E%0A%20%3Cuse%20xlink%3Ahref%3D%22%23E1-MJMATHI-45%22%20x%3D%2210473%22%20y%3D%220%22%3E%3C%2Fuse%3E%0A%20%3Cuse%20xlink%3Ahref%3D%22%23E1-MJMAIN-5B%22%20x%3D%2211238%22%20y%3D%220%22%3E%3C%2Fuse%3E%0A%20%3Cuse%20xlink%3Ahref%3D%22%23E1-MJMATHI-41%22%20x%3D%2211516%22%20y%3D%220%22%3E%3C%2Fuse%3E%0A%20%3Cuse%20xlink%3Ahref%3D%22%23E1-MJMATHI-78%22%20x%3D%2212267%22%20y%3D%220%22%3E%3C%2Fuse%3E%0A%20%3Cuse%20xlink%3Ahref%3D%22%23E1-MJMAIN-2B%22%20x%3D%2213061%22%20y%3D%220%22%3E%3C%2Fuse%3E%0A%20%3Cuse%20xlink%3Ahref%3D%22%23E1-MJMATHI-62%22%20x%3D%2214062%22%20y%3D%220%22%3E%3C%2Fuse%3E%0A%20%3Cuse%20xlink%3Ahref%3D%22%23E1-MJMAIN-5D%22%20x%3D%2214491%22%20y%3D%220%22%3E%3C%2Fuse%3E%0A%20%3Cuse%20xlink%3Ahref%3D%22%23E1-MJMAIN-2B%22%20x%3D%2214992%22%20y%3D%220%22%3E%3C%2Fuse%3E%0A%20%3Cuse%20xlink%3Ahref%3D%22%23E1-MJMATHI-45%22%20x%3D%2215993%22%20y%3D%220%22%3E%3C%2Fuse%3E%0A%20%3Cuse%20xlink%3Ahref%3D%22%23E1-MJMAIN-5B%22%20x%3D%2216757%22%20y%3D%220%22%3E%3C%2Fuse%3E%0A%20%3Cuse%20xlink%3Ahref%3D%22%23E1-MJMATHI-3B5%22%20x%3D%2217036%22%20y%3D%220%22%3E%3C%2Fuse%3E%0A%20%3Cuse%20xlink%3Ahref%3D%22%23E1-MJMAIN-5D%22%20x%3D%2217502%22%20y%3D%220%22%3E%3C%2Fuse%3E%0A%20%3Cuse%20xlink%3Ahref%3D%22%23E1-MJMAIN-3D%22%20x%3D%2218059%22%20y%3D%220%22%3E%3C%2Fuse%3E%0A%20%3Cuse%20xlink%3Ahref%3D%22%23E1-MJMATHI-41%22%20x%3D%2219115%22%20y%3D%220%22%3E%3C%2Fuse%3E%0A%20%3Cuse%20xlink%3Ahref%3D%22%23E1-MJMATHI-3BC%22%20x%3D%2219865%22%20y%3D%220%22%3E%3C%2Fuse%3E%0A%20%3Cuse%20xlink%3Ahref%3D%22%23E1-MJMAIN-2B%22%20x%3D%2220691%22%20y%3D%220%22%3E%3C%2Fuse%3E%0A%20%3Cuse%20xlink%3Ahref%3D%22%23E1-MJMATHI-62%22%20x%3D%2221692%22%20y%3D%220%22%3E%3C%2Fuse%3E%0A%3C%2Fg%3E%0A%3C%2Fsvg%3E)

$Var[y]=Var[Ax+b+\varepsilon]=Var[Ax+b]+Var[\epsilon]=A\cdot \wedge^{-1} \cdot A^T +L^{-1}$

$y \sim N(A\mu+b,A\cdot \wedge^{-1} \cdot A^T +L^{-1})$

---

②第二步：
$Z=\begin{gathered}\begin{pmatrix} x\\y\end{pmatrix}\end{gathered}\simN(\begin{gathered}\begin{matrix}\underbrace{\begin{bmatrix} \mu \\ A\mu+b\end{bmatrix}}\\E[z] \end{matrix}\end{gathered},\begin{gathered}\begin{bmatrix}  \wedge^{-1} & O \\O & L^{-1}+A\wedge^{-1}A^T \end{bmatrix}\end{gathered})$，我们缺少$O$（圆圈）的部分，实质上两个圆圈缺的内容是一样的（本质一个圆圈内容是另一个圆圈内容转置，但是他们互为转置），我们定义圆圈的内容为$\Delta$，$\Delta=Cov(x,y)\\=E[(x-E[x]) \cdot (y-E[y])]^T\\=E[(x-\mu)(y-A\mu-b)]^T\\=E[(x-\mu)(Ax+b+\varepsilon-A/mu-b)^T]\\=E[(x-\mu)(Ax-A\mu+\varepsilon)^T]\\=E[(x-\mu)(Ax-A/mu)^T+(x-\mu)\varepsilon^T]\\=E[(x-\mu)(Ax-A/mu)^T]+\begin{gathered}\begin{matrix}\underbrace{E[(x-\mu)\varepsilon^T]}\\x\bot\varepsilon\\x-\mu\bot\varepsilon\\ E[(x-\mu)]E[\varepsilon] =0\end{matrix}\end{gathered}\\=E[(x-u)(Ax-A\mu^T)]\\=E[(x-\mu)(x-\mu)^T\cdot A^T]\\=E[(x-u)(Ax-A\mu^T)]\\=E[(x-\mu)(x-\mu)^T\cdot A^T\\=Var[x] /cdot A^T\\=\wedge^{-1}A^T$
**最后一步中，$\mu$就是$E[x]$，所以那个事方差公式**

---

代入$O$（圆圈）
$p(x|y) \sim N(,)$最后答案套公式