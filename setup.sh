git remote add origin https://github.com/Smart-Enroll/Smart-Enroll.git
git branch -M main

git pull origin main

git push -u origin main

# Set up .gitignore to avoid committing unnecessary files
echo ".DS_Store
/log
/tmp
/db/*.sqlite3
/db/*.sqlite3-journal
/public/system
/node_modules
/yarn-error.log" > .gitignore
git add .gitignore
git commit -m "Update .gitignore"
git push
