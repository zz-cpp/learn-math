#set document(
  title: "线积分、保守场与旋度：从 dx、dy 到单位面积环量",
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

= 线积分、保守场与旋度

== 本笔记要解决的问题

这份笔记把以下几个容易分开的知识点放到同一条主线上：

- 为什么 $d bold(r) = (d x, d y)$；
- $integral_C f d x$、$integral_C f d y$、$integral_C f d s$ 分别在累计什么；
- 为什么 Work Integral 可以写成 $integral_C bold(F) dot d bold(r)$；
- 为什么点积具有“投影 × 长度”的几何意义；
- Conservative Field 到底意味着什么；
- 为什么 Curl 可以理解成单位面积上的环量；
- 为什么推导 Curl 时会出现 $N_x-M_y$；
- 为什么材料中的差商是“动点减动点”，却仍然能够得到导数；
- 为什么每一条小边上可以把 $bold(F)$ 近似成常数，但不同边上的近似值又不一样。

整份笔记的核心思想是：

$ 
  d bold(r) = (d x, d y)
$

以及：

$
  bold(F) dot d bold(r) = M d x + N d y
$
$

最终，旋度的推导来自一个极小矩形上的闭合线积分：

$
  curl bold(F)
  =
  lim_(Delta A -> 0)
  frac(
    ∮_C bold(F) dot d bold(r),
    Delta A
  )
$

这里真正要理解的不是“背出 $N_x-M_y$”，而是：

> 一个极小区域周围的环量，在单位面积意义下有多大？

= 第一部分：先把线积分的 $d x$、$d y$、$d s$ 搞清楚

== 微小位移是什么

假设我们沿着曲线移动。

从一个点：

$
  (x,y)
$

移动到相邻的点：

$
  (x+d x, y+d y)
$
$

那么这一步真正发生的位移向量是：

$
  d bold(r) = (d x, d y)
$
$

所以：

- $d x$ 是水平位移；
- $d y$ 是竖直位移；
- $d bold(r)$ 是完整的二维微小位移。

== $d s$ 是什么

$d s$ 表示这一步真实走过的微小弧长。

由勾股关系：

$
  d s = sqrt((d x)^2 + (d y)^2)
$
$

因此：

$
  d x,d y
$

是位移的两个坐标分量，而：

$
  d s
$

是位移的长度。

换句话说：

$
  d x = "水平变化"
$
$

$
  d y = "竖直变化"
$
$

$
  d s = "实际走过的距离"
$
$

== 为什么 $d x$ 不是距离

如果你沿着一条很弯曲的曲线从 $A$ 走到 $B$，即使实际走了很长一段路，
只要终点与起点的 $x$ 坐标差为 $5$，就有：

$
  integral_C d x = x_B - x_A = 5
$
$

因此：

$
  d x != d s
$
$

$d x$ 可以为正，也可以为负；而 $d s >= 0$。

同理：

$
  integral_C d y = y_B-y_A
$
$

只要起点与终点固定，$integral_C d x$ 与 $integral_C d y$ 就不依赖于中间走什么路径。

== 三种线积分是在按照三种不同的“尺度”累计

$
  integral_C f d s
$
$

表示按照实际弧长累计。

$
  integral_C f d x
$
$

表示按照水平位移累计。

$
  integral_C f d y
$
$

表示按照竖直位移累计。

因此不要把它们都看成“积分符号后面换了一个字母”。

真正的区别在于：

$
  
    "differential"
    =
    "你到底按照什么来累计"
  
$

= 第二部分：Work Integral 为什么是 $P d x + Q d y$

== 向量场与位移

设二维向量场：

$
  bold(F)(x,y) = (P(x,y),Q(x,y))
$

而微小位移：

$
  d bold(r)=(d x,d y)
$
$

做功的微小贡献是点积：

$
  d W = bold(F) dot d bold(r)
$
$

因此：

$
  d W
  =
  (P,Q) dot (d x,d y)
  =
  P d x + Q d y
$
$

沿整条路径：

$
  W = integral_C bold(F) dot d bold(r) = integral_C P d x + integral_C Q d y
$

== 为什么恰好是 $P d x + Q d y$

$P$ 是水平力分量，$Q$ 是竖直力分量。

$d x$ 是水平位移，$d y$ 是竖直位移。

