// ============================================================
// 平均值统一讲解（外部优秀材料，2026-09-16 归档）
// 来源：用户粘贴的讲解稿（2395 行）；经语法修复（\hspace → #h）后可编译。
// 定位：以后回答"平均值/加权/质心/线积分平均"类问题的优先参考范本。
// ============================================================

#set document(
  title: "平均值、积分与质心：从离散到连续的统一理解",
  author: "数学理解笔记",
)

#set page(
  margin: (
    top: 2.2cm,
    bottom: 2.2cm,
    left: 2.4cm,
    right: 2.4cm,
  ),
)

#set text(
  font: "New Computer Modern",
  size: 11pt,
)

#set heading(numbering: "1.1")

// 语法修复：提供 LaTeX 风格的 boxed（数学模式内可用）
#let boxed(body) = box(
  stroke: 0.6pt + rgb("#333333"),
  inset: (x: 6pt, y: 4pt),
  radius: 0.5pt,
  $body$,
)

// 语法修复：把原稿的 Markdown 引用块（> 开头）转为 Typst 引用块
#let bquote(body) = block(
  width: 100%,
  inset: (left: 12pt, top: 6pt, bottom: 6pt),
  stroke: (left: 2.5pt + rgb("#9aa0a6")),
  body,
)

// 三线表（简化版：顶线 + 表头下线，与笔记体系 booktabs-table 同风格）
#let booktabs-table(columns: auto, ..args) = table(
  columns: columns,
  align: left,
  stroke: (x, y) => (
    top: if y == 0 { 1.2pt + black } else { 0pt },
    bottom: if y == 1 { 0.5pt + black } else { 0pt },
  ),
  ..args,
)

= 从离散平均值到线积分平均值

== 核心思想

平均值并不是一系列彼此孤立的公式。

从离散平均值、加权平均值，到连续平均值、二重积分平均值、线积分平均值，再到质心，它们背后其实都在做同一件事情：

$
  "平均值"
  =
  frac(
    "总量",
    "总份量"
  )
$

更加一般地，如果 $f$ 是我们希望平均的量，而 $d mu$ 表示每一个微小部分所占的“份量”，那么：

$
  op("Avg")(f)
  =
  frac(
    integral_S f dif mu,
    integral_S dif mu
  )
$

如果不同位置的重要程度还不同，用权重 $w$ 表示，那么：

$
  op("Avg")_w(f)
  =
  frac(
    integral_S f w dif mu,
    integral_S w dif mu
  )
$

这条公式将贯穿整个学习过程。

---

= 第一阶段：离散平均值

== 普通平均值

先考虑三个数字：

$
  2, 5, 8
$

普通平均值为：

$
  bar(x)
  =
  frac(
    2 + 5 + 8,
    3
  )
  =
  5
$

这个公式真正重要的地方，不是“除以 3”，而是：

$
  3 times 5
  =
  2 + 5 + 8
$

也就是说：

$
  "平均值" times "数量"
  =
  "总和"
$

因此：

$
  #boxed[$ "平均值"
  =
  frac(
    "总和",
    "数量"
  ) $]
$

这就是所有平均值公式背后的母思想。

== 平均值的直觉

平均值可以理解成：

#bquote[如果我们把所有数据的总量平均分配给相同数量的份额，那么每一份是多少？]

例如：

$
  2 + 5 + 8 = 15
$

共有三个数据，所以平均分配：

$
  15 / 3 = 5
$

这里的 $5$ 并不是某一个特殊数据，而是“总量均匀分配”后每一份所对应的值。

---

= 第二阶段：加权平均值

== 为什么需要权重

现在考虑三个数据：

$
  2, 5, 8
$

但三个数字的重要程度不同。

设：

$
  w_1 = 1,
  w_2 = 2,
  w_3 = 3
$

那么简单平均：

$
  frac(
    2 + 5 + 8,
    3
  )
$

已经无法正确表达它们的重要程度。

应该让权重大的数字贡献更多：

$
  bar(x)_w
  =
  frac(
    1 dot 2 + 2 dot 5 + 3 dot 8,
    1 + 2 + 3
  )
$

一般形式为：

$
  #boxed[$ bar(x)_w
  =
  frac(
    sum_(i=1)^n w_i x_i,
    sum_(i=1)^n w_i
  ) $]
$

