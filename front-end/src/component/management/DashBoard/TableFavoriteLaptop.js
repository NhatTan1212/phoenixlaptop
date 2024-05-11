import React, { useState, useEffect, useContext } from 'react';
import {
    Breadcrumb, Input, Button, Table, Select, Row, Col, DatePicker
} from 'antd';
import { GetFavoriteLaptopsByDays } from '../../../callAPI/management/apiDashBoard';
import './TableFavoriteLaptops.scss'
import Context from '../../../store/Context';
import dayjs from 'dayjs';

const { RangePicker } = DatePicker;

const TableFavoriteLaptops = ({ data }) => {
    const context = useContext(Context)
    const [startDate, setStartDate] = useState(dayjs().add(-7, 'd').toISOString().slice(0, 10))
    const [endDate, setEndDate] = useState(dayjs().toISOString().slice(0, 10))
    const [listOrder, setListOrder] = useState([])
    const isHiddenAutoCpl = context.isHiddenAutoCpl
    const isScreenSmaller1280 = context.isScreenSmaller1280
    const isScreenSmaller430 = context.isScreenSmaller430
    const [isDateChanged, setIsDateChanged] = useState(false)

    const [favoriteLaptopsData, setFavoriteLaptopsData] = useState([])
    const columns = [
        {
            title: 'Ảnh đại diện',
            dataIndex: 'avatar',
            render: (dataIndex) => {
                return <img src={dataIndex} className='max-h-[80px]'></img>
            }
        },
        {
            title: 'Tên laptop',
            dataIndex: 'prod_name'
        },
        {
            title: 'Giá bán',
            dataIndex: 'price',
        },
        {
            title: 'Số lượng đã bán',
            dataIndex: 'quantity_sold',
        },
        {
            title: 'Còn trong kho',
            dataIndex: 'stock',
        },
    ];
    const onRangeChange = (dates, dateStrings) => {
        if (dates) {
            console.log('From: ', dates[0], ', to: ', dates[1]);
            console.log('From: ', dateStrings[0], ', to: ', dateStrings[1]);

            setStartDate(dateStrings[0])
            setEndDate(dateStrings[1])

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

    const deviceColumns = [
        {
            title: "Laptop bán chạy",
            render: (record, key, index) => {
                return (
                    <div>
                        <Row>
                            <Col md={{ span: 6, offset: 1 }} sm={{ span: 6, offset: 1 }} xs={{ span: 24, offset: 0 }}>
                                <div
                                    className='w-[108px]'
                                >
                                    < img
                                        src={record.avatar}
                                        className='w-full h-auto border-[1px] border-[#e1dada]'
                                    ></img >

                                </div>
                            </Col>
                            <Col md={{ span: 17 }} sm={{ span: 17 }} xs={{ span: 24 }}>
                                <p className='font-bold text-[17px] text-[#333] max-[576px]:max-w-[250px]'>{record.prod_name}</p>
                                <p>{record.price.toLocaleString('vi-VN', { style: 'currency', currency: 'VND' })}</p>
                                <p>Số lượng đã bán: {record.quantity_sold}</p>
                                <p>Còn trong kho: {record.stock}</p>
                            </Col>

                        </Row>
                    </div>
                )
            }
        }
    ];

    const getFavoriteBrandsByDays = () => {
        let rangeDate = [startDate, endDate]
        GetFavoriteLaptopsByDays(rangeDate).then((data) => {
            console.log(data);
            if (data.success) {
                setFavoriteLaptopsData(data.listFavoriteLaptops)
            }
        })
    }

    useEffect(() => {
        getFavoriteBrandsByDays()
    }, [isDateChanged]);

    return (
        <>

            <div className='relative'>
                <RangePicker presets={rangePresets} onChange={onRangeChange} className=' mr-6 mt-3 absolute top-0 right-0'
                    defaultValue={[dayjs().add(-7, 'd'), dayjs()]} />
                <h3 className='font-bold text-[15px] pl-4 p-3 bg-white '>Laptop bán chạy </h3>
                <Table
                    pagination={{ defaultPageSize: 5 }}
                    className='table-favorite-product'
                    columns={isHiddenAutoCpl ? columns : deviceColumns}
                    dataSource={favoriteLaptopsData}>
                </Table>
            </div>
        </>
    );
};
export default TableFavoriteLaptops;