所以：

$
  P d x
$

表示水平力对水平位移产生的功，而：

$
  Q d y
$

表示竖直力对竖直位移产生的功。

因此：

$
  
    d W
    =
    "水平方向做功"
    +
    "竖直方向做功"
  
$

这不是人为规定，而是：

$
  bold(F) dot d bold(r)
$

在二维坐标中的展开。

= 第三部分：点积为什么和投影有关

== 点积的几何公式

设两个向量 $bold(a)$ 与 $bold(b)$ 夹角为 $theta$。

点积满足：

$
  bold(a) dot bold(b) = |bold(a)| |bold(b)| cos theta
$

这里 $|bold(a)| cos theta$ 正是 $bold(a)$ 在 $bold(b)$ 方向上的有符号投影长度。

因此：

$
  bold(a) dot bold(b) = "a 在 b 方向的投影" times |bold(b)|
$

也可以反过来理解：

$
  bold(a) dot bold(b)
  =
  |bold(a)|
  times
  "b 在 a 方向的有符号投影"
$

== 为什么会出现 $cos theta$

把 $bold(a)$ 投影到 $bold(b)$ 的方向上，会形成直角三角形。

由：

$
  cos theta
  =
  frac("邻边", "斜边")
$

得到：

$
  "投影长度"
  =
  |bold(a)| cos theta
$

所以：

$
  bold(a) dot bold(b)
  =
  |bold(a)| cos theta |bold(b)|
$

这就说明点积实际上会“筛选”某个方向上的分量。

== 点积会消掉垂直分量

把 $bold(a)$ 分解成：

$
  bold(a)=bold(a)_parallel+bold(a)_perp
$

那么：

$
  bold(a) dot bold(b)
  =
  bold(a)_parallel dot bold(b)
  +
  bold(a)_perp dot bold(b)
$

因为 $bold(a)_perp$ 与 $bold(b)$ 垂直：

$
  bold(a)_perp dot bold(b)=0
$

所以：

$
  bold(a) dot bold(b) = bold(a)_parallel dot bold(b)
$

也就是说，点积自动忽略了垂直于另一个向量的部分。

== 与 Work Integral 的直接联系

对于做功：

$
  d W
  =
  bold(F) dot d bold(r)
$

设 $theta$ 是力与运动方向的夹角。

于是：

$
  d W
  =
  |bold(F)| |d bold(r)| cos theta
$

而：

$
  |d bold(r)|=d s
$

因此：

$
  d W = |bold(F)| cos theta d s
$

其中：

$
  |bold(F)| cos theta
$

正是力在运动方向上的有符号投影。

因此：

$
  W = integral_C F_parallel d s
$

这就是做功与点积几何意义之间的直接联系。

= 第四部分：Conservative Field 的核心性质

== 路径无关

若向量场 $bold(F)$ 是 conservative，则从 $A$ 到 $B$ 的线积分只依赖起点和终点，而与具体路径无关：

$
  
    integral_(C_1) bold(F) dot d bold(r)
    =
    integral_(C_2) bold(F) dot d bold(r)
  
$

这里要求两条路径具有相同的起点和终点，并且方向一致。

因此：

$
  "Conservative" => "Path Independent"
$

== 闭合路径积分为零

如果一条路径从 $A$ 出发，最后又回到 $A$，那么对于 conservative field：

$
  
    ∮_C bold(F) dot d bold(r)=0
  
$

因为做功只由起点和终点决定，而起点和终点相同。

反过来，如果任意闭合路径的积分都为零，就可以得到路径无关性。

因此可以把它们视为同一个结构的不同表达：

$
  "Path Independent" <=> "Closed-loop integral = 0"
$

== 存在势函数

如果存在标量函数 $f(x,y)$，使得：

$
  bold(F)=nabla f
$

那么：

$
  bold(F)=(f_x,f_y)
$

从而：

$
  bold(F) dot d bold(r)
  =
  f_x d x+f_y d y
$

而全微分：

$
  d f=f_x d x+f_y d y
$

所以：

$
  bold(F) dot d bold(r) = d f
$

沿曲线积分：

$
  integral_C bold(F) dot d bold(r)
  =
  integral_C d f
  =
  f(B)-f(A)
$

因为最终结果不含路径，所以得到路径无关性。

