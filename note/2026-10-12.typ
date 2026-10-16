// ═══════════════════════════════════════════════════════════════
// math-answer-note · 按日归档问答记录
// 结构：每个独立问题 = 一个一级标题（=），子问题用（== / ===）
// 轨道：数学轨（18.02.3x 课程地图 / 考研数学一优先级）
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
  date: datetime(year: 2026, month: 10, day: 12),
  abstract: [按日归档的问答记录：每个独立问题一个一级标题（=），子问题用（== / ===）；三问反思法（关键点/变式/同类归类）+ 讲课叙事流 + 判断框，结构与课程笔记同构。本日主题：18.02.3x（多元微积分第三单元）全 12 讲的*考研优先级地图*——哪几讲是大题发动机、哪几讲只取零件、哪几讲整块跳过，外附 MIT 记号与考纲记号的翻译表、3x 覆盖不到的另补清单（上一条为 10-08 的问题 134 · 半球面平均距离，仍在"引导轮"状态未收口；10-09 $tilde$ 10-11 均未新增问答，本日问答自问题 135 起逐条追加）。],
  bibliography: none,
  figure-index: (enabled: true),
  table-index: (enabled: true),
  listing-index: (enabled: true),
)

// 关闭 ilm 模板默认的公式自动编号 (1),(2),……
#set math.equation(numbering: none)

= 📌 本日起点

新的一天，档案已按 math-answer-note 规范建好：今日所有问答按 `= 主题` 追加在本节之后，一条问答一个一级标题（本日编号自 *问题 135* 起）。

#importantbox[
  *上一次记录（10-10）* 见 `note/2026-10-10.typ`——那一日*没有新增问答*，只是重建了起点与待办；10-11 则只有一次 git 提交（`e569574 docs(note): 新增 2026-10-07 ~ 2026-10-10 每日问答笔记`），同样无新问答。至今仍未收口的是 10-08 落下的问题 134：

  #booktabs-table(
    columns: (1fr, 3fr, 2.6fr),
    table.header([*编号*], [*主题*], [*结论一句话*]),
    [问题 134],
    [单位半球面（球面 $S: x^2 + y^2 + z^2 = 1$ 的上半部分 $H$，$z > 0$）上的点到原点的"平均距离"——*引导轮：只落了脚手架，用户尚未作答*],
    [已落盘题干照录（含题首 "you will use spherical coordinates" 的钩子）+ 三层入口（`sphere`/`ball` 之辨 $->$ 写出 $abs(O P)$ 的取值 $->$ 写出面积平均式）$+$ 两个对照（换成上半球体 / 换成到 $z$ 轴的距离）；五模块解答*待补全*],
  )
]

#warningbox[
  *待办清单（更新于 10-12，承接 10-10）*：

  #enum(
    numbering: "1.",
    [*问题 134 的引导尚未收口*——等用户回答三层入口（$H$ 是曲面还是实体？$abs(O P)$ 在 $H$ 上取哪些值？被平均量 $f$ 是什么？）并给出选择题选项截图，随后补齐 `直接解答 / 关键点 / 变式检验 / 同类归类 / 易错点` 五模块（标题去掉"引导轮"字样）],
    [格林公式的*补线法*——仍未展开（考研高频技巧：边界不闭合时补线，再套格林公式）。今天问题 135 的"补面法"图是它在三维的*同胞*，二维版本仍待补],
    [考纲第八章「常微分方程」在工作区*仍无*对应笔记材料（张宇 30 讲含此章，可作主材）],
    [*新增*：问题 135 给出的学习顺序（`lec04 -> lec03 -> lec05/06 -> lec08 -> lec07`）尚未落成"逐讲打勾"的进度表——若要执行，可在后续日期文件中维护],
  )
]

// ══════════════════════════════════════════════════════════════════════
// 本日问答自下方开始追加：一条问答一个一级标题（= 主题）
// ══════════════════════════════════════════════════════════════════════

= 🎯 问题 135：18.02.3x 全 12 讲里，考研最该学哪些部分？

读者问：更新今天的日期文件，同时告诉我 18.02.3x 中对于考研最需要学习哪些部分的内容。#footnote[来源：18.02.3x 课程笔记 `~/note/2026/18.02.3x/lec01–lec12/notes.typ` 各讲的节标题与正文（行号见下）；考研数学一《考试大纲》「多元函数积分学」考试内容与考试要求，与问题 131 同一份考纲（`note/2026-10-02.typ` 第 905–917 行）。]

