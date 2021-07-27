// get water machine of application

//获取预测数据
exports.getWaterInfoDetail = async (req, res) => {
    var param = req.body;
    var attArr = await getDetail(param.waterId);
    res.json(attArr);
};

let getDetail = (waterId) =>{
    return new Promise(function (resolve, reject){
        db.find({
            selector: {
                "datatype": "waterPrediction",
                "waterId": waterId
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


//保存预测数据
exports.saveWaterInfoDetail = async (req, res) => {
    var param = req.body;
    var id = await saveDetail(param);
    res.json(id);
};

let saveDetail = (param) =>{
    return new Promise(function (resolve, reject){
        param.datatype = 'waterPrediction';
        db.insert(param,function(error, doc) {
            if(error) {
                reject(error);
            }else{
                resolve(doc.id);
            }
        });
    });
}