// ═══════════════════════════════════════════════════════════════
// answer-note · 按日归档问答记录
// 结构：每个独立问题 = 一个一级标题（=），子问题用（== / ===）
// 轨道：数学轨（本日主题待记录；承接 10-17：18.02.3x 各讲顺序修复等待办，见本日起点）
// 规范：answer-note（无 practicebox/无自测框；三色判断框
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
    ..(
      for i in range(items.len()) {
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
      }
    ),
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
  authors: ("answer-note",),
  date: datetime(year: 2026, month: 10, day: 19),
  abstract: [按日归档的问答记录：每个独立问题一个一级标题（=），子问题用（== / ===）；三问反思法（关键点/变式/同类归类）+ 讲课叙事流 + 判断框，结构与课程笔记同构。本日主题：待记录（上一条为 10-17 的问题 143 · 切片法（切面法）识别曲面的局限与可靠判据（已收口）；10-18 未新增问答；本日问答自问题 144 起逐条追加。仍未收口的是 10-08 的问题 134 · 半球面平均距离（仍在"引导轮"状态）与 10-14 的问题 136 第 1 卷 · 线积分六道回忆题待答；另有 18.02.3x 各讲顺序修复等事项，见本日起点待办清单）],
  bibliography: none,
  figure-index: (enabled: true),
  table-index: (enabled: true),
  listing-index: (enabled: true),
)

// 关闭 ilm 模板默认的公式自动编号 (1),(2),……
#set math.equation(numbering: none)

= 📌 本日起点

新的一天，档案已按 answer-note 规范建好：今日所有问答按 `= 主题` 追加在本节之后，一条问答一个一级标题（本日编号自 *问题 144* 起）。

#importantbox[
  *上一次记录（10-17）* 见 `note/2026-10-17.typ`——那一日有*一条*记录（10-18 星期日未新增问答）：

  #booktabs-table(
    columns: (0.9fr, 2.9fr, 2.6fr),
    table.header([*编号*], [*主题*], [*状态*]),
    [问题 143],
    [切片法（切面法）识别曲面——是万能的吗？局限在哪（第 6 节的方法论追问）],
    [*已收口*：四局限速查表（两刀不够 / 同种曲线误导 / 只适图形式 / 坐标轴特权）+ 反例细节（圆锥 vs 四棱锥、马鞍面、$z = x y$、系数陷阱）+ 可靠判据（代数 / 标准式 / 参数化）+ 变式检验 + 易错点],
  )
]

#warningbox[
  *待办清单（更新于 10-19，承接 10-17）*：

  #enum(
    numbering: "1.",
    [*18.02.3x 各讲顺序修复（10-16 检查结果）*——A 类确证 4 讲待动手：`lec02`/`lec04`（全章小结前移到习题课前）、`lec05`（习题课「Worked Examples」前移到判断题与二维版之前）、`lec06`（例 18 与扩散方程两节交换）；B 类 2 讲（`lec08`、`lec09`）等读者在课程页面核对页序后处置；C 类 2 处"见正文"遗漏（`lec06` 地图 [8]、`lec09` 地图 [5]）待核],
    [*`lec02` 的球坐标图是否同步处理*——lec02 笔记中该图（材料原图，物理约定样式）位于「物理约定的三组基向量」节；读者定夺（换成数学约定版 $slash$ 加提示 $slash$ 保持原样）],
    [*问题 136 的第 1 卷*——线积分复习的六道回忆题，随时可答；答完进入批改环节（仍挂起）],
    [*问题 134 的引导尚未收口*——等读者回答三层入口（$H$ 是曲面还是实体？$abs(O P)$ 在 $H$ 上取哪些值？被平均量 $f$ 是什么？）并给出选择题选项截图，随后补齐五模块],
    [格林公式的*补线法*——仍未展开（考研高频技巧：边界不闭合时补线，再套格林公式）],
    [考纲第八章「常微分方程」在工作区*仍无*对应笔记材料（张宇 30 讲含此章，可作主材）],
    [18.02.3x 的*符号就地注释*：目前只覆盖 `lec01` 样板段——读到卡壳处随时报位置，按同一模式补],
  )
]

// ══════════════════════════════════════════════════════════════════════
// 本日问答自下方开始追加：一条问答一个一级标题（= 主题）
// ══════════════════════════════════════════════════════════════════════

