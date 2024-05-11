import React, { useState, useEffect, useContext } from 'react';
import { Bar } from 'react-chartjs-2';
import { subDays, format, set } from 'date-fns';
import dayjs from 'dayjs';
import { Select, DatePicker } from 'antd';

import {
    Chart as ChartJS, BarElement, CategoryScale, LinearScale, Tooltip, Legend, TimeScale, PointElement, defaults, Title, ArcElement
} from 'chart.js';
import { GetFavoriteBrandsByDays } from '../../../callAPI/management/apiDashBoard';

ChartJS.register(BarElement, CategoryScale, LinearScale, TimeScale, Tooltip, Legend, PointElement, Title, ArcElement
)
const { RangePicker } = DatePicker;

defaults.maintainAspectRatio = false
defaults.responsive = true

const ChartFavoriteBrands = ({ data }) => {
    const [startDate, setStartDate] = useState(dayjs().add(-7, 'd').toISOString().slice(0, 10))
    const [endDate, setEndDate] = useState(dayjs().toISOString().slice(0, 10))
    const [isDateChanged, setIsDateChanged] = useState(false)
    const [listOrder, setListOrder] = useState([])

    const getFavoriteBrandsByDays = () => {
        let rangeDate = [startDate, endDate]
        GetFavoriteBrandsByDays(rangeDate).then((data) => {
            console.log(data);
            if (data.success) {
                setListOrder(data.listFavoriteBrands)
            }
        })
    }
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


    useEffect(() => {
        getFavoriteBrandsByDays()
    }, [isDateChanged]);

    const labels = listOrder.map(item => {
        return item.name
    });
    const dataFavoriteBrands = listOrder.map(item => {
        return item.total_success_products
    });

    const progressBar = {
        id: 'progressBar',
        beforeDraw(chart, args, pluginOptions) {
            const { ctx, data, chartArea: { top, bottom, left, right, width, height }, scales: { x, y } } = chart;
            const fontSizeLabel = 12;
            ctx.save();
            // Vòng lặp qua từng dữ liệu để hiển thị nhãn lên trên các thanh dữ liệu
            data.labels.forEach((label, index) => {
                const yPos = y.getPixelForValue(index) - fontSizeLabel - 5;
                ctx.fillStyle = 'rgba(102, 102, 102, 1)';
                ctx.font = `${fontSizeLabel}px sans-serif`;
                ctx.textAlign = 'left';
                ctx.textBaseLine = 'middle'
                ctx.fillText(label, left, yPos);
            });

            data.datasets[0].data.forEach((data, index) => {
                const yPos = y.getPixelForValue(index) - fontSizeLabel - 5;
                ctx.fillStyle = 'rgba(102, 102, 102, 1)';
                ctx.font = `${fontSizeLabel}px sans-serif`;
                ctx.textAlign = 'right';
                ctx.textBaseLine = 'middle'
                ctx.fillText(data, right, yPos);
            });

            ctx.restore();
        }
    };



    const dataTotal = {
        labels: labels,
        datasets: [{
            label: 'Thương hiệu bán chạy',
            data: dataFavoriteBrands,
            backgroundColor: [
                'rgb(100, 150, 200)',
                'rgb(50, 200, 100)',
                'rgb(220, 120, 180)',
                'rgb(180, 60, 240)',
                'rgb(20, 180, 220)',
                'rgb(25, 280, 220)',
                'rgb(230, 123, 220)',
                'rgb(210, 10, 220)',
            ],
            borderColor: [
                'rgb(100, 150, 200)',
                'rgb(50, 200, 100)',
                'rgb(220, 120, 180)',
                'rgb(180, 60, 240)',
                'rgb(20, 180, 220)',
                'rgb(25, 280, 220)',
                'rgb(230, 123, 220)',
                'rgb(210, 10, 220)',
            ],
            borderWidth: 1,
            borderRadius: 5,
            borderSkipped: false,
            barPercentage: 0.2,
            categoryPercentage: 0.8
        }],
    };

    const optionsTotal = {
        indexAxis: 'y', // Xác định trục chính là trục y để thanh biểu đồ ngang
        scales: {
            x: {
                display: false,
                grid: {
                    display: false,
                    drawBorder: false
                },
                ticks: {
                    display: false
                }
            },
            y: {
                display: false,
                beginAtZero: true,
                grid: {
                    display: false,
                    drawBorder: false
                },
                ticks: {
                    display: false
                }
            },
        },
        plugins: {
            title: {
                display: true,
                align: 'start',
                text: "Thương hiệu bán chạy",
                font: {
                    size: '20px'
                },
                padding: {
                    top: 16,
                }
            },
            legend: {
                display: false,
                position: 'bottom',
                align: "center"
            },

        },
    };

    return (
        <div className='relative px-5'>
            <RangePicker presets={rangePresets} onChange={onRangeChange} className=' mr-6 mt-3 absolute top-0 right-0'
                defaultValue={[dayjs().add(-7, 'd'), dayjs()]} />
            <Bar
                className='w-full h-[500px]'
                data={dataTotal}
                options={optionsTotal}
                plugins={[progressBar]}
            />
        </div>
    );
};

export default ChartFavoriteBrands;
