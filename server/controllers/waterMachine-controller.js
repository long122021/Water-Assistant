// get water machine of application

exports.getWaterMachine = async (req, res) => {
    console.log('In controller - getWaterMachine');
    //取设备数据
    let machineArr = await getMachineList();
    if (machineArr.length>0){
        for (var i = 0; i < machineArr.length; i++){
            var mac = machineArr[i];
            let waterData = await getWaterInfo(mac.watermachineId, mac.waterId);
            mac.waterData = waterData;
        }
    }
    res.json(machineArr);
};

let getMachineList = () =>{
    return new Promise(function (resolve, reject){
        let objectArray = [];
        db.find({
            selector: {
                "datatype": "waterMachine"
            }
        }, function (err,body) {
            if (err) {
                reject(err);
            } else {
                resolve(body.docs);
            }
        });
    });
}

let getWaterInfo = (watermachineId ,waterId) =>{
    return new Promise(function (resolve, reject){
        db.find({
            selector: {
                "datatype": "waterInfo",
                "_id": waterId,
                "watermachineId": watermachineId
            }
        }, function (err,body) {
            if (err) {
                reject(err);
            } else {
                if (body.docs.length>0){
                    resolve(body.docs[0]);
                }
            }
        });
    });
}

//保存设备信息
exports.saveWaterMachine = (req, res) => {
    console.log('In controller - saveWaterMachine');
    var param = req.body;

    if (!param.watermachineId || param.watermachineId.length<=0){
        return;
    }
    db.insert({ datatype: 'waterMachine',
        watermachineId: param.watermachineId, name: param.name,
        longitude:param.longitude,latitude:param.latitude}, (err, data) => {
        if (err) {
            res.json(err);
        } else {
            res.json(data._id);
        }
    });
};
