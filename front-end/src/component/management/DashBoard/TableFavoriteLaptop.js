import React, { useState, useEffect, useContext } from 'react';
import {
    Breadcrumb, Input, Button, Table, Select
} from 'antd';
import { GetFavoriteLaptopsByDays } from '../../../callAPI/management/apiDashBoard';
import './TableFavoriteLaptops.scss'

const TableFavoriteLaptops = ({ data }) => {
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

    const getFavoriteBrandsByDays = (days) => {
        GetFavoriteLaptopsByDays(days).then((data) => {
            console.log(data.listFavoriteLaptops);
            if (data.success) {
                setFavoriteLaptopsData(data.listFavoriteLaptops)
            }
        })
    }

    useEffect(() => {
        getFavoriteBrandsByDays(data.daysFavoriteLaptopsSelected)
    }, [data.daysFavoriteLaptopsSelected]);

    return (
        <>

            <div className='relative'>
                <Select
                    className='absolute right-2 top-2 z-10'
                    value={data.daysFavoriteLaptopsSelected || 7}
                    options={[
                        {
                            value: 7,
                            label: 'Xem theo tuần'
                        },
                        {
                            value: 30,
                            label: 'Xem theo tháng'
                        },
                        {
                            value: 365,
                            label: 'Xem theo năm'
                        },
                    ]}
                    onChange={(e) => {
                        data.setDaysFavoriteLaptopsSelected(e)
                    }}
                ></Select>
                <h3 className='font-bold text-[15px] pl-4 p-3 bg-white '>Laptop bán chạy </h3>
                <Table
                    pagination={{ defaultPageSize: 5 }}
                    className='table-favorite-product'
                    columns={columns}
                    dataSource={favoriteLaptopsData}>
                </Table>
            </div>
        </>
    );
};
export default TableFavoriteLaptops;