也就是：

$
  #boxed[$ "加权平均"
  =
  frac(
    "加权总量",
    "总权重"
  ) $]
$

== 权重可以理解成“这个数据应该被数多少次”

例如：

$
  x_1 = 2,
  x_2 = 5,
  x_3 = 8
$

权重：

$
  w_1 = 1,
  w_2 = 2,
  w_3 = 3
$

可以把它想象成：

$
  2, 5, 5, 8, 8, 8
$

于是：

$
  frac(
    2 + 5 + 5 + 8 + 8 + 8,
    6
  )
$

就等于：

$
  frac(
    1 dot 2 + 2 dot 5 + 3 dot 8,
    1 + 2 + 3
  )
$

所以：

$
  #boxed[$ "权重"
  =
  "某个数据的重要程度" $]
$

也可以理解成：

$
  #boxed[$ "权重"
  =
  "这个数据应该被数多少次" $]
$

---

= 第三阶段：从离散进入连续

== 从有限个点到一个区间

现在考虑函数：

$
  f(x)
$

定义在：

$
  [a,b]
$

我们希望知道：

#bquote[函数 $f(x)$ 在整个区间上的平均值是多少？]

区间里不再只有有限个点，而是包含无限多个位置。

因此我们需要把连续区间分成很多很小的部分。

== 把区间切成小段

把：

$
  [a,b]
$

切成很多小段。

每一小段长度约为：

$
  Delta x
$

在第 $i$ 个小段中取一个代表点：

$
  x_i^*
$

那么：

$
  f(x)
$

在这一小段里可以近似看成：

$
  f(x_i^*)
$

这一小段对总量的贡献约为：

$
  f(x_i^*) Delta x
$

把所有小段加起来：

$
  sum_i f(x_i^*) Delta x
$

当分割越来越细时：

$
  #boxed[$ integral_a^b f(x) dif x
  =
  lim_(n -> infinity)
  sum_i f(x_i^*) Delta x $]
$

因此：

#bquote[积分可以理解为把连续世界中的所有微小贡献全部加起来。]

== 从求和到积分

离散：

$
  sum_i
$

连续：

$
  integral
$

因此：

$
  #boxed[$ sum
  arrow
  integral $]
$

并不是积分突然出现，而是：

#bquote[把离散求和做得越来越细，在极限下得到积分。]

---

= 第四阶段：连续平均值

== 连续平均值公式

离散平均：

$
  bar(x)
  =
  frac(
    sum_i x_i,
    n
  )
$

连续以后：

“总和”变成：

$
  integral_a^b f(x) dif x
$

“数量”变成区间长度：

$
  b-a
$

所以：

$
  #boxed[$ f_"avg"
  =
  frac(
    1,
    b-a
  )
  integral_a^b f(x) dif x $]
$

也可以写成：

$
  f_"avg"
  =
  frac(
    integral_a^b f(x) dif x,
    integral_a^b dif x
  )
$

因为：

$
  integral_a^b dif x = b-a
$

所以连续平均值仍然完全符合：

$
  #boxed[$ "平均值"
  =
  frac(
    "总量",
    "总份量"
  ) $]
$

== 离散与连续的对应

#table(
  columns: 2,
  align: left,
  [离散世界], [连续世界],
  [$x_i$], [$f(x)$],
  [$sum$], [$integral$],
  [$n$], [$b-a$],
  [数量], [长度],
  [普通平均], [区间平均],
)

---

= 第五阶段：连续加权平均值

== 从离散权重到连续权重

离散加权平均：

$
  bar(x)_w
  =
  frac(
    sum_i w_i x_i,
    sum_i w_i
  )
$

进入连续世界后，权重也变成函数：

$
  w(x)
$

于是连续加权平均：

$
  #boxed[$ f_"avg"
  =
  frac(
    integral_a^b f(x) w(x) dif x,
    integral_a^b w(x) dif x
  ) $]
$

这里：

- $f(x)$ 是我们真正想平均的东西；
- $w(x)$ 表示不同位置的重要程度；
- $w(x) dif x$ 是一个微小的加权份量。

== 物理直觉：密度不同的棍子

想象一根长度为 $10$ 的棍子。

棍子在位置 $x$ 的温度为：

$
  T(x)
$

如果棍子处处质量密度相同，那么：

