// ═══════════════════════════════════════════════════════════════
// math-answer-note · 按日归档问答记录
// 结构：每个独立问题 = 一个一级标题（=），子问题用（== / ===）
// 轨道：待定（按当日首条问答判断：数学轨 / CS 轨）
// 规范：math-answer-note 新版（无 practicebox/无 dia-scale；三色判断框
//       + titledbox + subfigure/plotline/unnumbered；公式编号全局关闭）
// ═══════════════════════════════════════════════════════════════
#import "@preview/ilm:2.1.1": *
#import "@preview/cetz:0.5.2"
#import "@preview/fletcher:0.5.8" as fletcher: diagram, edge, node
#import "@preview/cetz-plot:0.1.4": chart, plot

// ═══ 判断框体系（与课程笔记同构）═══
#let importantbox(body) = block(
  width: 100%,
  breakable: true,
  fill: rgb("#eef3fb"),
  stroke: (left: 3pt + rgb("#2f6fd0")),
  inset: (x: 11pt, y: 8pt),
  radius: 4pt,
)[*📌 核心要点*  #body]

#let knowledgebox(body) = block(
  width: 100%,
  breakable: true,
  fill: rgb("#eefaf1"),
  stroke: (left: 3pt + rgb("#2e9e5b")),
  inset: (x: 11pt, y: 8pt),
  radius: 4pt,
)[*💡 背景与类比*  #body]

#let warningbox(body) = block(
  width: 100%,
  breakable: true,
  fill: rgb("#fdf1ef"),
  stroke: (left: 3pt + rgb("#d64541")),
  inset: (x: 11pt, y: 8pt),
  radius: 4pt,
)[*⚠️ 陷阱预警*  #body]

// ═══ 标题栏框（tcolorbox attach 标题栏近似）═══
#let titledbox(
  title,
  body,
  bg: rgb("#eefaf1"),
  title-bg: rgb("#2e9e5b"),
  title-fg: white,
  stroke: 1pt + luma(70),
) = block(
  width: 100%,
  breakable: true,
  radius: 0pt,
  fill: bg,
  stroke: stroke,
  inset: 0pt,
)[
  #block(width: 100%, fill: title-bg, inset: (x: 8pt, y: 3pt), radius: 0pt)[
    #text(fill: title-fg, weight: "bold")[#title]
  ]
  #block(width: 100%, inset: (x: 9pt, y: 7pt))[#body]
]

// ═══ 行内 raw（机器符号 `...`）样式：等宽 + 淡底、保持内联 ═══
// 注意：不要用全局 #show raw.line —— 它会把行内反引号也渲染成带行号的整行方块
#show raw.where(block: false): it => box(
  fill: luma(243),
  inset: (x: 1.6pt, y: 0.3pt),
  radius: 1.5pt,
)[#text(font: "DejaVu Sans Mono", size: 0.88em)[#it.text]]

// ═══ codelisting（CS 轨用）═══
#let codelisting(code, lang: "typst", caption: none) = figure(caption: caption, block(
  width: 100%,
  breakable: true,
  stroke: 0.8pt + luma(200),
  inset: 8pt,
)[
  // 行号规则只在 codelisting 内部局部生效
  #show raw.line: line => box(width: 100%)[
    #box(width: 2.4em)[#text(fill: luma(150), size: 0.72em)[#str(line.number)]]
    #line.body
  ]
  #set text(size: 0.9em)   // 对应 listings 的 \small；raw 无自动折行，长行手动折
  #raw(code, lang: lang, block: true)
])

// ═══ booktabs-table ═══
#let booktabs-table(columns: (), ..rows) = block(width: 100%, breakable: true)[
  #table(
    columns: columns,
    stroke: (top: 1.2pt + black, bottom: 1.2pt + black, x: none, y: 0.5pt + luma(160)),
    fill: none,
    inset: (x: 8pt, y: 5pt),
    ..rows,
  )
]

// ═══ 子图助手（对应 lecture-to-notes 的 subcaption）═══
#let subfigure(items, caption: none, columns: (1fr, 1fr), gutter: 0.6cm) = figure(
  grid(
    columns: columns,
    gutter: gutter,
    ..(for i in range(items.len()) {
        let item = items.at(i)
        let body = item.at(0)
        let label = item.at(1, default: none)
        let letters = ("a", "b", "c", "d", "e", "f", "g", "h")
        (
          [
            #align(center)[#body]
            #if label != none [
              #align(center)[*（#letters.at(calc.min(i, letters.len() - 1))）#label*]
            ]
          ],
        )
      }),
  ),
  caption: caption,
)

