$Contents=Import-Csv vm-list.csv  #将CSV文件中内容导入，,赋值给变量为了利用数组进行逐个读取;
#源克隆的虚拟机
$SrcVM="F:\VMS-DS\Windows7x64.vmx" 
#snapshot名称
$SrcVMSnapshotName="VMSNAP" 
#虚拟机存放目录
$DesPath="F:\VMS-DS-DESS"
#用for 循环，逐个读取，CSV和EXCEL 类似，我们取对应的Server，Username，Password 三个栏位的值.
vmrun -T ws snapshot $SrcVM $SrcVMSnapshotName

for ($i=0;$i -le $Contents.Length;$i++){
    Write-Host "VM $i CREATE START--------------------------------"
    $IP=$Contents.IP[$i]
    $VMNAME=$Contents.vmname[$i]
    $PROXYIP=$Contents.proxyip[$i]
    $PWD=$Contents.adminpassword[$i]
    #$SrcVMSnapshotName="VM11"
    #Write-Host "The $i line IP is $IP"
    #Write-Host "The $i line Vmname is $VMNAME"
    #Write-Host "The $i line ProxyIp is $PROXYIP"
    #Write-Host "The $i line Password is $PWD"

    #REM 创建克隆链接的虚拟
    #vmrun.exe -T ws clone $SrcVM $DesPath\$VMNAME\$VMNAME.vmx full -cloneName=$VMNAME

    Write-Host $SrcVM
    write-host $SrcVMSnapshotName
    write-host $SrcVM
    write-host $DesPath\$VMNAME\$VMNAME.vmx 
    vmrun.exe -T esx clone "$SrcVM" "$DesPath\$VMNAME\$VMNAME.vmx" full -snapshot="$SrcVMSnapshotName" -cloneName="$VMNAME"

    #Write-Host "vmrun.exe -T ws clone $SrcVM $DesPath\$VMNAME\$VMNAME.vmx full -snapshot=${SrcVMSnapshotName} -cloneName=$VMNAME"
    vmrun.exe -T ws start "$DesPath\$VMNAME\$VMNAME.vmx"
    Write-Host "VM $i CREATE END--------------------------------"
}