$
  T_"avg"
  =
  frac(
    1,
    10
  )
  integral_0^10 T(x) dif x
$

但如果不同位置的密度不同：

$
  rho(x)
$

那么质量大的地方应该具有更大的重要程度。

于是：

$
  T_"avg"
  =
  frac(
    integral_0^10 T(x) rho(x) dif x,
    integral_0^10 rho(x) dif x
  )
$

此时：

$
  w(x) = rho(x)
$

因此：

$
  #boxed[$ "连续加权平均"
  =
  "按照密度进行加权的平均" $]
$

---

= 第六阶段：进入二维世界

== 从区间到区域

现在不再研究一条线，而考虑一个平面区域：

$
  D
$

区域中的每个位置：

$
  (x,y)
$

都有一个函数值：

$
  f(x,y)
$

例如：

- 温度；
- 高度；
- 压强；
- 密度；
- 光照强度。

我们希望知道：

#bquote[整个区域中的平均值是多少？]

== 把区域切成很多小格子

把区域切成很多很小的矩形。

每一个小矩形的面积：

$
  Delta A
  =
  Delta x Delta y
$

某个格子中：

$
  f(x_i,y_j)
$

大约保持不变。

因此这一小格的贡献：

$
  f(x_i,y_j) Delta A
$

全部相加：

$
  sum_i sum_j
  f(x_i,y_j)
  Delta x Delta y
$

当格子越来越细时：

$
  #boxed[$ integral_(D) f(x,y) dif A $]
$

这就是二重积分。

== 二重积分的直觉

一重积分：

$
  integral_a^b f(x) dif x
$

表示：

#bquote[沿着一条线，把所有微小贡献加起来。]

二重积分：

$
  integral_(D) f(x,y) dif A
$

表示：

#bquote[在一个二维区域中，把所有微小贡献加起来。]

真正发生的变化只有：

$
  dif x
  arrow
  dif A
$

也就是：

$
  "微小长度"
  arrow
  "微小面积"
$

---

= 第七阶段：二维区域的平均值

区域 $D$ 的面积：

$
  A(D)
  =
  integral_(D) dif A
$

于是：

$
  #boxed[$ f_"avg"
  =
  frac(
    integral_(D) f(x,y) dif A,
    integral_(D) dif A
  ) $]
$

即：

$
  f_"avg"
  =
  frac(
    1,
    "Area"(D)
  )
  integral_(D) f(x,y) dif A
$

可以把它理解成：

#bquote[把二维区域的总“函数量”平均分摊到整个区域面积上。]

---

= 第八阶段：二维连续加权平均

如果区域不同位置的重要程度不同：

$
  w(x,y)
$

那么：

$
  #boxed[$ f_"avg"
  =
  frac(
    integral_(D)
    f(x,y)w(x,y)
    dif A,
    integral_(D)
    w(x,y)
    dif A
  ) $]
$

例如：

$
  rho(x, y)
$

可以表示一个二维物体的密度。

此时：

$
  rho(x, y) dif A
$

就是一个微小面积块所对应的质量。

因此：

#bquote[二维物体中的很多物理量，实际上都可以解释为某种加权平均。]

---

= 第九阶段：进入曲线

== 为什么会出现线积分

现在我们既不是平均区间，也不是平均二维区域。

而是沿着一条曲线：

$
  C
$

例如：

- 道路；
- 山路；
- 管道；
- 绳子；
- 运动轨迹。

曲线上的每一点都有一个值：

$
  f(x,y)
$

我们希望知道：

#bquote[整条曲线上的平均值是多少？]

== 把曲线切成许多小段

把曲线分成：

$
  Delta s_1,
  Delta s_2,
  dots,
  Delta s_n
$

其中 $s$ 表示弧长。

若第 $i$ 段函数值约为：

$
  f_i
$

那么该小段对总量的贡献：

$
  f_i Delta s_i
$

因此平均值：

$
  frac(
    f_1 Delta s_1
    + dots
    + f_n Delta s_n,
    Delta s_1
    + dots
    + Delta s_n
  )
$

当这些小段无限细：

$
  #boxed[$ f_"avg"
  =
  frac(
    integral_C f dif s,
    integral_C dif s
  ) $]
$

而：

$
  integral_C dif s = L
$

其中 $L$ 是曲线长度。

所以：