// ═══ 折线助手（CeTZ 0.5.2 无 plot）═══
#let plotline(points, stroke: 1pt + black) = cetz.draw.line(..points, stroke: stroke)

// ═══ 图内公式编号助手（本文件全局关闭编号，此处备用）═══
#let unnumbered(body) = {
  set math.equation(numbering: none)
  body
}

#show: ilm.with(
  title: [数学与 CS 问答记录],
  authors: ("math-answer-note",),
  date: datetime(year: 2026, month: 10, day: 7),
  abstract: [按日归档的问答记录：每个独立问题一个一级标题（=），子问题用（== / ===）；三问反思法（关键点/变式/同类归类）+ 讲课叙事流 + 判断框，结构与课程笔记同构。本日主题：经线 = 半大圆（问题 133 起；上一条为 10-04 的问题 132 · 转动惯量）。],
  bibliography: none,
  figure-index: (enabled: true),
  table-index: (enabled: true),
  listing-index: (enabled: true),
)

// 关闭 ilm 模板默认的公式自动编号 (1),(2),……
#set math.equation(numbering: none)

= 📌 本日起点

新的一天，档案已按 math-answer-note 规范建好：今日所有问答按 `= 主题` 追加在本节之后，一条问答一个一级标题（本日编号自 *问题 133* 起）。

#importantbox[
  *上一次记录（10-06）只是一个空起点*，存在 `note/2026-10-06.typ`——那份文件建好了档案但没记录任何问答，因此编号 *133 顺延到今日*，仍未使用。再往前一次实际问答是：

  #booktabs-table(
    columns: (1fr, 3fr, 2.8fr),
    table.header([*编号*], [*主题*], [*结论一句话*]),
    [问题 132],
    [转动惯量（moment of inertia）——既有笔记原文汇总（`note/2026-10-04.typ`）],
    [质点 $m r^2$ $->$ 连续体 $integral.double_R r^2 delta dif A$；绕 $z$ 轴就是 $x^2 + y^2$（极坐标下即 $r^2$）；垂直轴定理 $I_0 = I_x + I_y$ 可交叉验算；三维柱坐标下表达式同形],
  )
]

#warningbox[
  *待办清单（更新于 10-07，承接 10-06）*：

  #enum(
    numbering: "1.",
    [格林公式的*补线法*——仍未展开（考研高频技巧：边界不闭合时补线，再套格林公式）],
    [考纲第八章「常微分方程」在工作区*仍无*对应笔记材料（张宇 30 讲含此章，可作主材）],
  )
]

// ══════════════════════════════════════════════════════════════════════
// 问题 133：第 10 条经线的长度（经线 = 半大圆）
// ══════════════════════════════════════════════════════════════════════

= 🌍 问题 133：为什么"第 10 条经线"的长度是 $pi R$，而不是 $2 pi R$？

#let meridianArc(cx, cy, r, a0, a1, n: 72) = range(n + 1).map(i => {
  let t = a0 + (a1 - a0) * i / n
  (cx + r * calc.cos(t), cy + r * calc.sin(t))
})

// 斜投影：世界坐标 (x, y, z) -> 屏幕 (x, y + K z)，极轴沿屏幕竖直方向
#let sphereK = 0.28
#let sphereRim = 1.5 * calc.sqrt(1 + sphereK * sphereK)
#let equatorPts(n: 96) = range(n + 1).map(i => {
  let t = 2 * calc.pi * i / n
  (1.5 * calc.cos(t), sphereK * 1.5 * calc.sin(t))
})

== 直接解答

地球半径取 $R = 6000$ 公里，第 10 条经线的官方答案是 $pi times 6000$。这个结果的第一眼观感是"漏乘了 2"——毕竟"圆周长 $2 pi R$"几乎是条件反射。但漏掉的不是 2，而是*这一条线根本不满一整圈*。

*一句话答案*：一条经线（meridian）只从北极走到南极，是*半个大圆（great circle）*；$2 pi R$ 属于"完整的一个大圆"，而经线只占它的一半：

$
L_"经线" = (2 pi R) / 2 = pi R = 6000 pi approx 18\,850 "km"
$

符号表：

- $L_"经线"$ —— 一条经线（北极到南极的那段弧）的长度；
- $R$ —— 地球半径，本题取 $6000$ 公里；
- $2 pi R$ —— 该经线所在*完整大圆*（子午圈）的周长，也就是被"漏乘"的那个 $2$ 真正属于的量。

下面把"只算一半"的几何依据补齐——只有三步。

