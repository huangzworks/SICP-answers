.. SICP 习题解答 documentation master file, created by
   sphinx-quickstart on Tue Apr 17 02:29:51 2012.
   You can adapt this file completely to your liking, but it should at least
   contain the root `toctree` directive.

SICP 解题集
=====================================

.. image:: image/cover.jpg
   :align: left
   :width: 408px
   :height: 580px
   :scale: 29

这个文档的目标是成为中文化的、完整的\ `《计算机程序的构造和解释》 <http://book.douban.com/subject/1148282>`_\ 一书的解题集。

这个解题集的特色是：

| 对于每道习题，除了习题答案之外，还给出习题的讲解和相关资料(如果有的话)；
| 使用 MIT Scheme 作为编程环境，完全避免了代码不兼容的问题；
| 所有代码都经过测试，确保准确性。

:doc:`relate` 介绍了这个解题集中用到的程序和工具。


.. _chp1:

第一章： 构造过程抽象
------------------------

- 1.1 程序设计的基本元素

    - 1.1.1 表达式
    - 1.1.2 命名和环境
    - 1.1.3 组合式的求值
    - 1.1.4 复合过程
    - 1.1.5 过程应用的代换模型
    - 1.1.6 条件表达式和谓词(:doc:`chp1/1`\ ，\ :doc:`chp1/2`\ ，\ :doc:`chp1/3`\ ，\ :doc:`chp1/4`\ ，\ :doc:`chp1/5`\ )
    - 1.1.7 实例： 采用牛顿法求平方根(:doc:`chp1/6`\ ，\ :doc:`chp1/7`\ ，\ :doc:`chp1/8`)
    - 1.1.8 过程作为黑箱抽象

- 1.2 过程与它们所产生的计算

    - 1.2.1 线性的递归和迭代(:doc:`chp1/9`\ ，\ :doc:`chp1/10`)
    - 1.2.2 树形递归(:doc:`chp1/11`\ ，\ :doc:`chp1/12`\ ，\ :doc:`chp1/13`)
    - 1.2.3 增长的阶(:doc:`chp1/14`\ ，\ :doc:`chp1/15`)
    - 1.2.4 求幂(:doc:`chp1/16`\ ，\ :doc:`chp1/17`\ ，\ :doc:`chp1/18`\ ，\ :doc:`chp1/19`)
    - 1.2.5 最大公约数(:doc:`chp1/20`)
    - 1.2.6 实例： 素数检测(:doc:`chp1/21`\ ，\ :doc:`chp1/22`\ ，\ :doc:`chp1/23`\ ，\ :doc:`chp1/24`\ ，\ :doc:`chp1/25`\ ，\ :doc:`chp1/26`\ ，\ :doc:`chp1/27`\ ，\ :doc:`chp1/28`)

- 1.3 用高阶函数做抽象

    - 1.3.1 过程作为参数(:doc:`chp1/29`\ ，\ :doc:`chp1/30`\ ，\ :doc:`chp1/31`\ ，\ :doc:`chp1/32`\ ，\ :doc:`chp1/33`)
    - 1.3.2 用 lambda 构造过程(:doc:`chp1/34`)
    - 1.3.3 过程作为一般性的方法(:doc:`chp1/35`\ ，\ :doc:`chp1/36`\ ，\ :doc:`chp1/37`\ ，\ :doc:`chp1/38`\ ，\ :doc:`chp1/39`)
    - 1.3.4 过程作为返回值(:doc:`chp1/40`\ ，\ :doc:`chp1/41`\ ，\ :doc:`chp1/42`\ ，\ :doc:`chp1/43`\ ，\ :doc:`chp1/44`\ ，\ :doc:`chp1/45`\ ，\ :doc:`chp1/46`)


.. _chp2:

第二章： 构造数据抽象
---------------------------------

- 2.1 数据抽象导引

    - 2.1.1 实例： 有理数的算术运算(:doc:`chp2/1`)
    - 2.1.2 抽象屏障(:doc:`chp2/2`\ ，\ :doc:`chp2/3`)
    - 2.1.3 数据意味着什么(:doc:`chp2/4`\ ，\ :doc:`chp2/5`\ ，\ :doc:`chp2/6`)
    - 2.1.4 扩展练习： 区间算术(:doc:`chp2/7`\ ，\ :doc:`chp2/8`\ ，\ :doc:`chp2/9`\ ，\ :doc:`chp2/10`\ ，\ :doc:`chp2/11`\ ，\ :doc:`chp2/12`\ ，\ :doc:`chp2/13`\ ，\ :doc:`chp2/14`\ ，\ :doc:`chp2/15`\ ，\ :doc:`chp2/16`\)