== 直接解答：12 讲压缩成"2 台发动机 $+$ 3 个零件"

先给结论，再讲为什么。

#importantbox[
  18.02.3x 的 12 讲在考研数学一里只卖*两样东西*：*高斯公式的"补面 $slash$ 挖球"套路*（`lec05` $+$ `lec06`）与*斯托克斯公式的"空间闭曲线换曲面积分"*（`lec08`）。其余各讲都是给这两台发动机*供零件的*——真正必须拿到的零件只有三个：面积微元 $dif S$（`lec03`）、通量与 $hat(n) dif S$ 打包（`lec04`）、旋度为零 $->$ 保守场与势函数（`lec07`）。

  一句话记法：*"两机三件，其余看心情。"*
]

#booktabs-table(
  columns: (0.8fr, 2.4fr, 2.2fr, 0.9fr),
  table.header([*讲次*], [*MIT 主题（英文原名）*], [*考研对应考点*], [*优先级*]),
  [`lec01`], [Parametrizing Surfaces (Part 1)：从曲线到曲面、柱坐标], [曲面参数化（曲面积分的前置）], [★★],
  [`lec02`], [Parametrizing Surfaces (Part 2)：球坐标、Möbius 带], [球坐标下的曲面面积微元], [★★],
  [`lec03`], [Surface Integrals：叉积、面积微元与隐式曲面], [*曲面面积*、*第一类曲面积分*], [★★★★],
  [`lec04`], [Vector Fields and Flux：从曲线通量到曲面通量], [*第二类曲面积分*（通量）], [★★★★★],
  [`lec05`], [Divergence Theorem：陈述与例], [*高斯公式*], [★★★★★],
  [`lec06`], [Divergence Theorem：证明与应用], [*高斯公式* $+$ 散度计算], [★★★★],
  [`lec07`], [Line Integrals and Curl：功、保守场与势函数], [路径无关、*势函数*], [★★★],
  [`lec08`], [Stokes' Theorem：旋度的通量与边界上的环量], [*斯托克斯公式*], [★★★★★],
  [`lec09`], [Stokes' Theorem Continued：可定向性、拓扑与路径无关], [单连通（概念）、定向], [★],
  [`lec10`], [Electrostatics：库仑定律、电势、Gauss 定律], [*超纲*（可当高斯公式的物理直觉）], [☆],
  [`lec11`], [Magnetostatics：Biot-Savart、Ampère 环路定律], [*超纲*], [☆],
  [`lec12`], [Electromagnetism：Maxwell 方程组、电磁波、辐射], [*超纲*], [☆],
)

*建议投入*：`lec03` $+$ `lec04` $+$ `lec05` $+$ `lec06` $+$ `lec08` 这五讲吃掉 *85%* 的学习价值；`lec01`/`lec02`/`lec07`/`lec09` 共占 15%；`lec10`–`lec12` 对考研的边际收益接近零。

== 第一梯队（必须吃透）：两台发动机

=== 发动机一：`lec05` $+$ `lec06` —— 散度定理（Divergence Theorem）就是高斯公式

考纲对它的措辞是最高一级的"*掌握用高斯公式计算曲面积分*"——这是解答题级别的要求，也是每年数一"多元函数积分学"大题的默认解法。

定理本身（`lec06` 第 442 行「定理 7」照录）在中国教材里的写法是：

$
integral.double_Sigma P dif y dif z + Q dif z dif x + R dif x dif y = integral.triple_Omega (P_x + Q_y + R_z) dif V
$

符号表：

- $Sigma$ —— *闭*曲面的外侧（左端是第二类曲面积分，即通量）；若题目给的曲面不闭，必须*补面*；
- $Omega$ —— $Sigma$ 围出的空间区域（右端是三重积分）；
- $P_x + Q_y + R_z$ —— 向量场 $arrow(F) = (P, Q, R)$ 的*散度*（divergence），即 $nabla dot arrow(F)$；
- 定理的读法：*穿出闭曲面的总通量 $=$ 内部"净生成量"的体积分*（`lec06` 第 326–438 行的源与汇直觉）——这正是它在物理里成为 Gauss 定律的原因。

*必会的三个动作*（考研的全部套路都在这里）：

#enum(
  numbering: "1.",
  [*判闭*：曲面是闭的吗？闭则直接套；不闭则进入第 2 步。],
  [*补面*：补上一块（或几块）好算的曲面凑成闭曲面，套高斯公式，再*把补的那几块单独减掉*——补面的定向必须也朝"外"（如球面的底面圆盘，外侧法向朝下）。下图就是这一步的几何。],
  [*挖球*：若场在区域内*有奇点*（典型例子是点电荷场 $arrow(F) = arrow(r) slash r^3$ 在原点的奇点），高斯公式不能直接用，要*以奇点为中心挖去一个小球* $->$ 闭区域变成"双层壳"，再套高斯公式（`lec06` 第 523 行「例 18」与 `lec09` 的拓扑段落是同一思想的深浅两版）],
)

