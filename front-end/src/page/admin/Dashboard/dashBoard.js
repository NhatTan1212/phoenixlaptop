import React, { useEffect, useState } from 'react';
import { Line } from 'react-chartjs-2';
import { Card, Col, Divider, Row, Select } from 'antd';
import { UpOutlined, MoneyCollectOutlined, ShoppingOutlined, UserAddOutlined } from '@ant-design/icons';

const Dashboard = () => {
    const optionsSelectDay = [
        { value: '7days', label: '7 ngày gần nhất' },
        { value: '30days', label: '30 ngày gần nhất' },
        { value: '60days', label: '60 ngày gần nhất' },
        { value: '90days', label: '90 ngày gần nhất' },
    ]
    const handleChange = (value) => {
        console.log(`selected ${value}`);
    };
    return (
        <div className="dashboard-container flex-1 mt-1 mx-3">
            <Row gutter={16}>
                <Col span={8}>
                    <Card
                        className='border-b-[4px] border-[#ce1b1b]'
                        title={
                            <Row>
                                <Col span={12} className='align-middle flex my-auto'>
                                    <h1>Tổng doanh thu</h1>
                                </Col>
                                <Col span={12}
                                    className='text-end'>
                                    <Select
                                        className=''
                                        defaultValue="7 ngày gần nhất"
                                        onChange={handleChange}
                                        options={optionsSelectDay}
                                    />
                                </Col>
                            </Row>
                        } bordered={false}>
                        <div className='flex justify-between'>
                            <div className='flex'>
                                <MoneyCollectOutlined className='text-[40px]  my-auto' />
                                <span className='text-[34px]'>12.204.000</span>
                            </div>
                            <div className='flex '>
                                <UpOutlined className='text-green-400 text-[17px] my-auto pt mr-2' />
                                <span className='text-[17px] my-auto'>7%</span>
                            </div>

                        </div>
                    </Card>
                </Col>
                <Col span={8}>
                    <Card
                        className='border-b-[4px] border-[#ce1b1b]'
                        title={
                            <Row>
                                <Col span={12} className='align-middle flex my-auto'>
                                    <h1>Đơn hàng mới</h1>
                                </Col>
                                <Col span={12}
                                    className='text-end'>
                                    <Select
                                        className=''
                                        defaultValue="7 ngày gần nhất"
                                        onChange={handleChange}
                                        options={optionsSelectDay}
                                    />
                                </Col>
                            </Row>
                        } bordered={false}>
                        <div className='flex justify-between'>
                            <div className='flex'>
                                <ShoppingOutlined className='text-[40px]  my-auto' />
                                <span className='text-[34px]'>264</span>
                            </div>
                            <div className='flex '>
                                <UpOutlined className='text-green-400 text-[17px] my-auto pt mr-2' />
                                <span className='text-[17px] my-auto'>10%</span>
                            </div>

                        </div>
                    </Card>
                </Col>
                <Col span={8}>
                    <Card
                        className='border-b-[4px] border-[#ce1b1b]'
                        title={
                            <Row>
                                <Col span={12} className='align-middle flex my-auto'>
                                    <h1>Khách hàng mới</h1>
                                </Col>
                                <Col span={12}
                                    className='text-end'>
                                    <Select
                                        className=''
                                        defaultValue="7 ngày gần nhất"
                                        onChange={handleChange}
                                        options={optionsSelectDay}
                                    />
                                </Col>
                            </Row>
                        } bordered={false}>
                        <div className='flex justify-between'>
                            <div className='flex'>
                                <UserAddOutlined className='text-[40px]  my-auto' />
                                <span className='text-[34px]'>364</span>
                            </div>
                            <div className='flex '>
                                <UpOutlined className='text-green-400 text-[17px] my-auto pt mr-2' />
                                <span className='text-[17px] my-auto'>20%</span>
                            </div>

                        </div>
                    </Card>
                </Col>
            </Row>
        </div>
    );
};

export default Dashboard;
