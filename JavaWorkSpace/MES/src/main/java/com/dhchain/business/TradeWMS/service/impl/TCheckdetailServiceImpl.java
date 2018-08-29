package com.dhchain.business.TradeWMS.service.impl;

import com.dhchain.business.TradeWMS.service.TCheckdetailService;
import com.dhchain.business.TradeWMS.vo.TCheckdetail;
import com.dhchain.business.base.service.impl.BaseService;
import org.springframework.stereotype.Service;

/**
 * Created by zhenglb on 2018-04-02.
 */
@Service("tCheckdetailService")
public class TCheckdetailServiceImpl extends BaseService<TCheckdetail> implements TCheckdetailService {
    @Override
    public boolean distribute(String packhalfid, String ids) {
        TCheckdetail tCheckdetail = new TCheckdetail();
        tCheckdetail.setPackhalfid(packhalfid);
        delete(tCheckdetail);
        if(!ids.equals("")){
            String[] idArr = ids.split(",");
            for (String id:idArr){
                TCheckdetail tCheckdetail1  = new TCheckdetail();
                tCheckdetail1.setPackhalfid(packhalfid);
                tCheckdetail1.setQmid(Integer.parseInt(id));
                InsertUseGeneratedKeysMapper(tCheckdetail1);
            }

        }

        return true;
    }
}