#figure(
  cetz.canvas(length: 1.5cm, {
    import cetz.draw: *
    // 透视参数：底面圆的 y 半径压到 0.55（球心在原点，赤道半径 2）
    let ball(t) = (2 * calc.cos(t), 2 * calc.sin(t))
    let ell(t) = (2 * calc.cos(t), 0.55 * calc.sin(t))
    let dome = range(0, 181, step: 5).map(t => ball(t * 1deg))
    let ring = range(0, 361, step: 6).map(t => ell(t * 1deg))
    // ① 补上的底面圆盘（整个椭圆，浅蓝填充）
    line(..ring, close: true, stroke: 0.9pt + rgb("#8fb0d8"), fill: rgb("#e8f0fa"))
    // ② 原曲面：上半球面的轮廓（实线，上半圆）
    line(..dome, stroke: 1.2pt)
    // ③ 外侧法向箭头：球面两支（指向外），底面一支（指向下）
    line((1.53, 1.29), (2.45, 2.06), stroke: 0.9pt + rgb("#d64541"), mark: (end: "stealth"))
    line((-1.53, 1.29), (-1.95, 1.64), stroke: 0.9pt + rgb("#d64541"), mark: (end: "stealth"))
    line((1.00, -0.48), (1.00, -1.25), stroke: 0.9pt + rgb("#d64541"), mark: (end: "stealth"))
    // ④ 标注
    content((-0.15, 1.60), unnumbered($S$))
    content((-1.05, 0.10), unnumbered($Sigma_1$))
    content((2.62, 2.18), unnumbered($hat(n)$), fill: rgb("#d64541"))
    content((1.12, -1.42), unnumbered($hat(n)$), fill: rgb("#d64541"))
  }),
  caption: [补面法的几何（CeTZ 重绘）：原曲面 $S$ 是不闭的上半球面（上半圆的实线轮廓），补上一块底面圆盘 $Sigma_1$（浅蓝填充）后，$S union Sigma_1$ 成为闭曲面；红箭头是两片曲面各自的*外侧*法向 $hat(n)$——球面朝外、底面朝下。图中能读出补面法的全部要件：闭曲面的两块拼合、外侧定向、以及"补的那块最后要单独减掉"（$integral.double_S = integral.double_(S union Sigma_1) - integral.double_(Sigma_1)$）。],
)

#knowledgebox[
  二维的同款操作是*格林公式的补线法*（边界不闭时补一段线），三维只是把"补线"升级成"补面"、把"挖洞"升级成"挖球"。你待办清单里那条"补线法未展开"，可以先拿这张图当三维预告：*补上去的那块永远要减掉，且定向要跟主体一致（都朝外）*。
]

*`lec06` 里可以跳过的部分*：扩散方程（热方程）的完整推导（第 614–722 行）——它漂亮，但考研不考偏微分方程；读它是为了理解"散度定理 $=$ 守恒律的数学形式"这层直觉，时间紧时看结论即可。

=== 发动机二：`lec08` —— Stokes 定理（斯托克斯公式）

考纲的措辞是"*会用斯托克斯公式计算曲线积分*"——注意它的方向与高斯公式相反：*把难算的空间闭曲线积分，换成一张曲面的通量积分*。

$
integral.cont_Gamma P dif x + Q dif y + R dif z = integral.double_Sigma (R_y - Q_z) dif y dif z + (P_z - R_x) dif z dif x + (Q_x - P_y) dif x dif y
$

符号表：

