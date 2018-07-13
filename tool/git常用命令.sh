#git 只跟踪修改 不跟踪文件
#用户工作区  == add ==>>  暂存区stage/index == commit ==>>  仓库 repository 
#暂存区和仓库是版本库
#分支master 指向分支的指针HEAD
#把这个目录变成Git可以管理的仓库  .git目录
git init #下载一个项目和它的整个代码历史git clone [url]
git add <filename> #把文件添加到暂存区
git commit -m "your commit message" #把暂存区的修改提交到本地仓库
git status #查看仓库、暂存区、工作区状态
git diff <filename>(可选) #查看具体修改
git diff HEAD -- readme.txt  #查看工作区和版本库的区别  HEAD:当前版本

#工作区修改后 先放到暂存区add 再放到仓库commit
git add <filename>
git commit -m "修改信息"

git log <--pretty=oneline> #查看commit仓库中历史记录

#版本回退
git reset --hard HEAD^ # HEAD:当前版本 HEAD^:上个版本 HEAD^^ HEAD~100:100个^
git reset --hard <版本号>
git reflog  #记录仓库中的每一次命令

git checkout -- <filename> #丢弃工作区的修改  把暂存区放到工作区
git reset HEAD <filename> #撤销add暂存区的修改 git reset命令既可以回退版本，也可以把暂存区的修改回退。当我们用HEAD时，表示最新的版本
#如果add了
git reset HEAD <filename> #撤销add暂存区
git checkout -- <filename> #撤销工作区

#删除
git rm <filename>
git commit
#误删回复
git checkout -- <filename> #git checkout其实是用版本库里的版本替换工作区的版本，无论工作区是修改还是删除，都可以“一键还原”

#===============================================
#远程仓库
#本地创建了一个Git仓库后 远程一个git仓库 让这两个仓库进行远程同步
 
# github SSH
ssh-keygen -t rsa -C "youremail@example.com" #创建sshkey
git remote add origin git@github.com:fanshui/javalearn.git #添加远程库 origin是远程仓库的名字
git push -u origin master #本地库的所有内容推送到远程库 仓库同步

git push origin master  #把本地master分支的最新修改推送至GitHub

#从远程库克隆
git clone git@github.com:****



#分支管理
#master:主分支 HEAD--->master---->当前分支
#HEAD指向当前分支
#创建新的分支，例如dev时，Git新建了一个指针叫dev，指向master相同的提交，再把HEAD指向dev，就表示当前分支在dev上
#
#    master
#      | 
#  <当前提交>   --------------->  <下个提交>              
#      |                             |
#     dev <------HEAD                dev <------HEAD
#Git创建一个分支很快，因为除了增加一个dev指针，改改HEAD的指向，工作区的文件都没有任何变化
#从现在开始，对工作区的修改和提交就是针对dev分支了，比如新提交一次后，dev指针往前移动一步，而master指针不变
#假如我们在dev上的工作完成了，就可以把dev合并到master上。Git怎么合并呢？最简单的方法，就是直接把master指向dev的当前提交，就完成了合并

#创建dev分支，然后切换到dev分支
git checkout -b dev
#-b参数表示创建并切换，相当于以下两条命令：
git branch dev  #创建分支
git checkout dev #切换分支
#查看当前分支
git branch

#把dev合并到master
git checkout master
git merge --no-ff dev  #合并指定分支到当前分支。合并后，再查看readme.txt的内容，就可以看到，和dev分支的最新提交是完全一样的 合并完成后，就可以放心地删除dev分支了：
git branch -d dev #删除dev分支

#冲突
git checkout -b fh #新建分支fh
#fh 修改文件 md 并提交
git add md
git commit -m "修改md"
git checkout master #切换到master
#master 修改文件 md 并提交
git add md
git commit -m " modify md"
#分支各自都分别有新的提交 无法执行“快速合并”，只能试图把各自的修改合并起来，但这种合并就可能会有冲突
git merge fh
#====== 报错
Auto-merging README.md
CONFLICT (content): Merge conflict in README.md
Automatic merge failed; fix conflicts and then commit the result.
#============
git status #查看冲突 我们可以直接查看readme.txt的内容 并修改
#再提交
git add <filename>
git commit -m "conflict fixed"

git log --graph --pretty=oneline --abbrev-commit #查看合并情况


#BUG分支
git stash #当前工作现场“储藏”起来，等以后恢复现场后继续工作  现在，用git status查看工作区，就是干净的（除非有没有被Git管理的文件），因此可以放心地创建分支来修复bug
#首先确定要在哪个分支上修复bug，假定需要在master分支上修复，就从master创建临时分支
git checkout master
git checkout -b issue-001
#==修改bug
git add ..
git commit -m "fix bug 001"
#合并
git checkout master
git merge --no-ff issue-001 -m "merged bug fix 001"
#删除bug分支
git branch -d issue-101
#回到dev继续开发
git checkout dev 
#查看工作现场
git stash list
#恢复现场 一是用git stash apply恢复stash@{0}，但是恢复后，stash内容并不删除，你需要用git stash drop来删除；另一种方式是用git stash pop，恢复的同时把stash内容也删了
git stash pop