== 与偏导数判据的关系

若：

$
  bold(F)=(P,Q)
$

并且：

$
  P=f_x,
  quad Q=f_y
$

在足够光滑的条件下：

$
  P_y=f_(xy)
  
  Q_x=f_(yx)
$
$

从而：

$
  P_y = Q_x
$

这是常见的 conservative field 判据，但需要结合适当的定义域条件；不能脱离定义域无条件地使用。

= 第五部分：什么是环量 Circulation

== 环量的直观意义

对于闭合曲线 $C$：

$
  ∮_C bold(F) dot d bold(r)
$

可以理解成：

> 沿着这个闭合小圈走一圈，向量场在运动方向上的推动作用全部加起来。

如果结果很大，说明场沿着这个方向存在明显的“绕圈推动”趋势。

如果结果是零，则这个闭合路径上的正负贡献可能完全抵消。

== 为什么要除以面积

单纯的环量会受到所选闭合区域大小的影响。

因此材料把旋度理解为：

$
  "单位面积上的环量" = frac(∮_C bold(F) dot d bold(r), "Area(C)")
$

为了得到一个“局部量”，让围起来的面积不断缩小到零。

于是研究的是：

$
  
    curl bold(F)(x_0,y_0)
    =
    lim_(Delta A -> 0)
    frac(
      ∮_C bold(F) dot d bold(r),
      Delta A
    )
  
$

材料把这个结构与一维导数类比：

$
  f'(x_0)
  =
  lim_(Delta x -> 0)
  frac(
    f(x_0+Delta x)-f(x_0),
    Delta x
  )
$

一维是在计算“函数值的局部变化率”，而 curl 在计算“环量的局部密度”。

= 第六部分：材料中的小矩形设置

== 选择极小矩形

设小矩形中心为：

$
  (x_0,y_0)
$

横向长度：

$
  Delta x
$

纵向长度：

$
  Delta y
$

因此面积：

$
  Delta A = Delta x Delta y
$

取逆时针方向：

```text
             C3: 向左
          ←──────────
          │          │
C4: 向下  ↓          ↑  C2: 向上
          │          │
          ──────────→
             C1: 向右
```

材料把四条边写成 $C_1+C_2+C_3+C_4$，并假设 $Delta x$ 与 $Delta y$ 很小。每一条小边上的向量场可以用该边中点处的值进行近似。资料中的推导正是按照这个结构展开的。

== 一个关键问题：每条边上的 $bold(F)$ 是常数吗？

不是在整个平面上恒定。

更准确的说法是：

$
  "在每一条极小的边上，bold(F) 可以近似看作常量"
$

但是四条边的近似常值一般不同。

因此：

$
  bold(F)_(bottom)
  !=
  bold(F)_(top)
$

一般也有：

$
  bold(F)_(left)
  !=
  bold(F)_(right)
$

而 curl 恰恰就是由这些不同边之间的微小差异产生的。

=== 为什么“边内近似常数”不会把 Curl 消掉

如果整个矩形四条边上的场都完全一样，那么绕一圈时正向和反向的贡献会全部抵消：

```text
→ → → →
↑     ↑
↑     ↑
← ← ← ←
```

这时：

$
  ∮_C bold(F) dot d bold(r)=0
$

真正产生 curl 的，是：

> 同一条极小边内部的变化很小，可以近似忽略；但不同边之间仍然存在一阶的小差异。

这个“一阶差异”最终留下来的就是偏导数。

= 第七部分：逐条计算四条边

== 写成 $bold(F)=(M,N)$

材料使用：

$
  bold(F) = (M,N)
$

因此：

$
  bold(F) dot d bold(r)=M d x+N d y
$

这是后面四条边计算的起点。材料给出的四段近似式与这一分解一致。

== 第一条边：下边 $C_1$

下边水平，因此：

$
  d y=0
$

所以：

$
  M d x+N d y=M d x
$

下边中点：

$
  (x_0,y_0-Delta y/2)
$

又因为下边向右：

$
  integral_(C_1) bold(F) dot d bold(r)
  approx
  M(x_0,y_0-Delta y/2) Delta x
$

== 第二条边：右边 $C_2$

右边竖直，因此：

$
  d x=0
$

所以：

$
  M d x+N d y=N d y
$

右边中点：

$
  (x_0+Delta x/2,y_0)
