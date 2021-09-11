#!/bin/bash
# VMS

while :
do
echo -e "\n[VMS]"
echo "1. Create Account"
echo "2. Query Account"
echo "3. Rent Video"
echo "4. Return video"
echo "0. Quit"
read -p "Please Select: " num

case $num in

	1) 
	echo -e "\n[1] Create Account"
	read -p "	Name: " name
	read -p "	Phone Number: " number
	if [ ! -d ./VMSfile ]; then
		mkdir ./VMSfile
	fi
	touch ./VMSfile/$name
	echo "$number" > ./VMSfile/$name 
	read -p "Press Enter" enter
	;;

	2) 
	echo -e "\n[2] Query Account"
	read -p "Enter Name: " name
	echo -e "\n	Videos Rented"
	echo "	====================="
	for (( n=2; n<=$(cat ./VMSfile/$name | wc -l); n++))
	do
		echo "	$((n-1)).$(sed -n "$n,1p" ./VMSfile/$name)"
	done

	echo "	====================="
	read -p "Press Enter" enter
	;;
		
	3) 
	echo -e "\n[3] Rent Video"
	read -p "Enter Name: " name
	echo "	Videos Availiable"
	echo "	====================="
	readarray list < ./VMSfile/videos
	n=1
	for line in "${list[@]}";
	do
		echo "	$n. $line"
		((n++))
	done 	
	echo "	====================="	
	read -p "Please Select Number: " num2

	echo "$(head -n $num2 ./VMSfile/videos |tail -1)		$(date +%m/%d)" >> ./VMSfile/$name
	echo "$(head -n $num2 ./VMSfile/videos |tail -1) is rented now"
	sed -i "$num2,1d" ./VMSfile/videos

	read -p "Press Enter" enter
	;;

	4) 
	echo -e "\n[4] Return Video"
	read -p "Enter Name: " name
	echo "	Videos Rented" 
	echo -e "\n	====================="
	for (( n=2; n<=$(cat ./VMSfile/$name | wc -l); n++))
	do
		echo "	$((n-1)).$(sed -n "$n,1p" ./VMSfile/$name)"
	done
		echo "	====================="
	read -p "Please Select Number: " num2
	echo "$(sed -n "$((num2+1)),1p" ./VMSfile/$name)" >> ./VMSfile/videos  
	echo "$(tr -d "${tab}'[0-9]*'/'[0-9]*'" <./VMSfile/videos)" > ./VMSfile/videos
	echo "$(tr -d '\t' <./VMSfile/videos)" > ./VMSfile/videos
	echo "$(tail -1 ./VMSfile/videos) is returned"
	sed -i "$((num2+1)),1d" ./VMSfile/$name
	read -p "Press Enter" enter
	;;
	0) break;;
esac
done
