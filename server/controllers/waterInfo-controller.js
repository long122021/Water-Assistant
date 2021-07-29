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
            desc = 'Mainly suitable for source water and national nature reserves; the best water source can be used for life, agriculture, household drinking, etc.';
            break;
        case 2:
            desc = 'It is mainly suitable for the first-level protection area of the surface water source of the centralized drinking water, the habitat of rare aquatic organisms, the fish and shrimp production field, the feeding ground of the larvae, juveniles, etc.; the water quality is very good, and it can be used for domestic, agricultural, and household drinking, etc.The current water level is low and there is a risk of drying up, please pay attention.';
            break;
        case 3:
            desc = 'It is mainly suitable for centralized domestic and drinking water surface water source areas, secondary protection areas, fish and shrimp overwintering grounds, migration channels, aquaculture areas and other fishery waters and swimming areas; the water quality is good and can be used for life, agriculture, etc., household drinking needs to be purified disinfect.';
            break;
        case 4:
            desc = 'Mainly suitable for general industrial water areas and recreational water areas where the human body is not in direct contact; the water quality is average, can be used in industry, agriculture, etc., not suitable for household drinking.';
            break;
        case 5:
            desc = 'Mainly suitable for agricultural water areas and water areas with general landscape requirements; the water quality is poor and can be used for agriculture but not for household drinking.';
            break;
        case 6:
            desc = 'The pollution is serious and the water quality is very poor. It cannot be used directly. If it needs to be used, it must be treated with strict filtration and purification.The current water level is low and there is a risk of drying up, please pay attention.';
            break;
        default:
            desc = 'No Data.';
            break;
    }
    if (req.depth <= 1){
        desc += 'The water level is very low, it is almost dry, and the water needs to be stored as soon as possible.';
    }else if(req.depth <= 3){
        desc += 'The water level is low, there is a risk of drying up, please pay attention.';
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
