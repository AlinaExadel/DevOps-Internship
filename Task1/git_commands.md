#2
pwd
mkdir Exadel_Tasks
ls
cd Exadel_Tasks/
git clone https://github.com/AlinaExadel/Task1.git
cd Task1/
mkdir Task1
cd Task1/
touch README.md
git add .
git commit -m"Add README.md file"
git push origin master

#3
git branch dev
git checkout dev
touch test.txt
git status
git commit -m"test.txt file"
git push origin dev

#4,5,6,7,8
git checkout -b alina-new_feature
vi README.md
git status
touch .gitignore
vi .gitignore
git add . 
git commit -m"Add .gitignore and README.md files"
git push origin alina-new_feature

#9,10 
Done using github web interface

#11,12
vi README.md
git add .
git commit -m"Change README.md content"
git reset --soft HEAD~1
git log --oneline --decorate > log.txt
git add .
git commit -m"Add log.txt file"
git push origin alina-new_feature
git checkout master
git pull
git merge alina-new_feature
git push origin master

#13
git branch -d alina-new_feature
git push origin --delete alina-new_feature

#14
git checkout dev
touch git_commands.md
vi git_commands.md
git add . 
git commit -m"Add git_commands.md file"
git push origin dev
