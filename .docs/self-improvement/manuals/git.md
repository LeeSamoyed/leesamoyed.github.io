# Git

由于是在线文档导致pdf,png等资料无法看清，建议直接下载相关文件

如果存在资料过期、资料过时，建议通过首页邮箱联系

***

### 创建 | CREATE
```
git clone ssh://user@domain.com/xx.git 克隆远程仓库
git init 初始化本地 git 仓库（新建仓库）
```

### 本地更改 | LOCAL CHANGES
```
git status 查看当前版本状态（是否修改）
git diff 显示所有未添加至 index 的变更
git diff HEAD 查看已缓存的与未缓存的所有改动
git add <path> 将该文件添加到缓存
git commit -m ‘xxx’ 提交
git commit --amend -m ‘xxx’ 合并上一次提交（用于反复修改）
git commit -am ‘xxx’ 将 add 和 commit 合为一步
```

### 提交历史记录 | COMMIT HISTORY
```
git log 显示日志
git show <commit> 显示某个提交的详细内容
git blame <file> 在每一行显示 commit 号,提交者,最早提交日期
```

### 分支机构和标签 | BRANCHES & TAGS
```
git branch 显示本地分支
git checkout <branch> 切换分支
git branch <new-branch> 新建分支
git branch --track <new> <remote> 创建新分支跟踪远程分支
git branch -d <branch> 删除本地分支
git tag <tag-name> 给当前分支打标签
```

### 更新和发布 | UPDATE & PUBLISH
```
git remote -v 列出远程分支详细信息
git remote show <remote> 显示某个分支信息
git remote add <remote> <url> 添加一个新的远程仓库
git fetch <remote> 获取远程分支，但不更新本地分支，另需 merge
git pull <remote> <branch> 获取远程分支，并更新本地分支
git push <remote> <branch> 推送本地更新到远程分支
git push <remote> --delete <branch> 删除一个远程分支
git push --tags 推送本地标签
```

### 合并与衍合 | MERGE & REBASE
```
git merge <branch> 合并分支到当前分支，存在两个
git rebase <branch> 合并分支到当前分支，存在一个
git rebase --abort 回到执行 rebase 之前
git rebase --continue 解决矛盾后继续执行 rebase
git mergetool 使用 mergetool 解决冲突
git add <resolve-file> 使用冲突文件解决冲突
git rm <resolved-file>
```

### 撤消 | UNDO
```
git reset --hard HEAD 将当前版本重置为 HEAD（用于 merge 失败）
git reset --hard <commit> 将当前版本重置至某一个提交状态(慎用!)
git reset <commit> 将当前版本重置至某一个提交状态，代码不变
git reset --merge <commit> 重置至某一状态,保留版本库中不同的文件
git reset --keep <commit> 重置至某一状态,重置变化的文件,代码改变
git checkout HEAD <file> 丢弃本地更改信息并将其存入特定文件
git revert <commit> 撤消提交
```

### 帮助 | HELP帮助 | HELP
```
git help <command>  获取命令行上的帮助
```

***

资料:

[W3CSchool](https://www.w3cschool.cn/git/git-cheat-sheet.html)