$
  #boxed[$ f_"avg"
  =
  frac(
    1,
    L
  )
  integral_C f dif s $]
$

== 为什么是 $dif s$

在线积分：

$
  integral_C f dif s
$

中：

$
  dif s
$

表示曲线上的微小长度。

因此：

$
  f dif s
$

表示：

#bquote[这一小段曲线所贡献的量。]

所以：

$
  integral_C f dif s
$

就是沿着曲线长度不断累加。

---

= 第十阶段：为什么线积分还会出现 $dif x$ 和 $dif y$

在线积分中还会出现：

$
  integral_C f dif x
$

和：

$
  integral_C f dif y
$

它们与：

$
  integral_C f dif s
$

含义不同。

== $integral_C f dif s$

按照：

$
  "曲线长度"
$

进行累积。

因为：

$
  dif s > 0
$

它表示沿曲线走过的微小距离。

== $integral_C f dif x$

按照：

$
  "x方向的变化"
$

进行累积。

这里：

$
  dif x
$

可以为正，也可以为负。

因此：

$
  dif x
$

不是长度。

同样：

$
  dif y
$

描述的是 $y$ 方向的变化。

可以记住：

$
  #boxed[$ dif s
  =
  "沿曲线走了多远" $]
$

$
  #boxed[$ dif x
  =
  "x发生了多少变化" $]
$

$
  #boxed[$ dif y
  =
  "y发生了多少变化" $]
$

---

= 第十一阶段：统一所有平均值

现在把之前所有公式放到一起。

设：

- $S$ 是我们需要平均的空间；
- $f$ 是我们希望平均的量；
- $w$ 是权重；
- $d mu$ 是一个微小的“份量”。

统一公式：

$
  #boxed[$ op("Avg")_w(f)
  =
  frac(
    integral_S f w dif mu,
    integral_S w dif mu
  ) $]
$

这就是整个体系最重要的公式。

== 不同情况下的 $dif mu$

=== 离散平均

可以把离散情况理解为：

$
  dif mu = 1
$

于是：

$
  op("Avg")(f)
  =
  frac(
    sum_i f_i,
    sum_i 1
  )
  =
  frac(
    sum_i f_i,
    n
  )
$

=== 离散加权

取：

$
  dif mu = w_i
$

于是：

$
  op("Avg")_w(f)
  =
  frac(
    sum_i f_i w_i,
    sum_i w_i
  )
$

=== 一维连续

取：

$
  dif mu = dif x
$

于是：

$
  op("Avg")(f)
  =
  frac(
    integral_a^b f(x) dif x,
    integral_a^b dif x
  )
$

=== 一维连续加权

取：

$
  dif mu = w(x) dif x
$

于是：

$
  op("Avg")_w(f)
  =
  frac(
    integral_a^b f(x)w(x) dif x,
    integral_a^b w(x) dif x
  )
$

=== 二维区域

取：

$
  dif mu = dif A
$

于是：

$
  op("Avg")(f)
  =
  frac(
    integral_(D) f(x,y) dif A,
    integral_(D) dif A
  )
$

=== 二维区域加权

取：

$
  dif mu = w(x,y) dif A
$

于是：

$
  op("Avg")_w(f)
  =
  frac(
    integral_(D) f(x,y)w(x,y) dif A,
    integral_(D) w(x,y) dif A
  )
$

=== 曲线平均

取：

$
  dif mu = dif s
$

于是：

$
  op("Avg")(f)
  =
  frac(
    integral_C f dif s,
    integral_C dif s
  )
$

即：

$
  f_"avg"
  =
  frac(
    1,
    L
  )
  integral_C f dif s
$

=== 曲线加权平均

取：

$
  dif mu = w(x,y) dif s
$

于是：

$
  op("Avg")_w(f)
  =
  frac(
    integral_C f(x,y)w(x,y) dif s,
    integral_C w(x,y) dif s
  )
$

---

= 第十二阶段：从平均值进入概率

这个统一结构还会自然出现在概率论中。

== 离散随机变量

随机变量 $X$ 的期望：

$
  E[X]
  =
  sum_i x_i P(X=x_i)
$

这实际上就是一种加权平均。

这里：

$
  P(X=x_i)
$

就是权重。

因此：

$
  #boxed[$ "期望值"
  =
  "按照概率进行加权的平均" $]
$