// ── 问题 144 · 环面参数化 (3.38)–(3.40)：用户问的是 (3.39)（数学轨）──

= 环面参数化第 (3.39) 步：$v = 0$ 时 $y$ 为什么不变

== 直接解答

你圈的是讲义 (3.39)，不是最终的参数化 (3.40)。把这一点定住，矛盾就不存在了：在 (3.39) 里，$y(u)$ 确实恒等于 $0$，$u$ 变时 $y$ 不变；只有在 (3.40) 把那个 $0$ 换成 $v$ 之后，$y$ 才会随 $u$ 变。

=== 教材的三步

第一步 (3.38)：先参数化位于 $(R, 0, 0)$ 的那个竖直圆：

$
  x(u) = R + r cos u, quad y(u) = 0, quad z(u) = r sin u
$

- $R$ —— 主半径（major radius），也就是 $x y$ 平面内基础圆的半径；
- $r$ —— 次半径（minor radius），也就是竖直圆的半径（管子的粗细）；
- $u$ —— 截面角，绕这个竖直圆转一圈；
- $R + r cos u$ —— 截面圆上的点到 $z$ 轴的水平距离。

这个圆整个落在 $x z$ 平面内：圆心 $(R, 0, 0)$，半径 $r$。

第二步 (3.39)：把 $1$ 和 $0$ 改写成 $cos 0$ 与 $sin 0$：

$
  x(u) = (R + r cos u) cos 0, quad y(u) = (R + r cos u) sin 0, quad z(u) = r sin u
$

- $cos 0 = 1$、$sin 0 = 0$ —— 所以 (3.39) 与 (3.38) 逐项相等，数值上什么都没变；
- $0$ —— 当前截面圆所在的方位角，下一步会被换成参数 $v$；
- $R + r cos u$ —— 水平半径，记作 $rho(u)$。

因为 $sin 0 = 0$，所以 (3.39) 里 $y(u) = rho(u) dot 0 = 0$。$u$ 从 $0$ 走到 $2 pi$，$y$ 恒等于 $0$，$x$ 与 $z$ 在 $x z$ 平面内画出一个半径 $r$、圆心 $(R, 0, 0)$ 的圆。

这正是你说的「过 $x y$ 平面上一点，做垂直于 $x y$ 平面的圆」——只不过那个点必须是 $(R, 0, 0)$（方位角为 $0$ 的点），圆才恰好落在 $x z$ 平面里。

第三步 (3.40)：把固定的 $0$ 换成参数 $v$：

$
  x(u, v) = (R + r cos u) cos v \
  y(u, v) = (R + r cos u) sin v \
  z(u, v) = r sin u
$

- $v$ —— 绕 $z$ 轴的方位角（azimuth），也就是旋转角；
- $u$ —— 截面圆内部的角度，保持不变；
- $rho(u) = R + r cos u$ —— 旋转前竖直圆上的点到 $z$ 轴的距离；
- $z(u, v) = r sin u$ —— 高度只由 $u$ 决定，旋转不改变高度。

=== 先看一个反例：$v = 90 degree$

你的说法里藏着一个前提：*「截面圆的水平方向就是 $x$ 轴」*。这个前提只在 $v = 0$ 时成立。

取 $v = 90 degree$，此时 $cos v = 0$、$sin v = 1$。代入 (3.40)：

$
  x = 0, quad y = R + r cos u, quad z = r sin u
$

- $x equiv 0$ —— 整个截面圆落在 $y z$ 平面内；
- $y$ —— 随 $u$ 在 $R - r$ 与 $R + r$ 之间变化；
- $z$ —— 随 $u$ 在 $-r$ 与 $r$ 之间变化。

圆上取三个点，一眼就能看出变的是谁：

#booktabs-table(
  columns: (auto, auto, auto, auto),
  table.header([*$u$*], [*点 $(x, y, z)$*], [*$y$*], [*$z$*]),
  [$0$], [$(0, R + r, 0)$], [$R + r$], [$0$],
  [$pi slash 2$], [$(0, R, r)$], [$R$], [$r$],
  [$pi$], [$(0, R - r, 0)$], [$R - r$], [$0$],
)

三点全在 $y z$ 平面内，$x$ 恒为 $0$，变的是 $y$ 与 $z$。所以「圆上只有 $x$、$z$ 在变」并不是截面圆的性质，而是 $v = 0$ 这个特殊方位的性质。