##多人协作
#当你从远程仓库克隆时，实际上Git自动把本地的master分支和远程的master分支对应起来了，并且，远程仓库的默认名称是origin
#要查看远程库的信息，用git remote
#用git remote -v显示更详细的信息
#
git push origin master/dev/fh #推送分支，就是把该分支上的所有本地提交推送到远程库
#抓取分支
git clone git@github.com:fanshui/javalearn.git
#远程库clone时，默认情况下，你的小伙伴只能看到本地的master分支
git branch
#要在dev分支上开发，就必须创建远程origin的dev分支到本地，于是他用这个命令创建本地dev分支：
git checkout -b dev origin/dev
#就可以在dev上继续修改，然后，时不时地把dev分支push到远程
git add ..
git commit
git push origin dev
#你的小伙伴已经向origin/dev分支推送了他的提交，而碰巧你也对同样的文件作了修改，并试图推送：
git push origin dev
#推送失败，因为你的小伙伴的最新提交和你试图推送的提交有冲突，
#解决办法也很简单，Git已经提示我们，先用git pull把最新的提交从origin/dev抓下来，然后，在本地合并，解决冲突，再推送
git branch --set-upstream dev origin/dev
git pull
#git pull成功，但是合并有冲突，需要手动解决，解决的方法和分支管理中的解决冲突完全一样。解决后，提交，再push
# 多人协作的工作模式通常是这样：

# 首先，可以试图用git push origin branch-name推送自己的修改；

# 如果推送失败，则因为远程分支比你的本地更新，需要先用git pull试图合并；

# 如果合并有冲突，则解决冲突，并在本地提交；

# 没有冲突或者解决掉冲突后，再用git push origin branch-name推送就能成功！

# 如果git pull提示“no tracking information”，
# 则说明本地分支和远程分支的链接关系没有创建，用命令git branch --set-upstream branch-name origin/branch-name。
git fetch origin 远程分支名x:本地分支名x #使用该方式会在本地新建分支x，但是不会自动切换到该本地分支x，需要手动checkout

git fetch origin master #相当于是从远程获取最新版本到本地，不会自动merge
#从远程获取最新的版本到本地的tmp分支上 之后再进行比较合并
git fetch origin master #首先从远程的origin的master主分支下载最新的版本
git log -p master..origin/master # 然后比较本地的master分支和origin/master分支的差别
git merge origin/master #最后进行合并
#等价于
git fetch origin master:tmp
git diff tmp 
git merge tmp

#git pull相当于是从远程获取最新版本并merge到本地
git pull origin master #相当于git fetch 和 git merge
#列出所有远程主机
git remotegit remote -v#该主机的详细信息git remote show <主机名>#列出所有分支git branch -agit branch -r#远程更新取回本地 #所取回的更新，在本地主机上要用"远程主机名/分支名"的形式读取#origin主机的master，就要用origin/master读取git fetch <远程主机名>git fetch <远程主机名> <分支名>#取回远程主机的更新以后，可以在它的基础上，使用git checkout命令创建一个新的分支 在origin/master的基础上，创建一个新分支git checkout -b newBrach origin/master#可以使用git merge命令或者git rebase命令，在本地分支上合并远程分支。git merge origin/mastergit rebase origin/master#git pull命令的作用是，取回远程主机某个分支的更新，再与本地的指定分支合并git pull <远程主机名> <远程分支名>:<本地分支名>git pull origin next:master#指定master分支追踪origin/next分支git branch --set-upstream master origin/next本地多个密钥对连接不同远程git服务器ssh-keygen -t rsa -C "YOUR_EMAIL@YOUREMAIL.COM" -f ~/.ssh/秘钥文件名字ssh-agent bashssh-add -lssh-add ~/.ssh/id_rsa
ssh-add ~/.ssh/id_rsa.yxfssh-add -l配置 ~/.ssh/config 文件
# Default github user(first@mail.com)
 
Host github.com
HostName github.com
User git
IdentityFile C:/Users/username/.ssh/id_rsa
 
# aysee (company_email@mail.com)
Host github-aysee
HostName github.com
User git
IdentityFile C:/Users/username/.ssh/aysee~/.ssh/config配置# fanghui
Host github.com
	HostName github.com
	User git
	IdentityFile ~/.ssh/id_rsa_new添加 id_rsa_new.pub 到你的git服务器网站上。测试ssh -T git@gitcafe.comnms@123.207.141.237:/opt/gitbase/nms.git 