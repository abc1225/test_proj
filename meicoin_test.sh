#!/bin/bash

# set user cookie
# like "Cookie:__cfduid=da6ba3394d54065b93f0e2362a5b5b5d51529456825; PHPSESSID=h4ha4qecupp8ur4pb2tgnoju30; landlan=1; _hjIncludedInSample=1; PHPSESSID=nhj0t7p4ajv92qok9qkukdtbl0; landlan=1; total=; _hjIncludedInSample=1; _ga=GA1.2.1156639940.1529735184; think_language=zh-CN; userName=15555564455; cookie_username=15555564455; SERVERID=dbd8bb77eb20c19d024afc02e389695a|1530326687|1530266762"
USER_COOKIE="Cookie:__cfduid=da6ba3394d54065b93f0e2362a5b5b5d51529456825; PHPSESSID=h4ha4qecupp8ur4pb2tgnoju30; landlan=1; _hjIncludedInSample=1; PHPSESSID=nhj0t7p4ajv92qok9qkukdtbl0; landlan=1; total=; _hjIncludedInSample=1; _ga=GA1.2.1156639940.1529735184; _gid=GA1.2.398307308.1530343878; think_language=zh-CN; userName=15555564455; cookie_username=15555564455; SERVERID=41bab0e45c36f679c90e7de7f1e53f3e|1530351765|1530266762"

# /www/server/apache/bin/ab  ab
AB_PATH=ab

MAIN_URL="http://www.meicoin.pro/"
TRADE_URL="http://www.meicoin.pro/Trade/index/market/mc_eth.html"

API1_URL="http://www.meicoin.pro/Home/Ajax/kline?market=mc_eth"
API2_URL="http://www.meicoin.pro/Ajax/getDepth?market=mc_eth&jjcoin=btc&trade_moshi=1&t=0.5430994790632493"
API3_URL="http://www.meicoin.pro/Ajax/getJsonTop?market=mc_eth&t=0.7273979342648424"

API4_URL="http://www.meicoin.pro/Ajax/getTradelog?market=mc_eth&jjcoin=btc&t=0.5559218781360911"
API5_URL="http://www.meicoin.pro/Ajax/getEntrustAndUsercoin?market=mc_eth&jjcoin=btc&t=0.9793548639787244"
API6_URL="http://www.meicoin.pro/Ajax/getEntrustHistory?market=mc_eth"

HELLO_URL="http://www.meicoin.pro/login/helloworld"



# main trade api1 api2 api3 api4 api5 api6
api=( 'main' 'trade' 'api1' 'api2' 'api3' 'api4' 'api5' 'api6' 'hello' )

# Default configuration
A=main
C=200
N=2000

# tmp flag
flag=0

while getopts ":c:n:a:" opt
do
    case $opt in
        c)
#        echo "参数c的值$OPTARG"
        if [ $OPTARG -gt 0 ];then
            C=$OPTARG
        fi
        ;;
        n)
#        echo "参数n的值$OPTARG"
        if [ $OPTARG -gt 0 ];then
            N=$OPTARG
        fi
        ;;
        a)
#        echo "参数a的值$OPTARG"
        for i in ${api[@]}
        do
            if [ "$i" = "$OPTARG" ];then
                flag=1
                A=$OPTARG
            fi
        done
	if [ $flag == 0 ];then
            echo "不支持的API选项，请输入正确的API参数 -a main | trade | api1 | api2 | api3 | api4 | api5 | api6 | hello"
            exit
        fi
        ;;
    esac
done
#echo "参数c的值$C"
#echo "参数n的值$N"
#echo "参数a的值$A"
echo -e "\n\nExcuting $A test:  \n"
case $A in
    main)
     echo -e "Test URL is: \n$MAIN_URL \n"
     $AB_PATH -r -c $C -n $N  $MAIN_URL
    ;;
    trade)
     echo -e "Test URL is: \n$TRADE_URL \n Test Cookie is: \n$USER_COOKIE\n\n"
    $AB_PATH -r -c $C -n $N -H "$USER_COOKIE"  $TRADE_URL
    ;;
    api1)
     echo -e "Test URL is: \n$API1_URL \n Test Cookie is: \n$USER_COOKIE\n\n"
    $AB_PATH -r -c $C -n $N -H "$USER_COOKIE"  $API1_URL
    ;;
    api2)
     echo -e "Test URL is: \n$API2_URL \n Test Cookie is: \n$USER_COOKIE\n\n"
    $AB_PATH -r -c $C -n $N -H "$USER_COOKIE"  $API2_URL
    ;;
    api3)
     echo -e "Test URL is: \n$API3_URL \n Test Cookie is: \n$USER_COOKIE\n\n"
    $AB_PATH -r -c $C -n $N -H "$USER_COOKIE"  $API3_URL
    ;;
    api4)
     echo -e "Test URL is: \n$API4_URL \n Test Cookie is: \n$USER_COOKIE\n\n"
    $AB_PATH -r -c $C -n $N -H "$USER_COOKIE"  $API4_URL
    ;;
    api5)
     echo -e "Test URL is: \n$API5_URL \n Test Cookie is: \n$USER_COOKIE\n\n"
    $AB_PATH -r -c $C -n $N -H "$USER_COOKIE"  $API5_URL
    ;;
    api6)
     echo -e "Test URL is: \n$API6_URL \n Test Cookie is: \n$USER_COOKIE\n\n"
    $AB_PATH -r -c $C -n $N -H "$USER_COOKIE"  $API6_URL
    ;;
    hello)
     echo -e "Test URL is: \n$HELLO_URL \n"
     $AB_PATH -r -c $C -n $N  $HELLO_URL
    ;;
esac



