while true
do
    for x in {1..100}; do (python query.py < question.txt > /tmp/$x.log) & done
    wait
    sleep 10
done