- $Gamma$ —— 空间中的*闭*曲线（左端是第二类曲线积分，即环量）；
- $Sigma$ —— 以 $Gamma$ 为边界的*任意*一张曲面，*朝向必须与 $Gamma$ 的绕行方向满足右手法则*（`lec08` 第 540 行「定向：让曲线与曲面的方向对上」的"行走规则"）；
- $(R_y - Q_z,\ P_z - R_x,\ Q_x - P_y)$ —— 旋度（curl）$nabla times arrow(F)$ 的三个分量；
- 右端可以写成更统一的向量形式 $integral.double_Sigma (nabla times arrow(F)) dot hat(n) dif S$——这也是笔记里的主写法（`lec08` 第 489 行「定理 10」）。

*三条高频用法*（`lec08` 第 780–938 行的"例题详解"一栏就是按这几种用法铺的）：

#enum(
  numbering: "1.",
  [*曲面可任选*（第 514 行 $+$ 用法三）：只要边界是 $Gamma$，$Sigma$ 可以换成最好算的那张——通常换成 $Gamma$ 所在的*平面圆盘 $slash$ 三角形*，$hat(n)$ 成为常向量，面积也现成。],
  [*旋度为零则环量为零*（用法四）：$nabla times arrow(F) = arrow(0)$ 时任何闭曲线上的环量为零，直接下结论，不用算积分。],
  [*退化用法*（用法五）：把曲面积分退回线积分，用于验证或处理 $hat(n) dif S$ 有奇点的情形。],
)

=== 两台发动机的辨析（超高频小题）

#booktabs-table(
  columns: (1.2fr, 1.4fr, 1.4fr, 1.6fr),
  table.header([*定理*], [*边界对象*], [*内部对象*], [*记法安全词*]),
  [高斯公式], [一张*闭曲面*], [一个*体积*], [边界是"面" $->$ 用散度],
  [斯托克斯公式], [一条*闭曲线*], [一张*曲面*], [边界是"线" $->$ 用旋度],
)

#knowledgebox[
  笔记 `lec08` 第 923 行的记法很省事：*"看边界是面还是线"*——边界是闭曲面的用高斯（散度配体积），边界是闭曲线的用斯托克斯（旋度配曲面）。拿到题先问这一句，方向立刻定下来，不必凭记忆猜。
]

== 第二梯队（必须拿到的零件）：`lec03` 与 `lec04`

大题的*骨头*是两台发动机，但*血肉*是这两个零件——少了它们，定理写出来了也算不下去。

=== 零件一：`lec03` —— 面积微元 $dif S$ 的三个来源

考研里算第一类曲面积分、曲面面积、以及判断"该用哪个 $dif S$"，全靠这三条：

$
dif S = norm(arrow(r)_u times arrow(r)_v) dif u dif v quad "（参数化）" quad, quad dif S = sqrt(1 + f_x^2 + f_y^2) dif x dif y quad "（图像 z = f(x, y)）"
$

符号表：

- $arrow(r)(u, v)$ —— 曲面的参数化，$arrow(r)_u, arrow(r)_v$ 是两个偏导向量；它们的叉积模长就是"参数小方块"被拉伸的倍数（`lec03` 第 543 行「曲面面积的定义」、第 936–952 行的"分割—求和—取极限"五步）；
- 第二式是图像型曲面的特化：第三个分量恒为 $1$，于是模长写成了根号；
- 隐式曲面 $G(x, y, z) = c$ 没有现成的参数化，*法向量由梯度 $nabla G$ 给出*（`lec03` 第 1000–1016 行）——这一条在通量题里比参数化更快。

#warningbox[
  考试里最常出错的是"三条来源混着用"：题目给 $z = f(x, y)$ 却去硬参数化，或题目给隐式曲面却去解 $z$。*判据*：函数图像 $->$ 根号式；能一眼看出角度的（球面、柱面、锥面）$->$ 参数化；只有方程没有解法的 $->$ 梯度法向量。
]

=== 零件二：`lec04` —— 通量与 $hat(n) dif S$ 的"打包"

这就是国内教材里的*"合一投影法"*，也是 `lec04` 第 697–738 行那一节的实质。曲面由 $z = f(x, y)$ 给出时，法向量与面积元素各自都很难看，但它们的*乘积*极其简洁：

$
hat(n) dif S = (-(partial f)/(partial x), -(partial f)/(partial y), 1) dif x dif y
$

符号表：

