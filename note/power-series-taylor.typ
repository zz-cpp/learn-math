// ═══════════════════════════════════════════════════════════════
// MIT 18.01.3x · Calculus 1C · Unit 3
// Power Series and Taylor Series —— 幂级数与 Taylor 级数
// 材料：9 段视频转录（intro, v1~v8）+ taylor_summary-1.pdf（5 页）
//       + MIT Learn 网页 9 页（block-1~8 视频页与官方练习、block-9 课程总览）
// 写作规范：math-note skill（第零律~第五律）+ material-to-notes 管线
// 修订记录：2026-09-02 重做——① 修正例 4：Σx^(2n)/(2n)! 真身为 cosh x
//   （Christine 口误说成 cos x，官方网页明确标注该错误）；
//   ② 补入全部官方网页练习（block-1~8）与讲义正文；
//   ③ 新增“备选公式 lim|a_n/a_{n+1}|=R”与 sin 的比值法 R=∞ 证明；
//   ④ 图增至 7 张（补部分和→2、多项式部分和、三函数对比）。
// ═══════════════════════════════════════════════════════════════
#import "@preview/ilm:2.1.1": *
#import "@preview/cetz:0.5.2"
#import "@preview/fletcher:0.5.8" as fletcher: diagram, edge, node

// ═══ 判断框体系（第四律 4.1）═══
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

#let practicebox(body) = block(
  width: 100%,
  breakable: true,
  fill: rgb("#f5f0fa"),
  stroke: (left: 3pt + rgb("#8e5bd0")),
  inset: (x: 11pt, y: 8pt),
  radius: 4pt,
)[*✍️ 自测与练习*  #body]

// ═══ booktabs 三线表（第五律 5.3）═══
#let booktabs-table(columns: (), ..rows) = block(width: 100%)[
  #table(
    columns: columns,
    stroke: (top: 1.2pt + black, bottom: 1.2pt + black, x: none, y: 0.5pt + luma(160)),
    fill: none,
    inset: (x: 8pt, y: 5pt),
    ..rows,
  )
]

// ═══ 图示尺寸预设（第五律 A6.2）═══
#let dia-scale = 1.0
#let sz-full = 1.5cm
#let sz-wide = 1.3cm
#let sz-normal = 1.0cm
#let sz-compact = 0.7cm

#show: ilm.with(
  title: [Power Series and Taylor Series · 幂级数与 Taylor 级数],
  authors: ("MIT 18.01.3x · Unit 3 · Calculus 1C",),
  date: datetime.today(),
  abstract: [本笔记忠实还原 MIT 18.01.3x "_Power series and Taylor series_" 一课：9 段 lecture/recitation/video 转录 + 5 页官方摘要 PDF + MIT Learn 网页全部官方练习与讲义正文。从"为什么指数/三角是超越函数"出发，先重新证明几何级数公式并点破它的缺陷（∞−∞），由此掀开收敛半径 R 的神秘面纱；再用比值/根值判别法征服四道例题与四道官方练习（R=2、R=∞、R=2、R=∞；官方题 R=1、R=∞、R=e、R=0）；接着学幂级数"像多项式一样"的四则与逐项微积分，并用官方三连练（求和、求导、积分）把它变成自己的手艺；然后完整走一遍 Taylor 公式的推导（逐阶求导挑系数、0!=1 约定），推出 e 与 e^x、sin、cos 三大级数，用比值法与连乘积两种途径证明 sin 的 R=∞；最后处理 1/(1+x) 的端点行为、cos 的官方系数表与"幂级数会隐藏函数性质"的收束。每个公式都有符号表、每个边界情形都有陷阱预警、每道官方练习都给出完整合理解答。],
  bibliography: none,
  figure-index: (enabled: true),
  table-index: (enabled: true),
  listing-index: (enabled: true),
)

= 💡 从"算不尽的函数"谈起：为什么要无穷级数？

课程开场先从全局定位：*指数函数、正弦、余弦*很重要，因为它们遍布科学与工程——不只是行星运动和微积分，还有科学计算与信号处理。（材料原话：“The exponential and trig functions… appear all over science and engineering, in more than just planetary motion and calculus. For example, scientific computing and signal processing.”）

但这些函数有一个共同点：*它们是我们第一批无法用有限过程描述的函数*。我们称这样的函数为*超越的*（transcendental）。注意“超越”不是玄学封号，而是精确的含义：不管你怎么加、减、乘、除、开方它们，都写不成 $x$ 的有限表达式——你必须“无穷次运算”才能定义它们。而这句话，正是本课全部内容的种子：*既然有限过程描述不了，那就用无穷过程去描述*。

== 定义指数函数的“套路”：跟 √2 一模一样

回想一下，我们是怎么定义指数函数的？——把它定义为某个微分方程加初值条件的*解*：
$ f'(x) = f(x), quad f(0) = 1 $ 的解即 $e^x$

*符号表*：$f'(x) = f(x)$ 是微分方程，$f(0) = 1$ 是初值条件；“解”就是满足这两个条件的函数。注意这个“定义”其实什么都没算出来——它只说了“e^x 是那个被微分方程逼出来的东西”，相当于只给了 e^x 一个身份证号，还没给取款密码。

老师提醒：这和我们把 $sqrt(2)$ 定义为“$x^2 = 2$ 的正解“是*完全平行*的思路！而要”得到“ $sqrt(2)$，我们必须用*无穷十进制展开*：
$ sqrt(2) = 1.41421356 dots.c $

*符号表*：$dots.c$ 表示小数继续无止境；$sqrt(2)$ 是被“无穷展开”逼近的数。十进制展开每一“位”都可以用有限步骤算出来，所以尽管 1.41421356… 永远写不完，我们却可以“任意精确地”抓住 √2。

#importantbox[
  *Taylor 级数 = 函数的“无穷小数展开”*：$sqrt(2)$ 用十进制展开逼近，函数（$e^x$、$sin x$、$cos x$……）用无穷级数展开逼近。这就是本课要学的 Taylor 级数——它把“我们熟悉的函数表达式”翻译成“所有函数都能用的统一表示法”。这个类比不是装饰：它具有操作性意义——十进制展开的每一位都可算，级数的每一项也可算；二者都是“用有限步骤逼近无限对象”的机器。
]

这个“展开”工具为什么值得学？因为在接下来的视频里它将揭晓核心答案：*为什么所有“常见函数”都能被幂级数表示、怎么表示、以及哪些 x 是表示得出来的*——最后一个问题的答案，就是收敛半径 $R$。

= 🔑 几何级数再遇：公式的证明与它的"瑕疵"

正式的第一步，从我们已经认识的老朋友开始——这是我们学过的第一个级数：
$ 1 + x + x^2 + x^3 + dots.c = 1 / (1 - x) quad (abs(x) < 1) $

*符号表*：左边是几何级数；右边是它的封闭形式；$|x| < 1$ 是成立条件。上一课我们用字母 $a$（公比），这一课换成 $x$——因为我们要把它当成一个函数来看（后面老师会专门回应这个“换字母”的伏笔）。

老师现在要展示*为什么*这个公式成立。这就是当年这些级数刚被发明时用的那种操作技巧——也是本课最重要的“动手直觉”之一：*假设和 S 存在，然后对等式做代数的形式运算，看能推出什么*。

== 乘 x、相减、剩 1：错位相减的完整演示

#knowledgebox[
  *为什么“错位”是这个地方的魔法*：把 $x dot S$ 的第二行与第一行的项逐列对齐，正好让每个 $x^k$ 都配上一个 $-x^k$——唯一的落单者是第一项 $1$。这种“对齐后相消”的技巧几乎是整个无穷级数理论里最简单、也最常用的操作：它把无限长的“尾巴”整个删掉，只留下首尾两个端点。你在反常积分的“裂项”和本课的“错位减法”里都会反复见到它。
]

假定这个和等于某个数 $S$：
$ S = 1 + x + x^2 + x^3 + x^4 + dots.c $

*符号表*：$S$ 是未知的无穷和；两边同时操作是对等式做“形式运算”。

第一步：两边乘以 $x$。
$ x dot S = x + x^2 + x^3 + x^4 + dots.c $

*符号表*：左边 $x dot S$；右边每一项都乘 $x$，整体错位一格。

第二步：两式相减（第一式减第二式）。
$ S - x dot S = (1 + x + x^2 + x^3 + dots.c) - (x + x^2 + x^3 + x^4 + dots.c) $

*符号表*：先不要跳步，逐项对消：$x$ 被 $-x$ 消掉、$x^2$ 被 $-x^2$ 消掉……*整整一条尾巴全部取消*。

#figure(
  cetz.canvas(length: 1.30cm * dia-scale, {
    import cetz.draw: *
    // 第一行
    for (i, lab) in ((0, $1$), (1, $+ x$), (2, $+ x^2$), (3, $+ x^3$), (4, $+ dots.c$)) {
      content((i, 1.35), lab, anchor: "south")
    }
    // 第二行错位
    for (i, lab) in ((0, $x$), (1, $+ x^2$), (2, $+ x^3$), (3, $+ x^4$), (4, $+ dots.c$)) {
      content((i + 0.55, 0.85), lab, anchor: "south")
    }
    // 划消：第 0 项以下全部消
    for i in range(0, 4) {
      line((i + 0.55 - 0.42, 0.75), (i + 0.55 + 0.42, 1.28), stroke: 0.7pt + red)
    }
    content((2.2, 0.35), $ "尾部全部消去！" $, fill: red)
    content((0, 1.95), $ S = 1 + x + x^2 + x^3 + dots.c $, anchor: "south")
    content((0.55, 1.95), $ x dot S = x + x^2 + x^3 + x^4 + dots.c $, anchor: "south")
  }),
  caption: [错位相减可视化：第一行 $1 + x + x^2 + x^3 + dots.c$ 减去第二行 $x + x^2 + x^3 + x^4 + dots.c$，错位的一列列同类项全部消去，只剩第一项 1。],
)
#footnote[来源：转录 v1 几何级数证明段（黑板演示示意图，按讲解重绘）；本方验证：图内容（两行错位级数、划消尾部）× 材料段（“There's a very, very substantial cancellation. This whole tail here gets canceled off. And the only thing that's left is the 1.”）× caption 一致。]

第三步：结果是 $1$ 在左，$S - x dot S$ 在右：
$ 1 = S - x dot S = S (1 - x) $

*符号表*：左边只剩 1；右边提出 $S$。

于是：
$ S = 1 / (1 - x) $

*符号表*：$S(1-x) = 1$ 两边除以 $1-x$；这正是在 $abs(x) < 1$ 时几何级数的和。公式得证——*前提是刚才假设的 $S$ 真的存在*。

== 缺陷自曝：这个推理“基本正确，但不完整”

老师立刻泼冷水：“这个推理有一个瑕疵。它不完全。这个推理基本正确，但它是*不完整*的——因为它要求 $S$ 存在。“

举例：$x = 1$ 时会发生什么？左式是
$ 1 + 1 + 1 + 1 + dots.c = S $

*符号表*：每一项都是 1；$S$ 被假定存在（其实它不存在）。

乘以 1 得 $S = S dot 1$，然后相减，左边变成
$ "∞" - "∞" = "∞" - "∞" $

*符号表*：这是“无穷减无穷”——不是 0，是无意义（indeterminate）。

老师原话：“That's what's really going on in the argument in this context. So it's just nonsense. I mean, it doesn't give us anything meaningful.”

#warningbox[
  *“形式操作”的前提是式子本身有意义*：错位相减这种操作在代数里天经地义，但把它搬到“无穷和”上就有风险——$S$ 必须真的存在（级数收敛），否则你会在 $x=1$ 时得到 $∞-∞$，什么鬼话都推得出。这正是我们上一课反复强调“收敛性”的原因：*收敛性给这些漂亮操作发许可证*。老师收束语：This argument is great. And it gives us the right answer, but not always. And the times when it gives us the correct answer is when the series is convergent. And that's why we care about convergence, because we want manipulations like this to be allowed.
]

换句话说：错位相减这个“诡计”没变，变的是允许使用它的场地——从“所有 x”缩小到“级数收敛的 x”。下一节的 $R$ 就是这块场地的边界。

== 官方练习 1：Σxⁿ 收敛范围与 1/(1-x) 的定义域

网页上的官方练习（MIT Learn 页面 block-1，视频“First example of a power series”之后的练习题）把这个公式的第一课落在“收敛”二字上。

*题目（Convergence, 1 分）*：回忆级数
$ sum_(n=0)^(oo) x^n = lim_(N -> oo) sum_(n=0)^(N) x^n $
对哪些 $x$ 的值 $sum x^n$ 收敛？

*符号表*：左边是无穷和的定义——有限和 $sum_(n=0)^N x^n$ 当 $N -> oo$ 的极限；题目选项有“所有实数”“对任何 $x$ 无定义“”$x < 1$“”$-1 < x < 1$“等。

#importantbox[
  *官方答案：$x != ±1$ 时收敛范围是 $-1 < x < 1$*。逐条排除：$x != 1$ 时（选项“$x < 1$“）错误——$x = -2$ 满足 $x < 1$，但 $sum (−2)^n$ 的项越来越大，发散；$x != ±1$ 同样不完整（比如 $x=2$ 发散）；“对所有实数”与“对任何 x 无定义”显然错误。几何级数收敛当且仅当 $|x| < 1$，即 $-1 < x < 1$。
]

