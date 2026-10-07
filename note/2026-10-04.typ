// ═══════════════════════════════════════════════════════════════
// math-answer-note · 按日归档问答记录
// 结构：每个独立问题 = 一个一级标题（=），子问题用（== / ===）
// 轨道：待定（按当日首条问答判断：数学轨 / CS 轨）
// 规范：2026-09-05 math-answer-note 新版（无 practicebox/无 dia-scale，
//       含 titledbox/unnumbered；公式编号全局关闭）
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

// ═══ 图内公式编号助手（本文件全局关闭编号，此处备用）═══
#let unnumbered(body) = {
  set math.equation(numbering: none)
  body
}

#show: ilm.with(
  title: [数学与 CS 问答记录],
  authors: ("math-answer-note",),
  date: datetime(year: 2026, month: 10, day: 4),
  abstract: [按日归档的问答记录：每个独立问题一个一级标题（=），子问题用（== / ===）；三问反思法（关键点/变式/同类归类）+ 讲课叙事流 + 判断框，结构与课程笔记同构。本日主题：转动惯量（moment of inertia）——既有笔记（18.02.2x lec-02 / lec-12）相关原文的照录汇总（问题 132）。],
  bibliography: none,
  figure-index: (enabled: true),
  table-index: (enabled: true),
  listing-index: (enabled: true),
)

// 关闭 ilm 模板默认的公式自动编号 (1),(2),……
#set math.equation(numbering: none)

= 📌 本日起点

新的一天，档案已按 math-answer-note 规范建好：今日所有问答按 `= 主题` 追加在本节之后，一条问答一个一级标题。

#importantbox[
  *上一次记录（10-02）的五条问答*，都存在 `note/2026-10-02.typ`（27 页）——从“复习一个概念”一路问到“考纲边界”：

  #booktabs-table(
    columns: (1fr, 3fr, 2.8fr),
    table.header([*编号*], [*主题*], [*结论一句话*]),
    [问题 127],
    [vector-valued function：笔记里是怎么写的],
    [输入参数、输出向量；求导得速度、取模得速率、单位化得单位切向量],
    [问题 128],
    [vector field 的定义；它算不算向量值函数],
    [“点 $->$ 向量”；材料原文就说“向量场有时也叫向量值函数”，分水岭在*定义域*的维度],
    [问题 129],
    [怎么判定向量场是不是保守场],
    [三步：算 $"curl"$ 先筛 $->$ 查定义域单连通 $->$ 动手求势函数（终审）],
    [问题 130],
    [四种等价说法怎么互证；$"div" = 0$ 有什么用],
    [循环证明 $(1) -> (2) -> (3) -> (4) -> (1)$；$"div" = 0$ 是 $"curl" = 0$ 的*法向对偶*（无源 $slash$ 不可压缩）],
    [问题 131],
    [考研考 3D 曲面积分吗],
    [*考*（数学一独有、解答题主力）；高斯算曲面积分、斯托克斯算曲线积分],
  )
]

#warningbox[
  *待办清单（更新于 10-04）*：

  #enum(
    numbering: "1.",
    [三维散度公式 $"div" arrow(F) = P_x + Q_y + R_z$——*已完成*：问题 130 顺带补上，同处还给出了三维 $"curl" = 0$ 的三个分量条件],
    [格林公式的*补线法*——仍未展开（考研高频技巧，边界不闭合时补线再套格林公式）],
    [考纲第八章「常微分方程」在工作区*仍无*对应笔记材料（张宇 30 讲含此章，可作主材）],
  )
]

= 🎡 问题 132：转动惯量（moment of inertia）——笔记原文汇总

读者问：我有些遗忘了转动惯量的概念，将我的笔记中的有关内容复制粘贴到日期文件里。#footnote[来源：照录自 `~/note/2026/18.02.2x/lec-02/polar-integrals.typ`（材料 4「转动惯量」第 646–735 行；附录 K 公式速查第 1407–1410 行）与 `~/note/2026/18.02.2x/lec-12/triple-integrals-and-cylindrical-coordinates.typ`（材料 10「三维转动惯量」第 1445–1600 行）。依赖原笔记 `figures/` 的插图已略去，自绘图保留；原 `practicebox` 的内容改写为普通段落（本文件无该宏）。]

