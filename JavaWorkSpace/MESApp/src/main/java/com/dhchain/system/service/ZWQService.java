package com.dhchain.system.service;

import com.dhchain.system.entity.OutputValue;
import com.dhchain.system.entity.ZWQ;

import java.util.List;

public interface ZWQService extends IService<ZWQ> {
    List<ZWQ> getZWQValue(String year, String month, String nwx);

}