=== $u$ 变的是水平半径，不是 $x$ 坐标

$u$ 变化时，真正在变的是两个量：

$
  rho(u) = R + r cos u, quad z(u) = r sin u
$

- $rho(u)$ —— 点沿*水平半径方向*到 $z$ 轴的距离；
- $z(u)$ —— 高度；
- $r$ —— 固定常数，不随 $u$ 变（$u$ 才是变量）。

$rho(u)$ 是一条沿 $e_rho (v) = (cos v, sin v, 0)$ 方向量出来的长度，不是 $x$ 坐标。把它投影到固定的 $x$、$y$ 轴上，就分成两份：

$
  x = rho(u) cos v, quad y = rho(u) sin v
$

只要 $sin v != 0$，$rho$ 一变，$y$ 就跟着变。$y$ 不是「圆上多出来的运动方向」，而是*水平半径在 $y$ 轴上的投影*。

=== 把坐标轴跟着圆一起转

如果站在「跟着圆一起转」的坐标系里看，$y$ 的困惑会消失。定义

$
  X' = x cos v + y sin v, quad Y' = -x sin v + y cos v
$

- $X'$ —— 沿 $e_rho (v)$ 方向的水平坐标；
- $Y'$ —— 垂直于该方向的水平坐标；
- $v$ —— 坐标轴绕 $z$ 轴转过的角度。

代入 (3.40) 得

$
  X' = R + r cos u, quad Y' = 0, quad z = r sin u
$

这正是 (3.39) 的形状：在旋转后的坐标系里，第二个水平坐标 $Y'$ 恒为 $0$，只有 $X'$ 与 $z$ 在变。你的直觉完全正确——只不过它描述的是 $(X', Y', z)$ 这组坐标，而材料写的是固定的 $(x, y, z)$。

一句话：*$u$ 改变的是水平半径 $rho(u)$，而 $y = rho(u) sin v$ 只是这个半径在 $y$ 轴上的投影*。$v = 0$ 时投影为零，回到 (3.39)；$v != 0$ 时投影随 $rho(u)$ 一起变。

不变量仍然是方向：

$
  y / x = tan v
$

- $y slash x$ —— 固定 $v$ 的截面圆上点的水平方向斜率；
- $v = 0$ 时 $tan v = 0$，化为 $y = 0$，正是 (3.39)。

#figure(
  cetz.canvas(length: 1.05cm, {
    let R = 2.2
    let r = 0.78
    let prj(x, y, z) = (x + 0.56 * y, z + 0.30 * y)
    let surf(u, v) = {
      let rho = R + r * calc.cos(u)
      (rho * calc.cos(v), rho * calc.sin(v), r * calc.sin(u))
    }
    // 纬线（固定 u）
    for k in range(0, 8) {
      let u = k * calc.pi / 4
      let pts = (prj(..surf(u, 0)),)
      for i in range(1, 37) {
        pts.push(prj(..surf(u, i * calc.pi / 18)))
      }
      cetz.draw.line(..pts, stroke: 0.3pt + luma(200))
    }
    // 经线（固定 v）
    for k in range(0, 12) {
      let v = k * calc.pi / 6
      let pts = (prj(..surf(0, v)),)
      for i in range(1, 37) {
        pts.push(prj(..surf(i * calc.pi / 18, v)))
      }
      cetz.draw.line(..pts, stroke: 0.3pt + luma(185))
    }
    // 坐标轴
    cetz.draw.line((-3.0, 0), (3.5, 0), stroke: 0.4pt + luma(110))
    cetz.draw.line((0, -1.25), (0, 2.05), stroke: (thickness: 0.4pt, paint: luma(110), dash: "dashed"))
    cetz.draw.line((0, 0), (1.79, 0.96), stroke: 0.4pt + luma(110))
    cetz.draw.content((3.55, 0), text(size: 7pt)[$x$], anchor: "west")
    cetz.draw.content((1.84, 1.02), text(size: 7pt)[$y$], anchor: "south-west")
    cetz.draw.content((0, 2.08), text(size: 7pt)[$z$], anchor: "south")
    // (3.39)：v = 0，截面圆整个落在 xz 平面内
    let c0 = (prj(..surf(0, 0)),)
    for i in range(1, 73) {
      c0.push(prj(..surf(i * calc.pi / 36, 0)))
    }
    cetz.draw.line(..c0, stroke: 1.7pt + rgb("#d64541"))
    // (3.40)：v = 45°，同一个截面圆转到方位角 45° 的竖直平面内
    let vh = calc.pi / 4
    let c1 = (prj(..surf(0, vh)),)
    for i in range(1, 73) {
      c1.push(prj(..surf(i * calc.pi / 36, vh)))
    }
    cetz.draw.line(..c1, stroke: 1.7pt + rgb("#2f6fd0"))
    // 两个圆心
    cetz.draw.circle(prj(R, 0, 0), radius: 0.06, fill: rgb("#d64541"))
    cetz.draw.circle(prj(R * calc.cos(vh), R * calc.sin(vh), 0), radius: 0.06, fill: rgb("#2f6fd0"))
  }),
  caption: [CeTZ 重绘：灰色为环面线框。红色圆是讲义 (3.39) 的截面圆（$v = 0$，圆心 $(R, 0, 0)$，整个落在 $x z$ 平面内，$y equiv 0$）；蓝色圆是同一个截面圆在 (3.40) 中取 $v = 45 degree$ 后的位置（圆心 $(R cos v, R sin v, 0)$，平面绕 $z$ 轴转了 $v$）。两圆的对比说明：$y$ 是否变化，取决于把圆放在哪个方位的竖直平面里。],
)