== 连续随机变量

连续随机变量的期望：

$
  E[X]
  =
  integral_(-infinity)^infinity
  x f_X(x) dif x
$

其中：

$
  f_X(x) dif x
$

可以理解成一个微小概率，也就是连续意义下的权重。

所以概率论中的期望，与前面的连续加权平均，本质上仍然是同一种结构。

---

= 第十三阶段：质心为什么又出现一个 $x$

这是理解质心最关键的一步。

假设有几个物体分布在一条直线上。

例如：

$
  x_1 = 0,
  quad x_2 = 10
$

质量分别为：

$
  m_1 = 2,
  quad m_2 = 1
$

可以想象成：

#let center-example = [
  $x=0$ #h(1cm) $x=10$

  ● #h(2.2cm) ●

  $m_1=2$ #h(1.3cm) $m_2=1$
]

#align(center, center-example)

我们想问：

#bquote[整个系统的“代表位置”在哪里？]

答案应该是：

$
  x_c
  =
  frac(
    2 dot 0 + 1 dot 10,
    2 + 1
  )
  =
  frac(
    10,
    3
  )
$

因此：

$
  #boxed[$ x_c = frac(10, 3) $]
$

== 为什么不能只平均位置

如果简单平均位置：

$
  frac(
    0+10,
    2
  )
  =
  5
$

这意味着：

#bquote[两个位置同样重要。]

但实际情况是：

$
  m_1=2
$

而：

$
  m_2=1
$

左边的质量是右边的两倍。

所以左边的位置应该拥有更大的权重。

于是：

$
  x_c
  =
  frac(
    m_1x_1 + m_2x_2,
    m_1+m_2
  )
$

这其实就是加权平均。

---

= 第十四阶段：质心就是“位置的加权平均”

这是最重要的一句话：

$
  #boxed[$ "质心的 x 坐标"
  =
  "所有质量所在 x 位置的质量加权平均" $]
$

一般离散情况：

$
  #boxed[$ x_c
  =
  frac(
    sum_i m_i x_i,
    sum_i m_i
  ) $]
$

现在与普通加权平均比较：

$
  bar(f)
  =
  frac(
    sum_i w_i f_i,
    sum_i w_i
  )
$

只需要做替换：

$
  f_i = x_i
$

$
  w_i = m_i
$

立即得到：

$
  x_c
  =
  frac(
    sum_i m_i x_i,
    sum_i m_i
  )
$

因此：

$
  #boxed[$ "质心"
  =
  "位置的加权平均" $]
$

其中：

$
  #boxed[$ "被平均的量"
  =
  "位置" $]
$

而：

$
  #boxed[$ "权重"
  =
  "质量" $]
$

---

= 第十五阶段：为什么公式里必须出现 $x$

现在回到：

$
  x_c
  =
  frac(
    sum_i m_i x_i,
    sum_i m_i
  )
$

可以从“平均什么”来理解。

如果我们想求平均质量，那么被平均的量应该是：

$
  m_i
$

如果我们想求平均温度，被平均的量应该是：

$
  T_i
$

而现在我们想求：

#bquote[平均位置。]

所以被平均的量必须是：

$
  x_i
$

只是这个位置的重要程度由质量决定，因此还要乘上：

$
  m_i
$

于是：

$
  #boxed[$ x_i m_i
  =
  "位置"
  times
  "该位置上的质量" $]
$

所以公式中的 $x$ 并不是一个额外塞进去的东西。

它是因为：

#bquote[*我们正在平均的是位置。*]

---

= 第十六阶段：一个极其直观的例子

考虑：

$
  x_1=1,
  quad m_1=100
$

以及：

$
  x_2=9,
  quad m_2=1
$

如果只进行普通位置平均：

$
  frac(1+9, 2)=5
$

得到：

$
  x=5
$

但这显然不能代表系统。

因为：

$
  x=1
$

附近有 $100$ 单位质量，而：

$
  x=9
$

附近只有 $1$ 单位质量。

真正的质心是：

$
  x_c
  =
  frac(
    100 dot 1 + 1 dot 9,
    100+1
  )
$

即：

$
  x_c
  =
  frac(109, 101)
  approx 1.079
$

所以：

$
  #boxed[$ x_c approx 1.079 $]
$

质心非常接近拥有大量质量的地方。