- $-(partial f) slash (partial x), -(partial f) slash (partial y)$ —— 曲面在两个水平方向的倾斜（取负号）；
- 常数 $1$ —— 第三分量，它保证这个向量指向"上方"（指向下就是整体取负）；
- $dif x dif y$ —— 投影区域上的面积微元；
- 于是通量积分为 $integral.double_S arrow(F) dot hat(n) dif S = integral.double_R arrow(F) dot (-f_x, -f_y, 1) dif x dif y$，*所有 $z$ 都先用 $f(x, y)$ 替换掉，再去定 $x, y$ 的范围*（操作顺序是笔记里专门强调的，第 733 行）。

#importantbox[
  把它翻译成考纲语言就更清楚了：这个向量正是第二类曲面积分的三个"微分形式" $(dif y dif z,\ dif z dif x,\ dif x dif y)$。

  三条来源：$dif y dif z$ 是"投影到 $y z$ 平面"那一项，$dif z dif x$ 投到 $z x$ 平面，$dif x dif y$ 投到 $x y$ 平面。*考试写 $P dif y dif z + Q dif z dif x + R dif x dif y$ 时脑子里的画面，应该是这三个投影。*
]

另外两个必须背熟的特例（`lec04` 第 493–745 行）：*球面*的法向就是径向 $->$ 通量里出现 $R^2$ 与 $sin phi$ 那一套；*柱面*的法向永远水平 $->$ 与 $z$ 无关。这两类曲面在高斯公式大题里出现的频率最高。

== 第三梯队（只取一瓢）：`lec01`/`lec02`/`lec07`/`lec09`

#booktabs-table(
  columns: (1fr, 3.2fr, 1.4fr),
  table.header([*讲次*], [*只取哪一个瓢*], [*其余部分*]),
  [`lec01`], [能自己写出常见曲面的参数化（$z = f(x,y)$ 型、旋转面、柱面）$+$ "小方块映成平行四边形"的线性近似], [习题课的动画细节可略读],
  [`lec02`], [*球坐标*与球面面积微元 $dif A = sin phi dif phi dif theta$（第 689–803 行）——球面积分必用；两套约定（物理 $slash$ 数学）只需认得出题用的是哪套], [Möbius 带（第 366–464 行）、球坐标基向量的求导练习：*超纲*],
  [`lec07`], [两条判据（混合偏导相等 $slash$ $nabla times arrow(F) = arrow(0)$，第 387–492 行）$+$ 共形势函数的两种构造法（逐项积分、沿折线积分，第 508–566 行）$+$ 微分形式恰当性（第 566–595 行）], [螺旋线上的线积分习题课（第 763 行起）：练手可做，非考点核心],
  [`lec09`], [*定向（orientation）*与右手法则、路径无关的三个等价说法（第 543–590 行）], [Klein 瓶、实射影平面、Seifert 曲面（第 389–539 行）与不可定向曲面专题（第 610–703 行）：*纯拓扑展览，超纲*],
)

#knowledgebox[
  这一档的判断标准很简单：*问自己"这条结论会不会出现在题干的条件里"*。球坐标面积微元会（"球面 $x^2 + y^2 + z^2 = a^2$ 上的积分"）；Möbius 带不会（考研不考不可定向曲面，中国教材连"定侧"都只用"外侧 $slash$ 内侧"这种朴素说法）。势函数会（"验证 $...$ 是某函数的全微分"）；Klein 瓶不会。
]

== 整块跳过：`lec10`–`lec12` 电磁学

三讲共 2600 余行，讲的是静电学、静磁学与 Maxwell 方程组——*考研数学一不考物理*。有两个例外值得各花十分钟：

#enum(
  numbering: "1.",
  [`lec10` 的 *Gauss 定律*一节（第 575–696 行）：$integral.double_S arrow(E) dot hat(n) dif S = Q_"内" slash epsilon_0$ 就是高斯公式的物理版。看懂它，你对"通量 $=$ 内部源强"的直觉会从公式升格为物理图像，做大题时更容易一眼看出该补面还是该挖球。],
  [`lec12` 的 *Maxwell 方程组*一览（第 463–494 行）：四条方程与散度、旋度、高斯、斯托克斯一一对应，是"整个 3x 其实只有一个想法"的最佳总结页——当复习索引看，不必推导。],
)

== 3x 覆盖不到、数一却必考的（另补清单）

