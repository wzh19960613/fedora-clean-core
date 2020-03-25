echo -e "\n"
text=`rpm -aq|grep ^kernel-`
list="core devel headers"
for str in $list; do
	items=`echo "$text"|grep ^kernel-$str-|sed 's/-/ - /g'|sed 's/\./ /g'|sort -k5n -k6n -k7n -k9n|sed 's/ - /-/g'|sed 's/ /\./g'`
	echo "当前最新 $str：`echo "$items"|tail -n 1`"
	items=`echo "$items"|sed '$d'`
	cnum=`echo "$items"|wc -c`
	lnum=`echo "$items"|wc -l`
	if [ $cnum -lt 2 ];then
		echo "没有多余 $str。"
	else
		echo "存在多余 $str，共 $lnum 个:"
		echo "-------------------------------------"
		echo "$items"
		echo "-------------------------------------"
		dnf remove $items
	fi
	echo -e "\n"
done