- 2.2 层次性数据和闭包性质

    - 2.2.1 序列的表示(:doc:`chp2/17`\ ，\ :doc:`chp2/18`\ ，\ :doc:`chp2/19`\ ，\ :doc:`chp2/20`\ ，\ :doc:`chp2/21`\ ，\ :doc:`chp2/22`\ ，\ :doc:`chp2/23`)
    - 2.2.2 层次性结构(:doc:`chp2/24`\ ，\ :doc:`chp2/25`\ ，\ :doc:`chp2/26`\ ，\ :doc:`chp2/27`\ ，\ :doc:`chp2/28`\ ，\ :doc:`chp2/29`\ ，\ :doc:`chp2/30`\ ，\ :doc:`chp2/31`\ ，\ :doc:`chp2/32`)
    - 2.2.3 序列作为一种约定的界面(:doc:`chp2/33`\ ，\ :doc:`chp2/34`\ ，\ :doc:`chp2/35`\ ，\ :doc:`chp2/36`\ ，\ :doc:`chp2/37`\ ，\ :doc:`chp2/38`\ ，\ :doc:`chp2/39`\ ，\ :doc:`chp2/40`\ ，\ :doc:`chp2/41`\ ，\ :doc:`chp2/42`\ ，\ :doc:`chp2/43`)
    - 2.2.4 实例： 一个图形语言(:doc:`chp2/44`\ ，\ :doc:`chp2/45`\ ，\ :doc:`chp2/46`\ ，\ :doc:`chp2/47`\ ，\ :doc:`chp2/48`\ ，\ :doc:`chp2/49`\ ，\ :doc:`chp2/50`\ ，\ :doc:`chp2/51`\ ，\ :doc:`chp2/52`)

- 2.3 符号数据

    - 2.3.1 引号(:doc:`chp2/53`\ ，\ :doc:`chp2/54`\ ，\ :doc:`chp2/55`)
    - 2.3.2 实例： 符号求导(:doc:`chp2/56`\ ，\ :doc:`chp2/57`\ ，\ :doc:`chp2/58`)
    - 2.3.3 实例： 集合的表示(:doc:`chp2/59`\ ，\ :doc:`chp2/60`\ ，\ :doc:`chp2/61`\ ，\ :doc:`chp2/62`\ ，\ :doc:`chp2/63`\ ，\ :doc:`chp2/64`\ ，\ :doc:`chp2/65`\ ，\ :doc:`chp2/66`)
    - 2.3.4 实例： Huffman 编码树(:doc:`chp2/67`\ ，\ :doc:`chp2/68`\ ，\ :doc:`chp2/69`\ ，\ :doc:`chp2/70`\ ，\ :doc:`chp2/71`\ ，\ :doc:`chp2/72`)

- 2.4 抽象数据的多重表示

    - 2.4.1 复数的表示
    - 2.4.2 带标志数据
    - 2.4.3 数据导向的程序设计的可加性(:doc:`chp2/73`\ ，\ :doc:`chp2/74`\ ，\ :doc:`chp2/75`\ ，\ :doc:`chp2/76`)

- 2.5 带有通用型操作的系统

    - 2.5.1 通用型算术运算(:doc:`chp2/77`\ ，\ :doc:`chp2/78`\ ，\ :doc:`chp2/79`\ ， :doc:`chp2/80`)
    - 2.5.2 不同类型数据的组合(:doc:`chp2/81`\ ，\ :doc:`chp2/82`\ ，\ :doc:`chp2/83`\ ，\ :doc:`chp2/84`\ ，\ :doc:`chp2/85`\ ，\ :doc:`chp2/86`)
    - 2.5.3 实例： 符号代数(:doc:`chp2/87`\ ，\ :doc:`chp2/88`\ ，\ :doc:`chp2/89`\ ，\ :doc:`chp2/90`\ ，\ :doc:`chp2/91`\ ，\ :doc:`chp2/92`\ ，\ :doc:`chp2/93`\ ，\ :doc:`chp2/94`\ ，\ :doc:`chp2/95`\ ，\ :doc:`chp2/96`\ ，\ :doc:`chp2/97`)


.. _chp3:

