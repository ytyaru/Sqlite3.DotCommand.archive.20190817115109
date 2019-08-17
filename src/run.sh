SCRIPT_DIR=$(cd $(dirname $0); pwd)
cd "$SCRIPT_DIR"

echo -e "aaa\nAAA" > A.txt
echo -e "bbb\nBBB" > B.txt
mkdir -p ./D/DD
echo -e "ddd\nDDD" > ./D/DD/DDD.txt

# アーカイブ作成
sqlite3 texts ".archive -c A.txt B.txt D/"
ls -1 | grep texts

# 一覧
sqlite3 texts ".archive -t"
sqlite3 texts ".archive -tv"

rm -rf A.txt B.txt D/
sqlite3 texts ".archive -x"
find .
cat A.txt
cat B.txt
cat D/DD/DDD.txt

sqlite3 texts ".tables"
sqlite3 texts ".headers on" "select * from sqlar;"

# ファイル挿入
echo -e "ccc\nCCC" > C.txt
sqlite3 texts ".archive -i C.txt"
sqlite3 texts ".archive -t"

# 更新
sqlite3 texts "select * from sqlar;"
# ファイル修正
echo "ばばば" >> B.txt
sed -ie '1d' B.txt
cat B.txt
# ワイルドカード指定するとエラー
sqlite3 texts ".archive -u *.txt"
# パスなしだと何も変化せず
sqlite3 texts ".archive -u"
# パス固定指定で更新された
sqlite3 texts ".archive -u B.txt"