#warningbox[
  18.02.3x 只负责"多元函数积分学"的*第三段*（曲面与场论）。考纲里同一章的以下内容*不在*这 12 讲里，别以为看完 3x 就齐了：

  #enum(
    numbering: "1.",
    [*两类曲线积分*（对弧长、对坐标）与*格林公式*——在 18.02.1x $slash$ 2x（`~/note/2026/18.02.2x/lec-08–lec-09`）],
    [*三重积分的计算*：直角坐标的"先一后二 $slash$ 先二后一"、柱坐标、球坐标——高斯公式的右端全靠它；3x 只用不教，主材在 18.02.2x 与张宇 30 讲],
    [*多元函数微分学*：偏导、全微分、方向导数与梯度、空间曲线的切线与法平面、曲面的切平面与法线（对应考纲第五章）],
    [*重积分 $slash$ 曲线曲面积分的物理应用*：质量、质心、形心、转动惯量、引力、功、流量（考纲要求第 8 条）],
    [*第一类曲面积分的对称性技巧*（奇偶性、轮换对称）——中国教材特有的"降维打击"手法，MIT 讲义里没有],
  )
]

== 记号翻译表：MIT 写法 $->$ 考纲写法

这是本次问答里*最实用的一张表*：你的笔记是英文材料写的，考卷是中文记号写的，做题时需要在两种语言之间实时翻译。

#booktabs-table(
  columns: (1.5fr, 1.8fr, 2.2fr),
  table.header([*概念*], [*MIT $slash$ 18.02.3x 笔记*], [*考研 $slash$ 国内教材*]),
  [曲面微元向量], [$hat(n) dif S$（法向 $times$ 面积）], [$dif arrow(S) = (cos alpha, cos beta, cos gamma) dif S$（方向余弦）],
  [通量], [$integral.double_S arrow(F) dot hat(n) dif S$], [第二类曲面积分 $integral.double_Sigma P dif y dif z + Q dif z dif x + R dif x dif y$],
  [函数图像型通量], [$(-f_x, -f_y, 1) dif x dif y$], [*合一投影法*：三投影合并成一次二重积分],
  [散度定理], [Divergence Theorem], [*高斯公式*],
  [斯托克斯定理], [Stokes' Theorem], [*斯托克斯公式*],
  [散度与旋度], [$nabla dot arrow(F)$, $nabla times arrow(F)$], [散度 $"div" arrow(F)$、旋度 $"rot" arrow(F)$（旧书也写 $"curl"$）],
  [保守场], [conservative $slash$ gradient field], [$"grad" f$ 型场，路径无关，全微分存在],
  [单连通], [simply connected], [单连通区域（$nabla times arrow(F) = arrow(0)$ 能反推保守场的*前提*）],
)

== 关键点

一句话：*18.02.3x 的价值高度集中在 5 讲里*——`lec03`/`lec04` 提供面积微元与通量这两个零件，`lec05`/`lec06` 的高斯公式与 `lec08` 的斯托克斯公式是两台发动机；考试里"多元函数积分学"的大题，几乎都能还原成"*先判断闭不闭 $->$ 不闭就补 $->$ 套高斯*"或"*闭曲线 $->$ 换一张好算的曲面套斯托克斯*"这两条流水线。其余 7 讲里，`lec01`/`lec02` 取参数化与球坐标、`lec07` 取判据与势函数、`lec09` 取定向与路径无关，`lec10`–`lec12` 整块跳过。

*学习顺序建议*：`lec04`（先有通量的画面）$->$ `lec03`（再补面积微元的算法）$->$ `lec05` $+$ `lec06`（发动机一）$->$ `lec08`（发动机二）$->$ `lec07`（回补保守场）$->$ 其余按需回看。之所以把 `lec04` 放最前：*通量的物理画面一旦建立，后面所有公式都变成"重算同一个量"，只是换了工具*。

== 变式检验