第三章： 模块化、对象和状态
---------------------------------

- 3.1 赋值和局部状态

    - 3.1.1 局部状态变量(:doc:`chp3/1`\ ，\ :doc:`chp3/2`\ ，\ :doc:`chp3/3`\ ，\ :doc:`chp3/4`\)
    - 3.1.2 引进赋值带来的利益(:doc:`chp3/5`\ ，\ :doc:`chp3/6`)
    - 3.1.3 引进赋值的代价(:doc:`chp3/7`\ ，\ :doc:`chp3/8`)

- 3.2 求值的环境模型

    - 3.2.1 求值规则
    - 3.2.2 简单过程的应用(:doc:`chp3/9`)
    - 3.2.3 将框架看作局部状态的展台(:doc:`chp3/10`)
    - 3.2.4 内部定义(:doc:`chp3/11`)

- 3.3 用变动数据做模拟

    - 3.3.1 变动的表结构(:doc:`chp3/12`\ ，\ :doc:`chp3/13`\ ，\ :doc:`chp3/14`\ ，\ :doc:`chp3/15`\ ，\ :doc:`chp3/16`\ ，\ :doc:`chp3/17`\ ，\ :doc:`chp3/18`\ ，\ :doc:`chp3/19`\ ，\ :doc:`chp3/20`)
    - 3.3.2 队列的表示(:doc:`chp3/21`\ ，\ :doc:`chp3/22`\ ，\ :doc:`chp3/23`)
    - 3.3.3 表格的表示(:doc:`chp3/24`\ ，\ :doc:`chp3/25`\ ，\ :doc:`chp3/26`\ ，\ :doc:`chp3/27`)
    - 3.3.4 数字电路的模拟器(:doc:`chp3/28`\ ，\ :doc:`chp3/29`\ ，\ :doc:`chp3/30`\ ，\ :doc:`chp3/31`\ ，\ :doc:`chp3/32`)
    - 3.3.5 约束的传播(:doc:`chp3/33`\ ，\ :doc:`chp3/34`\ ，\ :doc:`chp3/35`\ ，\ :doc:`chp3/36`\ ，\ :doc:`chp3/37`)

- 3.4 并发：时间是一个本质问题

    - 3.4.1 并发系统中时间的性质(:doc:`chp3/38`)
    - 3.4.2 控制并发的机制(:doc:`chp3/39`\ ，\ :doc:`chp3/40`\ ，\ :doc:`chp3/41`\ ，\ :doc:`chp3/42`\ ，\ :doc:`chp3/43`\ ，\ :doc:`chp3/44`\ ，\ :doc:`chp3/45`\ ，\ :doc:`chp3/46`\ ，\ :doc:`chp3/47`\ ，\ :doc:`chp3/48`\ ，\ :doc:`chp3/49`)

- 3.5 流

    - 3.5.1 流作为延时的表(:doc:`chp3/50`\ ，\ :doc:`chp3/51`\ ，\ :doc:`chp3/52`)
    - 3.5.2 无穷流(:doc:`chp3/53`\ ，\ :doc:`chp3/54`\ ，\ :doc:`chp3/55`\ ，\ :doc:`chp3/56`\ ，\ :doc:`chp3/57`\ ，\ :doc:`chp3/58`\ ，\ :doc:`chp3/59`\ ，\ :doc:`chp3/60`\ ，\ :doc:`chp3/61`\ ，\ :doc:`chp3/62`)
    - 3.5.3 流计算模式的使用(:doc:`chp3/63`\ ，\ :doc:`chp3/64`\ ，\ :doc:`chp3/65`\ ，\ :doc:`chp3/66`\ ，\ :doc:`chp3/67`\ ，\ :doc:`chp3/68`\ ，\ :doc:`chp3/69`\ ，\ :doc:`chp3/70`\ ，\ :doc:`chp3/71`\ ，\ :doc:`chp3/72`\ ，\ :doc:`chp3/73`\ ，\ :doc:`chp3/74`\ ，\ :doc:`chp3/75`\ ，\ :doc:`chp3/76`)
    - 3.5.4 流和延时求值(:doc:`chp3/77`\ ，\ :doc:`chp3/78`\ ，\ :doc:`chp3/79`\ ，\ :doc:`chp3/80`)
    - 3.5.5 函数式程序的模块化和对象的模块化(:doc:`chp3/81`\ ，\ :doc:`chp3/82`)