=== 第一步：过球心的平面，截出的是大圆

把地球中心记作 $O$。第 10 条经线所在的那个平面一定包含地球的自转轴；而自转轴穿过球心 $O$，所以这个平面*过球心*。

"过球心的平面与球面相交"是一个特殊情形：交线是半径恰好等于球半径 $R$ 的圆——这类圆叫*大圆（great circle）*，它的完整周长才是 $2 pi R$。经线所在的那个大圆另有专名：*子午圈（meridian circle）*。

（对照：不过球心的平面截出来的是*小圆（small circle）*，半径严格小于 $R$——纬线（parallel）属于这一类。）

=== 第二步：两极把这个大圆切成两段半圆

子午圈是一个完整的圆，它同时穿过北极 $N$ 与南极 $S$；这两个点把它分成弧长相等的两段半圆：

#enum(
  numbering: "1.",
  [从 $N$ 沿一个方向绕到 $S$ 的那一段，编号为经度 $10 degree$——*它就是题目问的"第 10 条经线"*；],
  [从 $N$ 沿另一个方向绕到 $S$ 的那一段，编号为经度 $190 degree$（等价地，西经 $170 degree$）。],
)

*编号规则本身就锁死了"一条经线 = 半圆"*：如果按整圈算，第 $10$ 条经线和第 $190$ 条经线会是同一个圈、同一个长度，"第几条"这个编号立刻失去区分意义。经度值天然只标半圈，因为东经、西经各自只用 $0 degree$–$180 degree$。

=== 第三步：把 $2 pi R$ 归位——它到底属于谁

把 $R = 6000$ km 代进去，那个"多余的 2"就自然被除以 $2$ 消掉了：

$
L_"经线" = (2 pi times 6000 "km") / 2 = 6000 pi "km" approx 18\,850 "km"
$

符号表：

- 分子上的 $2 pi times 6000$ km —— 整条子午圈的周长（完整大圆）；
- 分母上的 $2$ —— 从北极到南极只走半个圆；
- 结果 $6000 pi approx 18\,850$ km，正是官方给的答案。

四类线的身份对照：

#booktabs-table(
  columns: (1.4fr, 2.3fr, 1.6fr),
  table.header([*线*], [*几何身份*], [*长度（$R = 6000$ km）*]),
  [赤道 equator], [完整大圆：过球心，绕一整圈], [$2 pi R approx 3.770 times 10^4$ km],
  [子午圈（整圈）], [完整大圆：第 10 条经线 $+$ 第 190 条经线拼成], [$2 pi R approx 3.770 times 10^4$ km],
  [第 10 条经线], [*半*个大圆：$N -> S$], [$pi R approx 1.885 times 10^4$ km],
  [第 45 条纬线], [完整*小*圆：半径 $R cos 45 degree$], [$2 pi R cos 45 degree approx 2.666 times 10^4$ km],
)

