// ═══════════════════════════════════════════════════════════════
// answer-note · 按日归档问答记录
// 结构：每个独立问题 = 一个一级标题（=），子问题用（== / ===）
// 轨道：数学轨（本日主题待记录；承接 10-16：18.02.3x 各讲顺序修复等待办，见本日起点）
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
  authors: ("answer-note",),
  date: datetime(year: 2026, month: 10, day: 17),
  abstract: [按日归档的问答记录：每个独立问题一个一级标题（=），子问题用（== / ===）；三问反思法（关键点/变式/同类归类）+ 讲课叙事流 + 判断框，结构与课程笔记同构。本日主题：问题 143 · 切片法（切面法）识别曲面的局限与可靠判据（上一条为 10-16 的问题 140–142 · 标量线积分几何理解与参数化（节选）、参数化定义符号辨析、三维球坐标图（CeTZ 重绘·数学约定版），均已收口）；本日问答自问题 143 起逐条追加。仍未收口的是 10-08 的问题 134 · 半球面平均距离（仍在"引导轮"状态）与 10-14 的问题 136 第 1 卷 · 线积分六道回忆题待答；另有 18.02.3x 各讲顺序修复等事项，见本日起点待办清单）],
  bibliography: none,
  figure-index: (enabled: true),
  table-index: (enabled: true),
  listing-index: (enabled: true),
)

// 关闭 ilm 模板默认的公式自动编号 (1),(2),……
#set math.equation(numbering: none)

= 📌 本日起点

新的一天，档案已按 answer-note 规范建好：今日所有问答按 `= 主题` 追加在本节之后，一条问答一个一级标题（本日编号自 *问题 143* 起）。

#importantbox[
  *上一次记录（10-16）* 见 `note/2026-10-16.typ`——那一日有*三条*记录：

  #booktabs-table(
    columns: (0.9fr, 2.9fr, 2.6fr),
    table.header([*编号*], [*主题*], [*状态*]),
    [问题 140],
    [标量线积分的几何理解与参数化——lec-04 笔记节选（铁丝密度、窗帘几何；$dif s$ 的斜边本质、化一元定积分、与参数化无关）],
    [*已收口*：节选归档 + 三问 + 易错点],
    [问题 141],
    [$S$、$R$ vs $RR$、$u v$ 平面与 $[0, 1] times [0, 1]$——参数化定义的符号与维度辨析],
    [*已收口*：四问分答（$S$ 泛指、$R$ ≠ $RR$、$u v$ 平面二维、$times$ = 笛卡尔积）+ 三问 + 易错点],
    [问题 142],
    [三维球坐标 $theta$、$phi$ 几何图示（CeTZ 重绘·数学约定版）],
    [*已收口*：按一般惯例修正标注（$x y$ 面内 $theta$、$z$ 轴 $phi$）+ 读图要点 + 约定提醒；原 SVG 收录已替换为重绘版],
  )
]

#warningbox[
  *待办清单（更新于 10-17，承接 10-16）*：

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

= 🧭 问题 143：切片法（切面法）识别曲面——是万能的吗？局限在哪

读者问：读到笔记第六节「曲面长什么样：从函数图像到旋转面」——几乎所有参数化曲面都可以通过切面法找出原型。这个方法万能的吗？有哪些局限？#footnote[来源：`~/note/2026/18.02.3x/lec01/notes.typ` 第六节「用切片法识别曲面」（材料第 4 页「Examples of Surfaces」例 9–10 与其操作定义）；局限部分的反例为补充构造（标注"补充"），数值均经手算核对。]

== 直接解答：不是万能的——它是启发式

*切片法不是判据，是"认脸术"（heuristic）*。笔记自己也只敢说"两条截线是同一种曲线的两支，这个曲面*通常*就是……旋转曲面"——"通常"两个字就是伏笔。

它的本质：只取 $y = 0$、$x = 0$ 两条*一维截线*（每个方向一刀），用来*猜*曲面类型。四类局限：

#booktabs-table(
  columns: (1.5fr, 2.6fr, 2fr),
  table.header([*局限*], [*反例（两刀下的假象）*], [*破法*]),
  [① 两刀不足以定曲面], [$z = sqrt(x^2 + y^2)$ 与 $z = abs(x) + abs(y)$ 的两条坐标截线完全相同], [补斜切（$x = y$）；标准式比对],
  [② "同种曲线"会误导], [$z = x^2 - y^2$：两刀都是抛物线，实际是*马鞍面*], [看开口方向与符号],
  [③ 只适用 $z = f(x, y)$ 型], [球面、柱面、环面、Möbius 带写不成单张高度图], [改用隐式 $F = 0$ 或参数化识别],
  [④ 切面方向是坐标轴特权], [$z = x y$：两刀都截出直线 $z = 0$，看不出是马鞍面], [换方向切；代数验证],
)

== 局限的细节

=== ① 两刀不够：圆锥 vs "菱形锥"

#importantbox[
  - $z = sqrt(x^2 + y^2)$（圆锥面）：$y = 0$ 截得 $z = abs(x)$，$x = 0$ 截得 $z = abs(y)$；
  - $z = abs(x) + abs(y)$（四棱锥面，补充构造）：$y = 0$ 截得 $z = abs(x)$，$x = 0$ 截得 $z = abs(y)$。

  两条坐标截线*一模一样*。但沿 $x = y$（第一象限）切：圆锥得 $z = sqrt(2) x$，四棱锥得 $z = 2 x$——不是同一张曲面。
]