$

右边向上，因此：

$
  integral_(C_2) bold(F) dot d bold(r)
  approx
  N(x_0+Delta x/2,y_0) Delta y
$

== 第三条边：上边 $C_3$

上边也是水平边：

$
  d y=0
$

因此仍然只有：

$
  M d x
$

但现在运动方向向左，因此：

$
  d x<0
$

上边中点：

$
  (x_0,y_0+Delta y/2)
$

所以：

$
  integral_(C_3) bold(F) dot d bold(r)
  approx
  -M(x_0,y_0+Delta y/2) Delta x
$

这里的负号来自运动方向，而不是来自导数定义。

== 第四条边：左边 $C_4$

左边竖直：

$
  d x=0
$

因此只有：

$
  N d y
$

左边向下，所以：

$
  d y<0
$

左边中点：

$
  (x_0-Delta x/2,y_0)
$

因此：

$
  integral_(C_4) bold(F) dot d bold(r)
  approx
  -N(x_0-Delta x/2,y_0) Delta y
$

== 四条边相加

把四条边相加：

$
  ∮_C bold(F) dot d bold(r)
  approx
$
  
  [
    M(x_0,y_0-Delta y/2)
    -
    M(x_0,y_0+Delta y/2)
  ]Delta x
$

$
  +
  [
    N(x_0+Delta x/2,y_0)
    -
    N(x_0-Delta x/2,y_0)
  ]Delta y
$

材料给出的四段求和与这个结构一致。

= 第八部分：用户发现的关键问题——“这里不是动点减动点吗？”

== 普通导数的形式

我们熟悉：

$
  f'(x_0)
  =
  lim_(h -> 0)
  frac(
    f(x_0+h)-f(x_0),
    h
  )
$

看起来是：

$
  "动点" - "静点"
$

所以材料中的：

$
  frac(
    M(x_0,y_0+Delta y/2)
    -
    M(x_0,y_0-Delta y/2),
    Delta y
  )
$

确实不是这种最熟悉的形式。

这个观察是正确的。

关键在于：

> 材料这里使用的是中心差分（central difference），而不是最常见的前向差分。

== 把二维问题暂时变成一维问题

固定 $x=x_0$，定义：

$
  g(y)=M(x_0,y)
$

那么材料中的差商变成：

$
  frac(
    g(y_0+Delta y/2)-g(y_0-Delta y/2),
    Delta y
  )
$

现在它的意义很清楚：

> 它比较中心点两侧两个位置之间的平均变化率。

== 中心差分可以拆成两个普通差商

令 $h=Delta y$。

先在分子中插入 $g(y_0)$：

$
  g(y_0+h/2)-g(y_0-h/2)
$

等于：

$
  [g(y_0+h/2)-g(y_0)]
  +
  [g(y_0)-g(y_0-h/2)]
$

因此：

$
  frac(
    g(y_0+h/2)-g(y_0-h/2),
    h
  )
$

可以写成：

$
  frac12
  frac(
    g(y_0+h/2)-g(y_0),
    h/2
  )
  +
  frac12
  frac(
    g(y_0)-g(y_0-h/2),
    h/2
  )
$

现在两个差商都已经是我们熟悉的形式。

当 $h -> 0$ 时：

$
  frac(
    g(y_0+h/2)-g(y_0),
    h/2
  )
  -> g'(y_0)
$

以及：

$
  frac(
    g(y_0)-g(y_0-h/2),
    h/2
  )
  -> g'(y_0)
$

于是：

$
  
    lim_(h -> 0)
    frac(
      g(y_0+h/2)-g(y_0-h/2),
      h
    )
    =g'(y_0)
  
$

所以：“两个动点”并不违反导数的思想。

真正重要的是：

> 两个取值点之间的距离趋于零，而且两点最终都趋向同一个目标点。

=== 一句话理解中心差分

普通前向差分：

$
  frac(f(x+h)-f(x),h)
$

是“后一点减当前点”。

中心差分：

$
  frac(f(x+h/2)-f(x-h/2),h)
$

是“右边一点减左边一点”。

两者在 $h -> 0$ 时都测量同一个局部斜率。

= 第九部分：为什么材料中的 $M$ 最后会给出 $-M_y$

== 中心差分本身给出 $M_y$

先看：