*题目（Domains of definition, 2 分）*：设 $f(x) = sum_(n=0)^(oo) x^n$（级数收敛处定义），再考虑 $g(x) = 1 / (1 - x)$。问 $f$ 与 $g$ 各自的定义域。

#practicebox[
  *官方答案：二者定义域相同，都是 $-1 < x < 1$*。$f$ 的定义域是“级数收敛的 x”的集合（这正是 $R=1$ 的半径内部）；$g$ 的定义域原本是 $x != 1$，但本课以“幂级数等式”来谈论 $g$ 时，自觉地把讨论范围限制在级数收敛处 $|x|<1$——在这个范围内 $f$ 与 $g$ 是一模一样的函数。这正是“幂级数表示函数时，表示本身带有效期（半径）”的第一个官方实例。
]

为什么官方要专门问定义域？因为它把上一段的痛点固化成一个检查点：*公式 $sum x^n = 1/(1-x)$ 只在其成立范围内是函数等式*，在范围外，右边的 $g$ 还活着（$x=2$ 时 $g(2) = -1$），左边的级数却已经死了。级数表示函数，是以“收敛域”为契约的。

= 📏 一般幂级数与收敛半径 R

现在把系数从“全是 1”推广成任意数 $a_n$。官方讲义（网页 block-2 与 PDF 第 1 页）先做三点约定：*只讨论在 0 处展开（centered at $x = 0$）的幂级数*；*系数 $a_n$ 可以是任意实数，也可以为 0*；*为简洁，下面“幂级数”一律指这种形式*：

$ f(x) = a_0 + a_1 x + a_2 x^2 + a_3 x^3 + dots.c = sum_(n=0)^(oo) a_n x^n $

*符号表*：$a_n$ 是任意常数系数（可为 0）；$x^n$ 是幂；这个叫*幂级数*（power series）。“系数可以为零”不是废话——它意味着幂级数可以只有有限个非零项：那一类“截断的幂级数”就是多项式。

比如多项式 $a_0 + a_1 x + a_2 x^2 + dots.c + a_N x^N = sum_(n=0)^(N) a_n x^n$，把它写成无穷和的形式，只需令 $a_m = 0 quad (m > N)$ 即可——所以*多项式也是幂级数*，且它的“半径”是 $∞$（对所有 $x$ 收敛）。

== 魔力数字 R：幂级数收敛的“一刀切”规则

幸运的是，幂级数收敛有*非常简单的规则*。存在一个*魔力数字* $R$，它由这些 $a_n$ 决定，叫*收敛半径*（radius of convergence），$R$ 是满足 $0 <= R < oo$ 的实数（也允许 $R = oo$），使得：

$ abs(x) < R $：收敛；$ abs(x) > R $：发散；$ abs(x) = R $：边界（不讨论）

*符号表*：绝对值小于 R 的对称区间内级数收敛到有限数；大于 R 外部发散；正好等于 R 是“非常微妙的分界线”，本课不碰（官方讲义原话：“for |x| = R, the power series may converge or diverge. But we will mostly ignore what happens at the end points of the interval of convergence.”）。

#figure(
  cetz.canvas(length: 1.30cm * dia-scale, {
    import cetz.draw: *
    line((-3.6, 0), (3.6, 0), mark: (end: "stealth"), stroke: 0.9pt)
    content((3.6, 0), $ x $, anchor: "west")
    // 收敛区绿色
    line((-2, 0), (2, 0), stroke: 0.9pt + green.darken(20%))
    // 发散区红色
    line((-3.4, 0), (-2.15, 0), stroke: 0.9pt + red)
    line((2.15, 0), (3.4, 0), stroke: 0.9pt + red)
    // 端点
    circle((-2, 0), radius: 0.09, fill: white, stroke: 0.8pt + red)
    circle((2, 0), radius: 0.09, fill: white, stroke: 0.8pt + red)
    content((-3.5, 0.45), $ "发散" $, fill: red)
    content((3.5, 0.45), $ "发散" $, fill: red)
    content((0.7, 0.45), $ "收敛" $, fill: green.darken(20%))
    content((-2, 0.45), $ -R $, fill: red)
    content((2, 0.45), $ R $, fill: red)
    content((0, -0.45), $ 0 $, anchor: "north")
  }),
  caption: [收敛半径 R 的三区段：$|x| < R$ 绿色收敛区，$|x| > R$ 红色发散区，$|x| = R$ 两个空心端点——“非常微妙的分界线，课堂上不讨论”。],
)
#footnote[来源：转录 v1/v2 收敛半径段 + PDF p1（示意图按讲解重绘）；本方验证：图内容（三区段、端点空心）× 材料段（“minus R less than x less than R where there's convergence… x equals R is a very delicate borderline”）× caption 一致。]

为什么能这么“干净”？老师说：在 $|x| < R$ 内部，这些项会*指数级地快速趋于 0*（exponentially fast）；在 $|x| > R$ 外部，它们甚至不趋于 0——一眼就能看出来。你可能会问“怎么知道它是指数级快速而不是像 $1/x$ 那种慢速？“——老师承认：这是额外信息，但他向你打包票：”You can identify it. And it will happen every single time. I'm just promising you that it works that way. It's really for the same reason that it works that way here, that these are powers. And what's going on over here is it's close to powers with these a_n's.“

#importantbox[
  *收敛半径的直观（材料原话要点）*：
  - 幂级数“总和”是 $x^n$ 与 $a_n$ 的乘积，$x^n$ 的性质由 $|x|$ 与 $a_n$ 的增长共同决定；
  - $|x| < R$：项小得飞快（指数级衰减）；
  - $|x| > R$：项越来越大，绝无收敛可能；
  - $|x| = R$：每一道计算都可能给出荒谬结果，课堂避开。
]

== 官方讲义拾遗：几何级数与多项式的 R

官方讲义（PDF p1 与网页 block-2）给了两条最基础的半径结论，先把它们钉进“已知弹药库”：

$ "几何级数" quad 1 + x + x^2 + x^3 + dots.c = sum_(n=0)^(oo) x^n quad => quad R = 1 $

*符号表*：公比 $x$，收敛条件 $|x| < 1$，半径恰为 1——与上一大节 $\{sum x^n\}$ 的收敛范围 $-1 < x < 1$ 完全一致。

$ "多项式" quad sum_(n=0)^(oo) a_n x^n quad (a_n = 0 quad "当" n > N) quad => quad R = oo $

*符号表*：有限项之外系数全为 0，级数退化为有限和；对任意 $x$ 都收敛，故 $R = oo$。官方原话：“Polynomials are power series… The radius of convergence for any polynomial is ∞. In other words, the sum converges for all x.” 注意这个“幂级数”里每一项都含正幂——哪怕 $a_n$ 一大堆 0，只要指数全是非负整数，它就是幂级数。

== 官方练习 2：识别哪些表达式是幂级数

网页 block-2 的官方练习（Identify the power series, 1 分）：判断下面哪些表达式是幂级数（可多选）。

#practicebox[
  *官方三个候选*：
  - $3 - x + x^3/2$：*是*。它只含非负整数幂，是幂级数（其实是有限版——多项式）；
  - $sum_(n = -5)^(5) n x^n$：*不是*。求和范围含负下标，出现负幂 $x^(-n)$，而“幂级数只允许非负整数次幂”；
  - $sum_(n = 0)^(oo) n x^n$：*是*。下标从 0 到 ∞、系数 $a_n = n$、幂次非负，完全符合定义。
]

判别的关键只有一条：*每一单项必须形如“常数 × 某非负整数次幂”*。负幂（$1/x$ 项）、幂在分母里、或者次幂是变量而非非负整数，都直接把“幂级数”的标签撕掉。而“系数为 0”与“是否无限项”都不影响它作为幂级数的身份——只有“指数”是硬标准。

= 🧮 用比值判别法求半径：四个例题走一遍

习题课（转录 v3）的目标非常明确：*用比值判别法找出其他幂级数的收敛半径*。老师说：“我们要问的是：对哪些 x 这些幂级数收敛？”而做法就是直接用比值判别法，只是这次每次取绝对值（不必处理正负号）。他还提前声明：只问半径、不问端点——“sometimes it will actually converge on one or both of the endpoints. We're not going to deal with that one.”

== 通用配方：把比值极限解成 |x| 的不等式

对 $sum a_n x^n$，比值判别法说：
$ L = lim_(n -> oo) abs((a_(n+1) x^(n+1)) / (a_n x^n)) = lim_(n -> oo) abs(a_(n+1)/a_n) dot abs(x) $

*符号表*：$a_n x^n$ 整体视为$a_n$（它其实是 x 的函数）；$abs(x)$ 可以提出绝对值外；$L$ 是随 $x$ 变化的极限。

“比值判别法告诉我们：如果这个极限严格小于 1，级数必收敛。所以把 $L < 1$ 解成关于 $|x|$ 的不等式，得到的区间端点就是 $R$。“——老师反复指出这就是”比值判别法的位置“。

#importantbox[
  *求 R 的标准流程（本课全部例题共用）*：
  1. 写出 $a_(n+1) / a_n$（分子把 n 全部换成 n+1，分母保持 n 再取倒数）；
  2. 化简（幂对消、阶乘拆分），取绝对值；
  3. 求极限得只含 $|x|$ 的式子；
  4. 令该式子 $< 1$，解出 $|x| < R$，$R$ 即为收敛半径。
]

== 例 1：sum (x/2)^n —— R = 2（几何级数，意料之中）

第一题：
$ sum_(n=0)^(oo) (x / 2)^n $

*符号表*：把 $(x/2)^n$ 整体当成 $a_n$——它既是 x 的函数也依赖 n。

比值：
$ lim_(n -> oo) abs(((x/2)^(n+1)) / ((x/2)^n)) = lim_(n -> oo) abs(x) / 2 = abs(x) / 2 $

*符号表*：$(x/2)^(n+1)/(x/2)^n = x/2$；取绝对值，与 n 无关，极限即 $|x|/2$。

令其 $< 1$：
$ abs(x)/2 < 1 <=> abs(x) < 2 quad => quad R = 2 $

*符号表*：两边乘 2；R 就是区间的端点。

#practicebox[
  *用具体数字 “活化” 公式*：取 $x = 1.5$（在 $|x| < 2$ 内），几何级数求和公式给出 $1/(1 - 1.5/2) = 1/(0.25) = 4$；取 $x = 3$（在 $|x| < 2$ 外），公式给出 $1/(1 - 1.5) = -2$，但级数 $1.5 + 1.5^2 + 1.5^3 + dots.c$ 显然趋向无穷——这就是“半径外一切公式失效”的具体感受。
]

== 两个“几何级数”的对照：为什么结果不惊人

这个例子值得多说一句：它其实*就是*几何级数，只是把公比从 $x$ 换成了 $x/2$。回想第一课的“几何级数收敛当且仅当公比绝对值小于 1”，$sum (x/2)^n$ 的公比是 $x/2$，于是：
$ abs(x/2) < 1 quad <=> quad abs(x) < 2 quad <=> quad R = 2 $

*符号表*：$abs(x/2)$ 是公比的绝对值；不等式两边乘 2 得 $abs(x) < 2$。这句话把“上一课的几何级数判据”和“本课的比值法”缝合成同一个结论——如果两处答案不同，那一定是你算错了某一步。

#warningbox[
  *不要把绝对值乘错了方向*：解 $abs(x)/2 < 1$ 时，两边同时乘的必须是*正数* 2——$abs(x)$ 本身非负，所以乘 2 后不等式方向不变；但如果是一边乘“含 x 的表达式”，就要小心符号。这也是材料里老师说“绝对值为 2 是正数，所以不用担心 2 是不是负数”的原因。
]

== 例 2：sum x^n / n! —— R = ∞（e^x 的级数）

第二题：
$ sum_(n=0)^(oo) x^n / n! $

*符号表*：通项是 $x^n / n!$（阶乘打底）。

比值：
$ lim_(n -> oo) abs((x^(n+1) / (n+1)!) / (x^n / n!)) = lim_(n -> oo) abs(x) / (n + 1) $

*符号表*：$x^(n+1)/x^n = x$；$n!/(n+1)! = 1/(n+1)$（因为 $(n+1)! = (n+1) n!$）。

老师特别强调这个阶乘事实：“n+1 的阶乘等于 (n+1) 乘 n 的阶乘”——因为
$ (n+1)! = (n+1) dot n! $

*符号表*：$n! = n(n-1)(n-2) dots.c 1$，$(n+1)! = (n+1)(n) dots.c 1$，多乘一个 $n+1$。

现在取极限：$x$ 是*固定的*（“If I were moving x around, if I were moving x with n this would be a problem, but x is fixed.”）：
$ lim_(n -> oo) abs(x)/(n+1) = 0 < 1 quad "对任意固定的 x 成立" $

*符号表*：$x$ 固定时分母 → ∞，故比值 → 0。

所以：
$ R = oo $

即级数对一切 x 收敛。它是谁？——这正是 $e^x$ 的幂级数（后面见）。“We know that the power series for e to the x converges for any x. It's kind of a nice thing.”