这正是“质量加权平均”的直观含义。

---

= 第十七阶段：从离散质心到连续质心

现在不再有有限个小球。

假设我们有一个连续物体。

在位置：

$
  (x,y)
$

取一个极小面积：

$
  dif A
$

假设单位面积上的质量密度为：

$
  rho(x, y)
$

那么这个微小面积块的质量为：

$
  #boxed[$ dif m
  =
  rho(x, y) dif A $]
$

注意这里非常重要：

$
  rho(x, y) dif A
$

就是前面“权重”的连续版本。

也就是说：

#bquote[密度乘微小面积 = 这一小块所拥有的质量。]

---

= 第十八阶段：为什么连续质心中出现 $x rho$

现在我们想求质心的 $x$ 坐标。

刚才已经知道：

#bquote[$x_c$ 是所有质量所在位置的 $x$ 坐标的质量加权平均。]

因此：

$
  x_c
  =
  frac(
    integral x dif m,
    integral dif m
  )
$

而：

$
  dif m
  =
  rho(x, y) dif A
$

于是：

$
  x_c
  =
  frac(
    integral x rho(x, y) dif A,
    integral rho(x, y) dif A
  )
$

在二维区域 $D$ 上：

$
  #boxed[$ x_c
  =
  frac(
    integral_(D)
    x rho(x, y) dif A,
    integral_(D)
    rho(x, y) dif A
  ) $]
$

现在就能彻底解释：

$
  x rho(x, y) dif A
$

分别代表什么：

$
  underbrace(
    x,
    "被平均的量：位置"
  )
  underbrace(
    rho(x, y) dif A,
    "权重：这一小块的质量"
  )
$

因此：

$
  x rho(x, y) dif A
$

就是：

#bquote[这个微小质量块对“位置平均”产生的加权贡献。]

---

= 第十九阶段：为什么 $y_c$ 要乘 $y$

完全同样的思想。

如果我们想求的是：

#bquote[平均的 $y$ 位置。]

那么被平均的量就应该换成：

$
  y
$

所以：

$
  y_c
  =
  frac(
    integral_(D)
    y rho(x, y) dif A,
    integral_(D)
    rho(x, y) dif A
  )
$

即：

$
  #boxed[$ y_c
  =
  frac(
    integral_(D)
    y rho(x, y) dif A,
    integral_(D)
    rho(x, y) dif A
  ) $]
$

因此：

$
  x_c = op("Avg")_m(x)
$

而：

$
  y_c = op("Avg")_m(y)
$

也就是：

#bquote[$x_c$ 是 $x$ 按照质量进行的加权平均。]

#bquote[$y_c$ 是 $y$ 按照质量进行的加权平均。]

---

= 第二十阶段：质心与总质量

连续物体的总质量为：

$
  M
  =
  integral_(D)
  rho(x, y) dif A
$

因此质心公式：

$
  x_c
  =
  frac(
    integral_(D)
    x rho(x, y) dif A,
    M
  )
$

$
  y_c
  =
  frac(
    integral_(D)
    y rho(x, y) dif A,
    M
  )
$

于是可以写成：

$
  #boxed[$ M x_c
  =
  integral_(D)
  x rho(x, y) dif A $]
$

以及：

$
  #boxed[$ M y_c
  =
  integral_(D)
  y rho(x, y) dif A $]
$

这就是为什么会出现所谓的“质量矩”。

---

= 第二十一阶段：为什么叫“质量矩”

定义：

$
  M_x
  =
  integral_(D)
  x rho(x, y) dif A
$

它可以理解成：

#bquote[每一个微小质量 $dif m$ 乘上它的位置 $x$，然后全部加起来。]

因为：

$
  dif m
  =
  rho(x, y) dif A
$

所以：

$
  M_x
  =
  integral_D x dif m
$

离散情况下对应：

$
  M_x
  =
  sum_i x_i m_i
$

于是：

$
  x_c
  =
  frac(M_x, M)
$

也就是说：

$
  #boxed[$ "质心位置"
  =
  frac(
    "关于位置的总质量矩",
    "总质量"
  ) $]
$

这并不是一条新的、神秘的公式。

它仍然来自：

$
  #boxed[$ "平均值"
  =
  frac(
    "加权总量",
    "总权重"
  ) $]
$

---

= 第二十二阶段：质心公式的真正来源

