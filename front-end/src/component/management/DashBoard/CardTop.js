import React, { useContext, useEffect, useState } from 'react';
import { Card, Col, Row, Select, DatePicker } from 'antd';
import { UpOutlined, MoneyCollectOutlined, ShoppingOutlined, UserAddOutlined, DownOutlined } from '@ant-design/icons';

import dayjs from 'dayjs';
import { GetNewOrderByDays, GetNewUserByDays, GetOrderSuccessByDays } from '../../../callAPI/management/apiDashBoard';
const { RangePicker } = DatePicker;

const CardTop = ({ cardInfo }) => {
    const [isDateChanged, setIsDateChanged] = useState(false)

    const [startDate, setStartDate] = useState(dayjs().add(-7, 'd').toISOString().slice(0, 10))
    const [endDate, setEndDate] = useState(dayjs().toISOString().slice(0, 10))
    const [totalOrder, setTotalOrder] = useState('')
    const [percentTotalOrder, setPercentTotalOrder] = useState('')

    const [startDateNewOrder, setStartDateNewOrder] = useState(dayjs().add(-7, 'd').toISOString().slice(0, 10))
    const [endDateNewOrder, setEndDateNewOrder] = useState(dayjs().toISOString().slice(0, 10))
    const [newOrder, setNewOrder] = useState('')
    const [percentNewOrder, setPercentNewOrder] = useState('')

    const [startDateNewUser, setStartDateNewUser] = useState(dayjs().add(-7, 'd').toISOString().slice(0, 10))
    const [endDateNewUser, setEndDateNewUser] = useState(dayjs().toISOString().slice(0, 10))
    const [newUser, setNewUser] = useState('')
    const [percentNewUser, setPercentNewUser] = useState('')

    const onRangeChange = (dates, dateStrings) => {
        if (dates) {
            console.log('From: ', dates[0], ', to: ', dates[1]);
            console.log('From: ', dateStrings[0], ', to: ', dateStrings[1]);
            if (cardInfo.tittleCard === 'Tổng doanh thu') {
                setStartDate(dateStrings[0])
                setEndDate(dateStrings[1])
            }
            if (cardInfo.tittleCard === 'Đơn hàng mới') {
                setStartDateNewOrder(dateStrings[0])
                setEndDateNewOrder(dateStrings[1])
            }
            if (cardInfo.tittleCard === 'Khách hàng mới') {
                setStartDateNewUser(dateStrings[0])
                setEndDateNewUser(dateStrings[1])
            }
            setIsDateChanged(!isDateChanged)
        } else {
            console.log('Clear');
        }
    };
    const rangePresets = [
        {
            label: 'Last 7 Days',
            value: [dayjs().add(-7, 'd'), dayjs()],
        },
        {
            label: 'Last 14 Days',
            value: [dayjs().add(-14, 'd'), dayjs()],
        },
        {
            label: 'Last 30 Days',
            value: [dayjs().add(-30, 'd'), dayjs()],
        },
        {
            label: 'Last 90 Days',
            value: [dayjs().add(-90, 'd'), dayjs()],
        },
    ];

    const iconMapping = {
        'Tổng doanh thu': MoneyCollectOutlined,
        'Đơn hàng mới': ShoppingOutlined,
        'Khách hàng mới': UserAddOutlined
    };

    const iconUpDownMapping = {
        'up': UpOutlined,
        'down': DownOutlined
    }

    const IconComponent = iconMapping[cardInfo.tittleCard] || MoneyCollectOutlined;
    const IconUpDownComponent = iconUpDownMapping[
        cardInfo.tittleCard === 'Tổng doanh thu' ? percentTotalOrder > 0 ? 'up' : 'down' :
            cardInfo.tittleCard === 'Đơn hàng mới' ? percentNewOrder > 0 ? 'up' : 'down' :
                cardInfo.tittleCard === 'Khách hàng mới' ? percentNewUser > 0 ? 'up' : 'down' : 'up'
    ];

    const iconClass = cardInfo.tittleCard === 'Tổng doanh thu' ? percentTotalOrder > 0 ? 'text-green-500' : 'text-red-500' :
        cardInfo.tittleCard === 'Đơn hàng mới' ? percentNewOrder > 0 ? 'text-green-500' : 'text-red-500' :
            cardInfo.tittleCard === 'Khách hàng mới' ? percentNewUser > 0 ? 'text-green-500' : 'text-red-500' : 'text-green-500'

    const getOrderSuccessByDays = () => {
        let rangeDate = [startDate, endDate]
        GetOrderSuccessByDays(rangeDate).then((dataResult) => {
            console.log(dataResult);
            let total = dataResult.data.daysCurrent.length === 0 ? 0 : dataResult.data.daysCurrent.reduce((accumulator, currentValue) => accumulator + currentValue.total, 0);
            let totalUserBefore = dataResult.data.daysBefore.length === 0 ? 0 : dataResult.data.daysBefore.reduce((accumulator, currentValue) => accumulator + currentValue.total, 0);
            setTotalOrder(total)
            const percent = totalUserBefore === 0 ? (total !== 0 ? 100 : 0) : ((total - totalUserBefore) / totalUserBefore) * 100;
            setPercentTotalOrder(percent)
            console.log(total);
            // if (data.success) {
            //     setOrderData(days, data)
            // }
        })
    }
    const getNewOrderByDays = () => {
        let rangeDate = [startDateNewOrder, endDateNewOrder]
        GetNewOrderByDays(rangeDate).then((dataResult) => {
            console.log(dataResult);
            let total = dataResult.data.daysCurrent.length === 0 ? 0 : dataResult.data.daysCurrent.length;
            let totalUserBefore = dataResult.data.daysBefore.length === 0 ? 0 : dataResult.data.daysBefore.length;
            setNewOrder(total)
            const percent = totalUserBefore === 0 ? (total !== 0 ? 100 : 0) : ((total - totalUserBefore) / totalUserBefore) * 100;
            setPercentNewOrder(percent)
            console.log(total);
            // if (data.success) {
            //     setOrderData(days, data)
            // }
        })
    }

    const getNewUserByDays = () => {
        let rangeDate = [startDateNewUser, endDateNewUser]
        GetNewUserByDays(rangeDate).then((dataResult) => {
            console.log(dataResult);
            let total = dataResult.data.daysCurrent.length === 0 ? 0 : dataResult.data.daysCurrent.length;
            let totalUserBefore = dataResult.data.daysBefore.length === 0 ? 0 : dataResult.data.daysBefore.length;
            setNewUser(total)
            const percent = totalUserBefore === 0 ? (total !== 0 ? 100 : 0) : ((total - totalUserBefore) / totalUserBefore) * 100;
            setPercentNewUser(percent)
            console.log(total);
            // if (data.success) {
            //     setOrderData(days, data)
            // }
        })
    }
    useEffect(() => {
        if (cardInfo.tittleCard === 'Tổng doanh thu') {
            getOrderSuccessByDays()
        }
        if (cardInfo.tittleCard === 'Đơn hàng mới') {
            getNewOrderByDays()
        }
        if (cardInfo.tittleCard === 'Khách hàng mới') {
            getNewUserByDays()
        }
    }, [isDateChanged])
    return (
        <Card
            className='border-b-[4px] border-[#ce1b1b] bg-[#fff]'
            title={
                <Row>
                    <Col span={12} className='align-middle flex my-auto'>
                        <h1 className='font-bold text-[15px]'>{cardInfo.tittleCard}</h1>
                    </Col>
                    <Col span={12} className='text-end'>
                        <RangePicker presets={rangePresets} onChange={onRangeChange}
                            defaultValue={[dayjs().add(-7, 'd'), dayjs()]} />
                    </Col>
                </Row>
            }
            bordered={false}
        >
            <div className='flex justify-between max-[1300px]:flex-col-reverse'>
                <div className='flex'>
                    <IconComponent className='text-[30px] my-auto mr-2 p-4 bg-[#ce1b1b] rounded-xl text-white' />
                    <span className='text-[30px] my-auto'>
                        {cardInfo.tittleCard === 'Tổng doanh thu'
                            ? totalOrder.toLocaleString('vi-VN', { style: 'currency', currency: 'VND' })
                            : cardInfo.tittleCard === 'Đơn hàng mới' ? newOrder : newUser
                        }

                    </span>
                </div>
                <div className='flex max-[1300px]:justify-end max-[1300px]:pb-2'>
                    <IconUpDownComponent className={`${iconClass} text-[20px] my-auto pt mr-2`} />
                    <span className='text-[20px] my-auto'>{
                        cardInfo.tittleCard === 'Tổng doanh thu' ? Math.abs(parseFloat(percentTotalOrder).toFixed(2))
                            : cardInfo.tittleCard === 'Đơn hàng mới' ? Math.abs(parseFloat(percentNewOrder).toFixed(2))
                                : Math.abs(parseFloat(percentNewUser).toFixed(2))} %</span>
                </div>
            </div>
        </Card>
    );
};

export default CardTop;