#knowledgebox[
  *阶乘把“任何幂”都降住*：$x^n/n!$ 中，$x^n$ 随 n 指数增长；但 $n!$ 增长得更快——阶乘连乘的是 $1, 2, 3, dots.c$ 这些越来越大的自然数，而幂只是反复乘同一个 $x$。两者赛跑时，阶乘最终总是赢。这个结论将会在幂级数理论里反复出现；本课只要记住：分母带阶乘（非零收敛因子）的比值极限几乎必为 0，R 基本是 ∞。
]

== 例 3：sum x^n / (n 2^n) —— R = 2

第三题：
$ sum_(n=0)^(oo) x^n / (n dot 2^n) $

*符号表*：分母多了一个 $n dot 2^n$。

比值：
$ lim_(n -> oo) abs((x^(n+1) / ((n+1) 2^(n+1))) / (x^n / (n 2^n))) = lim_(n -> oo) abs(x) / 2 dot n/(n+1) = abs(x) / 2 $

*符号表*：$2^n/2^(n+1) = 1/2$；$n/(n+1) -> 1$；得 $|x|/2$。

解不等式：
$ abs(x)/2 < 1 quad => quad abs(x) < 2 quad => quad R = 2 $

老师自嘲：“我可能该换个数。” 把 2 换成 7，半径就是 7——你会看到流程完全一样，“except this would have been a 7, and the radius of convergence would have been 7.”

#warningbox[
  *$n/(n+1) -> 1$ 不等于“消掉”*：例 3 的化简里 $n/(n+1)$ 的极限是 1，但不能在取极限前就把它当 1 扔掉——它只是“在无穷远处等于 1”的合法简化。比值判别法要求“先化简再取极限”，顺序颠倒就会把 $abs(x)/2 dot n/(n+1)$ 误判成别的值。这也是例 3 的精髓：多项式与指数混合时，负责极限的部分要单独求极限。
]

== 例 4：sum x^(2n) / (2n)! —— R = ∞，但它不是 cos x！

第四题特别值得讲，因为它示范了“指数和阶乘更复杂时”怎么拆分——*同时也示范了老师自己示范了一个口误，官方网页专门为此加了更正说明*（网页 block-3 页首“Note about video”）。

$ sum_(n=0)^(oo) x^(2n) / (2n)! $

*符号表*：注意指数是 $2n$ 不是 $n$——这是“偶数次幂”系列。

比值：
$ lim_(n -> oo) abs(((x^(2(n+1))) / (2(n+1))!) / (x^(2n) / (2n)!)) = lim_(n -> oo) abs(x^2) dot (2n)! / (2n + 2)! $

*符号表*：$2(n+1) = 2n + 2$；$x^(2n+2)/x^(2n) = x^2$。

重点：$(2n+2)!$ 比 $(2n)!$ 多两个因子！
$ (2n+2)! = (2n+2)(2n+1)(2n)! $

*符号表*：展开 $(2n+2)!$ 从 $2n+2$ 向下到 1，最头两个因子是 $2n+2$ 与 $2n+1$，其后正是 $(2n)!$。

于是：
$ lim_(n -> oo) abs(x)^2 / ((2n+2)(2n+1)) = 0 < 1 quad "对所有 x" $

*符号表*：分母两因子都 → ∞，故极限 0；与 n 无关的 $|x|^2$ 被压死。

所以 $R = oo$。它是什么函数？老师在视频里是这样判断的：“I know without thinking that it's either sine or cosine… what's the first term? x to the 0 is 1 over 0 factorial is 1, so it looks like the first term is 1, so that makes me know it's cosine.” ——*但她随后说“Where it converges is equal to cosine x”，这是个口误*。

#warningbox[
  *官方勘误（网页 block-3 页首原话）*：“There is also an error in Example 4. Christine says the example is the series for $cos x$, but that is an error. You'll see the correct series for $cos x$ shortly, and discover what series this represents later in this lecture.“

  真相：$sum x^(2n)/(2n)!$ *不是* $cos x$，而是 $upright(cosh) x$（双曲余弦）！$cos x$ 的正确级数是带交替符号的 $sum (-1)^n x^(2n)/(2n)!$——少了 $(-1)^n$ 就少了一正一负的交替，系数全变 “+1”，那正对应 $upright(cosh)$ 的展开（$upright(cosh) x = (e^x + e^(-x))/2 = sum x^(2n)/(2n)!$）。

  这个错误的根源在于“首项判断法”只能用一半：首项是 1 只能说明它是*偶幂家族*（sin 与 cos、sinh 与 cosh 才是必须二选一的配偶）。要区分 $cos x$ 与 $upright(cosh) x$ 就得看第二项：$cos x$ 的 $x^2$ 项系数是 $-1/(2!)$（负号），而 $upright(cosh) x$ 的 $x^2$ 项系数是 $+1/(2!)$。首项只能判“奇偶”，符号才能定“正余”。
]

*正确的收尾*：该级数对所有 x 收敛（$R = oo$），它在 $x=0$ 附近等于 $upright(cosh) x$——记下这个“无符号交替的偶幂阶乘级数 = 双曲余弦”，等学过 $e^x$ 与 $e^(-x)$ 的级数后，用 $upright(cosh) x = (e^x + e^(-x))/2$ 一验即中。

== 补充：R = 0 的“失败”情形

老师提到另一种可能：半径可以是 *0*——级数只在 $x = 0$ 收敛（“the only place it converges is at x equals zero”）。这就是比值极限对所有 $x != 0$ 都大于 1 的情况（$L = oo$）。

#warningbox[
  *R 有三种值：有限、∞、0*——三者都真实存在。$sum x^n/n!$ 是 R=∞ 的例子；$sum 2^n x^n$ 是 R=1/2 的例子；而 R=0 的级数（比如 $sum n! x^n$），$x=0$ 之外全部发散。考试常见陷阱是默认“总有某个 R”，忘记“也可能只有原点”。
]

== 官方练习 3：四道半径题（1、∞、e、0）

网页 block-3 在比值法讲解后给了四道官方填空练习，正好把我们刚学的三种可能各用一遍。先自己算一遍，再看解答。

#table(
  columns: (2.2fr, 2.2fr, 1.6fr),
  inset: 8pt,
  align: (center + horizon),
  stroke: 0.5pt + luma(150),
  fill: (col, row) => if row == 0 { luma(240) } else { none },
  [题目编号], [级数], [答案 $R$],
  [Practice 1 $(3.141)$], [$sum_(n=1)^(oo) x^n / n$], [$1$],
  [Practice 2], [$1 - x$（多项式）], [$oo$],
  [Practice 3 $(3.144)$], [$sum_(n=1)^(oo) n! x^n / n^n$], [$e$],
  [Practice 4 $(3.153)$], [$sum_(n=1)^(oo) n^n x^n$], [$0$],
)

*逐题讲解*：

*题 1*：$a_n = 1/n$，比值法：
$ lim_(n -> oo) abs(a_(n+1)/a_n) dot abs(x) = lim_(n -> oo) n/(n+1) abs(x) = abs(x) < 1 quad => quad R = 1 $

*符号表*：$n/(n+1) -> 1$；这个级数正是 $-ln(1-x)$ 的展开（后面用逐项积分得到），半径 1 与其“对数奇点在 $x=1$“相呼应。

*题 2*：$1 - x$ 是多项式，按官方讲义 $R = oo$——对一切 x 收敛。

*题 3*：$a_n = n! / n^n$。普通比值法：
$
  lim_(n -> oo) abs(a_(n+1)/a_n) dot abs(x) = lim_(n -> oo) (n+1)/(n+1)^(n+1) dot n^n/n! dot abs(x) = lim_(n -> oo) 1 / (1 + 1/n)^n dot abs(x) = abs(x) / e
$

*符号表*：$(n+1)! = (n+1) dot n!$，$(n+1)^(n+1) = (n+1) dot (n+1)^n$，消去 $n+1$ 后剩 $n^n/(n+1)^n = 1/(1+1/n)^n -> 1/e$。

于是 $abs(x)/e < 1 quad => quad abs(x) < e quad => quad R = e$。换官方“备选公式”（$a_n$ 在分子）也一样：
$
  lim_(n -> oo) abs(a_n/a_(n+1)) = lim_(n -> oo) n^n/n! dot (n+1)!/(n+1)^(n+1) = lim_(n -> oo) (1 + 1/n)^n = e quad => quad R = e
$

*符号表*：两法都给出 $e$——一个是“系数比极限 = 1/e，解 $|x|/e < 1$“，一个是”倒数比极限直接等于 R“。顺便记住这个级数（$a_n = n! / n^n$）与 $e^x$ 家族的关系：它正是经典极限 $(1+1/n)^n -> e$ 的化身。

*题 4*：$a_n = n^n$，根值法最顺：
$ lim_(n -> oo) root(n, abs(n^n x^n)) = lim_(n -> oo) n abs(x) = oo dot abs(x) quad (x != 0) $

*符号表*：$root(n, n^n) = n -> oo$；只要 $x != 0$，极限就是 $oo > 1$，发散；只有 $x = 0$ 收敛。故 $R = 0$——官方练习里“半径被压成 0”的活标本。

== 官方补充：备选公式（倒数比值公式：直接给出 R）

官方讲义在比值法之后补了一个“按比值判别法的另一种写法”的 Remark——注意其中 $a_(n+1)$ 在分母、$a_n$ 在分子，与通常比值法*颠倒*，所以它直接给出 $R$ 而不用再解不等式：

$ "若" lim_(n -> oo) abs(a_n / a_(n+1)) = L quad (L "存在或为" oo) quad => quad R = L $

*符号表*：$a_n/a_(n+1)$ 越大说明“后面的系数越小”，半径越大；官方例题 $sum 2^n x^n$：
$ lim_(n -> oo) abs(2^n / 2^(n+1)) = 1/2 quad => quad R = 1/2 $

*符号表*：与“普通比值法” $2|x| < 1 => |x| < 1/2$ 殊途同归。

#knowledgebox[
  *两个公式的关系*：普通比值法 $lim |a_(n+1)/a_n||x| < 1$ 解出的区间端点是 $L_("比值")^(-1)$；备选公式直接算 $lim |a_n/a_(n+1)| = R$。二者互为倒数，做题时选“化简后极限好算”的那个。官方特别提醒：备选公式里 $a_n$ 在分子、$a_(n+1)$ 在分母，与比值法恰好相反——照搬比值法就会把 $R$ 算成倒数。
]

= 🌱 根值判别法求半径：与比值法的双胞胎

官方摘要第 3 页与网页 block-3 专门给出求 R 的第二种方法——*根值判别法*。它和比值法几乎是双胞胎，结论一模一样，但“抓手”不同。

== 根值法公式与三可能

对 $sum a_n x^n$，根值判别法说：
$ L = lim_(n -> oo) root(n, abs(a_n x^n)) = lim_(n -> oo) root(n, abs(a_n)) dot abs(x) $

*符号表*：$root(n, x)$ 是 $x$ 的 $n$ 次根；$abs(a_n x^n) = abs(a_n) abs(x)^n$，开 $n$ 次根后 $abs(x)^n$ 变 $abs(x)$——这个提公因子的动作就是根值法的全部技巧。

收敛条件与三种可能（与比值法逐字对应）：
$ abs(x) < R <=> lim root(n, abs(a_n)) dot abs(x) < 1 ; quad R "有三种可能" $

*符号表*：

1. 存在有限 $R$，使 $|x| < R$ 时极限 $< 1$、$|x| > R$ 时极限 $> 1$；
2. 对所有 $x$ 极限 $< 1$，则 $R = ∞$（所有 x 都满足 $|x| < ∞$）；
3. 对所有 $x != 0$ 极限 $> 1$，则 $R = 0$。

== 官方例题：sum 2^n x^n 的双重验证

官方用同一个例子演示两种方法。$sum_(n=0)^(oo) 2^n x^n$：

*比值法*：
$ lim_(n -> oo) 2^(n+1) / 2^n = 2 quad => quad 2 abs(x) < 1 quad => quad abs(x) < 1/2 quad => quad R = 1/2 $

*根值法*：
$
  lim_(n -> oo) root(n, abs(2^n x^n)) = lim_(n -> oo) root(n, abs(2^n)) dot abs(x) = 2 abs(x) < 1 quad <=> quad abs(x) < 1/2
$

*符号表*：$root(n, 2^n) = 2$（$n$ 次根把指数 $n$ 吃掉）；两法都给出 $R = 1/2$——这是“答案不依赖方法”的极佳示范。题目说的是同一个级数，比值法开“前项后项比”，根值法开“每项自身 $n$ 次根“，殊途同归。

#importantbox[
  *比值法 vs 根值法：各什么时候顺手*：
  - 比值法：$a_n$ 含阶乘、含“多项式比值”时最顺（$x^(2n)/(2n)!$ 这类）；
  - 根值法：$a_n$ 本身带 $n$ 次幂时最顺（如 $a_n = 2^n x^n$、$n^n x^n$ 这类）；
  - *三结论完全平行，$L = 1$ 时两法都无结论*。
]

== 根值法常用三极限（复述自“进阶判别法”一课官方表）

用根值法求 R 时需要：
$ lim_(n -> oo) b^(1/n) = 1 quad ; quad lim_(n -> oo) (n^p)^(1/n) = 1 quad ; quad lim_(n -> oo) (n!)^(1/n) = oo $

