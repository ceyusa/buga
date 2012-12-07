#!/bin/sh

git checkout -b test

./scripts/blogit list 1

testfile=$(date +%Y%m%d)
testfile="${testfile}.rst"

cat <<EOF > $testfile
Lorem ipsum
###########

Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod
tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam,
quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo
consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse
cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non
proident, sunt in culpa qui officia deserunt mollit anim id est laborum.

Lorem ipsum dolor sit amet, consectetuer adipiscing elit, sed diam nonummy
nibh euismod tincidunt ut laoreet dolore magna aliquam erat volutpat. Ut wisi
enim ad minim veniam, quis nostrud exerci tation ullamcorper suscipit lobortis
nisl ut aliquip ex ea commodo consequat. Duis autem vel eum iriure dolor in
hendrerit in vulputate velit esse molestie consequat, vel illum dolore eu
feugiat nulla facilisis at vero eros et accumsan et iusto odio dignissim qui
blandit praesent luptatum zzril delenit augue duis dolore te feugait nulla
facilisi. Nam liber tempor cum soluta nobis eleifend option congue nihil
imperdiet doming id quod mazim placerat facer possim assum. Typi non habent
claritatem insitam; est usus legentis in iis qui facit eorum
claritatem. Investigationes demonstraverunt lectores legere me lius quod ii
legunt saepius. Claritas est etiam processus dynamicus, qui sequitur
mutationem consuetudium lectorum. Mirum est notare quam littera gothica, quam
nunc putamus parum claram, anteposuerit litterarum formas humanitatis per
seacula quarta decima et quinta decima. Eodem modo typi, qui nunc nobis
videntur parum clari, fiant sollemnes in futurum.
EOF

# add new file
git add $testfile
git commit -m "lorem ipsum" || exit -1

./scripts/blogit list 1

# modify file
cat <<EOF > $testfile
Lorem ipsum
###########

Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod
tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam,
quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo
consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse
cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non
proident, sunt in culpa qui officia deserunt mollit anim id est laborum.
EOF

git add $testfile
git commit -m "update lorem ipsum" || exit -1

./scripts/blogit list 1

# remove file
git rm $testfile
git commit -m "remove lorem ipsum" || exit -1

./scripts/blogit list 1

# rollback
git checkout master
git branch -D test