== 一、定义与物理含义（lec-02 材料 4，原文照录）

=== 从物理出发：一个质点

转动惯量是本讲的最后一个应用，也是材料着墨最多的一个。

材料先给物理铺垫。一个质量为 $m$ 的质点、到轴 $S$ 的距离为 $r$，它绕该轴的*转动惯量*是

$ ("Moment of inertia of point mass " m " about the axis " S) quad m r^2 $

与之相关的是*动能*：角速度为 $omega$ 时，

$ ("Kinetic energy of point mass with angular velocity " omega) quad 1/2 m v^2 = 1/2 m r^2 omega^2 $

符号：$m$ 为质点质量；$r$ 为*到轴*的距离（不是到原点的距离）；$omega$ 为角速度；$v = r omega$ 为线速度。

#knowledgebox[
  把这两个式子对照看：动能式子里的 $1\/2 m r^2 omega^2$ 可以写成 $1\/2 (m r^2) omega^2$——括号里正是转动惯量。
  这与平动的动能 $1\/2 m v^2$ 完全平行：*转动惯量在转动里扮演的角色，等同于质量在平动里扮演的角色*。
  $r^2$ 这个因子说明“离轴越远的质量，转起来越费力”。
]

=== 连续体的推广：求和变成积分

把质点换成连续体，求和变成积分：

$ ("Moment of inertia of solid about axis " S) quad integral.double_R r(x, y)^2 delta(x, y) dif A $

其中 $r(x, y)$ 是点 $(x, y)$ 到*轴* $S$ 的距离（注意：不是到原点的距离，是到指定轴的距离）；
$delta(x, y)$ 为面密度。

对*绕 $z$ 轴*（即垂直于板、过原点）的转动惯量，材料给了专门的记号与公式：

$ I_0 = "Polar moment of inertia of solid" = integral.double_R (x^2 + y^2) delta(x, y) dif A $

#importantbox[
  *绕 $z$ 轴的 $r^2$ 就是 $x^2 + y^2$*——因为到 $z$ 轴的距离正是点到原点的距离（在这块板所在平面内）。
  所以绕 $z$ 轴的转动惯量在极坐标下格外好算：

  $ I_0 = integral.double_R r^2 delta dif A $

  （因为极坐标里的 $r^2$ 正是“绕 $z$ 轴的距离平方”本身。）

  *这是极坐标与转动惯量的天然匹配*：极坐标的 $r$ 恰好就是绕 $z$ 轴的转动惯量所需要的距离。
]

#warningbox[
  *绕 $x$ 轴或 $y$ 轴的转动惯量不要混用公式*。材料同时给出了

  $ I_x = integral.double_R y^2 delta dif A, quad I_y = integral.double_R x^2 delta dif A $

  绕 $x$ 轴的距离是 $abs(y)$（*不是* $sqrt(x^2 + y^2)$！），所以被积函数是 $y^2$。
  *判断方法：问自己“点到这条轴的垂线长度是多少”*——绕 $x$ 轴就是 $abs(y)$，绕 $y$ 轴就是 $abs(x)$，
  绕 $z$ 轴（过原点、垂直于板）才是 $sqrt(x^2 + y^2)$。

  这三者之间还有一个恒等式（*垂直轴定理*）：$I_0 = I_x + I_y$，因为 $x^2 + y^2$ 就是两个平方和。
  这条恒等式可以用来交叉验算。
]

=== 图示：它站在“微元法应用”的哪一格（原笔记自绘）