现在把整个推导压缩起来。

我们知道统一的加权平均：

$
  op("Avg")_w(f)
  =
  frac(
    integral f w dif mu,
    integral w dif mu
  )
$

对于质心：

$
  f = x
$

$
  w = rho
$

$
  dif mu = dif A
$

所以：

$
  x_c
  =
  frac(
    integral_D x rho dif A,
    integral_D rho dif A
  )
$

对于 $y$：

$
  f = y
$

于是：

$
  y_c
  =
  frac(
    integral_D y rho dif A,
    integral_D rho dif A
  )
$

所以：

$
  #boxed[$ "质心"
  =
  "把位置坐标当作被平均的量"
  +
  "把质量当作权重" $]
$

---

= 第二十三阶段：与之前的平均值体系完全统一

现在把所有情况排在一起。

#table(
  columns: 4,
  align: left,
  [场景], [被平均的量], [权重 / 微元], [平均结果],

  [离散平均], [$x_i$], [$1$], [$sum_i x_i / sum_i 1$],

  [离散加权], [$x_i$], [$w_i$], [$sum_i x_i w_i / sum_i w_i$],

  [连续一维], [$f(x)$], [$dif x$], [$integral f dif x / integral dif x$],

  [连续加权], [$f(x)$], [$w(x) dif x$], [$integral f w dif x / integral w dif x$],

  [二维区域], [$f(x,y)$], [$dif A$], [$integral integral f dif A / integral integral dif A$],

  [二维加权], [$f(x,y)$], [$w(x,y) dif A$], [$integral integral f w dif A / integral integral w dif A$],

  [曲线平均], [$f$], [$dif s$], [$integral_C f dif s / integral_C dif s$],

  [质心 $x_c$], [$x$], [$rho dif A$], [$integral_D x rho dif A / integral_D rho dif A$],

  [质心 $y_c$], [$y$], [$rho dif A$], [$integral_D y rho dif A / integral_D rho dif A$],
)

这里最值得观察的是：

质心公式看起来和普通二重积分平均值不同，但它其实只是把：

$
  f(x,y)
$

换成：

$
  x
$

或者：

$
  y
$

再把权重换成：

$
  rho(x, y)
$

而已。

---

= 第二十四阶段：一张统一的心智模型

以后看到任何“平均值”问题，都可以问三个问题。

== 问题一：我在平均什么？

可能是：

$
  x
$

$
  y
$

$
  f(x)
$

$
  T(x,y)
$

等等。

这就是：

$
  #boxed[$ "被平均的量" $]
$

== 问题二：我要按照什么来“数”？

可能是：

$
  1
$

$
  w_i
$

$
  dif x
$

$
  dif A
$

$
  dif s
$

$
  rho(x, y) dif A
$

这就是：

$
  #boxed[$ "权重 / 微小份量" $]
$

== 问题三：全部份量是多少？

计算：

$
  integral_S w dif mu
$

于是：

$
  #boxed[$ "平均值"
  =
  frac(
    "加权总量",
    "总权重"
  ) $]
$

---

= 第二十五阶段：整条知识链

可以把整个思想链记成：

$
  "离散平均"
  arrow
  "离散加权平均"
  arrow
  "连续平均"
  arrow
  "连续加权平均"
  arrow
  "二维平均"
  arrow
  "线积分平均"
  arrow
  "质心"
$

但从本质上说，并不是学了一堆互不相关的公式。

而是：

$
  #boxed[$ "同一个平均思想"
  +
  "不同的空间"
  +
  "不同的微小份量"
  +
  "不同的权重" $]
$

---

= 第二十六阶段：最核心的统一公式

整个体系可以最后压缩为：

$
  #boxed[$ op("Avg")_w(f)
  =
  frac(
    integral_S f w dif mu,
    integral_S w dif mu
  ) $]
$

其中：

- $S$：我们正在平均的空间；
- $f$：我们想平均的量；
- $w$：不同位置的重要程度；
- $d mu$：空间中的微小份量。

因此：

$
  dif mu
$

可以是：

$
  1,
  dif x,
  dif A,
  dif V,
  dif s
$

等等。

== 质心只是这个公式的一种特殊情况

对于质心：

$
  f = x,
  quad
  w = rho,
  quad
  dif mu = dif A
$

因此：