*符号表*：第一行 $b > 0$ 是常数，常数开 $n$ 次根趋于 1；第二行任何正幂 $p > 0$ 的 $n$ 次根也趋于 1；第三行阶乘的 $n$ 次根发散到 $oo$——三者是根值判别法的“弹药库”。

#warningbox[
  *根值法的“1”与比值法的“1”是同一个陷阱*：两法都在 $L = 1$ 时失效。所谓“幂阶级”级数（$sum 1/n^p$、$sum 1/(n ln n)$）两法都给出 1，判不动——这种级数还是老老实实用比较或积分测试。别把“根值法比比值法更高级”当成错觉：它们只是同一结论的两件外衣。
]

= 🔧 幂级数像多项式：可以相加、相乘、代换、相除……还有微分和积分！

主讲老师（转录 v4/v7）给出幂级数的*性质框架*：幂级数的规则*和多项式一样*。多项式能做的四则运算（加减、乘、代换、除），幂级数都能做。

“真正有趣、真正属于微积分的是最后两个——*微分*与*积分*。”

== 课堂问答 1：这是级数还是多项式？

正当老师说“运算规则与多项式相同”时，学生提问：“那到底是级数还是多项式？”

老师回答（原话大意）：*如果它结束，就是多项式；如果无限继续，就是级数。* 它们看起来几乎一样，多项式与级数几乎一模一样，差别就是那串“点点点”（little dot, dot, dot）。

#importantbox[
  *多项式 = 有限长幂级数；幂级数 = 无限长多项式*（“generalized polynomials”）。学生的重要洞察是“级数是逐点求和的数”——老师稍后会专门回应。
]

== 课堂问答 2：级数是“数”还是“函数”？

学生的质疑更进一层：“我以为级数是把*有限数*加起来；可这里你在用 x 相加？” 老师承认“换字母把你们骗过了”——我们把字母从 $a$ 换成 $x$，于是式子看起来“加了字母”。

但根本没有区别：
- 对每个具体的 $x$ 值，级数都是一个*数*。比如 $x = 1/2$，几何级数的值是 $1 + 1/2 + 1/4 + 1/8 + dots.c = 2$；
- 对每个 $x$ 都做一次，整体就是一个*函数*（对 $|x|<1$ 有效）。

#knowledgebox[
  *幂级数的“逐点函数”本质（材料原话转述）*：“This is a series. For each individual value of x, it's a number… On the other hand, I can do this for each value of x. So the interpretation of this is that it's a function of x.” 所以 $sum a_n x^n$ 读作“在允许的 $x$ 上定义了一个函数“。顺带，你也可以把别的函数（sine、cosine）塞进”幂“的位置——那就是 Fourier 型级数了，本课只谈 $\{x^n\}$ 这种最简单的。
]

#figure(
  cetz.canvas(length: 1.30cm * dia-scale, {
    import cetz.draw: *
    line((0.2, 0), (5.0, 0), mark: (end: "stealth"), stroke: 0.8pt)
    line((0.2, 0), (0.2, 2.4), mark: (end: "stealth"), stroke: 0.8pt)
    let s1 = ()
    let s2 = ()
    let s3 = ()
    let s4 = ()
    let s8 = ()
    let t = 0.1
    while t <= 4.9 {
      s1.push((t, 1))
      s2.push((t, 1 + t / 2))
      s3.push((t, 1 + t / 2 + t / 4))
      s4.push((t, 1 + t / 2 + t / 4 + t / 8))
      s8.push((t, 2))
      t += 0.08
    }
    line(..s1, stroke: 0.9pt + luma(140))
    line(..s2, stroke: 0.9pt + orange)
    line(..s3, stroke: 0.9pt + red)
    line(..s4, stroke: 0.9pt + green.darken(20%), dashed: (spacing: 2pt))
    line(..s8, stroke: 1.2pt + blue)
    content((0.35, 2.55), $ y = 2 $, anchor: "north-west", fill: blue)
    content((2.6, 1.05), $ 1 + x/2 + x/4 + x/8 + dots.c $, fill: red)
    content((1.0, 1.62), $ 1 + x/2 $, fill: orange)
    content((4.2, 2.05), $ "各处等值→函数" $, fill: green.darken(20%))
    content((0.2, -0.28), $ x $, anchor: "north-west")
  }),
  caption: [级数作为函数：把四个具体部分和 $1$、$1+x/2$、$1+x/2+x/4$……在每个 $x$ 处求和，得到同一族曲线，它们向 $y = 2$（它在 $|x|<1$ 内正是 $1/(1-x)$，此处以 $x=1/2$ 的等值线示意）逐点靠拢。对每个固定的 $x$ 它是个数；随着 x 变化，它是个函数。],
)
#footnote[来源：转录 v4 “x=1/2 → 1+1/2+1/4+1/8+…=2” 段与“它是函数”讨论（示意曲线，按讲解重绘）；本方验证：图内容（一族部分和曲线向水平线 2 靠拢）× 材料段（“if I plug in… x equals 1/2, I'm going to add 1 plus 1/2 plus a 1/4 plus 1/8, and I'll get a number, which is two… On the other hand, I can do this for each value of x… it's a function of x.”）× caption 一致。]

== 逐项微分：跟多项式规则一模一样

#importantbox[
  *逐项微分的“合法性来源”*：幂级数在半径内“像多项式”，所以幂级数的导数可以逐项求导，且收敛半径不变。直觉是：级数的每一段都只是多项式的“尾巴”，而多项式求导是四则运算；只要 $|x| < R$，这些“尾巴”缩得足够快，求导后依然平稳收敛。材料里老师只宣布结论，没有给出证明——本课把它当作规则使用。
]

$ "若" f(x) = sum_(n=0)^(oo) a_n x^n "收敛于" |x| < A, "则" f'(x) = sum_(n=1)^(oo) n a_n x^(n-1) "同样收敛于" |x| < A $

*符号表*：常数项 $a_0$ 求导得 0（$n$ 从 1 开始）；$a_n x^n$ 求导得 $n a_n x^(n-1)$；收敛半径不变。

老师演示逐项求导（多项式规则直接搬）：
$ f'(x) = a_1 + 2 a_2 x + 3 a_3 x^2 + 4 a_4 x^3 + dots.c $

*符号表*：第 k 项的导数把系数乘上 k、幂次降 1。

== 逐项积分：同样多项式规则，常数放前

#importantbox[
  *逐项积分马上给出一个重磅结果*：对 $1/(1-x) = sum x^n$ 逐项积分（注意 $integral 1/(1-x) dif x = -ln(1-x)$），立即得到官方级数表里“凭空出现”的行：
  $ -ln(1-x) = sum_(n=1)^(oo) x^n / n quad (abs(x) < 1) $
  它正是逐项积分“半径保持 $abs(x) < A$“的直接产品。
]

$ integral f(x) dif x = c + sum_(n=0)^(oo) a_n x^(n+1) / (n+1) quad "收敛于" |x| < A $

*符号表*：$c$ 是积分常数，放前面（约占 $a_0$ 项的位置——原 $a_0$ 项积分后“消失”变成 $a_0 x$）；$a_n x^n$ 的反导数是 $a_n x^(n+1)/(n+1)$；半径不变。

== 两个级数之和的半径：min(A, B) 与“至少 A”的微妙区别

官方 PDF 第 3-4 页给出两条加法的半径规则：

- 若 $A != B$（两个半径不同）：
$ sum a_n x^n + sum b_n x^n = sum (a_n + b_n) x^n quad "收敛于" |x| < min(A, B) $

*符号表*：两个级数同时收敛的范围是“较小的那个半径”。

- 若 $A = B$：
$ "半径至少是" A, quad "甚至可能更大" $

*符号表*：大的可能超过 A——因为“同半径的函数相减后，奇异的点可能互相抵消”（例如两个半径同为 1 的级数相减，可能得到多项式，其半径直接跳回 ∞）。

#warningbox[
  *把“逐项微分/积分”用在不收敛的级数上是灾难*：这些规则的前提都是 $|x| < R$（半径内）。端点处不确定；半径外更是直接无意义。另外微分/积分不改变半径（官方公式都写了“also converges for $|x| < A$“），但会改变端点行为（微分可能加大端点发散），本课统一”不讨论端点“。
]

== 官方练习 4：加、导、积三连练

网页 block-8（Facts about power series 视频后的官方练习）把我们刚讲的三个规则各出一道题，正好当场检验“同多项式”这个口号。

*① 求和（Adding power series, 2 分）*：求两个级数之和的幂级数与其半径：
$ sum_(n=1)^(oo) x^n / 7^n quad (R = 7) quad + quad sum_(n=1)^(oo) n^n x^n quad (R = 0) $

*符号表*：第一级数公比 $x/7$（几何级数，$R=7$）；第二级数正是上一大节官方练习 4，$R = 0$。

#practicebox[
  *解答*：按“逐项相加”规则，和级数为
  $ (sum_(n=1)^(oo) x^n/7^n) + (sum_(n=1)^(oo) n^n x^n) = sum_(n=1)^(oo) (1/7^n + n^n) x^n $
  半径取两者交集：$min(7, 0) = 0$——和级数只在 $x = 0$ 收敛。这就是“一个半径 0 的坏孩子会把整个和带坏”的官方实例：求和不会撮合两个半径，只会取更小的那个。
]

*② 求导（Differentiating power series, 2 分）*：对 $1/(1-x)$ 的级数逐项求导，得 $1/(1-x)^2$ 的级数，注意求和指标从 $n = 1$ 起：
$ 1/(1-x) = sum_(n=0)^(oo) x^n quad (|x| < 1) quad => quad 1/(1-x)^2 = sum_(n=1)^(oo) n x^(n-1) quad (|x| < 1) $

*符号表*：常数项 $1$ 求导消失，故 $n$ 从 1 起；$x^n$ 的导数是 $n x^(n-1)$；半径保持 $R = 1$。这个“平方”级数在考研与工程计算中都是熟脸：比如求和 $sum n/2^n$ 就是它取 $x = 1/2$。

*③ 积分（Integrating power series, 3 分）*：对 $1/(1-x)$ 的级数逐项积分，写出 $-ln(1-x) = sum a_n x^n$（常数项 $c$ 单独写）并求其 $R$：
$ integral 1/(1-x) dif x = -ln(1-x) = c + sum_(n=1)^(oo) x^n/n quad ("常数" c = 0, quad a_n = 1/n) quad (|x| < 1) $

*符号表*：逐项积分公式 $c + sum a_n x^(n+1)/(n+1)$ 中，$a_n = 1$，故第 $n$ 项系数 $= 1/n$，$n$ 从 1 起；由 $-ln(1-x)|_(x=0) = 0$ 定出 $c = 0$；半径仍为 $R = 1$（$x = 1$ 是 $ln$ 的对数奇点，呼应上一题）。

#knowledgebox[
  *三连练的底层逻辑*：加、导、积三个操作都“不越权”——半径要么取交集（加），要么不变（导、积）。官方选择 $1/(1-x)$ 做求导/积分靶子，因为它的级数 $sum x^n$ 最简单：导一次得到 $1/(1-x)^2$，积一次得到 $-ln(1-x)$——两个“新函数”的级数都能从一个最小级数里“免费”生成。这就是“器有大用”：幂级数运算规则是造新展开式的生产线。
]

= 🎯 Taylor 公式：从函数到系数的翻译机

为什么我们看这些幂级数？因为它们的角色恰好是*反向*的：读等式的两个方向都有意义（这是“全课程的主题”）。

#importantbox[
  *等式的两读（材料原话：“you can read equalities in two directions. Both are interesting typically.”）*：
  - 左读（求值）：$1/(1-x)$ 我不知道值，级数 $sum x^n$ 给我一个计算它的方法；
  - 右读（展开）：级数 $sum x^n$ 只是左边函数的另一种表达式；
  - 两个方向都“有趣、有用”——这是贯穿全课程的思维习惯，幂级数正是为这个双向翻译而生的工具。
]

$ "右式是左式的计算公式" : 1/(1-x) = sum x^n $

*符号表*：等式可以向左读（求值）也可以向右读（展开）——“You can think, I don't know what the value of this is. Here's a way of evaluating it. Or you can think of the left side as being a formula for the right side.”

级数*足够灵活*，能表示我们课里遇到的所有函数——这工具正如十进制展开让人抓住所有实数一样，让 $e^x$、$arctan x$、$sin x$、$cos x$ 全部“随手可用、直接可算”。

#knowledgebox[
  *十进制展开的类比展开*：$sqrt(2) = 1.41421356 dots.c$ 虽然永远写不完，但每一位都可以算出来——十进制展开“抓住”了 $sqrt(2)$。相似地，$e^x = 1 + x + x^2/2! + dots.c$ 虽然永远写不完，但每一项都能算出来——幂级数“抓住”了 $e^x$。这个类比是 MIT 课程体系里反复出现的母题，也是本笔记开头全部动机的来源；它顺带解释了为什么叫“展开”（expansion）——像把压缩在函数里的信息一点点“摊平”成可算的级数。
]

== Taylor 公式陈述

#knowledgebox[
  *Taylor 公式与幂级数展开的唯一性*：如果一个函数在某区间上有幂级数展开，那么它的系数一定是 $f^((n))(0)/n!$——没有第二种可能。这就解释了为什么“用几何级数算”“用 Taylor 公式算”两条路会汇合到同一个级数（例如 $1/(1+x)$ 的路径）。这种“两条路通一个答案”的现象是幂级数理论里最令人安心的性质之一。
]

