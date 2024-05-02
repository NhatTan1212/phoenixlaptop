import { Card, Col, List, Pagination, Row } from 'antd';
import React, { useContext, useEffect, useState } from 'react';
import { useLocation, useNavigate } from 'react-router-dom';
import { GetBrands, SearchQuery } from '../../../callAPI/api';
import Context from '../../../store/Context';
import renderListProduct from '../../../component/ListProducts';
import './searchPage.scss';

function SearchPage() {
    const context = useContext(Context);
    const isHiddenAutoCpl = context.isHiddenAutoCpl;
    const isScreenSmaller1280 = context.isScreenSmaller1280;
    const isScreenSmaller430 = context.isScreenSmaller430;

    const navigate = useNavigate();
    const location = useLocation();
    const urlParams = new URLSearchParams(location.search);

    const searchKeyword = urlParams.get('q');

    const [brands, setBrands] = useState([]);
    const [products, setProducts] = useState([]);
    const [sortStatus, setSortStatus] = useState('');
    const [pagination, setPagination] = useState({
        currentPage: 1,
        totalPages: 1,
        totalRecords: 1,
        limit: 1
    });

    const getBrands = () => {
        GetBrands().then(response => {
            setBrands(response);
        });
    };

    const getProductsByQuery = () => {
        SearchQuery(location.search).then(response => {
            setProducts(response.data);
            setPagination({
                currentPage: parseInt(response.currentPage),
                totalPages: parseInt(response.totalPages),
                totalRecords: response.totalRecords ? parseInt(response.totalRecords) : 0,
                limit: parseInt(response.limit),
            });
        });
    };

    const handleSort = (sort) => {
        let newSortParam = '';
        setSortStatus(sort);

        if (sort === 'asc') {
            newSortParam = 'asc';
        } else if (sort === 'desc') {
            newSortParam = 'desc';
        }

        let newSearch = location.search;

        if (!newSortParam) {
            newSearch = newSearch.replace(/([?&])sort=[^&]+(&|$)/i, '');
        } else if (!newSearch.includes('sort=')) {
            newSearch += newSearch.includes('?') ? `&sort=${newSortParam}` : `?sort=${newSortParam}`;
        } else {
            newSearch = newSearch.replace(/([?&])sort=[^&]+(&|$)/i, `$1sort=${newSortParam}$2`);
        }

        newSearch = newSearch.replace(/([?&])page=[^&]+(&|$)/i, '$1page=1$2');

        navigate(`/search${newSearch}`);
    };

    const handlePageChange = (page) => {
        navigate(location.search.replace(/(?<=page=)\d+/, `${page}`))
    };

    useEffect(() => {
        getBrands();
        getProductsByQuery();
    }, []);

    useEffect(() => {
        getProductsByQuery();
    }, [location.search]);

    return (
        <div className="allproduct-wrap-content m-auto ">
            <div className={`${isScreenSmaller430 ? 'mx-4' : 'mx-[30px]'}`}>
                <Row gutter={[24, 24]}>
                    <Col xs={24} sm={24} md={24} lg={24}>
                        <div className={`product-list-section bg-white  pt-0 ${isScreenSmaller430 ? 'p-0' : 'p-4'}`}>
                            <div className='flex justify-between'>
                                <div className='my-4 text-base'>
                                    Tìm được
                                    <span className='text-red-600 font-semibold'> {pagination.totalRecords} </span>
                                    kết quả cho từ khóa
                                    <span className='text-red-600 font-semibold italic'> "{searchKeyword}" </span>
                                </div>
                                <div className='flex'>
                                    <span className='my-4 px-3 py-1 ml-0 pl-0 max-[430px]:pl-2 '>Ưu tiên xem:</span>
                                    <span
                                        className={
                                            sortStatus === ''
                                                ? ('my-4 mx-0 px-3 py-1 border-[1px] border-[#bababa] bg-[#cb1c22] text-white rounded-l-md')
                                                : ('my-4 mx-0 px-3 py-1 border-[1px] border-[#bababa] text-black rounded-l-md')
                                        }
                                        onClick={() => { handleSort('') }}
                                    >
                                        Sản phẩm mới
                                    </span>
                                    <span
                                        className={
                                            sortStatus === 'desc'
                                                ? ('my-4 mx-0 px-3 py-1 border-[1px] border-[#bababa] bg-[#cb1c22] text-white border-l-0')
                                                : ('my-4 mx-0 px-3 py-1 border-[1px] border-[#bababa] border-l-0')
                                        }
                                        onClick={() => { handleSort('desc') }}
                                    >
                                        Giá cao
                                    </span>
                                    <span
                                        className=
                                        {
                                            sortStatus === 'asc'
                                                ? 'my-4 mx-0 px-3 py-1 border-[1px] border-[#bababa] bg-[#cb1c22] text-white border-l-0 rounded-r-md'
                                                : 'my-4 mx-0 px-3 py-1 border-[1px] border-[#bababa] border-l-0 rounded-r-md'
                                        }
                                        onClick={() => { handleSort('asc') }}
                                    >
                                        Giá thấp
                                    </span>
                                </div>
                            </div>
                            <List
                                grid={isHiddenAutoCpl ? { gutter: 16, column: 4 } : { gutter: 0, column: 2 }}
                                className=''
                                dataSource={products}
                                renderItem={(item) => (
                                    <List.Item className='h-full'>
                                        <Card className=' w-[100%] h-[100%] overflow-hidden'>
                                            {renderListProduct(item, brands)}
                                        </Card>
                                    </List.Item>
                                )}
                            />
                            <div className='flex justify-center'>
                                <Pagination
                                    onChange={(page) => { handlePageChange(page) }}
                                    current={pagination.currentPage}
                                    pageSize={pagination.limit}
                                    total={pagination.totalRecords}
                                />
                            </div>
                        </div>
                    </Col>
                </Row>
            </div>
        </div>
    );
}

export default SearchPage;