=== 数值对照

取 $R = 3$、$r = 1$，并把 (3.40) 的方位角取成 $v = 45 degree$（$sin v = 0.707$）：

#booktabs-table(
  columns: (auto, auto, auto, auto, auto),
  table.header([*$u$*], [*$rho(u)$*], [*(3.39) 的 $y$*], [*(3.40) 的 $y$（$v = 45 degree$）*], [*$z$*]),
  [$0$], [$4.00$], [$0$], [$2.83$], [$0$],
  [$pi slash 2$], [$3.00$], [$0$], [$2.12$], [$1$],
  [$pi$], [$2.00$], [$0$], [$1.41$], [$0$],
  [$3 pi slash 2$], [$3.00$], [$0$], [$2.12$], [$-1$],
)

第三列恒为 $0$，对应你图片里的 (3.39)；第四列随 $rho(u)$ 变，对应 (3.40)。两列描述的是同一个截面圆在两个不同方位角下的位置，所以并不矛盾。

== 关键点

#importantbox[
  (3.39) 是 $v = 0$ 的特例：截面圆落在 $x z$ 平面内，$y(u) equiv 0$，所以 $u$ 变时 $y$ 不变——你的理解完全正确。一般式 (3.40) 里 $y = rho(u) sin v$，固定 $v$ 时变的是水平半径 $rho(u)$，因此 $y$ 跟着 $u$ 变。把 $0$ 换成 $v$ 的这一步，只是把同一个截面圆旋转到别的方位角。
]

== 变式检验

=== 变式一：把 $0$ 换成 $pi slash 2$

$
  x = (R + r cos u) cos(pi slash 2) = 0, quad y = R + r cos u, quad z = r sin u
$

- $x equiv 0$ —— 截面圆落到 $y z$ 平面内；
- $y$ —— 随 $u$ 变，角色与 (3.39) 中的 $x$ 互换。

这说明 (3.39) 里的那个 $0$ 确实是「方位角」，不是可有可无的装饰。

=== 变式二：固定 $u$、让 $v$ 变

$
  x = rho(u_0) cos v, quad y = rho(u_0) sin v, quad z = r sin u_0
$

- $rho(u_0)$、$z$ —— 都是常数；
- $v$ —— 自由变化。

得到的是水平纬线（parallel）：$z$ 不变，$x$、$y$ 同时变。

=== 变式三：在 (3.39) 里哪些量不变

$u$ 变化时，$y equiv 0$、圆心 $(R, 0, 0)$、半径 $r$、所在平面 $x z$ 都不变；$x$ 与 $z$ 按圆的参数方程变化。这与「圆心固定、半径固定、平面固定」的平面圆完全一致，也是你最初图像对应的情形。

== 同类归类

讲义的三步就是旋转曲面的通用手法：先写一条母线（这里是圆），再把母线上的固定方位角 $0$ 换成旋转角 $v$。通式是

$
  arrow(r)(u, v) = (f(u) cos v, f(u) sin v, g(u))
$