先补一个官方约定（网页 block-5 讲义）：阶乘 $n!$ 定义为 $n! = n(n-1)(n-2) dots.c 1$（所有整数 $n >= 1$），并*额外约定* $0! = 1$——“This is a very valuable convention that simplifies many formulas.”

现在给出*Taylor 公式*——从函数走到系数的翻译机：
$ f(x) = sum_(n=0)^(oo) (f^((n))(0)) / (n!) x^n quad (abs(x) < R) $

*符号表*：$f^((n))(0)$ 是 f 的 n 阶导数在 0 处的值（$f^((0))=f$）；$n!$ 是阶乘；$x^n$ 是幂；$R$ 是收敛半径。右边称作 f 的 *Taylor 级数*（在 0 点，也叫 Maclaurin 级数）。官方讲义补充：本课只处理“在半径内函数等于其 Taylor 级数”的函数——$f(x) = sum f^((n))(0)/n! x^n quad (|x| < R)$——这是一个很大的函数类，覆盖本课所有常用函数。

“这公式告诉你 Taylor 级数是什么。” 接下来一多半的时间都是它的例子；但老师先讲*为什么*它必须长这样。

== 为什么系数必然长这样：逐阶求导“挑出” a_n

假设 $f(x) = a_0 + a_1 x + a_2 x^2 + a_3 x^3 +$……，然后逐次求导：

一阶：$f'(x) = a_1 + 2 a_2 x + 3 a_3 x^2 + 4 a_4 x^3 + dots.c$

二阶：$f''(x) = 2 a_2 + 3 dot 2 a_3 x + 4 dot 3 dot 2 a_4 x^2 + dots.c$

三阶：$f''' (x) = 3 dot 2 a_3 + 4 dot 3 dot 2 a_4 x + dots.c$

*符号表*：每求一次导，系数“掉下来”一个因子（$x^n -> n x^(n-1)$）；幂次降低。

现在代入 $x = 0$：除了常数项外全都消失！
$ f(0) = a_0 ; quad f'(0) = a_1 ; quad f''(0) = 2 a_2 ; quad f'''(0) = 3 dot 2 a_3 = 3! a_3 $

*符号表*：$3 dot 2 = 3!$（乘到 1 为止）。

于是：
$ a_n = f^((n))(0) / (n!) $

*符号表*：这就是 Taylor 公式的系数来源——$f$ 在 0 点的 n 阶导除以 n!。

#importantbox[
  *Taylor 公式的“挑系数”原理（材料原话重述）*：f 的幂级数系数“记录”了函数在 x=0 的各阶导数信息。$3 times 2 times 1 a_3$ 正是 $f'''(0)$，一般地 $a_n = f^((n))(0)/n!$。工具：反复求导、代入 0、看系数。
]

== 0! = 1：一个“疯狂的约定”

公式在 $n = 0$ 处需要一个约定：阶乘 $n!$ 对 $n >= 1$ 是 $n(n-1)(n-2) dots.c 1$，但对 $n = 0$ 我们定义：
$ 0! = 1 $

*符号表*：这不是“算出来的”，是约定（convention）——“there's something very strange here down at 0. Which is that 0 factorial, it turns out, has to be set equal to 1. So that's what you do in order to make this formula work out.”

#knowledgebox[
  *为什么 0! 必须等于 1*：因为 $n! = n(n-1)!$ 的递推在 n=1 时给出 $1! = 1 dot 0!$，只有 $0! = 1$ 这条链才能闭合；同时 Taylor 公式第一项（常数项）需要 $f(0)/0! dot x^0 = f(0)$。两个理由指向同一个约定。
]

== 官方热身：线性、二次逼近与“接着逼近”的心智模型

网页 block-4（“Review linear and quadratic approximations”）是 Taylor 公式的官方前奏——它是本讲的一个“回顾站”：我们已经会做线性与二次逼近，现在把“逼近到 n 阶”推广成概念。

$ L(x) = f(0) + f'(0)x quad; quad q(x) = f(0) + f'(0)x + (f''(0))/2 x^2 $

*符号表*：$L$ 是线性近似（在 $x=0$ 与 $f$ 的函数值、一阶导一致）；$q$ 是二次近似（额外与 $f$ 的二阶导一致）。官方练习问：哪些等式“必然成立”？答案如下——线性近似：$f(0) = L(0)$、$f'(0) = L'(0)$（函数值与一阶导在 0 处相等；注意 $f''(0) = L''(0)$ 不成立，因为 $L'' = 0$）；二次近似：$f(0) = q(0)$、$f'(0) = q'(0)$、$f''(0) = q''(0)$。

*官方“Food for thought”原文*：“Now we can imagine coming up with a best fit cubic function to our function at 0, the best fit 4th degree polynomial, 5th degree polynomial etc. If we continue this process to infinitely many terms, we end up with a power series whose derivatives all agree with the derivatives of our original function at the point 0.”——*无限逼近下去的极限就是 Taylor 级数*。这句话把“线性/二次/三次逼近”与“Taylor 级数”连成一条线，正是本讲所有故事的骨架。

*官方练习（Cubic approximations, 1 分）*：最佳三次逼近是
$ f(0) + f'(0)x + (f''(0))/2 x^2 + (f'''(0))/6 x^3 $

*符号表*：系数规律与 Taylor 公式完全一致：第 $k$ 项系数 $= f^((k))(0)/k!$，三次项除以 $3! = 6$。官方五个候选选项中只有这一个带了正确组合（其它混淆了 $f'''(0)/3$、$f'''(0)/12$ 或把系数顺序摆错）。

#practicebox[
  *官方热身的一体两面*：逼近公式 $f(0) + f'(0)x + f''(0)/2 x^2 + dots.c$ 展开写即 $f(0)/0! x^0 + f'(0)/1! x + f''(0)/2! x^2 + dots.c$——和 Taylor 公式逐项对应。所以“十项逼近”与“Taylor 级数前十项”是同一个东西；不同之处只在“要不要让 $n -> oo$“。做这道题的收获：把”导数表 → 除以阶乘 → 拼起来“写成肌肉记忆。
]

= 🌟 三大代表级数：e^x、sin x、cos x 与 e 的惊人之数

现在用 Taylor 公式推出最重要的例子。

== e^x：全部导数是自己，所以所有系数是 1

设 $f(x) = e^x$。它的导数是自己，二阶还是自己，一直如此：
$ f(x) = f'(x) = f''(x) = f''' (x) = dots.c = e^x $

*符号表*：指数函数微分还原自身，全部阶导数都是 $e^x$。

在 $x = 0$ 处求值，全部等于 1：
$ f^((n))(0) = 1 quad "对所有" n $

*符号表*：$e^0 = 1$，每个阶导数在 0 处都是 1。

Taylor 公式立刻给出：
$ e^x = sum_(n=0)^(oo) x^n / (n!) = 1 + x + x^2/(2!) + x^3/(3!) + x^4/(4!) + dots.c $

*符号表*：系数全是 $1/n!$；这就是 $e^x$ 的幂级数，也是（前面例 2 见过的）R=∞ 的级数。

特别地，取 $x = 1$ 得到 “e 的第一个诚实公式”：
$ e = sum_(n=0)^(oo) 1/(n!) = 1 + 1 + 1/(2!) + 1/(3!) + 1/(4!) + dots.c $

*符号表*：$x = 1$ 代入；第一项 $n=0$ 是 1，第二项 $n=1$ 是 1，其后是分数阶乘求和——快速收敛！

#importantbox[
  *e 的级数表达（材料原话）*：“This is our first honest formula for e, and also this is how you compute the exponential function.”——这是历史上第一次有人给 e 一个“看得见”的精确表达式（1780 年前后 Euler 的发现，见后文），也是现代计算器算 exp 的底层原理。
]

== sin x 与 cos x：交替奇偶幂家族

接下来是“完成课程开头那次奇怪工作”（线性/二次逼近补全）。老师先直接给出结论，再在下一段用 Taylor 公式严格推导 sin：

$ sin x = x - x^3/(3!) + x^5/(5!) - x^7/(7!) + dots.c $

$ cos x = 1 - x^2/(2!) + x^4/(4!) - x^6/(6!) + dots.c $

*符号表*：sin 只有奇次幂、符号交替；cos 只有偶次幂、符号交替；分母都是相应幂次的阶乘。

#importantbox[
  *三函数“同一家族”记忆法（材料原话要点）*：“These may feel like they're hard to memorize… They're actually extremely similar formulas. The exponential here just has this collection of factorials. The sine is all the odd powers with alternating signs, and the cosine is all the even powers with alternating signs. So all three of them form part of the same family.”

  口诀：$e^x$ 全阶乘；sin 奇幂交替；cos 偶幂交替。知道一个就能推另两个。官方讲义补充一句“注意阶乘出现在所有三项的分母里”（“the factorial appears in the denominator of all terms in all three power series”）。
]

#figure(
  cetz.canvas(length: 1.5cm * dia-scale, {
    import cetz.draw: *
    line((0.2, 0), (4.8, 0), stroke: 0.8pt)
    line((0.2, -1.7), (0.2, 1.7), stroke: 0.8pt)
    // sin x 部分和：x, x-x³/6
    let s1 = ()
    let s3 = ()
    let t = 0.05
    while t <= 4.6 {
      s1.push((t, calc.sin(t)))
      s3.push((t, t - calc.pow(t, 3) / 6))
      t += 0.05
    }
    line(..s1, stroke: 1.1pt + red)
    line(..s3, stroke: 1.1pt + green.darken(20%), dashed: (spacing: 2pt))
    content((2.0, 1.35), $ sin x $, fill: red)
    content((3.6, 0.75), $ x - x^3/3! $, fill: green.darken(20%))
    content((0.2, -1.9), $ x $, anchor: "north-west")
  }),
  caption: [$sin x$ 与其三次 Taylor 近似 $x - x^3/3!$：近似在原点周围牢牢“咬住”曲线，越远偏差越大——这正是“级数逐点逼近 + 收敛半径给出有效范围”的可视化。],
)
#footnote[来源：转录 v4/v8 sin 级数段（示意曲线，按讲解绘制）；本方验证：图内容（sin 曲线与三次近似贴合）× 材料段（“If you take enough terms, you'll get a good evaluation of the sine of x for any x”）× caption 一致。]

== 官方练习 5：三大级数的半径与 e 的快速收敛

网页 block-5 的“Radius of convergence”官方练习（3 分）直接问：$e^x$、$sin x$、$cos x$ 三个 Taylor 级数的 $R$ 分别是多少？

#practicebox[
  *官方答案：三个全是 $R = oo$*。
  - $e^x = sum x^n/n!$：比值法 $lim |x|/(n+1) = 0 < 1$，任意 x 收敛（例 2 已算过）；
  - $sin x = sum (-1)^n x^(2n+1)/(2n+1)!$：比值法 $lim |x|^2/((2n+3)(2n+2)) = 0$（下节详细走一遍）；
  - $cos x = sum (-1)^n x^(2n)/(2n)!$：与 sin 同理。
  注意“半径无穷”不等于“级数简单”——它只说明：无论你把 e 代入多离谱的 x（比如 $x = 10^6$），级数都收敛，只是部分和要算很久才逼近。
]

同一网页还有一个“秘密武器”：用 $e^x$ 的级数在 $x = 1$ 处得到 $e$ 的*快速收敛*级数（官方还特意把凑法写在讲义第三段）：
$ e = sum_(n=0)^(oo) 1/(n!) = 1 + 1 + 1/2 + 1/6 + 1/24 + 1/120 + dots.c $

*符号表*：$1/n!$ 下降得比任何等比 $r^n$ 都快（$n!$ 超越任何指数），所以部分和每加一项误差就缩小一个量级——这也是“rapidly converging series”的官方注脚。

== 官方练习 6：奇偶性“白送”两个新级数

网页 block-5 的“Evenness and oddness”官方练习（2 分）教了一个零方法：把 $-x$ 代入已知级数。已知
$ sin (x) = sum_(n=0)^(oo) (-1)^n x^(2n+1)/(2n+1)! = x - x^3/(3!) + x^5/(5!) - x^7/(7!) + dots.c $

代入 $-x$（只写到 $x^5$ 为止）：
$ sin (-x) = -x + x^3/(3!) - x^5/(5!) + dots.c = -(x - x^3/3! + x^5/5! - dots.c) = -sin x $

*符号表*：奇次幂 $x^(2n+1)$ 在 $x -> -x$ 时整体变号，故 $sin(-x) = -sin(x)$——奇函数性在级数里“自动”成立。

同理对 $cos x = 1 - x^2/(2!) + x^4/(4!) - x^6/(6!) + dots.c$ 代入 $-x$（写到 $x^4$ 为止）：
$ cos (-x) = 1 - x^2/(2!) + x^4/(4!) + dots.c = cos x $

*符号表*：偶次幂不变号，$cos(-x) = cos(x)$——偶函数性同样免费获得。

#knowledgebox[
  *官方练习的深层意义*：奇偶性这类函数性质，在级数表示下变成了“幂次的奇偶”检查。反过来这也演示了本课结尾的主题——级数擅长暴露某些性质（这里是奇偶性），同时隐藏另一些（周期性）。“代入 $-x$“是级数运算的入门级技巧：它花零成本，却每用必对。
]

