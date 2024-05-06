import { HomeOutlined, LaptopOutlined } from '@ant-design/icons';
import { Breadcrumb, Card, Checkbox, Col, List, Pagination, Radio, Row } from 'antd';
import React, { useContext, useEffect, useState } from 'react';
import { useLocation, useNavigate, useParams, useSearchParams } from 'react-router-dom';
import { GetBrands, GetCategories, GetProductsByQuery } from '../../../callAPI/api';
import CheckBoxGroup from '../../../component/CheckBoxGroup';
import renderListProduct from '../../../component/ListProducts';
import './AllProduct.scss';
import Context from '../../../store/Context';

const CheckboxGroup = Checkbox.Group;
function AllProduct() {
    const context = useContext(Context)
    const isHiddenAutoCpl = context.isHiddenAutoCpl
    const isScreenSmaller1280 = context.isScreenSmaller1280
    const isScreenSmaller430 = context.isScreenSmaller430

    const navigate = useNavigate();
    const location = useLocation();
    const urlParams = new URLSearchParams(location.search);

    const [products, setProducts] = useState([]);
    const [brands, setBrands] = useState([]);
    const [categories, setCategories] = useState([]);
    const [nameBrands, setNameBrands] = useState([]);
    const [brandSlugs, setBrandSlugs] = useState([]);
    const [nameCategories, setNameCategories] = useState([]);
    const [checkedListBrands, setCheckedListBrands] = useState([]);
    const [checkedListCategories, setCheckedListCategories] = useState([]);
    const { query } = useParams(); // Lấy tham số từ URL
    const [isCheckedAllBrands, setIsCheckedAllBrands] = useState(false)
    const [isCheckedAllCategories, setIsCheckedAllCategories] = useState(false)
    const [sortStatus, setSortStatus] = useState(null)
    const [currentPage, setCurrentPage] = useState(1)
    const [pagination, setPagination] = useState({
        currentPage: 1,
        totalPages: 1,
        totalProducts: 1,
        limit: 1
    })

    const priceRange = [
        { lable: 'Tất cả', value: 'tat-ca' },
        { lable: 'Dưới 10 triệu', value: 'duoi-10-trieu' },
        { lable: 'Từ 10 - 20 triệu', value: 'tu-10-den-20-trieu' },
        { lable: 'Từ 20 - 30 triệu', value: 'tu-20-den-30-trieu' },
        { lable: 'Từ 30 - 40 triệu', value: 'tu-30-den-40-trieu' },
        { lable: 'Trên 40 triệu', value: 'tren-40-trieu' }
    ]
    const [checkedPriceRange, setCheckedPriceRange] = useState(priceRange[0].value);

    useEffect(() => {

        setCurrentPage(pagination.currentPage)

    }, [query])

    useEffect(() => {
        getBrands();
        getCategories();
        getProductsByQuery();
        getSortSelected();
        setCheckBoxSelected();
    }, [query]);

    const setCheckBoxSelected = () => {
        if (query === 'page=1') {
            setIsCheckedAllBrands(true)
            setIsCheckedAllCategories(true)
        } else {
            setIsCheckedAllBrands(true)
            setIsCheckedAllCategories(true)
            if (query.includes('&')) {
                let arrQuerySplit = query.split('&')
                arrQuerySplit.forEach((querySplit) => {
                    if (querySplit.includes('brand')) {
                        let brand = querySplit.split('=')[1].split(',')
                        setCheckedListBrands(brand)
                        if (!query.includes('category')) {
                            setCheckedListCategories([])
                        }
                        setIsCheckedAllBrands(false)
                    }
                    if (querySplit.includes('category')) {
                        let getCategory = querySplit.split('=')[1].split(',')
                        setCheckedListCategories(getCategory)
                        setIsCheckedAllCategories(false)
                    }
                })
            } else {
                setIsCheckedAllBrands(true)
                setIsCheckedAllCategories(true)
                if (query.includes('brand')) {
                    let brand = query.split('=')[1]
                    brand = brand.split(',')
                    setCheckedListBrands(brand)
                    setIsCheckedAllBrands(false)
                    setIsCheckedAllCategories(true)
                } else {
                    setCheckedListBrands([])
                    setIsCheckedAllBrands(true)
                }

                if (query.includes('category')) {
                    let getCategory = query.split('=')[1]
                    getCategory = getCategory.split(',')
                    setCheckedListCategories(getCategory)
                    setIsCheckedAllCategories(false)
                    setIsCheckedAllBrands(true)
                } else {
                    setCheckedListCategories([])
                    setIsCheckedAllCategories(true)
                }

            }
        }
    }

    const getSortSelected = () => {
        if (query.includes('sort=gia-thap-den-cao')) {
            setSortStatus('asc')
        } else if (query.includes('sort=gia-cao-den-thap')) {
            setSortStatus('desc')
        } else {
            setSortStatus(null)
        }
    }
    const getBrands = () => {
        GetBrands().then(response => {
            setBrands(response);
            setNameBrands(response.map((brand) => {
                return brand.name
            }, []))
            setBrandSlugs(response.map((brand) => {
                return brand.slug
            }, []))
        })
    }

    const getCategories = () => {
        GetCategories().then(response => {
            setCategories(response);
            setNameCategories(response.map((category) => {
                return category.name
            }, []))
        })
    }

    const getProductsByQuery = () => {
        GetProductsByQuery(query).then(response => {
            setProducts(response.products);
            setPagination({
                currentPage: response.currentPage,
                totalPages: response.totalPages,
                totalProducts: response.totalProducts,
                limit: response.limit,
            })
        })
    }

    const handleCheckboxChangeBrands = (e) => {
        setCheckedListBrands(e)
        let newQuery = query

        if (e.length === 0 || e.length === brands.length) {
            setCheckedListBrands([])
            navigate(`/laptop/${newQuery.replace(/([?&])brand=[^&]+&?/, '$1').replace(/&$/, '')}`);
            return
        }

        newQuery = newQuery.replace(/([?&])brand=[^&]*/, '') + (newQuery.includes('?') ? '&' : '&') + 'brand=' + e.join(',');
        navigate(`/laptop/${newQuery.replace(/page=[^&]+(&|$)/i, 'page=1$1')}`);
    };

    const handleSelectAllChangeBrands = (e) => {
        let newQuery = query.replace(/([?&])brand=[^&]+&?/, '$1').replace(/&$/, '');
        navigate(`/laptop/${newQuery.replace(/page=[^&]+(&|$)/i, 'page=1$1')}`);
        setCheckedListBrands([])
    };

    const handleCheckboxChangeCategories = (e) => {
        setCheckedListCategories(e)
        let newQuery = query

        if (e.length === 0 || e.length === categories.length) {
            setCheckedListCategories([])
            navigate(`/laptop/${newQuery.replace(/([?&])category=[^&]+&?/, '$1').replace(/&$/, '')}`);
            return
        }

        newQuery = newQuery.replace(/([?&])category=[^&]*/, '') + (newQuery.includes('?') ? '&' : '&') + 'category=' + e.join(',');
        navigate(`/laptop/${newQuery.replace(/page=[^&]+(&|$)/i, 'page=1$1')}`);
    };

    const handleSelectAllChangeCategories = (e) => {
        let newQuery = query.replace(/([?&])category=[^&]+&?/, '$1').replace(/&$/, '');
        navigate(`/laptop/${newQuery.replace(/page=[^&]+(&|$)/i, 'page=1$1')}`);
        setCheckedListCategories([])
    };

    const handleCheckboxChangePriceRange = (priceRange) => {
        setCheckedPriceRange(priceRange);

        const priceRangeMap = {
            'duoi-10-trieu': 'duoi-10-trieu',
            'tu-10-den-20-trieu': 'tu-10-den-20-trieu',
            'tu-20-den-30-trieu': 'tu-20-den-30-trieu',
            'tu-30-den-40-trieu': 'tu-30-den-40-trieu',
            'tren-40-trieu': 'tren-40-trieu',
            'tat-ca': null
        };

        const newPriceRangeParam = priceRangeMap[priceRange] || 'tat-ca';

        let newQuery = query.replace(/([?&])range=[^&]*/, '') + (query.includes('?') ? '&' : '&') + 'range=' + newPriceRangeParam

        if (priceRange === 'tat-ca') {
            newQuery = newQuery.replace(/([?&])range=[^&]+&?/, '$1').replace(/&$/, '');
        }

        navigate(`/laptop/${newQuery.replace(/page=[^&]+(&|$)/i, 'page=1$1')}`);
    };

    const handleChangeSort = (sort) => {
        const sortMap = {
            'asc': 'gia-thap-den-cao',
            'desc': 'gia-cao-den-thap'
        };

        const newSort = sortMap[sort] || null;

        let newQuery = query.replace(/([?&])sort=[^&]*/, '') + (query.includes('page') ? '&' : '?') + 'sort=' + newSort;

        if (!newSort) {
            newQuery = newQuery.replace(/([?&])sort=[^&]+&?/, '$1').replace(/&$/, '');
        }

        navigate(`/laptop/${newQuery.replace(/page=[^&]+(&|$)/i, 'page=1$1')}`);
    };

    useEffect(() => {
        getProductsByQuery();
    }, [currentPage]);

    const handlePageChange = (page) => {
        setCurrentPage(page);

        navigate(location.pathname.replace(/(?<=page=)\d+/, `${page}`))
    };

    return (
        <div className="allproduct-wrap-content m-auto ">
            <div className={`${isScreenSmaller430 ? 'mx-4' : 'mx-[30px]'}`}>
                <Breadcrumb
                    className="bc-allproduct"
                    items={[
                        {
                            href: '/',
                            title: (
                                <span className="flex items-center">
                                    <HomeOutlined /> Trang chủ
                                </span>
                            ),
                        },
                        {
                            title: (
                                <span className="flex items-center">
                                    <LaptopOutlined className="mr-2" /> Laptop
                                </span>
                            ),
                        },
                    ]}
                />

                <Row gutter={[16, 16]}>
                    {/* Col for checkboxes */}
                    <Col xs={24} sm={24} md={24} lg={6}>
                        <CheckBoxGroup
                            tittle={'Hãng sản xuất'}
                            nameDisplay={nameBrands}
                            checkedList={checkedListBrands}
                            handleCheckboxChange={handleCheckboxChangeBrands}
                            handleSelectAllChange={handleSelectAllChangeBrands}
                            type={brands}
                            param={query}
                            isCheckedAll={isCheckedAllBrands}
                        />

                        <CheckBoxGroup

                            tittle={'Thể loại'}
                            nameDisplay={nameCategories}
                            checkedList={checkedListCategories}
                            handleCheckboxChange={handleCheckboxChangeCategories}
                            handleSelectAllChange={handleSelectAllChangeCategories}
                            type={categories}
                            isCheckedAll={isCheckedAllCategories}
                        />
                        
                        <h3 className='font-bold my-4'>Mức giá</h3>
                        <Row>
                            {priceRange.map((item) => {
                                return (
                                    <Col span={24} className='my-1'>
                                        <Checkbox
                                            key={item.label}
                                            onChange={(e) => handleCheckboxChangePriceRange(e.target.value)}
                                            checked={item.value === checkedPriceRange}
                                            value={item.value}
                                        >
                                            {item.lable}
                                        </Checkbox>
                                    </Col>
                                )
                            })}
                        </Row>
                    </Col>

                    {/* Col for product list */}
                    <Col xs={24} sm={24} md={24} lg={18}>
                        <div className={`product-list-section bg-white  pt-0 ${isScreenSmaller430 ? 'p-0' : 'p-4'}`}>
                            {/* Product list goes here */}
                            <div className='flex'>
                                <span className='my-4 px-3 py-1 ml-0 pl-0 max-[430px]:pl-2 '>Ưu tiên xem:</span>
                                <span
                                    className={
                                        sortStatus === null
                                            ? ('my-4 mx-0 px-3 py-1 border-[1px] border-[#bababa] bg-[#cb1c22] text-white rounded-l-md cursor-pointer')
                                            : ('my-4 mx-0 px-3 py-1 border-[1px] border-[#bababa] text-black rounded-l-md cursor-pointer')
                                    }
                                    onClick={() => { handleChangeSort() }}
                                >
                                    Sản phẩm mới
                                </span>
                                <span
                                    className={
                                        sortStatus === 'desc'
                                            ? ('my-4 mx-0 px-3 py-1 border-[1px] border-[#bababa] bg-[#cb1c22] text-white border-l-0 cursor-pointer')
                                            : ('my-4 mx-0 px-3 py-1 border-[1px] border-[#bababa] border-l-0 cursor-pointer')
                                    }
                                    onClick={() => { handleChangeSort('desc') }}
                                >
                                    Giá cao
                                </span>
                                <span
                                    className=
                                    {
                                        sortStatus === 'asc'
                                            ? 'my-4 mx-0 px-3 py-1 border-[1px] border-[#bababa] bg-[#cb1c22] text-white border-l-0 rounded-r-md cursor-pointer'
                                            : 'my-4 mx-0 px-3 py-1 border-[1px] border-[#bababa] border-l-0 rounded-r-md cursor-pointer'
                                    }
                                    onClick={() => { handleChangeSort('asc') }}
                                >
                                    Giá thấp
                                </span>
                            </div>
                            <List
                                grid={isHiddenAutoCpl ? { gutter: 16, column: 3 } : { gutter: 0, column: 2 }}
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
                                    total={pagination.totalProducts}
                                />
                            </div>

                        </div>
                    </Col>
                </Row>

            </div>
        </div>
    );
}

export default AllProduct;