$
  frac(
    M(x_0,y_0+Delta y/2)
    -
    M(x_0,y_0-Delta y/2),
    Delta y
  )
  ->
  M_y(x_0,y_0)
$

这是标准的中心差分极限。

但是线积分里实际出现的是反过来的顺序：

$
  M(x_0,y_0-Delta y/2)
  -
  M(x_0,y_0+Delta y/2)
$

所以：

$
  frac(
    M(x_0,y_0-Delta y/2)
    -
    M(x_0,y_0+Delta y/2),
    Delta y
  )
  ->
  -M_y
$

因此：

$
  "负号来自逆时针绕行时，上边向左"
$

而不是导数定义带来的负号。

== 这一区分一定要记住

中心差分：

$
  "上"-"下"
  ->
  M_y
$

线积分需要的组合：

$
  "下"-"上"
  ->
  -M_y
$

所以推导中同时存在：

- 微积分的局部变化率；
- 几何绕行方向造成的符号。

不要把这两个来源混在一起。

= 第十部分：为什么 $N_x$ 来自左右两边

== 左右两边比较的是 $N$

左右边是竖直边，因此：

$
  d x=0
$

只保留：

$
  N d y
$

右边的 $x$ 坐标是：

$
  x_0+Delta x/2
$

左边的 $x$ 坐标是：

$
  x_0-Delta x/2
$

因此出现：

$
  N(x_0+Delta x/2,y_0)
  -
  N(x_0-Delta x/2,y_0)
$

除以 $Delta x$：

$
  frac(
    N(x_0+Delta x/2,y_0)
    -
    N(x_0-Delta x/2,y_0),
    Delta x
  )
  ->
  N_x
$

于是：

$
  
    "左右边贡献"
    ->
    N_x
  
$

== 为什么是“交叉偏导”

注意：

$M$ 是水平分量，但我们观察的是它随 $y$ 的变化：

$
  M_y
$

$N$ 是竖直分量，但我们观察的是它随 $x$ 的变化：

$
  N_x
$

因此 curl 研究的是：

$
  "水平分量的竖直变化" "与" "竖直分量的水平变化"
$

这就是为什么最后不是 $M_x+N_y$，而是：

$
  curl bold(F)=N_x-M_y
$

= 第十一部分：用泰勒展开看清楚“为什么差商会出来”

== 上下两点的局部展开

考虑：

$
  M(x,y+Delta y/2)
$

因为 $Delta y$ 很小，可以在 $(x,y)$ 附近线性化：

$
  M(x,y+Delta y/2)
  approx
  M(x,y)
  +
  M_y(x,y) Delta y/2
$

同样：

$
  M(x,y-Delta y/2)
  approx
  M(x,y)
  -
  M_y(x,y) Delta y/2
$

相减：

$
  M(x,y+Delta y/2)
  -
  M(x,y-Delta y/2)
  approx
  M_y Delta y
$

所以：

$
  frac(
    M(x,y+Delta y/2)-M(x,y-Delta y/2),
    Delta y
  )
  approx
  M_y
$

== 为什么中间的 $M(x,y)$ 消失了

上下两侧都有同一个零阶项：

$
  M(x,y)
$

相减时自动消掉。

真正留下的是一阶变化：

$
  M_y Delta y
$

因此，这个推导的深层思想是：

$
  
    "比较对边"
    ->
    "消掉共同的常数部分"
    ->
    "留下局部一阶变化"
  
$

这就是局部线性化。

== 左右两边完全类似

对于 $N$：

$
  N(x+Delta x/2,y)
  approx
  N(x,y)+N_x Delta x/2
$

$
  N(x-Delta x/2,y)
  approx
  N(x,y)-N_x Delta x/2
$

相减后：

$
  N(x+Delta x/2,y)-N(x-Delta x/2,y)
  approx
  N_x Delta x
$

因此：

$
  "左右两边" -> N_x
$

= 第十二部分：把四条边完整地合起来

== 环量近似

由前面的四条边：

$
  ∮_C bold(F) dot d bold(r)
  approx
  
  [
    M(x_0,y_0-Delta y/2)
    -
    M(x_0,y_0+Delta y/2)
  ] Delta x
$

$
  +
  [
    N(x_0+Delta x/2,y_0)
    -
    N(x_0-Delta x/2,y_0)
  ] Delta y
