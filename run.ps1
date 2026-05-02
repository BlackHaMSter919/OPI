if (Test-Path .git) { Remove-Item -Recurse -Force .git }
Remove-Item *.java -ErrorAction SilentlyContinue

git init
git config user.name "red"
git config user.email "red@example.com"

$sec = 10

function Quick-Commit($msg, $author="red <red@example.com>") {
    $global:sec++
    $env:GIT_AUTHOR_DATE = "2026-05-02T14:00:$($global:sec)"
    $env:GIT_COMMITTER_DATE = "2026-05-02T14:00:$($global:sec)"
    git commit --allow-empty --author=$author -m $msg
}

Write-Output "# Lab 2" >> README.md; git add .
Quick-Commit "initial commit"
Write-Output "*.ps1`n*.zip" >> .gitignore; git add .
Quick-Commit "add .gitignore"

tar -xf commit0.zip; git add .; Quick-Commit "r0 (red)"
tar -xf commit1.zip; git add .; Quick-Commit "r1 (red)"

git checkout -b branch2
tar -xf commit2.zip; git add .; Quick-Commit "r2 (blue)" "blue <blue@example.com>"

git checkout -b branch3
tar -xf commit3.zip; git add .; Quick-Commit "r3 (blue)" "blue <blue@example.com>"
tar -xf commit4.zip; git add .; Quick-Commit "r4 (blue)" "blue <blue@example.com>"

git checkout branch2
tar -xf commit5.zip; git add .; Quick-Commit "r5 (blue)" "blue <blue@example.com>"

git checkout branch3
tar -xf commit6.zip; git add .; Quick-Commit "r6 (blue)" "blue <blue@example.com>"
tar -xf commit7.zip; git add .; Quick-Commit "r7 (blue)" "blue <blue@example.com>"
tar -xf commit8.zip; git add .; Quick-Commit "r8 (blue)" "blue <blue@example.com>"

git checkout master
tar -xf commit9.zip; git add .; Quick-Commit "r9 (red)"

git checkout branch2
tar -xf commit10.zip; git add .; Quick-Commit "r10 (blue)" "blue <blue@example.com>"
tar -xf commit11.zip; git add .; Quick-Commit "r11 (blue)" "blue <blue@example.com>"
tar -xf commit12.zip; git add .; Quick-Commit "r12 (blue)" "blue <blue@example.com>"

git merge branch3 --no-commit -X theirs
tar -xf commit13.zip; git add .; Quick-Commit "r13 (blue)" "blue <blue@example.com>"

git checkout master
git merge branch2 --no-commit -X ours
tar -xf commit14.zip; git add .; Quick-Commit "r14 (red)"

git log --graph --all --oneline --date-order