#subfigure(
  (
    (
      cetz.canvas(length: 1.8cm, {
        cetz.draw.line(..meridianArc(0, 0, sphereRim, 0, 2 * calc.pi, n: 96), stroke: 0.5pt + luma(150))
        cetz.draw.line(..equatorPts(), stroke: (thickness: 0.5pt, paint: luma(130), dash: "dashed"))
        cetz.draw.line(..meridianArc(0, 0, 1.5, -calc.pi / 2, calc.pi / 2), stroke: 1.6pt + rgb("#d64541"))
        cetz.draw.line(
          ..meridianArc(0, 0, 1.5, calc.pi / 2, 3 * calc.pi / 2),
          stroke: (thickness: 1.2pt, paint: rgb("#2f6fd0"), dash: "dashed"),
        )
        cetz.draw.content((0, 1.62), $N$, anchor: "south")
        cetz.draw.content((0, -1.62), $S$, anchor: "north")
        cetz.draw.content((0.70, 1.00), text(size: 7pt)[$pi R$], anchor: "west")
        cetz.draw.content((-0.90, 0.62), text(size: 6.5pt)[$2 pi R$], anchor: "east", fill: rgb("#2f6fd0"))
      }),
      [经线 = *半个*大圆：红实线是第 10 条经线（$N -> S$，长 $pi R$），蓝虚线是第 190 条经线，两段合起来才是周长 $2 pi R$ 的完整子午圈；虚线扁椭圆是赤道],
    ),
    (
      cetz.canvas(length: 1.8cm, {
        cetz.draw.line(..meridianArc(0, 0, sphereRim, 0, 2 * calc.pi, n: 96), stroke: 0.5pt + luma(150))
        cetz.draw.line(..equatorPts(), stroke: (thickness: 0.5pt, paint: luma(130), dash: "dashed"))
        cetz.draw.line(
          ..range(97).map(i => {
            let t = 2 * calc.pi * i / 96
            (1.0607 * calc.cos(t), 1.0607 + sphereK * 1.0607 * calc.sin(t))
          }),
          stroke: 1.6pt + rgb("#d64541"),
        )
        cetz.draw.line((0, 0), (1.0607, 1.0607), stroke: 0.7pt + luma(90))
        cetz.draw.line((0, 1.0607), (1.0607, 1.0607), stroke: 0.7pt + luma(90))
        cetz.draw.content((0.60, 0.44), text(size: 7pt)[$R$], anchor: "west")
        cetz.draw.content((0.46, 1.09), text(size: 6.5pt)[$r = R cos 45 degree$], anchor: "south")
        cetz.draw.content((0, 1.62), $N$, anchor: "south")
        cetz.draw.content((0, -1.62), $S$, anchor: "north")
        cetz.draw.content((-1.14, 1.02), text(size: 6.5pt)[周长 $2 pi r$], anchor: "east")
      }),
      [纬线 = 完整*小*圆：球心到第 45 条纬线上一点是半径 $R$，该点到地轴的距离是 $r = R cos 45 degree$，整圈周长 $2 pi r$],
    ),
  ),
  caption: [球面上三类线的长度对照（CeTZ 重绘；斜投影：极轴竖直、赤道画成扁椭圆，红 $=$ 题目所问，蓝 $=$ 补成整圈的另外半段）],
)
#footnote[来源：MIT 18.02 网页「Check your understanding 1」（球面面积估算题）；与本工作区笔记 `../18.02.3x/lec02/notes.typ` 的「习题课一：球面的面积微元」是同一份材料的相邻两问。]

== 关键点

#importantbox[
  *判断"要不要乘 2"只看一件事：这条线是不是完整闭合的一圈。*

  - *经线*：从 $N$ 走到 $S$ 就结束了，不闭合 $->$ 半个大圆 $->$ $pi R$；
  - *纬线*：绕地轴转一圈回到自己，闭合 $->$ 完整小圆 $->$ $2 pi r$，$r$ 是它到地轴的距离 $R cos ell$；
  - *大圆本身*（赤道、子午圈整圈）：闭合且过球心 $->$ 完整大圆 $->$ $2 pi R$。

  还有一条容易忽略的对称性：*经线长度与经度无关*（第 $1$ 条和第 $179$ 条一样长，都是 $pi R$），而*纬线长度强烈依赖纬度*——这正是经线不需要"选点"、纬线必须说明纬度的原因。
]

#knowledgebox[
  *统一视角：绕轴一圈的长度 $= 2 pi times$ 到轴的距离。*

  - 赤道：到地轴距离 $= R$ $->$ $2 pi R$；
  - 纬度 $ell$ 的纬线：到地轴距离 $= R cos ell$ $->$ $2 pi R cos ell$；
  - *经线不适用这条模板*——它沿着"从轴的一端走到另一端"的方向前进，不是绕轴的闭合轨迹，只能按半大圆处理。

  这个"到轴的距离"在极坐标里就是 $r$（面积元素 $dif A = r dif r dif theta$），在球坐标里就是 $R sin theta$（面积元素 $dif A = R^2 sin theta dif theta dif phi$）——*同一个量换三套衣服*。顺带一个历史锚点：米的原始定义正是"从赤道到北极的经线弧长的千万分之一"，即 $(pi R \/ 2) \/ 10^7 = 1$ m，反解出 $R = 2 times 10^7 \/ pi approx 6366$ km——与真实值 $6371$ km 只差 $0.08 percent$，也说明本题取 $6000$ km 是刻意的整数化。
]

== 变式检验

*变式 1：把"半圈"换成"整圈"。* 改问"经度 $10 degree$ 那条子午圈的整圈长度""格林尼治子午圈的整圈长度"，答案就是 $2 pi R approx 3.77 times 10^4$ km。识别词是*整圈 / 完整子午圈 / meridian circle*，而"第几条经线"永远只指半圈。

*变式 2：换成任意纬度 $ell$ 的纬线。*

$
L_"纬线" (ell) = 2 pi R cos ell
$

符号表：

- $ell$ —— 纬度（自赤道量起的角）；
- $R cos ell$ —— 该纬线圆到地轴的距离，也就是它的半径；
- $ell = 0 degree$ 时得赤道 $2 pi R$（最长）；$ell -> 90 degree$ 时 $L -> 0$（纬线收缩成一个点）。