#enum(
  numbering: "1.",
  [*补面（`lec05` $slash$ `lec06` 套路）*：设 $Sigma$ 是上半球面 $z = sqrt(a^2 - x^2 - y^2)$ 的上侧，求 $integral.double_Sigma x dif y dif z + y dif z dif x + z dif x dif y$。
  曲面*不闭* $->$ 补上底面圆盘 $Sigma_1: z = 0$（外侧法向朝下）$->$ 闭曲面 $Sigma union Sigma_1$ 上用高斯：$nabla dot arrow(F) = 3$，得 $3 dot (2 slash 3) pi a^3 = 2 pi a^3$；补面自身的通量为 $0$（场在 $z = 0$ 上第三分量为 $0$），所以原积分就是 $2 pi a^3$。
  *验算*：直接算也行——法向 $hat(n) = arrow(r) slash a$，被积函数 $= arrow(F) dot hat(n) = a$，乘上面积 $2 pi a^2$ 得同一个数。*两条路数一致，说明补面时"最后减掉补面"这一步没做错。*],
  [*挖球（奇点）*：$arrow(F) = arrow(r) slash r^3$（点电荷场），求它穿出球面 $r = a$ 的通量。
  $nabla dot arrow(F) = 0$（原点之外处处），若直接套高斯公式会得到 $0$——*错在原点那个奇点*。正确做法是挖去半径 $epsilon$ 的小球：夹层区域上散度为零，故外球面通量 $=$ 内球面通量的相反数 $= 4 pi$。
  *这一步与二维里"挖洞"（问题 126 的扩展格林定理）是同一种操作的升维版。*],
  [*Stokes 的曲面任选*：求 $integral.cont_Gamma y dif x + z dif y + x dif z$，$Gamma$ 是平面 $x + y + z = 1$ 与三个坐标面的交线（三角形边界）。
  直接算要分三段；用斯托克斯把 $Sigma$ 取成*那张三角形平面*（$hat(n) = (1,1,1) slash sqrt(3)$ 是常向量）：$nabla times arrow(F) = (-1, -1, -1)$，被积函数为 $-3 slash sqrt(3) = -sqrt(3)$，三角形面积 $sqrt(3) slash 2$，得 $-3 slash 2$（取负是因为按右手法则该取朝上的定向）。*这正是考纲"会用斯托克斯公式计算曲线积分"的标准场景。*],
  [*记号翻译训练*：把上面第三题改用考纲记法重写一遍——$integral.double_Sigma (R_y - Q_z) dif y dif z + dots$ 与 $integral.cont_Gamma P dif x + Q dif y + R dif z$ 的形式。*同一个题，两个语言；能自由互译，才算真会。*],
)

== 同类归类

- 与 *问题 131（考研考 3D 曲面积分吗）*：那条回答的是"*考不考*"（数一必考，且是大题主力），本条回答的是"*怎么学*"——先读 131 的考纲层级表选定范围，再用 135 的顺序分配时间；
- 与 *问题 123（高数考纲八章）*：本题覆盖的是其中第六章「多元函数积分学」的后半段（前面曲线积分与格林公式在 18.02.2x）；
- 与 *问题 130（div 与 curl 各有什么用）*：那两条结论在这里落地成了两台发动机——散度配高斯、旋度配斯托克斯；
- 与 *问题 126（扩展格林定理要加辅助线 $C_3$）*：三维的"挖球"是它的升维版，都是"把奇点排除在区域之外"；
- 与 *待办清单里的"格林公式补线法"*：与本题图中的*补面法*同构——二维补线、三维补面，补上的那块必须单独扣除且定向一致。

== 易错点

#warningbox[
  #enum(
    numbering: "1.",
    [*把"MIT 讲得深"当成"考研要考"*：`lec10`–`lec12` 的电磁学、`lec09` 的拓扑、`lec02` 的 Möbius 带都讲得很认真，但它们*一题都不会考*。反过来，`lec10` 的 Gauss 定律虽然超纲，却是理解高斯公式的好梯子——*取舍的标准永远是考纲，不是材料的篇幅*。],
    [*忘了高斯公式的三个前提*：曲面*闭*、定向*外侧*、场内*无奇点*。缺一条就不能直接用；补面与挖球就是为补齐前两条与第三条而生的。],
    [*补面忘了减*：补的那块 $integral.double_(Sigma_1)$ 必须从结果里减掉（等价于"加进闭曲面再扣出来"）——符号写错是这一步最常见的失分点。],
    [*Stokes 的定向反了*：$Gamma$ 的绕行方向与 $hat(n)$ 的方向必须满足右手法则；方向反了答案差一个负号，而这类题的负号很好错。],
    [*两类曲面积分混用*：第一类 $integral.double_Sigma f dif S$ 与曲面朝哪一侧*无关*；第二类 $integral.double_Sigma P dif y dif z + dots$ 与定向*强相关*。题干问"曲面面积"给的是第一类，问"通量"给的是第二类。],
    [*把"曲面面积"当成"曲面积分"*：面积是 $integral.double_Sigma dif S$（一个数），别被 $dif S$ 里那根根号吓到而漏掉它其实只是"把 $dif x dif y$ 换成缩放因子"。],
  )
]