- $f(u)$ —— 母线上一点到 $z$ 轴的距离（profile radius）；
- $g(u)$ —— 该点的高度（profile height）；
- $v$ —— 绕 $z$ 轴的旋转角。

环面取 $f(u) = R + r cos u$、$g(u) = r sin u$ 即可。固定 $v$ 得经线（meridian，管子截面圆），固定 $u$ 得纬线（parallel，绕轴的水平圆）：

#booktabs-table(
  columns: (auto, auto, auto, auto),
  table.header([*曲面*], [*母线（$u$ 方向）*], [*固定 $v$：经线*], [*固定 $u$：纬线*]),
  [环面], [半径 $r$ 的圆], [竖直圆], [水平圆],
  [球面], [半圆], [半圆], [圆],
  [圆锥面], [直线], [直线], [圆],
  [圆柱面], [竖直线], [竖直线], [圆],
)

== 易错点

#warningbox[
  #enum(
    [*把 (3.39) 的 $y equiv 0$ 推广到整个环面。* 它只在 $v = 0$ 时成立；(3.40) 里 $y = rho(u) sin v$，一般 $v$ 下随 $u$ 变。],
    [*把 (3.39) 与 (3.40) 混着读。* 前者是固定方位角 $0$ 的截面圆，后者才是环面的完整参数化。],
    [*把 $x z$ 平面当成所有截面圆所在的平面。* 一般 $v$ 下截面圆在含 $z$ 轴、方位角为 $v$ 的竖直平面内。],
    [*把 $R$ 当成外半径。* 外半径是 $R + r$，内半径是 $R - r$；$R$ 是基础圆（圆心所在圆）的半径。],
    [*把讲义 (3.41) 的 $bold(p)$、$bold(q)$ 混进本问题。* 它们是「方纸片卷上环面」同伦里的两个点，属于下一个例子，与 (3.38)–(3.40) 的截面圆推导无关。],
  )
]

#knowledgebox[
  笔记里的口诀可以直接对上这三步：*先写一个截面圆，再把截面圆的半径接到旋转角上*。(3.38) 写截面圆，(3.39) 把 $1$、$0$ 改写成角度为 $0$ 的单位向量，(3.40) 把 $0$ 换成 $v$。你图片所指的 (3.39) 正是中间那一步，还没有开始旋转。
]

// ── 问题 145 · 同伦 H(p,q,t)：方纸片怎样变成环面（数学轨）──

= 同伦（homotopy）$H(bold(p), bold(q), t)$：方纸片怎样"变成"环面

== 直接解答

这句话可以逐词翻成一句人话：*给方片上的每个点安排一个终点，让它在 $t$ 从 $0$ 走到 $1$ 的过程中，沿直线从起点走到终点。*

$
  H(bold(p), bold(q), t) = (1 - t) bold(p) + t bold(q), quad 0 <= t <= 1
$

- $bold(p)$ —— 方片上的一个点，也就是起点；
- $bold(q)$ —— 它在环面上的对应点，也就是终点，由 (3.40) 算出；
- $t$ —— 动画进度：$t = 0$ 在起点，$t = 1$ 在终点，$t = 0.5$ 走到一半；
- $1 - t$ 与 $t$ —— 两个权重，加起来恒等于 $1$。

"线性插值"四个字拆开就是：*线性* = 每个坐标按同一比例混合；*插值* = 在起点与终点之间取值。$t = 0.5$ 时，$H$ 正好是两点连线的中点。

=== 三个角色别弄混

- 方片是 $[0, 2 pi] times [0, 2 pi]$，平放在 $x y$ 平面上，所以方片上的点写成 $bold(p) = (u, v, 0)$；
- 它的目的地是环面参数化给出的点 $bold(q) = ((R + r cos u) cos v, (R + r cos u) sin v, r sin u)$；
- $bold(p)$ 的两个坐标 $(u, v)$ 只是"方片上的地址"，同时也是参数；它们不是环面上的 $x$、$y$。

$bold(p)$ 与 $bold(q)$ 不是新参数，只是同一只蚂蚁的起点和终点。

=== 算一个具体点

取 $R = 3$、$r = 1$，方片上的点 $bold(p) = (0, 0, 0)$。它的目的地是

$
  bold(q) = ((3 + 1) cos 0, (3 + 1) sin 0, 1 dot sin 0) = (4, 0, 0)
$

三个时刻的位置：

