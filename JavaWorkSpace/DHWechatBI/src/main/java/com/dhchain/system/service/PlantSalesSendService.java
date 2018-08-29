package com.dhchain.system.service;

import com.dhchain.system.entity.User;

import java.util.List;

/**
 * Created by ANT on 2018/5/30.
 */
public interface PlantSalesSendService extends IService<User>{

    List<User> getlist1(String year, String month, String nwx);

    List<User> getlistDay1(String year, String month, String day, String nwx);

    List<User> getlistYear1(String year, String nwx);
}