#figure(
  cetz.canvas(length: 1.0cm, {
    import cetz.draw: *
    line(
      (-1.5, -1),
      (1.2, -1.3),
      (1.6, 0.9),
      (-0.9, 1.4),
      close: true,
      fill: rgb("#eef3fb"),
      stroke: (paint: rgb("#2f6fd0"), thickness: 1.2pt),
    )
    // 网格细分表示“求和”
    set-style(stroke: (paint: rgb("#8fa8c8"), thickness: 0.5pt))
    for i in range(1, 6) {
      let t = i / 6
      line((-1.5 + t * 3.1, -1 + t * 0.55), (-0.9 + t * 2.5, 1.4 - t * 1.0))
    }
    content((0.1, 0.1), [面积 $= integral.double_R dif A$], anchor: "center")
    content((0, -1.9), [把区域切成小块求和], anchor: "center")
  }),
  caption: [
    *微元法的统一图景*（CeTZ 重绘，原笔记“二重积分的四个应用”中的一幅）。
    二重积分就是“把区域切碎求和”——面积与质量是对 $1$ 与 $delta$ 求和；
    *转动惯量则是把权重换成“到轴距离的平方”*：$integral.double_R r^2 delta dif A$。
    同一套微元法，只换被积函数。
  ],
)

== 二、速查：绕各轴的公式与常用结果（lec-02 附录 K 原文条目）

#booktabs-table(
  columns: (2.2fr, 3.4fr),
  table.header([*条目*], [*公式*]),
  [绕 $z$ 轴转动惯量（极转动惯量）],
  [$I_0 = integral.double_R (x^2 + y^2) delta dif A = integral.double_R r^2 delta dif A$],
  [绕 $x$ 轴转动惯量],
  [$I_x = integral.double_R y^2 delta dif A$],
  [绕 $y$ 轴转动惯量],
  [$I_y = integral.double_R x^2 delta dif A$],
  [垂直轴定理],
  [$I_0 = I_x + I_y$（用于交叉验算）],
  [密度均匀圆盘绕中心轴],
  [$I_0 = pi a^4 slash 2$（半径 $a$、密度 $1$）],
)

#knowledgebox[
  对照记忆：*面积 $->$ 质量 $->$ 质心 $->$ 转动惯量*是同一套微元法的四级台阶——
  $integral.double_R dif A$、$integral.double_R delta dif A$、$integral.double_R x delta dif A$（求质心的分子）、
  $integral.double_R r^2 delta dif A$。*只有被积函数在变。*
]

== 三、三维版本（lec-12 材料 10，原文照录）

=== 教授的开场与柱坐标下的形式

#knowledgebox[
  *材料 10 页视频转录，教授的原话（照录）*：“那我们做一个例题。”
  “*让我求一个立体锥绕 $z$ 轴的转动惯量，这个锥在 $z = a r$ 与 $z = b$ 之间。*”
]

#knowledgebox[
  *原笔记自测题的答案*（原文，原为 practicebox）：为什么这道题里“到 $z$ 轴的距离”就是 $r$？
  因为*柱坐标里的 $r$ 本来就是“到 $z$ 轴的距离”*，而转动惯量的定义要求“到转轴距离的平方”。

  所以绕 $z$ 轴的转动惯量可以直接写成

  $ I_z = integral.triple r^2 delta dif V $

  *转动惯量的表达式在柱坐标下变得极其简洁*——这也是柱坐标特别适合处理“绕轴旋转”问题的原因。
]

=== 例题：实心锥绕 $z$ 轴的转动惯量（材料 10 页原题）

#importantbox[
  *材料 10 页给出的题目（照录）*：

  “*这里是原题：*求一个实心锥绕 $z$ 轴的转动惯量，这个锥在柱坐标下被描述为
  【$z = a r$ 与 $z = b$ 之间的实心体】，其中 $a$ 与 $b$ 是常数。假设密度恒为【$1$】。”

  “为了答案唯一，所有积分限必须满足 $A < B$。”
]

