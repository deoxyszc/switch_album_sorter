# switch_album_sorter
看到微博上发布的switch整理截图的技巧，感觉不够智能，搜索了一下相关的工具，只有一个外国人用python写的工具，游戏列表也都是英文的。
所以决定弄一个简单的powershell脚本，方便小白用户在windows上直接运行。

[原微博地址](https://weibo.com/6048193311/I2TvJtiu0)

## 使用方法
- switch的截图保存在sd卡中的 *\Nintendo\Album* 目录下，将Album目录整个拷贝到电脑硬盘里
- **假设拷贝后，截图文件夹为** ***D:\Nintendo\Album***
   - 将switch_album_sorter.ps1和game-id.json三个文件拷贝到 *D:\Nintendo\\* 目录中
   - 右键点击switch_album_sorter.ps1，选择“使用PowerShell运行”，脚本开始运行（如果出现需要确认的提示，则输入Y或A，回车），此时会输出原截图路径和整理后截图所在路径。
   - 提示处理完成后，按任意键退出脚本，整理后的图片都保存在 *D:\Nintendo\Album-sorted* 路径下

## 注意事项
- 该脚本是一时兴起现学现弄出来的，测试也只经过了我自己的win10电脑的测试，出现错误在所难免，使用前切记备份好数据
- 其实脚本不是重点，重点是游戏id和游戏名的对照表，这个表目前很不完善，只有我自己机器上截过图的游戏
- 如果这个工具真的能用起来，希望大家踊跃贡献，完善对照表，对照表是json格式的，打开后一目了然。谢谢！~
