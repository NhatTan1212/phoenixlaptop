import React, { useState, useEffect, useContext } from 'react';
import { FontAwesomeIcon } from '@fortawesome/react-fontawesome'
import { faEye } from '@fortawesome/free-regular-svg-icons';
import { faTrash, faPenToSquare } from '@fortawesome/free-solid-svg-icons';
import { HomeOutlined, LaptopOutlined, InboxOutlined, PlusOutlined, } from '@ant-design/icons';
import {
  Breadcrumb, Input, Button, Table, Modal, Row, Col
} from 'antd';
import AdminHome from '../adminHome';
import './productManagement.scss'
import { DeleteProduct, GetBrands, GetCategories, GetImages, GetProducts } from '../../../callAPI/api';
import ModalProductManager from '../../../component/management/product/ModalProductManager';
import Cookies from 'js-cookie';
import Context from '../../../store/Context';

const ProductManagement = () => {
  let token = Cookies.get('token')
  const context = useContext(Context)
  const isHiddenAutoCpl = context.isHiddenAutoCpl
  const isScreenSmaller1280 = context.isScreenSmaller1280
  const isScreenSmaller430 = context.isScreenSmaller430

  const [products, setProducts] = useState([]);
  const [images, setImages] = useState([]);
  const [brands, setBrands] = useState([]);
  const [categories, setCategories] = useState([]);
  const [isEditing, setIsEditing] = useState(false);
  const [isViewing, setIsViewing] = useState(false);
  const [isOpenedModalAddNew, setIsOpenedModalAddNew] = useState(false);
  const [editingProduct, setEditingProduct] = useState(null);
  const [brandsSelect, setBrandsSelect] = useState([])
  const [brandDefault, setBrandDefault] = useState('')
  const [categorySelect, setCategorySelect] = useState([])
  const [categoryDefault, setCategoryDefault] = useState('')
  const [fileList, setFileList] = useState([]);
  const [searchText, setSearchText] = useState('');
  const [filteredProducts, setFilteredProducts] = useState(products);
  const [showDeleteConfirmation, setShowDeleteConfirmation] = useState(false);
  const [productIdToDelete, setProductIdToDelete] = useState(null);
  const [isListProductsChanged, setIsListProductsChanged] = useState(false);
  const columns = [
    {
      title: 'ID',
      dataIndex: 'id',
      width: '10%',
      sortDirections: ["descend", "ascend"],
      responsive: ["xl"],
      sorter: (record1, record2) => { return record1.id - record2.id }
    },
    {
      title: 'Tên thương hiệu',
      dataIndex: 'brand_id',
      sortDirections: ["descend", "ascend"],
      responsive: ["xxl"],
      render: (dataIndex) => {
        const brand = brands.find(brand => brand.brand_id === dataIndex);
        return (brand && <img src={brand.image} className='max-h-[30px]'
          alt="Brand Logo" />)
      },
      filters: brands.map((brand) => {
        return {
          text: brand.name,
          value: brand.brand_id
        }
      }),
      onFilter: (value, record) => {
        return record.brand_id === value;
      }
      // defaultFiltered
    },
    {
      title: 'Danh mục',
      dataIndex: 'category_id',
      sortDirections: ["descend", "ascend"],
      responsive: ["xxl"],
      render: (dataIndex) => {
        const category = categories.find(category => category.category_id === dataIndex);
        // console.log(category)
        return (category && <span >{category.name}</span>)
      },
      filters: categories.map((category) => {
        return {
          text: category.name,
          value: category.category_id
        }
      }),
      onFilter: (value, record) => {
        return record.category_id === value;
      }
    },

    {
      title: 'Hình sản phẩm',
      dataIndex: 'avatar',
      render: (dataIndex) => {
        return <img src={dataIndex} className='max-h-[110px] min-w-[100px]'></img>
      }
    },
    {
      title: 'Tên sản phẩm',
      dataIndex: 'prod_name',
      render: (_, record) => {
        return <div className='max-[1510px]:max-w-[200px] max-[1190px]:max-w-[150px] max-h-[3em] overflow-hidden'>{record.prod_name}</div>
      }
    },
    {
      title: 'Giá bán',
      dataIndex: 'price',
      sorter: (record1, record2) => { return record1.price - record2.price },
      render: (_, record) => (
        <span>{record.price.toLocaleString('vi-VN', { style: 'currency', currency: 'VND' })}</span>
      ),
    },
    {
      title: 'Giá chính hãng',
      dataIndex: 'cost',
      sorter: (record1, record2) => { return record1.cost - record2.cost },
      render: (_, record) => (
        <span>{record.cost.toLocaleString('vi-VN', { style: 'currency', currency: 'VND' })}</span>
      ),
    },
    {
      title: 'Số lượng',
      dataIndex: 'quantity',
      sorter: (record1, record2) => { return record1.quantity - record2.quantity }
    },
    {
      title: 'Hành động',
      dataIndex: 'action',
      width: '135px',
      render: (text, record) => {
        return (<div className='flex flex-col h-auto'>
          <button className=' bg-[#c8191f] text-white text-center
                    hover:text-white hover:shadow-[0_0_6px_0_#333] rounded-[30px] 
                    p-1 px-2'
            onClick={(e) => {
              // console.log(record)
              viewDetailsProduct(record)
            }}>
            {!isScreenSmaller1280 ? 'Xem chi tiết' : <FontAwesomeIcon className='min-w-[60px]' icon={faEye} />}
          </button>
          <button className=' bg-[#c8191f] text-white text-center
                    hover:text-white hover:shadow-[0_0_6px_0_#333] rounded-[30px] 
                    p-1 px-2 mt-2'
            onClick={(e) => {
              // console.log(record)
              updateProduct(record)
            }}>
            {!isScreenSmaller1280 ? 'Chỉnh sửa' : <FontAwesomeIcon icon={faPenToSquare} />}
          </button>
          <button className=' bg-[#c8191f] text-white text-center
                    hover:text-white hover:shadow-[0_0_6px_0_#333] rounded-[30px] 
                    p-1 px-2 mt-2'
            onClick={(e) => {
              // console.log(record);
              setProductIdToDelete(record.id)
              setShowDeleteConfirmation(true)
            }}>
            {!isScreenSmaller1280 ? 'Xóa' : <FontAwesomeIcon icon={faTrash} />}
          </button>
        </div>)
      }
    },
  ];
  const deviceColumns = [
    {
      title: 'Thông tin sản phẩm',
      render: (record, key, index) => {
        return (
          <div>
            <div className='pb-2'>Mã sản phẩm: {record.id}</div>
            <Row className='overflow-hidden text-ellipsis max-[470px]:max-w-[300px]'>
              <Col md={{ span: 6, offset: 0 }} sm={{ span: 6, offset: 0 }} xs={{ span: 6, offset: 0 }}
                className='max-[490px]:max-w-full'>

                <div
                  className='w-[108px]'
                >
                  < img
                    src={record.avatar}
                    className='w-full h-auto border-[1px] border-[#e1dada]'
                  ></img >

                </div>
              </Col>
              <Col md={{ span: 17, offset: 1 }} sm={{ span: 16, offset: 2 }} xs={{ span: 15, offset: 3 }}
                className='max-[490px]:max-w-full max-[490px]:ml-0'
              >
                <p className='font-bold text-[17px] text-[#333] max-h-[3em] overflow-hidden max-[576px]:max-w-[200px]'>{record.prod_name}</p>
                <p>Giá bán {record.price}</p>
                <p>Giá gốc: {record.cost}</p>
                <p>Còn trong kho: {record.quantity}</p>
              </Col>

            </Row>
          </div>
        )
      }
    },
    {
      title: 'Action',
      dataIndex: 'action',
      width: `${isHiddenAutoCpl ? '150px' : '20%'}`,
      render: (text, record) => {
        return (<div className='flex flex-col h-auto'>
          <button className=' bg-[#c8191f] text-white text-center
                    hover:text-white hover:shadow-[0_0_6px_0_#333] rounded-[30px] 
                    p-1 px-2  max-[490px]:w-[60px] '
            onClick={(e) => {
              // console.log(record)
              viewDetailsProduct(record)
            }}>
            {isHiddenAutoCpl ? 'Xem chi tiết' : <FontAwesomeIcon icon={faEye} />}
          </button>
          <button className=' bg-[#c8191f] text-white text-center
                    hover:text-white hover:shadow-[0_0_6px_0_#333] rounded-[30px] 
                    p-1 px-2 mt-2'
            onClick={(e) => {
              // console.log(record)
              updateProduct(record)
            }}>
            {isHiddenAutoCpl ? 'Chỉnh sửa' : <FontAwesomeIcon icon={faPenToSquare} />}
          </button>
          <button className=' bg-[#c8191f] text-white text-center
                    hover:text-white hover:shadow-[0_0_6px_0_#333] rounded-[30px] 
                    p-1 px-2 mt-2'
            onClick={(e) => {
              // console.log(record);
              setProductIdToDelete(record.id)
              setShowDeleteConfirmation(true)
            }}>
            {isHiddenAutoCpl ? 'Xóa' : <FontAwesomeIcon icon={faTrash} />}
          </button>
        </div>)
      }
    },
  ];

  useEffect(() => {
    // Hàm này chạy khi component được mount
    getProducts();
    getImages();
    getBrands();
    getCategories();

  }, [isEditing, searchText, isListProductsChanged]);

  useEffect(() => {
    filterProducts();
  }, [searchText, products]);

  const getProducts = () => {
    GetProducts().then((data) => {
      setProducts(data)
    })
  };
  const getBrands = () => {
    GetBrands().then(response => {
      // console.log(response.data.map((brand) => {
      //     return brand.name
      // }, []));
      setBrands(response);

      setBrandsSelect(response.map((brand) => {
        return brand.name
      }, []))
    })
  }

  const getCategories = () => {
    GetCategories().then(response => {
      setCategories(response);
      setCategorySelect(response.map((category) => {
        return category.name
      }, []))
    })
  }

  const getImages = () => {
    GetImages().then(response => {
      setImages(response);
    })
  }

  const updateProduct = (product) => {
    setIsEditing(true)
    setEditingProduct(product)
    const getBrand = brands.find((brand) => {
      return brand.brand_id === product.brand_id

    });
    setBrandDefault(getBrand.name)

    const getImages = images.filter((img) => {
      // console.log(img.product_id)
      return img.product_id === product.id

    });
    // console.log(product.id)
    // console.log(getImages)
    setFileList(getImages)

    const getCategory = categories.find((category) => {
      return category.category_id === product.category_id

    });
    setCategoryDefault(getCategory.name)
    // console.log(brandDefault);
    // setFormKey(formKey + 1);
  }

  const viewDetailsProduct = (product) => {
    setIsViewing(true)
    setEditingProduct(product)
    const getBrand = brands.find((brand) => {
      return brand.brand_id === product.brand_id

    });
    setBrandDefault(getBrand.name)

    const getImages = images.filter((img) => {
      // console.log(img.product_id)
      return img.product_id === product.id

    });
    // console.log(product.id)
    // console.log(getImages)
    setFileList(getImages)

    const getCategory = categories.find((category) => {
      return category.category_id === product.category_id

    });
    setCategoryDefault(getCategory.name)
  }
  const addNewProduct = () => {
    setIsOpenedModalAddNew(true)
  }

  const handleDeleteProduct = (productId) => {

    const requestData = {
      token: token,
      product_id: productId,
    };

    DeleteProduct(requestData).then(response => {
      if (response.success) {
        setIsListProductsChanged(!isListProductsChanged)
        context.Message("success", "Xóa sản phẩm thành công.")

      }
    })
  }

  const handleChangeInputSearch = (e) => {
    setSearchText(e.target.value)

  }

  const filterProducts = () => {
    const filteredProducts = products.filter((product) => {
      const productName = product.prod_name.toLowerCase();
      const productId = product.id + '';
      return productName.includes(searchText.toLowerCase()) || productId === searchText;
    });
    setFilteredProducts(filteredProducts);
  }


  return (
    <div className='flex-1'>
      {/* <AdminHome></AdminHome> */}
      <Modal
        title="Xác nhận xóa sản phẩm"
        open={showDeleteConfirmation}
        onOk={() => {
          handleDeleteProduct(productIdToDelete); // Gọi hàm xóa sau khi xác nhận
          setShowDeleteConfirmation(false); // Đóng modal
        }}
        onCancel={() => setShowDeleteConfirmation(false)} // Đóng modal khi bấm hủy
        className='model-cart'
      >
        <p>Bạn có chắc chắn muốn xóa sản phẩm khỏi cửa hàng?</p>
      </Modal>
      <div className='bg-[#f0f0f0] p-3'>
        <Breadcrumb
          items={[
            {
              href: '',
              title: <span className='flex items-center'>
                <HomeOutlined />
              </span>,
            },
            {
              title: <span className='flex items-center'>
                <LaptopOutlined className='mr-2' /> Product Management
              </span>,
            },
          ]}
        />
        <div className={`flex justify-between bg-white items-center  ${isHiddenAutoCpl ? 'p-4' : 'flex-col-reverse p-0'}`}>

          <Input.Search
            allowClear
            className={`searchPM ${isHiddenAutoCpl ? '' : 'w-full pt-2'}`}
            placeholder='Nhập tên sản phẩm, từ khóa cần tìm kiếm,...'
            onChange={(e) => { handleChangeInputSearch(e) }}
            onSearch={(e) => { console.log('hi') }}
            onPressEnter={(e) => { console.log('hi') }}
            style={{ width: '45%' }}></Input.Search>
          <Button
            className={`btn-add-prd bg-[#c8191f] text-white ${isHiddenAutoCpl ? '' : 'w-full'}
                         h-auto`}
            onClick={() => { addNewProduct() }}
          >
            <span className='font-bold text-[18px] mr-2'>
              +
            </span>
            <span>
              Thêm sản phẩm
            </span>
          </Button>
        </div>
        <div className='flex flex-col bg-white p-4
                mt-[20px]'>
          <h3>Quản lý sản phẩm</h3>
          <Table
            className='table-product-management'
            columns={isHiddenAutoCpl ? columns : deviceColumns}
            dataSource={filteredProducts.map((product) => ({
              ...product,
              key: product.id,
            }))}>
          </Table>
        </div>
      </div>
      {isEditing &&
        <ModalProductManager
          title={'Chỉnh sửa sản phẩm - ' + editingProduct.prod_name}
          isActioning={isEditing}
          width={1200}
          setIsActioning={setIsEditing}
          setActioningProduct={setEditingProduct}
          searchText={searchText}
          actioningProduct={editingProduct}
          fileList={fileList}
          setFileList={setFileList}
          brands={brands}
          categories={categories}
          brandDefault={brandDefault}
          categoryDefault={categoryDefault}
          brandsSelect={brandsSelect}
          categorySelect={categorySelect}
        ></ModalProductManager>
      }
      {isViewing &&
        <ModalProductManager
          title={'Xem chi tiết sản phẩm - ' + editingProduct.prod_name}
          isActioning={isViewing}
          width={800}
          setIsActioning={setIsViewing}
          setActioningProduct={setEditingProduct}
          actioningProduct={editingProduct}
          fileList={fileList}
          setFileList={setFileList}
          brandDefault={brandDefault}
          categoryDefault={categoryDefault}
        ></ModalProductManager>
      }
      {isOpenedModalAddNew &&
        <ModalProductManager
          title={'Thêm sản phẩm mới'}
          isActioning={isOpenedModalAddNew}
          width={1200}
          setIsActioning={setIsOpenedModalAddNew}
          brands={brands}
          categories={categories}
          brandsSelect={brandsSelect}
          categorySelect={categorySelect}
          fileList={fileList}
          setFileList={setFileList}
          setIsListProductsChanged={setIsListProductsChanged}
        ></ModalProductManager>
      }

    </div >

  );
};
export default ProductManagement;