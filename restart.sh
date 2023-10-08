echo "正在停止挖矿程序"
ps aux|grep miner|grep -v grep | awk '{print $2}'|xargs kill -9
echo "正在启动挖矿程序"

cd /root/XENGPUMiner

sudo nohup python3 miner.py --gpu=true > miner.log 2>&1 &

#count=`nvidia-smi | grep NVIDIA | grep -v NVIDIA-SMI -c | awk '{print $1}'`
#echo "GPU count:$count"

for k in $(nvidia-smi | grep NVIDIA | grep -v NVIDIA-SMI -c | awk '{print $1}')
do
    cmd="sudo nohup ./xengpuminer -d$k > xengpuminer-$k.log 2>&1 &"
    echo cmd
    ${cmd}
done
