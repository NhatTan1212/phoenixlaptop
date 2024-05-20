import { useParams, Link } from 'react-router-dom';
import React, { useState, useEffect, useContext } from 'react';
import Cookies from 'js-cookie'; // Import thư viện js-cookie
import axios from 'axios';
import { FontAwesomeIcon } from '@fortawesome/react-fontawesome'
import { faXmark, faAngleLeft, faTriangleExclamation } from '@fortawesome/free-solid-svg-icons';
import './orderDetail.scss'
import Instance from '../../../axiosInstance';
import DeliveryAddressOrderDetail from '../../../component/management/DeliveryAddress';
import TableOrderDetail from '../../../component/management/TableOrderDetail';
import Context from '../../../store/Context';
import { Button, Col, Image, Modal, Row } from 'antd';
import iconsOrder from '../../../global/imageOrder'


function OrderDetail() {
    const context = useContext(Context)
    const isHiddenAutoCpl = context.isHiddenAutoCpl
    const isScreenSmaller1280 = context.isScreenSmaller1280
    const isScreenSmaller430 = context.isScreenSmaller430

    const { id } = useParams();
    const token = Cookies.get('token');
    const tokenGID = Cookies.get('tokenGID');
    const [orderDetail, setOrderDetail] = useState([]);
    const [products, setProducts] = useState([]);
    const [order, setOrder] = useState([]);
    const [confirmDelete, setConfirmDelete] = useState(false);
    const [orderDetailChange, setorderDetailChange] = useState(false);
    const [isDisableDeleteOrder, setIsDisableDeleteOrder] = useState(false);
    const columns = [
        {
            title: 'Hình sản phẩm',
            dataIndex: 'avatar',
            key: 'avatar',
            render: (_, record) => {
                const product = products.find((item) => (
                    item.id === record.product_id
                ))
                return (
                    // console.log("record", record)
                    <div className='w-[108px] '>
                        <img
                            src={product.avatar}
                            className='w-full h-auto border-[1px] border-[#e1dada]'
                        ></img>

                    </div>
                )

            }
        },
        {
            title: 'Miêu tả',
            dataIndex: 'description',
            key: 'description',
            render: (_, record) => {
                const product = products.find((item) => (
                    item.id === record.product_id
                ))
                return (
                    <p className='font-bold text-[17px] text-[#333]'>{product.prod_description}</p>
                )

            }
        },
        {
            title: 'Đơn giá',
            key: 'price',
            dataIndex: 'price',
            render: (_, record) => (
                <span>{record.price.toLocaleString('vi-VN', { style: 'currency', currency: 'VND' })}</span>
            )
        },
        {
            title: 'Số lượng',
            key: 'quantity',
            dataIndex: 'quantity',
            render: (_, record) => (
                <span>{record.quantity}</span>
            )
        },
    ];

    const deviceColumns = [
        {
            title: 'Danh sách sản phẩm',
            render: (_, record) => {
                const product = products.find((item) => (
                    item.id === record.product_id
                ))
                return (
                    // console.log("record", record)
                    <div >
                        <div className='flex max-[650px]:flex-col'>
                            <div className='mr-4 w-[108px] min-w-[108px]'>
                                <img
                                    src={product.avatar}
                                    className='w-full h-auto border-[1px] border-[#e1dada]'
                                ></img>
                            </div>
                            <p className='font-bold text-[17px] text-[#333]   max-[470px]:max-w-[300px]'>{product.prod_description}</p>

                        </div>
                        <div className='flex justify-between'>
                            <span className='ml-[124px] max-[650px]:mx-0'>x{record.quantity}</span>
                            <span>{record.price.toLocaleString('vi-VN', { style: 'currency', currency: 'VND' })}</span>

                        </div>
                    </div>
                )

            }
        },
    ];

    const dataTable = orderDetail.map((item) => ({
        ...item,
        key: item.id
    }));
    const getorderDetail = () => {

        Instance.get(`/orderdetails/${id}`)
            .then(response => {
                console.log(response.data);
                setOrderDetail(response.data.orderDetails);
                setProducts(response.data.dataProduct)
                // console.log(productDetail)
            })
            .catch(error => {
                // Handle errors here
                console.error('Error fetching data:', error);
            });

    }

    const getOrder = () => {

        const keyToken = token ? 'token' : 'tokenGID'
        const valueToken = token ? token : tokenGID

        Instance.post('/order', { [keyToken]: valueToken }, {
            headers: {
                "Content-Type": "application/json",
            }
        })
            .then(response => {
                console.log(response.data);
                const dataOrder = response.data.find((order) => (order.id + '' === id + ''))
                setOrder(dataOrder)
                dataOrder && setIsDisableDeleteOrder((dataOrder.is_payment === 1 || dataOrder.is_cancel
                    || dataOrder.is_approved === 1 || dataOrder.is_being_shipped === 1
                    || dataOrder.is_transported === 1 || dataOrder.is_success === 1) ? true : false)

            })
            .catch(error => {
                // Xử lý lỗi ở đây
                console.error('Error fetching data:', error);
            });

    }

    const handleOkButtonDeleteOrder = () => {
        Instance.get(`/cancel-order/${id}`)
            .then(response => {
                console.log(response.data);
                context.Message("success", "Hủy đơn hàng thành công")
                setConfirmDelete(false)
                setorderDetailChange(true)
                // console.log(productDetail)
            })
            .catch(error => {
                context.Message("error", "Hủy đơn hàng thất bại")
                console.error('Error fetching data:', error);
            });
    }

    const handleDeleteButton = () => {
        if (order.is_cancel) return
        (isDisableDeleteOrder && order.is_payment) ? context.Message("error", "Đơn hàng đã thanh toán không thể hủy.")
            : (isDisableDeleteOrder && (order.is_approved || order.is_being_shipped
                || order.is_transported || order.is_success))
                ? context.Message("error", "Đơn hàng đã được chấp nhận không thể hủy")
                : setConfirmDelete(true)
    }


    const oderStatusCpn = (status, iconActive, iconDisable, title, positionLeft, positionTop, dateStatus) => {

        return (
            <div className='relative'>
                <div>
                    <div
                        style={{ left: `-${positionLeft}px`, top: `${positionTop}px`, backgroundColor: status === 1 ? '#2dc258' : '#d8d8d8' }}
                        className={`absolute w-[210px] h-[3px] z-[1]`}
                    ></div>
                </div>

                <div className='flex flex-col w-[210px]'>
                    <div className={`border-[4px] border-[${status === 1 ? '#2dc258' : '#d8d8d8'}] rounded-[100px] p-3
                                max-w-[60px] mx-auto z-10 relative bg-white`}>
                        <img src={status === 1 ? iconActive : iconDisable} alt='order-img' className='w-[35px] object-contain '></img>
                    </div>
                    <div className='mt-2 mx-auto text-center'>{title}</div>
                    {status == 1 ?
                        <div className='mx-auto text-center text-[#a4a4a4] text-sm '>
                            <span>
                                {dateStatus.slice(11, 16)}
                            </span>
                            <span className='ml-2'>
                                {new Date(dateStatus).toLocaleDateString().replace(/\//g, '-')}
                            </span>

                        </div> : null
                    }
                </div>
            </div>
        )
    }

    useEffect(() => {
        getorderDetail();
        getOrder()
    }, [orderDetailChange]);


    return (
        <div className='bg-[#f0f0f0] py-3 flex'>
            <Modal
                open={confirmDelete}
                onCancel={() => setConfirmDelete(false)}
                onOk={handleOkButtonDeleteOrder}
            >
                {
                    'Bạn có chắc là muốn hủy đơn hàng này không.'
                }
            </Modal>

            <div className='w-10/12 mx-[auto] max-[1550px]:w-full flex'>
                <div className='flex-1 mr-5'>

                    {
                        order && order.is_cancel &&
                        <div className='bg-[#fffdea] mx-[263px] flex flex-col max-[1550px]:mx-[293px] max-[1360px]:mx-[30px] border-[2px] 
                border-[#8f7f00] mb-3'>
                            <div className='flex p-4'>
                                <div>
                                    <FontAwesomeIcon icon={faTriangleExclamation} className='text-[#8f7f00]' />
                                </div>
                                <div>
                                    <Col className='p-3 py-0 font-bold text-[#8f7f00]'>Đơn hàng đã hủy</Col>
                                    <Col className='p-3 py-0'>Đơn hàng được hủy vào lúc

                                        <span className='pl-1 font-bold text-[#8f7f00]' >
                                            {new Date(order.cancel_at).toLocaleDateString()}
                                        </span>
                                        <span className='pl-1 font-bold text-[#8f7f00]'>
                                            {`${new Date(order.cancel_at).toISOString().slice(11, 19)}`}
                                        </span>
                                    </Col>
                                </div>
                            </div>
                        </div>
                    }

                    <div className='mb-3 max-[1550px]:mx-[293px] max-[1360px]:mx-[30px]'>
                        <div className='flex items-center justify-between mb-3 max-[730px]:flex-col max-[730px]:items-start'>
                            <Link to={'/order'} className='flex items-center '>
                                <FontAwesomeIcon
                                    className='text-[gray] pr-2'
                                    icon={faAngleLeft}></FontAwesomeIcon>
                                <h5 className=''>Quay lại các đơn đặt hàng của bạn</h5>
                            </Link>
                            <div className='max-[435px]:flex max-[435px]:flex-col'>
                                <span>Mã đơn hàng: {order ? order.id : 'N/A'} |</span>
                                <span className='text-[#ed1d24] uppercase font-bold ml-4 max-[435px]:ml-0'>

                                    {order ? order.is_cancel === 1 ? 'Đơn hàng đã hủy' : order.user_address === 'Nhận hàng tại cửa hàng' ? 'Đặt hàng thành công'

                                        : order.is_success === 1 ? 'Đơn hàng đã hoàn tất'
                                            : order.is_transported === 1 ? 'Đơn hàng đã được giao đến nơi'
                                                : order.is_being_shipped === 1 ? 'Đơn hàng đang được giao đến bạn'
                                                    : order.is_approved === 1 ? 'Đơn hàng đã được xác nhận. (Đang chuẩn bị hàng)'
                                                        : 'Đang chờ phê duyệt' : ''
                                    }</span>


                            </div>
                        </div>
                        <div className='flex justify-center py-4 bg-white mb-1 relative'>


                            <div className='flex flex-col w-[210px]'>
                                <div className={`border-[4px] border-[#2dc258] rounded-[100px] p-3 max-w-[60px] mx-auto z-10 relative bg-white`}>
                                    <img src={iconsOrder.receiptActive} alt='order-img' className='w-[35px] object-contain '></img>
                                </div>
                                <div className='mt-2 mx-auto'>Đơn hàng đã đặt</div>

                                {order && order.length != 0 &&
                                    <>
                                        <div className='mx-auto text-[#a4a4a4] text-sm '>
                                            <span>
                                                {order.created_at.slice(11, 16)}
                                            </span>
                                            <span className='ml-2'>
                                                {new Date(order.created_at).toLocaleDateString().replace(/\//g, '-')}
                                            </span>

                                        </div>
                                    </>

                                }




                            </div>

                            {
                                order && order.user_address !== 'Nhận hàng tại cửa hàng' && oderStatusCpn(order.is_payment, iconsOrder.paymentActive, iconsOrder.paymentDisable, 'Đơn hàng đã thanh toán', 120, 30, order.paid_at)
                            }
                            {
                                order && order.user_address !== 'Nhận hàng tại cửa hàng' && oderStatusCpn(order.is_being_shipped, iconsOrder.deliveryActive, iconsOrder.deliveryDisable, 'Đơn hàng đang được giao đến bạn', 120, 30, order.being_shipped_at)
                            }
                            {
                                order && order.user_address !== 'Nhận hàng tại cửa hàng' && oderStatusCpn(order.is_transported, iconsOrder.receiverActive, iconsOrder.receiptDisable, 'Đã nhận được hàng', 120, 30, order.transported_at)
                            }
                            {
                                oderStatusCpn(order && order.is_success, iconsOrder.checkActive, iconsOrder.checkDisable, 'Đơn hàng đã hoàn thành', 120, 30, order && order.successful_at)
                            }

                        </div>
                        <div className='bg-[#fff]'>
                            <DeliveryAddressOrderDetail order={order} />

                        </div>

                    </div>
                    <div className='bg-[#ffffff] flex flex-col max-[1550px]:mx-[293px] max-[1360px]:mx-[30px]'>
                        <TableOrderDetail
                            columns={isHiddenAutoCpl ? columns : deviceColumns}
                            dataSource={dataTable}
                            order={order} />
                    </div>
                    <div className='bg-[#ffffff] flex flex-col max-[1550px]:mx-[293px] max-[1360px]:mx-[30px] py-5'>
                        <div className='flex justify-end mr-[30px]'>
                            <Button
                                onClick={handleDeleteButton}
                                className={`bg-[#cb1c22]  ${isDisableDeleteOrder ? 'bg-gray-300 cursor-not-allowed opacity-50 text-black' : 'text-white'}`}>
                                Hủy đơn hàng
                            </Button>
                        </div>
                    </div>
                </div>


                {
                    (order.paymentMethods === 'BANK' && (!order.is_payment && !order.is_cancel)) ?
                        <div className='w-[400px] h-[max-content] mt-9 bg-white p-6'>
                            <div className='italic'>* Quét mã QR Code để thanh toán.</div>
                            <div className='flex flex-col justify-center items-center mt-6'>
                                <img className='w-80' src={`https://img.vietqr.io/image/mb-0354086520-compact.png?amount=${order.total}&addInfo=DH${order.id}&accountName=HO%20THANH%20HIEN`} alt='qr'></img>

                                <div className='flex flex-col justify-center items-center mt-6 text-[#214e89] text-lg'>
                                    <div>Số tiền: {order ? order.total ? order.total.toLocaleString('vi-VN') + ' VND' : '' : ''}</div>
                                    <div>Nội dung CK: DH{order ? order.id : 'N/A'}</div>
                                    <div>Tên chủ tài khoản: HO THANH HIEN</div>
                                    <div>Số TK: <span className='font-bold'> 0354086520</span></div>
                                    <div>Ngân hàng TMCP Quân Đội</div>
                                </div>
                            </div>
                        </div> : null
                }
            </div>
        </div>

    );
}

export default OrderDetail