= 🔬 例题课：多项式的 Taylor 级数就是它自己

习题课（转录 v6）做个“看起来像个玩笑”的例题：求
$ f(x) = 3 x^3 + 4 x^2 - 2 x + 1 $
的 Taylor 级数。

== 建表：f 与逐阶导数在 0 的值

#practicebox[
  *建导数表的标准姿势*：把“原函数、一阶、二阶、三阶……”写在表头，每行先写完整表达式、再代入 $x=0$。三阶导后如果变成常数（如本题 18），下一行立刻是 0——看到常数导数是“马上就能停”的信号。老师还特意演示了“第四阶导数是什么？常数函数的导数，是 0”，这一步让表在此封顶。
]

用 Taylor 公式，先建一个导数表：

#booktabs-table(
  columns: (2fr, 3fr, 2fr),
  [导数阶数],
  [表达式],
  [$x=0$ 处的值],
  [$f(x)$],
  [$3x^3 + 4x^2 - 2x + 1$],
  [$1$],
  [$f'(x)$],
  [$9x^2 + 8x - 2$],
  [$-2$],
  [$f''(x)$],
  [$18x + 8$],
  [$8$],
  [$f'''(x)$],
  [$18$],
  [$18$],
  [$f^((4))(x)$],
  [$0$],
  [$0$],
  [$f^((5))(x)$],
  [$0$],
  [$0$],
)

*符号表*：第一行原函数在 0 处 = 1；一阶导 $9x^2+8x-2$ 在 0 处 = -2；二阶导 $18x+8$ 在 0 处 = 8；三阶导常数 18，在 0 处 = 18；四阶以后全为 0（常数函数导数是 0）。老师：“So the nth derivative at 0 is equal to 0 for n bigger than 3.”

== 代入 Taylor 公式：每阶一项拼回来

#warningbox[
  *分母不写错是本题唯一风险*：$f''(0)/(2!)$ 里的 $2! = 2$、$f'''(0)/(3!)$ 里的 $3! = 6$——如果写成“除以 2”和“除以 3”（忘了阶乘），答案就差一个因子。材料里老师一步一步说“8 over 2 because 2 factorial is 2”、“18 divided by 6 because 3 factorial is 6”，正是为了把“除以阶乘”的口诀钉进脑子里。
]

逐项代入：
$ f(0)/(0!) = 1 quad => quad $ 第一项 $= 1$

$ f'(0)/(1!) x = -2 x quad => quad $ 第二项 $= -2x$

$ f''(0)/(2!) x^2 = 8/2 x^2 = 4 x^2 quad => quad $ 第三项 $= 4x^2$

$ f'''(0)/(3!) x^3 = 18/6 x^3 = 3 x^3 quad => quad $ 第四项 $= 3x^3$

*符号表*：$0! = 1$，$1! = 1$，$2! = 2$，$3! = 6$；$8/2 = 4$，$18/6 = 3$。

其余项全 0，停。于是：
$ 3x^3 + 4x^2 - 2x + 1 quad => quad "Taylor 级数" = 3 x^3 + 4 x^2 - 2 x + 1 $

*符号表*：级数收敛回原函数——只是幂次顺序相反（从低到高）。

== 吐槽时间：Christine，这是疯了吗？

老师在视频里演出“有人看到这里会说：Christine，this is madness！”的桥段。为什么是 Madness？因为答案是原函数。为什么？因为——*多项式的 Taylor 级数永远是它自己*：四阶以上导数全为 0，级数在有限项截断，恰好还原。这正是“quadratic approximation of polynomials at x = 0 is just the polynomials”的同款故事。

#importantbox[
  *多项式的 Taylor 级数 = 原多项式（材料结论）*：对任何多项式，$n$ 大于其次数后导数全 0，Taylor 级数是有限和且逐项还原。这是一道“唬人题”：如果直接看出这一点，答案可以秒写；看不出就老老实实建表，也能得到相同答案——两种路径殊途同归。老师的话：“Hey, now any time I see a polynomial and I want to do the Taylor series… I just have to write down the polynomial, again.”

  用第四律的“一般化”说：*N 次多项式的 N+1 阶逼近就是它自己*——这正是“逼近”变“精确”的一个阈值时刻：逼近次数一旦超过多项式次数，近似就变成恒等。
]

#figure(
  cetz.canvas(length: 1.30cm * dia-scale, {
    import cetz.draw: *
    line((0.2, 0), (4.8, 0), stroke: 0.8pt)
    line((0.2, -1.6), (0.2, 1.6), stroke: 0.8pt)
    let f0 = ()
    let f1 = ()
    let f2 = ()
    let f3 = ()
    let t = 0.1
    while t <= 4.7 {
      f0.push((t, 1))
      f1.push((t, 1 - 2 * t))
      f2.push((t, 1 - 2 * t + 4 * calc.pow(t, 2)))
      f3.push((t, 1 - 2 * t + 4 * calc.pow(t, 2) + 3 * calc.pow(t, 3)))
      t += 0.05
    }
    line(..f0, stroke: 0.9pt + luma(150))
    line(..f1, stroke: 0.9pt + orange)
    line(..f2, stroke: 0.9pt + red, dashed: (spacing: 2pt))
    line(..f3, stroke: 1.2pt + blue)
    content((2.9, 1.35), $ f(x) = 3x^3 + 4x^2 - 2x + 1 $, fill: blue)
    content((3.4, 0.55), $ "部分和" $, fill: red)
    content((2.7, 0.1), $ 1 - 2x $, fill: orange)
    content((0.25, 1.7), $ "一次/二次/三次部分和" $, fill: luma(100), anchor: "north-west")
  }),
  caption: [多项式的 Taylor 部分和链：常数项 $1$（灰）、一次部分和 $1-2x$（橙）、二次部分和 $1-2x+4x^2$（红）、三次部分和 $1-2x+4x^2+3x^3$（蓝）——最后一条与原多项式完全重合。三阶以后导数全为 0，级数在有限项处"追平"原函数，这就是"多项式的 Taylor 级数就是它自己"的图像化。],
)
#footnote[来源：转录 v6 多项式例题（导数表与回归讨论，示意曲线按讲解重绘）；本方验证：图内容（四条部分和曲线，第三条与蓝色原曲线重合）× 材料段（"This is the function, again. It's exactly were we start at… the orders opposite of what it was before"）× caption 一致。]

#practicebox[
  *自己再算一个*：求 $g(x) = 2x^4 - x^2 + 5$ 的 Taylor 级数。提示：$g(0)=5$，$g'(0)=0$，$g''(0)=-2$（除以 2! 得 -1），$g'''(0)=0$，$g^((4))(0)=48$（除以 4!=24 得 2），于是级数 $= 5 - x^2 + 2x^4$，又还原了！四阶导不为 0 但四阶以上全 0。

  官方 quiz（block-6，1 分）再递进一层：*次数 ≤ 200 的多项式的 Taylor 级数，$R = ∞$*——因为它是有限和（从 0 到 200 的有限项），对所有 x 都收敛，$R = oo$ 是官方“多项式半径 $= oo$“条目的直接应用。
]

= 📦 1/(1+x)：半径 1 的"样板课"

主讲老师（转录 v7）说下一个例子是*牛顿*的（上一个 e^x 是*欧拉*的——“This example wasn't due to David Jerison. It was due to Leonhard Euler”；而 1/(1+x) 这个例子，“I think this was due to Newton, not Euler.”）。

== 由几何级数写出展开

求 $1/(1+x)$ 的幂级数展开。用几何级数知识直接写：
$ 1 / (1 + x) = 1 - x + x^2 - x^3 + x^4 - dots.c quad (abs(x) < 1) $

*符号表*：把几何级数里的 $-x$ 当公比：$1/(1-(-x)) = sum (-x)^n$；括号展开得正负交替；$|x| < 1$ 因 $|-x| = |x|$。

“你可能想知道这些负号哪里来——答案就在几何级数里的减号，被替换成这些负号。”

== x = -1 的极点：R 不可能是 ∞

#knowledgebox[
  *极点与半径的“距离法则”*：幂级数的收敛半径其实等于“展开点到最近奇点（极点或更一般的奇点）的复数距离”——这是一个在复分析里成立的深层事实，本课只需要它的雏形：$1/(1+x)$ 在 $-1$ 处分母为 0（极点），这个“坏点”离原点距离 1，所以 $R = 1$。函数在 $+1$ 处光滑也无济于事：半径看的是“最近的坏点”，而不是“最远的好点”。
]

回想 $y = 1/(1+x)$ 的图象：当 $x = -1$ 时分母为 0，函数“竖起”一个*极点*（pole），冲向 $oo$。函数在那里爆炸——这意味着若级数在 $x = -1$ 处试图收敛到“∞”，它会遇到大麻烦（$1/(1+x)$ 级数在 $x=-1$ 处每项都是 1，越加越大，根本不收敛）。

$ "所以" quad R != oo quad "；事实上" quad R = 1 $

*符号表*：函数本身的奇点（极点）决定了收敛半径——这只是表面现象吗？看下一问。

== 学生的尖锐一问：x = +1 处明明光滑，为什么半径还是 1？

学生提问（原话大意）：“我看到 x=-1 会爆炸。可 x=+1 时图象非常光滑、人畜无害、值是有限的，为什么 1/(1+x) 的级数在 x=+1 处也出问题？半径为什么不是 2 之类的数？”

老师回答：“Excellent question.” 关键：*半径是个“到最近奇异点的距离”，只要有一个方向出问题，半径就到此为止*。把 $x=+1$ 代入级数，看部分和：
$ 1, quad 1 - 1 = 0, quad 1 - 1 + 1 = 1, quad 1 - 1 + 1 - 1 = 0, quad dots.c $

*符号表*：部分和在 1 与 0 之间震荡（不爆炸、也不收敛）——这正是上一课 $a=-1$ 几何级数的老朋友：公式给出 1/2，级数震荡。

#warningbox[
  *端点行为：“发散但不爆炸”也是发散*：$x = +1$ 处部分和 1,0,1,0,… 振荡不定；$x = -1$ 处发散到 ∞。两种“死法”都判定级数在该点不安全，所以它们都落在“边界排除区”——这就是为什么我们在“整数端点”上什么结论都不能下。老师原话：“Even though it doesn't blow up to infinity, it still does not converge. And any of these other things will also fail to converge in this example. Well, that's the only two real numbers are at the edge.”
]

#figure(
  cetz.canvas(length: 1.30cm * dia-scale, {
    import cetz.draw: *
    line((0.3, 0), (4.8, 0), mark: (end: "stealth"), stroke: 0.8pt)
    line((0.3, 0), (0.3, 2.6), mark: (end: "stealth"), stroke: 0.8pt)
    let pts = ()
    let t = 0.4
    while t <= 4.7 {
      pts.push((t, 1 / (1 + t)))
      t += 0.06
    }
    line(..pts, stroke: 1.3pt + black)
    // x = -1 极点标记（在原点左侧不可画负区间，用虚线提示）
    line((0.3, -0.25), (0.3, 2.6), stroke: 0.8pt + red, dashed: (spacing: 2pt))
    content((0.3, 2.75), $ "x = -1 极点" $, fill: red, anchor: "south")
    content((3.2, 1.9), $ y = 1/(1+x) $, anchor: "south")
    content((1.7, 1.3), $ "在 +1 处光滑但 R=1" $, fill: gray, anchor: "south")
  }),
  caption: [$y = 1/(1+x)$：左侧 $x=-1$ 处有极点（红色虚竖线），半径上限被它锁死为 1；即使正方向 $x=+1$ 处函数值光滑有限，级数在那里也震荡不收敛——半径只看“最远可达的坏点”。],
)
#footnote[来源：转录 v7 “pole” 段与课堂问答（示意曲线按讲解重绘）；本方验证：图内容（极点竖线、$1/(1+x)$ 曲线）× 材料段（“The graph has a pole there, goes up to infinity at x equals minus 1… That's an indication that the radius of convergence is not infinity”）× caption 一致。]

== 官方练习 7：用 Taylor 公式验证 1/(1+x) 的系数

网页 block-5 的“Gold standard”练习（The geometric series, 2 分）要求用 Taylor 公式验证 $1/(1+x)$ 的级数确实是几何级数 $sum (-1)^n x^n$。做法：先求 $1/(1+x)$ 的第 $n$ 阶导数：

$ d^n/(d x^n) 1/(1+x) = (-1)^n n! / (1+x)^(n+1) $

*符号表*：每求一阶导，幂次加 1、系数乘 $-(k)$；$n$ 阶导即 $(-1)^n (1+x)^(-(n+1))$ 乘 $n!$。

代入 $x = 0$ 得 $d^n/(d x^n) 1/(1+x) bar_(x=0) = (-1)^n n!$，再除以 $n!$：
$ a_n = ((-1)^n n!)/(n!) = (-1)^n quad => quad 1/(1+x) = sum_(n=0)^(oo) (-1)^n x^n quad (abs(x) < 1) $

*符号表*：$a_n = (-1)^n$，即系数序列 $+1, -1, +1, -1, dots.c$——与“几何级数把 $-x$ 当公比“的答案一模一样。两条路（几何级数公式 vs Taylor 公式）通向同一个展开，这是官方想让你记住的”自洽性证据“。