于是出现一个反直觉的结论：*在低纬度，纬线比经线长*。$L_"纬线" \/ L_"经线" = 2 cos ell$，在 $ell = 45 degree$ 处等于 $sqrt(2) approx 1.41$；两条线等长发生在 $ell = 60 degree$（$2 cos 60 degree = 1$），更高的纬度上纬线才变短。

*变式 3：把长度换算成"每 $1 degree$ 的地面距离"。* 纬度方向每 $1 degree$ 对应固定的弧长，经度方向每 $1 degree$ 对应的弧长却随纬度收缩：

$
Delta s_"南北" = R dot Delta ell, quad Delta s_"东西" = R cos ell dot Delta lambda quad ("两者均取弧度制")
$

符号表：

- $Delta ell$、$Delta lambda$ —— 纬度差与经度差（弧度）；
- $R cos ell$ —— 走东西方向时的*有效半径*（同一个"到轴的距离"）。

代进题设的岛屿（纬度 $45 degree$–$46 degree$、经度 $10 degree$–$11 degree$，取中点 $ell = 45.5 degree$）：

- 南北边长 $= 6000 times (pi \/ 180) approx 104.7$ km；
- 东西边长 $= 6000 cos 45.5 degree times (pi \/ 180) approx 73.4$ km；
- 面积 $approx 104.7 times 73.4 approx 7.7 times 10^3$ km²。

这解释了题目的编排意图：*先问经线长度、再问纬线长度，是在给"岛屿面积"预置两个方向的尺度*——经线给出南北方向的尺子，纬线给出东西方向的尺子。

== 同类归类

- *与本工作区笔记同源*：`~/note/2026/18.02.3x/lec02/notes.typ` 的「习题课一：球面的面积微元」讲的是 $dif A = sin theta dif phi dif theta$，其中的 $sin theta$ 正是"沿纬线方向走一步要乘的缩放因子"。本问题就是它的*一次方版本*：纬线长度 $= 2 pi R sin theta$（$theta$ 为天顶角）$= 2 pi R cos ell$（$ell$ 为纬度）——同一件事的两种角变量写法。
- *与极坐标面积元素同类*：$dif A = r dif r dif theta$ 里的 $r$ 和纬线里的 $R cos ell$ 是同一个量（到旋转轴的距离）；把 $r$ 固定、让 $theta$ 跑一圈，得到的就是纬线式的整圆。
- *与参数曲面上的网格线同类*：柱面的水平圆、环面的纬圆，都是"绕轴一圈"的闭合轨迹，长度一律 $2 pi times$（到轴距离）；而"从轴的一端到另一端"的线（经线、柱面母线方向的直线段）必须单独处理，不能套 $2 pi$。
- 一句话织进知识网络：*先问"闭合吗"，再问"半径是到哪条轴的距离"，最后才代入 $2 pi r$ 或 $pi R$。*

== 易错点

#warningbox[
  #enum(
    numbering: "1.",
    [*把经线当整圈*：多乘一个 $2$，答成 $2 pi R approx 3.77 times 10^4$ km。判据：经线从 $N$ 到 $S$ 就换线了，不闭合。],
    [*反向错误：把纬线当半圈*，漏乘 $2$，答成 $pi R cos ell$。纬线是完整闭合的小圆，$2 pi r$ 一个都不能少。],
    [*以为"第 10 条经线"是球面上某个点的位置*：它指整条 $N -> S$ 的弧，长度与站在哪个纬度无关；"第 10 条"标的是经度值，不是点。],
    [*用整条纬线长度除以 $360$ 换算"每 $1 degree$ 经度差的距离"*：会得到 $26657 \/ 360 approx 74.05$ km，而 $45 degree$–$46 degree$ 之间的真值是 $45.5 degree$ 处的 $73.4$ km，两者差 $0.9 percent$。严格算法是积分 $R integral_(45 degree)^(46 degree) cos ell dif ell = R (sin 46 degree - sin 45 degree) approx 73.4$ km；实用做法则是取纬度*中点*。],
    [*把地面弧长和穿过地球的弦长搞混*：题目要的一律是沿地表走的弧长（$pi R$、$2 pi R cos ell$），不是两点间的直线距离。],
  )
]

#importantbox[
  *本节结论一句话*：经线 $= pi R$（半大圆），纬线 $= 2 pi R cos ell$（完整小圆），赤道与大圆 $= 2 pi R$——$2 pi$ 只属于*闭合*的圈；经线不闭合，所以只有 $pi$。
]