$
  #boxed[$ x_c
  =
  frac(
    integral_D x rho dif A,
    integral_D rho dif A
  ) $]
$

对于 $y$：

$
  #boxed[$ y_c
  =
  frac(
    integral_D y rho dif A,
    integral_D rho dif A
  ) $]
$

所以最后真正值得记住的是：

$
  #boxed[$ "质心不是一个新的数学概念。" $]
$

$
  #boxed[$ "质心就是位置坐标的质量加权平均。" $]
$

进一步：

$
  #boxed[$ "x_c = Avg_m(x)"
  quad
  "y_c = Avg_m(y)" $]
$

这就把“平均值 → 加权平均 → 连续平均 → 二重积分 → 线积分 → 质心”全部统一到了同一个框架中。

= 总结

最值得牢牢记住的不是某一个公式，而是下面四句话：

$
  #boxed[$ "平均值"
  =
  frac(
    "总量",
    "总份量"
  ) $]
$

$
  #boxed[$ "加权平均"
  =
  frac(
    "加权总量",
    "总权重"
  ) $]
$

$
  #boxed[$ "积分"
  =
  "把连续空间中的微小贡献全部加起来" $]
$

$
  #boxed[$ "质心"
  =
  "位置坐标的质量加权平均" $]
$

因此看到：

$
  x rho(x, y) dif A
$

时，应该直接读成：

$
  underbrace(
    x,
    "我想平均的位置"
  )
  times
  underbrace(
    rho(x, y) dif A,
    "这一小块所拥有的质量"
  )
$

而不是把它看成一个需要死记的“质心公式”。

---

= 附：读者批注（2026-09-16）

*读者的自主解释*（原文，含就地自注）：

#bquote[
  每一个位置点 $x$（*贡献*），都对应有一个质量 $dif m$（*数量*），这可以抽象地翻译为“贡献 $times$ 数量（$dif m$）”，所以总的贡献是求和，总的数量是 $dif m$ 的积分。

  补注：$dif m = rho dif A$，其中 $rho$（*权重，即重复次数*）。
]

*读者自注的命名与数学身份*：

#booktabs-table(
  columns: (1.9fr, 2.2fr, 2.7fr),
  [读者命名],
  [记号],
  [数学含义],
  [*贡献*],
  [$x$],
  [该点的位置——被平均的量],
  [*数量*],
  [$dif m = rho dif A$],
  [该点的份量（该块被数到的总次数）],
  [*权重（重复次数）*],
  [$rho$],
  [每单位面积被数的次数（次数密度）],
  [贡献 $times$ 数量],
  [$x dot dif m$],
  [分子的一项（位置 $times$ 份量）],
  [总贡献],
  [$integral x dif m$],
  [分子],
  [总数量],
  [$integral dif m = M$],
  [分母（总质量）],
)

于是：

$ x_c = (integral x dif m)/(integral dif m) = (integral_D x rho dif A)/(integral_D rho dif A) $

*与加权平均领悟（问题 99）的完全一致*——三个场景是同一个框架：

#booktabs-table(
  columns: (1.7fr, 1.7fr, 1.7fr, 1.7fr, 1.9fr),
  [场景],
  [被平均的量],
  [权重],
  [贡献],
  [总份量],
  [无权平均],
  [$f$],
  [$dif A$],
  [$f dif A$],
  [$integral dif A$],
  [加权平均],
  [$f$],
  [$w dif A$],
  [$f w dif A$],
  [$integral w dif A$],
  [质心],
  [$x$],
  [$dif m$],
  [$x dot dif m$],
  [$integral dif m = M$],
)

*一个值得点出的洞察（$dif m$ 的角色切换）*：在“求平均质量”的问题里，$dif m$ 是*被平均的量*；在“求质心”的问题里，$dif m$ 变成了*权重*——*同一个 $dif m$，换一个问题就换一个角色*。这正是“质心 $=$ 位置的加权平均”的全部含义。

*数值复核*：离散（$x_1 = 1, m_1 = 100$；$x_2 = 9, m_2 = 1$）：$Sigma x dot dif m slash Sigma dif m = 109 slash 101 approx 1.079208$；连续（$rho = x$ 在 $[0, 1]$）：$x_c = (1 slash 3) slash (1 slash 2) = 0.666667$（网格复核 $0.666667$ ✓）。