#knowledgebox[
  *两路验证为什么让人安心*：在数学里“同一对象的不同表示”必须互相印证。$1/(1+x)$ 用几何级数一眼看出 $sum (-x)^n$，用 Taylor 公式逐阶求导也能得出 $a_n = (-1)^n$——两个独立推导都指向同一系数序列。考试里如果你用“捷径”（几何级数）写出的展开与“死算”（Taylor 公式）对不上，其中必有一个错了。
]

== 写多少项才算“写完”？

学生问：“写幂级数时要写多远才算定义良好/考试够用？” 老师答：“*写到你能看出模式为止*。那足够好。”“Some people would tell you that you have to write the summation convention thing. Don't believe them.”

#practicebox[
  *判断“模式已可见”的实用标准*：写 3~4 项，然后标注 $dots.c$，再（可选）给出通项公式 $f^((n))(0)/n!$。若通项写不出，用“第 k 项 =（模式描述）”也可以。不必强写 $sum$ 记号——除非题目明确要求闭式。另注意老师顺手补充的一条习惯：*写幂级数时要说清它的收敛半径*（“whenever you write out a power series, you should say what the radius of convergence is”）。
]

== 课堂问答 3：哪些函数能写成幂级数？

学生问：“哪些函数可以写成幂级数？” 老师回答：“任何有合理表达式的函数都能写成幂级数。”——他随即补充：“我没给你很好的答案，因为真正的答案有点复杂；但微积分里出现的函数——sin、cos、tan——它们都有幂级数展开。”

#knowledgebox[
  *“合理表达式”背后的真话*：严格地说，一个函数能写成幂级数，需要它是“解析函数”（在某点邻域内能展开成收敛的幂级数）。但老师给出课程级别的结论已够用：本课遇到的三角函数、指数函数、有理函数都能展开。更多函数（如 $arctan x$）可用“积分 $1/(1+x^2)$ 的级数“得到——这正是”积分保持半径“的一个实用推论。
]

== 半径内的“高级待遇”：函数有全部导数

主讲老师在复习时说：“在收敛半径内，函数拥有*全部阶导数*——就像多项式那样。你可以反复求导，而系数 $a_n$ 可以用导数在 0 点的值表达（这就是 Taylor 公式）。“

#importantbox[
  *幂级数在半径内的“三件套”待遇（转录 v7 + PDF p3 综合）*：
  1. 逐项微分：$dif/dif x sum a_n x^n = sum n a_n x^(n-1)$，同半径；
  2. 逐项积分：$integral sum a_n x^n dif x = c + sum a_n x^(n+1)/(n+1)$，同半径；
  3. 系数可反解：$a_n = f^((n))(0)/n!$（Taylor 公式）。

  换句话说：半径内的幂级数“既是函数、又像多项式”——它是可微性最强的函数（平滑到无穷阶）。这也是老师“generalized polynomials”说法的数学内容。
]

= 🌊 sin x 的正式推导与 R=∞ 的两条证明

最后一个大段落（转录 v8 + 网页 block-7）：用 Taylor 公式严格推出 sin x，并用*两种独立方法*证明它的半径是 ∞。

== 循环导数链：sin → cos → -sin → -cos → sin

#knowledgebox[
  *四步循环为什么必然发生*：从 $sin$ 出发，每求导一次就“换人”一次，顺序是 $sin -> cos -> -sin -> -cos -> sin$。这对应到一个矩阵运算：$dif/dif x$ 作用在二维向量空间 ${cos x, sin x}$ 上就是旋转 $90°$；转四次回到原点。记住“每次换人、每四次复活”就足够写出完整的导数表。
]

开始算 $sin x$ 的各阶导数：
$
  f(x) = sin x quad => quad f'(x) = cos x quad => quad f''(x) = -sin x quad => quad f'''(x) = -cos x quad => quad f^((4))(x) = sin x
$

*符号表*：$sin$ 导数是 $cos$；$cos$ 导数是 $-sin$；$-sin$ 导数是 $-cos$；$-cos$ 导数是 $+sin$（两个负号抵消）。四步一循环——“all of the sudden, I'm right back where I started.”

代入 $x = 0$：
$ sin 0 = 0 ; quad cos 0 = 1 ; quad -sin 0 = 0 ; quad -cos 0 = -1 ; quad sin 0 = 0 ; quad dots.c $

*符号表*：值序列是 0, 1, 0, -1, 0, 1, 0, -1…… 四周期循环。奇数阶导的 0 值让 $x^1, x^3, x^5$ 项有系数，偶数阶导的 1 值让 $x^2, x^4$ 项系数为 0。

代入 Taylor 公式：
$ sin x = 0 + 1 dot x + 0/(2!) x^2 + (-1)/(3!) x^3 + 0/(4!) x^4 + 1/(5!) x^5 + dots.c $

*符号表*：$n=0$ 项 0；$n=1$ 项 $x$；$n=2$ 项 0；$n=3$ 项 $-x^3/3!$；$n=4$ 项 0；$n=5$ 项 $+x^5/5!$。

于是（老师随即验证“够不够看出来模式”——下一项该是 $-x^7/7!$）：
$ sin x = x - x^3/(3!) + x^5/(5!) - x^7/(7!) + dots.c = sum_(n=0)^(oo) (-1)^n x^(2n+1)/(2n+1)! $

*符号表*：奇次幂、正负交替、分母为幂次的阶乘——“And so the signs alternate, and these denominators get very big, don't they? Exponentials grow very fast.”

== 证明一（转录 v8）：固定 x 的“连乘积”论证

为什么这个级数对*任何* x 都收敛（R=∞）？关键：看通项的大小：
$ |x|^(2n+1) / (2n+1)! = |x|/1 dot |x|/2 dot |x|/3 dots.c dot |x|/(2n+1) $

*符号表*：分子 $|x|^(2n+1)$ 拆成 $2n+1$ 个 $|x|$；分母 $(2n+1)!$ 拆成 $1 dot 2 dot 3 dots.c (2n+1)$——这样每一个因子都是 $abs(x)$ 除以某个正整数。

现在固定一个 $x$（“Let's fix a number x… Big, but fixed”），比如 $x = 1,000,000$：
- 前几个因子很大：$10^6/1$、$10^6/2$、$10^6/3$；
- 但当 $n = 10^6$ 左右时，因子约等于 $1/2$；
- 当 $n = 10^9$ 时，因子约等于 $1/2000$；
- *分母越来越大，分子永远是同一个 x*。乘得足够远后，你是在乘以越来越多、越来越小的数——所以无论 x 多大，$abs(x)^m / m! -> 0$。

#importantbox[
  *连乘积法结构（材料原话要点）*：把 $x^m/m!$ 写成一串 “x 除以 1、x 除以 2、x 除以 3……” 的连乘积；只要乘得足够远，因子就小于 1 且越来越小。每个固定 x 都如此，于是对一切 x 通项 → 0 —— 这就是 R = ∞ 的信号。“This convergence to 0 of the general term works for every x, then the radius of convergence is infinity.”
]

== 证明二（网页 block-7）：比值法直接算

官方网课（block-7 的“Radius of convergence of Taylor series of sine”小节）用我们熟悉的比值法走了一遍——两者等价，但这遍是“标准流程”：

$
  lim_(n -> oo) abs(((-1)^(n+1) x^(2(n+1)+1))/((2(n+1)+1)!)) dot abs(((2n+1)!)/((-1)^n x^(2n+1))) = |x|^2 lim_(n -> oo) 1/((2n+2)(2n+3)) = |x|^2 dot 0 = 0 quad "对任何 x"
$

*符号表*：$n -> n+1$ 时代入是 $x^(2n+3)$ 与 $(2n+3)!$；符号相除 $(-1)^(n+1)/(-1)^n = -1$，但取绝对值后消失；$|x|^2$ 提出极限外；$(2n+3)!/(2n+1)! = (2n+2)(2n+3)$ 只剩两项。极限恒为 0 小于 1，故 *R = ∞*（对所有 x 绝对收敛）。

官方还给了一个备选评注：若只关心收敛（不要求绝对收敛），也可在*每个固定 x*上用交错级数判别法——因为 $n$ 增大时 $|(-1)^n x^(2n+1)/(2n+1)!|$ 单调下降（分母阶乘压过分子幂），正负交替的级数收敛。两条路（比值法/交错判别法）都说明：sin 的级数的确是“所有实数都能用”的展开。

#warningbox[
  *比值法 vs 连乘积：何时用哪个*：比值法“机械化”、三步出结果（写比值、约分、取极限）；连乘积论证“可视化”（看因子逐渐小于 1），适合解释“为什么”、也适合口述题。两者不矛盾：是对同一定理的两个视角。考试求 $R$ 首选比值法；解释为什么 $R = oo$ 时，连乘积那句“因子最后都小于 1”最有直觉冲击力。
]

== 官方练习 8：cos x 的系数表与 x^18 的系数

网页 block-7 的“Taylor series of cosine”官方练习（9 分）把 cos 的推导拆成填空：先列 $cos^(n)(x)$，再列 $cos^(n)(0)/n!$（$n = 0..4$），最后求 $x^18$ 的系数。

#booktabs-table(
  columns: (1.6fr, 3fr, 2.6fr),
  [$n$],
  [$cos^(n)(x)$],
  [$cos^(n)(0) / n!$],
  [$0$],
  [$cos x$],
  [$1 / 0! = 1$],
  [$1$],
  [$-sin x$],
  [$0 / 1! = 0$],
  [$2$],
  [$-cos x$],
  [$-1 / 2! = -1/2$],
  [$3$],
  [$sin x$],
  [$0 / 3! = 0$],
  [$4$],
  [$cos x$],
  [$1 / 4! = 1/24$],
)

*符号表*：$cos$ 导数链 $cos -> -sin -> -cos -> sin -> cos$ 四步循环；$n = 0..4$ 处 $cos^((n))(0)$ 依次为 $1, 0, -1, 0, 1$；除以 $n!$ 即得出前五项系数 $1, 0, -1/2, 0, 1/24$。

*系数规律*：仅 $n$ 为偶数时非零，且替号为 $(-1)^(n/2)$。于是 $x^18$ 的系数（$n = 18$ 必为偶数项，而 $cos x = sum (-1)^n x^(2n)/(2n)!$ 中 $x^18 = x^(2n)$ 对应 $n = 9$）：

$ "Coefficient of " x^18 quad = quad (-1)^9 / (18!) quad = quad -1/(18!) $

*符号表*：$2n = 18 => n = 9$；偶数次幂项正负交替，$n = 9$ 为负号；分母阶乘为 $18!$。官方答案即 $-1/18!$——顺带说明：Taylor 系数“除以阶乘”的约定，在具体项里表现为 $cos^((n))(0)/n!$，千万不能漏掉阶乘分母。

= 📈 更多展开与应用：让幂级数"干活"

第四律允许并鼓励主动教学扩充。这一节用本课已经学到的工具，展示幂级数还能干哪些活——全部基于材料中的思想在变式中的直接延伸，不是新材料。

== 用逐项积分造新级数：arctan x 与 ln(1+x)

我们已经见过官方例子 $-ln(1-x) = sum x^n/n$。同样手法可造 $arctan x$：把 $1/(1+x^2)$ 展开成几何级数再积分：
$ 1 / (1 + x^2) = 1 - x^2 + x^4 - x^6 + dots.c = sum_(n=0)^(oo) (-1)^n x^(2n) quad (abs(x) < 1) $

*符号表*：把几何级数中的 $x$ 换成 $-x^2$；公比是 $-x^2$，绝对值小于 1 时收敛（$|x| < 1$）。

逐项积分：
$
  arctan x = integral dif x / (1 + x^2) = x - x^3/3 + x^5/5 - x^7/7 + dots.c = sum_(n=0)^(oo) (-1)^n x^(2n+1) / (2n+1) quad (abs(x) < 1)
$

*符号表*：$integral x^(2n) dif x = x^(2n+1)/(2n+1)$；$arctan 0 = 0$ 确定积分常数为 0。

取 $x = 1$（虽然边界需谨慎，本课“跳过端点”——此处作为材料外扩展展示）可得莱布尼茨级数：
$ pi / 4 = 1 - 1/3 + 1/5 - 1/7 + dots.c $

*符号表*：$arctan 1 = pi/4$；这是人类最早用级数“计算” $pi$ 的公式之一（莱布尼茨-格雷戈里）。注意：材料里没有这行——它由上面两级数公式直接推出，属本笔记扩充，供认识“级数=计算工具”的力量。

#practicebox[
  *同理可证：$ln(1+x)$ 的级数*：从 $1/(1+x) = 1 - x + x^2 - x^3 + dots.c$ 逐项积分得 $ln(1+x) = x - x^2/2 + x^3/3 - x^4/4 + dots.c$（$|x| < 1$）。请自己写一遍：$integral 1/(1+x) dif x = ln(1+x)$，右边逐项积分的正负号要跟着 $(-1)^n$ 走。
]

== 用幂级数做数值近似：算算 e 与 sin(1)

$e = sum 1/n!$ 是“快速收敛”的级数——试算它的部分和：
$ S_5 = 1 + 1 + 1/2 + 1/6 + 1/24 + 1/120 = 2.716666 dots.c quad ("真实值" e approx 2.71828) $

