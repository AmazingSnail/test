package com.dhchain.system.service;

import com.dhchain.system.entity.OutputValue;
import com.dhchain.system.entity.User;

import java.util.List;

public interface OutputValueService extends IService<OutputValue> {
    List<OutputValue> getOutputValue(String year, String month, String nwx);
    List<OutputValue> getOutputValueDay(String year, String month, String nwx);
}