=== ② 马鞍面陷阱：抛物线 ≠ 旋转抛物面

$z = x^2 - y^2$（双曲抛物面，hyperbolic paraboloid）在两条坐标面上都截得*抛物线*（$z = x^2$ 与 $z = -y^2$）。只看"曲线种类"会误判为旋转抛物面；关键差别在*开口方向*（一上一下）与沿 $x = y$ 的截线（$z = 0$ 的整条直线——双曲抛物面特有的直纹）。

=== ③ 非图形式曲面：切片法的框架不适用

球面 $x^2 + y^2 + z^2 = 1$ 无法写成单张 $z = f(x, y)$（上下半球各一张）；柱面、环面、Möbius 带同理。"固定 $x$ 或 $y$ 看截线、再判'绕轴旋转'"这套话只对图形式曲面成立。对隐式曲面仍可切片（如球切 $z = 0$ 得圆），但那只是*一个截面*，不是"原型判据"。

=== ④ 坐标轴特权与系数陷阱

只切 $x = 0$、$y = 0$，等于假设"特征方向沿坐标轴"：

#importantbox[
  - *反例 A（方向陷阱）*：$z = x y$ 的两条坐标截线都是直线 $z = 0$——完全看不出真身（旋转 45° 后即 $z = (u^2 - v^2) / 2$，双曲抛物面）；
  - *反例 B（系数陷阱）*：$z = x^2 + x y + y^2$ 与 $z = x^2 + y^2$ 在两条坐标面上的截线*完全相同*（$z = x^2$、$z = y^2$），但前者沿 $x = y$ 是 $z = 3 x^2$、后者是 $2 x^2$——前者不是旋转曲面。
]

== 可靠判据：切片"猜"，标准式"证"

#importantbox[
  三条可靠路线（按可用性选）：
  *① 旋转对称的代数判据*：曲面绕 $z$ 轴旋转（成为*旋转曲面*，surface of revolution）当且仅当存在一元函数 $g$ 使 $f(x, y) = g(x^2 + y^2)$；等价说法：极坐标下 $f$ 与 $theta$ 无关。
  *② 标准式比对*：配方/变形到标准形（$z = x^2 + y^2$ 旋转抛物面、$z^2 = x^2 + y^2$ 锥面、$x^2 + y^2 + z^2 = R^2$ 球面……），逐项核对（含系数）。
  *③ 参数化验证*：写出 $arrow(r)(u, v)$ 或隐式 $F(x, y, z) = 0$，按定义逐条核对它属于哪个标准族（与第六节之后的「四组练习」同一套思路）。
]

实际做题：*切片法用来快速猜与排除；标准式/参数化用来定案*。多切几刀（含 $x = y$ 等斜方向）可以压低误判，但只有代数验证能给出保证。

== 关键点

#importantbox[
  一句话：*切片法是启发式，不是判据*。它在常见二次曲面居中、正放、无交叉项时很灵；一旦曲面斜放、含 $x y$ 项、不是图形式，或两条截线碰巧相同（圆锥 vs 四棱锥），它就会失败。要"证"曲面原型，只能回到标准式或参数化。
]

== 变式检验

#enum(
  numbering: "1.",
  [*马鞍面 $z = x^2 - y^2$*：找一条能把它与旋转抛物面区分开的截线（提示：沿 $x = y$ 切，双曲抛物面会出现 $z = 0$ 的整条直线）。],
  [*椭圆抛物面（elliptic paraboloid）$z = x^2 + 2 y^2$*：两条坐标截线是 $z = x^2$ 与 $z = 2 y^2$——*系数不同*就是对"旋转曲面"的第一声警报；再沿 $x = y$ 复核（$z = 3 y^2$ 与 $z = 2 y^2$ 不同）。],
  [*补充构造 $z = abs(x) + abs(y)$*：用它检验任何"两刀定曲面"的说法——沿 $x = y$ 一切，$2 x$ 与 $sqrt(2) x$ 立刻分家。],
)

== 同类归类

- 与 *lec01 第六节的「切片法操作定义」*：那里写的是"通常"——本条的四个局限正是"通常"的边界；读那一节时可把"通常"理解成"在标准位置、二次曲面、无交叉项时"；
- 与 *同页「四组练习」（从参数化倒推曲面）*：那是"从映射认曲面"（读参数范围、固定一个看轨迹），与"从方程切片"是互补的两条认脸路线，最终都落在标准型比对上；
- 与 *lec03 的曲面面积/法向量*：认脸只是第一步；后续计算依赖的是参数化（$arrow(r)_u times arrow(r)_v$）或隐式梯度（$nabla F$），切片法不提供这些硬信息。

== 易错点

#warningbox[
  #enum(
    numbering: "1.",
    [*把"两刀相同"当"曲面相同"*：圆锥 vs 四棱锥、$z = x y$（两刀皆直线）都是反例——两刀不够，必要时补斜切；],
    [*只看曲线种类、不看开口与系数*：$z = x^2 - y^2$（马鞍）与 $z = x^2 + 2 y^2$（椭圆抛物面）的截线都是抛物线——符号与系数才是关键；],
    [*对非图形式曲面硬套*：球面/柱面/环面写不成 $z = f(x, y)$，应改用隐式或参数化方式识别；],
    [*把启发式当证明*：切片结论须经标准式/参数化验证后才能定案。],
  )
]
// ══════════════════════════════════════════════════════════════════════
