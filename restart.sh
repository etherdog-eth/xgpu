echo "正在停止挖矿程序"
ps aux|grep miner|grep -v grep | awk '{print $2}'|xargs kill -9

echo "正在启动挖矿程序"
sudo nohup python3 miner.py --gpu=true > miner.log 2>&1 &

count=`nvidia-smi | grep NVIDIA | grep -v NVIDIA-SMI -c`

echo "GPU count:$count"

for ((i=0; i< $count; i++))
do
    cmd="sudo nohup ./xengpuminer -d$i > xengpuminer-$i.log 2>&1 &"
    echo cmd
    ${cmd}
done
