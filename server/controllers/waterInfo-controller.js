// get water machine of application

exports.getWaterInfo = (req, res) => {

};

//保存水质信息
exports.saveWaterInfo = async (req, res)=>{
    var param = req.body;
    var waterId = await saveWater(param);
    // saveWaterAttribute(req, waterId);
    var status = updateMachine(param.watermachineId, waterId);
    res.json(status);
};

//获取水质级别
let getType = (arrV, value, isMax) =>{
    var type = 1;
    for (var i = 0; i < arrV.length; i++){
        if (isMax){
            if (value >= arrV[i]){
                type = i+1;
                break;
            }
        }else {
            if (value <= arrV[i]){
                type = i+1;
                break;
            }
        }
    }
    return type;
}

let saveWater = (req) => {
    //根据attribute算出type
    var type = 1;
    var arrV = [];
    var isMax = false;
    for (var i = 0; i < req.waterAttributes.length; i++){
    // req.waterAttributes.forEach(function(document){
        var document = req.waterAttributes[i];
        var value = document.value;
        isMax = false;
        if (document.name === 'DissolvedOxygen'){
//>=7.5\6\5\3\2
            arrV = [7.5,6,5,3,2];
            isMax = true;
        }else if (document.name === 'Permanganate'){
//<=2\4\6\10\15
            arrV = [2,4,6,10,15];
        }else if (document.name === 'Ammonia'){
//<=0.15\0.5\1.0\1.5\2.0
            arrV = [0.15,0.5,1.0,1.5,2.0];
        }else if (document.name === 'Phosphorus'){
//<=0.02\0.1\0.2\0.3\0.4
            arrV = [0.02,0.1,0.2,0.3,0.4];
        }else if (document.name === 'Nitrogen'){
//<=0.2\0.5\1.0\1.5\2.0
            arrV = [0.2,0.5,1.0,1.5,2.0];
        }
        type = Math.max(type, getType(arrV, value, isMax));
    // });
    }
    //得出推荐的描述
    var desc = '';
    switch (type){
        case 1:
            desc = '水质级别是1，很好，可用于农业、生活，简单消毒后即可饮用';
            break;
        case 2:
            desc = '水质级别是2，很好，可用于农业、生活，简单过滤、消毒后即可饮用';
            break;
        case 3:
            desc = '水质级别是3，较好，可用于农业、生活，过滤和消毒后可饮用.主要适用于集中式生活饮用水地表水源地二级保护区、鱼虾类越冬场、洄游通道、水产养殖区等渔业水域及游泳区';
            break;
        case 4:
            desc = '水质级别是4，一般，可以用于农业、工业，不能用于生活，不可饮用';
            break;
        case 5:
            desc = '水质级别是5，较差，一般可以农业灌溉使用，不能用于生活，不可饮用';
            break;
        case 6:
            desc = '水质级别是6，非常差，未经处理不能使用';
            break;
        default:
            desc = '没监测到水质';
            break;
    }
    if (req.depth <= 1){
        desc += '水位线很低，接近干涸，需要近况储存水';
    }else if(req.depth <= 3){
        desc += '水位线较低，有干涸的风险，请多留意';
    }

    return new Promise(function (resolve, reject) {
        db.insert({"datatype":"waterInfo","watermachineId":req.watermachineId,
                            "type":type,"depth":req.depth,
                            "desc":desc,"waterAttributes":req.waterAttributes}, (err, data) => {
          if (err) {
            reject(err);
          } else {
            resolve(data.id); // { ok: true, id: 'rabbit', ...
          }
        });
    });
}

//更新监测点最新水质ID
let updateMachine = (machineId, waterId) =>{
    return new Promise(function (resolve, reject){
        db.find({
            selector: {
                "datatype": "waterMachine",
                "watermachineId": machineId
            }
        }, function (err,body) {
            if (err) {
                reject(err);
            } else {
                let document;
                if (body.docs.length>0){
                    document = body.docs[0];
                }
                if (document){
                    document.waterId = waterId;
                    db.insert(document,function(error, doc) {
                        if(error) {
                            reject(error);
                        }else{
                            resolve(doc.id);
                        }
                    });
                }
            }
        });
    });
}