#booktabs-table(
  columns: (auto, auto, auto),
  table.header([*$t$*], [*$H$ 的位置*], [*含义*]),
  [$0$], [$(0, 0, 0)$], [还在方片上],
  [$0.5$], [$(2, 0, 0)$], [正好走到一半],
  [$1$], [$(4, 0, 0)$], [到达环面],
)

再换一个点 $bold(p) = (pi slash 2, pi slash 2, 0)$：它对应的 $bold(q) = (0, 3, 1)$。$t = 0.5$ 时

$
  H = 0.5 dot (1.571, 1.571, 0) + 0.5 dot (0, 3, 1) = (0.785, 2.285, 0.5)
$

它沿直线飞向目的地，不是沿着环面爬过去。

=== 为什么整张方片会"变成"环面

因为方片上的*每一个点*都有一条自己的 $bold(p) -> bold(q)$ 直线，而且所有点共用同一个 $t$，所以它们是"同时、同比例"地走。$t = 0$ 时所有点都还在方片上；$t = 1$ 时所有点都到了环面上；中间每一帧就是所有点走到同一进度时的样子。

也就是说，这不是一只手在卷纸，而是每个点各自沿直线飞过去；整体看起来像方片在连续变形。

=== 为什么中间帧不像"卷纸"

线性插值不保长度、不保面积，也不保证不自交。每个点走直线，整张纸会被拉伸、挤压，甚至穿过自己。数学上它只是一个*同伦*（homotopy）：把"方片嵌入"连续地变到"环面参数化"，不要求中间形状是物理上的卷纸。只有 $t = 1$ 的终态才是环面。

=== 它和 (3.40) 的分工

- (3.40) 回答"环面上的点在哪"：给定 $(u, v)$，算出 $bold(q)$；
- $H$ 回答"动画怎么从方片走到环面"：给定起点、终点和进度，算出中间位置。

$H$ 不是环面的参数化，也不能拿来算曲面积分；它只是可视化的工具。

== 关键点

#importantbox[
  $H(bold(p), bold(q), t) = (1 - t) bold(p) + t bold(q)$ 就是"每个点沿直线从起点走到终点"的动画公式：$t$ 是进度，$bold(p)$ 是方片上的点，$bold(q)$ 是它在环面上的对应点。$t = 0$ 是方片，$t = 1$ 是环面，中间是过渡帧；中间帧只是同伦，不是物理卷纸。
]

== 变式检验

=== 变式一：$t = 0.5$ 到底是谁

$H = (bold(p) + bold(q)) slash 2$，即起点与终点的中点。对 $bold(p) = (0,0,0)$、$bold(q) = (4,0,0)$，中点是 $(2,0,0)$。

=== 变式二：换成另一个终点

如果 $bold(q)$ 不是环面上的点，而是球面上的点，同一个公式给出"方片 → 球面"的动画。公式本身不关心终点在什么曲面上，它只负责在两点之间走直线。

=== 变式三：$t$ 与 $u$、$v$ 无关

$u$、$v$ 决定"是哪个点"（方片上的地址）；$t$ 决定"这个点走到哪了"（动画进度）。固定 $u$、$v$、改变 $t$，得到同一个点的一条直线轨迹；固定 $t$、改变 $u$、$v$，得到某一帧的整张曲面。

== 同类归类

- *线性插值*（linear interpolation）：两个值之间按比例取中间值，$H$ 是它在三维点上的版本；
- *关键帧动画*（keyframe animation）：起点一帧、终点一帧，中间帧由插值生成；
- *同伦*（homotopy）：$H(dot, 0) = bold(p)$、$H(dot, 1) = bold(q)$ 且对 $t$ 连续，正是"一个映射连续变到另一个映射"的定义。

== 易错点

#warningbox[
  #enum(
    [*把 $bold(p)$、$bold(q)$ 当成新参数。* 它们是起点与终点；$bold(p)$ 的两个坐标就是 $(u, v)$。],
    [*把 $H$ 当成环面的参数化。* 环面参数化是 (3.40)，$H$ 只是动画公式。],
    [*把中间帧当成环面。* 只有 $t = 1$ 才是环面；中间形状可能拉伸、自交。],
    [*把 $t$ 与 $u$、$v$ 混用。* $t$ 是动画进度，与方片上的地址无关。],
    [*以为点在沿环面爬。* 每个点走的是三维空间中的直线段。],
  )
]