.. _chp4:

第四章： 元语言抽象
---------------------------

- 4.1 元循环求值器

    - 4.1.1 求值器的内核(:doc:`chp4/1`)

    - 4.1.2 表达式的表示(:doc:`chp4/2`\ ，\ :doc:`chp4/3`\ ，\ :doc:`chp4/4`\ ，\ :doc:`chp4/5`\ ，\ :doc:`chp4/6`\ ，\ :doc:`chp4/7`\ ，\ :doc:`chp4/8`\ ，\ :doc:`chp4/9`\ ，\ :doc:`chp4/10`)

    - 4.1.3 求值器数据结构(:doc:`chp4/11`\ ，\ :doc:`chp4/12`\ ，\ :doc:`chp4/13`)

    - 4.1.4 作为程序运行这个求值器(:doc:`chp4/14`)

    - 4.1.5 将数据作为程序(:doc:`chp4/15`)

    - 4.1.6 内部表示(:doc:`chp4/16`\ ，\ :doc:`chp4/17`\ ，\ :doc:`chp4/18`\ ，\ :doc:`chp4/19`\ ，\ :doc:`chp4/20`\ ，\ :doc:`chp4/21`)

    - 4.1.7 将语法分析和执行分离(:doc:`chp4/22`\ ，\ :doc:`chp4/23`\ ，\ :doc:`chp4/24`)

- 4.2 Scheme 的变形 —— 惰性求值

    - 4.2.1 正则序和应用序(:doc:`chp4/25`\ ，\ :doc:`chp4/26`)

    - 4.2.2 一个采用惰性求值的解释器(:doc:`chp4/27`\ ，\ :doc:`chp4/28`\ ，\ :doc:`chp4/29`\ ，\ :doc:`chp4/30`\ ，\ :doc:`chp4/31`)

    - 4.2.3 将流作为惰性的表(:doc:`chp4/32`\ ，\ :doc:`chp4/33`\ ，\ :doc:`chp4/34`)

- 4.3 Scheme 的变形 —— 非确定性求值

    - 4.3.1 amb 和搜索(:doc:`chp4/35`\ ，\ :doc:`chp4/36`\ ，\ :doc:`chp4/37`)

    - 4.3.2 非确定性程序的实例(:doc:`chp4/38`\ ，\ :doc:`chp4/39`\ ，\ :doc:`chp4/40`\ ，\ :doc:`chp4/41`\ ，\ :doc:`chp4/42`\ ，\ :doc:`chp4/43`\ ，\ :doc:`chp4/44`\ ，\ :doc:`chp4/45`\ ，\ :doc:`chp4/46`\ ，\ :doc:`chp4/47`\ ，\ :doc:`chp4/48`\ ，\ :doc:`chp4/49`)

    - 4.3.3 实现 amb 求值器(:doc:`chp4/50`\ ，\ :doc:`chp4/51`\ ，\ :doc:`chp4/52`\ ，\ :doc:`chp4/53`\ ，\ :doc:`chp4/54`)

- 4.4 逻辑程序设计

    - 4.4.1 演绎信息检索(:doc:`chp4/55`\ ，\ :doc:`chp4/56`\ ，\ :doc:`chp4/57`\ ，\ :doc:`chp4/58`\ ，\ :doc:`chp4/59`\ ，\ :doc:`chp4/60`\ ，\ :doc:`chp4/61`\ ，\ :doc:`chp4/62`\ ，\ :doc:`chp4/63`)

    - 4.4.2 查询系统如何工作

    - 4.4.3 逻辑程序设计是数理逻辑吗(:doc:`chp4/64`\ ，\ :doc:`chp4/65`\ ，\ :doc:`chp4/66`\ ，\ :doc:`chp4/67`\ ，\ :doc:`chp4/68`\ ，\ :doc:`chp4/69`)

    - 4.4.4 查询系统的实现(:doc:`chp4/70`\ ，\ :doc:`chp4/71`\ ，\ :doc:`chp4/72`\ ，\ :doc:`chp4/73`\ ，\ :doc:`chp4/74`\ ，\ :doc:`chp4/75`\ ，\ :doc:`chp4/76`\ ，\ :doc:`chp4/77`\ ，\ :doc:`chp4/78`\ ，\ :doc:`chp4/79`)


.. _chp5:

第五章： 寄存器机器里的计算
------------------------------

