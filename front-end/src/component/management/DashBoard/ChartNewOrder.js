import React, { useEffect, useState } from 'react';
import { Line } from 'react-chartjs-2';
import { subDays, format, set, subMonths, addDays } from 'date-fns';
import { DatePicker } from 'antd';

import {
    Chart as ChartJS, CategoryScale, LinearScale, Tooltip, Legend, TimeScale, LineElement, PointElement, defaults, Title, SubTitle
} from 'chart.js';
import dayjs from 'dayjs';

import { GetNewOrderByDays, GetNewUserByDays, GetOrderSuccessByDays } from '../../../callAPI/management/apiDashBoard';

ChartJS.register(
    CategoryScale, LinearScale, TimeScale, Tooltip, Legend, LineElement, PointElement, Title, SubTitle,
)

const { RangePicker } = DatePicker;

defaults.responsive = true
defaults.maintainAspectRatio = false

const ChartNewOrders = ({ data }) => {
    const [isDateChanged, setIsDateChanged] = useState(false)

    const [startDate, setStartDate] = useState(dayjs().add(-7, 'd').toISOString().slice(0, 10))
    const [endDate, setEndDate] = useState(dayjs().toISOString().slice(0, 10))
    const [listOrder, setListOrder] = useState([])
    const [listNewOrder, setListNewOrder] = useState([])
    const [listNewUser, setListNewUser] = useState([])

    const [rangeDate, setRangeDate] = useState(0)

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

    const getOrderSuccessByDays = () => {
        let rangeDate = [startDate, endDate]
        GetOrderSuccessByDays(rangeDate).then((dataResult) => {
            console.log(dataResult);
            setListOrder(dataResult.data.daysCurrent)
            const startDateDate = new Date(startDate);
            const endDateDate = new Date(endDate);

            // Độ chính xác đến ngày bằng cách bỏ đi phần thời gian
            const start = new Date(startDateDate.getFullYear(), startDateDate.getMonth(), startDateDate.getDate());
            const end = new Date(endDateDate.getFullYear(), endDateDate.getMonth(), endDateDate.getDate());

            // Tính số miligiây giữa hai mốc thời gian
            const millisecondsPerDay = 1000 * 60 * 60 * 24;
            const differenceMilliseconds = end - start;

            // Chuyển đổi từ miligiây thành số ngày
            const differenceDays = Math.floor(differenceMilliseconds / millisecondsPerDay);
            setRangeDate(differenceDays)
            console.log('differenceDays: ', differenceDays);
            // if (data.success) {
            //     setOrderData(days, data)
            // }
        })

    }
    const getNewOrderByDays = () => {
        let rangeDate = [startDate, endDate]
        GetNewOrderByDays(rangeDate).then((dataResult) => {
            console.log(dataResult);
            setListNewOrder(dataResult.data.daysCurrent)
        })
    }

    const getNewUserByDays = () => {
        let rangeDate = [startDate, endDate]
        GetNewUserByDays(rangeDate).then((dataResult) => {
            console.log(dataResult);
            setListNewUser(dataResult.data.daysCurrent)
        })
    }
    useEffect(() => {
        getNewOrderByDays()
        getNewUserByDays()
        getOrderSuccessByDays()
    }, [isDateChanged])
    let labels = [];
    let newDataTotal = [];
    let newDataOrder = [];
    let newDataUser = [];


    labels = Array.from({ length: rangeDate + 1 }, (_, i) => {
        const date = subDays(new Date(), rangeDate - i);
        return format(date, 'yyyy-MM-dd');
    });

    const currentDate = new Date();
    const previousDate = subDays(currentDate, rangeDate);

    // Lấy ngày trước hiện tại 1 ngày


    // Format ngày dưới dạng yyyy-MM-dd

    newDataTotal = Array.from({ length: rangeDate + 1 }, (_, i) => {
        // Lấy ngày cần tính tổng doanh thu
        const currentDate = subDays(new Date(endDate), rangeDate - 1 - i);
        const formattedCurrentDate = format(currentDate, 'yyyy-MM-dd');

        // Tính tổng doanh thu của ngày hiện tại
        const totalReturn = listOrder.reduce((accumulator, order) => {
            // Lấy ngày thành công của đơn hàng và chuyển đổi thành định dạng yyyy-MM-dd
            const orderSuccessfulDate = format(new Date(order.successful_at), 'yyyy-MM-dd');

            // Nếu ngày thành công của đơn hàng trùng với ngày hiện tại đang xét
            if (orderSuccessfulDate === formattedCurrentDate) {
                return accumulator + order.total; // Cộng tổng doanh thu của đơn hàng vào tổng kết quả
            } else {
                return accumulator; // Không thay đổi tổng kết quả
            }
        }, 0);

        return totalReturn;
    });

    newDataOrder = Array.from({ length: rangeDate + 1 }, (_, i) => {
        // Lấy ngày cần tính tổng doanh thu
        const currentDate = subDays(new Date(endDate), rangeDate - 1 - i);
        const formattedCurrentDate = format(currentDate, 'yyyy-MM-dd');

        // Tính tổng doanh thu của ngày hiện tại
        const totalReturn = listNewOrder.reduce((accumulator, order) => {
            // Lấy ngày thành công của đơn hàng và chuyển đổi thành định dạng yyyy-MM-dd
            const orderSuccessfulDate = format(new Date(order.created_at), 'yyyy-MM-dd');

            // Nếu ngày thành công của đơn hàng trùng với ngày hiện tại đang xét
            if (orderSuccessfulDate === formattedCurrentDate) {
                return accumulator + 1; // Cộng tổng doanh thu của đơn hàng vào tổng kết quả
            } else {
                return accumulator; // Không thay đổi tổng kết quả
            }
        }, 0);

        return totalReturn;
    });

    newDataUser = Array.from({ length: rangeDate + 1 }, (_, i) => {
        // Lấy ngày cần tính tổng doanh thu
        const currentDate = subDays(new Date(endDate), rangeDate - 1 - i);
        const formattedCurrentDate = format(currentDate, 'yyyy-MM-dd');

        // Tính tổng doanh thu của ngày hiện tại
        const totalReturn = listNewUser.reduce((accumulator, user) => {
            // Lấy ngày thành công của đơn hàng và chuyển đổi thành định dạng yyyy-MM-dd
            const userSuccessfulDate = format(new Date(user.created_at), 'yyyy-MM-dd');

            // Nếu ngày thành công của đơn hàng trùng với ngày hiện tại đang xét
            if (userSuccessfulDate === formattedCurrentDate) {
                return accumulator + 1; // Cộng tổng doanh thu của đơn hàng vào tổng kết quả
            } else {
                return accumulator; // Không thay đổi tổng kết quả
            }
        }, 0);

        return totalReturn;
    });


    const dataNewOrder = {
        labels: labels,
        datasets: [
            {
                label: 'Tổng doanh thu',
                data: newDataTotal,
                fill: false,
                borderColor: 'rgb(206 27 27)',
                backgroundColor: 'rgb(206 27 27)',
                tension: 0.3
            },
            {
                label: 'Đơn hàng mới',
                data: newDataOrder,
                fill: false,
                borderColor: 'rgb(21,177,0)',
                backgroundColor: 'rgb(21,177,0)',
                tension: 0.3,
            },
            {
                label: 'Khách hàng mới',
                data: newDataUser,
                fill: false,
                borderColor: 'rgb(54, 162, 235)',
                backgroundColor: 'rgb(54, 162, 235)',
                tension: 0.3,
            }
        ]
    };

    const optionsNewOrder = {
        scales: {
            y: {
                beginAtZero: true,
                position: 'right',
            },
        },
        plugins: {
            title: {
                display: true,
                align: 'between',
                text: "Đơn hàng mới",
                font: {
                    size: '20px'
                },
                padding: {
                    left: 20,
                    top: 20,
                    bottom: 10,
                }
            },
            legend: {
                display: true,
                position: 'top',
                align: "between",
            }
        }
    };

    return (
        <div className='relative    text-end'>
            <RangePicker presets={rangePresets} onChange={onRangeChange} className=' mr-6 mt-3 '
                defaultValue={[dayjs().add(-7, 'd'), dayjs()]} />
            <Line
                // height={500}
                className='w-full h-full max-h-[500px] min-h-[300px]'
                data={dataNewOrder}
                options={optionsNewOrder}
            />
        </div>
    );
};

export default ChartNewOrders;
