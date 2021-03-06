/*
 * The MIT License (MIT)
 *
 * Copyright (c) 2014 abel533@gmail.com
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 */

package com.dhchain.business.partpunchingworkshop.service.Impl;

import com.dhchain.business.partpunchingworkshop.service.IService;
import com.dhchain.util.MyMapper;
import org.springframework.beans.factory.annotation.Autowired;
import tk.mybatis.mapper.common.Mapper;

import java.util.List;

/**
 * Created by liuzh on 2014/12/11.
 */
public abstract class BaseService<T> implements IService<T> {

    @Autowired
    protected MyMapper<T> myMapper;

    public Mapper<T> getMapper() {
        return myMapper;
    }

    @Override
    public T selectByKey(Object key) {
        return myMapper.selectByPrimaryKey(key);
    }

    public int save(T entity) {
        return myMapper.insert(entity);
    }

    public int delete(Object key) {
        return myMapper.deleteByPrimaryKey(key);
    }

    public int updateAll(T entity) {
        return myMapper.updateByPrimaryKey(entity);
    }

    public int updateNotNull(T entity) {
        return myMapper.updateByPrimaryKeySelective(entity);
    }

    public List<T> selectByExample(Object example) {

        return myMapper.selectByExample(example);
    }
    public List<T> selectAll() {
        return myMapper.selectAll();
    }
    public List<T> select(T t) {
        return myMapper.select(t);
    }

    public T selectOne(T t) {
        return myMapper.selectOne(t);
    }

    public int selectCount(T t) {
        return myMapper.selectCount(t);
    }

    public int InsertUseGeneratedKeysMapper(T entity){
        return myMapper.insertUseGeneratedKeys(entity);
    }

    public int deleteByExample(T entity){
        return myMapper.deleteByExample(entity);
    }
    //TODO 其他...
}