- 5.1 寄存器机器的设计(:doc:`chp5/1`)

    - 5.1.1 一种描述寄存器机器的语言(:doc:`chp5/2`)

    - 5.1.2 机器设计的抽象(:doc:`chp5/3`)

    - 5.1.3 子程序

    - 5.1.4 采用堆栈实现递归(:doc:`chp5/4`\ ，\ :doc:`chp5/5`\ ，\ :doc:`chp5/6`)

    - 5.1.5 指令总结

- 5.2 一个寄存器机器模拟器(:doc:`chp5/7`)

    - 5.2.1 机器模型

    - 5.2.2 汇编程序(:doc:`chp5/8`)

    - 5.2.3 为指令生成执行过程(:doc:`chp5/9`\ ，\ :doc:`chp5/10`\ ，\ :doc:`chp5/11`\ ，\ :doc:`chp5/12`\ ，\ :doc:`chp5/13`)

    - 5.2.4 监视机器执行(:doc:`chp5/14`\ ，\ :doc:`chp5/15`\ ，\ :doc:`chp5/16`\ ，\ :doc:`chp5/17`\ ，\ :doc:`chp5/18`\ ，\ :doc:`chp5/19`)

- 5.3 存储分配和废料收集

    - 5.3.1 将存储看作向量(:doc:`chp5/20`\ ，\ :doc:`chp5/21`\ ，\ :doc:`chp5/22`)

    - 5.3.2 维持一种无穷存储的假象

- 5.4 显式控制的求值器

    - 5.4.1 显式控制求值器的内核

    - 5.4.2 序列的求值和尾递归

    - 5.4.3 条件、赋值和定义(:doc:`chp5/23`\ ，\ :doc:`chp5/24`\ ，\ :doc:`chp5/25`)

    - 5.4.4 求值器的运行(:doc:`chp5/26`\ ，\ :doc:`chp5/27`\ ，\ :doc:`chp5/28`\ ，\ :doc:`chp5/29`\ ，\ :doc:`chp5/30`)

- 5.5 编译

    - 5.5.1 编译器的结构(:doc:`chp5/31`\ ，\ :doc:`chp5/32`)

    - 5.5.2 表达式的编译

    - 5.5.3 组合式的编译

    - 5.5.4 指令序列的组合

    - 5.5.5 编译代码的实例(:doc:`chp5/33`\ ，\ :doc:`chp5/34`\ ，\ :doc:`chp5/35`\ ，\ :doc:`chp5/36`\ ，\ :doc:`chp5/37`\ ，\ :doc:`chp5/38`)

    - 5.5.6 词法地址(:doc:`chp5/39`\ ，\ :doc:`chp5/40`\ ，\ :doc:`chp5/41`\ ，\ :doc:`chp5/42`\ ，\ :doc:`chp5/43`\ ，\ :doc:`chp5/44`)

    - 5.5.7 编译代码和求值器的互连(:doc:`chp5/45`\ ，\ :doc:`chp5/46`\ ，\ :doc:`chp5/47`\ ，\ :doc:`chp5/48`\ ，\ :doc:`chp5/49`\ ，\ :doc:`chp5/50`\ ，\ :doc:`chp5/51`\ ，\ :doc:`chp5/52`)


项目进度
----------------

目前项目仍处于开发阶段，贡献、提交建议或意见，请到项目的 github 页面： `https://github.com/huangz1990/SICP-answers <https://github.com/huangz1990/SICP-answers>`_ 。


下载离线版本
---------------

`HTML 格式 <https://media.readthedocs.org/htmlzip/sicp/latest/sicp.zip>`_

注意，因为文档总是在不断地更新和修正当中，请定期下载最新的离线文档，确保获得最好的阅读体验。


关于
-----

这个解题集的绝大部分练习由 huangz 完成，在我遇上解不出的问题时， `Eli Bendersky 的 SICP 解答 <http://eli.thegreenplace.net/category/programming/lisp/sicp/>`_ 和 `sicp.org.ua 上的 WIKI <http://sicp.org.ua/sicp>`_ 总能给我很大帮助，在此对他们表示感谢。

你可以免费下载、阅读、复制、传播和修改本文档及相应的代码示例，如果需要其他使用许可，请用以下任一方式联系本人： 
向 gmail 帐号 huangz1990 发送邮件 / `豆瓣 <http://www.douban.com/people/i_m_huangz>`_ /  `twitter <http://www.twitter.com/huangz1990>`_


评论
-------