$

利用中心差分：

$
  M(x_0,y_0-Delta y/2)
  -
  M(x_0,y_0+Delta y/2)
  approx
  -M_y Delta y
$

以及：

$
  N(x_0+Delta x/2,y_0)
  -
  N(x_0-Delta x/2,y_0)
  approx
  N_x Delta x
$

代入：

$
  ∮_C bold(F) dot d bold(r)
  approx
  (-M_y Delta y) Delta x
  +
  (N_x Delta x) Delta y
$

所以：

$
  
    ∮_C bold(F) dot d bold(r)
    approx
    (N_x-M_y) Delta x Delta y
  
$

由于：

$
  Delta A=Delta x Delta y
$

所以：

$
  
    ∮_C bold(F) dot d bold(r)
    approx
    (N_x-M_y)Delta A
  
$

材料给出的 Step 1 就是在得到这个形式。

= 第十三部分：除以面积，Curl 自然出现

== 单位面积环量

把：

$
  ∮_C bold(F) dot d bold(r)
  approx
  (N_x-M_y)Delta A
$

除以：

$
  Delta A
$

得到：

$
  frac(
    ∮_C bold(F) dot d bold(r),
    Delta A
  )
  approx
  N_x-M_y
$

然后让：

$
  Delta x,Delta y -> 0
$

就得到：

$
  
    curl bold(F)(x_0,y_0)
    =
    lim_(Delta A -> 0)
    frac(
      ∮_C bold(F) dot d bold(r),
      Delta A
    )
    =
    N_x-M_y
  
$

这正是材料的 Step 2：先除以面积，再把面积缩到零。

== Curl 的三个视角

材料最后把 Curl 的三个身份放在一起。

=== 代数视角

$
  curl bold(F)=N_x-M_y
$

这是最方便计算的形式。

=== 几何视角

$
  
    curl bold(F)
    =
    "单位面积上的环量的极限"
  
$

也就是：

$
  "局部环量密度"
$

=== 物理视角

如果 $bold(F)$ 被理解成速度场或某种旋转场，那么 Curl 可以用来描述局部的旋转趋势。

例如单位速率旋转场的典型结果是：

$
  curl bold(F)=2
$

材料使用这个结果作为物理视角。

= 第十四部分：两个重要例子

== 例子一：常数向量场

假设：

$
  bold(F)=(3,4)
$

那么：

$
  M=3,
  quad N=4
$

因此：

$
  M_y=0,
  quad N_x=0
$

所以：

$
  curl bold(F)=0
$

直觉上，这是一个整个平面都完全相同的推动场：

```text
→ → → → →
→ → → → →
→ → → → →
```

它可以推动物体运动，但没有局部的“绕圈不平衡”。

== 例子二：旋转场

考虑：

$
  bold(F)(x,y)=(-y,x)
$

于是：

$
  M=-y,
  quad N=x
$
$

因此：

$
  M_y=-1,
  quad N_x=1
$

所以：

$
  curl bold(F)=1-(-1)=2
$

这个场在不同位置持续产生绕圈趋势，因此一个极小闭合回路的环量不会完全抵消。

= 第十五部分：重新理解“每条边近似常数”的问题

== 为什么这不是把微分信息丢掉

这个推导采用的是一种典型的局部近似：

$
  "在单条极小边内"
  ->
  "变化很小"
  ->
  "用中点值代表"
$

但我们同时保留：

$
  "不同边之间"
  ->
  "存在一阶的小差异"
$

所以：

$
  "边内忽略变化" + "边间保留差异" = "提取一阶导数"
$

如果把整个矩形里的场都当成同一个常数，那么当然得不到 Curl；
真正的推导只是在每一条足够短的边上做近似。

== 从“场的值”转向“场的变化”

下边和上边的区别：

$
  M_(bottom)-M_(top)
$

告诉我们：

> 水平分量 $M$ 在竖直方向上到底发生了多少变化。

右边和左边的区别：

$
  N_(right)-N_(left)
$

告诉我们：

> 竖直分量 $N$ 在水平方向上到底发生了多少变化。

最后：

$
  curl bold(F)=N_x-M_y
$

就是这两个局部变化的带方向组合。

= 第十六部分：最重要的统一心智模型

