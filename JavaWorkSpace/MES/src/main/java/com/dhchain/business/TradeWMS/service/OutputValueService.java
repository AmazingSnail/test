package com.dhchain.business.TradeWMS.service;

import com.dhchain.business.TradeWMS.vo.TOutputvalue;
import com.dhchain.business.base.service.IService;

import java.util.List;

public interface OutputValueService extends IService<TOutputvalue> {
    List<TOutputvalue> getOutputValue(String year, String month, String nwx);
    List<TOutputvalue> getOutputValueDay(String year, String month, String nwx);
}