*符号表*：$S_5$ 是前六项（$n = 0..5$）的和；$delta approx 0.0016$——误差已经在千分之一量级！这就是“阶乘分母飞快放大→级数快速收敛”的直观证据：每加一项，误差缩小一个因子 $1/(n+1)$。

再算 $sin(1)$：取 $x = 1$，前两项（$x - x^3/3!$）给出 $1 - 1/6 = 0.8333$，前四项（加 $x^5/5!$ 与 $-x^7/7!$ 及 $x^9/9!$）给出 $0.84147 dots.c$，真值 $sin 1 = 0.84147 dots.c$——两项就已精确到小数点后一位，六项到六位。幂级数就是这样“用多少项买多少精度”。

#warningbox[
  *近似是有“有效期”的*：$e$ 与 $sin$ 的级数对所有 x 收敛（R=∞），且收敛很快；但像 $1/(1+x)$ 这种 R=1 的级数，在 $|x|$ 接近 1 时收敛极慢（部分和在 0 与 1 之间震荡不决）——“级数收敛”不等于“级数好用”，还要看收敛半径内离端点有多远。
]

== 幂级数大结局：为什么“数字计算机”离得开它

回到课程开头的动机：指数、正弦、余弦是第一批“无法用有限过程描述”的函数。现在你手里有了它们的级数——而级数恰好是*有限过程能逼近的*：算 $n$ 项只需有限次四则运算。这就是科学计算里“计算 exp 与三角”的底层原理：级数给“抽象函数”做出了“可执行的定义”。

#knowledgebox[
  *本课核心闭环（材料首尾呼应）*：开头说“指数/三角是超越函数，无法用有限过程描述”，结尾我们拿到了它们“按任意精度逼近的有限配方”。幂级数正是“超越函数”与“可计算性”之间的桥梁——这是本课（而非单纯技巧列表）的真正价值。
]

#figure(
  cetz.canvas(length: 1.5cm * dia-scale, {
    import cetz.draw: *
    line((0.2, 0), (4.8, 0), stroke: 0.8pt)
    line((0.2, -1.8), (0.2, 1.8), stroke: 0.8pt)
    let s_exp = ()
    let s_sin = ()
    let s_cos = ()
    let t = 0.05
    while t <= 4.6 {
      s_exp.push((t, 1 + t + calc.pow(t, 2) / 2 + calc.pow(t, 3) / 6))
      s_sin.push((t, t - calc.pow(t, 3) / 6 + calc.pow(t, 5) / 120))
      s_cos.push((t, 1 - calc.pow(t, 2) / 2 + calc.pow(t, 4) / 24))
      t += 0.05
    }
    line(..s_exp, stroke: 1.1pt + blue)
    line(..s_sin, stroke: 1.1pt + red)
    line(..s_cos, stroke: 1.1pt + green.darken(20%), dashed: (spacing: 2pt))
    content((2.6, 1.55), $ "三函数部分和" $, fill: blue)
    content((3.4, 0.9), $ e^x $, fill: blue)
    content((3.6, 0.2), $ sin x $, fill: red)
    content((3.4, -0.6), $ cos x $, fill: green.darken(20%))
    content((0.2, -2.0), $ x $, anchor: "north-west")
  }),
  caption: [三大代表级数的部分和对比：$e^x$（蓝，全阶乘）、$sin x$（红，奇幂交替）、$cos x$（绿，偶幂交替）各取前四项，都在原点附近忠实复刻“函数家族”的模样——三式同族、分工不同，这正是“三函数家族”记忆法的图景。],
)
#footnote[来源：转录 v5 三函数级数段与“同一家族”讨论（示意曲线，按讲解重绘）；本方验证：图内容（三条部分和曲线分别对应 e^x/sin/cos）× 材料段（“The exponential here just has this collection of factorials. The sine is all the odd powers with alternating signs, and the cosine is all the even powers with alternating signs. So all three of them form part of the same family.”）× caption 一致。]

= 🧠 全课回顾：幂级数看到的与看不到的

== 官方总结表：已知 Maclaurin 级数

#practicebox[
  *背表诀窍：三行一起背*：$e^x$ 是全阶乘级数；$sin x$ 把 $e^x$ 的偶次项删掉、奇次项乘以 $(-1)^n$；$cos x$ 把奇次项删掉、偶次项乘以 $(-1)^n$。以“全”为基准去“删减”，比三张表孤立背要快得多。最后一行 $ln(1-x)$ 不靠背：它在考场上可以用“逐项积分几何级数”临时推出来。
]

#booktabs-table(
  columns: (2.4fr, 3.6fr),
  [函数],
  [Taylor 级数（在 0 点展开）],
  [$1/(1-x)$],
  [$sum_(n=0)^(oo) x^n$，$abs(x) < 1$],
  [$e^x$],
  [$sum_(n=0)^(oo) x^n/(n!)$，对所有 $x$],
  [$sin x$],
  [$sum_(n=0)^(oo) (-1)^n x^(2n+1)/(2n+1)!$，对所有 $x$],
  [$cos x$],
  [$sum_(n=0)^(oo) (-1)^n x^(2n)/(2n)!$，对所有 $x$],
  [$-ln(1-x)$],
  [$sum_(n=1)^(oo) x^n/n$，$abs(x) < 1$],
)

*符号表*：最后一行由几何级数逐项积分得到（$integral sum x^n dif x = sum x^(n+1)/(n+1)$；$-ln(1-x) = integral dif x/(1-x)$）——这是“积分保持半径”的官方演示。另可加一行 $1/(1+x) = sum (-1)^n x^n quad (|x|<1)$（由 $-x$ 代换得到），它就是第五行几何级数的“交替兄弟”。

== 幂级数会“隐藏”函数性质

老师在结尾给出最重要的一课：幂级数擅长某些事，但也*隐藏*其它性质。

$ sin x = x - x^3/(3!) + x^5/(5!) - dots.c $ 里：
- 从这个公式*很难看出* $sin x$ 是*周期函数*（“Not obvious at all”）；
- 某个地方藏着数 $pi$（半周期：$pi/2$），但级数里完全看不见（“Somewhere hidden away in this expression is the number pi, the half the period. But that's not clear from the power series at all.”）。

#warningbox[
  *“级数表示”≠“全部信息”*：幂级数适合做数值计算、微分积分、微扰展开；不适合看周期性、对称性、渐近行为。考研常见陷阱：“写出幂级数后以为掌握了函数的一切”——记住材料结语：“The power series are very good for some things, but they hide other properties of functions.”
]

== 级数告诉我们很多，但不是全部

回到 $sin x$ 的级数，听老师做最后的“留白”陈述——这也是本课最点睛的一段话，值得逐句收进笔记。

他说：“Anyway, so we've got the sine function, a new function with its own power series. It's a way of computing the sine of x. If you take enough terms, you'll get a good evaluation of the sine of x for any x. This tells you a lot about the function sine of x, but not everything at all.”

*逐句拆解*：
- *“It's a way of computing”*：级数给了 $sin x$ 一个“计算方法”——你不再需要查表或看图，只要有限次四则运算就能逼近任意精度；
- *“tells you a lot… but not everything”*：这是数学语言里“局部 vs 全局”的张力：级数描述的是“原点附近的全部”，但不是“函数在所有意义下的全部”；
- *反例就是周期性*：$sin$ 最著名的性质是周期 $2pi$，但从展开式 $x - x^3/3! + x^5/5! - dots.c$ 中*根本看不出来*。

#knowledgebox[
  *从级数看“隐藏的 $pi$“*：$pi$ 半周期藏在 $sin$ 级数深处——$sin(pi/2) = 0$ 意味着“把 $pi/2$ 代入级数会得到 0“，一个关于 $pi$ 的、完全不平凡的等式。但级数公式本身不含 $pi$：这就是“表达式蕴含信息但不可见”的活例子。
]

== 全课武器箱与自测

#importantbox[
  *为什么武器箱表是笔记的“枢纽”*：它把“六种工具、三十多条细节”压缩成一张决策表——你拿到一道幂级数题，先问：“求什么？半径？展开？还是证明性质？”再沿表定位到对应行。这正是把材料里“零散规则”变成“可操作流程”的一步，也是复习时唯一需要闭上眼默写的页。
]

#table(
  columns: (1fr, 2.1fr, 2.1fr),
  inset: 8pt,
  align: (center + horizon),
  stroke: 0.5pt + luma(150),
  fill: (col, row) => if row == 0 { luma(240) } else { none },
  [*工具*], [*内容*], [*注意*],
  [几何级数公式], [$sum x^n = 1/(1-x)$，$|x|<1$], [错位相减证明有一个“假设 S 存在”的瑕疵],
  [收敛半径 R], [$|x|<R$ 收敛、$|x|>R$ 发散、$|x|=R$ 不碰], [极点锁死 R；$R=0$ 只收敛于原点],
  [比值法求 R], [$lim abs(a_(n+1)/a_n) dot abs(x) < 1$], [阶乘差几个因子要展开；$L=1$ 无结论],
  [备选公式], [$lim abs(a_n/a_(n+1)) = R$], [与比值法互为倒数；$a_n$ 在分子],
  [根值法求 R], [$lim abs(a_n)^(1/n) dot abs(x) < 1$], [与比值法结论平行；用 $lim b^(1/n)=1$ 等],
  [逐项微积分], [半径不变、系数按多项式规则], [只在半径内合法；± 加减取 min(A,B)],
  [Taylor 公式], [$f(x) = sum f^((n))(0)/n! x^n$], [0!=1 约定；系数是“函数在 0 点的各阶导”],
  [三大级数], [$e^x$ 全阶乘、sin 奇幂交替、cos 偶幂交替], [同族记忆；sin/cos R=∞（比值法+连乘积）],
  [函数隐藏性], [级数暴露可算性，掩盖周期性/π], [“tells you a lot, but not everything”],
)

== 自测问题

#practicebox[
  *自测顺序建议*：先默写“三大级数 + 半径值”（30 秒）；再默写求 R 的比值法与备选公式（30 秒）；然后动笔做官方练习 3 的四道半径题（5 分钟）；最后口述第 4 题“隐藏性质”的答案。答错第 4 题的同学，请回到“幂级数会隐藏函数性质”一节重读——那是本课最重要的“元认知”结论。
]

1. *基础层*：写出几何级数公式及其证明的“错位相减”三步；指出该证明在哪一步有缺陷。
2. *理解层*：为什么 $e^x$ 的幂级数半径是 ∞，而 $1/(1+x)$ 的半径只能是 1（即使 $x=+1$ 处函数光滑）？
3. *应用层*：求 $sum (x/3)^n$、$sum x^n/(n!)$、$sum x^(2n)/(2n)!$、$sum n! x^n$ 的收敛半径；再做官方练习 3 四题（$sum x^n/n$、$1-x$、$sum n!x^n/n^n$、$sum n^n x^n$）。
4. *陷阱层*：一位同学说“$sin x$ 的幂级数中能直接看到周期性“，对不对？为什么？另一个同学说”$sum x^(2n)/(2n)!$ 是 $cos x$ 的级数“，对不对？为什么？

== 参考答案

1. 见“错位相减”节：乘 x、相减、得 $S(1-x)=1$；缺陷是假设 $S$ 存在（$x=1$ 时 $∞-∞$ 无意义）。
2. $e^x$ 无极点、通项 $x^n/n!$ 的连乘积对固定 x 最终因子 $< 1$（R=∞）；$1/(1+x)$ 在 $x=-1$ 有极点，半径被锁死在 1（这是“到最近坏点的距离”）。
3. 依次为：R=3（几何）、R=∞（e^x）、R=∞（cosh x，注意不是 cos x！）、R=0（$lim abs(n! x^n)^(1/n) = oo dot abs(x)$，仅 $x=0$ 收）。官方练习 3：$R=1$、$R=oo$、$R=e$、$R=0$。
4. 第一个不对：级数中周期性完全不可见——$pi$ 藏在级数深处（材料原话：“Not obvious at all. Somewhere hidden away in this expression is the number pi.”）。第二个不对：$sum x^(2n)/(2n)!$ 是 $upright(cosh) x$，无交替符号；$cos x$ 必须带 $(-1)^n$（官方勘误：“Christine says the example is the series for cos x, but that is an error.”）。

#practicebox[
  *考研视角一分钟串讲*：求和式看到 $r^n$ 的幂结构 → 几何级数或比值法；看到 $a_n$ 与 $x^n$ 组合 → 比值法或根值法求 $R$；看到抽象函数 → 用 Taylor 公式求系数（先算导数表）；看到要证 $R = oo$ → 固定 $x$ 后把 $x^m/m!$ 拆成连乘积论证，或用比值法一步到位。三大级数（$sum x^n/n! = e^x$、$sum (-1)^n x^(2n+1)/(2n+1)! = sin x$、$sum (-1)^n x^(2n)/(2n)! = cos x$）必须在 10 秒内写全；另记官方四练习之三：$sum n!x^n/n^n$ 的半径是 $e$（用备选公式 $lim |a_n/a_(n+1)|$）。本讲还有一个传说中的考点：$sum x^(2n)/(2n)! = upright(cosh) x$ 而*不是* $cos x$ —— 官方的勘误就是最好的命题提醒。
]