== 从 $d x,d y,d s$ 到 Curl

先记住：

$
  d bold(r)=(d x,d y)
$

然后：

$
  
    bold(F) dot d bold(r)
    =
    M d x+N d y
  
$

闭合曲线积分：

$
  
    ∮_C bold(F) dot d bold(r)
    =
    "一圈的总环量"
  
$

除以极小区域面积：

$
  frac(∮_C bold(F) dot d bold(r), Delta A) = "单位面积环量"
$

令面积趋近于零：

$
  curl bold(F) = "一个点处的局部环量密度"
$

而实际计算时：

$
  "上下边" -> -M_y
$

$
  "左右边" -> N_x
$

最终：

$
  curl bold(F)=N_x-M_y
$

== 看到公式时应该想到什么

以后看到：

$
  N_x-M_y
$

不要第一反应只是背公式。

应该在脑中出现这个画面：

```text
                   上边 ←
              ┌────────────┐
              │            │
左边 ↓        │     •      │        ↑ 右边
              │            │
              └────────────┘
                   下边 →
```

然后想：

- 上、下两边比较的是 $M$；
- 左、右两边比较的是 $N$；
- 上下差产生 $-M_y$；
- 左右差产生 $N_x$；
- 两者相加得到局部环量密度。

= 第十七部分：与 Conservative Field 的连接

== Curl 为零与保守场

对于：

$
  bold(F)=(P,Q)
$

Curl 在二维记号下为：

$
  curl bold(F)=Q_x-P_y
$

如果：

$
  curl bold(F)=0
$

那么：

$
  Q_x=P_y
$

在适当的定义域条件下，这与 Conservative Field 的常见偏导数判据连接起来。

因此可以把两章知识连起来：

$
  "curl = 0" -> "闭合环量倾向消失" -> "在适当条件下与 conservative field 联系"
$

但要特别注意：仅仅看到 $Q_x=P_y$，不能脱离定义域条件就机械地断言一定 conservative。

= 第十八部分：最容易混淆的几个问题

== 问题 1：每条边上的 $bold(F)$ 是不是完全相同？

不是。

正确理解：

$
  "每一条极小边上近似常数，但不同边的近似常数一般不同。"
$

== 问题 2：中心差分为什么也是导数？

因为：

$
  lim_(h -> 0)
  frac(f(x+h/2)-f(x-h/2),h)
  =
  f'(x)
$

两个点虽然都在移动，但它们同时趋向同一个中心点。

== 问题 3：为什么上下边给出负号？

不是因为导数公式有负号，而是因为逆时针路径在上边向左走，因此：

$
  d x<0
$

于是得到：

$
  -M_y
$
$

== 问题 4：为什么不是 $M_x+N_y$？

因为 Curl 不是在问：

> 每个分量沿自己的方向变化多少？

而是在问：

> 相对的两条边之间，沿闭合方向的推动贡献差了多少？

因此天然出现交叉变化：

$
  M_y,
  quad N_x
$

= 第十九部分：最终总结

== 你真正需要记住的四层结构

=== 第一层：位移

$
  d bold(r)=(d x,d y)
$

=== 第二层：做功

$
  
    d W
    =
    bold(F) dot d bold(r)
    =
    P d x+Q d y
  
$

=== 第三层：环量

$
  
    ∮_C bold(F) dot d bold(r)
  
$

表示围绕闭合曲线走一圈的总环量。

=== 第四层：旋度

$
  
    curl bold(F)
    =
    lim_(Delta A -> 0)
    frac(
      ∮_C bold(F) dot d bold(r),
      Delta A
    )
    =
    N_x-M_y
  
$

这就是整个材料的主线。

== 最终的一句话

> Curl 不是凭空定义出来的 $N_x-M_y$。
>
> 我们先围绕一个极小矩形计算 Work Integral，把四条边的贡献相加；由于对边方向相反，零阶的共同部分抵消，只留下不同边之间的一阶变化；上下边留下 $-M_y$，左右边留下 $N_x$。再除以面积并令面积趋于零，就得到局部环量密度：$curl bold(F)=N_x-M_y$。

因此整个推导可以压缩成：

$
  "四条边的线积分" -> "对边差异" -> "中心差分" -> "偏导数" -> "单位面积环量" -> "Curl"
$

这条链比单独背公式更重要。