#importantbox[
  换积分顺序之后的读限（这是本题的全部难点）：

  #booktabs-table(
    columns: (1.4fr, 1.6fr, 2.6fr),
    table.header([*层*], [*积分限*], [*读法*]),
    [外层（$theta$）],
    [$0 <= theta <= 2 pi$],
    [旋转对称],
    [中层（$z$）],
    [$0 <= z <= b$],
    [*高度从 $0$ 到 $b$*],
    [内层（$r$）],
    [$0 <= r <= z slash a$],
    [*对固定的高度 $z$，截面是一个圆盘*],
  )

  *与“先 $z$”的版本对照*：

  #booktabs-table(
    columns: (1.2fr, 1.4fr, 1.4fr, 2fr),
    table.header([*顺序*], [*$z$ 的限*], [*$r$ 的限*], [*哪一种更好写*]),
    [先 $z$],
    [$a r <= z <= b$],
    [$0 <= r <= b slash a$],
    [—],
    [先 $r$],
    [$0 <= z <= b$],
    [$0 <= r <= z slash a$],
    [*截面是圆盘时更自然*],
  )

  *两者的积分限完全不同，但算出的转动惯量必然相同*。
]

#knowledgebox[
  *为什么“先 $r$”的顺序里 $r$ 的上界是 $z slash a$*：因为对固定的高度 $z$，
  锥的*水平截面是一个圆盘*，它的半径由锥面方程 $z = a r$ 解出：$r = z slash a$。
]

== 关键点

*转动惯量 $=$ “把每个质量微元乘以它到轴的*距离平方*，再加起来”*：
质点情形是 $m r^2$，连续体情形是 $integral.double_R r^2 delta dif A$（三维：$integral.triple r^2 delta dif V$）。
它衡量的是“绕这条轴转起来有多费劲”——在转动的世界里，它扮演的角色与质量在平动里完全平行
（动能 $1\/2 I omega^2$ 对 $1\/2 m v^2$）。*绕哪条轴，就用哪条轴的距离*：绕 $z$ 轴是 $x^2 + y^2$（极坐标下就是 $r^2$），
绕 $x$ 轴是 $y^2$，绕 $y$ 轴是 $x^2$。

== 变式检验

#enum(
  numbering: "1.",
  [*换个轴*：同一块板，$I_0 = I_x + I_y$（垂直轴定理）。所以只要算出其中两个，第三个自动到手——
    这也解释了为什么“绕 $z$ 轴”的公式最好用（它在极坐标下就是一个 $r^2$）。],
  [*换个维度*：三维里 $I_z = integral.triple (x^2 + y^2) delta dif V = integral.triple r^2 delta dif V$（柱坐标），
    *表达式与二维完全同形*——因为柱坐标的 $r$ 天生就是“到 $z$ 轴的距离”。],
  [*换个积分顺序*：锥体那题“先 $z$”与“先 $r$”的限完全不同（见上表），但结果必然相同；
    选顺序的标准是“哪一层的截面形状更简单”。],
)

== 同类归类

- 与 *质量、质心*：同属“二重积分（三维：三重积分）的物理应用”，唯一变化是被积函数（问题 123 考纲第 8 条把它们并列）；
- 与 *极坐标*：$dif A = r dif r dif theta$ 里的那个 $r$ 与转动惯量里的 $r^2$ 天然合拍，所以“圆盘 $slash$ 圆环”型区域的转动惯量首选极坐标；
- 与 *物理*：转动惯量是刚体转动的“质量”，后续力学课程里会反复出现（$I$ 与 $m$ 的对应）。

== 易错点

#warningbox[
  #enum(
    numbering: "1.",
    [*把“到轴的距离”与“到原点的距离”混为一谈*：绕 $x$ 轴时距离是 $abs(y)$，不是 $sqrt(x^2 + y^2)$——
      记法是“问自己：点到这条轴的垂线有多长”。],
    [*忘记面积元里的 $r$*（原笔记列为“错误一”）：被积函数含 $r^2$、面积元含 $r$，相乘是 $r^3$；
      漏掉 $r$ 会整题算错。],
    [*三维里漏掉 $delta$ 或维度因子*：三维是 $integral.triple r^2 delta dif V$，
      柱坐标下 $dif V = r dif r dif theta dif z$——多出来的那个 $r$ 别丢。],
    [*把垂直轴定理记反*：是 $I_0 = I_x + I_y$（极转动惯量最大），不是 $I_0 = I_x - I_y$。],
  )
]
